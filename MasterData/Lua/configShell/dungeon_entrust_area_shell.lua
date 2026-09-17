local this = class("dungeon_entrust_area_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustAreaTable.GetInstance()

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
  areascope = 1,
  uiperform = 2,
  heroid = 3,
  shoptimeline = 4,
  timelinegather = 5,
  shopUibackground = 6,
  shopTimelinePos = 7,
  shopTimelineRot = 8,
  shopCharacterPos = 9,
  shopCharacterRot = 10,
  heroposition = 11,
  herorotation = 12,
  uibackground = 13,
  shopvoice = 14,
  voice = 15,
  basebackground = 16,
  permanententranceType = 17,
  permanententrance = 18,
  uiShowTime = 19,
  uiQuitTime = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAreascope(offset)
  local str = core:GetVString(offset, this.indexMap.areascope).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUiperform(offset)
  local str = core:GetVString(offset, this.indexMap.uiperform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroid)
end

function this:_getShoptimeline(offset)
  local str = core:GetVString(offset, this.indexMap.shoptimeline).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getTimelinegather(offset)
  local str = core:GetVString(offset, this.indexMap.timelinegather).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getShopuibackground(offset)
  local str = core:GetVString(offset, this.indexMap.shopUibackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShoptimelinepos(offset)
  local str = core:GetVString(offset, this.indexMap.shopTimelinePos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShoptimelinerot(offset)
  local str = core:GetVString(offset, this.indexMap.shopTimelineRot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShopcharacterpos(offset)
  local str = core:GetVString(offset, this.indexMap.shopCharacterPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShopcharacterrot(offset)
  local str = core:GetVString(offset, this.indexMap.shopCharacterRot).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHeroposition(offset)
  local str = core:GetVString(offset, this.indexMap.heroposition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHerorotation(offset)
  local str = core:GetVString(offset, this.indexMap.herorotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUibackground(offset)
  local str = core:GetVString(offset, this.indexMap.uibackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShopvoice(offset)
  local str = core:GetVString(offset, this.indexMap.shopvoice).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getVoice(offset)
  local str = core:GetVString(offset, this.indexMap.voice).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

function this:_getBasebackground(offset)
  local str = core:GetVString(offset, this.indexMap.basebackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 7)
end

function this:_getPermanententrancetype(offset)
  local str = core:GetVString(offset, this.indexMap.permanententranceType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPermanententrance(offset)
  local str = core:GetVString(offset, this.indexMap.permanententrance).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUishowtime(offset)
  return core:GetInt(offset, this.indexMap.uiShowTime)
end

function this:_getUiquittime(offset)
  return core:GetInt(offset, this.indexMap.uiQuitTime)
end

this.keyToMethodsMap = {
  id = this._getId,
  areascope = this._getAreascope,
  uiperform = this._getUiperform,
  heroid = this._getHeroid,
  shoptimeline = this._getShoptimeline,
  timelinegather = this._getTimelinegather,
  shopUibackground = this._getShopuibackground,
  shopTimelinePos = this._getShoptimelinepos,
  shopTimelineRot = this._getShoptimelinerot,
  shopCharacterPos = this._getShopcharacterpos,
  shopCharacterRot = this._getShopcharacterrot,
  heroposition = this._getHeroposition,
  herorotation = this._getHerorotation,
  uibackground = this._getUibackground,
  shopvoice = this._getShopvoice,
  voice = this._getVoice,
  basebackground = this._getBasebackground,
  permanententranceType = this._getPermanententrancetype,
  permanententrance = this._getPermanententrance,
  uiShowTime = this._getUishowtime,
  uiQuitTime = this._getUiquittime
}
return this
