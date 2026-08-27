local Feature_1065 = class("Feature_1065", LuaSkillBase)
local base = LuaSkillBase
Feature_1065.config = {effect = 12136, enemy_caster_dataId = 117}

function Feature_1065:ctor()
end

function Feature_1065:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], BindCallback(self, self.TimerEvent), nil, -1)
end

function Feature_1065:TimerEvent()
  local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  for k, v in pairs(enemylist) do
    if self.caster ~= v and v.roleDataId ~= self.config.enemy_caster_dataId then
      local s_value = self.caster.maxHp * self.arglist[2] // 1000
      LuaSkillCtrl:AddRoleShield(v, 0, s_value)
    end
  end
end

function Feature_1065:ClearShiled()
  local enemylist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if enemylist == nil or enemylist.Count < 1 then
    return
  end
  for k, v in pairs(enemylist) do
    if self.caster ~= v and v.roleDataId ~= self.config.enemy_caster_dataId then
      LuaSkillCtrl:CallEffect(v, self.config.effect, self, nil, self.caster)
      LuaSkillCtrl:ClearAllShield(v)
    end
  end
end

function Feature_1065:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
  self:ClearShiled()
end

return Feature_1065
