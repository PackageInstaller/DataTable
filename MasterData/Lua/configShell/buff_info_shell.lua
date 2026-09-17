local this = class("buff_info_shell", G_BaseConfig)
local core = G_Tables.TDBuffInfoTable.GetInstance()

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
  desc = 2,
  type = 3,
  unitId = 4,
  tips = 5,
  tipsRange = 6,
  tipsCd = 7,
  attrIcon = 8,
  SpecialIcon = 9,
  stages = 10,
  times = 11,
  displaypriority = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("buff_info", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("buff_info", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getUnitid(offset)
  local str = core:GetVString(offset, this.indexMap.unitId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTips(offset)
  local langStr = G_TableMgrIns:GetLangStr("buff_info", core:GetVString(offset, this.indexMap.tips))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tips")
end

function this:_getTipsrange(offset)
  return core:GetFloat(offset, this.indexMap.tipsRange)
end

function this:_getTipscd(offset)
  return core:GetFloat(offset, this.indexMap.tipsCd)
end

function this:_getAttricon(offset)
  local str = core:GetVString(offset, this.indexMap.attrIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSpecialicon(offset)
  local str = core:GetVString(offset, this.indexMap.SpecialIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getStages(offset)
  return core:GetInt(offset, this.indexMap.stages)
end

function this:_getTimes(offset)
  return core:GetInt(offset, this.indexMap.times)
end

function this:_getDisplaypriority(offset)
  return core:GetInt(offset, this.indexMap.displaypriority)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  type = this._getType,
  unitId = this._getUnitid,
  tips = this._getTips,
  tipsRange = this._getTipsrange,
  tipsCd = this._getTipscd,
  attrIcon = this._getAttricon,
  SpecialIcon = this._getSpecialicon,
  stages = this._getStages,
  times = this._getTimes,
  displaypriority = this._getDisplaypriority
}
return this
