local bs_10329 = class("bs_10329", LuaSkillBase)
local base = LuaSkillBase
bs_10329.config = {buffId = 2055, effectId = 10974}

function bs_10329:ctor()
end

function bs_10329:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10329_3", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player)
  self:AddAfterAddBuffTrigger("bs_10329_2", 1, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player)
  self:AddOnRoleDieTrigger("bs_10329_02", 1, self.OnRoleDie)
  self.countBuffEffect = {}
end

function bs_10329:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1)
    self:OnSkillTake()
  end
end

function bs_10329:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId and target ~= nil and target.hp > 0 then
    local buffTier1 = target:GetBuffTier(self.config.buffId)
    if buffTier1 == 1 then
      self.countBuffEffect[target.uid] = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      LuaSkillCtrl:EffectSetCountValue(self.countBuffEffect[target.uid], buffTier1 - 1)
    elseif self.countBuffEffect[target.uid] ~= nil then
      LuaSkillCtrl:EffectSetCountValue(self.countBuffEffect[target.uid], buffTier1 - 1)
    end
  end
end

function bs_10329:OnRoleDie(killer, role)
  if self.countBuffEffect[role.uid] ~= nil then
    self.countBuffEffect[role.uid]:Die()
    self.countBuffEffect[role.uid] = nil
  end
end

function bs_10329:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10329:LuaDispose()
  self.countBuffEffect = nil
  base.LuaDispose(self)
end

return bs_10329
