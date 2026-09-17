local this = class("world_difficulty_tactics_shell", G_BaseConfig)
local core = G_Tables.TDWorldDifficultyTacticsTable.GetInstance()

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
  difficultLv = 3,
  para = 4
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

function this:_getDifficultlv(offset)
  return core:GetInt(offset, this.indexMap.difficultLv)
end

function this:_getPara(offset)
  local str = core:GetVString(offset, this.indexMap.para).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  type = this._getType,
  difficultLv = this._getDifficultlv,
  para = this._getPara
}
return this
