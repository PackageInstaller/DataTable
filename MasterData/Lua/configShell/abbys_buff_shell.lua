local this = class("abbys_buff_shell", G_BaseConfig)
local core = G_Tables.TDAbbysBuffTable.GetInstance()

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
  simpleDesc1 = 2,
  simpleDesc2 = 3,
  icon = 4,
  buffid = 5,
  monsterbuffid = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("abbys_buff", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSimpledesc1(offset)
  local langStr = G_TableMgrIns:GetLangStr("abbys_buff", core:GetVString(offset, this.indexMap.simpleDesc1))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "simpleDesc1")
end

function this:_getSimpledesc2(offset)
  local langStr = G_TableMgrIns:GetLangStr("abbys_buff", core:GetVString(offset, this.indexMap.simpleDesc2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "simpleDesc2")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffid)
end

function this:_getMonsterbuffid(offset)
  return core:GetInt(offset, this.indexMap.monsterbuffid)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  simpleDesc1 = this._getSimpledesc1,
  simpleDesc2 = this._getSimpledesc2,
  icon = this._getIcon,
  buffid = this._getBuffid,
  monsterbuffid = this._getMonsterbuffid
}
return this
