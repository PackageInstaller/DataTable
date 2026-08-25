local BattleAssistStarItem, Super = System.NewComponent("BattleAssistStarItem", BattleAssistItem)

function BattleAssistStarItem:_UpdateAssistPlayerInfo(targetData, name, newRelation)
  self.model:UpdateAssistStarPlayerInfo(targetData, name, newRelation)
  self.model:UpdateAssistPlayerInfo(targetData, name, newRelation)
  self.model:UpdateSearchAssistPlayerInfo(targetData, name, newRelation)
end

function BattleAssistStarItem:_BindShoolBan()
  self:SetActive(self.ui.Image_Conflict, false)
end

function BattleAssistStarItem:RefreshPlayerName()
  self.binder:SetText(self.ui.Text_Name, SocialDataUtils.GetPlayerName(self.data.playerInfo))
end

function BattleAssistStarItem:_CreateAttentionBtnCom(childBinder, attentionCb, socialNoteSuccess)
  SocialDataUtils.CreateAttentionBtnCom(childBinder, self.data, self.ui.Btn_Attention, nil, attentionCb, socialNoteSuccess)
end

return BattleAssistStarItem
