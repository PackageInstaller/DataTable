local LevelMenuPanel = class("LevelMenuPanel", BasePanel)
LevelMenuPanel._tbDefine = {
  {
    sPrefabPath = "LevelMenuEx/LevelMenuPanel.prefab",
    sCtrlName = "Game.UI.LevelMenuEx.LevelMenuCtrl"
  }
}

function LevelMenuPanel:Awake()
  self.nCurStarTowerGroupId = nil
end

function LevelMenuPanel:OnEnable()
end

function LevelMenuPanel:OnDisable()
end

function LevelMenuPanel:OnDestroy()
end

function LevelMenuPanel:GetAniState()
end

function LevelMenuPanel:SetAniState(bPlay)
end

return LevelMenuPanel
