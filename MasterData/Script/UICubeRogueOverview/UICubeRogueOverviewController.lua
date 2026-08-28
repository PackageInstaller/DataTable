local View = require("UICubeRogueOverview/UICubeRogueOverviewView")
local CardPackDataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local DataModel = require("UICubeRogueOverview/UICubeRogueOverviewDataModel")
local CubeRogueMissionDataModel = require("UICubeRogueMission/UICubeRogueMissionDataModel")
local CommonRewardsDataModel = require("UICommonRewards/UICommonRewardsDataModel")
local Controller = {}

function Controller:Init()
  Controller:RefreshCommonLevel()
  if DataModel.weeklyRewardTime and DataModel.weeklyRewardTime > 0 then
    Controller:RefreshWeeklyRewardsTime()
  end
  Controller:RefreshQuestProgeress()
  Controller:RefreshCube()
  Controller:RefreshCard()
  Controller:RefreshAllRed()
  View.Img_Title:SetSprite(PlayerData:GetFactoryData(88300198).filePath)
  View.Group_Book.Img_Bg:SetSprite(PlayerData:GetFactoryData(88300194).filePath)
  View.Group_WeeklyRewards.Img_Bg:SetSprite(PlayerData:GetFactoryData(88300195).filePath)
  View.Group_Enter.Group_Continue.Img_Btn:SetSprite(PlayerData:GetFactoryData(88300202).filePath)
  View.Group_Enter.Group_Start.Img_Btn:SetSprite(PlayerData:GetFactoryData(88300201).filePath)
  View.Group_Quest.Img_Bg:SetSprite(PlayerData:GetFactoryData(88300196).filePath)
  View.Group_Store.Img_Bg:SetSprite(PlayerData:GetFactoryData(88300197).filePath)
  View.Group_Skill.Img_Title:SetSprite(PlayerData:GetFactoryData(88300189).filePath)
end

function Controller:RefreshCube()
  View.Group_Bg.Group_Start.self:SetActive(DataModel.isJoin == false)
  View.Group_Bg.Group_Continue.self:SetActive(DataModel.isJoin == true)
  View.Group_Enter.Group_Start.self:SetActive(DataModel.isJoin == false)
  View.Group_Enter.Group_Continue.self:SetActive(DataModel.isJoin == true)
  View.Group_Enter.Group_Stop.self:SetActive(DataModel.isJoin == true)
  if DataModel.isJoin == false then
    View.Group_Enter.Group_Start.Btn_:SetSprite(PlayerData:GetFactoryData(88300201).filePath)
  else
    View.Group_Enter.Group_Continue.Btn_:SetSprite(PlayerData:GetFactoryData(88300202).filePath)
    View.Group_Enter.Group_Stop.Btn_:SetSprite(PlayerData:GetFactoryData(88300203).filePath)
    local cubeCA = PlayerData:GetFactoryData(DataModel.cubeId)
    local faceIndex = cubeCA.faceIndex
    local group_1 = "Group_Plane"
    for i = 1, 10 do
      if View.Group_Bg.Group_Continue[group_1 .. i] then
        if i == faceIndex then
          View.Group_Bg.Group_Continue[group_1 .. i].self:SetActive(true)
        else
          View.Group_Bg.Group_Continue[group_1 .. i].self:SetActive(false)
        end
      end
      if View.Group_Enter.Group_Continue[group_1 .. i] then
        if i == faceIndex then
          View.Group_Enter.Group_Continue[group_1 .. i].self:SetActive(true)
        else
          View.Group_Enter.Group_Continue[group_1 .. i].self:SetActive(false)
        end
      end
    end
  end
end

function Controller:RefreshCommonLevel()
  View.Group_CommonLevel.Txt_Time:SetActive(DataModel.diffTime and DataModel.diffTime > 0)
  if DataModel.diffTime and DataModel.diffTime > 0 then
    Controller:RefreshCommonLevelTime()
  end
  View.Group_CommonLevel.Img_Title:SetSprite(PlayerData:GetFactoryData(88300192).filePath)
  View.Group_CommonLevel.Txt_CurrentLevel:SetText(CommonRewardsDataModel.GetCubeRewardLv())
end

function Controller:RefreshCommonLevelTime()
  local diffTime = TimeUtil:SecondToTable(DataModel.diffTime)
  if diffTime.day > 0 then
    View.Group_CommonLevel.Txt_Time:SetText(string.format(GetText(80610642), diffTime.day, diffTime.hour))
  else
    View.Group_CommonLevel.Txt_Time:SetText(string.format(GetText(80610673), diffTime.hour, diffTime.minute))
  end
end

function Controller.RefreshWeeklyRewardsTime()
  local dayList = TimeUtil:SecondToTable(DataModel.weeklyRewardTime)
  if dayList.day > 0 then
    View.Group_WeeklyRewards.Txt_Time:SetText(string.format(GetText(80610640), dayList.day, dayList.hour))
  else
    View.Group_WeeklyRewards.Txt_Time:SetText(string.format(GetText(80610674), dayList.hour, dayList.minute))
  end
end

function Controller:RefreshAllRed()
  View.Group_CommonLevel.Group_RedPoint.self:SetActive(DataModel:GetEveryRedPoint("Group_CommonLevel"))
  View.Group_Book.Group_RedPoint.self:SetActive(DataModel:GetEveryRedPoint("Group_Book"))
  View.Group_WeeklyRewards.Group_RedPoint.self:SetActive(DataModel:GetEveryRedPoint("Group_WeeklyRewards"))
  View.Group_Skill.Group_RedPoint.self:SetActive(DataModel:GetEveryRedPoint("Group_Skill"))
  View.Group_Quest.Group_RedPoint.self:SetActive(DataModel:GetEveryRedPoint("Group_Quest"))
end

function Controller:RefreshCard()
  if DataModel.activityCA.activityCardPack <= 0 then
    View.Group_Card.self:SetActive(false)
    return
  end
  DataModel.CardPackInfo = CardPackDataModel.GetCardPackInfo(DataModel.activityCA.activityCardPack)
  View.Group_Card.self:SetActive(true)
  View.Group_Card.Img_CardPack:SetSprite(GetResPath(88300321))
  View.Group_Card.Group_RedPoint.self:SetActive(DataModel.CardPackInfo.extraCardStatus == 1)
  View.Group_Card.Txt_Num:SetText(string.format(GetText(80603017), DataModel.CardPackInfo.ownCount, DataModel.CardPackInfo.allCount))
end

function Controller:RefreshQuestProgeress()
  CubeRogueMissionDataModel.Init()
  local questInfo_1 = CubeRogueMissionDataModel.questInfo[1]
  View.Group_Quest.Group_Num.Txt_All:SetText(#questInfo_1.questList)
  View.Group_Quest.Group_Num.Txt_Completed:SetText(questInfo_1.completeCount)
  local questInfo_2 = CubeRogueMissionDataModel.questInfo[2]
  local completeCount = questInfo_1.completeCount + questInfo_2.completeCount
  local questListCount = #questInfo_2.questList + #questInfo_1.questList
  View.Group_Quest.Group_Num.Txt_All:SetText(questListCount)
  View.Group_Quest.Group_Num.Txt_Completed:SetText(completeCount)
end

return Controller
