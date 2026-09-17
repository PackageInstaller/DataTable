local this = class("home_block_shell", G_BaseConfig)
local core = G_Tables.TDHomeBlockTable.GetInstance()

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
  name = 1,
  groupType = 2,
  level = 3,
  sequence = 4,
  desc = 5,
  icon = 6,
  worldmapId = 7,
  blockType = 8,
  unlockCondi = 9,
  fieldType = 10,
  blockStartPos = 11,
  blockEndPos = 12,
  buildingBlockSize = 13,
  grassAsset = 14,
  boxPosition = 15,
  petPlantPos = 16,
  petWaterPos = 17,
  petHarvestPos = 18,
  blockLens = 19
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_block", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getGrouptype(offset)
  return core:GetInt(offset, this.indexMap.groupType)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getSequence(offset)
  return core:GetInt(offset, this.indexMap.sequence)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_block", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldmapId)
end

function this:_getBlocktype(offset)
  return core:GetInt(offset, this.indexMap.blockType)
end

function this:_getUnlockcondi(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondi).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFieldtype(offset)
  return core:GetInt(offset, this.indexMap.fieldType)
end

function this:_getBlockstartpos(offset)
  local str = core:GetVString(offset, this.indexMap.blockStartPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBlockendpos(offset)
  local str = core:GetVString(offset, this.indexMap.blockEndPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBuildingblocksize(offset)
  local str = core:GetVString(offset, this.indexMap.buildingBlockSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGrassasset(offset)
  local str = core:GetVString(offset, this.indexMap.grassAsset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBoxposition(offset)
  local str = core:GetVString(offset, this.indexMap.boxPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetplantpos(offset)
  local str = core:GetVString(offset, this.indexMap.petPlantPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetwaterpos(offset)
  local str = core:GetVString(offset, this.indexMap.petWaterPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetharvestpos(offset)
  local str = core:GetVString(offset, this.indexMap.petHarvestPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBlocklens(offset)
  local str = core:GetVString(offset, this.indexMap.blockLens).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  groupType = this._getGrouptype,
  level = this._getLevel,
  sequence = this._getSequence,
  desc = this._getDesc,
  icon = this._getIcon,
  worldmapId = this._getWorldmapid,
  blockType = this._getBlocktype,
  unlockCondi = this._getUnlockcondi,
  fieldType = this._getFieldtype,
  blockStartPos = this._getBlockstartpos,
  blockEndPos = this._getBlockendpos,
  buildingBlockSize = this._getBuildingblocksize,
  grassAsset = this._getGrassasset,
  boxPosition = this._getBoxposition,
  petPlantPos = this._getPetplantpos,
  petWaterPos = this._getPetwaterpos,
  petHarvestPos = this._getPetharvestpos,
  blockLens = this._getBlocklens
}
return this
