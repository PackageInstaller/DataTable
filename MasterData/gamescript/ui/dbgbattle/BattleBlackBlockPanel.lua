local BattleBlackBlockPanel, Super = System.NewClass("BattleBlackBlockPanel", UIBasePanel)
BattleBlackBlockPanel.uiResCls = UI_EmptyPanelResource

function BattleBlackBlockPanel:ctor(overTime)
  Super.ctor(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleBlackBlockPanel:OnBind(binder)
  UIBlackScreenMgr.Instance:Show(self)
end

function BattleBlackBlockPanel:OnUnbind()
  Super.OnUnbind(self)
  UIBlackScreenMgr.Instance:Hide(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

return BattleBlackBlockPanel
