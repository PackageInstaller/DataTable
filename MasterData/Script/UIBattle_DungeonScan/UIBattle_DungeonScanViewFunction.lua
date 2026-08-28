local View = require("UIBattle_DungeonScan/UIBattle_DungeonScanView")
local MainController = require("UIMainUI/UIMainUIController")
local DataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
local WorldScanController = require("UIWorldScan/UIWorldScanController")
local WorldScanDataModel = require("UIWorldScan/UIWorldScanDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  Battle_DungeonScan_Btn_Return_Click = function(btn, str)
    DataModel.IsAutoDungeon = 0
    WorldScanController:endAuto()
    WorldScanController:releaseEvent()
    UIManager:GoBack()
  end,
  Battle_DungeonScan_Group_Right_Group_Drop_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.ChooseRewardList[elementIndex]
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Group_First.self:SetActive(false)
    element.Group_Allready.self:SetActive(false)
    CommonItem:SetItem(element.Group_Item, row)
  end,
  Battle_DungeonScan_Group_Right_Group_Drop_ScrollGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.ChooseRewardList[tonumber(str)].id, nil, true)
  end,
  Battle_DungeonScan_Group_Right_Btn_Energy_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy", nil, function()
      local user_info = PlayerData:GetUserInfo()
      local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
      local maxEnergy = user_info.max_energy or initConfig.energyMax
      local currEnergy = user_info.energy or 0
      View.Group_Right.Btn_Energy.Txt_Num:SetText(currEnergy .. "/" .. maxEnergy)
    end)
  end,
  Battle_DungeonScan_Group_Right_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  Battle_DungeonScan_Group_Right_Group_Fight_Btn_StartFight_Click = function(btn, str)
    if TrainManager.FreeCamera then
      PlayerData.TempCache.Yaw = TrainManager.FreeCamera.m_yaw
      PlayerData.TempCache.Pitch = TrainManager.FreeCamera.m_pitch
    end
    local mainDataModel = require("UIMainUI/UIMainUIDataModel")
    mainDataModel.TrainEventId = DataModel.EventId
    mainDataModel.TrainLevelId = DataModel.LevelId
    print_r("mainDataModel.TrainLevelId", mainDataModel.TrainLevelId)
    PlayerData.TempCache.EventIndex = DataModel.EventIndex
    PlayerData.TempCache.AreaId = DataModel.AreaId
    PlayerData.TempCache.ActivityId = DataModel.ActivityId
    if TrainManager.CurrTrainState ~= TrainState.None then
      MainController.ImmediatelyStop()
    end
    MainController.Battle(DataModel.NeedLv)
  end,
  Battle_DungeonScan_Group_Right_Group_Auto_Btn_Auto_Click = function(btn, str)
    if DataModel.Type == "pollute" then
      local event = PlayerData:GetFactoryData(DataModel.EventId, "AFKEventFactory")
      local levelId = event.levelId
      local level = PlayerData:GetFactoryData(levelId, "LevelFactory")
      local user_info = PlayerData:GetUserInfo()
      local currEnergy = user_info.energy or 0
      if currEnergy < level.energyEnd then
        CommonTips.OpenTips(80606882)
        DataModel.IsAutoDungeon = 0
        WorldScanController:endAuto()
        return
      end
    end
    DataModel.IsAutoDungeon = DataModel.IsAutoDungeon == 0 and 1 or 0
    if DataModel.IsAutoDungeon == 0 then
      WorldScanController:endAuto()
    end
    View.Group_Right.Group_Auto.Btn_Auto.Group_On.self:SetActive(DataModel.IsAutoDungeon == 1)
    DataModel.AutoStep = 180
    View.Group_Right.Group_Auto.Txt_Time:SetActive(DataModel.IsAutoDungeon == 1)
  end,
  Battle_DungeonScan_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    DataModel.IsAutoDungeon = 0
    WorldScanController:endAuto()
    WorldScanController:releaseEvent()
    UIManager:GoBack()
  end,
  Battle_DungeonScan_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    DataModel.IsAutoDungeon = 0
    WorldScanController:endAuto()
    UIManager:GoHome()
  end,
  Battle_DungeonScan_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Battle_DungeonScan_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
