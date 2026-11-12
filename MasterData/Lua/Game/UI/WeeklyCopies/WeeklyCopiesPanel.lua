local WeeklyCopiesPanel = class("WeeklyCopiesPanel", BasePanel)
WeeklyCopiesPanel._tbDefine = {
  {
    sPrefabPath = "WeeklyCopies/WeeklyCopiesPanel.prefab",
    sCtrlName = "Game.UI.WeeklyCopies.WeeklyCopiesCtrl"
  }
}

function WeeklyCopiesPanel:Awake()
  self.curSelMonster = 0
end

function WeeklyCopiesPanel:OnEnable()
end

function WeeklyCopiesPanel:OnAfterEnter()
end

function WeeklyCopiesPanel:OnDisable()
end

function WeeklyCopiesPanel:OnDestroy()
end

function WeeklyCopiesPanel:OnRelease()
end

return WeeklyCopiesPanel
