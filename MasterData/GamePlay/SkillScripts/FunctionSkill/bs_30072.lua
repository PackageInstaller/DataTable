local QiuSkillBase = require("GamePlay.SkillScripts.FunctionSkill.QiuSkillBase")
local bs_30072 = class("bs_30072", QiuSkillBase)
local base = QiuSkillBase
bs_30072.config = {is_reducable = false}
bs_30072.config = setmetatable(bs_30072.config, {
  __index = base.config
})

function bs_30072:ctor()
end

function bs_30072:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30072_1", 998, self.OnAfterBattleStart)
end

function bs_30072:OnAfterBattleStart()
  self.ToCastBallSkill = BindCallback(self, self.RealCastSkillAUTOBall)
  if self.caster.recordTable.bs_30073 then
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1] - self.caster.recordTable.bs_30073_time, self.ToCastBallSkill, nil, -1)
  else
    self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.ToCastBallSkill, nil, -1)
  end
end

function bs_30072:RealCastSkillAUTOBall()
  if LuaSkillCtrl:CallRange(1, 1000) <= 200 then
    self:RealCastSkillWUDUBall()
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 400 then
    self:RealCastSkillBOOMBall()
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 600 then
    self:RealCastSkillSHANBall()
  elseif LuaSkillCtrl:CallRange(1, 1000) <= 800 then
    self:RealCastSkillDEFBall()
  else
    self:RealCastSkillATKBall()
  end
end

function bs_30072:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30072
