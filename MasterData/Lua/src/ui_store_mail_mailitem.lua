local this = class("mailItem")

function this:ctor()
  self.fetch = false
  self.sender_id = 0
  self.content = 0
  self.title = ""
  self.effecttm = 0
  self.template_id = 0
  self.reward = {}
  self.createtm = 0
  self.guid = 0
  self.read = false
  self.collect = false
  self.argsDict = {}
end

return this
