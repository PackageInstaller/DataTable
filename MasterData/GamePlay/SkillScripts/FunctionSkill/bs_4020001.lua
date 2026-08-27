local bs_4020001 = class("bs_4020001", LuaSkillBase)
local base = LuaSkillBase
bs_4020001.config = {
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  effectId = 12073,
  HurtConfigId = 14,
  buffId = 2090
}

function bs_4020001:ctor()
end

function bs_4020001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4020001_1", 1, self.OnBattleStart)
  self.timer = nil
end

function bs_4020001:OnBattleStart()
  local arriveCallBack = BindCallback(self, self.eventFunc)
  self.timer = LuaSkillCtrl:StartTimer(self, self.arglist[1], arriveCallBack, nil, -1)
end

function bs_4020001:eventFunc()
  local target_grid = LuaSkillCtrl:CallFindGridMostRolesArounded(eBattleRoleBelong.enemy)
  if target_grid == nil then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(target_grid.x, target_grid.y)
  if target == nil then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  if skillResult.roleList.Count > 0 then
    for i = 0, skillResult.roleList.Count - 1 do
      local targetRole = skillResult.roleList[i]
      if targetRole.belongNum == eBattleRoleBelong.enemy then
        LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId, 1, self.arglist[3], nil)
        local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult1, self.config.HurtConfigId, {
          self.arglist[2]
        }, true, true)
        skillResult1:EndResult()
      end
    end
  end
  skillResult:EndResult()
end

function bs_4020001:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_4020001:LuaDispose()
  base.LuaDispose(self)
  self.timer = nil
end

return bs_4020001
