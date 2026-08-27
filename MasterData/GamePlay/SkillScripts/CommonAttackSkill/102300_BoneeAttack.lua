local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102300 = class("bs_102300", bs_1)
local base = bs_1
bs_102300.config = {
  effectId_1 = 102302,
  effectId_2 = 102303,
  audioId1 = 236,
  audioId2 = 237,
  audioId3 = 238
}
bs_102300.config = setmetatable(bs_102300.config, {
  __index = base.config
})

function bs_102300:ctor()
end

function bs_102300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102300:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_102300:LuaDispose()
  base.LuaDispose(self)
end

return bs_102300
