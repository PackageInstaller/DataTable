local this = class("soulessence_grade_shell", G_BaseConfig)
local core = G_Tables.TDSoulessenceGradeTable.GetInstance()

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
  soulessenceId = 1,
  subSkillId = 2,
  grade = 3,
  skillId = 4,
  skillLv = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSoulessenceid(offset)
  return core:GetInt(offset, this.indexMap.soulessenceId)
end

function this:_getSubskillid(offset)
  return core:GetInt(offset, this.indexMap.subSkillId)
end

function this:_getGrade(offset)
  return core:GetInt(offset, this.indexMap.grade)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getSkilllv(offset)
  return core:GetInt(offset, this.indexMap.skillLv)
end

this.keyToMethodsMap = {
  id = this._getId,
  soulessenceId = this._getSoulessenceid,
  subSkillId = this._getSubskillid,
  grade = this._getGrade,
  skillId = this._getSkillid,
  skillLv = this._getSkilllv
}
return this
