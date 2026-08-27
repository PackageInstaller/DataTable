local bs_108101 = class("bs_108101", LuaSkillBase)
local base = LuaSkillBase
bs_108101.config = {
  buffid = 107906,
  buffId_Mark = 108102,
  buffId_doge = 108101,
  buffId_atk = 108103,
  skill_time = 45,
  effect_loop = 108104,
  effect_start = 108105,
  effect_blink = 108110,
  effectId_show = 108111
}

function bs_108101:ctor()
end

function bs_108101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108101", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_108101_2", 1, self.BeforeEndBattle)
  self.count = 0
end

function bs_108101:OnAfterBattleStart()
  local skilltime = self.arglist[3]
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 2, 1)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= nil and targetlist[i].targetRole ~= self.caster and targetlist[i].targetRole.roleType ~= eBattleRoleType.realSummoner then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId_Mark, 1, skilltime)
        self.count = self.count + 1
      end
    end
  end
  if self.count == 0 then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffid, 1, skilltime, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_blink, self)
  LuaSkillCtrl:SetRoleVisible(self.caster, false)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Mark, 1, skilltime)
  self:CallCasterWait(skilltime)
  self.actioner = LuaSkillCtrl:StartTimer(self, 15, BindCallback(self, self.OnAction), nil, -1, 15)
  self.ender = LuaSkillCtrl:StartTimer(self, skilltime, BindCallback(self, self.OnEndAction), nil, 0, 0)
end

function bs_108101:OnAction()
  if self.loopEffect == nil then
    local Grid = LuaSkillCtrl:GetGridWithRole(self.caster)
    local tar = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    self.loopEffect = LuaSkillCtrl:CallEffect(tar, self.config.effect_loop, self)
  end
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 2, 1)
  if targetlist.Count == 0 then
    self.ender.left = 0
    return
  end
  local random = LuaSkillCtrl:CallRange(1, targetlist.Count)
  local target = targetlist[random - 1]
  self.caster:LookAtTarget(target)
end

function bs_108101:OnEndAction()
  if self.actioner ~= nil then
    self.actioner:Stop()
    self.actioner = nil
  end
  if self.loopEffect ~= nil then
    self.loopEffect:Die()
    self.loopEffect = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 2, 1)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= nil and targetlist[i].targetRole ~= self.caster and targetlist[i].targetRole.roleType ~= eBattleRoleType.realSummoner then
        LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId_doge, 1)
        LuaSkillCtrl:CallEffect(targetlist[i], self.config.effect_start, self)
      end
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_atk, self.count, nil)
  if 0 < self.caster:GetBuffTier(self.config.buffid) then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffid, 1)
  end
  LuaSkillCtrl:SetRoleVisible(self.caster, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_show, self)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
end

function bs_108101:BeforeEndBattle()
  LuaSkillCtrl:SetRoleVisible(self.caster, true)
end

function bs_108101:OnCasterDie()
  base.OnCasterDie(self)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = targetList.Count - 1, 0, -1 do
      if i < targetList.Count and 0 <= i then
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and 0 < role:GetBuffTier(self.config.buffId_Mark) then
          LuaSkillCtrl:DispelBuff(role, self.config.buffId_Mark, 1)
        end
      end
    end
  end
  if self.actioner ~= nil then
    self.actioner:Stop()
    self.actioner = nil
  end
  if self.loopEffect ~= nil then
    self.loopEffect:Die()
    self.loopEffect = nil
  end
end

function bs_108101:LuaDispose()
  base.LuaDispose(self)
end

return bs_108101
