local this = class("chatMessage")

function this:ctor()
  self.player_id = nil
  self.msg = ""
  self.time = 0
  self.type = 0
  self.baseInfo = nil
  self.isMeeting = false
  self.bubbleConfigId = 0
  self.order = 0
end

return this
