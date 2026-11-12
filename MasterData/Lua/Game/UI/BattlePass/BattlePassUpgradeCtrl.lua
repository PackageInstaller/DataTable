local BattlePassUpgradeCtrl = class("BattlePassUpgradeCtrl", BaseCtrl)
BattlePassUpgradeCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  btnMaskClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtRankNum = {sComponentName = "TMP_Text"},
  txtRankText = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_Upgrade_Hint"
  }
}
BattlePassUpgradeCtrl._mapEventConfig = {}

function BattlePassUpgradeCtrl:SetOldWorldClass()
  if self.mapBattlePassClass == nil then
    return
  end
  local nOldBattlePassClass = self.mapBattlePassClass.nOldLevel
  local nOldBattlePassExp = self.mapBattlePassClass.nOldExp
  local mapOldCfg = ConfigTable.GetData("BattlePassLevel", nOldBattlePassClass + 1)
  local nOldFullExp = 0
  if mapOldCfg then
    nOldFullExp = mapOldCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtRankNum, nOldBattlePassClass)
  local nBattlePassClass = self.mapBattlePassClass.nLevel
  local nCurExp = self.mapBattlePassClass.nExp
  local mapCfg = ConfigTable.GetData("BattlePassLevel", nBattlePassClass + 1)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  
  local function callback()
    self:Refresh()
  end
  
  self:AddTimer(1, 0.6, callback, true, true, true)
end

function BattlePassUpgradeCtrl:Refresh()
  local nBattlePassClass = self.mapBattlePassClass.nLevel
  NovaAPI.SetTMPText(self._mapNode.txtRankNum, nBattlePassClass)
end

function BattlePassUpgradeCtrl:FadeIn()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function BattlePassUpgradeCtrl:Awake()
end

function BattlePassUpgradeCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if nil ~= tbParam then
    self.cbClose = tbParam[1]
    self.mapBattlePassClass = tbParam[2]
  end
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  self._mapNode.goRoot.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goRoot.gameObject:SetActive(true)
    self:SetOldWorldClass()
  end
  
  cs_coroutine.start(wait)
end

function BattlePassUpgradeCtrl:OnDisable()
end

function BattlePassUpgradeCtrl:OnDestroy()
end

function BattlePassUpgradeCtrl:OnBtnClick_Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.BattlePassUpgrade)
  if nil ~= self.cbClose then
    self.cbClose()
  end
end

return BattlePassUpgradeCtrl
