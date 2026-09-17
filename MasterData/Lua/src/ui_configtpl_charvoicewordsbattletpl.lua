local this = class("charVoiceWordsBattleTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getTagValue(tpl, tag)
  return L_Config:provider(tpl[tag])
end

function this:getDischarge(tpl)
  return tpl.Discharge
end

function this:getBattleStart01(tpl)
  return tpl.BattleStart_01
end

function this:getQiboCapture(tpl)
  return tpl.QiboCapture
end

function this:getBossTransform(tpl)
  return tpl.BossTransform
end

function this:getAttackMedium002(tpl)
  return tpl.AttackMedium_002
end

function this:getEnemyBreak(tpl)
  return tpl.EnemyBreak
end

function this:getBeHitStrong001(tpl)
  return tpl.BeHitStrong_001
end

function this:getBossSummon(tpl)
  return tpl.BossSummon
end

function this:getBossInvincible(tpl)
  return tpl.BossInvincible
end

function this:getDodge(tpl)
  return tpl.Dodge
end

function this:getEliteDefeated(tpl)
  return tpl.EliteDefeated
end

function this:getBossWeak02(tpl)
  return tpl.BossWeak_02
end

function this:getAttackLight001(tpl)
  return tpl.AttackLight_001
end

function this:getBossKilled(tpl)
  return tpl.BossKilled
end

function this:getKinsAttack(tpl)
  return tpl.KinsAttack
end

function this:getBossWeak01(tpl)
  return tpl.BossWeak_01
end

function this:getBossStage03(tpl)
  return tpl.BossStage_03
end

function this:getBreakCheer(tpl)
  return tpl.BreakCheer
end

function this:getCounter(tpl)
  return tpl.Counter
end

function this:getBossStage01(tpl)
  return tpl.BossStage_01
end

function this:getCombo200(tpl)
  return tpl.Combo200
end

function this:getBossEnter(tpl)
  return tpl.BossEnter
end

function this:getOverDrive(tpl)
  return tpl.OverDrive
end

function this:getAttackMedium003(tpl)
  return tpl.AttackMedium_003
end

function this:getHealed(tpl)
  return tpl.Healed
end

function this:getCombo900(tpl)
  return tpl.Combo900
end

function this:getUltimateSkillCheer(tpl)
  return tpl.UltimateSkillCheer
end

function this:getDown(tpl)
  return tpl.Down
end

function this:getBossShown(tpl)
  return tpl.BossShown
end

function this:getBattleVictory(tpl)
  return tpl.BattleVictory
end

function this:getBossStage02(tpl)
  return tpl.BossStage_02
end

function this:getPetUltimateHint(tpl)
  return tpl.PetUltimateHint
end

function this:getPetUltimateRelease(tpl)
  return tpl.PetUltimateRelease
end

function this:getSwitchFR(tpl)
  return tpl.SwitchFR
end

function this:getCombo500(tpl)
  return tpl.Combo500
end

function this:getSupportFR(tpl)
  return tpl.SupportFR
end

function this:getAbnormal01(tpl)
  return tpl.Abnormal_01
end

function this:getAttackLight002(tpl)
  return tpl.AttackLight_002
end

function this:getBossDoneHit(tpl)
  return tpl.BossDoneHit
end

function this:getBattleStart03(tpl)
  return tpl.BattleStart_03
end

function this:getHPLow(tpl)
  return tpl.HPLow
end

function this:getAbnormal02(tpl)
  return tpl.Abnormal_02
end

function this:getNormalSkill(tpl)
  return tpl.NormalSkill
end

function this:getAttackHeavy003(tpl)
  return tpl.AttackHeavy_003
end

function this:getSupport(tpl)
  return tpl.Support
end

function this:getAbnormal03(tpl)
  return tpl.Abnormal_03
end

function this:getBeHit001(tpl)
  return tpl.BeHit_001
end

function this:getDischargeAble(tpl)
  return tpl.DischargeAble
end

function this:getUltimateSkillEnd(tpl)
  return tpl.UltimateSkillEnd
end

function this:getSwitch(tpl)
  return tpl.Switch
end

function this:getBossUltimateSkill(tpl)
  return tpl.BossUltimateSkill
end

function this:getAttackMedium001(tpl)
  return tpl.AttackMedium_001
end

function this:getUltimateSkillFace(tpl)
  return tpl.UltimateSkillFace
end

function this:getBeHitStrong002(tpl)
  return tpl.BeHitStrong_002
end

function this:getBeHit002(tpl)
  return tpl.BeHit_002
end

function this:getAttackLight003(tpl)
  return tpl.AttackLight_003
end

function this:getAttackHeavy001(tpl)
  return tpl.AttackHeavy_001
end

function this:getId(tpl)
  return tpl.id
end

function this:getUltimateSkillAttack(tpl)
  return tpl.UltimateSkillAttack
end

function this:getBattleStart02(tpl)
  return tpl.BattleStart_02
end

function this:getAttackHeavy002(tpl)
  return tpl.AttackHeavy_002
end

return this
