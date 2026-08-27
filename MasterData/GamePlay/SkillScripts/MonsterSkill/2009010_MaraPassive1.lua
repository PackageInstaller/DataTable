local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_2009010 = class("bs_2009010", bs_200001)
local base = bs_200001
bs_2009010.config = {timeDuration = 15}
bs_2009010.config = setmetatable(bs_2009010.config, {
  __index = base.config
})

function bs_2009010:ctor()
end

function bs_2009010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.Roll = self.arglist[1]
  self.caster.recordTable.arg = self.arglist[2]
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2009010:OnAfterBattleStart()
  base.OnAfterBattleStart(self)
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
end

function bs_2009010:CountDown()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(false)
  end
end

function bs_2009010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2009010
