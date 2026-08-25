local TreasureMailListItemComp, Super = NewViewComponent("TreasureMailListItemComp", MailListItemComp)

function TreasureMailListItemComp:ctor(uiNode, view, mailData, isSelected, clickCb)
  Super.ctor(self, uiNode, view, mailData, isSelected, clickCb)
  self.ui = Btn_Pocket_Mail_ItemResource(uiNode)
end

function TreasureMailListItemComp:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnChangeTreasureMailData, self._RefreshAll, self)
end

return TreasureMailListItemComp
