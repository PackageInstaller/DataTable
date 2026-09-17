local this = class("pet_favorability_shell", G_BaseConfig)
local core = G_Tables.TDPetFavorabilityTable.GetInstance()

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
  level = 0,
  exp = 1,
  levelEffect = 2,
  desc = 3
}

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getLeveleffect(offset)
  return core:GetInt(offset, this.indexMap.levelEffect)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_favorability", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

this.keyToMethodsMap = {
  level = this._getLevel,
  exp = this._getExp,
  levelEffect = this._getLeveleffect,
  desc = this._getDesc
}
return this
