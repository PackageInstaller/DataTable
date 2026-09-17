local this = class("hero_grade_shell", G_BaseConfig)
local core = G_Tables.TDHeroGradeTable.GetInstance()

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
  heroId = 1,
  grade = 2,
  title = 3,
  text = 4,
  mainAttr = 5,
  mainSkill = 6,
  reward = 7,
  picText1 = 8,
  picText2 = 9,
  picText3 = 10,
  picText4 = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getGrade(offset)
  return core:GetInt(offset, this.indexMap.grade)
end

function this:_getTitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_grade", core:GetVString(offset, this.indexMap.title))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "title")
end

function this:_getText(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_grade", core:GetVString(offset, this.indexMap.text))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "text")
end

function this:_getMainattr(offset)
  local str = core:GetVString(offset, this.indexMap.mainAttr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMainskill(offset)
  local str = core:GetVString(offset, this.indexMap.mainSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPictext1(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_grade", core:GetVString(offset, this.indexMap.picText1))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "picText1")
end

function this:_getPictext2(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_grade", core:GetVString(offset, this.indexMap.picText2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "picText2")
end

function this:_getPictext3(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_grade", core:GetVString(offset, this.indexMap.picText3))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "picText3")
end

function this:_getPictext4(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_grade", core:GetVString(offset, this.indexMap.picText4))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "picText4")
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  grade = this._getGrade,
  title = this._getTitle,
  text = this._getText,
  mainAttr = this._getMainattr,
  mainSkill = this._getMainskill,
  reward = this._getReward,
  picText1 = this._getPictext1,
  picText2 = this._getPictext2,
  picText3 = this._getPictext3,
  picText4 = this._getPictext4
}
return this
