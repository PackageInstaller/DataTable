local bs_103302 = class("bs_103302", LuaSkillBase)
local base = LuaSkillBase
bs_103302.config = {
  actionId = 1002,
  skill_time = 19,
  start_time = 8,
  skill_speed = 1,
  selectId_skill = 45,
  buffId_tab = 103302,
  effectId_start = 103305,
  audioId1 = 103304,
  buffId_170 = 170
}

function bs_103302:ctor()
end

function bs_103302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103302:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, 10)
  if targetList.Count <= 0 then
    return
  end
  local skilltime = self.config.skill_time * 100 // (self.config.skill_speed * 100)
  local starttime = self.config.start_time * 100 // (self.config.skill_speed * 100)
  self:CallCasterWait(skilltime)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, targetList)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, starttime, triggerCallBack)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, starttime + self.arglist[1], true)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
end

function bs_103302:OnActionCallBack(targetList)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role.belongNum ~= eBattleRoleBelong.neutral then
        local time = 5 - i
        if 0 < time then
          local buff = LuaSkillCtrl:CallBuff(self, role, self.config.buffId_tab, time, self.arglist[1])
          if not LuaSkillCtrl.IsInVerify and buff ~= nil and buff.listBattleEffect ~= nil then
            for i = 0, buff.listBattleEffect.Count - 1 do
              local effect = buff.listBattleEffect[i]
              if effect ~= nil then
                local num = 5 - time
                effect:SetCountValue(num)
              end
            end
          end
        end
      end
    end
  end
end

function bs_103302:OnBreakSkill(role)
  if role == self.caster and self.isSkillUncompleted == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_103302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103302
