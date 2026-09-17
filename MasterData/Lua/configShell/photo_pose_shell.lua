local this = class("photo_pose_shell", G_BaseConfig)
local core = G_Tables.TDPhotoPoseTable.GetInstance()

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
  type = 2,
  moreType = 3,
  animname = 4,
  texture = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("photo_pose", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getMoretype(offset)
  return core:GetInt(offset, this.indexMap.moreType)
end

function this:_getAnimname(offset)
  return core:GetVString(offset, this.indexMap.animname).value
end

function this:_getTexture(offset)
  local str = core:GetVString(offset, this.indexMap.texture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  type = this._getType,
  moreType = this._getMoretype,
  animname = this._getAnimname,
  texture = this._getTexture
}
return this
