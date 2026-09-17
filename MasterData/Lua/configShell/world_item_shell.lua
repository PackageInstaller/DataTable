local this = class("world_item_shell", G_BaseConfig)
local core = G_Tables.TDWorldItemTable.GetInstance()

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
  resPath = 1,
  skillList = 2,
  skillBytesPath = 3,
  templateId = 4,
  overwriteId = 5,
  rewardHeight = 6,
  splitTypeList = 7,
  transToHash = 8,
  lodIndex = 9,
  splitType = 10,
  resMeshPathList = 11,
  resEffectPathList = 12,
  resPrefabPathList = 13,
  resBrgMeshAssetHashList = 14,
  resBrgMeshPathList = 15,
  resBrgMatAssetHashList = 16,
  resBrgMatPathList = 17,
  meshPath = 18,
  effectPath = 19,
  aabb = 20,
  streamixPrefabHash = 21
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRespath(offset)
  local str = core:GetVString(offset, this.indexMap.resPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSkillbytespath(offset)
  local str = core:GetVString(offset, this.indexMap.skillBytesPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getTemplateid(offset)
  return core:GetInt(offset, this.indexMap.templateId)
end

function this:_getOverwriteid(offset)
  return core:GetInt(offset, this.indexMap.overwriteId)
end

function this:_getRewardheight(offset)
  return core:GetFloat(offset, this.indexMap.rewardHeight)
end

function this:_getSplittypelist(offset)
  local str = core:GetVString(offset, this.indexMap.splitTypeList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTranstohash(offset)
  local str = core:GetVString(offset, this.indexMap.transToHash).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getLodindex(offset)
  local str = core:GetVString(offset, this.indexMap.lodIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSplittype(offset)
  local str = core:GetVString(offset, this.indexMap.splitType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getResmeshpathlist(offset)
  local str = core:GetVString(offset, this.indexMap.resMeshPathList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getReseffectpathlist(offset)
  local str = core:GetVString(offset, this.indexMap.resEffectPathList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getResprefabpathlist(offset)
  local str = core:GetVString(offset, this.indexMap.resPrefabPathList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getResbrgmeshassethashlist(offset)
  local str = core:GetVString(offset, this.indexMap.resBrgMeshAssetHashList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getResbrgmeshpathlist(offset)
  local str = core:GetVString(offset, this.indexMap.resBrgMeshPathList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getResbrgmatassethashlist(offset)
  local str = core:GetVString(offset, this.indexMap.resBrgMatAssetHashList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getResbrgmatpathlist(offset)
  local str = core:GetVString(offset, this.indexMap.resBrgMatPathList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getMeshpath(offset)
  local str = core:GetVString(offset, this.indexMap.meshPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getEffectpath(offset)
  local str = core:GetVString(offset, this.indexMap.effectPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getAabb(offset)
  local str = core:GetVString(offset, this.indexMap.aabb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getStreamixprefabhash(offset)
  return core:GetVString(offset, this.indexMap.streamixPrefabHash).value
end

this.keyToMethodsMap = {
  id = this._getId,
  resPath = this._getRespath,
  skillList = this._getSkilllist,
  skillBytesPath = this._getSkillbytespath,
  templateId = this._getTemplateid,
  overwriteId = this._getOverwriteid,
  rewardHeight = this._getRewardheight,
  splitTypeList = this._getSplittypelist,
  transToHash = this._getTranstohash,
  lodIndex = this._getLodindex,
  splitType = this._getSplittype,
  resMeshPathList = this._getResmeshpathlist,
  resEffectPathList = this._getReseffectpathlist,
  resPrefabPathList = this._getResprefabpathlist,
  resBrgMeshAssetHashList = this._getResbrgmeshassethashlist,
  resBrgMeshPathList = this._getResbrgmeshpathlist,
  resBrgMatAssetHashList = this._getResbrgmatassethashlist,
  resBrgMatPathList = this._getResbrgmatpathlist,
  meshPath = this._getMeshpath,
  effectPath = this._getEffectpath,
  aabb = this._getAabb,
  streamixPrefabHash = this._getStreamixprefabhash
}
return this
