local this = class("kibo_duel_skill_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelSkillTable.GetInstance()

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
  skillId = 1,
  defaultSkill = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getDefaultskill(offset)
  return core:GetBool(offset, this.indexMap.defaultSkill)
end

this.keyToMethodsMap = {
  id = this._getId,
  skillId = this._getSkillid,
  defaultSkill = this._getDefaultskill
}
return this
