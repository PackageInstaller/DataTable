local AvgCmdVideoLoop = System.NewClass("AvgCmdVideoLoop", AvgCmdBase)

function AvgCmdVideoLoop:Awake()
  local videoUrl = self.params[1]
  local videoTimeA = tonumber(self.params[2])
  local videoTimeB = tonumber(self.params[3])
  local captionId = tonumber(self.params[4])
  local isLoop = true
  self.cmdComp.avgModel:SetVideo(videoUrl, videoTimeA, videoTimeB, captionId, isLoop)
  self.cmdComp.avgModel:SetVideoType(CommonDefine.AvgVideoType.VideoLoop)
end

return AvgCmdVideoLoop
