local StarTowerFastBattlePanel = class("StarTowerFastBattlePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
StarTowerFastBattlePanel._tbDefine = {
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerFastBattlePanel.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerFastBattleCtrl"
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
    sPrefabPath = "StarTower/StarTowerDepotPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Depot.StarTowerDepotCtrl"
  },
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerAutoBattlePopup.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionHUDCtrl"
  }
}

function StarTowerFastBattlePanel:Awake()
  self.trUIRoot = GameObject.Find("---- UI ----").transform
  local tbParams = self:GetPanelParam()
  assert(type(tbParams) == "table" and tbParams[1] ~= nil, "StarTowerFastBattlePanel: 缺少初始化参数")
  local tbStarTowerInfo = tbParams[1]
  local luaClass = require("Game.Adventure.StarTower.StarTowerSweepData")
  self.LevelData = luaClass.new(tbStarTowerInfo.Meta.Id)
  StarTowerSettingGate.Start(self.LevelData)
  self.LevelData:Init(tbStarTowerInfo.Meta, tbStarTowerInfo.Room, tbStarTowerInfo.Bag)
  EventManager.Hit("SetStarTowerSweepData", self.LevelData)
  self.tbTeam = self.LevelData.tbTeam
  self.tbDisc = self.LevelData.tbDisc
  self.mapCharData = self.LevelData.mapCharData
  self.mapDiscData = self.LevelData.mapDiscData
  self.mapPotentialAddLevel = self.LevelData.mapPotentialAddLevel
  self.nStarTowerId = self.LevelData.nTowerId
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
  GamepadUIManager.EnterAdventure(true)
end

function StarTowerFastBattlePanel:SetTop(goCanvas)
  NovaAPI.SetCanvasSortingOrder(goCanvas, AllEnum.UI_SORTING_ORDER.StarTowerSweepPopup)
end

function StarTowerFastBattlePanel:OpenDepotDetailPanel(nPanelId, ...)
  PanelManager.OpenPanelWithContext(nPanelId, {
    nSortingOrderBase = AllEnum.UI_SORTING_ORDER.StarTowerSweepDetail
  }, ...)
end

function StarTowerFastBattlePanel:CheckMainChar(nCharId)
  if self.tbTeam ~= nil then
    for k, v in ipairs(self.tbTeam) do
      if v == nCharId then
        return k == 1
      end
    end
  end
  return false
end

function StarTowerFastBattlePanel:GetSkillLevel(nCharId)
  local mapChar = self.mapCharData[nCharId]
  local tbList = {}
  tbList[GameEnum.skillSlotType.NORMAL] = mapChar and mapChar.tbSkillLvs[1] or 1
  tbList[GameEnum.skillSlotType.B] = mapChar and mapChar.tbSkillLvs[2] or 1
  tbList[GameEnum.skillSlotType.C] = mapChar and mapChar.tbSkillLvs[3] or 1
  tbList[GameEnum.skillSlotType.D] = mapChar and mapChar.tbSkillLvs[4] or 1
  return tbList
end

function StarTowerFastBattlePanel:OnEnable()
  PlayerData.State:SetStarTowerSweepState(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormationDisc)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function StarTowerFastBattlePanel:OnDisable()
  StarTowerSettingGate.Stop(self.LevelData)
  PlayerData.State:SetStarTowerSweepState(false)
  GamepadUIManager.QuitAdventure()
end

function StarTowerFastBattlePanel:OnDestroy()
  StarTowerSettingGate.Stop(self.LevelData)
  self.LevelData:EndExploration()
  self.LevelData:UnBindEvent()
  EventManager.Hit("SetStarTowerSweepData")
end

function StarTowerFastBattlePanel:OnRelease()
end

function StarTowerFastBattlePanel:OnAfterEnter()
end

return StarTowerFastBattlePanel
