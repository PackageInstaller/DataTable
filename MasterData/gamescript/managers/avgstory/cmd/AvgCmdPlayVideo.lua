local AvgCmdPlayVideo = System.NewClass("AvgCmdPlayVideo", AvgCmdBase)

function AvgCmdPlayVideo:Awake()
  local videoUrl = self.params[1]
  local videoTimeA = tonumber(CommonDefine.AvgVideoStartTime)
  local videoTimeB = tonumber(CommonDefine.AvgVideoEndTime)
  local caption = tonumber(self.params[2])
  local isLoop = tonumber(self.params[3]) == cd.NumberTrue
  self.cmdComp.avgModel:SetVideo(videoUrl, videoTimeA, videoTimeB, caption, isLoop)
  self.cmdComp.avgModel:SetVideoType(CommonDefine.AvgVideoType.VideoPure)
end

return AvgCmdPlayVideo
