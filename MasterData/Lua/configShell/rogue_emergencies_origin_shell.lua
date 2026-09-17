local this = class("rogue_emergencies_origin_shell", G_BaseConfig)
local core = G_Tables.TDRogueEmergenciesOriginTable.GetInstance()

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
  nextid = 1,
  gatherid = 2,
  gatherfirstid = 3,
  gathertitle = 4,
  type = 5,
  description = 6,
  CG = 7,
  HandBookImg = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getNextid(offset)
  return core:GetInt(offset, this.indexMap.nextid)
end

function this:_getGatherid(offset)
  return core:GetInt(offset, this.indexMap.gatherid)
end

function this:_getGatherfirstid(offset)
  return core:GetInt(offset, this.indexMap.gatherfirstid)
end

function this:_getGathertitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_emergencies_origin", core:GetVString(offset, this.indexMap.gathertitle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "gathertitle")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("rogue_emergencies_origin", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getCg(offset)
  local str = core:GetVString(offset, this.indexMap.CG).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHandbookimg(offset)
  local str = core:GetVString(offset, this.indexMap.HandBookImg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  nextid = this._getNextid,
  gatherid = this._getGatherid,
  gatherfirstid = this._getGatherfirstid,
  gathertitle = this._getGathertitle,
  type = this._getType,
  description = this._getDescription,
  CG = this._getCg,
  HandBookImg = this._getHandbookimg
}
return this
