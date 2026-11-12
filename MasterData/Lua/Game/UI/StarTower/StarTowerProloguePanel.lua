local StarTowerProloguePanel = class("StarTowerProloguePanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerProloguePanel.OpenMinMap = false
StarTowerProloguePanel._bAddToBackHistory = false
StarTowerProloguePanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeItemTip/RoguelikeItemTipPanel.prefab",
    sCtrlName = "Game.UI.RoguelikeItemTips.RoguelikeItemTipsCtrl"
  },
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
    sPrefabPath = "Battle/SubSkillDisplay.prefab",
    sCtrlName = "Game.UI.Battle.SubSkillDisplay.SubSkillDisplayCtrl"
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
    sPrefabPath = "StarTower/FateCardSelectPanel.prefab",
    sCtrlName = "Game.UI.StarTower.FateCard.FateCardSelectCtrl"
  },
  {
    sPrefabPath = "GuideProloguel/GuideProloguelPanel.prefab",
    sCtrlName = "Game.UI.GuideProloguel.GuideProloguelCtrl"
  },
  {
    sPrefabPath = "Battle/AdventureMainUI/BattlePopupTips.prefab",
    sCtrlName = "Game.UI.Battle.BattlePopupTipsCtrl"
  }
}

function StarTowerProloguePanel:SetTop(goCanvas)
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

function StarTowerProloguePanel:CheckMainChar(nCharId)
  if self.tbTeam ~= nil then
    for k, v in ipairs(self.tbTeam) do
      if v == nCharId then
        return k == 1
      end
    end
  end
  return false
end

function StarTowerProloguePanel:GetSkillLevel(nCharId)
  local mapChar = self.mapCharData[nCharId]
  local tbList = {}
  tbList[GameEnum.skillSlotType.NORMAL] = mapChar and mapChar.tbSkillLvs[1] or 1
  tbList[GameEnum.skillSlotType.B] = mapChar and mapChar.tbSkillLvs[2] or 1
  tbList[GameEnum.skillSlotType.C] = mapChar and mapChar.tbSkillLvs[3] or 1
  tbList[GameEnum.skillSlotType.D] = mapChar and mapChar.tbSkillLvs[4] or 1
  return tbList
end

function StarTowerProloguePanel:Awake()
  self.BattleType = GameEnum.worldLevelType.PrologueBattleLevel
  self.trUIRoot = GameObject.Find("---- UI ----").transform
  self.tbTeam = self._tbParam[1]
  self.tbDisc = self._tbParam[2]
  self.mapCharData = self._tbParam[3]
  self.mapDiscData = self._tbParam[4]
  self.mapPotentialAddLevel = self._tbParam[5]
  self.nStarTowerId = self._tbParam[6]
  self.nLastStarTowerId = self._tbParam[7]
  self.tbShowNote = {}
  EventManager.Add(EventId.HideProloguePanle, self, self.SetProloguePanleVisible)
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
end

function StarTowerProloguePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormationDisc)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function StarTowerProloguePanel:OnAfterEnter()
  EventManager.Hit(EventId.SubSkillDisplayInit, self.tbTeam)
end

function StarTowerProloguePanel:OnDisable()
  EventManager.Remove(EventId.HideProloguePanle, self, self.SetProloguePanleVisible)
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.QuitAdventure()
end

function StarTowerProloguePanel:SetProloguePanleVisible(bVisible)
  local function SetVisible(_tb)
    for k, ctrlObjInstance in pairs(_tb) do
      ctrlObjInstance.gameObject:SetActive(bVisible == true)
    end
  end
  
  SetVisible(self._tbObjCtrl)
  SetVisible(self._tbObjChildCtrl)
  SetVisible(self._tbObjDyncChildCtrl)
  NovaAPI.DispatchEventWithData("BlockTouchEffect", nil, {bVisible})
end

return StarTowerProloguePanel
