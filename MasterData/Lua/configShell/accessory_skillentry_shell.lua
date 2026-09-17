local this = class("accessory_skillentry_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySkillEntryTable.GetInstance()

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
  subAttrId = 2,
  star = 3,
  skillId = 4,
  skillLv = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getSubattrid(offset)
  return core:GetInt(offset, this.indexMap.subAttrId)
end

function this:_getStar(offset)
  return core:GetInt(offset, this.indexMap.star)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getSkilllv(offset)
  return core:GetInt(offset, this.indexMap.skillLv)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  subAttrId = this._getSubattrid,
  star = this._getStar,
  skillId = this._getSkillid,
  skillLv = this._getSkilllv
}
return this
