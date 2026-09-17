local this = class("world_area_unit_define_shell", G_BaseConfig)
local core = G_Tables.TDWorldAreaUnitDefineTable.GetInstance()

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
  sceneId = 1,
  isTemplate = 2,
  useTemplateId = 3,
  gamePlayTagCondt = 4,
  autoCreate = 5,
  triggerActionId = 6,
  type = 7,
  height = 8,
  areaPos = 9,
  vertices = 10,
  checkPriority = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getIstemplate(offset)
  return core:GetInt(offset, this.indexMap.isTemplate)
end

function this:_getUsetemplateid(offset)
  return core:GetInt(offset, this.indexMap.useTemplateId)
end

function this:_getGameplaytagcondt(offset)
  local str = core:GetVString(offset, this.indexMap.gamePlayTagCondt).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getAutocreate(offset)
  return core:GetInt(offset, this.indexMap.autoCreate)
end

function this:_getTriggeractionid(offset)
  return core:GetInt(offset, this.indexMap.triggerActionId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getHeight(offset)
  return core:GetFloat(offset, this.indexMap.height)
end

function this:_getAreapos(offset)
  local str = core:GetVString(offset, this.indexMap.areaPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getVertices(offset)
  local str = core:GetVString(offset, this.indexMap.vertices).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCheckpriority(offset)
  return core:GetInt(offset, this.indexMap.checkPriority)
end

this.keyToMethodsMap = {
  id = this._getId,
  sceneId = this._getSceneid,
  isTemplate = this._getIstemplate,
  useTemplateId = this._getUsetemplateid,
  gamePlayTagCondt = this._getGameplaytagcondt,
  autoCreate = this._getAutocreate,
  triggerActionId = this._getTriggeractionid,
  type = this._getType,
  height = this._getHeight,
  areaPos = this._getAreapos,
  vertices = this._getVertices,
  checkPriority = this._getCheckpriority
}
return this
