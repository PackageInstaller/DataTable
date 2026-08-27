local UIAthItemDetail = class("UIAthItemDetail", UIBaseWindow)
local base = UIBaseWindow
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")

function UIAthItemDetail:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  self.ui.aTHDetailItem:SetActive(false)
  self.detailItemPool = UIItemPool.New(UINAthDetailItem, self.ui.aTHDetailItem)
  self.__onAthDataUpdate = BindCallback(self, self.__OnAthDataUpdate)
end

function UIAthItemDetail:InitAthItemDetail(heroData, athData, replaceAthData, inAthTable)
  AudioManager:PlayAudioById(1072)
  self.athData = athData
  self.replaceAthData = replaceAthData
  self.ui.btn_Close.gameObject:SetActive(true)
  local isAdd = true
  if athData.bindInfo ~= nil and athData.bindInfo.id == heroData.dataId then
    isAdd = false
  end
  self.detailItemPool:HideAll()
  if replaceAthData == nil then
    local detailItem = self.detailItemPool:GetOne()
    if isAdd then
      detailItem:InitAthDetailItem(self, athData, heroData, true, false)
    else
      detailItem:InitAthDetailItem(self, athData, heroData, false, false)
    end
    if inAthTable then
      detailItem.transform:SetParent(self.ui.tableDetailPos)
    else
      detailItem.transform:SetParent(self.ui.listDetailPos)
    end
    detailItem.transform.anchoredPosition = Vector2.zero
  else
    local addItem = self.detailItemPool:GetOne()
    addItem:InitAthDetailItem(self, athData, heroData, true, true)
    addItem.transform:SetParent(self.ui.listDetailPos)
    addItem.transform.anchoredPosition = Vector2.zero
    local removeItem = self.detailItemPool:GetOne()
    removeItem:InitAthDetailItem(self, replaceAthData, heroData, false, true)
    removeItem.transform:SetParent(self.ui.replaceDetailPos)
    removeItem.transform.anchoredPosition = Vector2.zero
  end
end

function UIAthItemDetail:SetAthItemDetailFunc(installFunc, uninstallFunc, replaceFunc)
  self.installFunc = installFunc
  self.uninstallFunc = uninstallFunc
  self.replaceFunc = replaceFunc
end

function UIAthItemDetail:ChangeAthItemParent(athItem, getAthItemFunc)
  athItem:SetAthItemRootParent(self.transform)
  self.__getAthItemFunc = getAthItemFunc
  self.__changeParentItem = athItem
  self.__changeParentAthData = athItem:GetAthItemData()
end

function UIAthItemDetail:OnClickInstallAth()
  if self.installFunc ~= nil then
    self.installFunc(self.athData)
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UIAthItemDetail:OnClickUninstallAth()
  if self.uninstallFunc ~= nil then
    self.uninstallFunc(self.athData)
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UIAthItemDetail:OnClickReplaceAth()
  if self.replaceFunc ~= nil then
    self.replaceFunc(self.replaceAthData, self.athData)
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UIAthItemDetail:__OnAthDataUpdate(updateAthDic, heroSlot, deleteAth)
  if self.athData ~= nil and deleteAth[self.athData.uid] ~= nil or self.replaceAthData ~= nil and deleteAth[self.replaceAthData.uid] ~= nil then
    self:__OnClickClose()
    return
  end
  for k, item in ipairs(self.detailItemPool.listItem) do
    if item.athData ~= nil and updateAthDic[item.athData.uid] ~= nil then
      item:RefreshAthDetailItemAttr()
      item:UpdAthDetailItemState()
    end
  end
  if self.__changeParentItem ~= nil and self.__getAthItemFunc ~= nil then
    self.__changeParentItem:SetAthItemRootParent(nil, true)
    self.__changeParentItem = nil
    local athItem = self.__getAthItemFunc(self.__changeParentAthData.uid)
    if athItem ~= nil then
      athItem:SetAthItemRootParent(self.transform)
      self.__changeParentItem = athItem
    end
  end
end

function UIAthItemDetail:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIAthItemDetail:BackAction()
  self:Hide()
end

function UIAthItemDetail:OnShow()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  base.OnShow(self)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate1, self.__onAthDataUpdate)
end

function UIAthItemDetail:OnHide()
  if self.__changeParentItem ~= nil and not IsNull(self.__changeParentItem.gameObject) then
    self.__changeParentItem:SetAthItemRootParent(nil, true)
    self.__changeParentItem = nil
    self.__changeParentAthData = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate1, self.__onAthDataUpdate)
  base.OnHide(self)
end

function UIAthItemDetail:OnDelete()
  self.detailItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIAthItemDetail
