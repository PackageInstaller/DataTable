local this = class("enemy_mark_shell", G_BaseConfig)
local core = G_Tables.TDEnemyMarkTable.GetInstance()

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
  displaymode = 1,
  normalmarkParameter = 2,
  normalnamemarkcolor = 3,
  normallvmarkcolor = 4,
  hardmarkParameter = 5,
  hardnamemarkcolor = 6,
  hardlvmarkcolor = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDisplaymode(offset)
  return core:GetInt(offset, this.indexMap.displaymode)
end

function this:_getNormalmarkparameter(offset)
  local str = core:GetVString(offset, this.indexMap.normalmarkParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNormalnamemarkcolor(offset)
  return core:GetVString(offset, this.indexMap.normalnamemarkcolor).value
end

function this:_getNormallvmarkcolor(offset)
  return core:GetVString(offset, this.indexMap.normallvmarkcolor).value
end

function this:_getHardmarkparameter(offset)
  local str = core:GetVString(offset, this.indexMap.hardmarkParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHardnamemarkcolor(offset)
  return core:GetVString(offset, this.indexMap.hardnamemarkcolor).value
end

function this:_getHardlvmarkcolor(offset)
  return core:GetVString(offset, this.indexMap.hardlvmarkcolor).value
end

this.keyToMethodsMap = {
  id = this._getId,
  displaymode = this._getDisplaymode,
  normalmarkParameter = this._getNormalmarkparameter,
  normalnamemarkcolor = this._getNormalnamemarkcolor,
  normallvmarkcolor = this._getNormallvmarkcolor,
  hardmarkParameter = this._getHardmarkparameter,
  hardnamemarkcolor = this._getHardnamemarkcolor,
  hardlvmarkcolor = this._getHardlvmarkcolor
}
return this
