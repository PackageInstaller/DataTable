local RpgArenaRelationPanel, Super = System.NewClass("RpgArenaRelationPanel", UIBasePanel)
RpgArenaRelationPanel.uiResCls = Popup_Arena_RelationResource

function RpgArenaRelationPanel:ctor()
  Super.ctor(self)
  self.data = DataCenter.rpgArenaData.historyCombat
end

function RpgArenaRelationPanel:OnBind(binder)
  self.binder = binder
  binder:BindToCircularListView(self.ui.ScrollView_Arena_Relation_Tip, function()
    return self.data
  end, function(childBinder, item, index)
    local total = #self.data
    childBinder:BindComponent(ArenaHistoryCombatItem(item, self.data[total - index + 1]))
  end)
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnConfirmClick))
end

function RpgArenaRelationPanel:OnConfirmClick()
  self:Close()
end

return RpgArenaRelationPanel
