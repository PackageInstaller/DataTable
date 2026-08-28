local View = require("UIActivityGlobalBattle/UIActivityGlobalBattleView")
local DataModel = require("UIActivityGlobalBattle/UIActivityGlobalBattleDataModel")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}

function Controller:Init()
  View.Group_Reward.Img_Progress:SetFilledImgAmount(0)
  NPCDialog.SetNPC(View.Group_NPC, DataModel.activityCA.npcId)
  NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.enterText)
  Controller:RefreshTimeShow(false)
  if DataModel.reward then
    Controller:RefreshProgress()
    Controller:RefreshReward(DataModel.reward)
  else
    Net:SendProto("activity.info", function(json)
      if json.activity and json.activity[tostring(DataModel.activityId)] then
        local item = json.activity[tostring(DataModel.activityId)].item
        local itemId = DataModel.activityCA.globalWeeklyItem
        if item and item[tostring(itemId)] and item[tostring(itemId)].num then
          DataModel.progressNum = item[tostring(itemId)].num
        else
          DataModel.progressNum = 0
        end
        Controller:RefreshProgress()
        local reward = json.activity[tostring(DataModel.activityId)].reward
        Controller:RefreshReward(reward)
      end
    end, DataModel.activityId)
  end
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
  if 1 <= timeTable.day then
    View.Group_Title.Group_Time.Txt_T:SetActive(true)
    View.Group_Title.Group_Time.Txt_D:SetActive(true)
    View.Group_Title.Group_Time.Txt_T2:SetActive(0 < timeTable.hour)
    View.Group_Title.Group_Time.Txt_H:SetActive(0 < timeTable.hour)
    View.Group_Title.Group_Time.Txt_T3:SetActive(false)
    View.Group_Title.Group_Time.Txt_M:SetActive(false)
    View.Group_Title.Group_Time.Txt_D:SetText(timeTable.day)
    View.Group_Title.Group_Time.Txt_H:SetText(timeTable.hour)
  elseif 1 <= timeTable.hour then
    View.Group_Title.Group_Time.Txt_T:SetActive(false)
    View.Group_Title.Group_Time.Txt_D:SetActive(false)
    View.Group_Title.Group_Time.Txt_T2:SetActive(true)
    View.Group_Title.Group_Time.Txt_H:SetActive(true)
    View.Group_Title.Group_Time.Txt_T3:SetActive(0 < timeTable.minute)
    View.Group_Title.Group_Time.Txt_M:SetActive(0 < timeTable.minute)
    View.Group_Title.Group_Time.Txt_H:SetText(timeTable.hour)
    View.Group_Title.Group_Time.Txt_M:SetText(timeTable.minute)
  else
    View.Group_Title.Group_Time.Txt_T:SetActive(false)
    View.Group_Title.Group_Time.Txt_D:SetActive(false)
    View.Group_Title.Group_Time.Txt_T2:SetActive(false)
    View.Group_Title.Group_Time.Txt_H:SetActive(false)
    View.Group_Title.Group_Time.Txt_T3:SetActive(true)
    View.Group_Title.Group_Time.Txt_M:SetActive(true)
    View.Group_Title.Group_Time.Txt_M:SetText(timeTable.minute)
  end
  DataModel.lastDay = timeTable.day
end

function Controller:RefreshProgress()
  local maxNum = DataModel.activityCA.globalWeeklyScoreMax
  local haveNum = math.min(DataModel.progressNum, maxNum)
  View.Group_Reward.Txt_Progress:SetText(haveNum .. "/" .. maxNum)
  View.Group_Reward.Img_Progress:SetFilledImgAmount(haveNum / maxNum)
end

function Controller:RefreshReward(reward)
  DataModel.reward = reward
  local haveNum = DataModel.progressNum
  local isRed = Controller:getRewardState(reward, haveNum)
  View.Group_Reward.Btn_Reward.Img_Red:SetActive(isRed)
end

function Controller:getRewardState(reward, haveNum)
  for i, v in ipairs(DataModel.activityCA.globalWeeklyRewardsList) do
    local data = DataModel.activityCA.globalWeeklyRewardsList[i]
    if reward and reward[tostring(i - 1)] then
    elseif haveNum >= data.score then
      return true
    end
  end
  return false
end

return Controller
