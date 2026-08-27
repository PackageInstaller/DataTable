local bs_20167 = class("bs_20167", LuaSkillBase)
local base = LuaSkillBase
bs_20167.config = {}

function bs_20167:ctor()
end

function bs_20167:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20167_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable.totalHp = 0
  self.caster.recordTable.totalAtk = 0
  self.caster.recordTable.totalIntensity = 0
  self.caster.recordTable.totalDef = 0
  self.caster.recordTable.totalMagicRes = 0
  self.caster.recordTable.roleNum = 0
end

function bs_20167:OnAfterBattleStart()
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return
  end
  self.caster.recordTable.roleNum = targetlist.Count
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i].targetRole
    self.caster.recordTable.totalHp = self.caster.recordTable.totalHp + targetRole.maxHp
    self.caster.recordTable.totalAtk = self.caster.recordTable.totalAtk + targetRole.pow
    self.caster.recordTable.totalIntensity = self.caster.recordTable.totalIntensity + targetRole.skill_intensity
    self.caster.recordTable.totalDef = self.caster.recordTable.totalDef + targetRole.def
    self.caster.recordTable.totalMagicRes = self.caster.recordTable.totalMagicRes + targetRole.magic_res
  end
end

function bs_20167:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20167
