local this = class("task_text_shell", G_BaseConfig)
local core = G_Tables.TDTaskTextTable.GetInstance()

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
  title = 1,
  desc = 2,
  sign = 3,
  target = 4,
  rewardShow = 5,
  reward = 6
}

function this:_getId(offset)
  return core:GetLong(offset, this.indexMap.id)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_text", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_text", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSign(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_text", core:GetVString(offset, this.indexMap.sign))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "sign")
end

function this:_getTarget(offset)
  local langStr = G_TableMgrIns:GetLangStr("task_text", core:GetVString(offset, this.indexMap.target))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "target")
end

function this:_getRewardshow(offset)
  local str = core:GetVString(offset, this.indexMap.rewardShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getReward(offset)
  return core:GetInt(offset, this.indexMap.reward)
end

this.keyToMethodsMap = {
  id = this._getId,
  title = this._getTitle,
  desc = this._getDesc,
  sign = this._getSign,
  target = this._getTarget,
  rewardShow = this._getRewardshow,
  reward = this._getReward
}
return this
