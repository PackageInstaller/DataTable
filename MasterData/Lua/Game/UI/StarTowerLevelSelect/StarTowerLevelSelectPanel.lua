local StarTowerLevelSelectPanel = class("StarTowerLevelSelectPanel", BasePanel)
StarTowerLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerLevelSelect/StarTowerLevelSelect.prefab",
    sCtrlName = "Game.UI.StarTowerLevelSelect.StarTowerLevelSelectCtrl"
  }
}

function StarTowerLevelSelectPanel:Awake()
end

function StarTowerLevelSelectPanel:OnEnable()
end

function StarTowerLevelSelectPanel:OnDisable()
end

function StarTowerLevelSelectPanel:OnDestroy()
end

function StarTowerLevelSelectPanel:OnRelease()
end

function StarTowerLevelSelectPanel:OnAfterEnter()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    PopUpManager.OpenPopUpPanelByType(GameEnum.PopUpSeqType.FuncUnlock)
  end
  
  cs_coroutine.start(wait)
end

return StarTowerLevelSelectPanel
