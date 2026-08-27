local bs_25203 = class("bs_25203", LuaSkillBase)
local base = LuaSkillBase
bs_25203.config = {buffId = 2109}

function bs_25203:ctor()
end

function bs_25203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_25203_2", 99, self.OnSetHurt, nil, nil, self.caster.belongNum)
  self:AddAfterHurtTrigger("bs_25203_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum)
end

function bs_25203:OnSetHurt(context)
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
    if 0 < debuffNum then
      LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, debuffNum, nil, true)
    end
  end
end

function bs_25203:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    local buffTier = sender:GetBuffTier(self.config.buffId)
    if 0 < buffTier then
      LuaSkillCtrl:DispelBuff(sender, self.config.buffId, 0, true, true)
    end
  end
end

function bs_25203:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25203
