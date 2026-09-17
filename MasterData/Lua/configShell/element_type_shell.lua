local this = class("element_type_shell", G_BaseConfig)
local core = G_Tables.TDElementTypeTable.GetInstance()

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
  name = 1,
  abbrName = 2,
  elementColor = 3,
  petPuzzleIcon = 4,
  petPuzzleColor = 5,
  petElem = 6,
  professionColor = 7,
  elementIcon = 8,
  teamElementIcon = 9,
  professionRectangleColor = 10,
  skillElem = 11,
  restraint = 12,
  kiboRestraint = 13,
  dungeonElementColor = 14,
  dungeonElementIcon = 15,
  kiboCardIcon = 16,
  kiboCardEleBg = 17,
  kiboBoxCardEleIcon = 18,
  kiboDuelCard = 19,
  kiboDuelNameColor = 20,
  admissioneffects = 21,
  elementalaltarEffect = 22,
  elementiconography = 23,
  elementPetBox = 24
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("element_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAbbrname(offset)
  local langStr = G_TableMgrIns:GetLangStr("element_type", core:GetVString(offset, this.indexMap.abbrName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "abbrName")
end

function this:_getElementcolor(offset)
  return core:GetVString(offset, this.indexMap.elementColor).value
end

function this:_getPetpuzzleicon(offset)
  local str = core:GetVString(offset, this.indexMap.petPuzzleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getPetpuzzlecolor(offset)
  local str = core:GetVString(offset, this.indexMap.petPuzzleColor).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getPetelem(offset)
  local str = core:GetVString(offset, this.indexMap.petElem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getProfessioncolor(offset)
  local str = core:GetVString(offset, this.indexMap.professionColor).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getElementicon(offset)
  local str = core:GetVString(offset, this.indexMap.elementIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

function this:_getTeamelementicon(offset)
  local str = core:GetVString(offset, this.indexMap.teamElementIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

function this:_getProfessionrectanglecolor(offset)
  return core:GetVString(offset, this.indexMap.professionRectangleColor).value
end

function this:_getSkillelem(offset)
  local str = core:GetVString(offset, this.indexMap.skillElem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRestraint(offset)
  local str = core:GetVString(offset, this.indexMap.restraint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKiborestraint(offset)
  local str = core:GetVString(offset, this.indexMap.kiboRestraint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDungeonelementcolor(offset)
  return core:GetVString(offset, this.indexMap.dungeonElementColor).value
end

function this:_getDungeonelementicon(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonElementIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getKibocardicon(offset)
  local str = core:GetVString(offset, this.indexMap.kiboCardIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getKibocardelebg(offset)
  local str = core:GetVString(offset, this.indexMap.kiboCardEleBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 4)
end

function this:_getKiboboxcardeleicon(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBoxCardEleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getKiboduelcard(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelCard).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 8)
end

function this:_getKiboduelnamecolor(offset)
  return core:GetVString(offset, this.indexMap.kiboDuelNameColor).value
end

function this:_getAdmissioneffects(offset)
  local str = core:GetVString(offset, this.indexMap.admissioneffects).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getElementalaltareffect(offset)
  local str = core:GetVString(offset, this.indexMap.elementalaltarEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getElementiconography(offset)
  local str = core:GetVString(offset, this.indexMap.elementiconography).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getElementpetbox(offset)
  local str = core:GetVString(offset, this.indexMap.elementPetBox).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 3)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  abbrName = this._getAbbrname,
  elementColor = this._getElementcolor,
  petPuzzleIcon = this._getPetpuzzleicon,
  petPuzzleColor = this._getPetpuzzlecolor,
  petElem = this._getPetelem,
  professionColor = this._getProfessioncolor,
  elementIcon = this._getElementicon,
  teamElementIcon = this._getTeamelementicon,
  professionRectangleColor = this._getProfessionrectanglecolor,
  skillElem = this._getSkillelem,
  restraint = this._getRestraint,
  kiboRestraint = this._getKiborestraint,
  dungeonElementColor = this._getDungeonelementcolor,
  dungeonElementIcon = this._getDungeonelementicon,
  kiboCardIcon = this._getKibocardicon,
  kiboCardEleBg = this._getKibocardelebg,
  kiboBoxCardEleIcon = this._getKiboboxcardeleicon,
  kiboDuelCard = this._getKiboduelcard,
  kiboDuelNameColor = this._getKiboduelnamecolor,
  admissioneffects = this._getAdmissioneffects,
  elementalaltarEffect = this._getElementalaltareffect,
  elementiconography = this._getElementiconography,
  elementPetBox = this._getElementpetbox
}
return this
