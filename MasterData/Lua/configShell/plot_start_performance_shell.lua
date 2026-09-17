local this = class("plot_start_performance_shell", G_BaseConfig)
local core = G_Tables.TDPlotStartPerformanceTable.GetInstance()

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
  volName = 2,
  chapterNum = 3,
  chapterName = 4,
  icon = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getVolname(offset)
  local langStr = G_TableMgrIns:GetLangStr("plot_start_performance", core:GetVString(offset, this.indexMap.volName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "volName")
end

function this:_getChapternum(offset)
  local langStr = G_TableMgrIns:GetLangStr("plot_start_performance", core:GetVString(offset, this.indexMap.chapterNum))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "chapterNum")
end

function this:_getChaptername(offset)
  local langStr = G_TableMgrIns:GetLangStr("plot_start_performance", core:GetVString(offset, this.indexMap.chapterName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "chapterName")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  volName = this._getVolname,
  chapterNum = this._getChapternum,
  chapterName = this._getChaptername,
  icon = this._getIcon
}
return this
