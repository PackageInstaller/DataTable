local AvgCmdPlayFastCaption = System.NewClass("AvgCmdPlayFastCaption", AvgCmdBase)

function AvgCmdPlayFastCaption:Awake()
  self.cmdComp.avgModel:SetCaptionAnim(CommonDefine.AvgCaptionAnim.Fast)
end

return AvgCmdPlayFastCaption
