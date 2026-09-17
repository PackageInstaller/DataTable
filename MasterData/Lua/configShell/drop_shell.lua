local this = class("drop_shell", G_BaseConfig)
local core = G_Tables.TDDropTable.GetInstance()

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
  dropId = 1,
  dropGroupId = 2,
  tacticsGroup = 3,
  weight = 4,
  tacticsWeight = 5,
  type = 6,
  itemId = 7,
  minValue = 8,
  maxValue = 9,
  tacticsValue = 10,
  allowanceValue = 11,
  param = 12,
  splitNum = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDropid(offset)
  return core:GetInt(offset, this.indexMap.dropId)
end

function this:_getDropgroupid(offset)
  return core:GetInt(offset, this.indexMap.dropGroupId)
end

function this:_getTacticsgroup(offset)
  return core:GetInt(offset, this.indexMap.tacticsGroup)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getTacticsweight(offset)
  return core:GetInt(offset, this.indexMap.tacticsWeight)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getItemid(offset)
  return core:GetInt(offset, this.indexMap.itemId)
end

function this:_getMinvalue(offset)
  return core:GetInt(offset, this.indexMap.minValue)
end

function this:_getMaxvalue(offset)
  return core:GetInt(offset, this.indexMap.maxValue)
end

function this:_getTacticsvalue(offset)
  return core:GetInt(offset, this.indexMap.tacticsValue)
end

function this:_getAllowancevalue(offset)
  return core:GetInt(offset, this.indexMap.allowanceValue)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSplitnum(offset)
  return core:GetInt(offset, this.indexMap.splitNum)
end

this.keyToMethodsMap = {
  id = this._getId,
  dropId = this._getDropid,
  dropGroupId = this._getDropgroupid,
  tacticsGroup = this._getTacticsgroup,
  weight = this._getWeight,
  tacticsWeight = this._getTacticsweight,
  type = this._getType,
  itemId = this._getItemid,
  minValue = this._getMinvalue,
  maxValue = this._getMaxvalue,
  tacticsValue = this._getTacticsvalue,
  allowanceValue = this._getAllowancevalue,
  param = this._getParam,
  splitNum = this._getSplitnum
}
return this
