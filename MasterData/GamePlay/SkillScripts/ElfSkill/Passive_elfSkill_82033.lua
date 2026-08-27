local bs_82033 = class("bs_82033", LuaSkillBase)
local base = LuaSkillBase
bs_82033.config = {
  buffId_cookie = 709,
  select_id = 6,
  select_range = 20,
  effect_win = 611,
  effect_fail = 610
}

function bs_82033:ctor()
end

function bs_82033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_82033_1", 99, self.OnSetHurt, nil, nil, nil, eBattleRoleBelong.player)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_82033_2", 1, self.OnAfterBattleStart)
  self.ulttarget = 0
  self.skillCasterEntity = LuaSkillCtrl:GetPlayerRoleEntity()
end

function bs_82033:OnAfterBattleStart(data)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i].targetRole
      if role ~= nil and role.belongNum == eBattleRoleBelong.player and role.roleType == 1 then
        self:CallCookieBuff(role)
      end
    end
  end
end

function bs_82033:CallCookieBuff(role)
  if role == nil or role.hp <= 0 then
    return
  else
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_cookie, self.arglist[4], nil, true)
  end
end

function bs_82033:OnSetHurt(context)
  if self.skillCasterEntity.recordTable.elfSkillTrigger == nil then
    self.skillCasterEntity.recordTable.elfSkillTrigger = self.caster
  end
  if self.skillCasterEntity.recordTable.elfSkillTrigger ~= self.caster then
    return
  end
  local limit_hurt = context.target.maxHp * self.arglist[1] // 1000
  local cookie = context.target:GetBuffTier(self.config.buffId_cookie)
  if 0 < cookie and limit_hurt <= context.hurt then
    local convert_dodge = context.target.dodge * self.arglist[3]
    local bingo = convert_dodge + self.arglist[2]
    if bingo >= self.arglist[3] then
      bingo = self.arglist[3]
    end
    if bingo >= LuaSkillCtrl:CallRange(1, 1000) then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_win, self)
      context.hurt = 1
      LuaSkillCtrl:DispelBuff(context.target, self.config.buffId_cookie, 1, true)
    else
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_fail, self)
    end
  end
end

function bs_82033:OnCasterDie()
  if self.skillCasterEntity.recordTable.elfSkillTrigger == self.caster then
    self.skillCasterEntity.recordTable.elfSkillTrigger = nil
  end
  base.OnCasterDie(self)
end

function bs_82033:LuaDispose()
  base.LuaDispose(self)
  self.skillCasterEntity = nil
end

return bs_82033
