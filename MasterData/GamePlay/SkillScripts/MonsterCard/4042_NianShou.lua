local bs_4042 = class("bs_4042", LuaSkillBase)
local base = LuaSkillBase
bs_4042.config = {buffId = 40421}

function bs_4042:ctor()
end

function bs_4042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_4042_01", 1, self.OnSetHurt, {
    sender = self.caster,
    targetBelongNum = eBattleRoleBelong.enemy
  })
end

function bs_4042:OnSetHurt(context)
  if context.isCrit == true then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_4042:LuaDispose()
  base.LuaDispose(self)
end

function bs_4042:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4042
