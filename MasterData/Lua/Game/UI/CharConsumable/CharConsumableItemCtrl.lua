local CharConsumableItemCtrl = class("CharConsumableItemCtrl", BaseCtrl)
CharConsumableItemCtrl._mapNodeConfig = {
  imgSR = {nCount = 2},
  imgSSR = {nCount = 2},
  imgChar = {sComponentName = "Image"},
  TMPCharName = {sComponentName = "TMP_Text"},
  imgElement = {sComponentName = "Image"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  imgAlreadyOwned = {},
  imgSelectBg = {},
  imgSelectMask = {},
  TMPAO = {sComponentName = "TMP_Text", sLanguageId = "Skin_Has"}
}
CharConsumableItemCtrl._mapEventConfig = {}
CharConsumableItemCtrl._mapRedDotConfig = {}

function CharConsumableItemCtrl:Awake()
end

function CharConsumableItemCtrl:FadeIn()
end

function CharConsumableItemCtrl:FadeOut()
end

function CharConsumableItemCtrl:OnEnable()
end

function CharConsumableItemCtrl:OnDisable()
end

function CharConsumableItemCtrl:OnDestroy()
end

function CharConsumableItemCtrl:OnRelease()
end

function CharConsumableItemCtrl:SetChar(nCharId)
  local mapCharCfgData = ConfigTable.GetData("Character", nCharId)
  self.nCharId = nCharId
  if mapCharCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  local nSkinId = mapCharCfgData.DefaultSkinId
  local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  if mapSkin == nil then
    self.gameObject:SetActive(false)
    return
  end
  self:SetPngSprite(self._mapNode.imgChar, mapSkin.Icon .. AllEnum.CharHeadIconSurfix.GC)
  NovaAPI.SetTMPText(self._mapNode.TMPCharName, mapCharCfgData.Name)
  local sName = AllEnum.ElementIconType.Icon .. mapCharCfgData.EET
  self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", sName)
  self._mapNode.imgSSR[1]:SetActive(mapCharCfgData.Grade == GameEnum.characterGrade.SSR)
  self._mapNode.imgSSR[2]:SetActive(mapCharCfgData.Grade == GameEnum.characterGrade.SSR)
  local mapChar = PlayerData.Char:GetCharDataByTid(nCharId)
  self._mapNode.imgAlreadyOwned:SetActive(mapChar ~= nil)
end

function CharConsumableItemCtrl:SetSelect(bSelect)
  self._mapNode.imgSelectBg:SetActive(bSelect)
  self._mapNode.imgSelectMask:SetActive(bSelect)
end

function CharConsumableItemCtrl:OnBtnClick_Detail(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.nCharId)
end

return CharConsumableItemCtrl
