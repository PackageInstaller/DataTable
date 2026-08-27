local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_3 = class("sc_3", StorySkillBase)
local base = StorySkillBase
sc_3.config = {}
sc_3.config = setmetatable(sc_3.config, {
  __index = base.config
})

function sc_3:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_3:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
end

function sc_3:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.xingshi = self:GetRole(1088)
  self.shengcan = self:GetRole(20033)
  if self.xingshi then
    self:SetUndead(self.xingshi)
  end
  if self.shengcan then
    LuaSkillCtrl:CallBuff(self, self.shengcan, 1283, 1)
  end
  LuaSkillCtrl:StartTimer(nil, 345, self.TimerSet, self)
end

function sc_3:TimerSet()
  LuaSkillCtrl:CallBattleCamShakeByParam(1, 2.0, 1.2, 50)
  LuaSkillCtrl:CallStartLocalScale(self.shengcan, Vector3(1.6, 1.6, 1.6), 1.2)
  LuaSkillCtrl:StartTimer(nil, 35, function()
    LuaSkillCtrl:ForceEndBattle(true)
  end)
end

function sc_3:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_3
