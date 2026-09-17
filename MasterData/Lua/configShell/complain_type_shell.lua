local this = class("complain_type_shell", G_BaseConfig)
local core = G_Tables.TDComplainTypeTable.GetInstance()

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
  reportEntryID = 1,
  isShow = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getReportentryid(offset)
  local str = core:GetVString(offset, this.indexMap.reportEntryID).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsshow(offset)
  return core:GetBool(offset, this.indexMap.isShow)
end

this.keyToMethodsMap = {
  id = this._getId,
  reportEntryID = this._getReportentryid,
  isShow = this._getIsshow
}
return this
