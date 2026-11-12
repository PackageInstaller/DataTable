local DormMusicSelectPanel = class("DormMusicSelectPanel", BasePanel)
DormMusicSelectPanel._bIsMainPanel = false
DormMusicSelectPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormMusicSelectPanel.prefab",
    sCtrlName = "Game.UI.Dorm.MusicSelect.DormMusicSelectCtrl"
  }
}

function DormMusicSelectPanel:Awake()
end

function DormMusicSelectPanel:OnEnable()
end

function DormMusicSelectPanel:OnDisable()
end

function DormMusicSelectPanel:OnDestroy()
end

return DormMusicSelectPanel
