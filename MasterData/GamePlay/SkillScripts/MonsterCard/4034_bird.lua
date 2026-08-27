local bs_4034 = class("bs_4034", LuaSkillBase)
local base = LuaSkillBase
bs_4034.config = {buff_id = 40341}

function bs_4034:ctor()
end

function bs_4034:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_4034", 1, self.OnAfterHurt, {
    target = self.caster,
    extraArg3 = true
  })
  self.passiveCd = 0
end

function bs_4034:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  local battleCtrl = LuaSkillCtrl.battleCtrl
  local curFrame = battleCtrl.frame
  if curFrame < self.passiveCd then
    return
  end
  if isMiss == true and target ~= nil and target.hp > 0 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_id, 1, self.arglist[2])
    self.passiveCd = curFrame + self.arglist[3]
  end
end

function bs_4034:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4034
