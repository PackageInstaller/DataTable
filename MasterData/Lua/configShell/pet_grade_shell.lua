local this = class("pet_grade_shell", G_BaseConfig)
local core = G_Tables.TDPetGradeTable.GetInstance()

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
  petRank = 1,
  petRare = 2,
  petRareParam = 3,
  grade = 4,
  gradeScore = 5,
  gradeBackground = 6,
  icon = 7,
  iconSquare = 8,
  petPixelBase = 9,
  petGradeFrame = 10,
  name = 11,
  gradeIcon = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetrank(offset)
  return core:GetInt(offset, this.indexMap.petRank)
end

function this:_getPetrare(offset)
  return core:GetInt(offset, this.indexMap.petRare)
end

function this:_getPetrareparam(offset)
  return core:GetFloat(offset, this.indexMap.petRareParam)
end

function this:_getGrade(offset)
  local str = core:GetVString(offset, this.indexMap.grade).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGradescore(offset)
  local str = core:GetVString(offset, this.indexMap.gradeScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGradebackground(offset)
  local str = core:GetVString(offset, this.indexMap.gradeBackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconsquare(offset)
  local str = core:GetVString(offset, this.indexMap.iconSquare).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPetpixelbase(offset)
  local str = core:GetVString(offset, this.indexMap.petPixelBase).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPetgradeframe(offset)
  local str = core:GetVString(offset, this.indexMap.petGradeFrame).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getGradeicon(offset)
  local str = core:GetVString(offset, this.indexMap.gradeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

this.keyToMethodsMap = {
  id = this._getId,
  petRank = this._getPetrank,
  petRare = this._getPetrare,
  petRareParam = this._getPetrareparam,
  grade = this._getGrade,
  gradeScore = this._getGradescore,
  gradeBackground = this._getGradebackground,
  icon = this._getIcon,
  iconSquare = this._getIconsquare,
  petPixelBase = this._getPetpixelbase,
  petGradeFrame = this._getPetgradeframe,
  name = this._getName,
  gradeIcon = this._getGradeicon
}
return this
