local AvgActionPrepareVideo = System.NewClass("AvgActionPrepareVideo", AvgActionBase)

function AvgActionPrepareVideo:DoAction(_, videoUrl, finishCb)
  self.avgPanel.avgVideoComp.prepareVideoUrl = videoUrl
  finishCb()
end

return AvgActionPrepareVideo
