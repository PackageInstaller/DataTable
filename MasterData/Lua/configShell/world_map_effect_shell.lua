local this = class("world_map_effect_shell", G_BaseConfig)
local core = G_Tables.TDWorldMapEffectTable.GetInstance()

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
  name = 1,
  position = 2,
  worldId = 3,
  openCondi = 4,
  closeCondi = 5,
  effect = 6,
  miniEffect = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_map_effect", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldid(offset)
  return core:GetInt(offset, this.indexMap.worldId)
end

function this:_getOpencondi(offset)
  local str = core:GetVString(offset, this.indexMap.openCondi).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getClosecondi(offset)
  local str = core:GetVString(offset, this.indexMap.closeCondi).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMinieffect(offset)
  local str = core:GetVString(offset, this.indexMap.miniEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  position = this._getPosition,
  worldId = this._getWorldid,
  openCondi = this._getOpencondi,
  closeCondi = this._getClosecondi,
  effect = this._getEffect,
  miniEffect = this._getMinieffect
}
return this
