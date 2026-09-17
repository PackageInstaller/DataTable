local this = class("tips_group_shell", G_BaseConfig)
local core = G_Tables.TDTipsGroupTable.GetInstance()

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
  groupId = 1,
  tips = 2,
  bgType = 3,
  bg = 4,
  material = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getTips(offset)
  local langStr = G_TableMgrIns:GetLangStr("tips_group", core:GetVString(offset, this.indexMap.tips))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tips")
end

function this:_getBgtype(offset)
  return core:GetInt(offset, this.indexMap.bgType)
end

function this:_getBg(offset)
  local str = core:GetVString(offset, this.indexMap.bg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMaterial(offset)
  return core:GetVString(offset, this.indexMap.material).value
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  tips = this._getTips,
  bgType = this._getBgtype,
  bg = this._getBg,
  material = this._getMaterial
}
return this
