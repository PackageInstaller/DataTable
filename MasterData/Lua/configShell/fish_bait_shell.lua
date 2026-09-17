local this = class("fish_bait_shell", G_BaseConfig)
local core = G_Tables.TDFishBaitTable.GetInstance()

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
  fishRodName = 1,
  rarity = 2,
  iconMain = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFishrodname(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_bait", core:GetVString(offset, this.indexMap.fishRodName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fishRodName")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getIconmain(offset)
  local str = core:GetVString(offset, this.indexMap.iconMain).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  fishRodName = this._getFishrodname,
  rarity = this._getRarity,
  iconMain = this._getIconmain
}
return this
