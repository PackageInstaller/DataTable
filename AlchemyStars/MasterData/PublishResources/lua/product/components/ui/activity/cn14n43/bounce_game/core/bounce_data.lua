_class("BounceData", Object)
BounceData = BounceData

function BounceData:Constructor()
  self.levelId = 0
  self.levelCfg = nil
  self.historyBestScore = 0
  self.startTime = 0
  self.targetScore = 0
  self.targetMonster = 0
  self.showHistory = nil
  self.genBossId = nil
  self.genBossScore = 0
  self:Reset()
end

function BounceData:Init(levelId, selectPlayer, historyBestScore)
  self.startTime = self:GetTime()
  if BounceDebug.TestPlayerRes then
    self.palyerRes = BounceDebug.TestPlayerRes
  else
    self.palyerRes = UIN28GronruGameConst.GetPlayerInfo(selectPlayer)[1]
  end
  if BounceDebug.TestLevelId then
    self.levelId = BounceDebug.TestLevelId
  else
    self.levelId = levelId
  end
  Log.debug("[bounce] init levelId = " .. levelId .. " use levelid = " .. self.levelId)
  self.levelCfg = Cfg.cfg_component_bounce_mission[self.levelId]
  self.historyBestScore = historyBestScore
  if not self.levelCfg then
    Log.fatal("err:can't find cfg_component_bounce_mission cfg with id = " .. self.levelId)
    return
  end
  self.targetScore = self.levelCfg.OverByScore or 0
  self.targetMonster = self.levelCfg.OverByKillMonster or 0
  if self.levelCfg.GenMonsterByScore then
    self.genBossScore = self.levelCfg.GenMonsterByScore[1]
    self.genBossId = self.levelCfg.GenMonsterByScore[2]
    self.genBossPos = Vector2(self.levelCfg.GenMonsterByScore[3], self.levelCfg.GenMonsterByScore[4])
  end
end

function BounceData:Reset()
  self.hasGenBoss = false
  self.isOvering = false
  self.score = 0
  self.durationMs = 0
  self.resultRecord = {}
  self.palyerRes = nil
  self.hasGenBoss = false
  self.isOvering = false
  self.overTime = 0
  self.killedBoss = false
  self.isGuiding = false
  self.guidingId = -1
end

function BounceData:GetIsGuiding()
  return self.isGuiding
end

function BounceData:SetIsGuiding(value)
  self.isGuiding = value
end

function BounceData:AddScore(score)
  self.score = self.score + score
end

function BounceData:GetScore()
  return self.score
end

function BounceData:GetLevelId()
  return self.levelId
end

function BounceData:GetTime()
  local timemodule = GameGlobal.GetModule(SvrTimeModule)
  local nowtime = timemodule:GetServerTime() / 1000
  return nowtime
end

function BounceData:GetLastTime()
  local time = math.ceil(self:GetTime() - self.startTime)
  return time
end

function BounceData:GetMissionId()
  return self.levelCfg.CampaignMissionId
end

function BounceData:AddHistoryBestScore()
  if self.score > self.historyBestScore then
    self.historyBestScore = self.score
  end
end

function BounceData:SetKilledBoss(killed)
  self.killedBoss = killed
end

function BounceData:GetKilledBoss()
  return self.killedBoss
end
