local this = {}

function this.scoket_10005(data, errorCode)
  L_BattleStore:rsp_syncBattleHeroInfo(data, errorCode)
end

function this.socket_10708(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_BattleStore:rsp_syncObjBattleInfoByHurt(data)
end

function this.socket_10729(data, errorCode)
  local itemList = data.rewards and data.rewards.rewards
  if data.reason == L_Const.FightRewardReason.FRR_Catch then
    L_BattleStore:setCatchReward(itemList)
    L_RewardManager:showBattlePage(nil, L_Const.FightRewardReason.FRR_Catch)
  else
    L_BattleStore:setBattleReward(itemList)
    L_RewardManager:showBattlePage()
  end
end

return this
