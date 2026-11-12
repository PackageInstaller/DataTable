local VampireSurvivorBattlePanel = class("VampireSurvivorBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
VampireSurvivorBattlePanel.OpenMinMap = true
VampireSurvivorBattlePanel._bAddToBackHistory = false
VampireSurvivorBattlePanel._tbDefine = {
  {
    sPrefabPath = "Battle/BattleDashboard.prefab",
    sCtrlName = "Game.UI.Battle.BattleDashboardCtrl"
  },
  {
    sPrefabPath = "VampireBattle/VampireMenu.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireMenuCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/AdventureMainUI.prefab",
    sCtrlName = "Game.UI.Battle.MainBattleCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "Battle/CommonMonsterWarning.prefab",
    sCtrlName = "Game.UI.Battle.CommonMonsterWarningCtrl"
  },
  {
    sPrefabPath = "RegionBossTimeEx/RegionBossTime.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireSurvivorTimeCtrl"
  },
  {
    sPrefabPath = "VampireBattle/VampireFateCardSelectPanel.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireFateCardSelect"
  },
  {
    sPrefabPath = "VampireBattle/VampireRoomInfo.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireSurvivorRoomInfo"
  },
  {
    sPrefabPath = "VampireBattle/VampirePausePanel.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireSurvivorPauseCtrl"
  },
  {
    sPrefabPath = "VampireBattle/VampireDepotPanel.prefab",
    sCtrlName = "Game.UI.VampireSurvivor.VampireDepotCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function VampireSurvivorBattlePanel:Awake()
  self.BattleType = GameEnum.worldLevelType.VampireInstance
  self.trUIRoot = GameObject.Find("---- UI ----").transform
  EventManager.Add("VampireSurvivorChangeArea", self, self.OnEvent_ChangeArea)
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
  self.nLevelId = self._tbParam[2]
  self:RefreshCharData(self._tbParam[1], self._tbParam[3])
end

function VampireSurvivorBattlePanel:SetTop(goCanvas)
  local nTopLayer = 0
  if nil ~= self.trUIRoot then
    local nChildCount = self.trUIRoot.childCount
    local trChild
    for i = 1, nChildCount do
      trChild = self.trUIRoot:GetChild(i - 1)
      nTopLayer = math.max(nTopLayer, NovaAPI.GetCanvasSortingOrder(trChild:GetComponent("Canvas")))
    end
  end
  if 0 < nTopLayer then
    NovaAPI.SetCanvasSortingOrder(goCanvas, nTopLayer + 1)
  end
end

function VampireSurvivorBattlePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud, true, true)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
  end
  
  cs_coroutine.start(wait)
end

function VampireSurvivorBattlePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self._tbParam[1])
end

function VampireSurvivorBattlePanel:OnDisable()
  EventManager.Remove("VampireSurvivorChangeArea", self, self.OnEvent_ChangeArea)
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

function VampireSurvivorBattlePanel:RefreshCharData(tbTeam, mapBuildData)
  self.tbTeam = tbTeam
  local nBuildSource = PlayerData.Build:GetBuildSourceByData(mapBuildData)
  self._bTrialBuild = nBuildSource == AllEnum.BuildSource.Trial or nBuildSource == AllEnum.BuildSource.LimitedTrial
  local mapTrialId = {}
  if self._bTrialBuild then
    for _, mapBuildChar in ipairs(mapBuildData.tbChar) do
      mapTrialId[mapBuildChar.nTid] = mapBuildChar.nTrialId
    end
  end
  self.mapCharData = {}
  for _, nCharId in ipairs(self.tbTeam) do
    local mapChar
    local nTrialId = mapTrialId[nCharId]
    if nBuildSource == AllEnum.BuildSource.LimitedTrial then
      mapChar = clone(PlayerData.Char:GetLimitedTrialCharById(nTrialId))
      mapChar.tbAttrEffect = PlayerData.Talent:GetLimitedTrialTalentEffect(nTrialId)
      mapChar.tbSkillAddedLvs = PlayerData.Char:GetLimitedTrialCharSkillAddedLevel(nTrialId)
    elseif nBuildSource == AllEnum.BuildSource.Trial then
      mapChar = clone(PlayerData.Char:GetTrialCharById(nTrialId))
      mapChar.tbAttrEffect = PlayerData.Talent:GetTrialTalentEffect(nTrialId)
      mapChar.tbSkillAddedLvs = PlayerData.Char:GetTrialCharSkillAddedLevel(nTrialId)
    else
      mapChar = clone(PlayerData.Char:GetCharDataByTid(nCharId))
    end
    self.mapCharData[nCharId] = mapChar
  end
end

function VampireSurvivorBattlePanel:OnEvent_ChangeArea(tbTeam, mapBuildData)
  self:RefreshCharData(tbTeam, mapBuildData)
end

return VampireSurvivorBattlePanel
