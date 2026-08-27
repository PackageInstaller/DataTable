local bs_27041 = class("bs_27041", LuaSkillBase)
local base = LuaSkillBase
bs_27041.config = {buff = 2303}

function bs_27041:ctor()
end

function bs_27041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_27041", 999, self.OnSetDeadHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self.flag = false
end

function bs_27041:OnSetDeadHurt(context)
  if not self:isAnyNotInBuff(target) then
    self:AllGoDie()
  end
  if self.flag == true then
    return
  end
  local cb = BindCallback(self, self.OnBuffLifeEvent, context.target)
  LuaSkillCtrl:CallBuffLifeEvent(self, context.target, self.config.buff, 1, self.arglist[1], cb)
end

function bs_27041:OnBuffLifeEvent(target, lifeType, arg)
  if lifeType == eBuffLifeEvent.NewAdd and not self:isAnyNotInBuff(target) then
    self:AllGoDie()
  end
  if lifeType == eBuffLifeEvent.Remove and self:isAnyNotInBuff(target) then
    LuaSkillCtrl:CallHeal(target.maxHp * self.arglist[2] // 1000, self, target)
  end
end

function bs_27041:isAnyNotInBuff(excludeRole)
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if plist == nil or plist.Count < 1 then
    return false
  end
  for i = 0, plist.Count - 1 do
    if 1 > plist[i]:GetBuffTier(self.config.buff) and plist[i] ~= excludeRole then
      return true
    end
  end
  return false
end

function bs_27041:AllGoDie()
  self.flag = true
  self:RemoveSkillTrigger(eSkillTriggerType.SetDeadHurt)
  local plist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if plist == nil or plist.Count < 1 then
    return
  end
  for i = plist.Count - 1, 0, -1 do
    LuaSkillCtrl:DispelBuff(plist[i], self.config.buff, 0)
    LuaSkillCtrl:RemoveLife(plist[i].maxHp + 1, self, plist[i], nil, nil, nil, nil, nil, true)
  end
end

function bs_27041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_27041
