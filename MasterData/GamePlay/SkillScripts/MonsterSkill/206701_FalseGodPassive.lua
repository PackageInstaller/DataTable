local bs_206701 = class("bs_206701", LuaSkillBase)
local base = LuaSkillBase
bs_206701.config = {
  buffId_superArmor = 2067011,
  buffId_curse = 2067012,
  buffId_curseLabel1 = 2067013,
  buffId_curseLabel2 = 2067014,
  buffId_curseLabel3 = 2067015,
  effectId_curse = 2067011
}

function bs_206701:ctor()
end

function bs_206701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_206701_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_206701_2", 99, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 206700)
  self.caster.recordTable.curse = self.arglist[1]
end

function bs_206701:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_superArmor, 1, nil)
  end
  self.caster:AddRoleProperty(eHeroAttr.cd_reduce, 1000, eHeroAttrType.Extra)
end

function bs_206701:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack == true and isMiss == false then
    if target == nil or target.hp <= 0 then
      return
    end
    local frontTarget = self.caster.recordTable.frontTarget
    if frontTarget ~= nil and frontTarget ~= target then
      local falseGodEnermy = eBattleRoleBelong.player
      if self.caster.belongNum == eBattleRoleBelong.player then
        falseGodEnermy = eBattleRoleBelong.enemy
      end
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(falseGodEnermy)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          frontTarget = targetList[i]
          LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curse, 0, true)
          LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curseLabel1, 0, true)
          LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curseLabel3, 0, true)
        end
      end
    end
    self.caster.recordTable.frontTarget = target
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curse, 1)
    self:CurseLabel(target)
    if self.caster.recordTable.RootCurseUp ~= nil then
      local extraCurse = LuaSkillCtrl:CallRange(1, 1000)
      if extraCurse <= self.caster.recordTable.RootCurseUp then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curse, 1)
        self:CurseLabel(target)
      end
    end
  end
end

function bs_206701:CurseLabel(target)
  local labelTier = target:GetBuffTier(self.config.buffId_curse)
  if labelTier <= 6 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_curseLabel3, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curseLabel1, 1)
  else
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_curseLabel1, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curseLabel3, 1)
  end
end

function bs_206701:OnCasterDie()
end

return bs_206701
