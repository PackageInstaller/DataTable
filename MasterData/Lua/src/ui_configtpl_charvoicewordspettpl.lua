local this = class("charVoiceWordsPetTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIntoBattle(tpl)
  return tpl.IntoBattle
end

function this:getAceReady(tpl)
  return tpl.AceReady
end

function this:getDying(tpl)
  return tpl.Dying
end

function this:getResponseBreak(tpl)
  return tpl.ResponseBreak
end

function this:getPuzzleTalk(tpl)
  return tpl.PuzzleTalk
end

function this:getInDanger(tpl)
  return tpl.InDanger
end

function this:getResponseLowHP(tpl)
  return tpl.ResponseLowHP
end

function this:getPuzzleElement(tpl)
  return tpl.PuzzleElement
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getPassiveSkill(tpl)
  return tpl.PassiveSkill
end

function this:getResponseSkill(tpl)
  return tpl.ResponseSkill
end

function this:getId(tpl)
  return tpl.id
end

function this:getTagValue(tpl, tag)
  return L_Config:provider(tpl[tag])
end

return this
