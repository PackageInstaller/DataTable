local bs_107001 = require("GamePlay.SkillScripts.RoleSkill.107001_LunaPassive")
local bs_107005 = class("bs_107005", bs_107001)
local base = bs_107001
bs_107005.config = {}
bs_107005.config = setmetatable(bs_107005.config, {
  __index = base.config
})

function bs_107005:ctor()
end

function bs_107005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_107006_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable.Ultcost_des = self.arglist[8]
end

function bs_107005:OnAfterBattleStart()
  self.caster.recordTable.bless = true
end

function bs_107005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107005
