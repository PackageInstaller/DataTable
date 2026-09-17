local this = class("game_events_cul_train_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulTrainTable.GetInstance()

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
  trainOption = 1,
  name = 2,
  icon = 3,
  amb = 4,
  trainLevel = 5,
  systemId = 6,
  needEXP = 7,
  addTrainAttr = 8,
  costStamina = 9,
  addEXP = 10,
  addBond = 11,
  addBondkibo = 12,
  cost = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getTrainoption(offset)
  return core:GetInt(offset, this.indexMap.trainOption)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_train", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAmb(offset)
  return core:GetVString(offset, this.indexMap.amb).value
end

function this:_getTrainlevel(offset)
  return core:GetInt(offset, this.indexMap.trainLevel)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getNeedexp(offset)
  return core:GetInt(offset, this.indexMap.needEXP)
end

function this:_getAddtrainattr(offset)
  local str = core:GetVString(offset, this.indexMap.addTrainAttr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCoststamina(offset)
  return core:GetInt(offset, this.indexMap.costStamina)
end

function this:_getAddexp(offset)
  return core:GetInt(offset, this.indexMap.addEXP)
end

function this:_getAddbond(offset)
  return core:GetInt(offset, this.indexMap.addBond)
end

function this:_getAddbondkibo(offset)
  local str = core:GetVString(offset, this.indexMap.addBondkibo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCost(offset)
  return core:GetInt(offset, this.indexMap.cost)
end

this.keyToMethodsMap = {
  Id = this._getId,
  trainOption = this._getTrainoption,
  name = this._getName,
  icon = this._getIcon,
  amb = this._getAmb,
  trainLevel = this._getTrainlevel,
  systemId = this._getSystemid,
  needEXP = this._getNeedexp,
  addTrainAttr = this._getAddtrainattr,
  costStamina = this._getCoststamina,
  addEXP = this._getAddexp,
  addBond = this._getAddbond,
  addBondkibo = this._getAddbondkibo,
  cost = this._getCost
}
return this
