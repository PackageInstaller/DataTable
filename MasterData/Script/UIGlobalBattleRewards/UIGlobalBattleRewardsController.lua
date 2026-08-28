local View = require("UIGlobalBattleRewards/UIGlobalBattleRewardsView")
local DataModel = require("UIGlobalBattleRewards/UIGlobalBattleRewardsDataModel")
local Controller = {}

function Controller:Init()
  Controller:RefreshTimeShow(false)
  if DataModel.reward then
    Controller:RefreshProgressShow()
    View.Group_RewardList.ScrollGrid_RewardList.grid.self:SetDataCount(#DataModel.activityCA.globalWeeklyRewardsList + 2)
    View.Group_RewardList.ScrollGrid_RewardList.grid.self:RefreshAllElement()
    for i, v in ipairs(DataModel.activityCA.globalWeeklyRewardsList) do
      local data = DataModel.activityCA.globalWeeklyRewardsList[i]
      if DataModel.reward[tostring(i - 1)] then
      elseif DataModel.progressNum >= data.score and (DataModel.firstUnlock == 0 or i < DataModel.firstUnlock) then
        DataModel.firstUnlock = i
      end
    end
    View.Group_RewardList.ScrollGrid_RewardList.grid.self:MoveToPos(math.max(DataModel.firstUnlock, 1))
  else
    Net:SendProto("activity.info", function(json)
      if json.activity and json.activity[tostring(DataModel.activityId)] then
        local reward = json.activity[tostring(DataModel.activityId)].reward
        DataModel.reward = reward
        Controller:RefreshProgressShow()
        View.Group_RewardList.ScrollGrid_RewardList.grid.self:SetDataCount(#DataModel.activityCA.globalWeeklyRewardsList + 2)
        View.Group_RewardList.ScrollGrid_RewardList.grid.self:RefreshAllElement()
        local ActivityController = require("UIActivityGlobalBattle/UIActivityGlobalBattleController")
        ActivityController:RefreshReward(reward)
      end
    end, DataModel.activityId)
  end
end

function Controller:RefreshProgressShow()
  local maxNum = DataModel.activityCA.globalWeeklyScoreMax
  local haveNum = math.min(DataModel.progressNum, maxNum)
  View.Group_Progress.Txt_Current:SetText(haveNum)
  View.Group_Progress.Txt_All:SetText(maxNum)
  DataModel.progress = haveNum / maxNum
  DataModel.lastUnlock = DataModel:GetRewardLastUnlock()
end

function Controller:RefreshTimeShow(isCheck)
  local targetTime = TimeUtil:GetNextWeekTime(1, 5)
  local timeTable = TimeUtil:SecondToTable(targetTime - TimeUtil:GetServerTimeStamp())
  if isCheck == true and timeTable.day > DataModel.lastDay then
    DataModel.reward = {}
    DataModel.progressNum = 0
    DataModel.lastDay = timeTable.day
    Controller:Init()
    return
  end
  if timeTable.day > 0 then
    View.Group_Time.Txt_Time:SetText(string.format(GetText(80612075), timeTable.day, timeTable.hour))
  elseif 0 < timeTable.hour then
    View.Group_Time.Txt_Time:SetText(string.format(GetText(80612076), timeTable.hour))
  else
    View.Group_Time.Txt_Time:SetText(string.format(GetText(80612077), timeTable.minute))
  end
  DataModel.lastDay = timeTable.day
end

function Controller:RefreshRewardElement(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  if elementIndex == 1 then
    element.Group_Item.self:SetActive(false)
    element.Group_Scroe.self:SetActive(false)
    element.Img_progressOn1:SetActive(false)
    element.Img_progressOff1:SetActive(false)
    element.Img_progressOn2:SetActive(false)
    element.Img_progressOff2:SetActive(false)
    element.Img_ProgressBg:SetActive(false)
    element.Img_Progress:SetActive(false)
  elseif elementIndex == 2 then
    element.Group_Item.self:SetActive(false)
    element.Group_Scroe.self:SetActive(false)
    element.Img_ProgressBg:SetActive(true)
    element.Img_Progress:SetActive(true)
    if DataModel.progress > 0 then
      element.Img_progressOn1:SetActive(true)
      element.Img_progressOff1:SetActive(false)
      element.Img_progressOn2:SetActive(false)
      element.Img_progressOff2:SetActive(false)
      element.Img_progressOn1:SetLocalScale(Vector3(1, 1, 1))
      if elementIndex - 2 == DataModel.lastUnlock then
        element.Img_Progress:SetFilledImgAmount(DataModel.progress)
      else
        element.Img_Progress:SetFilledImgAmount(1)
      end
    else
      element.Img_progressOn1:SetActive(false)
      element.Img_progressOff1:SetActive(true)
      element.Img_progressOn2:SetActive(false)
      element.Img_progressOff2:SetActive(false)
      element.Img_progressOff1:SetLocalScale(Vector3(1, 1, 1))
      element.Img_Progress:SetFilledImgAmount(0)
    end
  else
    local config = DataModel.activityCA.globalWeeklyRewardsList[elementIndex - 2]
    if not config then
      return
    end
    local itemInfo = PlayerData:GetFactoryData(config.id, "ItemFactory")
    if itemInfo then
      element.Group_Item.Img_Reward:SetSprite(itemInfo.iconPath)
      local numStr = ""
      if config.id == 11400001 then
        numStr = tostring(PlayerData:TransitionNum(config.num))
      else
        numStr = tostring(config.num)
      end
      element.Group_Item.Txt_Num:SetText(numStr)
    end
    local state = DataModel:GetRewardStateByIndex(elementIndex - 2)
    element.Group_Item.self:SetActive(true)
    element.Group_Scroe.self:SetActive(true)
    if state == DataModel.rewardState.lock then
      element.Group_Item.Img_Got:SetActive(false)
      element.Group_Item.Img_Lock:SetActive(true)
      element.Group_Item.Btn_Reward:SetActive(false)
      element.Group_Item.Btn_View:SetActive(true)
      element.Group_Scroe.Img_On:SetActive(false)
      element.Group_Scroe.Img_Lock:SetActive(true)
    elseif state == DataModel.rewardState.canGet then
      element.Group_Item.Img_Got:SetActive(false)
      element.Group_Item.Img_Lock:SetActive(false)
      element.Group_Item.Btn_Reward:SetActive(true)
      element.Group_Item.Btn_View:SetActive(false)
      element.Group_Scroe.Img_On:SetActive(true)
      element.Group_Scroe.Img_Lock:SetActive(false)
    else
      element.Group_Item.Img_Got:SetActive(true)
      element.Group_Item.Img_Lock:SetActive(false)
      element.Group_Item.Btn_Reward:SetActive(false)
      element.Group_Item.Btn_View:SetActive(true)
      element.Group_Scroe.Img_On:SetActive(true)
      element.Group_Scroe.Img_Lock:SetActive(false)
    end
    element.Group_Item.Btn_View:SetClickParam(config.id)
    element.Group_Scroe.Txt_Score:SetText(config.score)
    local w = 300
    if (elementIndex - 2) % 2 == 1 then
      element.Group_Item.self:SetLocalPositionY(-w + 120)
      element.Group_Scroe.self:SetLocalPositionY(-w - 58)
    else
      element.Group_Item.self:SetLocalPositionY(-w - 120)
      element.Group_Scroe.self:SetLocalPositionY(-w + 58)
    end
    local maxCount = #DataModel.activityCA.globalWeeklyRewardsList
    element.Img_ProgressBg:SetActive(true)
    element.Img_Progress:SetActive(true)
    if elementIndex - 2 <= DataModel.lastUnlock then
      if elementIndex - 2 == maxCount then
        element.Img_progressOn1:SetActive(true)
        element.Img_progressOff1:SetActive(false)
        element.Img_progressOn2:SetActive(false)
        element.Img_progressOff2:SetActive(false)
        element.Img_progressOn1:SetLocalScale(Vector3(-1, 1, 1))
        element.Img_ProgressBg:SetActive(false)
        element.Img_Progress:SetActive(false)
      else
        element.Img_progressOn1:SetActive(false)
        element.Img_progressOff1:SetActive(false)
        element.Img_progressOn2:SetActive(true)
        element.Img_progressOff2:SetActive(false)
        if elementIndex - 2 == DataModel.lastUnlock then
          local dataCur = DataModel.activityCA.globalWeeklyRewardsList[DataModel.lastUnlock]
          local scroeCur = dataCur.score
          local dataNext = DataModel.activityCA.globalWeeklyRewardsList[DataModel.lastUnlock + 1]
          local progress = 0
          if dataNext then
            local scroeNext = dataNext.score
            progress = (DataModel.progressNum - scroeCur) / (scroeNext - scroeCur)
          end
          element.Img_Progress:SetFilledImgAmount(progress)
        else
          element.Img_Progress:SetFilledImgAmount(1)
        end
      end
    elseif elementIndex - 2 == maxCount then
      element.Img_progressOn1:SetActive(false)
      element.Img_progressOff1:SetActive(true)
      element.Img_progressOn2:SetActive(false)
      element.Img_progressOff2:SetActive(false)
      element.Img_progressOff1:SetLocalScale(Vector3(-1, 1, 1))
      element.Img_ProgressBg:SetActive(false)
      element.Img_Progress:SetActive(false)
    else
      element.Img_progressOn1:SetActive(false)
      element.Img_progressOff1:SetActive(false)
      element.Img_progressOn2:SetActive(false)
      element.Img_progressOff2:SetActive(true)
      element.Img_Progress:SetFilledImgAmount(0)
    end
  end
end

function Controller.ReqGetAllReward()
  Net:SendProto("activity.rec_weekly_act", function(json)
    DataModel.reward = nil
    Controller:Init()
    if string.nilorempty(json.rc) then
      CommonTips.OpenShowItem(json.reward)
    end
  end, DataModel.activityId, 0, 1)
end

return Controller
