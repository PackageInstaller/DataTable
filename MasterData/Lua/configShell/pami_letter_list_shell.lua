local this = class("pami_letter_list_shell", G_BaseConfig)
local core = G_Tables.TDPamiLetterListTable.GetInstance()

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
  groupId = 1,
  type = 2,
  order = 3,
  condition = 4,
  param = 5,
  time = 6,
  title = 7,
  firstId = 8,
  taskId = 9,
  disappear = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_list", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getFirstid(offset)
  return core:GetInt(offset, this.indexMap.firstId)
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getDisappear(offset)
  return core:GetInt(offset, this.indexMap.disappear)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  type = this._getType,
  order = this._getOrder,
  condition = this._getCondition,
  param = this._getParam,
  time = this._getTime,
  title = this._getTitle,
  firstId = this._getFirstid,
  taskId = this._getTaskid,
  disappear = this._getDisappear
}
return this
