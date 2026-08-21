_class("MonsterData", Object)
MonsterData = MonsterData

function MonsterData:Constructor(monsterId)
  self.camp = BounceCamp.Monster
  local cfg = Cfg.cfg_bounce_monster[monsterId]
  self.initHp = cfg.InitHp
  self.hp = self.initHp
  self.durationMS = 0
  self.cfg = cfg
end

function MonsterData:ChgCamp()
  if self.camp == BounceCamp.Player then
    self.camp = BounceCamp.Monster
  elseif self.camp == BounceCamp.Monster then
    self.camp = BounceCamp.Player
  end
end

function MonsterData:Reset()
  self.camp = BounceCamp.Monster
  self.durationMS = 0
  self.underPlayer = false
end

function MonsterData:GetMaxHp()
  return self.initHp
end
