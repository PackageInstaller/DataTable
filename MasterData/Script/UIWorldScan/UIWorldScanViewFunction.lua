local View = require("UIWorldScan/UIWorldScanView")
local DataModel = require("UIWorldScan/UIWorldScanDataModel")
local Controller = require("UIWorldScan/UIWorldScanController")
local ViewFunction = {
  WorldScan_Btn_Scan_Click = function(btn, str)
    Controller:StartScan()
  end,
  WorldScan_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    DataModel.isAuto = false
    View.Group_Auto.Group_List.self:SetActive(false)
    if DataModel.isBattleReturn and DataModel.activityId then
      UIManager:Open("UI/Activity/ActivityMain", Json.encode({
        id = DataModel.activityId,
        backToHome = true
      }))
    else
      UIManager:GoBack()
    end
  end,
  WorldScan_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    DataModel.isAuto = false
    View.Group_Auto.Group_List.self:SetActive(false)
    UIManager:GoHome()
  end,
  WorldScan_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  WorldScan_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  WorldScan_Group_Btn_ScrollGrid_BtnList_SetGrid = function(element, elementIndex)
    Controller:SetBtnEventGridElelment(element, elementIndex)
  end,
  WorldScan_Group_Btn_ScrollGrid_BtnList_Group_Btn_Btn_Event_Click = function(btn, str)
    Controller:ClickEvent(tonumber(str))
  end,
  WorldScan_Group_Btn_Btn_Main_Click = function(btn, str)
    DataModel.isOpenBtnList = -DataModel.isOpenBtnList
    Controller:OpenBtnList()
  end,
  WorldScan_Group_Scaning_Group_Success_Btn_Close_Click = function(btn, str)
    View.Group_Scaning.self:SetActive(false)
    View.Group_Scaning.Group_Success.self:SetActive(false)
  end,
  WorldScan_Group_Map_ScrollView_Map_Viewport_Content_Btn_CloseDetail_Click = function(btn, str)
    Controller:releaseEvent()
    if UIManager:IsPanelOpened("UI/Chapter/Battle_DungeonScan") then
      UIManager:ClosePanel(false, "UI/Chapter/Battle_DungeonScan")
      local DungeonScanDataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
      DungeonScanDataModel.IsAutoDungeon = 0
      Controller:endAuto()
    end
  end,
  WorldScan_Group_Auto_Btn_Setup_Click = function(btn, str)
    if View.Group_Auto.Group_List.self.IsActive == false then
      View.Group_Auto.Group_List.self:SetActive(true)
    else
      View.Group_Auto.Group_List.self:SetActive(false)
    end
    if UIManager:IsPanelOpened("UI/Chapter/Battle_DungeonScan") and DataModel.isAuto == true then
      Controller:endAuto()
      for i = 1, #DataModel.autoTypeList do
        for j = 1, #DataModel.eventList do
          local v = DataModel.eventList[j]
          if v.typeIndex == DataModel.autoTypeList[i] then
            Controller:ClickEvent(j, true, false)
            return
          end
        end
      end
    end
  end,
  WorldScan_Group_Auto_Group_List_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  WorldScan_Group_Auto_Group_List_StaticGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetBtnAutoItemGridElelment(element, elementIndex)
  end,
  WorldScan_Group_Auto_Group_List_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    print_r(str)
    Controller:clickBtnAutoItem(tonumber(str))
  end,
  WorldScan_Group_Auto_Group_List_Btn_Confirm_Click = function(btn, str)
  end,
  WorldScan_Group_Auto_Group_List_Btn_Cancel_Click = function(btn, str)
  end,
  WorldScan_Group_Auto_Btn_Start_Click = function(btn, str)
    if #DataModel.autoTypeList > 0 then
      DataModel.isAuto = true
      View.Group_Auto.Btn_Start:SetActive(DataModel.isAuto == false)
      View.Group_Auto.Btn_End:SetActive(DataModel.isAuto == true)
      for i = 1, #DataModel.autoTypeList do
        for j = 1, #DataModel.eventList do
          local v = DataModel.eventList[j]
          if v.typeIndex == DataModel.autoTypeList[i] then
            View.Group_Auto.Group_List.self:SetActive(false)
            Controller:ClickEvent(j, true, true)
            return
          end
        end
      end
      CommonTips.OpenTips(80612119)
      Controller:endAuto()
    elseif View.Group_Auto.Group_List.self.IsActive == false then
      View.Group_Auto.Group_List.self:SetActive(true)
    else
      CommonTips.OpenTips(80612120)
    end
  end,
  WorldScan_Group_Auto_Btn_End_Click = function(btn, str)
    Controller:endAuto()
    for i = 1, #DataModel.autoTypeList do
      for j = 1, #DataModel.eventList do
        local v = DataModel.eventList[j]
        if v.typeIndex == DataModel.autoTypeList[i] then
          Controller:ClickEvent(j, true, false)
          return
        end
      end
    end
  end
}
return ViewFunction
