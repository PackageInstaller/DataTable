local this = class("partygame_skill_shell", G_BaseConfig)
local core = G_Tables.TDPartygameSkillTable.GetInstance()

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
  skillid = 1,
  name = 2,
  description = 3,
  order = 4,
  figureicon = 5,
  buttonicon = 6,
  videopath = 7,
  CD = 8,
  times = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillid)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("partygame_skill", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("partygame_skill", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getFigureicon(offset)
  local str = core:GetVString(offset, this.indexMap.figureicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getButtonicon(offset)
  local str = core:GetVString(offset, this.indexMap.buttonicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getVideopath(offset)
  local str = core:GetVString(offset, this.indexMap.videopath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCd(offset)
  return core:GetInt(offset, this.indexMap.CD)
end

function this:_getTimes(offset)
  return core:GetInt(offset, this.indexMap.times)
end

this.keyToMethodsMap = {
  id = this._getId,
  skillid = this._getSkillid,
  name = this._getName,
  description = this._getDescription,
  order = this._getOrder,
  figureicon = this._getFigureicon,
  buttonicon = this._getButtonicon,
  videopath = this._getVideopath,
  CD = this._getCd,
  times = this._getTimes
}
return this
