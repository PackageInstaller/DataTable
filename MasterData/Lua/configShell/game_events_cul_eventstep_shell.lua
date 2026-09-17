local this = class("game_events_cul_eventstep_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulEventstepTable.GetInstance()

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
  systemId = 1,
  step = 2,
  nextStep = 3,
  isFirstStep = 4,
  character = 5,
  text = 6,
  option = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getStep(offset)
  return core:GetInt(offset, this.indexMap.step)
end

function this:_getNextstep(offset)
  return core:GetInt(offset, this.indexMap.nextStep)
end

function this:_getIsfirststep(offset)
  return core:GetInt(offset, this.indexMap.isFirstStep)
end

function this:_getCharacter(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_eventstep", core:GetVString(offset, this.indexMap.character))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "character")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_eventstep", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getOption(offset)
  local str = core:GetVString(offset, this.indexMap.option).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  systemId = this._getSystemid,
  step = this._getStep,
  nextStep = this._getNextstep,
  isFirstStep = this._getIsfirststep,
  character = this._getCharacter,
  text = this._getText,
  option = this._getOption
}
return this
