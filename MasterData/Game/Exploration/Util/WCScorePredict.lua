local WCScorePredict = {}

function WCScorePredict.GetWCPredictScore(isMax, StepLefts, BattleStepLefts, CurCoin, CurExp, CurChipScore, CurStoreLevel, MaxStorLevel, CurChipLimit, CurEpLevel, CurBuffMult, CurMonLevel, CurScore, AllBuffSum)
  local epLevels = {
    {
      5,
      2,
      1
    },
    {
      3,
      4,
      1
    },
    {
      1,
      5,
      2
    }
  }
  local roomScore = {
    0,
    10,
    25
  }
  local roomMoney = {
    5,
    10,
    30
  }
  local average_score = {
    0,
    0,
    0
  }
  local average_money = {
    0,
    0,
    0
  }
  local curBaseScore = CurScore / 1.5 / (1 + CurBuffMult)
  for i = 1, 3 do
    average_score[1] = average_score[1] + roomScore[i] * epLevels[1][i]
    average_score[2] = average_score[2] + roomScore[i] * epLevels[2][i]
    average_score[3] = average_score[3] + roomScore[i] * epLevels[3][i]
    average_money[1] = average_money[1] + roomMoney[i] * epLevels[1][i]
    average_money[2] = average_money[2] + roomMoney[i] * epLevels[2][i]
    average_money[3] = average_money[3] + roomMoney[i] * epLevels[3][i]
  end
  local totalRoomScore = 0
  local totalRoomMoney = 0
  for i = 1, 3 do
    if CurEpLevel > i then
    elseif CurEpLevel == i then
      totalRoomScore = totalRoomScore + average_score[i] / 8 * BattleStepLefts[i]
      totalRoomMoney = totalRoomMoney + average_money[i] / 8 * BattleStepLefts[i] + 20
    elseif CurEpLevel < i then
      totalRoomScore = totalRoomScore + average_score[i]
      totalRoomMoney = totalRoomMoney + average_money[i] + 20
    end
  end
  local rest_steps = 0
  for _, left in ipairs(StepLefts) do
    rest_steps = rest_steps + left
  end
  local pre_rates = math.min(400, rest_steps * 25)
  local tatalMoney = CurCoin + pre_rates + totalRoomMoney + CurExp * 2.5
  local needCoin = {}
  local weekly_challenge_shop = ConfigData.weekly_challenge_shop
  local lastExp = 0
  for index, cfg in ipairs(weekly_challenge_shop) do
    table.insert(needCoin, math.ceil((cfg.exp - lastExp) * 2.5))
    lastExp = cfg.exp
  end
  local reckonStoreLevel = 0
  for i = CurStoreLevel, MaxStorLevel do
    if tatalMoney >= needCoin[i] then
      tatalMoney = tatalMoney - needCoin[i]
      reckonStoreLevel = i
    else
      reckonStoreLevel = i
      break
    end
  end
  local tatolChipScore = (reckonStoreLevel + 3 - CurEpLevel) * 30 - CurChipScore
  local clearScore = 200
  local damageScore = 300
  local timeScore = 90
  local outputRoomScore = 50 * (3 - CurEpLevel)
  local BuffMult = math.min(CurBuffMult + AllBuffSum / 10 * math.max(8 - CurMonLevel, 0), AllBuffSum)
  if not isMax then
    damageScore = 100
    timeScore = 0
    BuffMult = CurBuffMult
  end
  local totalScore = (curBaseScore + tatolChipScore + totalRoomScore + damageScore + timeScore + outputRoomScore + clearScore) * 1.5 * (1 + BuffMult)
  return math.floor(totalScore)
end

return WCScorePredict
