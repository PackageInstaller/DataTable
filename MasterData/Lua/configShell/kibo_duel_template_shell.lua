local this = class("kibo_duel_template_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelTemplateTable.GetInstance()

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
  kiboBaseAttribute = 1,
  toweratk = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKibobaseattribute(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBaseAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getToweratk(offset)
  return core:GetFloat(offset, this.indexMap.toweratk)
end

this.keyToMethodsMap = {
  id = this._getId,
  kiboBaseAttribute = this._getKibobaseattribute,
  toweratk = this._getToweratk
}
return this
