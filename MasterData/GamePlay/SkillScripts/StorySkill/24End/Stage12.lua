local StorySkillBase = require("GamePlay.SkillScripts.StorySkill.StorySkillBase")
local sc_2 = class("sc_2", StorySkillBase)
local base = StorySkillBase
sc_2.config = {}
sc_2.config = setmetatable(sc_2.config, {
  __index = base.config
})

function sc_2:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function sc_2:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  self.pf = self:GetRole(1001083)
  self:StopRole(self.pf)
  self.daimi = self:GetRole(1001082)
  if LuaSkillCtrl:GetBattleRoomId() ~= 1201213 then
    self:StoryFlow_noraml()
  else
    self:StoryFlow_boss()
  end
end

function sc_2:StoryFlow_noraml()
  self:SetUndead(self.daimi)
  self:AddAfterHurtTrigger("sc_2", 1, self.OnAfterHurt, self.daimi, nil, nil, nil, nil, nil, nil)
end

function sc_2:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  LuaSkillCtrl:RemoveLife(target.maxHp // 7, self, target, true, nil, true, true, nil, true)
end

function sc_2:StoryFlow_boss()
  LuaSkillCtrl:StartTimer(nil, 75, function()
    LuaSkillCtrl:StartAvgWithPauseGame("24fe_s10_1", nil, self.End)
  end)
end

function sc_2:End()
  LuaSkillCtrl:ForceEndBattle(true)
end

function sc_2:OnCasterDie()
  base.OnCasterDie(self)
end

return sc_2
