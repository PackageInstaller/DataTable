local this = class("home_dnatree_shell", G_BaseConfig)
local core = G_Tables.TDHomeDnatreeTable.GetInstance()

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
  treeType = 1,
  num = 2,
  treeOffset = 3,
  poolID = 4,
  harvestGold = 5,
  harvestPurple = 6,
  harvestOthers = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTreetype(offset)
  return core:GetInt(offset, this.indexMap.treeType)
end

function this:_getNum(offset)
  return core:GetInt(offset, this.indexMap.num)
end

function this:_getTreeoffset(offset)
  local str = core:GetVString(offset, this.indexMap.treeOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPoolid(offset)
  return core:GetInt(offset, this.indexMap.poolID)
end

function this:_getHarvestgold(offset)
  local str = core:GetVString(offset, this.indexMap.harvestGold).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHarvestpurple(offset)
  local str = core:GetVString(offset, this.indexMap.harvestPurple).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHarvestothers(offset)
  local str = core:GetVString(offset, this.indexMap.harvestOthers).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  treeType = this._getTreetype,
  num = this._getNum,
  treeOffset = this._getTreeoffset,
  poolID = this._getPoolid,
  harvestGold = this._getHarvestgold,
  harvestPurple = this._getHarvestpurple,
  harvestOthers = this._getHarvestothers
}
return this
