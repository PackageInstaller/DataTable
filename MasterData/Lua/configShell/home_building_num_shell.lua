local this = class("home_building_num_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingNumTable.GetInstance()

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
  unlockCondition = 2,
  isFirst = 3,
  addNum = 4,
  unlockDesc = 5,
  _note = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIsfirst(offset)
  return core:GetBool(offset, this.indexMap.isFirst)
end

function this:_getAddnum(offset)
  return core:GetInt(offset, this.indexMap.addNum)
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_num", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  unlockCondition = this._getUnlockcondition,
  isFirst = this._getIsfirst,
  addNum = this._getAddnum,
  unlockDesc = this._getUnlockdesc,
  _note = this._get_note
}
return this
