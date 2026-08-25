local AvgCmdVideoFrame = System.NewClass("AvgCmdVideoFrame", AvgCmdBase)

function AvgCmdVideoFrame:Awake()
  local videoUrl = self.params[1]
  local videoTimeA = tonumber(self.params[2])
  local videoTimeB = tonumber(self.params[3]) or videoTimeA
  local caption = tonumber(self.params[4])
  self.cmdComp.avgModel:SetVideo(videoUrl, videoTimeA, videoTimeB, caption)
  local videoType = CommonDefine.AvgVideoType.VideoFramePlay
  if videoTimeA == videoTimeB then
    videoType = CommonDefine.AvgVideoType.VideoFramePause
  end
  self.cmdComp.avgModel:SetVideoType(videoType)
end

return AvgCmdVideoFrame
