local this = class("char_voice_words_battle_shell", G_BaseConfig)
local core = G_Tables.TDCharVoiceWordsBattleTable.GetInstance()

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
  Dodge = 2,
  QiboCapture = 3,
  NormalSkill = 4,
  UltimateSkillFace = 5,
  UltimateSkillAttack = 6,
  UltimateSkillEnd = 7,
  AttackLight_001 = 8,
  AttackLight_002 = 9,
  AttackLight_003 = 10,
  AttackMedium_001 = 11,
  AttackMedium_002 = 12,
  AttackMedium_003 = 13,
  AttackHeavy_001 = 14,
  AttackHeavy_002 = 15,
  AttackHeavy_003 = 16,
  HPLow = 17,
  BeHit_001 = 18,
  BeHit_002 = 19,
  BeHitStrong_001 = 20,
  BeHitStrong_002 = 21,
  Down = 22,
  Healed = 23,
  OverDrive = 24,
  DischargeAble = 25,
  Discharge = 26,
  EnemyBreak = 27,
  BreakCheer = 28,
  EliteDefeated = 29,
  Change = 30,
  Support = 31,
  BattleStart_01 = 32,
  BattleStart_02 = 33,
  BattleStart_03 = 34,
  Abnormal_01 = 35,
  Abnormal_02 = 36,
  Abnormal_03 = 37,
  Combo200 = 38,
  Combo500 = 39,
  Combo900 = 40,
  PetUltimateRelease = 41,
  PetUltimateHint = 42,
  Counter = 43,
  KinsAttack = 44,
  UltimateSkillCheer = 45,
  BattleVictory = 46,
  SupportFR = 47,
  SwitchFR = 48,
  BossEnter = 49,
  BossShown = 50,
  BossStage_01 = 51,
  BossStage_02 = 52,
  BossStage_03 = 53,
  BossWeak_01 = 54,
  BossWeak_02 = 55,
  BossDoneHit = 56,
  BossUltimateSkill = 57,
  BossInvincible = 58,
  BossSummon = 59,
  BossTransform = 60,
  BossKilled = 61,
  SummonBattle = 62,
  ProprietaryKiboSkill = 63,
  StarlinkSuccess = 64,
  StarlinkFail_01 = 65,
  StarlinkFail_02 = 66
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDodge(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Dodge))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dodge")
end

function this:_getQibocapture(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.QiboCapture))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "QiboCapture")
end

function this:_getNormalskill(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.NormalSkill))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "NormalSkill")
end

function this:_getUltimateskillface(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.UltimateSkillFace))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "UltimateSkillFace")
end

function this:_getUltimateskillattack(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.UltimateSkillAttack))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "UltimateSkillAttack")
end

function this:_getUltimateskillend(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.UltimateSkillEnd))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "UltimateSkillEnd")
end

function this:_getAttacklight_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackLight_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackLight_001")
end

function this:_getAttacklight_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackLight_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackLight_002")
end

function this:_getAttacklight_003(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackLight_003))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackLight_003")
end

function this:_getAttackmedium_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackMedium_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackMedium_001")
end

function this:_getAttackmedium_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackMedium_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackMedium_002")
end

function this:_getAttackmedium_003(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackMedium_003))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackMedium_003")
end

function this:_getAttackheavy_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackHeavy_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackHeavy_001")
end

function this:_getAttackheavy_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackHeavy_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackHeavy_002")
end

function this:_getAttackheavy_003(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.AttackHeavy_003))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "AttackHeavy_003")
end

function this:_getHplow(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.HPLow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "HPLow")
end

function this:_getBehit_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BeHit_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BeHit_001")
end

function this:_getBehit_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BeHit_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BeHit_002")
end

function this:_getBehitstrong_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BeHitStrong_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BeHitStrong_001")
end

function this:_getBehitstrong_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BeHitStrong_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BeHitStrong_002")
end

function this:_getDown(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Down))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Down")
end

function this:_getHealed(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Healed))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Healed")
end

function this:_getOverdrive(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.OverDrive))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "OverDrive")
end

function this:_getDischargeable(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.DischargeAble))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "DischargeAble")
end

function this:_getDischarge(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Discharge))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Discharge")
end

function this:_getEnemybreak(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.EnemyBreak))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnemyBreak")
end

function this:_getBreakcheer(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BreakCheer))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BreakCheer")
end

function this:_getElitedefeated(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.EliteDefeated))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EliteDefeated")
end

function this:_getChange(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Change))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Change")
end

function this:_getSupport(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Support))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Support")
end

function this:_getBattlestart_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BattleStart_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BattleStart_01")
end

function this:_getBattlestart_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BattleStart_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BattleStart_02")
end

function this:_getBattlestart_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BattleStart_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BattleStart_03")
end

function this:_getAbnormal_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Abnormal_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Abnormal_01")
end

function this:_getAbnormal_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Abnormal_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Abnormal_02")
end

function this:_getAbnormal_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Abnormal_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Abnormal_03")
end

function this:_getCombo200(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Combo200))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Combo200")
end

function this:_getCombo500(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Combo500))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Combo500")
end

function this:_getCombo900(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Combo900))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Combo900")
end

function this:_getPetultimaterelease(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.PetUltimateRelease))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PetUltimateRelease")
end

function this:_getPetultimatehint(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.PetUltimateHint))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "PetUltimateHint")
end

function this:_getCounter(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.Counter))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Counter")
end

function this:_getKinsattack(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.KinsAttack))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "KinsAttack")
end

function this:_getUltimateskillcheer(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.UltimateSkillCheer))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "UltimateSkillCheer")
end

function this:_getBattlevictory(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BattleVictory))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BattleVictory")
end

function this:_getSupportfr(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.SupportFR))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SupportFR")
end

function this:_getSwitchfr(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.SwitchFR))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SwitchFR")
end

function this:_getBossenter(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossEnter))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossEnter")
end

function this:_getBossshown(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossShown))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossShown")
end

function this:_getBossstage_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossStage_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossStage_01")
end

function this:_getBossstage_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossStage_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossStage_02")
end

function this:_getBossstage_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossStage_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossStage_03")
end

function this:_getBossweak_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossWeak_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossWeak_01")
end

function this:_getBossweak_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossWeak_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossWeak_02")
end

function this:_getBossdonehit(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossDoneHit))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossDoneHit")
end

function this:_getBossultimateskill(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossUltimateSkill))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossUltimateSkill")
end

function this:_getBossinvincible(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossInvincible))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossInvincible")
end

function this:_getBosssummon(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossSummon))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossSummon")
end

function this:_getBosstransform(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossTransform))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossTransform")
end

function this:_getBosskilled(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.BossKilled))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BossKilled")
end

function this:_getSummonbattle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.SummonBattle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SummonBattle")
end

function this:_getProprietarykiboskill(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.ProprietaryKiboSkill))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ProprietaryKiboSkill")
end

function this:_getStarlinksuccess(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.StarlinkSuccess))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "StarlinkSuccess")
end

function this:_getStarlinkfail_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.StarlinkFail_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "StarlinkFail_01")
end

function this:_getStarlinkfail_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_battle", core:GetVString(offset, this.indexMap.StarlinkFail_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "StarlinkFail_02")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  Dodge = this._getDodge,
  QiboCapture = this._getQibocapture,
  NormalSkill = this._getNormalskill,
  UltimateSkillFace = this._getUltimateskillface,
  UltimateSkillAttack = this._getUltimateskillattack,
  UltimateSkillEnd = this._getUltimateskillend,
  AttackLight_001 = this._getAttacklight_001,
  AttackLight_002 = this._getAttacklight_002,
  AttackLight_003 = this._getAttacklight_003,
  AttackMedium_001 = this._getAttackmedium_001,
  AttackMedium_002 = this._getAttackmedium_002,
  AttackMedium_003 = this._getAttackmedium_003,
  AttackHeavy_001 = this._getAttackheavy_001,
  AttackHeavy_002 = this._getAttackheavy_002,
  AttackHeavy_003 = this._getAttackheavy_003,
  HPLow = this._getHplow,
  BeHit_001 = this._getBehit_001,
  BeHit_002 = this._getBehit_002,
  BeHitStrong_001 = this._getBehitstrong_001,
  BeHitStrong_002 = this._getBehitstrong_002,
  Down = this._getDown,
  Healed = this._getHealed,
  OverDrive = this._getOverdrive,
  DischargeAble = this._getDischargeable,
  Discharge = this._getDischarge,
  EnemyBreak = this._getEnemybreak,
  BreakCheer = this._getBreakcheer,
  EliteDefeated = this._getElitedefeated,
  Change = this._getChange,
  Support = this._getSupport,
  BattleStart_01 = this._getBattlestart_01,
  BattleStart_02 = this._getBattlestart_02,
  BattleStart_03 = this._getBattlestart_03,
  Abnormal_01 = this._getAbnormal_01,
  Abnormal_02 = this._getAbnormal_02,
  Abnormal_03 = this._getAbnormal_03,
  Combo200 = this._getCombo200,
  Combo500 = this._getCombo500,
  Combo900 = this._getCombo900,
  PetUltimateRelease = this._getPetultimaterelease,
  PetUltimateHint = this._getPetultimatehint,
  Counter = this._getCounter,
  KinsAttack = this._getKinsattack,
  UltimateSkillCheer = this._getUltimateskillcheer,
  BattleVictory = this._getBattlevictory,
  SupportFR = this._getSupportfr,
  SwitchFR = this._getSwitchfr,
  BossEnter = this._getBossenter,
  BossShown = this._getBossshown,
  BossStage_01 = this._getBossstage_01,
  BossStage_02 = this._getBossstage_02,
  BossStage_03 = this._getBossstage_03,
  BossWeak_01 = this._getBossweak_01,
  BossWeak_02 = this._getBossweak_02,
  BossDoneHit = this._getBossdonehit,
  BossUltimateSkill = this._getBossultimateskill,
  BossInvincible = this._getBossinvincible,
  BossSummon = this._getBosssummon,
  BossTransform = this._getBosstransform,
  BossKilled = this._getBosskilled,
  SummonBattle = this._getSummonbattle,
  ProprietaryKiboSkill = this._getProprietarykiboskill,
  StarlinkSuccess = this._getStarlinksuccess,
  StarlinkFail_01 = this._getStarlinkfail_01,
  StarlinkFail_02 = this._getStarlinkfail_02
}
return this
