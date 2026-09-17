local this = class("words_narration_shell", G_BaseConfig)
local core = G_Tables.TDWordsNarrationTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  type = 1,
  content = 2,
  duration = 3,
  fadeInTime = 4,
  fadeOutTime = 5,
  writerInterval = 6,
  canSkip = 7,
  canClick = 8,
  disableInteract = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getContent(offset)
  local langStr = G_TableMgrIns:GetLangStr("words_narration", core:GetVString(offset, this.indexMap.content))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "content")
end

function this:_getDuration(offset)
  return core:GetFloat(offset, this.indexMap.duration)
end

function this:_getFadeintime(offset)
  return core:GetFloat(offset, this.indexMap.fadeInTime)
end

function this:_getFadeouttime(offset)
  return core:GetFloat(offset, this.indexMap.fadeOutTime)
end

function this:_getWriterinterval(offset)
  return core:GetFloat(offset, this.indexMap.writerInterval)
end

function this:_getCanskip(offset)
  return core:GetInt(offset, this.indexMap.canSkip)
end

function this:_getCanclick(offset)
  return core:GetInt(offset, this.indexMap.canClick)
end

function this:_getDisableinteract(offset)
  return core:GetInt(offset, this.indexMap.disableInteract)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  content = this._getContent,
  duration = this._getDuration,
  fadeInTime = this._getFadeintime,
  fadeOutTime = this._getFadeouttime,
  writerInterval = this._getWriterinterval,
  canSkip = this._getCanskip,
  canClick = this._getCanclick,
  disableInteract = this._getDisableinteract
}
return this
