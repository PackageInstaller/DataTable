local this = class("introduction_shell", G_BaseConfig)
local core = G_Tables.TDIntroductionTable.GetInstance()

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
  page = 2,
  title = 3,
  content = 4,
  picture = 5,
  isPictureIntroduction = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getPage(offset)
  return core:GetInt(offset, this.indexMap.page)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("introduction", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getContent(offset)
  local langStr = G_TableMgrIns:GetLangStr("introduction", core:GetVString(offset, this.indexMap.content))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "content")
end

function this:_getPicture(offset)
  local str = core:GetVString(offset, this.indexMap.picture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIspictureintroduction(offset)
  return core:GetBool(offset, this.indexMap.isPictureIntroduction)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  page = this._getPage,
  title = this._getTitle,
  content = this._getContent,
  picture = this._getPicture,
  isPictureIntroduction = this._getIspictureintroduction
}
return this
