local this = class("game_events_kibo_tour_group_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsKiboTourGroupTable.GetInstance()

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
  Id = 0,
  name = 1,
  desc = 2,
  icon = 3,
  element = 4,
  reward = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_tour_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_tour_group", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getElement(offset)
  local str = core:GetVString(offset, this.indexMap.element).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  icon = this._getIcon,
  element = this._getElement,
  reward = this._getReward
}
return this
