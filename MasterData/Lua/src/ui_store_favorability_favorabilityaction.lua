local this = {}

function this:req_getFavorabilityReward(heroId, callback)
  local data = {u64 = heroId}
  L_Net:sendMessage(MsgGenCode.CSProtoGotFavorReward, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and not table.isEmpty(rspData.rewards) then
      local rewards = require("ui.manager.reward.rewardData").new()
      rewards.rewardShowType = L_Const.rewardShowType.full
      local data = L_DataUtil.parseRewardConfig(rspData.rewards, true, true)
      rewards:constructList(data)
      L_RewardManager:ShowReward(rewards)
    end
  end)
end

return this
