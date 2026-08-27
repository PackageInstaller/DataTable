local BattlePassEnum = {}
BattlePassEnum.ConditionType = {AchievementLevel = 1, BattlePassLevel = 2}
BattlePassEnum.TakeWay = {
  Base = 0,
  Senior = 1,
  BaseAndSenior = 2,
  All = 3,
  Overflow = 4
}
BattlePassEnum.BuyQuality = {
  Senior = 0,
  Ultimate = 1,
  SupplyUltimate = 2
}
BattlePassEnum.PurposeType = {
  Common = 0,
  Comeback = 1,
  Activity = 2
}
BattlePassEnum.RedDotType = {Reward = 1, Task = 2}

function BattlePassEnum.GetPassPayId(quality, passCfg)
  local payId = 0
  if quality == BattlePassEnum.BuyQuality.Senior then
    payId = passCfg.senior_price
  elseif quality == BattlePassEnum.BuyQuality.Ultimate then
    payId = passCfg.ultimate_price
  elseif quality == BattlePassEnum.BuyQuality.SupplyUltimate then
    payId = passCfg.supply_price
  end
  return payId
end

BattlePassEnum.pickColor = Color.New(1, 0.56, 0.13, 0.9)
BattlePassEnum.ReHolderStyleMapping = {
  BattlePassReHolderStyleNormal = "UINReHolderStyleNormal"
}
return BattlePassEnum
