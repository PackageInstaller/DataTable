_class("LuckLandGameData", Object)
LuckLandGameData = LuckLandGameData

function LuckLandGameData:Init(data)
  self._cfg = data
  self.gameRound = data.GameRound
  self.curMoney = data.InitMoney
  self.maxHp = data.MaxHp
  self.curHp = self.maxHp
  self.reDrawCount = 0
  self.gameRoundEnemyDic = SortedDictionary:New()
  self.nextEnmeyList = {}
  self.nextEnterEnemyRoundIndex = 0
  self.enemyTotalAtk = 0
end

function LuckLandGameData:GetTotalRound()
  return self._cfg.GameRound
end

function LuckLandGameData:GetCurRound()
  return self.gameRound
end

function LuckLandGameData:GetUseRound()
  return self._cfg.GameRound - self.gameRound + 1
end

function LuckLandGameData:GetCurMoney()
  return self.curMoney
end

function LuckLandGameData:GetUserMaxHp()
  return self.maxHp
end

function LuckLandGameData:GetUserCurHp()
  return self.curHp
end

function LuckLandGameData:ReDrawCount()
  return self.reDrawCount
end

function LuckLandGameData:ReDrawCost()
  return 10
end

function LuckLandGameData:GetGameRoundEnemyDic()
  return self.gameRoundEnemyDic
end

function LuckLandGameData:GetNeXTEnemyList()
  return self.nextEnmeyList
end

function LuckLandGameData:GetNextEnterEnemyRoundIndex()
  return self.nextEnterEnemyRoundIndex
end

function LuckLandGameData:SetNextEnterEnemyRoundIndex(index)
  self.nextEnterEnemyRoundIndex = index
end

function LuckLandGameData:GetEnemyTotalAtk()
  return self.enemyTotalAtk
end

function LuckLandGameData:SetEnemyTotalAtk(atk)
  self.enemyTotalAtk = atk
end

function LuckLandGameData:TurnNextRound()
  self.gameRound = self.gameRound - 1
end

function LuckLandGameData:AddMoney(money)
  self.curMoney = self.curMoney + money
end

function LuckLandGameData:CostMoney(money)
  self.curMoney = self.curMoney - money
end

function LuckLandGameData:CanCostMoney(money)
  if money <= self.curMoney then
    return true
  else
    return false
  end
end

function LuckLandGameData:RecoverUserHp(hp)
  self.curHp = self.curHp + hp
  if self.curHp > self.maxHp then
    self.curHp = self.maxHp
  end
end

function LuckLandGameData:ReduceUserHp(hp)
  self.curHp = self.curHp - hp
  if self.curHp <= 0 then
  end
end

function LuckLandGameData:AddReDrawCount()
  self.reDrawCount = self.reDrawCount + 1
end
