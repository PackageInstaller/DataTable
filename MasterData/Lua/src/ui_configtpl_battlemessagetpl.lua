local this = class("battleMessageTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMessage(tpl)
  return L_Config:provider(tpl.message)
end

function this:getAudioEvent(tpl)
  return tpl.audioEvent
end

function this:getMessageType(tpl)
  return tpl.messageType
end

function this:getMessageTime(tpl)
  return tpl.messageTime
end

function this:getCharacter(tpl)
  return tpl.character
end

function this:getId(tpl)
  return tpl.id
end

function this:getCharacterType(tpl)
  return tpl.characterType
end

function this:getIconType(tpl)
  local iconType = L_Config:getPathByHash(tpl.iconType)
  return iconType
end

function this:getDialogueId(tpl)
  return tpl.dialogueId
end

return this
