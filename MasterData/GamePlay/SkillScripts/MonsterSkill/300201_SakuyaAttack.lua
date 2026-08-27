local base = require("GamePlay.SkillScripts.CommonAttackSkill.103800_SakuyaAttack")
local bs_300201 = class("bs_300201", base)
bs_300201.config = {action1 = 1021}
bs_300201.config = setmetatable(bs_300201.config, {
  __index = base.config
})

function bs_300201:ctor()
end

function bs_300201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_300201:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300201
