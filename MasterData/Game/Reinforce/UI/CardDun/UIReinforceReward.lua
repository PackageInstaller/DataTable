local base = UIBaseWindow
local UIReinforceReward = class("UIReinforceReward", base)
local UINReinforceCardDunLeveScoreNodeRewardItem = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunLeveScoreNodeRewardItem")

function UIReinforceReward:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.__OnClickGetAll)
  self.ui.rewardList.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.rewardList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__onClickGetOne = BindCallback(self, self.__OnClickGetOne)
  self.scrollItemDic = {}
end

function UIReinforceReward:InitRewardList(levelData, actData)
  UIUtil.SetTopStatus(self, self.Delete)
  self.levelData = levelData
  self.actData = actData
  self:__Refresh()
  self.rewardDataList = levelData:GetRankRewardDataList()
  self.ui.rewardList.totalCount = #self.rewardDataList
  self.ui.rewardList:RefillCells()
end

function UIReinforceReward:__OnNewItem(go)
  local scrollItem = UINReinforceCardDunLeveScoreNodeRewardItem.New()
  scrollItem:Init(go)
  self.scrollItemDic[go] = scrollItem
end

function UIReinforceReward:__OnChangeItem(go, index)
  local scrollItem = self.scrollItemDic[go]
  if scrollItem == nil then
    error("Can't find scrollItem by gameObject")
    return
  end
  local rewardData = self.rewardDataList[index + 1]
  local isHaveLayer = self.levelData:IsHaveLayerGroup()
  scrollItem:RefreshRewardData(rewardData, self.curScore, self.pickedDic, self.levelData:GetLevelName(), self.__onClickGetOne, isHaveLayer)
end

function UIReinforceReward:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIReinforceReward:__Refresh()
  local stageId = self.levelData:GetStageId()
  if self.levelData:IsHaveLayerGroup() then
    self.curScore = self.actData:GetHightestLevelByStageId(stageId)
    local pickedScore = self.actData:GetRankRewardPickedScoreByStageId(stageId)
    self.pickedDic = pickedScore.alreadyLayerLevel or table.emptytable
  else
    self.curScore = self.actData:GetRankScoreByStageId(stageId)
    local pickedScore = self.actData:GetRankRewardPickedScoreByStageId(stageId)
    self.pickedDic = pickedScore.alreadyScore or table.emptytable
  end
end

function UIReinforceReward:__OnClickGetOne(num)
  local activityId = self.actData:GetActFrameId()
  local stageId = self.levelData:GetStageId()
  local rewardStageScore, rewardStageLayer
  if self.levelData:IsHaveLayerGroup() then
    rewardStageLayer = num
  else
    rewardStageScore = num
  end
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_HighExploration_Reward(activityId, stageId, false, rewardStageScore, rewardStageLayer, function(objList)
    local msg = objList[0]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
      window:AddAndTryShowReward(CRData)
    end)
    self:__Refresh()
    self.ui.rewardList:RefillCells()
  end)
end

function UIReinforceReward:__OnClickGetAll()
  local activityId = self.actData:GetActFrameId()
  local stageId = self.levelData:GetStageId()
  NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_HighExploration_Reward(activityId, stageId, true, nil, nil, function(objList)
    local msg = objList[0]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
      window:AddAndTryShowReward(CRData)
    end)
    self:__Refresh()
    self.ui.rewardList:RefillCells()
  end)
end

function UIReinforceReward:OnDelete()
  base.OnDelete(self)
end

return UIReinforceReward
