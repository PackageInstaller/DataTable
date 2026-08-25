local typeof = _ENV.typeof
local BattlePanelStageUI, Super = System.NewComponent("BattlePanelStageUI")

function BattlePanelStageUI:ctor(battlePanel, uiNode)
  Super.ctor(self)
  self.ui = UI_Battle_Panel_DbgResource(uiNode)
  self.battlePanel = battlePanel
end

function BattlePanelStageUI:OnBind(binder)
  self.binder = binder
end

function BattlePanelStageUI:OnUnbind()
end

return BattlePanelStageUI
