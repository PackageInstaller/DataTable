local this = class("playercard_dress_shell", G_BaseConfig)
local core = G_Tables.TDPlayercardDressTable.GetInstance()

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
  type = 1,
  name = 2,
  defaultComponent = 3,
  customize = 4,
  countAvailable = 5,
  itemName = 6,
  desc = 7,
  specialDesc = 8,
  icon = 9,
  rarity = 10,
  maxNum = 11,
  pic = 12,
  profilepic = 13,
  framepic = 14,
  numRes = 15,
  txt = 16,
  show = 17,
  way = 18,
  wayDesc = 19,
  previewPaintingPath = 20,
  previewStartingAnimation = 21,
  previewFrameName = 22,
  previewHideBg = 23
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("playercard_dress", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDefaultcomponent(offset)
  return core:GetInt(offset, this.indexMap.defaultComponent)
end

function this:_getCustomize(offset)
  return core:GetInt(offset, this.indexMap.customize)
end

function this:_getCountavailable(offset)
  return core:GetInt(offset, this.indexMap.countAvailable)
end

function this:_getItemname(offset)
  local langStr = G_TableMgrIns:GetLangStr("playercard_dress", core:GetVString(offset, this.indexMap.itemName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "itemName")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("playercard_dress", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("playercard_dress", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getProfilepic(offset)
  local str = core:GetVString(offset, this.indexMap.profilepic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getFramepic(offset)
  local str = core:GetVString(offset, this.indexMap.framepic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNumres(offset)
  local str = core:GetVString(offset, this.indexMap.numRes).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getTxt(offset)
  local langStr = G_TableMgrIns:GetLangStr("playercard_dress", core:GetVString(offset, this.indexMap.txt))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "txt")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("playercard_dress", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "playercard_dress")
end

function this:_getPreviewpaintingpath(offset)
  local str = core:GetVString(offset, this.indexMap.previewPaintingPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPreviewstartinganimation(offset)
  local str = core:GetVString(offset, this.indexMap.previewStartingAnimation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPreviewframename(offset)
  local str = core:GetVString(offset, this.indexMap.previewFrameName).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPreviewhidebg(offset)
  return core:GetBool(offset, this.indexMap.previewHideBg)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  name = this._getName,
  defaultComponent = this._getDefaultcomponent,
  customize = this._getCustomize,
  countAvailable = this._getCountavailable,
  itemName = this._getItemname,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  rarity = this._getRarity,
  maxNum = this._getMaxnum,
  pic = this._getPic,
  profilepic = this._getProfilepic,
  framepic = this._getFramepic,
  numRes = this._getNumres,
  txt = this._getTxt,
  show = this._getShow,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  previewPaintingPath = this._getPreviewpaintingpath,
  previewStartingAnimation = this._getPreviewstartinganimation,
  previewFrameName = this._getPreviewframename,
  previewHideBg = this._getPreviewhidebg
}
return this
