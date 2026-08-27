local bs_70008 = class("bs_70008", LuaSkillBase)
local base = LuaSkillBase
bs_70008.config = {
  buffId1 = 198,
  effectId = 12021,
  timeDuration = 15
}

function bs_70008:ctor()
end

function bs_70008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70008_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_70008_2", 2, self.OnAfterHurt, nil, self.caster)
  self.lastHpPercent = 100
  self.totalTime = 525
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

function bs_70008:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_70008:TimeUp()
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_70008:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
end

function bs_70008:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if target == self.caster and not isMiss then
    local nowHpPercent = target.hp * 100 // target.maxHp
    local diff = self.lastHpPercent - nowHpPercent
    if diff > self.arglist[1] // 10 then
      local diffBiLi = diff * 10 // self.arglist[1]
      LuaSkillCtrl:AddPlayerTowerMp(diffBiLi * self.arglist[2])
      self.lastHpPercent = self.lastHpPercent - diffBiLi * self.arglist[1] // 10
    end
    if diff > self.arglist[1] // 50 then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
    end
  end
end

function bs_70008:OnCasterDie()
  self.lastHpPercent = nil
  base.OnCasterDie(self)
end

return bs_70008
