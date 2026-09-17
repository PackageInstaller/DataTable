local this = class("pose_shell", G_BaseConfig)
local core = G_Tables.TDPoseTable.GetInstance()

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
  multiaction = 3,
  multiactionposition = 4,
  animname = 5,
  texture = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pose", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getMultiaction(offset)
  return core:GetInt(offset, this.indexMap.multiaction)
end

function this:_getMultiactionposition(offset)
  local str = core:GetVString(offset, this.indexMap.multiactionposition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
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
  multiaction = this._getMultiaction,
  multiactionposition = this._getMultiactionposition,
  animname = this._getAnimname,
  texture = this._getTexture
}
return this
