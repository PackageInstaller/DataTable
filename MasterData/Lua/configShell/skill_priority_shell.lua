local this = class("skill_priority_shell", G_BaseConfig)
local core = G_Tables.TDSkillPriorityTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {skillId = 0, priority = 1}

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getPriority(offset)
  return core:GetFloat(offset, this.indexMap.priority)
end

this.keyToMethodsMap = {
  skillId = this._getSkillid,
  priority = this._getPriority
}
return this
