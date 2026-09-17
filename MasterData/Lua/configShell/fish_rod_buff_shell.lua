local this = class("fish_rod_buff_shell", G_BaseConfig)
local core = G_Tables.TDFishRodBuffTable.GetInstance()

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
  icon = 1,
  desc = 2,
  pondId = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_rod_buff", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getPondid(offset)
  local str = core:GetVString(offset, this.indexMap.pondId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  icon = this._getIcon,
  desc = this._getDesc,
  pondId = this._getPondid
}
return this
