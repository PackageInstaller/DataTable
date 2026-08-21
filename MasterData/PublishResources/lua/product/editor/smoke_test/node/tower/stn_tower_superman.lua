require("common_async_base")
_class("Tower_BattleCheat_SuperAurorian", CTestRobot_Base)
Tower_BattleCheat_SuperAurorian = Tower_BattleCheat_SuperAurorian

function Tower_BattleCheat_SuperAurorian:OnWorking()
  local runData = self._manager:GetMissionRunData()
  local type = runData:GetTowerElementType()
  if type < 4 then
    return Tower_BattleCheat_SuperAurorian.super.OnWorking(self)
  end
  local maxHP = GMCommand:New()
  maxHP:SetFuncName("BattleCheatHeroMaxHP")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, maxHP)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatAttackMax")
  cmd:SetFuncParam(8000)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
  return Tower_BattleCheat_SuperAurorian.super.OnWorking(self)
end
