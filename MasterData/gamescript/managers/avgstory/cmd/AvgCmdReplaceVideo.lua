local AvgCmdReplaceVideo = System.NewClass("AvgCmdReplaceVideo", AvgCmdBase)

function AvgCmdReplaceVideo:Awake()
  local gender = self.params[1]
  local video = self.params[2]
  if PlayerDataUtils.GetGenderStr() == gender then
    self.cmdComp.avgModel:SetVideo(video)
  end
end

return AvgCmdReplaceVideo
