local this = class("common_challenge_shell", G_BaseConfig)
local core = G_Tables.TDCommonChallengeTable.GetInstance()

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
  group = 1,
  type = 2,
  condition = 3,
  frontChallenge = 4,
  challengeCondition = 5,
  desc = 6,
  isSatisfy = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFrontchallenge(offset)
  return core:GetInt(offset, this.indexMap.frontChallenge)
end

function this:_getChallengecondition(offset)
  local str = core:GetVString(offset, this.indexMap.challengeCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDesc(offset)
  return core:GetVString(offset, this.indexMap.desc).value
end

function this:_getIssatisfy(offset)
  return core:GetInt(offset, this.indexMap.isSatisfy)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  type = this._getType,
  condition = this._getCondition,
  frontChallenge = this._getFrontchallenge,
  challengeCondition = this._getChallengecondition,
  desc = this._getDesc,
  isSatisfy = this._getIssatisfy
}
return this
