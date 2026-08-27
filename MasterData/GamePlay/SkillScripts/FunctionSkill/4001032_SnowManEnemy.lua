local bs_4001032 = class("bs_4001032", LuaSkillBase)
local base = LuaSkillBase
bs_4001032.config = {buffId = 3025}

function bs_4001032:ctor()
end

function bs_4001032:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4001032_1", 1, self.OnAfterBattleStart)
  self.flag = false
  self:AddBuffDieTrigger("bs_4001032_2", 3, self.OnBuffDie, nil, nil, self.config.buffId)
  self:AddAfterBuffRemoveTrigger("bs_4001032_3", 4, self.AfterBuffRemove, nil, nil, self.config.buffId)
end

function bs_4001032:OnAfterBattleStart()
  if self.flag then
    return
  end
  self.flag = true
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetList.Count <= 0 then
    return
  end
  local role = targetList[0].targetRole
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  if role:GetBuffTier(self.config.buffId) ~= nil then
    buffTier = role:GetBuffTier(self.config.buffId)
  end
  if 0 < buffTier then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(0.2, 0.2, 0.2))
  end
end

function bs_4001032:OnBuffDie(buff, target, removeType)
  if buff.buffId ~= self.config.buffId then
    return
  end
  LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1))
end

function bs_4001032:AfterBuffRemove(buffId, target, removeType)
  if buffId ~= self.config.buffId then
    return
  end
  LuaSkillCtrl:CallStartLocalScale(target, Vector3.New(1, 1, 1))
end

function bs_4001032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4001032
