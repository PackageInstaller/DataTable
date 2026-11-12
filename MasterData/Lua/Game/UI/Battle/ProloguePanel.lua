local ProloguePanel = class("ProloguePanel", BasePanel)
ProloguePanel.OpenMinMap = false
ProloguePanel._bAddToBackHistory = false
ProloguePanel._tbDefine = {
  {
    sPrefabPath = "Battle/ProloguePanel.prefab",
    sCtrlName = "Game.UI.Battle.PrologueCtrl"
  },
  {
    sPrefabPath = "Battle/SkillHintIndicators.prefab",
    sCtrlName = "Game.UI.Battle.SkillHintIndicator.HintIndicators"
  }
}

function ProloguePanel:OnEnable()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
  end
  
  cs_coroutine.start(wait)
end

return ProloguePanel
