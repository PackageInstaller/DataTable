local bs_25201 = class("bs_25201", LuaSkillBase)
local base = LuaSkillBase
bs_25201.config = {buffId = 2110}

function bs_25201:ctor()
end

function bs_25201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_25201_2", 99, self.OnSetHurt, nil, nil, self.caster.belongNum)
  self:AddAfterHurtTrigger("bs_25201_3", 1, self.OnAfterHurt, nil, nil, self.caster.belongNum)
end

function bs_25201:OnSetHurt(context)
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
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, debuffNum, nil, true)
    end
  end
end

function bs_25201:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and self:IsReadyToTake() then
    self:OnSkillTake()
    local buffTier = target:GetBuffTier(self.config.buffId)
    if 0 < buffTier then
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0, true, true)
    end
  end
end

function bs_25201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25201
