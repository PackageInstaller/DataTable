local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_202001 = class("bs_202001", bs_200001)
local base = bs_200001
bs_202001.config = {}
bs_202001.config = setmetatable(bs_202001.config, {
  __index = base.config
})

function bs_202001:ctor()
end

function bs_202001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable["520_arg1"] = self.arglist[1]
  self.caster.recordTable["520_arg2"] = self.arglist[2]
end

function bs_202001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202001
