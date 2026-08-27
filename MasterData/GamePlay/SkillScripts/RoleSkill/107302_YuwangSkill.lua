local bs_107302 = class("bs_107302", LuaSkillBase)
local base = LuaSkillBase
bs_107302.config = {
  buffId_bati = 107301,
  skill_time = 30,
  actionId = 1002,
  action_speed = 1,
  actionId_start_time = 15,
  effect_sheild = 107303,
  audio_start = 107304
}

function bs_107302:ctor()
end

function bs_107302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107302:PlaySkill(data)
  local time = self.config.skill_time
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
end

function bs_107302:OnAttackTrigger(data)
  local shieldValue = self.caster.skill_intensity * self.arglist[2] // 1000
  local playerTargetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, playerTargetList.Count - 1 do
    local role = playerTargetList[i]
    local IfRoleCotainsUnselectedBuff = LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.NotBeSelected)
    if IfRoleCotainsUnselectedBuff == false and role.recordTable.WillowPic ~= true then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId_bati, 1, self.arglist[1], true)
      if 0 < shieldValue then
        LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
        LuaSkillCtrl:PlayAuSource(self.caster, self.config.audio_start)
      end
    end
  end
end

function bs_107302:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_107302:LuaDispose()
  base.LuaDispose(self)
end

return bs_107302
