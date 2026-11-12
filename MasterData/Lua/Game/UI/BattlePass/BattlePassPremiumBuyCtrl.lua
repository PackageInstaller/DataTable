local BattlePassPremiumBuyCtrl = class("BattlePassPremiumBuyCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
BattlePassPremiumBuyCtrl._mapNodeConfig = {
  srRewardListPremium = {
    sComponentName = "LoopScrollView"
  },
  srRewardListSPremium = {
    sComponentName = "LoopScrollView"
  },
  btnBuySPremium = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SPremium"
  },
  btnBuyPremium = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Premium"
  },
  txtBtnbtnBuyPremium = {sComponentName = "TMP_Text"},
  txtBtnbtnBuySPremium = {sComponentName = "TMP_Text"},
  txtBtnbtnBuySPremiumDiscount = {sComponentName = "TMP_Text"},
  TMPUnlockSPremium = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassPremiumUnlocked"
  },
  TMPUnlockPremium = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassPremiumUnlocked"
  },
  TMPTitlePremium = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassRewardPremium"
  },
  TMPTitleSPremium = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassRewardLuxury"
  },
  TMPRewardDescPremium = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_SkinHint"
  },
  btnRewardDetailPremium = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OutfitInfo"
  },
  Actor2D_PNG_Buy = {sComponentName = "Transform"},
  imgBattlePassLogo = {sComponentName = "Image"}
}
BattlePassPremiumBuyCtrl._mapEventConfig = {}
BattlePassPremiumBuyCtrl._mapRedDotConfig = {}

function BattlePassPremiumBuyCtrl:Awake()
  self._mapGridCtrl = {}
end

function BattlePassPremiumBuyCtrl:FadeIn()
end

function BattlePassPremiumBuyCtrl:FadeOut()
end

function BattlePassPremiumBuyCtrl:OnEnable()
end

function BattlePassPremiumBuyCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function BattlePassPremiumBuyCtrl:OnDestroy()
end

function BattlePassPremiumBuyCtrl:OnRelease()
end

function BattlePassPremiumBuyCtrl:OpenPanel(nCurType, nSeasonId, nVersion)
  self.nCurType = nCurType
  self.nSeasonId = nSeasonId
  self.nVersion = nVersion
  self.gameObject:SetActive(true)
  local mapBattlePassCfgData = ConfigTable.GetData("BattlePass", self.nSeasonId)
  if mapBattlePassCfgData == nil then
    return
  end
  self.tbRewardPremium = mapBattlePassCfgData.PremiumShowItems
  self.tbRewardSPremium = mapBattlePassCfgData.LuxuryShowItems
  self._mapNode.srRewardListPremium:Init(#self.tbRewardPremium, self, self.OnGridRefreshPremium, nil, true, nil)
  self._mapNode.srRewardListSPremium:Init(#self.tbRewardSPremium + 1, self, self.OnGridRefreshSPremium, nil, true, nil)
  self.sPremiumProductId = mapBattlePassCfgData.PremiumProductId
  self.sLuxuryProductId = mapBattlePassCfgData.LuxuryProductId
  self.sComplementaryProductId = mapBattlePassCfgData.ComplementaryProductId
  NovaAPI.SetTMPText(self._mapNode.txtBtnbtnBuyPremium, tostring(mapBattlePassCfgData.PremiumShowPrice))
  if self.nSeasonId >= 6 then
    self:SetPngSprite(self._mapNode.imgBattlePassLogo, "Icon/ArtText/CharSkin_ArtText_" .. mapBattlePassCfgData.Cover .. "_lang")
  else
    self:SetPngSprite(self._mapNode.imgBattlePassLogo, "Icon/ArtText/CharSkin_ArtText_" .. mapBattlePassCfgData.Cover)
  end
  NovaAPI.SetImageNativeSize(self._mapNode.imgBattlePassLogo)
  local sSPremiumPrice = nCurType == 0 and mapBattlePassCfgData.LuxuryShowPrice or mapBattlePassCfgData.ComplementaryShowPrice
  NovaAPI.SetTMPText(self._mapNode.txtBtnbtnBuySPremium, tostring(sSPremiumPrice))
  NovaAPI.SetTMPText(self._mapNode.txtBtnbtnBuySPremiumDiscount, tostring(mapBattlePassCfgData.OriginShowPrice))
  self._mapNode.txtBtnbtnBuySPremiumDiscount.gameObject:SetActive(nCurType == 0)
  self._mapNode.TMPUnlockPremium.gameObject:SetActive(1 <= nCurType)
  self._mapNode.TMPUnlockSPremium.gameObject:SetActive(2 <= nCurType)
  self._mapNode.btnBuyPremium.gameObject:SetActive(nCurType < 1)
  self._mapNode.btnBuySPremium.gameObject:SetActive(nCurType < 2)
  local nSkinId = mapBattlePassCfgData.Cover
  local mapSkinCfg = ConfigTable.GetData("CharacterSkin", nSkinId)
  if mapSkinCfg ~= nil then
    self._mapNode.Actor2D_PNG_Buy.gameObject:SetActive(true)
    local nCharId = mapSkinCfg.CharId
    Actor2DManager.SetActor2D_PNG(self._mapNode.Actor2D_PNG_Buy, PanelId.BattlePass, nCharId, nSkinId)
  else
    self._mapNode.Actor2D_PNG_Buy.gameObject:SetActive(false)
  end
end

function BattlePassPremiumBuyCtrl:Refresh(nCurType, nSeasonId, nVersion)
  self.nCurType = nCurType
  self.nSeasonId = nSeasonId
  self.nVersion = nVersion
  local mapBattlePassCfgData = ConfigTable.GetData("BattlePass", self.nSeasonId)
  if mapBattlePassCfgData == nil then
    printError("BattlePassCfgData missing:" .. self.nSeasonId)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtBtnbtnBuyPremium, tostring(mapBattlePassCfgData.PremiumShowPrice))
  local nSPremiumPrice = nCurType == 0 and mapBattlePassCfgData.LuxuryPrice or mapBattlePassCfgData.ComplementaryPrice
  local sSPremiumPrice = nCurType == 0 and mapBattlePassCfgData.LuxuryShowPrice or mapBattlePassCfgData.ComplementaryShowPrice
  NovaAPI.SetTMPText(self._mapNode.txtBtnbtnBuySPremium, tostring(sSPremiumPrice))
  NovaAPI.SetTMPText(self._mapNode.txtBtnbtnBuySPremiumDiscount, tostring(mapBattlePassCfgData.OriginShowPrice))
  self._mapNode.txtBtnbtnBuySPremiumDiscount.gameObject:SetActive(nCurType == 0)
  self._mapNode.TMPUnlockPremium.gameObject:SetActive(1 <= nCurType)
  self._mapNode.TMPUnlockSPremium.gameObject:SetActive(2 <= nCurType)
  self._mapNode.btnBuyPremium.gameObject:SetActive(nCurType < 1)
  self._mapNode.btnBuySPremium.gameObject:SetActive(nCurType < 2)
end

function BattlePassPremiumBuyCtrl:UnbindAllCtrl()
  for _, mapCtrl in pairs(self._mapGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapGridCtrl = {}
end

function BattlePassPremiumBuyCtrl:OnGridRefreshPremium(goGrid, gridIndex)
  if self._mapGridCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BattlePass.BattlePassBuyPremiumItemGridCtrl")
    self._mapGridCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  self._mapGridCtrl[goGrid]:Refresh(self.tbRewardPremium[nIdx])
end

function BattlePassPremiumBuyCtrl:OnGridRefreshSPremium(goGrid, gridIndex)
  if self._mapGridCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.BattlePass.BattlePassBuyPremiumItemGridCtrl")
    self._mapGridCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  self._mapGridCtrl[goGrid]:Refresh(self.tbRewardSPremium[nIdx])
end

function BattlePassPremiumBuyCtrl:ClosePanel()
  self.gameObject:SetActive(false)
  self:UnbindAllCtrl()
end

function BattlePassPremiumBuyCtrl:OnBtnClick_Premium()
  PlayerData.Mall:BuyBattlePass(1, self.nVersion, self.sPremiumProductId, "BattlePassPremium")
end

function BattlePassPremiumBuyCtrl:OnBtnClick_SPremium()
  local sId = self.nCurType == 0 and self.sLuxuryProductId or self.sComplementaryProductId
  local sStatistical = self.nCurType == 0 and "BattlePassOrigin_Luxury" or "BattlePassOrigin_Complement"
  PlayerData.Mall:BuyBattlePass(2, self.nVersion, sId, sStatistical)
end

function BattlePassPremiumBuyCtrl:OnBtnClick_OutfitInfo()
  local mapBattlePassCfgData = ConfigTable.GetData("BattlePass", self.nSeasonId)
  if mapBattlePassCfgData == nil then
    return
  end
  local nSkinId = mapBattlePassCfgData.Cover
  
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.SkinPreviewPanel, {nSkinId}, 1)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, func)
end

return BattlePassPremiumBuyCtrl
