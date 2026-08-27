local UINNavigationBranchBtn = class("UINNavigationBranchBtn", UIBaseNode)
local base = UIBaseNode
UINNavigationBranchBtn.eLockType = {perCoditonLock = 0, forceLock = 1}
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UINNavigationBranchBtn:OnInit()
  self.isRedDotInited = false
  self.__navSpecs = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_subNavBranchItem, self, self.OnClickNavigationBranchBtn)
end

function UINNavigationBranchBtn:InitNavigationBranchBtn(navigation_subCfg, resloader, index)
  self.resloader = resloader
  self.navigation_subCfg = navigation_subCfg
  self.ui.txt_Title.text = LanguageUtil.GetLocaleText(navigation_subCfg.name)
  self.transform.gameObject.name = tostring(index)
  self:RefreshNBBIsUnlock()
  self.ui.img_Icon.enabled = false
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_NavigationBar"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, navigation_subCfg.img)
    self.ui.img_Icon.enabled = true
  end)
  if self.navigation_subCfg.red_dot_show == 1 then
    self.ui.img_redDot.color = self.ui.reddot_blue
  end
end

function UINNavigationBranchBtn:OnClickNavigationBranchBtn()
  if not self.isUnlock then
    if self.lockType == UINNavigationBranchBtn.eLockType.perCoditonLock then
      cs_MessageCommon.ShowMessageTips(self.lockInfo)
    elseif self.lockType == UINNavigationBranchBtn.eLockType.forceLock then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.NavigationBtnForceLocked))
    end
    return
  end
  JumpManager:Jump(self.navigation_subCfg.jump_target, function(jumpCallback)
    if UIUtil.CheckIsHaveSpecialMarker(self.navigation_subCfg.marker) then
      UIUtil.ReturnUntil2Marker(self.navigation_subCfg.marker)
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      local win = UIManager:GetWindow(UIWindowTypeID.ClickContinue)
      if win ~= nil then
        win:Hide()
      end
      return
    end
    if jumpCallback ~= nil then
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      jumpCallback()
    end
  end, nil, self.navigation_subCfg.jump_arg, self.navigation_subCfg.jump_is_cover)
end

function UINNavigationBranchBtn:RefreshNBBIsUnlock()
  local isUnlock
  if self.navigation_subCfg.force_lock then
    isUnlock = false
    self.lockType = UINNavigationBranchBtn.eLockType.forceLock
  elseif self.navigation_subCfg.id == 13 then
    isUnlock = JumpManager:Jump2DynActivityValidate()
    self.lockType = UINNavigationBranchBtn.eLockType.forceLock
  else
    isUnlock = CheckCondition.CheckLua(self.navigation_subCfg.pre_condition, self.navigation_subCfg.pre_para1, self.navigation_subCfg.pre_para2)
    self.lockType = UINNavigationBranchBtn.eLockType.perCoditonLock
    self.lockInfo = CheckCondition.GetUnlockInfoLua(self.navigation_subCfg.pre_condition, self.navigation_subCfg.pre_para1, self.navigation_subCfg.pre_para2)
  end
  self.isUnlock = isUnlock
  self.ui.obj_isLock:SetActive(not isUnlock)
  if isUnlock then
    if not self.isRedDotInited then
      self:InitNBBRedDot()
    end
  else
    self.ui.obj_redDot:SetActive(false)
  end
end

function UINNavigationBranchBtn:GetNBBIsUnlock()
  return self.isUnlock
end

function UINNavigationBranchBtn:RefreshIsInThisUI(bool)
  if bool then
    self.ui.img_Icon_outline.color = self.ui.color_yellow
  else
    self.ui.img_Icon_outline.color = Color.white
  end
end

function UINNavigationBranchBtn:InitNBBRedDot()
  self.isRedDotInited = true
  local redDotPathList = string.split(self.navigation_subCfg.red_dot_path, ".")
  if redDotPathList == nil or #redDotPathList == 0 then
    self.ui.obj_redDot:SetActive(false)
    return
  end
  local ok, node = RedDotController:GetRedDotNode(table.unpack(redDotPathList))
  if ok then
    self.ui.obj_redDot:SetActive(ok and 0 < node:GetRedDotCount())
    
    function self.redDotFunc(node)
      self.ui.obj_redDot:SetActive(node:GetRedDotCount() > 0)
    end
    
    self.redDot = node
    RedDotController:AddListener(node.nodePath, self.redDotFunc)
  else
    self.ui.obj_redDot:SetActive(false)
  end
end

function UINNavigationBranchBtn:GetAllSpecialIds()
  return self.navigation_subCfg.special
end

function UINNavigationBranchBtn:AddNavSpecialNode(typeId, specitem)
  self.__navSpecs[typeId] = specitem
end

function UINNavigationBranchBtn:OnDelete()
  if self.redDot ~= nil then
    RedDotController:RemoveListener(self.redDot.nodePath, self.redDotFunc)
  end
  for typeId, specitem in pairs(self.__navSpecs) do
    specitem:Delete()
  end
  self.__navSpecs = nil
  base.OnDelete(self)
end

return UINNavigationBranchBtn
