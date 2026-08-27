local bs_15168 = class("bs_15168", LuaSkillBase)
local base = LuaSkillBase
bs_15168.config = {effectId_1 = 12083, hurtConfig = 14}

function bs_15168:ctor()
end

function bs_15168:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_15168_1", 1, self.OnAfterPlaySkill, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_15168:OnAfterPlaySkill(skill, role)
  if not self:IsReadyToTake() then
    return
  end
  local maxRole, pow = LuaSkillCtrl:CallFindMaxPowOrSkillIntensityRole()
  local damage = pow * self.arglist[1] // 1000
  self:OnSkillTake()
  self.timer = LuaSkillCtrl:StartTimer(self, 10, BindCallback(self, self.CallBack, damage), nil, self.arglist[2])
end

function bs_15168:CallBack(damage)
  local roleList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for i = 0, roleList.Count - 1 do
    local role = roleList[i]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {damage}, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(role, self.config.effectId_1, self)
  end
end

function bs_15168:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_15168:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15168
