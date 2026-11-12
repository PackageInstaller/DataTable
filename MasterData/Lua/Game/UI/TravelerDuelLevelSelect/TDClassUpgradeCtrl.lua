local TDClassUpgradeCtrl = class("TDClassUpgradeCtrl", BaseCtrl)
TDClassUpgradeCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  btnMaskClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtRankNum = {sComponentName = "TMP_Text"},
  imgExp = {sComponentName = "Image"},
  txtEffect = {sComponentName = "TMP_Text"},
  txtEffectValueBefore = {sComponentName = "TMP_Text"},
  txtEffectValueAfter = {sComponentName = "TMP_Text"}
}
TDClassUpgradeCtrl._mapEventConfig = {}

function TDClassUpgradeCtrl:SetOldWorldClass()
  local nOldWorldClass, nOldWorldExp = PlayerData.TravelerDuel:GetOldTDLevelData()
  local mapOldCfg = ConfigTable.GetData("TravelerDuelLevel", nOldWorldClass + 1)
  local nOldFullExp = 0
  if mapOldCfg then
    nOldFullExp = mapOldCfg.LevelUpExp
  end
  NovaAPI.SetTMPText(self._mapNode.txtRankNum, nOldWorldClass)
  NovaAPI.SetImageFillAmount(self._mapNode.imgExp, nOldWorldExp / nOldFullExp)
  local nWorldClass, nCurExp = PlayerData.TravelerDuel:GetTravelerDuelLevel()
  local mapCfg = ConfigTable.GetData("TravelerDuelLevel", nWorldClass + 1)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.LevelUpExp
  end
  local sequence = DOTween.Sequence()
  sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgExp, 1, 0.65, true))
  sequence:AppendCallback(function()
    self:Refresh()
  end)
  sequence:AppendInterval(0.5)
  sequence:Append(NovaAPI.ImageDoFillAmount(self._mapNode.imgExp, nCurExp / nFullExp, 0.5, true))
  sequence:SetUpdate(true)
end

function TDClassUpgradeCtrl:Refresh()
  local nWorldClass = PlayerData.TravelerDuel:GetTravelerDuelLevel()
  local nWorldClassBefore = PlayerData.TravelerDuel:GetOldTDLevelData()
  local mapCurCfg = ConfigTable.GetData("TravelerDuelLevel", nWorldClass)
  local mapBeforeCfg = ConfigTable.GetData("TravelerDuelLevel", nWorldClassBefore)
  NovaAPI.SetTMPText(self._mapNode.txtRankNum, nWorldClass)
  NovaAPI.SetImageFillAmount(self._mapNode.imgExp, 0)
  NovaAPI.SetTMPText(self._mapNode.txtEffect, ConfigTable.GetUIText("TD_TitleCurCoinAdd"))
  NovaAPI.SetTMPText(self._mapNode.txtEffectValueBefore, mapBeforeCfg.CoinAdditionProb .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtEffectValueAfter, mapCurCfg.CoinAdditionProb .. "%")
end

function TDClassUpgradeCtrl:FadeIn()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function TDClassUpgradeCtrl:Awake()
end

function TDClassUpgradeCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if nil ~= tbParam and nil ~= tbParam[1] then
    self.cbClose = tbParam[1]
  end
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  self._mapNode.goRoot.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.imgBlurredBg.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self:SetOldWorldClass()
  end
  
  cs_coroutine.start(wait)
end

function TDClassUpgradeCtrl:OnDisable()
end

function TDClassUpgradeCtrl:OnDestroy()
end

function TDClassUpgradeCtrl:OnBtnClick_Close()
  PlayerData.Base:SetWorldClassChange(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.TDLevelUpgrade)
  if nil ~= self.cbClose then
    self.cbClose()
  end
end

return TDClassUpgradeCtrl
