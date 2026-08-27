local bs_9023 = class("bs_9023", LuaSkillBase)
local base = LuaSkillBase
bs_9023.config = {}

function bs_9023:ctor()
end

function bs_9023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_9023", 1, self.OnAfterBattleStart)
  self:AddHurtResultStartTriggerForTable("bs_9023", 2, self.OnHurtResultStart, {
    senderBelongNum = eBattleRoleBelong.player,
    extraArg2 = false
  })
  self.Start_tag = nil
end

function bs_9023:OnAfterBattleStart()
  local target_Role
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetlist ~= nil then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].roleDataId == 1078 then
        target_Role = targetlist[i]
        self.Start_tag = true
        break
      end
    end
  end
  if self.Start_tag and targetlist ~= nil and target_Role ~= nil then
    target_Role:AddRoleProperty(eHeroAttr.damage_increase, self.arglist[2], eHeroAttrType.Origin)
  end
end

function bs_9023:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and self.Start_tag and context.sender.belongNum == self.caster.belongNum and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    LuaSkillCtrl:CallRecoverHeal(context.sender, self, 0, 0, 0)
  end
end

function bs_9023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_9023
