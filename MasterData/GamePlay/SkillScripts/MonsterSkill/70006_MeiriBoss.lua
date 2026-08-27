local bs_70006 = class("bs_70006", LuaSkillBase)
local base = LuaSkillBase
bs_70006.config = {
  timeDuration = 15,
  effectId = 10910,
  buffFeature_ignoreDie = 6,
  buffFeature_Invinciable = 2,
  effectDelaytime = 30,
  effectTime = 55
}

function bs_70006:ctor()
end

function bs_70006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.totalTime = self.arglist[1]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime - self.config.effectTime, timeCallBack)
end

function bs_70006:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = math.max(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

function bs_70006:TimeUp()
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(1)
  if 1 > targetlist.Count then
    return
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  LuaSkillCtrl:StartTimer(nil, self.config.effectDelaytime + self.config.effectTime - 20, function()
    LuaSkillCtrl:CallUltSkillScreenEffect()
  end)
  LuaSkillCtrl:StartTimer(nil, self.config.effectDelaytime + self.config.effectTime - 10, function()
    LuaSkillCtrl:CallUltSkillScreenEffect()
  end)
  LuaSkillCtrl:StartTimer(nil, self.config.effectDelaytime + self.config.effectTime, function()
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i]
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_ignoreDie)
        if 0 < buff_ignoreDie.Count then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, buff_ignoreDie[i].dataId, 0)
          end
        end
      end
      local IfRoleCotainsInvinciableBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, self.config.buffFeature_Invinciable)
      if IfRoleCotainsInvinciableBuff and not targetRole.recordTable.equipSummoner then
        local buff_invinciable = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, self.config.buffFeature_Invinciable)
        if 0 < buff_invinciable.Count then
          for i = 0, buff_invinciable.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, buff_invinciable[i].dataId, 0)
          end
        end
      end
      local damage = targetRole.maxHp * 10
      targetRole:SubHp(damage)
    end
  end)
  LuaSkillCtrl:StartTimer(nil, self.config.effectDelaytime + self.config.effectTime + 10, function()
    LuaSkillCtrl:ForceEndBattle(false)
  end)
end

function bs_70006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_70006
