local this = class("home_object_brg_shell", G_BaseConfig)
local core = G_Tables.TDHomeObjectBrgTable.GetInstance()

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
  objName = 1,
  resBrgMeshAssetHashList = 2,
  resBrgMeshPathList = 3,
  resBrgMatAssetHashList = 4,
  resBrgMatPathList = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getObjname(offset)
  return core:GetVString(offset, this.indexMap.objName).value
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

this.keyToMethodsMap = {
  id = this._getId,
  objName = this._getObjname,
  resBrgMeshAssetHashList = this._getResbrgmeshassethashlist,
  resBrgMeshPathList = this._getResbrgmeshpathlist,
  resBrgMatAssetHashList = this._getResbrgmatassethashlist,
  resBrgMatPathList = this._getResbrgmatpathlist
}
return this
