local this = {}

function this:isInPhoto()
  return self.mediator ~= nil
end

function this:enterPhoto()
  self.mediator = require("ui.manager.photo.photoMediator").new()
  return self.mediator
end

function this:getMediator()
  return self.mediator
end

function this:exitPhoto()
  self:resetWorldState()
  self.mediator:onDestroy()
  self.mediator = nil
  self:releasePendingCaptureRTs()
end

function this:initRecording()
end

function this:enterPhotoTemplate()
end

function this:exitPhotoTemplate()
end

function this:setMediatorTarget(entity)
  if self.mediator then
    self.mediator.target = entity
  end
end

return this
