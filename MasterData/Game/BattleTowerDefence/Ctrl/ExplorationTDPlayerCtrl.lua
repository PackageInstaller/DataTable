local base = require("Game.Exploration.Ctrl.ExplorationPlayerCtrl")
local ExplorationTDPlayerCtrl = class("ExplorationTDPlayerCtrl", base)

function ExplorationTDPlayerCtrl:__TryShowNewReward()
  local lastRewardDataList = self.dynPlayer.dynRewardBag:TryGetLastEpRewardBagDataList()
  if lastRewardDataList == nil then
    return
  end
  if 0 < #lastRewardDataList then
    print("todo体力商店飞入动画")
  end
end

return ExplorationTDPlayerCtrl
