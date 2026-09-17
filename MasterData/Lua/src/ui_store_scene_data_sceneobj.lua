local this = class("sceneObj")

function this:ctor(id)
  self.id = id
  self.done_step = nil
  self.done_step_index = nil
  self.curStep = nil
  self.count = nil
  self.status = nil
  self.trigger_time = nil
  self.reset_time = nil
  self.receive_num = nil
  self.finishStep = nil
  self.isInRange = nil
end

return this
