local DataModel = {}
local HomeController = require("UIHome/UIHomeController")
local HomeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local HomeCoachController = require("UIHomeCoach/UIHomeCoachController")
local passengerDataModel = require("UIPassenger/UIPassengerDataModel")
local View = require("UIFriendTrain/UIFriendTrainView")
local Timer = require("Common/Timer")

function DataModel.InitTrainData()
  TrainCameraManager:OpenCamera(2)
  CommonCoachData.InitCoachBagTagId()
  CommonCoachData.RefreshData()
  HomeController:RefreshTrains()
  HomeCoachController:InitEnvironment()
  HomeCoachDataModel.InitRoomData()
  HomeCoachDataModel.InitPresetData(PlayerData.ServerData.user_home_info.pre_dress_up)
  HomeCharacterManager:RecycleAll()
  HomeCoachDataModel.CalcCurrentCharacter()
  HomeCoachDataModel.CalcCurrentPet()
  HomeCoachDataModel.RemoveNoEmptyRoomCharacter()
  passengerDataModel.CreateHomePassenger()
  HomeCharacterManager:CreateAll(HomeCoachDataModel.characterData, HomeCoachDataModel.petData)
  HomeManager:OpenHome(0)
end

function DataModel.GetHeadPath()
  local avatar = PlayerData.visitInfo.avatar
  if avatar == "" then
    local gender = PlayerData.visitInfo.gender or 1
    local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if head ~= nil and head.playerHeadList ~= nil then
      return head.playerHeadList[gender + 1].playerHeadPath, nil
    end
  end
  local photoFactory = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
  if photoFactory ~= nil then
    return photoFactory.imagePath, photoFactory
  end
  return "", nil
end

function DataModel.UpdateStoleInfo()
  View.Group_Info.Group_ClearCD:SetActive(false)
  local config = PlayerData:GetFactoryData(99900192)
  local maxStoleCount = config.stealNum
  DataModel.RemainStoleCount = maxStoleCount - PlayerData.visitInfo.rubbish_area.stolen_cnt
  View.Group_Info.Group_Clear.Txt_Num:SetText(DataModel.RemainStoleCount .. "/" .. maxStoleCount)
  View.Group_Info.Group_ClearRate.Txt_Num:SetText(math.floor(PlayerData.visitInfo.rubbish_area.steal_rate * 100) .. "%")
  local cfg = PlayerData:GetFactoryData(99900192)
  local baseRate = 1 - PlayerData.visitInfo.rubbish_area.success_cnt * cfg.doReduceRate
  View.Group_RateTips.Img_Tips.Txt_Tips:SetText(string.format(GetText(80611182), tostring(math.floor(baseRate * 100)), tostring(math.floor(PlayerData.visitInfo.rubbish_area.pet_ex_rate * 100))))
  local stoleCD = config.stealCD
  local lastStoleTime = PlayerData.visitInfo.rubbish_area.stolen_ts or 0
  DataModel.NextCanStoleTime = lastStoleTime + stoleCD
  if lastStoleTime ~= 0 and DataModel.NextCanStoleTime > TimeUtil:GetServerTimeStamp() then
    local remainTime = DataModel.NextCanStoleTime - TimeUtil:GetServerTimeStamp()
    local timeTable = TimeUtil:SecondToTableHMS(remainTime)
    View.Group_Info.Group_ClearCD:SetActive(true)
    View.Group_Info.Group_ClearCD.Txt_Num:SetText(string.format("%02d:%02d", timeTable.minute, timeTable.second))
    if View.timer ~= nil then
      View.timer:Stop()
      View.timer = nil
    end
    View.timer = Timer.New(1, function()
      DataModel.UpdateStoleCD()
    end)
    View.timer:Start()
  else
    View.Group_Info.Group_ClearCD:SetActive(false)
  end
  local leastRubbishNum = PlayerData:GetFactoryData(99900192).rubProtect * PlayerData.visitInfo.rubbish_area.max_space or 0
  DataModel.canStoleRubbishNum = PlayerData.visitInfo.rubbish_area.waste_block - leastRubbishNum
end

function DataModel.UpdateStoleCD()
  if DataModel.NextCanStoleTime ~= 0 and DataModel.NextCanStoleTime > TimeUtil:GetServerTimeStamp() then
    local remainTime = DataModel.NextCanStoleTime - TimeUtil:GetServerTimeStamp()
    local timeTable = TimeUtil:SecondToTableHMS(remainTime)
    View.Group_Info.Group_ClearCD:SetActive(true)
    View.Group_Info.Group_ClearCD.Txt_Num:SetText(string.format("%02d:%02d", timeTable.minute, timeTable.second))
  else
    View.Group_Info.Group_ClearCD:SetActive(false)
    View.timer:Stop()
  end
end

return DataModel
