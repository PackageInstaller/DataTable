local AvgActionSetBg = System.NewClass("AvgActionSetBg", AvgActionBase)

function AvgActionSetBg:DoAction(_, _)
  self.avgPanel.bgComp:SetBg()
  self:FinishAction()
end

return AvgActionSetBg
