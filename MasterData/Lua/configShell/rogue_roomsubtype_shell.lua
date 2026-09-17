local this = class("rogue_roomsubtype_shell", G_BaseConfig)
local core = G_Tables.TDRogueRoomsubtypeTable.GetInstance()

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
  Id = 0,
  Name = 1,
  type = 2,
  secondtype = 3,
  littleicon = 4,
  roadsubicon = 5,
  transtitlebg = 6,
  transspawnerid = 7,
  PixelIcon = 8,
  PixelIconDev = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_roomsubtype", core:GetVString(offset, this.indexMap.Name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getSecondtype(offset)
  return core:GetInt(offset, this.indexMap.secondtype)
end

function this:_getLittleicon(offset)
  local str = core:GetVString(offset, this.indexMap.littleicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRoadsubicon(offset)
  local str = core:GetVString(offset, this.indexMap.roadsubicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTranstitlebg(offset)
  local str = core:GetVString(offset, this.indexMap.transtitlebg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTransspawnerid(offset)
  return core:GetInt(offset, this.indexMap.transspawnerid)
end

function this:_getPixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.PixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPixelicondev(offset)
  local str = core:GetVString(offset, this.indexMap.PixelIconDev).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  Name = this._getName,
  type = this._getType,
  secondtype = this._getSecondtype,
  littleicon = this._getLittleicon,
  roadsubicon = this._getRoadsubicon,
  transtitlebg = this._getTranstitlebg,
  transspawnerid = this._getTransspawnerid,
  PixelIcon = this._getPixelicon,
  PixelIconDev = this._getPixelicondev
}
return this
