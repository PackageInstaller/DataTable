local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessStrategyRewardCtrl = class("WarChessStrategyRewardCtrl", base)
local ChipData = require("Game.PlayerData.Item.ChipData")
local BuffData = require("Game.WarChess.Data.WarChessBuffData")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function WarChessStrategyRewardCtrl:ctor(wcCtrl)
  self.__strategySystemData = nil
  self.__identify = nil
end

function WarChessStrategyRewardCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.strategyReward
end

function WarChessStrategyRewardCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.strategySystemData == nil then
    error("not have data")
    return
  end
  self.__strategySystemData = systemState.strategySystemData
  self.__identify = identify
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessStrategyReward, function(win)
    if win == nil then
      return
    end
    win:InitWCStrategyReward()
  end)
end

function WarChessStrategyRewardCtrl:GetWCStrategyFixedReward()
  return self.__strategySystemData.fixedReward
end

function WarChessStrategyRewardCtrl:GetWCStrategySelectRewards()
  local srIdList = self.__strategySystemData.strategyRewardIds
  local rewardList = self.__strategySystemData.strategyReward
  local selectRewardList = {}
  for index, srId in ipairs(srIdList) do
    local srElem = rewardList[index]
    local chipDataList, buffDataList
    if srElem.rewardType == 1 then
      chipDataList = {}
      for alg, _ in pairs(srElem.rewards) do
        local itemId, level = ExplorationManager.ChipServerIdConvert(alg)
        local chipData = ChipData.NewChipForLocal(itemId, level)
        table.insert(chipDataList, chipData)
      end
    elseif srElem.rewardType == 2 then
      buffDataList = {}
      for itemId, num in pairs(srElem.rewards) do
        local buffData = BuffData.CrearteBuffById(itemId)
        table.insert(buffDataList, buffData)
      end
    end
    selectRewardList[index] = {
      index = index - 1,
      srElem = srElem,
      srId = srId,
      chipDataList = chipDataList,
      buffDataList = buffDataList
    }
  end
  return selectRewardList
end

function WarChessStrategyRewardCtrl:WCStrategySelectChipReward(index, teamData)
end

function WarChessStrategyRewardCtrl:WCStrategySelectReward(indexStrategyKey, rewardMapKey, tid)
  tid = tid or self.__identify.tid
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_Event_StrategySelect(self.__identify, indexStrategyKey, rewardMapKey, tid, function()
  end)
end

function WarChessStrategyRewardCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  UIManager:DeleteWindow(UIWindowTypeID.WarChessStrategyReward)
end

function WarChessStrategyRewardCtrl:Delete()
end

return WarChessStrategyRewardCtrl
