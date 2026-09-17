local this = class("nestcoop_shop_show_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopShopShowTable.GetInstance()

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
  shopGroupId = 1,
  uiperform = 2,
  heroid = 3,
  shoptimeline = 4,
  shopUibackground = 5,
  shopTimelinePos = 6,
  shopTimelineRot = 7,
  shopCharacterPos = 8,
  shopCharacterRot = 9,
  shopvoice = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getShopgroupid(offset)
  return core:GetInt(offset, this.indexMap.shopGroupId)
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

function this:_getShopvoice(offset)
  local str = core:GetVString(offset, this.indexMap.shopvoice).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  shopGroupId = this._getShopgroupid,
  uiperform = this._getUiperform,
  heroid = this._getHeroid,
  shoptimeline = this._getShoptimeline,
  shopUibackground = this._getShopuibackground,
  shopTimelinePos = this._getShoptimelinepos,
  shopTimelineRot = this._getShoptimelinerot,
  shopCharacterPos = this._getShopcharacterpos,
  shopCharacterRot = this._getShopcharacterrot,
  shopvoice = this._getShopvoice
}
return this
