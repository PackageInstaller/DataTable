local View = require("UITrainBattleSettlement/UITrainBattleSettlementView")
local DataModel = require("UITrainBattleSettlement/UITrainBattleSettlementDataModel")
local Controller = require("UITrainBattleSettlement/UITrainBattleSettlementController")
local ViewFunction = {
  TrainBattleSettlement_ScrollView_Select_Viewport_Content_Group_Select_Btn_Return_Click = function(btn, str)
  end,
  TrainBattleSettlement_ScrollView_Select_Viewport_Content_Group_Select_Group_Level_Group_Level_Btn_Select_Click = function(btn, str)
  end,
  TrainBattleSettlement_ScrollView_Select_Viewport_Content_Group_Select_Group_Level_StaticGrid_Level_SetGrid = function(element, elementIndex)
    Controller:SetLevelGrid(element, elementIndex)
  end,
  TrainBattleSettlement_ScrollView_Select_Viewport_Content_Group_Select_Group_Level_StaticGrid_Level_Group_Level_Btn_Select_Click = function(btn, str)
    Controller:ShowParamInfo(str)
    View.ScrollView_Select.Viewport.Content.Group_Select.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
  end,
  TrainBattleSettlement_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
    if MainManager.bgSceneName == "Kabaneri" then
      CommonTips.OpenLoading(nil, "", nil, function()
        local battleUIManager = CBus:GetManager(CS.ManagerName.BattleUIManager, true)
        if battleUIManager then
          CS.FRef.setProperty(battleUIManager, "_canvas", UIManager:GetCanvas())
        end
        CBus:ChangeScene("Main", function()
          UIManager:Open("UI/Activity/ActivityMain", Json.encode({
            id = DataModel.activityCA.id
          }))
        end)
      end)
    end
  end,
  TrainBattleSettlement_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  TrainBattleSettlement_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  TrainBattleSettlement_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80307033}
    UIManager:Open("UI/TrainBattle/Group_Help", Json.encode(data))
  end,
  TrainBattleSettlement_Group_readiness_Group_FixButton_Btn_Fix_Click = function(btn, str)
    Controller:ConfirmRepair()
  end,
  TrainBattleSettlement_Group_readiness_Group_OilButton_Btn_Oil_Click = function(btn, str)
    Controller:ConfirmOil()
  end,
  TrainBattleSettlement_Group_readiness_Group_battery_Group_ammoNum_Btn_ammoNum_Click = function(btn, str)
    Controller:OnAmmoBtnClick()
  end,
  TrainBattleSettlement_Btn_Build_Click = function(btn, str)
    Controller:TryOpenCarriageEditor()
  end,
  TrainBattleSettlement_Group_TrainOverview_Btn_All_Click = function(btn, str)
    Controller:SetTrainOverViewShow(true)
  end,
  TrainBattleSettlement_Group_TrainOverview_Group_Overview_Btn_CloseOverview_Click = function(btn, str)
    Controller:SetTrainOverViewShow(false)
  end,
  TrainBattleSettlement_Group_Right_Btn_Close_Click = function(btn, str)
    Controller:RefreshAutoBtn(false)
    Controller:HideParamInfo()
    View.ScrollView_Select.Viewport.Content.Group_Select.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
  end,
  TrainBattleSettlement_Group_Right_Img_infoPath_Group_Cost_Btn_Energy_Click = function(btn, str)
    Controller:OpenEnergyBuy()
  end,
  TrainBattleSettlement_Group_Right_Img_infoPath_Group_Cost_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  TrainBattleSettlement_Group_Right_Img_infoPath_Group_Drop_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    Controller:SetLevelRewardGrid(element, elementIndex)
  end,
  TrainBattleSettlement_Group_Right_Img_infoPath_Group_Drop_ScrollGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  TrainBattleSettlement_Group_Right_Img_infoPath_Group_Fight_Btn_StartFight_Click = function(btn, str)
    Controller:TryLevelGo()
  end,
  TrainBattleSettlement_Group_readiness_Btn_Button_Click = function(btn, str)
    Controller:AutoFix()
  end,
  TrainBattleSettlement_Group_Right_Img_infoPath_Group_Auto_Btn_Auto_Click = function(btn, str)
    Controller:OnClickBtnAuto()
  end,
  TrainBattleSettlement_Group_Open_Btn_Close_Click = function(btn, str)
    View.Group_Open:SetActive(false)
  end,
  TrainBattleSettlement_Group_readiness_Group_battery_Btn_battery_Click = function(btn, str)
    local cb
    local t = {}
    t.type = 1
    t.weaponIdx = 2
    t.coachIdx = 0
    local netData = PlayerData:GetHomeInfo().coach_template
    if netData[1] ~= nil then
      t.coachUid = netData[1]
      local coachData = PlayerData:GetHomeInfo().coach_store[1]
      if coachData then
        t.coachId = tonumber(coachData.id)
      end
    end
    
    function cb()
      Controller:Init(true)
    end
    
    UIManager:Open("UI/Trainfactory/CoachWeaponSelect", Json.encode(t), cb)
  end,
  TrainBattleSettlement_Group_readiness_Group_battery_Btn_Nobattery_Click = function(btn, str)
  end
}
return ViewFunction
