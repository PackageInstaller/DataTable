local bs_204805 = class("bs_204805", LuaSkillBase)
local base = LuaSkillBase
bs_204805.config = {
  buff = 2048039,
  buffFeature_ignoreDie = 6,
  buffId_SuperArmor = 2048036,
  buffId_attackCD = 104205,
  start_time = 13
}

function bs_204805:ctor()
end

function bs_204805:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:SelfDie()
end

function bs_204805:SelfDie()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_SuperArmor, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.start_time, true)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
    if IfRoleCotainsIgnoreDieBuff == true then
      local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
      if buff_ignoreDie.Count > 0 then
        for i = 0, buff_ignoreDie.Count - 1 do
          LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0)
          IfRoleCotainsIgnoreDieBuff = false
        end
      end
    end
    if 0 < self.caster.hp and IfRoleCotainsIgnoreDieBuff == false then
      LuaSkillCtrl:RemoveLife(self.caster.hp, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
    end
  end)
end

function bs_204805:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_204805:LuaDispose()
  base.LuaDispose(self)
end

return bs_204805
