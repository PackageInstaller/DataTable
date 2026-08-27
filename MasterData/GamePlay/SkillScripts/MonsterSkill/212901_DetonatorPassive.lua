local bs_212901 = class("bs_212901", LuaSkillBase)
local base = LuaSkillBase
bs_212901.config = {
  buffId = 107101,
  HurtConfigID = 3,
  effectId = 212701,
  buffId1 = 179,
  buffId2 = 1033,
  buffId3 = 198,
  buffId4 = 88,
  combo_buff = 2211
}

function bs_212901:ctor()
end

function bs_212901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_212901_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTriggerForTable("bs_212901_2", 1, self.OnAfterAddBuff, {
    senderBelongNum = eBattleRoleBelong.player,
    targetBelongNum = eBattleRoleBelong.enemy,
    buffId = 107101
  })
  self.isCanReduceCd = true
  self.ReduceTimes = 0
end

function bs_212901:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId4, 1, nil, true)
end

function bs_212901:OnAfterAddBuff(buff, target)
  if not self.isCanReduceCd then
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, 12075, self)
  LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[3])
  self.ReduceTimes = self.ReduceTimes + 1
  if self.ReduceTimes >= self.arglist[4] then
    self.isCanReduceCd = false
    self.ReduceTimes = 0
  end
end

function bs_212901:PlaySkill(data)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  LuaSkillCtrl:StartTimer(nil, 6, function()
    self.isCanReduceCd = true
    local skill_intensity = 0
    local max_role
    local targetlist1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetlist1.Count then
      for i = 0, targetlist1.Count - 1 do
        if skill_intensity <= targetlist1[i].skill_intensity then
          skill_intensity = targetlist1[i].skill_intensity
          max_role = targetlist1[i]
        end
      end
    end
    LuaSkillCtrl:CallBuff(self, max_role, self.config.combo_buff, 1, nil, true)
    if LuaSkillCtrl.IsInBrotatoBattle then
      local targetList = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 5, false)
      if 0 < targetList.Count then
        for i = targetList.Count - 1, 0, -1 do
          local damage = self.arglist[2] * skill_intensity // 1000
          local target = targetList[i]
          LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnDetonatorCastSkill, max_role, target, damage)
        end
      end
    else
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
      if 0 < targetList.Count then
        for i = targetList.Count - 1, 0, -1 do
          if targetList[i].targetRole.belongNum == eBattleRoleBelong.enemy then
            local damage = self.arglist[2] * skill_intensity // 1000
            local target = targetList[i]
            LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnDetonatorCastSkill, max_role, target, damage)
          end
        end
      end
    end
  end, nil, 0, 0)
end

function bs_212901:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212901
