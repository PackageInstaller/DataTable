local bs_4033 = class("bs_4033", LuaSkillBase)
local base = LuaSkillBase
bs_4033.config = {buff_id = 40331}

function bs_4033:ctor()
end

function bs_4033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4033_1", 1, self.OnAfterBattleStart)
  self.target = nil
  self:AddAfterHurtTriggerForTable("bs_4033_2", 2, self.OnAfterHurt, {
    extraArg2 = false,
    target = self.target
  })
end

function bs_4033:OnAfterBattleStart()
  local highHpRole = LuaSkillCtrl:CallTargetSelect(self, 68, 20)
  if highHpRole ~= nil and highHpRole.Count > 0 and highHpRole[0] ~= nil then
    self.target = highHpRole[0].targetRole
  end
end

function bs_4033:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender ~= nil and sender.hp > 0 and sender.belongNum == 2 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buff_id, 1, self.arglist[2])
  end
end

function bs_4033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4033
