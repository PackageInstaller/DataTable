local GiftCharItemCtrl = class("GiftCharItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
GiftCharItemCtrl._mapNodeConfig = {
  imgBg = {},
  imgSelectBg = {},
  imgHeadIcon = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text", nCount = 2},
  txtSign = {sComponentName = "TMP_Text", nCount = 2},
  goAffinity = {},
  imgProgressBg = {},
  rectProgress = {
    sNodeName = "imgProgress",
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  imgAffinityLv = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  imgOnline = {}
}
GiftCharItemCtrl._mapEventConfig = {}
local nSignTextMaxHeight = 65

function GiftCharItemCtrl:SetSelect(bSelect)
  self._mapNode.imgBg.gameObject:SetActive(not bSelect)
  self._mapNode.imgSelectBg.gameObject:SetActive(bSelect)
  self._mapNode.imgOnline.gameObject:SetActive(bSelect)
end

function GiftCharItemCtrl:SetGiftCharItem(nCharId)
  if self.signTextAnimTimer ~= nil then
    self.signTextAnimTimer:Cancel()
    self.signTextAnimTimer = nil
  end
  self.nCharId = nCharId
  local mapCharacter = ConfigTable.GetData_Character(nCharId)
  if mapCharacter ~= nil then
    local nSkinId = mapCharacter.DefaultSkinId
    local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
    if mapSkin ~= nil then
      self:SetPngSprite(self._mapNode.imgHeadIcon, mapSkin.Icon, AllEnum.CharHeadIconSurfix.S)
    end
    NovaAPI.SetTMPText(self._mapNode.txtCharName[1], mapCharacter.Name)
    NovaAPI.SetTMPText(self._mapNode.txtCharName[2], mapCharacter.Name)
  end
  local cfgData = PlayerData.Phone:GetAvgContactsData(self.nCharId)
  for _, v in ipairs(self._mapNode.txtSign) do
    v.gameObject:SetActive(cfgData ~= nil)
    if cfgData ~= nil then
      NovaAPI.SetTMPText(v, cfgData.landmark)
    end
  end
  self:RefreshGiftLevel()
  self:SetSelect(false)
end

function GiftCharItemCtrl:RefreshGiftLevel()
  local affinityData = PlayerData.Char:GetCharAffinityData(self.nCharId)
  local curFavourLevel = affinityData.Level
  local curFavourExp = affinityData.Exp
  NovaAPI.SetTMPText(self._mapNode.txtLevel, curFavourLevel)
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.nCharId)
  if mapCharAffinity == nil then
    return
  end
  local templateId = mapCharAffinity.TemplateId
  local maxAffinityLevel = PlayerData.Char:GetMaxAffinityLevel(templateId)
  local level = curFavourLevel >= maxAffinityLevel and maxAffinityLevel or curFavourLevel + 1
  local data = CacheTable.GetData("_AffinityLevel", templateId)[level]
  local nPercent = 0
  if curFavourLevel >= maxAffinityLevel then
    nPercent = 1
  else
    nPercent = curFavourExp / data.NeedExp
  end
  local sizeDelta = self._mapNode.rectProgress.sizeDelta
  sizeDelta.x = self.progressBarWidth * nPercent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * nPercent
  self._mapNode.rectProgress.sizeDelta = sizeDelta
  if curFavourLevel >= maxAffinityLevel then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Phone_Gift_Affinity_Max_Level"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", curFavourExp, data.NeedExp))
  end
  local nCurLevel = curFavourLevel >= maxAffinityLevel and maxAffinityLevel or curFavourLevel
  data = CacheTable.GetData("_AffinityLevel", templateId)[nCurLevel]
  self:SetPngSprite(self._mapNode.imgAffinityLv, data.AffinityLevelIcon .. "_s")
  self._mapNode.rectProgress.gameObject:SetActive(0 < curFavourExp or curFavourLevel >= maxAffinityLevel)
end

function GiftCharItemCtrl:Awake()
  self.progressBarWidth = 253
  self.progressBarMinWidth = 0
end

function GiftCharItemCtrl:OnEnable()
end

function GiftCharItemCtrl:OnDisable()
end

function GiftCharItemCtrl:OnDestroy()
end

return GiftCharItemCtrl
