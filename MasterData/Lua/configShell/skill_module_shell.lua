local this = class("skill_module_shell", G_BaseConfig)
local core = G_Tables.TDSkillModuleTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, moduleTags = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getModuletags(offset)
  local str = core:GetVString(offset, this.indexMap.moduleTags).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  moduleTags = this._getModuletags
}
return this
