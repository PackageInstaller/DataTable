local this = class("world_eep_shell", G_BaseConfig)
local core = G_Tables.TDWorldEepTable.GetInstance()

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
  group = 1,
  worldMapID = 2,
  position = 3,
  rotation = 4,
  cd = 5,
  repeatLimit = 6,
  templateList = 7,
  overridePosition = 8,
  overrideTriggerParam = 9,
  overrideFilterRules = 10,
  targetGroupId = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldMapID)
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRotation(offset)
  local str = core:GetVString(offset, this.indexMap.rotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCd(offset)
  return core:GetInt(offset, this.indexMap.cd)
end

function this:_getRepeatlimit(offset)
  return core:GetInt(offset, this.indexMap.repeatLimit)
end

function this:_getTemplatelist(offset)
  local str = core:GetVString(offset, this.indexMap.templateList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOverrideposition(offset)
  local str = core:GetVString(offset, this.indexMap.overridePosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOverridetriggerparam(offset)
  return core:GetVString(offset, this.indexMap.overrideTriggerParam).value
end

function this:_getOverridefilterrules(offset)
  return core:GetVString(offset, this.indexMap.overrideFilterRules).value
end

function this:_getTargetgroupid(offset)
  local str = core:GetVString(offset, this.indexMap.targetGroupId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  worldMapID = this._getWorldmapid,
  position = this._getPosition,
  rotation = this._getRotation,
  cd = this._getCd,
  repeatLimit = this._getRepeatlimit,
  templateList = this._getTemplatelist,
  overridePosition = this._getOverrideposition,
  overrideTriggerParam = this._getOverridetriggerparam,
  overrideFilterRules = this._getOverridefilterrules,
  targetGroupId = this._getTargetgroupid
}
return this
