local bs_81029 = class("bs_81029", LuaSkillBase)
local base = LuaSkillBase
bs_81029.config = {gridId = 3, buffId = 2156}

function bs_81029:ctor()
end

function bs_81029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_81029_1", 1, self.OnAfterBattleStart)
  self.Num = 0
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) == self.config.gridId then
    self.Num = 1
  end
end

function bs_81029:OnAfterBattleStart()
  if self.Num == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_81029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81029
