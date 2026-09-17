local this = class("enemy_propertyskill_shell", G_BaseConfig)
local core = G_Tables.TDEnemyPropertyskillTable.GetInstance()

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
  propertySkillName = 1,
  propertySkillDescribe = 2,
  propertySkillIcon = 3,
  elementId = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPropertyskillname(offset)
  return core:GetVString(offset, this.indexMap.propertySkillName).value
end

function this:_getPropertyskilldescribe(offset)
  return core:GetVString(offset, this.indexMap.propertySkillDescribe).value
end

function this:_getPropertyskillicon(offset)
  return core:GetVString(offset, this.indexMap.propertySkillIcon).value
end

function this:_getElementid(offset)
  return core:GetInt(offset, this.indexMap.elementId)
end

this.keyToMethodsMap = {
  id = this._getId,
  propertySkillName = this._getPropertyskillname,
  propertySkillDescribe = this._getPropertyskilldescribe,
  propertySkillIcon = this._getPropertyskillicon,
  elementId = this._getElementid
}
return this
