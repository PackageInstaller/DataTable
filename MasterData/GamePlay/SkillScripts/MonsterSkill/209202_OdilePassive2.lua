local bs_209202 = class("bs_209202", LuaSkillBase)
local base = LuaSkillBase
bs_209202.config = {
  effectId_Grid = 209203,
  effectId_Grid_s = 209218,
  HurtConfigID = 16,
  audioId = 209203
}

function bs_209202:ctor()
end

function bs_209202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.MapBorder = LuaSkillCtrl:GetMapBorder()
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_209202_2", 1, self.OnAfterBattleStart)
end

function bs_209202:OnAfterBattleStart()
  local FirstSecond = self:getbattleCurSecond()
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.OnLoopDamage, FirstSecond), nil, -1, 0)
  if self.MapBorder.x > 6 and self.MapBorder.x < 10 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_Grid, self)
  elseif self.MapBorder.x < 6 then
    local effectGrid = LuaSkillCtrl:GetTargetWithGrid(2, 2)
    LuaSkillCtrl:CallEffect(effectGrid, self.config.effectId_Grid_s, self)
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId)
end

function bs_209202:OnLoopDamage(FirstSecond)
  local CurSecond = self:getbattleCurSecond()
  local extraDamage = (CurSecond - FirstSecond) // (self.arglist[2] // 15)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[1] + extraDamage * self.arglist[3]
      })
      skillResult:EndResult()
    end
  end
end

function bs_209202:getbattleCurSecond()
  local battleCtrl = CS.BattleManager.Instance.CurBattleController
  local battleFrame = battleCtrl.frame
  local battleCurSecond = BattleUtil.FrameToTime(battleFrame)
  return battleCurSecond
end

function bs_209202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209202
