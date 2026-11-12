local BattlePassPopupSkinCtrl = class("BattlePassPopupSkinCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
BattlePassPopupSkinCtrl._mapNodeConfig = {
  Actor2D_PNG_Popup = {sComponentName = "Transform"},
  imgBattlePassLogo = {sComponentName = "Image"},
  TMPSeasonTImeTitle_popup = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_SeasonTImeTitle"
  },
  TMPSeasonTIme_popup = {sComponentName = "TMP_Text"},
  TMPPopupHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_SkinHint"
  },
  txtBtnClosePopup = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_SkinHintOpenBP"
  },
  btnClosePopup = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgSeasonTimeBar = {sComponentName = "Image"}
}
BattlePassPopupSkinCtrl._mapEventConfig = {}
BattlePassPopupSkinCtrl._mapRedDotConfig = {}

function BattlePassPopupSkinCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function BattlePassPopupSkinCtrl:FadeIn()
end

function BattlePassPopupSkinCtrl:FadeOut()
end

function BattlePassPopupSkinCtrl:OnEnable()
end

function BattlePassPopupSkinCtrl:OnDisable()
end

function BattlePassPopupSkinCtrl:OnDestroy()
end

function BattlePassPopupSkinCtrl:OnRelease()
end

function BattlePassPopupSkinCtrl:ShowPanel(mapBattlePassCfg)
  self.gameObject:SetActive(true)
  self.animRoot:Play("rtSkinPopup_in")
  local nSkinId = mapBattlePassCfg.Cover
  local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nSkinId)
  local _, color = ColorUtility.TryParseHtmlString(mapBattlePassCfg.CoverColor)
  self._mapNode.imgSeasonTimeBar.color = color
  if mapSkinCfg ~= nil then
    self._mapNode.Actor2D_PNG_Popup.gameObject:SetActive(true)
    local nCharId = mapSkinCfg.CharId
    Actor2DManager.SetActor2D_PNG(self._mapNode.Actor2D_PNG_Popup, PanelId.BattlePass, nCharId, nSkinId)
  else
    self._mapNode.Actor2D_PNG_Popup.gameObject:SetActive(false)
  end
  local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapBattlePassCfg.StartTime)
  local nCloseTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapBattlePassCfg.EndTime)
  local sOpenTime = os.date("%Y.%m.%d", nOpenTime)
  local sCloseTime = os.date("%Y.%m.%d", nCloseTime)
  NovaAPI.SetTMPText(self._mapNode.TMPSeasonTIme_popup, string.format("%s-%s", sOpenTime, sCloseTime))
  if mapBattlePassCfg.ID >= 6 then
    self:SetPngSprite(self._mapNode.imgBattlePassLogo, "Icon/ArtText/CharSkin_ArtText_" .. mapBattlePassCfg.Cover .. "_lang")
  else
    self:SetPngSprite(self._mapNode.imgBattlePassLogo, "Icon/ArtText/CharSkin_ArtText_" .. mapBattlePassCfg.Cover)
  end
  NovaAPI.SetImageNativeSize(self._mapNode.imgBattlePassLogo)
end

function BattlePassPopupSkinCtrl:OnBtnClick_Close()
  local function callback()
    self.gameObject:SetActive(false)
  end
  
  self.animRoot:Play("rtSkinPopup_out")
  self:AddTimer(1, 0.85, callback, true, true, true)
end

return BattlePassPopupSkinCtrl
