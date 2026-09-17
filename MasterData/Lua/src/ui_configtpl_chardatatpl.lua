local this = class("charDataTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getCharacterRace(tpl)
  return tpl.characterRace
end

function this:getCharacterVoice(tpl)
  return tpl.characterVoice
end

function this:getCharacterName(tpl)
  return L_Config:provider(tpl.characterName)
end

function this:getCharacterNation(tpl)
  return tpl.characterGroup
end

function this:getCharacterStory(tpl)
  return tpl.characterStory
end

function this:getIntroduction(tpl)
  return L_Config:provider(tpl.introduction)
end

function this:getCharacterBirthday(tpl)
  return L_Config:provider(tpl.characterBirthday)
end

function this:getCvName(tpl)
  return L_Config:provider(tpl.cvName)
end

return this
