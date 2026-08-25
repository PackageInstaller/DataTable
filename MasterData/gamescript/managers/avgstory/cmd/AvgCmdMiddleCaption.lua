local AvgCmdPlayMiddleCaption = System.NewClass("AvgCmdPlayMiddleCaption", AvgCmdBase)

function AvgCmdPlayMiddleCaption:Awake()
  self.cmdComp.avgModel:SetCaptionAnim(CommonDefine.AvgCaptionAnim.Middle)
end

return AvgCmdPlayMiddleCaption
