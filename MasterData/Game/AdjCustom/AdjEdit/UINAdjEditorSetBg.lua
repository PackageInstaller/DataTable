local UINAdjEditorSetBg = class("UINAdjEditorSetBg", UIBaseNode)
local base = UIBaseNode
local UINAdjEditorSetBgItem = require("Game.AdjCustom.AdjEdit.UINAdjEditorSetBgItem")
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon

function UINAdjEditorSetBg:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  self.ui.bgList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.bgList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.bgList.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__OnSelectBgCallback = BindCallback(self, self.__OnSelectBg)
  self._bgGoItemDic = {}
  self._bgIdItemDic = nil
  self._resloader = CS_ResLoader.Create()
  self._defaultConfirmColor = self.ui.img_confirm.color
  self.__OnListenItemUpdateCallback = BindCallback(self, self.__OnListenItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnListenItemUpdateCallback)
end

function UINAdjEditorSetBg:InitUINAdjEditorSetBg(editMain)
  self._editMain = editMain
end

function UINAdjEditorSetBg:UpdateUINAdjEditorSetBg()
  self._bgIdItemDic = {}
  self._bgList = {}
  for k, bgCfg in pairs(ConfigData.background) do
    if not bgCfg.background_locked then
      table.insert(self._bgList, bgCfg)
    end
  end
  table.sort(self._bgList, function(a, b)
    if a.order ~= b.order then
      return a.order < b.order
    end
    return a.id < b.id
  end)
  self.ui.bgList.totalCount = #self._bgList
  self.ui.bgList:RefillCells()
  self:__RefreshConfirmState()
end

function UINAdjEditorSetBg:__OnInstantiateItem(go)
  local bgItem = UINAdjEditorSetBgItem.New()
  bgItem:Init(go)
  self._bgGoItemDic[go] = bgItem
end

function UINAdjEditorSetBg:__OnChangeItem(go, index)
  local bgItem = self._bgGoItemDic[go]
  local oriBgId = bgItem:GetAdjBgItemId()
  if oriBgId ~= nil and self._bgIdItemDic[oriBgId] == bgItem then
    self._bgIdItemDic[oriBgId] = nil
  end
  local bgCfg = self._bgList[index + 1]
  bgItem:InitAdjBgItem(bgCfg, self._resloader, self.__OnSelectBgCallback)
  bgItem:SetAdjBgSelectState(bgCfg.id == self._editMain:GetAdjEditBgId())
  self._bgIdItemDic[bgCfg.id] = bgItem
end

function UINAdjEditorSetBg:__OnReturnItem(go)
  local bgItem = self._bgGoItemDic[go]
  local bgId = bgItem:GetAdjBgItemId()
  if bgId ~= nil then
    self._bgIdItemDic[bgId] = nil
  end
end

function UINAdjEditorSetBg:__OnSelectBg(bgId)
  local oriBgId = self._editMain:GetAdjEditBgId()
  if bgId == oriBgId then
    return
  end
  local oriBgItem = self._bgIdItemDic[self._editMain:GetAdjEditBgId()]
  if oriBgItem ~= nil then
    oriBgItem:SetAdjBgSelectState(false)
  end
  local bgItem = self._bgIdItemDic[bgId]
  if bgItem ~= nil then
    bgItem:SetAdjBgSelectState(true)
  end
  self._editMain:SetAdjEditBg(bgId)
  self:__RefreshConfirmState()
end

function UINAdjEditorSetBg:__RefreshConfirmState()
  local selectBgId = self._editMain:GetAdjEditBgId()
  if PlayerDataCenter:GetItemCount(self._editMain:GetAdjEditBgId()) > 0 then
    self.ui.img_confirm.color = self._defaultConfirmColor
  else
    self.ui.img_confirm.color = Color.gray
  end
end

function UINAdjEditorSetBg:OnClickConfirm()
  if PlayerDataCenter:GetItemCount(self._editMain:GetAdjEditBgId()) == 0 then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(407))
    return
  end
  self._editMain:AdjEditJumpSubNode(self._editMain.subType.Operation)
end

function UINAdjEditorSetBg:__OnListenItemUpdate()
  if self._bgIdItemDic == nil then
    return
  end
  for k, item in pairs(self._bgIdItemDic) do
    item:RefreshAdjBgLockState()
  end
  self:__RefreshConfirmState()
end

function UINAdjEditorSetBg:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnListenItemUpdateCallback)
  base.OnDelete(self)
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
end

return UINAdjEditorSetBg
