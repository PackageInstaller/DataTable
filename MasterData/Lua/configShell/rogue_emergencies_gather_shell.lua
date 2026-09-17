local this = class("rogue_emergencies_gather_shell", G_BaseConfig)
local core = G_Tables.TDRogueEmergenciesGatherTable.GetInstance()

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
  gatherid = 1,
  charactertype = 2,
  charactername = 3,
  speechcontent = 4,
  action = 5,
  kiboemotion = 6,
  isselection = 7,
  jumpconfig = 8,
  nextcontenttype = 9,
  nextcontentid = 10,
  nextgatherid = 11,
  jumptext = 12,
  choiceicon = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGatherid(offset)
  return core:GetInt(offset, this.indexMap.gatherid)
end

function this:_getCharactertype(offset)
  return core:GetInt(offset, this.indexMap.charactertype)
end

function this:_getCharactername(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_emergencies_gather", core:GetVString(offset, this.indexMap.charactername))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "charactername")
end

function this:_getSpeechcontent(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_emergencies_gather", core:GetVString(offset, this.indexMap.speechcontent))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "speechcontent")
end

function this:_getAction(offset)
  return core:GetVString(offset, this.indexMap.action).value
end

function this:_getKiboemotion(offset)
  return core:GetInt(offset, this.indexMap.kiboemotion)
end

function this:_getIsselection(offset)
  return core:GetInt(offset, this.indexMap.isselection)
end

function this:_getJumpconfig(offset)
  local str = core:GetVString(offset, this.indexMap.jumpconfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNextcontenttype(offset)
  return core:GetInt(offset, this.indexMap.nextcontenttype)
end

function this:_getNextcontentid(offset)
  local str = core:GetVString(offset, this.indexMap.nextcontentid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNextgatherid(offset)
  return core:GetInt(offset, this.indexMap.nextgatherid)
end

function this:_getJumptext(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("rogue_emergencies_gather", core:GetVString(offset, this.indexMap.jumptext))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "rogue_emergencies_gather")
end

function this:_getChoiceicon(offset)
  local str = core:GetVString(offset, this.indexMap.choiceicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

this.keyToMethodsMap = {
  id = this._getId,
  gatherid = this._getGatherid,
  charactertype = this._getCharactertype,
  charactername = this._getCharactername,
  speechcontent = this._getSpeechcontent,
  action = this._getAction,
  kiboemotion = this._getKiboemotion,
  isselection = this._getIsselection,
  jumpconfig = this._getJumpconfig,
  nextcontenttype = this._getNextcontenttype,
  nextcontentid = this._getNextcontentid,
  nextgatherid = this._getNextgatherid,
  jumptext = this._getJumptext,
  choiceicon = this._getChoiceicon
}
return this
