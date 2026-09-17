local this = class("home_stage_shell", G_BaseConfig)
local core = G_Tables.TDHomeStageTable.GetInstance()

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
  unlockCondition = 1,
  objectId = 2,
  objectLayerName = 3,
  otherResource = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getObjectid(offset)
  local str = core:GetVString(offset, this.indexMap.objectId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getObjectlayername(offset)
  local str = core:GetVString(offset, this.indexMap.objectLayerName).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getOtherresource(offset)
  local str = core:GetVString(offset, this.indexMap.otherResource).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  unlockCondition = this._getUnlockcondition,
  objectId = this._getObjectid,
  objectLayerName = this._getObjectlayername,
  otherResource = this._getOtherresource
}
return this
