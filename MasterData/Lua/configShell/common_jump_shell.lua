local this = class("common_jump_shell", G_BaseConfig)
local core = G_Tables.TDCommonJumpTable.GetInstance()

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
  condition = 2,
  page = 3,
  param = 4,
  text = 5,
  main = 6,
  lockTips = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getPage(offset)
  return core:GetVString(offset, this.indexMap.page).value
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getText(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("common_jump", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "common_jump")
end

function this:_getMain(offset)
  return core:GetInt(offset, this.indexMap.main)
end

function this:_getLocktips(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("common_jump", core:GetVString(offset, this.indexMap.lockTips))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "common_jump")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  condition = this._getCondition,
  page = this._getPage,
  param = this._getParam,
  text = this._getText,
  main = this._getMain,
  lockTips = this._getLocktips
}
return this
