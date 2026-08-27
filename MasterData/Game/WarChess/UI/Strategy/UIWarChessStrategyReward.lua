local base = UIBaseWindow
local UIWarChessStrategyReward = class("UIWarChessStrategyReward", base)
local UINWarChessStrategySelectItem = require("Game.WarChess.UI.Strategy.UINWarChessStrategySelectItem")

function UIWarChessStrategyReward:OnInit()
  self.__selectedItem = nil
  self.strategyItemPool = UIItemPool.New(UINWarChessStrategySelectItem, self.ui.obj_StrategyItem)
  self.ui.obj_StrategyItem:SetActive(false)
  self.__onSelectItem = BindCallback(self, self.__OnSelectItem)
  UIUtil.AddButtonListener(self.ui.btn_confirm, self, self.__OnClickConfitem)
end

function UIWarChessStrategyReward:InitWCStrategyReward()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local strategyRewardCtrl = wcCtrl.strategyRewardCtrl
  local rewardList = strategyRewardCtrl:GetWCStrategySelectRewards()
  self.strategyItemPool:HideAll()
  for index, srData in ipairs(rewardList) do
    local sItem = self.strategyItemPool:GetOne()
    sItem:InitAsWCStrategySelectItem(srData, self.__onSelectItem)
  end
end

function UIWarChessStrategyReward:__OnSelectItem(isRward, sItem)
  self.__selectedItem = sItem
  self.ui.tex_ChoiceDes.text = sItem.des
end

function UIWarChessStrategyReward:__OnClickConfitem()
  if self.__selectedItem == nil then
    return
  end
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local strategyRewardCtrl = wcCtrl.strategyRewardCtrl
  if self.__selectedItem.srData ~= nil then
    local srData = self.__selectedItem.srData
    local rewardType = srData.srElem.rewardType
    if rewardType == 3 then
      local indexStrategyKey = srData.index
      local rewardMapKey
      for key, _ in pairs(srData.srElem.rewards) do
        rewardMapKey = key
        break
      end
      strategyRewardCtrl:WCStrategySelectReward(indexStrategyKey, rewardMapKey)
    elseif rewardType == 4 then
      local indexStrategyKey = srData.index
      strategyRewardCtrl:WCStrategySelectReward(indexStrategyKey, nil, nil)
    else
      self.strategyItemPool:HideAll()
      if srData.chipDataList ~= nil then
        local teamDataDic = wcCtrl.teamCtrl:GetWCTeams()
        UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSelectChip, function(wcChipWindow)
          wcChipWindow:InitWCSelectChip(srData.chipDataList, teamDataDic, function(index, teamData)
            local tid = teamData:GetWCTeamId()
            local selectedChipData = srData.chipDataList[index]
            local indexStrategyKey = srData.index
            local rewardMapKey = ExplorationManager.ChipConvert2ServerId(selectedChipData.dataId, selectedChipData:GetCount())
            strategyRewardCtrl:WCStrategySelectReward(indexStrategyKey, rewardMapKey, tid, function()
              UIManager:DeleteWindow(UIWindowTypeID.WarChessSelectChip)
            end)
          end)
        end)
      end
      if srData.buffDataList ~= nil then
        for _, buffData in ipairs(srData.buffDataList) do
          local sItem = self.strategyItemPool:GetOne()
          sItem:InitAsWCStrategySubSelectItem(buffData, 2, self.__onSelectItem, srData.index)
        end
      end
    end
    return
  end
  if self.__selectedItem.srSubItemId ~= nil then
    local indexStrategyKey = self.__selectedItem.index
    local rewardMapKey = self.__selectedItem.srSubItemId
    strategyRewardCtrl:WCStrategySelectReward(indexStrategyKey, rewardMapKey)
  end
end

function UIWarChessStrategyReward:OnDelete()
end

return UIWarChessStrategyReward
