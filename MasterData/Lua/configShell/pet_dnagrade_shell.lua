local this = class("pet_dnagrade_shell", G_BaseConfig)
local core = G_Tables.TDPetDnagradeTable.GetInstance()

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
  grade1 = 1,
  grade2 = 2,
  grade3 = 3,
  grade4 = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGrade1(offset)
  return core:GetInt(offset, this.indexMap.grade1)
end

function this:_getGrade2(offset)
  return core:GetInt(offset, this.indexMap.grade2)
end

function this:_getGrade3(offset)
  return core:GetInt(offset, this.indexMap.grade3)
end

function this:_getGrade4(offset)
  return core:GetInt(offset, this.indexMap.grade4)
end

this.keyToMethodsMap = {
  id = this._getId,
  grade1 = this._getGrade1,
  grade2 = this._getGrade2,
  grade3 = this._getGrade3,
  grade4 = this._getGrade4
}
return this
