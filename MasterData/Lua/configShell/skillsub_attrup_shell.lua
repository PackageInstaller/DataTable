local this = class("skillsub_attrup_shell", G_BaseConfig)
local core = G_Tables.TDSkillsubAttrupTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, attributeList = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAttributelist(offset)
  local str = core:GetVString(offset, this.indexMap.attributeList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  attributeList = this._getAttributelist
}
return this
