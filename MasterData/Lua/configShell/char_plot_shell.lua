local this = class("char_plot_shell", G_BaseConfig)
local core = G_Tables.TDCharPlotTable.GetInstance()

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
  heroId = 1,
  name = 2,
  order = 3,
  exId = 4,
  englishNum = 5,
  title = 6,
  text = 7,
  pic = 8,
  taskId = 9,
  unlockCondition = 10,
  unlockConditionText = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_plot", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getExid(offset)
  return core:GetInt(offset, this.indexMap.exId)
end

function this:_getEnglishnum(offset)
  return core:GetVString(offset, this.indexMap.englishNum).value
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_plot", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_plot", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockconditiontext(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("char_plot", core:GetVString(offset, this.indexMap.unlockConditionText))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "char_plot")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  name = this._getName,
  order = this._getOrder,
  exId = this._getExid,
  englishNum = this._getEnglishnum,
  title = this._getTitle,
  text = this._getText,
  pic = this._getPic,
  taskId = this._getTaskid,
  unlockCondition = this._getUnlockcondition,
  unlockConditionText = this._getUnlockconditiontext
}
return this
