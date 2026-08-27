local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_40029 = class("bs_40029", bs_200001)
local base = bs_200001
bs_40029.config = {}
bs_40029.config = setmetatable(bs_40029.config, {
  __index = base.config
})

function bs_40029:ctor()
end

function bs_40029:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Roll = self.arglist[1]
  self.caster.recordTable.arg = self.arglist[2]
end

function bs_40029:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
end

function bs_40029:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40029
