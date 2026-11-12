local RoguelikeResultPanel = class("RoguelikeResultPanel", BasePanel)
RoguelikeResultPanel._bAddToBackHistory = false
RoguelikeResultPanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeResultPanel/RoguelikeResult.prefab",
    sCtrlName = "Game.UI.RoguelikeResultPanel.RoguelikeResultCtrl"
  }
}

function RoguelikeResultPanel:Awake()
end

function RoguelikeResultPanel:OnEnable()
end

function RoguelikeResultPanel:OnDisable()
end

function RoguelikeResultPanel:OnDestroy()
end

return RoguelikeResultPanel
