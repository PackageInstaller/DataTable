local bs_25006 = class("bs_25006", LuaSkillBase)
local base = LuaSkillBase
bs_25006.config = {buffId = 110075}

function bs_25006:ctor()
end

function bs_25006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTriggerForTable("bs_25006_2", 99, self.OnSetHurt, {
    senderBelongNum = self.caster.belongNum,
    extraArg2 = false
  })
  self:AddAfterHurtTrigger("bs_25006_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum)
end

function bs_25006:OnSetHurt(context)
  if context.hurt > 0 and context.isTriggerSet ~= true and context.isCrit and context.target.belongNum ~= self.caster.belongNum and context.sender.belongNum == self.caster.belongNum then
    local sender = context.sender
    local target = context.target
    local debuffNum = 0
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs ~= nil and 0 < buffs.Count then
      for i = 0, buffs.Count - 1 do
        if buffs[i].buffType == 2 then
          debuffNum = debuffNum + 1
        end
      end
    end
    if 30 < debuffNum then
      debuffNum = 30
    end
    if 0 < debuffNum then
      LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, debuffNum, nil, true)
    end
  end
end

function bs_25006:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    local buffTier = sender:GetBuffTier(self.config.buffId)
    if 0 < buffTier then
      LuaSkillCtrl:DispelBuff(sender, self.config.buffId, 0, true, true)
    end
  end
end

function bs_25006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25006
