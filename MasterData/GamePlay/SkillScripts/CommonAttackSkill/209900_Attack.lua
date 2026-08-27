local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2099001 = class("bs_2099001", bs_1)
local base = bs_1
bs_2099001.config = {}
bs_2099001.config = setmetatable(bs_2099001.config, {
  __index = base.config
})

function bs_2099001:ctor()
end

function bs_2099001:PlaySkill(passdata)
  return
end

function bs_2099001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_2099001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2099001
