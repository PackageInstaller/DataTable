local StarTowerPanel = class("StarTowerPanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerPanel.OpenMinMap = false
StarTowerPanel._bAddToBackHistory = false
StarTowerPanel._tbDefine = {
  {
    sPrefabPath = "Battle/BattleDashboard.prefab",
    sCtrlName = "Game.UI.Battle.BattleDashboardCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/AdventureMainUI.prefab",
    sCtrlName = "Game.UI.Battle.MainBattleCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  },
  {
    sPrefabPath = "FixedRoguelikeEx/FRIndicators.prefab",
    sCtrlName = "Game.UI.FixedRoguelikeEx.FRIndicators"
  },
  {
    sPrefabPath = "StarTower/StarTowerMenu.prefab",
    sCtrlName = "Game.UI.StarTower.StarTowerMenuCtrl"
  },
  {
    sPrefabPath = "StarTower/StarTowerRoomInfo.prefab",
    sCtrlName = "Game.UI.StarTower.StarTowerRoomInfo"
  },
  {
    sPrefabPath = "StarTower/PotentialSelectPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Potential.PotentialSelectCtrl"
  },
  {
    sPrefabPath = "StarTower/PotentialLevelUpPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Potential.PotentialLevelUpCtrl"
  },
  {
    sPrefabPath = "StarTower/FateCardSelectPanel.prefab",
    sCtrlName = "Game.UI.StarTower.FateCard.FateCardSelectCtrl"
  },
  {
    sPrefabPath = "StarTower/DiscSkillActivePanel.prefab",
    sCtrlName = "Game.UI.StarTower.DiscTips.DiscSkillActiveCtrl"
  },
  {
    sPrefabPath = "StarTower/StarTowerNotePanel.prefab",
    sCtrlName = "Game.UI.StarTower.StarTowerNoteCtrl"
  },
  {
    sPrefabPath = "StarTower/StarTowerMapPanel.prefab",
    sCtrlName = "Game.UI.StarTower.StarTowerMapCtrl"
  },
  {
    sPrefabPath = "StarTower/StarTowerDepotPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Depot.StarTowerDepotCtrl"
  },
  {
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
  }
}

function StarTowerPanel:SetTop(goCanvas)
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

function StarTowerPanel:CheckMainChar(nCharId)
  if self.tbTeam ~= nil then
    for k, v in ipairs(self.tbTeam) do
      if v == nCharId then
        return k == 1
      end
    end
  end
  return false
end

function StarTowerPanel:GetSkillLevel(nCharId)
  local mapChar = self.mapCharData[nCharId]
  local tbList = {}
  tbList[GameEnum.skillSlotType.NORMAL] = mapChar and mapChar.tbSkillLvs[1] or 1
  tbList[GameEnum.skillSlotType.B] = mapChar and mapChar.tbSkillLvs[2] or 1
  tbList[GameEnum.skillSlotType.C] = mapChar and mapChar.tbSkillLvs[3] or 1
  tbList[GameEnum.skillSlotType.D] = mapChar and mapChar.tbSkillLvs[4] or 1
  return tbList
end

function StarTowerPanel:Awake()
  self.BattleType = GameEnum.worldLevelType.StarTower
  self.trUIRoot = GameObject.Find("---- UI ----").transform
  self.tbTeam = self._tbParam[1]
  self.tbDisc = self._tbParam[2]
  self.mapCharData = self._tbParam[3]
  self.mapDiscData = self._tbParam[4]
  self.mapPotentialAddLevel = self._tbParam[5]
  self.nStarTowerId = self._tbParam[6]
  self.nLastStarTowerId = self._tbParam[7]
  self.tbShowNote = {}
  local mapCfg = ConfigTable.GetData("StarTower", self.nStarTowerId)
  if mapCfg ~= nil then
    local nDropGroup = mapCfg.SubNoteSkillDropGroupId
    local tbNoteDrop = CacheTable.GetData("_SubNoteSkillDropGroup", nDropGroup)
    if tbNoteDrop ~= nil then
      for _, v in ipairs(tbNoteDrop) do
        table.insert(self.tbShowNote, v.SubNoteSkillId)
      end
    end
  end
  table.sort(self.tbShowNote, function(a, b)
    return a < b
  end)
  self.mapNoteNeed = {}
  for nIndex, nDiscId in ipairs(self.tbDisc) do
    if 3 < nIndex then
      break
    end
    local mapDiscData = self.mapDiscData[nDiscId]
    if mapDiscData ~= nil then
      local tbNeedNote = mapDiscData.tbSkillNeedNote
      for _, mapNeedNote in ipairs(tbNeedNote) do
        if self.mapNoteNeed[mapNeedNote.nId] == nil then
          self.mapNoteNeed[mapNeedNote.nId] = 0
        end
        self.mapNoteNeed[mapNeedNote.nId] = self.mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
      end
    end
  end
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
end

function StarTowerPanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud, false, true)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormationDisc)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function StarTowerPanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self.tbTeam)
end

function StarTowerPanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

return StarTowerPanel
