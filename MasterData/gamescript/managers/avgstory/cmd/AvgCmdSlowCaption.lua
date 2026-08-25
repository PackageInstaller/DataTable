local AvgCmdPlaySlowCaption = System.NewClass("AvgCmdPlaySlowCaption", AvgCmdBase)

function AvgCmdPlaySlowCaption:Awake()
  self.cmdComp.avgModel:SetCaptionAnim(CommonDefine.AvgCaptionAnim.Slow)
end

return AvgCmdPlaySlowCaption
