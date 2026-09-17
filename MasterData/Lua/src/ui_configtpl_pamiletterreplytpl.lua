local this = class("pamiLetterReplyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSign(tpl)
  return tpl.sign
end

function this:getText(tpl)
  return tpl.text
end

function this:getRecipient(tpl)
  return tpl.recipient
end

function this:getTeamId(tpl)
  return tpl.teamId
end

function this:getChoiceTitle(tpl)
  return tpl.choiceTitle
end

function this:getPic(tpl)
  return tpl.pic
end

function this:getId(tpl)
  return tpl.id
end

function this:getTextId(tpl)
  return tpl.textId
end

return this
