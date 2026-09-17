local this = class("home_technology_tree_shell", G_BaseConfig)
local core = G_Tables.TDHomeTechnologyTreeTable.GetInstance()

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
  icon = 2,
  markIcon = 3,
  category = 4,
  nodeType = 5,
  locationX = 6,
  locationY = 7,
  pretechnologyTypeId = 8,
  posttechnologyTypeId = 9,
  nodeTypeIcon = 10,
  pretechnologyToIndex = 11,
  posttechnologyFromIndex = 12,
  isRecommend = 13,
  isAutoUnlock = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_technology_tree", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getMarkicon(offset)
  local str = core:GetVString(offset, this.indexMap.markIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCategory(offset)
  return core:GetInt(offset, this.indexMap.category)
end

function this:_getNodetype(offset)
  return core:GetInt(offset, this.indexMap.nodeType)
end

function this:_getLocationx(offset)
  return core:GetInt(offset, this.indexMap.locationX)
end

function this:_getLocationy(offset)
  return core:GetInt(offset, this.indexMap.locationY)
end

function this:_getPretechnologytypeid(offset)
  local str = core:GetVString(offset, this.indexMap.pretechnologyTypeId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPosttechnologytypeid(offset)
  local str = core:GetVString(offset, this.indexMap.posttechnologyTypeId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNodetypeicon(offset)
  return core:GetInt(offset, this.indexMap.nodeTypeIcon)
end

function this:_getPretechnologytoindex(offset)
  local str = core:GetVString(offset, this.indexMap.pretechnologyToIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPosttechnologyfromindex(offset)
  local str = core:GetVString(offset, this.indexMap.posttechnologyFromIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsrecommend(offset)
  return core:GetInt(offset, this.indexMap.isRecommend)
end

function this:_getIsautounlock(offset)
  return core:GetInt(offset, this.indexMap.isAutoUnlock)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  icon = this._getIcon,
  markIcon = this._getMarkicon,
  category = this._getCategory,
  nodeType = this._getNodetype,
  locationX = this._getLocationx,
  locationY = this._getLocationy,
  pretechnologyTypeId = this._getPretechnologytypeid,
  posttechnologyTypeId = this._getPosttechnologytypeid,
  nodeTypeIcon = this._getNodetypeicon,
  pretechnologyToIndex = this._getPretechnologytoindex,
  posttechnologyFromIndex = this._getPosttechnologyfromindex,
  isRecommend = this._getIsrecommend,
  isAutoUnlock = this._getIsautounlock
}
return this
