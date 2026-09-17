local this = class("task_target_shell", G_BaseConfig)
local core = G_Tables.TDTaskTargetTable.GetInstance()

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
  stepId = 1,
  desc = 2,
  param = 3,
  descCount = 4,
  journeyJump = 5,
  btnDesc = 6,
  shortLockText = 7,
  deliverText = 8
}

function this:_getId(offset)
  return core:GetLong(offset, this.indexMap.id)
end

function this:_getStepid(offset)
  return core:GetLong(offset, this.indexMap.stepId)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_target", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getDesccount(offset)
  return core:GetInt(offset, this.indexMap.descCount)
end

function this:_getJourneyjump(offset)
  return core:GetInt(offset, this.indexMap.journeyJump)
end

function this:_getBtndesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_target", core:GetVString(offset, this.indexMap.btnDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "btnDesc")
end

function this:_getShortlocktext(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_target", core:GetVString(offset, this.indexMap.shortLockText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "shortLockText")
end

function this:_getDelivertext(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_target", core:GetVString(offset, this.indexMap.deliverText))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "deliverText")
end

this.keyToMethodsMap = {
  id = this._getId,
  stepId = this._getStepid,
  desc = this._getDesc,
  param = this._getParam,
  descCount = this._getDesccount,
  journeyJump = this._getJourneyjump,
  btnDesc = this._getBtndesc,
  shortLockText = this._getShortlocktext,
  deliverText = this._getDelivertext
}
return this
