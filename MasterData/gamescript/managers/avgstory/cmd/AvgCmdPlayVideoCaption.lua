local AvgCmdPlayVideoCaption = System.NewClass("AvgCmdPlayFastCaption", AvgCmdBase)

function AvgCmdPlayVideoCaption:Awake()
  local captionTid = tonumber(self.params[1])
  UIManager.Instance:Reopen(Urls.VideoCaptionPanel, captionTid)
end

return AvgCmdPlayVideoCaption
