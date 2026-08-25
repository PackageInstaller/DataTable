local AvgCmdVideoFrame = System.NewClass("AvgCmdVideoFrame", AvgCmdBase)

function AvgCmdVideoFrame:Awake()
  self.cmdComp.avgModel:SetVideoAutoNext(true)
end

return AvgCmdVideoFrame
