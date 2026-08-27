local bs_4004 = class("bs_4004", LuaSkillBase)
local base = LuaSkillBase
bs_4004.config = {
  buffId = 107101,
  buffId_addDamage = 40041,
  effect = 212115,
  effect_big = 212121,
  effect_small = 212120,
  HurtConfigID = 3
}

function bs_4004:ctor()
end

function bs_4004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
  self:AddAfterAddBuffTrigger("bs_4004_1", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId)
  self.energy_num = 0
end

function bs_4004:OnAfterAddBuff(buff, target)
  self.energy_num = self.energy_num + 1
  if self.energy_num >= self.arglist[1] then
    self:doskill()
    self.energy_num = 0
  end
end

function bs_4004:doskill()
  if self.MapBorder.x == 6 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(2, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effect_small, self)
  elseif self.MapBorder.x == 7 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effect, self)
  elseif self.MapBorder.x == 10 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(4, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effect_big, self)
  end
  local skill_intensity = 0
  local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if 0 < targetlist1.Count then
    for i = 0, targetlist1.Count - 1 do
      if skill_intensity <= targetlist1[i].skill_intensity then
        skill_intensity = targetlist1[i].skill_intensity
      end
    end
  end
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if 0 < targetList.Count then
    for i = targetList.Count - 1, 0, -1 do
      local damage = self.arglist[2] * skill_intensity // 1000
      LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_addDamage, 1, self.arglist[4])
      LuaSkillCtrl:RemoveLife(damage, self, targetList[i], true, nil, true, false, eHurtType.RealDmg)
    end
  end
end

function bs_4004:LuaDispose()
  base.LuaDispose(self)
end

function bs_4004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4004
