local bs_60006 = class("bs_60006", LuaSkillBase)
local base = LuaSkillBase
bs_60006.config = {
  buffId1 = 175,
  buffId2 = 1033,
  buffId3 = 198,
  buffId = 3010,
  buffStun = 66,
  buffUndefeatable = 88,
  buffIds1 = 302901,
  buffIds2 = 302902,
  effectId_skill = 208302,
  time_hurt = 4,
  effectId_trail = 302903,
  buffIdjx = 302903,
  effectId_Z = 302906,
  time_strat = 15
}

function bs_60006:ctor()
end

function bs_60006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60006_1", 1, self.OnAfterBattleStart)
  self.buff_list = {}
end

function bs_60006:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 302907, 1, 999999, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdjx, self.arglist[5], 999999, true)
end

function bs_60006:PlaySkill(data)
  self.buff_list = {}
  if self.caster.recordTable.cando == 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffIdjx, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 1002)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Z, self)
    LuaSkillCtrl:StartTimer(nil, 4, function()
      local num = self.arglist[2]
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      local targetList1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
      if targetList ~= nil and targetList1 ~= nil then
        if targetList.Count < targetList1.Count then
          if targetList1[0] ~= nil then
            self:RealPlaySkill(nil, targetList1[0], 1, 1, 0)
            self.buff_list[targetList1[0]] = true
          end
        elseif targetList[0] ~= nil then
          self:RealPlaySkill(nil, targetList[0], 1, 0, 0)
          self.buff_list[targetList[0]] = true
        end
      end
    end)
  end
end

function bs_60006:RealPlaySkill(sender, target, JNId, Belong, IsChange)
  if sender == nil then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, false, false, self.SkillEventFunc, JNId, Belong, IsChange)
    end)
  elseif JNId <= 1 then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, sender, false, false, self.SkillEventFunc, JNId, Belong, IsChange)
    end)
  else
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, sender, false, false, self.SkillEventFunc, JNId, Belong, IsChange)
    end)
  end
end

function bs_60006:SkillEventFunc(JNId, Belong, IsChange, effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, self.config.time_hurt, function()
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffIds1, 1, self.arglist[1])
    end)
    local num = self.arglist[2]
    if JNId < self.arglist[2] then
      if Belong == 0 then
        local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
        local targetList1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
        local num = targetList.Count
        local IsSet = flase
        if IsChange == 0 and targetList ~= nil and targetList.Count ~= 0 then
          for i = 0, targetList.Count - 1 do
            if self.buff_list[targetList[i]] == nil then
              self:RealPlaySkill(target.targetRole, targetList[i], JNId + 1, 0, 0)
              self.buff_list[targetList[i]] = true
              IsSet = true
              break
            end
          end
          IsChange = 1
        end
        if IsSet == flase and IsChange == 1 and targetList1 ~= nil and targetList1.Count ~= 0 then
          for i = 0, targetList1.Count - 1 do
            if self.buff_list[targetList1[i]] == nil then
              self:RealPlaySkill(target.targetRole, targetList1[i], JNId + 1, 0, 1)
              self.buff_list[targetList1[i]] = true
              break
            end
          end
        end
      elseif Belong == 1 then
        local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
        local targetList1 = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
        local num = targetList.Count
        local IsSet = flase
        if IsChange == 0 and targetList ~= nil and targetList.Count ~= 0 then
          for i = 0, targetList.Count - 1 do
            if self.buff_list[targetList[i]] == nil then
              self:RealPlaySkill(target.targetRole, targetList[i], JNId + 1, 1, 0)
              self.buff_list[targetList[i]] = true
              IsSet = true
              break
            end
          end
          IsChange = 1
        end
        if IsSet == flase and IsChange == 1 and targetList1 ~= nil and targetList1.Count ~= 0 then
          for i = 0, targetList1.Count - 1 do
            if self.buff_list[targetList1[i]] == nil then
              self:RealPlaySkill(target.targetRole, targetList1[i], JNId + 1, 1, 1)
              self.buff_list[targetList1[i]] = true
              break
            end
          end
        end
      end
    end
  end
end

function bs_60006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_60006
