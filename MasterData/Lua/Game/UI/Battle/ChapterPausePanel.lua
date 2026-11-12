local ChapterPausePanel = class("ChapterPausePanel", BasePanel)
ChapterPausePanel._bIsMainPanel = false
ChapterPausePanel._tbDefine = {
  {
    sPrefabPath = "Battle/ChapterPausePanel.prefab",
    sCtrlName = "Game.UI.Battle.ChapterPauseCtrl"
  }
}

function ChapterPausePanel:Awake()
end

function ChapterPausePanel:OnEnable()
end

function ChapterPausePanel:OnDisable()
end

function ChapterPausePanel:OnDestroy()
end

return ChapterPausePanel
