local DBGDailyChallengeScore, Super = System.NewComponent("DBGDailyChallengeScore")

function DBGDailyChallengeScore:ctor(uiNode, info)
  Super.ctor(self)
  self.ui = UI_Dungeous_Item_StatisticsResource(uiNode)
  self.info = info
end

function DBGDailyChallengeScore:OnBind(binder)
  binder:SetText(self.ui.Text_Introduce, self.info.desc)
  if self.info.score >= 0 then
    binder:SetText(self.ui.Text_Value, "+" .. self.info.score)
  else
    binder:SetText(self.ui.Text_Value, self.info.score)
  end
end

return DBGDailyChallengeScore
