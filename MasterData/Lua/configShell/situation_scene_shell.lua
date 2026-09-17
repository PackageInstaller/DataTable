local this = class("situation_scene_shell", G_BaseConfig)
local core = G_Tables.TDSituationSceneTable.GetInstance()

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
  scenesName = 1,
  SceneResource = 2,
  SceneIcon = 3,
  unlock = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getScenesname(offset)
  local langStr = G_TableMgrIns:GetLangStr("situation_scene", core:GetVString(offset, this.indexMap.scenesName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "scenesName")
end

function this:_getSceneresource(offset)
  return core:GetVString(offset, this.indexMap.SceneResource).value
end

function this:_getSceneicon(offset)
  local str = core:GetVString(offset, this.indexMap.SceneIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  scenesName = this._getScenesname,
  SceneResource = this._getSceneresource,
  SceneIcon = this._getSceneicon,
  unlock = this._getUnlock
}
return this
