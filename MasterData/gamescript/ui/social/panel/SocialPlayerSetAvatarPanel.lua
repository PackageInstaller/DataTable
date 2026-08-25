local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType
local ItemSubType2BtnTxtMap = {
  [ItemSubType.PlayerAvatar] = LT.Text("SocialSystemChangeAvatar"),
  [ItemSubType.AvatarFrame] = LT.Text("SocialChangeAvatarFrameBtnTxt")
}
local SocialPlayerSetAvatarPanel, Super = System.NewClass("SocialPlayerSetAvatarPanel", UIBasePanel)
SocialPlayerSetAvatarPanel.uiResCls = UI_Social_Popup_PlayerHeadResource

function SocialPlayerSetAvatarPanel:ctor(avatar, selectFrame, callback)
  Super.ctor(self)
  self.callback = callback
  self.showList = Vue.ref({})
  self.selectAvatarTid = Vue.ref(avatar)
  self.selectFrameTid = Vue.ref(selectFrame)
  self.selectItemSubType = Vue.ref(ItemSubType.PlayerAvatar)
  self.usingAvatar = avatar
  self.usingFrame = selectFrame
end

function SocialPlayerSetAvatarPanel:OnBind(binder)
  self.binder = binder
  self.binder:LoadAllLangFont(self.ui.Text_Introduction)
  self:_BindToggle(binder)
  self:_BindPopupComp(binder)
  self:_BindScrollView(binder)
  self:_BindRightPart(binder)
end

function SocialPlayerSetAvatarPanel:_BindToggle()
  self:_BindToggleComp(self.ui.Btn_Head, ItemSubType.PlayerAvatar, RedTypeDefine.SocialSubType.Avatar)
  self:_BindToggleComp(self.ui.Btn_HeadFrame, ItemSubType.AvatarFrame, RedTypeDefine.SocialSubType.AvatarFrame)
end

function SocialPlayerSetAvatarPanel:_BindToggleComp(obj, page, socialSubType)
  self.binder:BindZ1Button(obj, function()
    self.selectItemSubType.value = page
  end, nil, nil, function()
    do return SocialRedUtils.GetSocialRed end
    return SocialRedUtils.GetSocialRed, {socialSubType}, socialSubType
  end, function()
    return self.selectItemSubType.value == page
  end)
end

function SocialPlayerSetAvatarPanel:_BindPopupComp(binder)
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
end

function SocialPlayerSetAvatarPanel:_BindScrollView(binder)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GenItemList), System.fn(self, self._OnUpdateAvatarItem))
end

function SocialPlayerSetAvatarPanel:_BindRightPart(binder)
  binder:BindToRaw(function(childBinder)
    local headItemTid, frameItemTid = self.selectAvatarTid.value, self.selectFrameTid.value
    local itemData = {
      headIcon = ItemDataUtils.GetItemIcon(headItemTid),
      frameIcon = ItemDataUtils.GetItemIcon(frameItemTid)
    }
    childBinder:BindComponent(CommonHeadItem(self.ui.UI_Common_Head, itemData))
    local detailItemTid = self.selectItemSubType.value == ItemSubType.PlayerAvatar and headItemTid or frameItemTid
    childBinder:SetText(self.ui.Text_Name, self:_GetAvatarName(detailItemTid))
    childBinder:SetText(self.ui.Text_Introduction, self:_GetAvatarIntro(detailItemTid))
    local selectSameItem = self:_CheckIsSameItem()
    childBinder:SetActive(self.ui.UI_Common_Btn_Change, not selectSameItem)
    childBinder:SetActive(self.ui.Image_Using, selectSameItem)
  end, function()
    return {
      self.selectAvatarTid.value,
      self.selectFrameTid.value,
      self.selectItemSubType.value
    }
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Change, System.fn(self, self._OnClickConfirm), nil, function()
    return ItemSubType2BtnTxtMap[self.selectItemSubType.value]
  end)
end

function SocialPlayerSetAvatarPanel:_CheckIsSameItem()
  if self.selectItemSubType.value == ItemSubType.PlayerAvatar then
    return self.usingAvatar == self.selectAvatarTid.value
  elseif self.selectItemSubType.value == ItemSubType.AvatarFrame then
    return self.usingFrame == self.selectFrameTid.value
  end
  return false
end

function SocialPlayerSetAvatarPanel:_GenItemList()
  local list = {}
  for _, v in pairs(DataCenter.itemData.BagItemData) do
    if not v then
    else
      local config = ItemDataUtils.GetItemConfig(v.tid)
      if config.Type == ItemType.Special and config.SubType == self.selectItemSubType.value then
        table.insert(list, v)
      end
    end
  end
  
  local function _SortFunc(a, b)
    local configA = ItemDataUtils.GetItemConfig(a.tid)
    local configB = ItemDataUtils.GetItemConfig(b.tid)
    return configA.BaseSortID < configB.BaseSortID
  end
  
  table.sort(list, _SortFunc)
  self.showList.value = list
  return self.showList.value
end

function SocialPlayerSetAvatarPanel:_OnUpdateAvatarItem(binder, obj, index)
  local itemData = self.showList.value[index]
  local ui = UI_Social_Item_AvatarResource(obj)
  binder:UpdateLocalizedTextAndResouce(obj)
  local selectItemSubType = self.selectItemSubType.value
  local isSelectHeads = selectItemSubType == ItemSubType.PlayerAvatar
  
  local function _OnSelect()
    local selectTid = isSelectHeads and self.selectAvatarTid.value or self.selectFrameTid.value
    return selectTid == itemData.tid
  end
  
  binder:SetText(ui.Text_Lv, "")
  binder:SetActive(ui.Text_Lv, false)
  binder:BindToVisible(ui.Image_Select, _OnSelect)
  local targetImage = ItemDataUtils.GetItemIcon(itemData.tid)
  binder:BindComponent((CommonHeadItem(ui.UI_Common_Head, {
    headIcon = targetImage,
    frameIcon = targetImage,
    hideHead = not isSelectHeads,
    hideFrame = isSelectHeads,
    clickCb = function()
      if isSelectHeads then
        SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.Avatar, {
          itemData.uid
        })
        self.selectAvatarTid.value = itemData.tid
        return
      end
      SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.AvatarFrame, {
        itemData.uid
      })
      self.selectFrameTid.value = itemData.tid
    end,
    redFunc = function()
      do return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.Item end
      return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.Item, {
        itemData.uid
      }, itemData.uid
    end
  })))
end

function SocialPlayerSetAvatarPanel:_GetAvatarName(tid)
  if not tid then
    Logger.Warn("[_GetAvatarName] Social Avatar param error, tid:", tid)
    return
  end
  local itemName = ItemDataUtils.GetItemName(tid)
  if itemName and string.contains(itemName, "{s1}") then
    itemName = LT.Textf(itemName, DataCenter.playerData.DRole.name)
  end
  return itemName
end

function SocialPlayerSetAvatarPanel:_GetAvatarIntro(tid)
  if not tid then
    Logger.Warn("[_GetAvatarIntro] Social Avatar param error, tid:", tid)
    return
  end
  do return ItemDataUtils.GetItemDesc end
  return ItemDataUtils.GetItemDesc, tid, tid
end

function SocialPlayerSetAvatarPanel:_OnClickConfirm()
  local function _OnSetAvatarSucc()
    if self.callback then
      self.callback(self.selectAvatarTid.value, self.selectFrameTid.value, self.selectItemSubType.value)
    end
    self:Close()
  end
  
  if self.selectItemSubType.value == ItemSubType.PlayerAvatar then
    SocialDataUtils.SetPlayerAvatar(self.selectAvatarTid.value, _OnSetAvatarSucc)
  elseif self.selectItemSubType.value == ItemSubType.AvatarFrame then
    SocialDataUtils.SetPlayerAvatarFrame(self.selectFrameTid.value, _OnSetAvatarSucc)
  end
end

function SocialPlayerSetAvatarPanel:Close()
  Super.Close(self)
end

return SocialPlayerSetAvatarPanel
