local AVProVideoLiftTimeControl = NewClass("AVProVideoLiftTimeControl")

function AVProVideoLiftTimeControl:ctor(go)
  self.gameObject = go
end

function AVProVideoLiftTimeControl:SetVideoPlayer(videiPlayer)
  self.videiPlayer = videiPlayer
end

function AVProVideoLiftTimeControl:OnDestroy()
  if self.videiPlayer then
    self.videiPlayer:Dispose()
    self.videiPlayer = nil
  end
end

return AVProVideoLiftTimeControl
