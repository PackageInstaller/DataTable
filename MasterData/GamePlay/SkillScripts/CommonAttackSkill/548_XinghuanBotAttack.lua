local bs_548 = class("bs_548", LuaSkillBase)
local base = LuaSkillBase
bs_548.config = {
  action_start = 1034,
  action_speed = 1,
  start_time_1 = 15,
  effect_boom = 107210
}

function bs_548:ctor()
end

function bs_548:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_548:PlaySkill()
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
    if not LuaSkillCtrl.IsInVerify then
      self.caster.lsObject.gameObject:SetActive(false)
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effect_boom, self)
    LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, true, nil, false, true, eHurtType.RealDmg, true)
  end
end

function bs_548:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_548:LuaDispose()
  base.LuaDispose(self)
end

return bs_548
