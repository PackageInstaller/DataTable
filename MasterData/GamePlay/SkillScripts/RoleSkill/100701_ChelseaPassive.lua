local bs_100701 = class("bs_100701", LuaSkillBase)
local base = LuaSkillBase
bs_100701.config = {
  hurtConfigId = 2,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  buffId_BingDong = 1178,
  weaponLv = 0
}

function bs_100701:ctor()
end

function bs_100701:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_100701_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 100700)
  self.num = 0
end

function bs_100701:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.dataId == 100700 then
    local targets = self:GetBehindTargetsPos(2, self.caster.x, self.caster.y, target.x, target.y)
    local targetNext
    if targets ~= nil and 2 <= table.length(targets) and targets[2].belongNum ~= self.caster.belongNum then
      targetNext = targets[2]
    end
    if targetNext ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetNext)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[1]
      })
      skillResult:EndResult()
    end
    if 1 <= self.config.weaponLv then
      self.num = self.num + 1
      if self.num >= self.arglist[2] then
        self.num = 0
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_BingDong, 1, 75)
        if targetNext ~= nil then
          LuaSkillCtrl:CallBuff(self, targetNext, self.config.buffId_BingDong, 1, 75)
        end
      end
    end
  end
end

function bs_100701:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100701
