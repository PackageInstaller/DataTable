local CommonItem = require("Common/BtnItem")
local View = require("UIActivityBattleBossNew/UIActivityBattleBossNewView")
local DataModel = require("UIActivityBattleBossNew/UIActivityBattleBossNewDataModel")
local Controller = {}

function Controller:Init()
  View.Group_Main.Group_Tower.Img_Title:SetSprite(GetResPath(88300311))
  View.Group_Main.Group_Depth.Img_Title:SetSprite(GetResPath(88300312))
  View.Group_Main.Group_Singularity.Img_Title:SetSprite(GetResPath(88300313))
  if DataModel.ActivityCA.rewardPreviewList and table.count(DataModel.ActivityCA.rewardPreviewList) > 0 then
    View.Group_Main.Group_Shop.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(table.count(DataModel.ActivityCA.rewardPreviewList))
    View.Group_Main.Group_Shop.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
  end
  View.Group_Main.Group_Tower.Btn_Plot.self:SetActive(PlayerData.plot_paragraph[tostring(DataModel.TurntableCA.FirstParagraphid)] ~= nil)
  local isOpen = PlayerData:GetPlayerLevel() >= DataModel.ActivityCA.openLv
  View.Group_Main.Group_Tower.Btn_Open.Txt_T:SetActive(isOpen)
  View.Group_Main.Group_Depth.Btn_Open.Txt_T:SetActive(isOpen)
  View.Group_Main.Group_Tower.Img_Mask.self:SetActive(not isOpen)
  View.Group_Main.Group_Tower.Img_Mask.Txt_T:SetText(string.format(GetText(80611024), DataModel.ActivityCA.openLv))
  Net:SendProto("station.turntable_battle", function(json)
    DataModel.BatterInfo = json.ttb_level[tostring(DataModel.StationCA.id)]
    DataModel.TowerScore = json.score
    local progressAll = 0
    local progressAllMax = 0
    for i, v in ipairs(DataModel.TurntableCA.levelBossList) do
      local data = DataModel.TurntableCA.levelBossList[i]
      local levelList = PlayerData:GetFactoryData(data.id).levelList
      local levelCountMax = #levelList
      local progress = DataModel:GetCurrentLevelData(i - 1, levelCountMax)
      progressAll = progressAll + progress
      progressAllMax = progressAllMax + levelCountMax
    end
    View.Group_Main.Group_Tower.Group_Progress.Txt_Num:SetText(progressAll .. "/" .. progressAllMax)
    View.Group_Main.Group_Tower.Group_Progress.Img_Bar:SetFilledImgAmount(progressAll / progressAllMax)
  end, DataModel.StationCA.id)
  local isRedFlag = Controller:GetRedDotStatus(DataModel.ActivityId)
  View.Group_Main.Group_Tower.Img_Red:SetActive(isRedFlag)
  Controller:RefreshAbyssTime()
end

function Controller:RewardSetElemnt(element, elementIndex)
  local row = DataModel.ActivityCA.rewardPreviewList[elementIndex]
  CommonItem:SetActivityPreviewItem(element.Group_Item, row)
  element.Group_Item.Btn_Item:SetClickParam(row.id)
end

function Controller:RewardClickElemnt(id)
  CommonTips.OpenPreRewardDetailTips(id)
end

function Controller:PlayDialog()
  local function callBack()
  end
  
  if DataModel.TurntableCA.clickParagraphid and DataModel.TurntableCA.clickParagraphid ~= "" and DataModel.TurntableCA.clickParagraphid > -1 then
    UIManager:Open("UI/Dialog/Dialog", Json.encode({
      id = DataModel.TurntableCA.clickParagraphid
    }), callBack, callBack)
  end
end

function Controller:OpenBattleBoss()
  if PlayerData:GetPlayerLevel() < DataModel.ActivityCA.openLv then
    return
  end
  UIManager:Open("UI/BattleBoss/BattleBoss", Json.encode({
    stationId = DataModel.StationCA.id,
    turntableId = DataModel.StationCA.turntableId,
    isActivity = true,
    activityId = DataModel.ActivityId,
    batterInfo = DataModel.BatterInfo,
    towerScore = DataModel.TowerScore
  }))
end

function Controller:OpenBattleBossStore()
  local buildingCA = PlayerData:GetFactoryData(DataModel.StationCA.turnExchangeBuildId, "BuildingFactory")
  if PlayerData:GetUserInfo().lv < (buildingCA.playerLevel or 0) then
    return
  end
  local storeList = buildingCA.exchangeStoreList
  local storeId, remainTime, isOpen
  for i = 1, #storeList do
    isOpen, remainTime = PlayerData:IsStoreOpen(storeList[i].id)
    if isOpen then
      storeId = storeList[i].id
      break
    end
  end
  if not isOpen then
    return
  end
  Net:SendProto("shop.info", function(json)
    UIManager:Open(buildingCA.uiPath, Json.encode({
      buildingId = DataModel.StationCA.turnExchangeBuildId,
      isCityMapIn = false,
      name = buildingCA.name,
      initMode = "Exchange"
    }))
    PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
  end, storeId)
end

function Controller:RefreshAbyssTime()
  if DataModel.curPeriodId ~= nil then
    local curPeriodCA = PlayerData:GetFactoryData(DataModel.curPeriodId)
    if not TimeUtil:IsActive(curPeriodCA.startTime, curPeriodCA.endTime) then
      DataModel.curPeriodId = nil
    end
  end
  if DataModel.curPeriodId == nil then
    local abyssCA = PlayerData:GetFactoryData(DataModel.StationCA.turntableId)
    for i = 1, #abyssCA.abyssPeriodList do
      local periodCA = PlayerData:GetFactoryData(abyssCA.abyssPeriodList[i].id)
      if TimeUtil:IsActive(periodCA.startTime, periodCA.endTime) then
        DataModel.curPeriodId = periodCA.id
        break
      end
    end
  end
  local starRed, rewardRed = PlayerData:GetAbyssRedPoint()
  View.Group_Main.Group_Depth.Img_Red:SetActive(starRed or rewardRed)
  if DataModel.curPeriodId == nil then
    View.Group_Main.Group_Depth.Txt_Time:SetText(GetText(80607793))
    View.Group_Main.Group_Depth.Img_Mask.self:SetActive(true)
    View.Group_Main.Group_Depth.Img_Mask.Txt_T:SetText("")
  else
    local curPeriodCA = PlayerData:GetFactoryData(DataModel.curPeriodId)
    local endTime = curPeriodCA.endTime
    local remainTime = TimeUtil:LastTime(endTime)
    local remainTable = TimeUtil:SecondToTable(remainTime)
    if remainTable.day > 0 then
      View.Group_Main.Group_Depth.Txt_Time:SetText(string.format(GetText(80607764), remainTable.day, remainTable.hour))
    elseif 0 < remainTable.hour then
      View.Group_Main.Group_Depth.Txt_Time:SetText(string.format(GetText(80600007), remainTable.hour, remainTable.minute))
    else
      View.Group_Main.Group_Depth.Txt_Time:SetText(string.format(GetText(80600008), remainTable.minute))
    end
    local curPeriodCA = PlayerData:GetFactoryData(DataModel.curPeriodId)
    isOpen = PlayerData:GetPlayerLevel() >= curPeriodCA.openLv
    View.Group_Main.Group_Depth.Img_Mask.self:SetActive(not isOpen)
    View.Group_Main.Group_Depth.Img_Mask.Txt_T:SetText(string.format(GetText(80611024), curPeriodCA.openLv))
  end
end

function Controller:TryOpenAbyssPanel()
  if PlayerData:GetPlayerLevel() < DataModel.ActivityCA.openLv then
    return
  end
  if DataModel.curPeriodId ~= nil then
    local curPeriodCA = PlayerData:GetFactoryData(DataModel.curPeriodId)
    if not TimeUtil:IsActive(curPeriodCA.startTime, curPeriodCA.endTime) then
      DataModel.curPeriodId = nil
    end
  end
  if DataModel.curPeriodId == nil then
    Controller:RefreshAbyssTime()
    return
  end
  UIManager:Open("UI/Chapter/Battle_Abyss/Battle_Abyss", Json.encode({
    id = DataModel.StationCA.turntableId,
    activityId = DataModel.ActivityId
  }))
end

function Controller:GetRedDotStatus(id)
  local activeCA = PlayerData:GetFactoryData(id)
  local stationCA = PlayerData:GetFactoryData(activeCA.correspondingCity[1].id)
  local turntableBattleCA = PlayerData:GetFactoryData(stationCA.turntableId)
  if PlayerData:GetUserInfo().lv < activeCA.openLv then
    return false
  end
  local BattleBossController = require("UIBattleBoss/UIBattleBossController")
  for i, v in ipairs(turntableBattleCA.levelBossList) do
    local data = turntableBattleCA.levelBossList[i]
    local levelList = PlayerData:GetFactoryData(data.id).levelList
    local levelCountMax = #levelList
    if PlayerData.ServerData.level_record then
      local isRedFlag = BattleBossController:RefreshRedFlag(tostring(levelList[levelCountMax].id))
      if isRedFlag == true then
        return isRedFlag
      end
    end
  end
  return PlayerData.plot_paragraph[tostring(turntableBattleCA.FirstParagraphid)] == nil
end

return Controller
