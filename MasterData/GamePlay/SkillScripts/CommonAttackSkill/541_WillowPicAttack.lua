local bs_541 = class("bs_541", LuaSkillBase)
local base = LuaSkillBase
bs_541.config = {
  buffId_Taunt = 3002,
  buffId_Blind = 3012,
  buffFeature_ignoreDie = 6
}

function bs_541:ctor()
end

function bs_541:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.WillowPic = true
  self:AddSetHurtTrigger("bs_541_1", 99, self.OnSetHurt, nil, self.caster)
  self:AddSetHealTrigger("bs_541_2", 99, self.OnAfterHeal, nil, self.caster)
  self:AddBeforeAddBuffTrigger("bs_541_3", 1, self.OnBeforeAddBuff, nil, self.caster)
  self.arg1 = self.caster.recordTable.arg_1
  self.arg2 = self.caster.recordTable.arg_2
  self.arg3 = self.caster.recordTable.arg_3
  local over = BindCallback(self, self.Onover)
  LuaSkillCtrl:StartTimer(nil, self.arg2, over)
  self.over_time = true
  LuaSkillCtrl:StartTimer(nil, self.arg2 - 1, function()
    self.over_time = false
  end)
end

function bs_541:PlaySkill()
  local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetlist_enemy.Count > 0 then
    for i = 0, targetlist_enemy.Count - 1 do
      if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
        LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], self.config.buffId_Taunt, 1, self.arg2)
      end
    end
  end
end

function bs_541:Onover()
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, self.config.buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, self.config.buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, buff_ignoreDie[i].dataId, 0, true)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  if 0 < self.caster.hp and IfRoleCotainsIgnoreDieBuff == false then
    LuaSkillCtrl:RemoveLife(self.caster.hp + 10000, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
    local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
    if targetlist_enemy.Count > 0 then
      for i = 0, targetlist_enemy.Count - 1 do
        if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
          LuaSkillCtrl:DispelBuffByMaker(self.caster, targetlist_enemy[i], self.config.buffId_Taunt, 1)
          LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], self.config.buffId_Blind, 1, self.arg3)
        end
      end
    end
  end
end

function bs_541:OnSetHurt(context)
  if context.target == self.caster and context.hurt > 0 and self.over_time == true then
    context.hurt = 1
  end
end

function bs_541:OnAfterHeal(context)
  if context.target == self.caster and context.heal > 0 and self.over_time == true then
    context.heal = 0
  end
end

function bs_541:OnBeforeAddBuff(target, context)
  if target == self.caster and context.buff.battleSkill.dataId ~= 102901 and context.buff.battleSkill.dataId ~= 198 then
    context.active = false
  end
end

function bs_541:OnCasterDie()
  local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetlist_enemy.Count > 0 then
    for i = 0, targetlist_enemy.Count - 1 do
      if targetlist_enemy[i].belongNum == eBattleRoleBelong.enemy and not targetlist_enemy[i]:IsUnSelect(self.caster) then
        LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], self.config.buffId_Blind, 1, self.arg3)
      end
    end
  end
  base.OnCasterDie(self)
end

return bs_541
