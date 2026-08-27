local bs_50017 = class("bs_50017", LuaSkillBase)
local base = LuaSkillBase
bs_50017.config = {buffId = 1209}

function bs_50017:ctor()
end

function bs_50017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_50017_2", 2, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_50017_1", 1, self.OnAfterMove)
end

function bs_50017:OnAfterPlaySkill(skill, role)
  self.curCd = self.caster.recordTable.gs_1_CDGrid
  local curCd = self.curCd
  LuaSkillCtrl:CallResetCDNumForRole(role, curCd)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
end

function bs_50017:OnAfterMove()
  self.curCd = self.caster.recordTable.gs_1_CDGrid
  local curCd = self.curCd
  LuaSkillCtrl:CallResetCDNumForRole(self.caster, curCd)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
end

function bs_50017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50017
