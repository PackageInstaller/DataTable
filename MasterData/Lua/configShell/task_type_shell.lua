local this = class("task_type_shell", G_BaseConfig)
local core = G_Tables.TDTaskTypeTable.GetInstance()

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
  order = 1,
  name = 2,
  show = 3,
  icon = 4,
  taskIcon = 5,
  color = 6,
  detailcolor = 7,
  unlockCondition = 8,
  mapIcon = 9,
  mapIconBg = 10,
  interactiveIcon = 11,
  englishName = 12,
  taskType = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTaskicon(offset)
  local str = core:GetVString(offset, this.indexMap.taskIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getDetailcolor(offset)
  return core:GetVString(offset, this.indexMap.detailcolor).value
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMapicon(offset)
  local str = core:GetVString(offset, this.indexMap.mapIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMapiconbg(offset)
  local str = core:GetVString(offset, this.indexMap.mapIconBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getInteractiveicon(offset)
  local str = core:GetVString(offset, this.indexMap.interactiveIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getEnglishname(offset)
  return core:GetVString(offset, this.indexMap.englishName).value
end

function this:_getTasktype(offset)
  local str = core:GetVString(offset, this.indexMap.taskType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  order = this._getOrder,
  name = this._getName,
  show = this._getShow,
  icon = this._getIcon,
  taskIcon = this._getTaskicon,
  color = this._getColor,
  detailcolor = this._getDetailcolor,
  unlockCondition = this._getUnlockcondition,
  mapIcon = this._getMapicon,
  mapIconBg = this._getMapiconbg,
  interactiveIcon = this._getInteractiveicon,
  englishName = this._getEnglishname,
  taskType = this._getTasktype
}
return this
