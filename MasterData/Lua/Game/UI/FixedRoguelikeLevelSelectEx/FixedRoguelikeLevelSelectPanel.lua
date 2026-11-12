local FixedRoguelikeLevelSelectPanel = class("FixedRoguelikeLevelSelectPanel", BasePanel)
FixedRoguelikeLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "FRLevelSelectEx/RoguelikeLevelSelect.prefab",
    sCtrlName = "Game.UI.FixedRoguelikeLevelSelectEx.FixedRoguelikeLevelCtrl"
  }
}

function FixedRoguelikeLevelSelectPanel:Awake()
end

function FixedRoguelikeLevelSelectPanel:OnEnable()
end

function FixedRoguelikeLevelSelectPanel:OnDisable()
end

function FixedRoguelikeLevelSelectPanel:OnDestroy()
end

function FixedRoguelikeLevelSelectPanel:OnRelease()
end

function FixedRoguelikeLevelSelectPanel:OnAfterEnter()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    PopUpManager.OpenPopUpPanelByType(GameEnum.PopUpSeqType.FuncUnlock)
  end
  
  cs_coroutine.start(wait)
end

return FixedRoguelikeLevelSelectPanel
