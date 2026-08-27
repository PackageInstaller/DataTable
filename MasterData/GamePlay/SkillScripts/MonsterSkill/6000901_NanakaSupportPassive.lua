local bs_6000900 = class("bs_6000900", LuaSkillBase)
local base = LuaSkillBase
bs_6000900.config = {effectId_loop = 600901, effectId_skill = 600902}

function bs_6000900:ctor()
end

function bs_6000900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6000900", 1, self.OnAfterBattleStart)
  self:AddAfterPlaySkillTrigger("bs_6000900", 1, self.OnAfterPlaySkill, nil, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_6000900:OnAfterBattleStart()
  local effect
  self.timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    LuaSkillCtrl:CallAddPlayerHmp(ConfigData.game_config.ultMpCost * self.arglist[2] // 1000)
    effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  end, nil, -1, self.arglist[1])
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end, nil, -1, 0)
end

function bs_6000900:OnAfterPlaySkill(skill, role)
  if role.belongNum == eBattleRoleBelong.player and skill.isUltSkill then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self)
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local targetRole = targetList[i]
        LuaSkillCtrl:ClearShield(targetRole, 0)
        local buffs = LuaSkillCtrl:GetRoleBuffs(targetRole)
        if buffs ~= nil and buffs.Count > 0 then
          for i = 0, buffs.Count - 1 do
            if buffs[i].buffType == 1 then
              LuaSkillCtrl:DispelBuff(targetRole, buffs[i].dataId, 0, false)
            end
          end
        end
      end
    end
  end
end

function bs_6000900:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_6000900
