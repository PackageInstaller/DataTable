local this = class("explore_map_group_shell", G_BaseConfig)
local core = G_Tables.TDExploreMapGroupTable.GetInstance()

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
  exploreGroupName = 1,
  mapId = 2,
  reward = 3,
  levelMax = 4,
  prefabSetting = 5,
  panelDesc = 6,
  scanDesc = 7,
  prefabSettingLocation = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getExploregroupname(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore_map_group", core:GetVString(offset, this.indexMap.exploreGroupName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "exploreGroupName")
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapId)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLevelmax(offset)
  return core:GetInt(offset, this.indexMap.levelMax)
end

function this:_getPrefabsetting(offset)
  local str = core:GetVString(offset, this.indexMap.prefabSetting).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPaneldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore_map_group", core:GetVString(offset, this.indexMap.panelDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "panelDesc")
end

function this:_getScandesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore_map_group", core:GetVString(offset, this.indexMap.scanDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "scanDesc")
end

function this:_getPrefabsettinglocation(offset)
  local str = core:GetVString(offset, this.indexMap.prefabSettingLocation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  exploreGroupName = this._getExploregroupname,
  mapId = this._getMapid,
  reward = this._getReward,
  levelMax = this._getLevelmax,
  prefabSetting = this._getPrefabsetting,
  panelDesc = this._getPaneldesc,
  scanDesc = this._getScandesc,
  prefabSettingLocation = this._getPrefabsettinglocation
}
return this
