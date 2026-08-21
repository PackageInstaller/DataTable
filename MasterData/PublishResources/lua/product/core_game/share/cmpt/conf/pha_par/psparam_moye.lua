require("skill_phase_param_base")
_class("SkillPhaseMoyeParam", SkillPhaseParamBase)
SkillPhaseMoyeParam = SkillPhaseMoyeParam

function SkillPhaseMoyeParam:Constructor(t)
  self.monsterAnim = t.monsterAnim
  self.monsterEffID = t.monsterEffID
  self.monsterAudioID = t.monsterAudioID
  self.yieldTime = t.yieldTime or 0
  self.noMonsterAnim = t.noMonsterAnim
  self.noMonsterEffID = t.noMonsterEffID
  self.noMonsterAudioID = t.noMonsterAudioID
  self.yieldTimeNoMonster = t.yieldTimeNoMonster or 0
  self.monsterWeaponEffID = t.monsterWeaponEffID
  self.yieldTime1 = t.yieldTime1 or 0
  self.noMonsterWeaponEffID = t.noMonsterWeaponEffID
  self.yieldTime1NoMonster = t.yieldTime1NoMonster or 0
  self.trapIDs = t.trapIDs
  self.trajectoryEffID = t.trajectoryEffID
  self.flyTime = t.flyTime or 1100
  self.waitHitTime = t.waitHitTime or 120
  self.trajectoryEndEff = t.trajectoryEndEff
  self.trajectoryIntervalTime = t.trajectoryIntervalTime or 50
  self.yieldTime2 = t.yieldTime2 or 0
  self.yieldTime2TrapNoMonster = t.yieldTime2TrapNoMonster or 0
  self.yieldTime2Monster = t.yieldTime2Monster or 0
  self.yieldTime2NoMonster = t.yieldTime2NoMonster or 0
  self.lastPosEffID = t.lastPosEffID
  self.lastPosAudioID = t.lastPosAudioID
  self.yieldTime3 = t.yieldTime3 or 0
  self.teleportAnim = t.teleportAnim
  self.teleportAnimTime = t.teleportAnimTime or 500
  self.teleportEffID = t.teleportEffID
  self.teleportTime = t.teleportTime
  self.teleportWaitTime = t.teleportWaitTime or 700
end

function SkillPhaseMoyeParam:GetCacheTable()
  local t = {}
  if self.monsterEffID and self.monsterEffID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.monsterEffID].ResPath,
      1
    })
  end
  if self.monsterWeaponEffID and 0 < self.monsterWeaponEffID then
    table.insert(t, {
      Cfg.cfg_effect[self.monsterWeaponEffID].ResPath,
      1
    })
  end
  if self.noMonsterEffID and 0 < self.noMonsterEffID then
    table.insert(t, {
      Cfg.cfg_effect[self.noMonsterEffID].ResPath,
      1
    })
  end
  if self.noMonsterWeaponEffID and 0 < self.noMonsterWeaponEffID then
    table.insert(t, {
      Cfg.cfg_effect[self.noMonsterWeaponEffID].ResPath,
      1
    })
  end
  if self.trajectoryEffID and 0 < self.trajectoryEffID then
    table.insert(t, {
      Cfg.cfg_effect[self.trajectoryEffID].ResPath,
      1
    })
  end
  if self.lastPosEffID and 0 < self.lastPosEffID then
    table.insert(t, {
      Cfg.cfg_effect[self.lastPosEffID].ResPath,
      1
    })
  end
  if self.teleportEffID and 0 < self.teleportEffID then
    table.insert(t, {
      Cfg.cfg_effect[self.teleportEffID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseMoyeParam:GetCacheAudio()
  local t = {}
  if self.monsterAudioID and self.monsterAudioID > 0 then
    table.insert(t, self.monsterAudioID)
  end
  if self.noMonsterAudioID and 0 < self.noMonsterAudioID then
    table.insert(t, self.noMonsterAudioID)
  end
  if self.lastPosAudioID and 0 < self.lastPosAudioID then
    table.insert(t, self.lastPosAudioID)
  end
  return t
end

function SkillPhaseMoyeParam:GetPhaseType()
  return SkillViewPhaseType.Moye
end
