local this = class("char_voice_words_system_shell", G_BaseConfig)
local core = G_Tables.TDCharVoiceWordsSystemTable.GetInstance()

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
  EnterInterface_01 = 2,
  EnterInterface_02 = 3,
  EnterInterface_03 = 4,
  Introduce = 5,
  AboutSelf_01 = 6,
  AboutSelf_02 = 7,
  AboutPlayer_01 = 8,
  AboutPlayer_02 = 9,
  AboutPet_01 = 10,
  AboutPet_02 = 11,
  AboutWorld_01 = 12,
  AboutWorld_02 = 13,
  Information = 14,
  Forming = 15,
  Obtain = 16,
  Shown = 17,
  MaterialChoose = 18,
  LevelBreak = 19,
  SameUnitBreak = 20,
  Talent = 21,
  ChangeKibo = 22,
  ChangeEquip = 23,
  ChangeClothing = 24,
  ChangeWeapon = 25,
  IdleGift = 26,
  PresentFavorite = 27,
  PresentNormal = 28,
  CheckIn = 29,
  Relationship_01 = 30,
  Relationship_02 = 31,
  Relationship_03 = 32,
  Relationship_04 = 33,
  Relationship_05 = 34,
  WishFurniture = 35,
  Birthday = 36,
  BirthdayThoughts = 37,
  FishingThrow = 38,
  FishingHold_01 = 39,
  FishingHold_02 = 40,
  FishingHold_03 = 41,
  FishingHold_04 = 42,
  FishingWin = 43,
  FishingFail = 44,
  Idle1 = 45,
  Idle2 = 46,
  IdleFavorAbility_01 = 47,
  IdleFavorAbility_02 = 48,
  IdleFavorAbility_03 = 49,
  IdleFavorAbility_04 = 50,
  IdleFavorAbility_05 = 51
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getEnterinterface_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.EnterInterface_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnterInterface_01")
end

function this:_getEnterinterface_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.EnterInterface_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnterInterface_02")
end

function this:_getEnterinterface_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.EnterInterface_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnterInterface_03")
end

function this:_getIntroduce(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Introduce))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Introduce")
end

function this:_getAboutself_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutSelf_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutSelf_01")
end

function this:_getAboutself_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutSelf_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutSelf_02")
end

function this:_getAboutplayer_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutPlayer_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutPlayer_01")
end

function this:_getAboutplayer_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutPlayer_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutPlayer_02")
end

function this:_getAboutpet_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutPet_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutPet_01")
end

function this:_getAboutpet_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutPet_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutPet_02")
end

function this:_getAboutworld_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutWorld_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutWorld_01")
end

function this:_getAboutworld_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.AboutWorld_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AboutWorld_02")
end

function this:_getInformation(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Information))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Information")
end

function this:_getForming(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Forming))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Forming")
end

function this:_getObtain(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Obtain))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Obtain")
end

function this:_getShown(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Shown))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Shown")
end

function this:_getMaterialchoose(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.MaterialChoose))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "MaterialChoose")
end

function this:_getLevelbreak(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.LevelBreak))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "LevelBreak")
end

function this:_getSameunitbreak(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.SameUnitBreak))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SameUnitBreak")
end

function this:_getTalent(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Talent))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Talent")
end

function this:_getChangekibo(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.ChangeKibo))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ChangeKibo")
end

function this:_getChangeequip(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.ChangeEquip))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ChangeEquip")
end

function this:_getChangeclothing(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.ChangeClothing))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ChangeClothing")
end

function this:_getChangeweapon(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.ChangeWeapon))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ChangeWeapon")
end

function this:_getIdlegift(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.IdleGift))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleGift")
end

function this:_getPresentfavorite(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.PresentFavorite))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PresentFavorite")
end

function this:_getPresentnormal(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.PresentNormal))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PresentNormal")
end

function this:_getCheckin(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.CheckIn))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "CheckIn")
end

function this:_getRelationship_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Relationship_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Relationship_01")
end

function this:_getRelationship_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Relationship_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Relationship_02")
end

function this:_getRelationship_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Relationship_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Relationship_03")
end

function this:_getRelationship_04(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Relationship_04))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Relationship_04")
end

function this:_getRelationship_05(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Relationship_05))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Relationship_05")
end

function this:_getWishfurniture(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.WishFurniture))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "WishFurniture")
end

function this:_getBirthday(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Birthday))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Birthday")
end

function this:_getBirthdaythoughts(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.BirthdayThoughts))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BirthdayThoughts")
end

function this:_getFishingthrow(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingThrow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingThrow")
end

function this:_getFishinghold_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingHold_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingHold_01")
end

function this:_getFishinghold_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingHold_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingHold_02")
end

function this:_getFishinghold_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingHold_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingHold_03")
end

function this:_getFishinghold_04(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingHold_04))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingHold_04")
end

function this:_getFishingwin(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingWin))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingWin")
end

function this:_getFishingfail(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.FishingFail))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FishingFail")
end

function this:_getIdle1(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Idle1))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Idle1")
end

function this:_getIdle2(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.Idle2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Idle2")
end

function this:_getIdlefavorability_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.IdleFavorAbility_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleFavorAbility_01")
end

function this:_getIdlefavorability_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.IdleFavorAbility_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleFavorAbility_02")
end

function this:_getIdlefavorability_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.IdleFavorAbility_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleFavorAbility_03")
end

function this:_getIdlefavorability_04(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.IdleFavorAbility_04))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleFavorAbility_04")
end

function this:_getIdlefavorability_05(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_system", core:GetVString(offset, this.indexMap.IdleFavorAbility_05))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleFavorAbility_05")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  EnterInterface_01 = this._getEnterinterface_01,
  EnterInterface_02 = this._getEnterinterface_02,
  EnterInterface_03 = this._getEnterinterface_03,
  Introduce = this._getIntroduce,
  AboutSelf_01 = this._getAboutself_01,
  AboutSelf_02 = this._getAboutself_02,
  AboutPlayer_01 = this._getAboutplayer_01,
  AboutPlayer_02 = this._getAboutplayer_02,
  AboutPet_01 = this._getAboutpet_01,
  AboutPet_02 = this._getAboutpet_02,
  AboutWorld_01 = this._getAboutworld_01,
  AboutWorld_02 = this._getAboutworld_02,
  Information = this._getInformation,
  Forming = this._getForming,
  Obtain = this._getObtain,
  Shown = this._getShown,
  MaterialChoose = this._getMaterialchoose,
  LevelBreak = this._getLevelbreak,
  SameUnitBreak = this._getSameunitbreak,
  Talent = this._getTalent,
  ChangeKibo = this._getChangekibo,
  ChangeEquip = this._getChangeequip,
  ChangeClothing = this._getChangeclothing,
  ChangeWeapon = this._getChangeweapon,
  IdleGift = this._getIdlegift,
  PresentFavorite = this._getPresentfavorite,
  PresentNormal = this._getPresentnormal,
  CheckIn = this._getCheckin,
  Relationship_01 = this._getRelationship_01,
  Relationship_02 = this._getRelationship_02,
  Relationship_03 = this._getRelationship_03,
  Relationship_04 = this._getRelationship_04,
  Relationship_05 = this._getRelationship_05,
  WishFurniture = this._getWishfurniture,
  Birthday = this._getBirthday,
  BirthdayThoughts = this._getBirthdaythoughts,
  FishingThrow = this._getFishingthrow,
  FishingHold_01 = this._getFishinghold_01,
  FishingHold_02 = this._getFishinghold_02,
  FishingHold_03 = this._getFishinghold_03,
  FishingHold_04 = this._getFishinghold_04,
  FishingWin = this._getFishingwin,
  FishingFail = this._getFishingfail,
  Idle1 = this._getIdle1,
  Idle2 = this._getIdle2,
  IdleFavorAbility_01 = this._getIdlefavorability_01,
  IdleFavorAbility_02 = this._getIdlefavorability_02,
  IdleFavorAbility_03 = this._getIdlefavorability_03,
  IdleFavorAbility_04 = this._getIdlefavorability_04,
  IdleFavorAbility_05 = this._getIdlefavorability_05
}
return this
