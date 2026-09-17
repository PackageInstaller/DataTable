local this = class("home_building_buff_world_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingBuffWorldTable.GetInstance()

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
  level = 1,
  groupId = 2,
  name = 3,
  buffCondition = 4,
  buffConditionLogic = 5,
  buffParams = 6,
  buffId = 7,
  upgradeDesc = 8,
  upgradeCondition = 9,
  technologyExp = 10,
  material = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_buff_world", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getBuffcondition(offset)
  local str = core:GetVString(offset, this.indexMap.buffCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffconditionlogic(offset)
  return core:GetInt(offset, this.indexMap.buffConditionLogic)
end

function this:_getBuffparams(offset)
  local str = core:GetVString(offset, this.indexMap.buffParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuffid(offset)
  local str = core:GetVString(offset, this.indexMap.buffId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUpgradedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_building_buff_world", core:GetVString(offset, this.indexMap.upgradeDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_building_buff_world")
end

function this:_getUpgradecondition(offset)
  local str = core:GetVString(offset, this.indexMap.upgradeCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  groupId = this._getGroupid,
  name = this._getName,
  buffCondition = this._getBuffcondition,
  buffConditionLogic = this._getBuffconditionlogic,
  buffParams = this._getBuffparams,
  buffId = this._getBuffid,
  upgradeDesc = this._getUpgradedesc,
  upgradeCondition = this._getUpgradecondition,
  technologyExp = this._getTechnologyexp,
  material = this._getMaterial
}
return this
