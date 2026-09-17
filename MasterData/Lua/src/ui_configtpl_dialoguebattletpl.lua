local this = class("dialogueBattleTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRank(tpl)
  return tpl.rank
end

function this:getSpeakerName(tpl)
  return L_Config:provider(tpl.speakerName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getVoice(tpl)
  return tpl.voice
end

function this:getContent(tpl)
  return L_Config:provider(tpl.content)
end

return this
