local UITopStatus = class("UITopStatus", UIBaseWindow)
local base = UIBaseWindow
local UINTopBtnGroup = require("Game.TopStatus.UINTopBtnGroup")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local JumpManager = require("Game.Jump.JumpManager")
local cs_InputUtility = CS.InputUtility

function UITopStatus:OnInit()
  self.__permanent = true
  self.__NavigationWin = nil
  self.topGroup = UINTopBtnGroup.New()
  self.topGroup:Init(self.ui.topButtonGroup)
  self.resGroup = UINResourceGroup.New()
  self.resGroup:Init(self.ui.gameResourceGroup)
  self.__OnClickNavigationBarBtn = BindCallback(self, self.OnClickNavigationBarBtn)
  self.__HideNavigation = BindCallback(self, self.HideNavigation)
  self.topGroup:SetBtnHomeClickAction(function()
    self:OnClickHomeBtn()
  end)
end

function UITopStatus:ChangeResourceItemClass(newClass)
  self.resGroup:ChangeResourceItemClass(newClass)
end

function UITopStatus:RefreshTopStatusUI(topData)
  self:SetTopStatusResIds(topData.resIds)
  self:SetTopStatusResAddFuncs(topData.resIds, topData.resAddCallbackDic)
  if topData.infoAction ~= nil then
    self.topGroup:SetInfoClickAction(topData.infoAction)
    self.topGroup:SetInfoBtnBluedot(topData.infoActionBuledot)
  end
  self:SetTopButtonGroup(not topData.hideTopButton)
  self.topGroup:SetBeforeBackCloseNavigation(self.__HideNavigation)
  self.topGroup:SetBtnOpenNavigationClickAction(self.__OnClickNavigationBarBtn)
  self.topGroup:RefreshTopGroupUI(topData)
  self:__RefreshNewbeeTopstatus()
end

function UITopStatus:__RefreshNewbeeTopstatus()
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if not completeIntro then
    self.topGroup:ShowTopBtnGroupGoHomeBtn(false)
    self.topGroup:RefreshouldShowNaviBtn(false)
    self:SetResourceGroupActive(false)
  end
end

function UITopStatus:OnClickHomeBtn()
  if self.__NavigationWin ~= nil and self.__NavigationWin.active then
    self.__NavigationWin:CloseNavigationBar()
    UIUtil.ReturnHome()
  else
    UIUtil.ReturnHome()
  end
end

function UITopStatus:OnClickNavigationBarBtn()
  if self.__NavigationWin ~= nil then
    if self.__NavigationWin.active then
      self.__NavigationWin:CloseNavigationBar()
    else
      self.__NavigationWin:Show()
      self.__NavigationWin:RefreshAllBranchItem()
    end
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.NavigationBar, function(win)
      if win == nil then
        return
      end
      win.transform:SetParent(self.ui.go_NavigationParent.transform, false)
      self.__NavigationWin = win
      self.__NavigationWin:RefreshAllBranchItem()
    end)
  end
end

function UITopStatus:HideNavigation()
  if self.__NavigationWin ~= nil and self.__NavigationWin.active then
    self.__NavigationWin:CloseNavigationBar()
    return true
  end
end

function UITopStatus:SetTopButtonGroup(active)
  self.topGroup.gameObject:SetActive(active)
end

function UITopStatus:SetTopStatusResIds(Ids)
  if Ids ~= nil then
    self.resGroup:SetResourceIds(Ids)
    self:SetResourceGroupActive(true)
  else
    self:SetResourceGroupActive(false)
  end
end

function UITopStatus:SetTopStatusResAddFuncs(Ids, addCallbackDic)
  if Ids == nil then
    return
  end
  for _, itemId in ipairs(Ids) do
    local addCallback
    if addCallbackDic ~= nil then
      addCallback = addCallbackDic[itemId]
    end
    if addCallback == nil then
      addCallback = UIUtil.GetItemResAddFunc(itemId)
    end
    if addCallback ~= nil then
      self.resGroup:SetResourceAddBtnFunc(itemId, true, addCallback)
    else
      self.resGroup:SetResourceAddBtnFunc(itemId, false, addCallback)
    end
  end
end

function UITopStatus:GetTopStatusResItem(Id)
  return self.resGroup:GetResourceItem(Id)
end

function UITopStatus:SetResourceGroupActive(active)
  self.resGroup.gameObject:SetActive(active)
end

function UITopStatus:GetResItemPos(id)
  return self.resGroup:GetResItemPos(id)
end

function UITopStatus:TryClickTopBack()
  local rectTran = self.topGroup:GetTopBtnBackRectTran()
  if rectTran.gameObject.activeInHierarchy and cs_InputUtility.UIClickable(rectTran) then
    UIUtil.ForceOnClickBack()
    return true
  end
  return false
end

function UITopStatus:OnShow()
  base.OnShow(self)
end

function UITopStatus:OnHide()
  if self.__NavigationWin ~= nil and self.__NavigationWin.active then
    self.__NavigationWin:CloseNavigationBar()
  end
  base.OnHide(self)
end

function UITopStatus:OnDelete()
  self.topGroup:Delete()
  self.resGroup:Delete()
  if self.__NavigationWin ~= nil then
    self.__NavigationWin:Delete()
  end
  base.OnDelete(self)
end

return UITopStatus
