local bs_10330 = class("bs_10330", LuaSkillBase)
local base = LuaSkillBase
bs_10330.config = {buffId = 2061, effectId = 10975}

function bs_10330:ctor()
end

function bs_10330:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10330_3", 3, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self:AddAfterAddBuffTrigger("bs_10330_2", 0, self.OnAfterAddBuff, nil, nil, eBattleRoleBelong.player)
  self:AddOnRoleDieTrigger("bs_10330_02", 1, self.OnRoleDie)
  self.times = 0
  self.countBuffEffect = {}
end

function bs_10330:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet then
    self:OnSkillTake()
    self.times = self.times + 1
    if self.times >= self.arglist[1] then
      self.times = 0
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
      if 0 < targetList.Count then
        for i = 0, targetList.Count - 1 do
          local target = targetList[i].targetRole
          LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId, 1)
        end
      end
    end
  end
end

function bs_10330:OnAfterAddBuff(buff, target)
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

function bs_10330:OnRoleDie(killer, role)
  if self.countBuffEffect[role.uid] ~= nil then
    self.countBuffEffect[role.uid]:Die()
    self.countBuffEffect[role.uid] = nil
  end
end

function bs_10330:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10330:LuaDispose()
  self.countBuffEffect = nil
  base.LuaDispose(self)
end

return bs_10330
