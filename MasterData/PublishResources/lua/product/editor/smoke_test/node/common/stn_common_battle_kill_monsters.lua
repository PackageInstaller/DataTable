_class("Common_BattleKillMonsters", Common_AsyncBase)
Common_BattleKillMonsters = Common_BattleKillMonsters

function Common_BattleKillMonsters:Constructor(pManger, nWaitTime)
end

function Common_BattleKillMonsters:TaskFunc(TT, outResult)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleKillMonsters")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end
