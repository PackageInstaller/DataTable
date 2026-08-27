local bs_102102 = require("GamePlay.SkillScripts.RoleSkill.102102_GrooveSkill")
local bs_102104 = class("bs_102104", bs_102102)
local base = bs_102102
bs_102104.config = {buffId_dodge = 102108, weaponLv = 1}
bs_102104.config = setmetatable(bs_102104.config, {
  __index = base.config
})

function bs_102104:ctor()
end

function bs_102104:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102104:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss and target.roleType == eBattleRoleType.character and target:GetBuffTier(self.config.buffId_dodge) > 0 then
    local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetlist.Count then
      for i = 0, targetlist.Count - 1 do
        LuaSkillCtrl:CallBuff(self, targetlist[i], self.config.buffId_attackfast, 1, self.arglist[5])
      end
    end
  end
end

function bs_102104:OnAttackTrigger()
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetlist[i], self.config.buffId_dodge, 1, self.arglist[4])
      LuaSkillCtrl:CallBuff(self, targetlist[i], self.config.buffId_dodge2, 1, self.arglist[4])
    end
  end
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 302103 then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop2, self, nil, nil, nil, true)
  end
  LuaSkillCtrl:StartTimer(self, self.arglist[4], function()
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 302103 and self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_lockCd, 0, true)
    if self.audioloop ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.audioloop)
    end
  end)
end

function bs_102104:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102104
