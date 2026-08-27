local bs_202302 = require("GamePlay.SkillScripts.MonsterSkill.202302_LovePassive02")
local bs_203204 = class("bs_203204", bs_202302)
local base = bs_202302
bs_203204.config = {}
bs_203204.config = setmetatable(bs_203204.config, {
  __index = base.config
})

function bs_203204:ctor()
end

function bs_203204:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203204:OnAfterBattleStart()
  LuaSkillCtrl:AddPlayerTowerMp(-10000)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList.Count > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_191, 15)
    LuaSkillCtrl:CallBuff(self, self.caster, 1064, 1000)
  end
end

function bs_203204:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203204
