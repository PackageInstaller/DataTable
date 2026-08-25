local PVPCardRecordInfoPanel, Super = System.NewClass("PVPCardRecordInfoPanel", FuncBattleCardInfoPanel)
PVPCardRecordInfoPanel.uiResCls = Func_Battle_CardInfoResource

function PVPCardRecordInfoPanel:ctor(...)
  Super.ctor(self, ...)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function PVPCardRecordInfoPanel:OnBind(...)
  Super.OnBind(self, ...)
  EventMgr.Instance.TouchEndEvent:RegisterEvent(System.fn(self, self.OnTouchEnd))
end

function PVPCardRecordInfoPanel:OnUnbind()
  Super.OnUnbind(self)
  EventMgr.Instance.TouchEndEvent:RemoveEvent(System.fn(self, self.OnTouchEnd))
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function PVPCardRecordInfoPanel:OnTouchEnd(e)
  self:Close()
end

return PVPCardRecordInfoPanel
