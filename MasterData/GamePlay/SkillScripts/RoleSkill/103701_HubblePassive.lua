local bs_103701 = class("bs_103701", LuaSkillBase)
local base = LuaSkillBase
bs_103701.config = {
  effectId_num1 = 10320,
  effectId_num2 = 10321,
  effectId_num3 = 10322,
  effectId_num4 = 10323,
  effectId_num5 = 10324,
  buffId1 = 103701,
  audioId1 = 286,
  countmax = 5,
  weaponLv = 0
}

function bs_103701:ctor()
end

function bs_103701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_103701_12", 1, self.OnAfterPlaySkill)
  self.caster.recordTable.Passive = 0
  self.caster.recordTable.X_num = 0
end

function bs_103701:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.caster.recordTable.Passive = self.caster.recordTable.Passive + 1
    if self.caster.recordTable.Passive >= self.arglist[1] then
      self:Passivetirger(1)
    end
  end
end

function bs_103701:Passivetirger(num)
  if self.caster.recordTable.X_num < self.config.countmax then
    local X_number = self.caster.recordTable.X_num + 1
    local X_effect = self.config["effectId_num" .. tostring(X_number)]
    self.caster.recordTable.Passive = 0
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    LuaSkillCtrl:CallEffect(self.caster, X_effect, self, nil, nil, nil, false)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
    self.caster.recordTable.X_num = self.caster.recordTable.X_num + num
    if self.config.weaponLv == 3 then
      local maxMP = ConfigData.game_config.ultMpCost * self.arglist[5] // 1000
      LuaSkillCtrl:CallAddPlayerHmp(maxMP)
    end
  end
end

function bs_103701:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_103701
