local bs_10227 = class("bs_10227", LuaSkillBase)
local base = LuaSkillBase
bs_10227.config = {buffId = 1082, effectId = 10625}

function bs_10227:ctor()
end

function bs_10227:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10227_1", 1, self.OnAfterBattleStart)
end

function bs_10227:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return
  end
  for i = 0, targetlist.Count - 1 do
    local role = targetlist[i].targetRole
    local buffTier = role:GetBuffTier(self.config.buffId)
    if buffTier == 0 then
      LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1], true)
    end
    local arriveCallBack1 = BindCallback(self, self.OnArriveAction1, self.caster)
    LuaSkillCtrl:StartTimer(nil, self.arglist[1] - 2, arriveCallBack1)
  end
end

function bs_10227:OnArriveAction1(role)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_10227:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

return bs_10227
