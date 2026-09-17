local this = class("pamiLetterTextTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSign(tpl)
  return tpl.sign
end

function this:getTeamId(tpl)
  return tpl.teamId
end

function this:getId(tpl)
  return tpl.id
end

function this:getLetterId(tpl)
  return tpl.letterId
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getText(tpl)
  return tpl.text
end

function this:getRecipient(tpl)
  return tpl.recipient
end

function this:getPic(tpl)
  return tpl.pic
end

function this:getTime(tpl)
  return tpl.time
end

function this:getVoice(tpl)
  return tpl.voice
end

function this:getFirstId(tpl)
  return tpl.firstId
end

return this
