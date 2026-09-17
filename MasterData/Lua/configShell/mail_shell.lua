local this = class("mail_shell", G_BaseConfig)
local core = G_Tables.TDMailTable.GetInstance()

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
  title = 2,
  name = 3,
  content = 4,
  jumpShow = 5,
  jumpType = 6,
  link = 7,
  questionnaireParam = 8,
  jumpId = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTitle(offset)
  return core:GetInt(offset, this.indexMap.title)
end

function this:_getName(offset)
  return core:GetInt(offset, this.indexMap.name)
end

function this:_getContent(offset)
  return core:GetInt(offset, this.indexMap.content)
end

function this:_getJumpshow(offset)
  local langStr = G_TableMgrIns:GetLangStr("mail", core:GetVString(offset, this.indexMap.jumpShow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "jumpShow")
end

function this:_getJumptype(offset)
  return core:GetInt(offset, this.indexMap.jumpType)
end

function this:_getLink(offset)
  return core:GetVString(offset, this.indexMap.link).value
end

function this:_getQuestionnaireparam(offset)
  local str = core:GetVString(offset, this.indexMap.questionnaireParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getJumpid(offset)
  return core:GetInt(offset, this.indexMap.jumpId)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  title = this._getTitle,
  name = this._getName,
  content = this._getContent,
  jumpShow = this._getJumpshow,
  jumpType = this._getJumptype,
  link = this._getLink,
  questionnaireParam = this._getQuestionnaireparam,
  jumpId = this._getJumpid
}
return this
