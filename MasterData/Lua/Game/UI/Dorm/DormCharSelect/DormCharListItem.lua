local DormCharListItem = class("DormCharListItem", BaseCtrl)
DormCharListItem._mapNodeConfig = {
  Mask = {},
  imgSelectChoose = {},
  TMPHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "In_Formation"
  },
  imgSelectIcon = {},
  imgSelect = {},
  imgSelectedMask = {},
  imgIcon = {sComponentName = "Image"},
  btnGrid = {sComponentName = "UIButton"},
  btnMask = {
    sNodeName = "Mask",
    sComponentName = "Button",
    callback = "OnBtnClick_Mask"
  },
  TMPSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "RoguelikeBuild_Manage_SelectedTitle"
  },
  imgCharRare = {sComponentName = "Image"}
}
DormCharListItem._mapEventConfig = {}

function DormCharListItem:Awake()
end

function DormCharListItem:FadeIn()
end

function DormCharListItem:FadeOut()
end

function DormCharListItem:OnEnable()
end

function DormCharListItem:OnDisable()
end

function DormCharListItem:OnDestroy()
end

function DormCharListItem:OnRelease()
end

function DormCharListItem:SetChar(nCharId)
  local mapChar = ConfigTable.GetData_Character(nCharId)
  if mapChar == nil then
    return
  end
  local mapCharItem = ConfigTable.GetData_Item(nCharId)
  if mapCharItem == nil then
    return
  end
  local nSkinId = mapChar.DefaultSkinId
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  if mapCharSkin == nil then
    return
  end
  local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharItem.Rarity]
  self:SetAtlasSprite(self._mapNode.imgCharRare, "12_rare", sFrame)
  self:SetPngSprite(self._mapNode.imgIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXLS)
end

function DormCharListItem:RefreshItem(bSelect, nIdx, nCharId, bBanned, nSortType, nRoomId)
  self.nCharId = nCharId
  self:SetChar(nCharId)
  self.bBanned = bBanned
  self._mapNode.Mask:SetActive(bBanned)
  self:SetSelect(bSelect)
  if 0 < nRoomId then
    local sName = PlayerData.PlayerDormData:GetRoomNameById(nRoomId)
    NovaAPI.SetTMPText(self._mapNode.TMPHint, sName)
  end
end

function DormCharListItem:SetSelect(bSelect, nIdx)
  self._mapNode.imgSelect:SetActive(bSelect)
  self._mapNode.imgSelectedMask:SetActive(bSelect)
  self._mapNode.imgSelectIcon:SetActive(bSelect)
  self._mapNode.imgSelectChoose:SetActive(bSelect)
end

function DormCharListItem:OnBtnClick_Mask(btn)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Formation_Selected"))
end

function DormCharListItem:OnBtnClick_Detail(btn)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if PlayerData.Guide:GetGuideState() then
    return
  end
  if self.nCharId ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId, {
      self.nCharId
    }, false)
  end
end

return DormCharListItem
