local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_104200 = class("bs_104200", bs_1)
local base = bs_1
bs_104200.config = {
  effectId_1 = 104201,
  effectId_2 = 104202,
  audioId3 = 104202
}
bs_104200.config = setmetatable(bs_104200.config, {
  __index = base.config
})

function bs_104200:ctor()
end

function bs_104200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104200:OnCasterDie()
  if self.loopTimer ~= nil then
    self.loopTimer:Stop()
    self.loopTimer = nil
  end
  base.OnCasterDie(self)
end

function bs_104200:LuaDispose()
  if self.loopTimer ~= nil then
    self.loopTimer:Stop()
    self.loopTimer = nil
  end
  base.LuaDispose(self)
end

return bs_104200
