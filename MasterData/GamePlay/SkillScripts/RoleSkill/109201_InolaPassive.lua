local bs_109201 = class("bs_109201", LuaSkillBase)
local base = LuaSkillBase
bs_109201.config = {
  buffId_huyou = 109201,
  buffId_meihuo = 109202,
  buffId_tar_steal_1 = 109203,
  buffId_tar_steal_2 = 109204,
  buffId_tar_steal_3 = 109205,
  effect_1 = 109203,
  extra_skill = 109210
}

function bs_109201:ctor()
end

function bs_109201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.atk = true
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_109201_2", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_109201_4", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_huyou)
  self:AddBeforePlaySkillTrigger("bs_109201_2", 1, self.OnBeforePlaySkill, nil, nil, self.caster.belongNum, nil, nil, nil, nil, eSkillTag.normalSkill)
  LuaSkillCtrl:AddExtraAddSkill(self.config.extra_skill, self.level)
  local skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
  skillCasterEntity.recordTable.passiveArg1 = self.arglist[1]
end

function bs_109201:OnBeforePlaySkill(role, context)
  if role ~= self.caster then
    self:OnAddbuff(role)
  end
end

function bs_109201:OnAfterBattleStart()
  local list = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, list.Count - 1 do
    local role = list[i]
    if role ~= self.caster and role.roleType == eBattleRoleType.character then
      self:OnAddbuff(role)
      LuaSkillCtrl:CallEffect(role, self.config.effect_1, self)
    end
  end
end

function bs_109201:OnAddbuff(target)
  if target.recordTable.AttrUp == true then
    target:AddRoleProperty(eHeroAttr.skill_intensity, -target.recordTable.AttrUpNum, eHeroAttrType.Extra)
    local AttrDamageNum = self.caster.skill_intensity * self.arglist[1] // 1000
    target.recordTable.AttrUpNum = AttrDamageNum
    target:AddRoleProperty(eHeroAttr.skill_intensity, AttrDamageNum, eHeroAttrType.Extra)
  else
    local AttrDamageNum = self.caster.skill_intensity * self.arglist[1] // 1000
    target.recordTable.AttrUpNum = AttrDamageNum
    target.recordTable.AttrUp = true
    target:AddRoleProperty(eHeroAttr.skill_intensity, AttrDamageNum, eHeroAttrType.Extra)
  end
end

function bs_109201:OnAfterAddBuff(buff, target)
  if target.belongNum == self.caster.belongNum then
    return
  end
  if target:GetBuffTier(self.config.buffId_tar_steal_1) + target:GetBuffTier(self.config.buffId_tar_steal_2) + target:GetBuffTier(self.config.buffId_tar_steal_3) < self.arglist[6] then
    local AttrSkill_intensityNum = target.skill_intensity * self.arglist[2] // 1000
    target:AddRoleProperty(eHeroAttr.skill_intensity, -AttrSkill_intensityNum, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.skill_intensity, AttrSkill_intensityNum, eHeroAttrType.Extra)
    LuaSkillCtrl:StartTimer(nil, self.arglist[5], function()
      self.caster:AddRoleProperty(eHeroAttr.skill_intensity, -AttrSkill_intensityNum, eHeroAttrType.Extra)
      if target.hp > 0 then
        target:AddRoleProperty(eHeroAttr.skill_intensity, AttrSkill_intensityNum, eHeroAttrType.Extra)
      end
    end, nil, 0, 0)
    if target:GetBuffTier(self.config.buffId_tar_steal_1) == 0 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tar_steal_1, 1, self.arglist[5])
    elseif target:GetBuffTier(self.config.buffId_tar_steal_2) == 0 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tar_steal_2, 1, self.arglist[5])
    elseif target:GetBuffTier(self.config.buffId_tar_steal_3) == 0 then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tar_steal_3, 1, self.arglist[5])
    end
  end
  if target:GetBuffTier(self.config.buffId_huyou) >= self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_meihuo, 1, self.arglist[4])
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_huyou, 0)
  end
end

function bs_109201:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_109201:LuaDispose()
  base.LuaDispose(self)
end

return bs_109201
