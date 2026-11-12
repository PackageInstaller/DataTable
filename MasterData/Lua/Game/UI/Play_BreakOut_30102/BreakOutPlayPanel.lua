local BreakOutPlayPanel = class("BreakOutPlayPanel", BasePanel)
BreakOutPlayPanel._bIsMainPanel = true
BreakOutPlayPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
BreakOutPlayPanel._sUIResRootPath = "UI_Activity/"
BreakOutPlayPanel._tbDefine = {
  {
    sPrefabPath = "30102/Play/BreakOutPlayPanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutPlayCtrl"
  },
  {
    sPrefabPath = "30102/Play/BreakOutPlaySkillPanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutPlaySkillCtrl"
  },
  {
    sPrefabPath = "30102/Play/PausePanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutPauseCtrl"
  },
  {
    sPrefabPath = "30102/Play/BreakOutAllResultPanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutResultCtrl"
  }
}

function BreakOutPlayPanel:SetTop(goCanvas)
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

function BreakOutPlayPanel:Awake()
  self.trUIRoot = GameObject.Find("---- UI ----").transform
  GamepadUIManager.EnterAdventure()
  GamepadUIManager.EnableGamepadUI("BattleMenu", {})
end

function BreakOutPlayPanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud, false, true)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormation)
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineFormationDisc)
    EventManager.Hit(EventId.ClosePanel, PanelId.RegionBossFormation)
  end
  
  cs_coroutine.start(wait)
end

function BreakOutPlayPanel:OnAfterEnter()
end

function BreakOutPlayPanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("BattleMenu")
  GamepadUIManager.DisableGamepadUI("BreakOutPlayCtrl")
  GamepadUIManager.QuitAdventure()
end

function BreakOutPlayPanel:OnDestroy()
end

function BreakOutPlayPanel:OnRelease()
end

return BreakOutPlayPanel
