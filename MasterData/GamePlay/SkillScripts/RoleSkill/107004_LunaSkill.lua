local bs_107002 = require("GamePlay.SkillScripts.RoleSkill.107002_LunaSkill")
local bs_107004 = class("bs_107004", bs_107002)
local base = bs_107002
bs_107004.config = {weaponLv = 1}
bs_107004.config = setmetatable(bs_107004.config, {
  __index = base.config
})

function bs_107004:ctor()
end

function bs_107004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107004_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable.crit_trigger = false
  self.caster.recordTable.Ex_damplus = nil
end

function bs_107004:OnAfterBattleStart()
  if self.config.weaponLv >= 1 then
    self.caster.recordTable.crit_trigger = true
  end
  if self.config.weaponLv >= 2 then
    self.caster.recordTable.Ex_damplus = self.arglist[7]
  end
end

function bs_107004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107004
