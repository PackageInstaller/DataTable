local View = require("UIESC/UIESCView")
local DataModel = require("UIESC/UIESCDataModel")
local Controller = require("UIESC/UIESCController")
local CtrlUserCenter = require("UIESC/UIESCController_UserCenter")
local CtrlLinkPasswordSet = require("UIESC/Controller/UIESCController_LinkPasswordSet")
local FuncController = require("UIESC/UIESCFuncController")
local CommonItem = require("Common/BtnItem")
local CtrlFuncBtns = require("UIESC/Controller/UIESC_FuncBtnsController")
local ViewFunction = {
  ESC_Btn_Close_Click = function(btn, str)
    Controller:Exit()
  end,
  ESC_Btn_Camera_Click = function(btn, str)
    CommonTips.OpenTips(80600368)
  end,
  ESC_Btn_Friends_Click = function(btn, str)
    UIManager:Open("UI/Friends/Friends")
  end,
  ESC_Btn_Notice_Click = function(btn, str)
    CommonTips.OpenNoticeLogin()
  end,
  ESC_Btn_Mail_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if funcCommon.FuncActiveCheck(117) then
      Net:SendProto("mail.get", function(json)
        PlayerData.ServerData.mails = json.mails
        Controller:ExitTo("UI/Mail/Mail")
      end)
    end
  end,
  ESC_Btn_Set_Click = function(btn, str)
    Controller:ExitTo("UI/Setting/Setting")
  end,
  ESC_Btn_LogOut_Click = function(btn, str)
    CommonTips.OnPrompt(80600797, nil, nil, function()
      HasAddGloableTrainUpdate = nil
      local TimerHelper = require("Common/Timer/TimerHelper")
      TimerHelper.Stop("TrainGloableUpdate")
      TimerHelper.Stop("TrainWheelUpdate")
      SdkHelper.TryLogout()
      PlayerData:Logout()
    end)
  end,
  ESC_Btn_Signln_Click = function(btn, str)
    Controller:ExitTo("UI/SignIn/SignIn")
  end,
  ESC_Group_Info_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ClickHead()
  end,
  ESC_Group_Info_Btn_ChangeName_Click = function(btn, str)
    local timestamp = PlayerData:GetUserInfo().name_punish_time or 0
    Controller:CheckModifyIsPunish("UI/Common/Group_InputName", timestamp, 80600172)
  end,
  ESC_Group_Info_Group_Energy_Btn_Add_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy", nil, function()
      local userInfo = PlayerData:GetUserInfo()
      View.Group_Info.Group_Energy.Txt_Num:SetText(userInfo.energy .. "/" .. userInfo.max_energy)
      View.Group_Info.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end)
  end,
  ESC_Group_Info_Group_HomeEnergy_Btn_Add_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.OpenMoveEnergyUseItem(function()
      homeCommon.SetMoveEnergyElement(View.Group_Info.Group_HomeEnergy)
      View.Group_Info.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end)
  end,
  ESC_Group_Info_Group_Loadage_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Energy_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Loadage_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_HomeEnergy_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Gold_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Gold_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_Diamond_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  ESC_Group_Info_Group_Diamond_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Btn_MoreInfo_Click = function(btn, str)
    View.Group_Info.Group_MoreInfo.self:SetActive(true)
  end,
  ESC_Group_Info_Group_MoreInfo_Group_Trade_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Group_Trade_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Btn_Fans_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Btn_Rep_Click = function(btn, str)
    Controller:ShowAllRep()
  end,
  ESC_Group_Info_Group_MoreInfo_Btn_LessInfo_Click = function(btn, str)
    View.Group_Info.Group_MoreInfo.self:SetActive(false)
  end,
  ESC_Group_AllRep_Btn_Close_Click = function(btn, str)
    View.Group_AllRep.self:SetActive(false)
  end,
  ESC_Group_AllRep_ScrollGrid_CityList_SetGrid = function(element, elementIndex)
    Controller:RefreshRepElement(element, elementIndex)
  end,
  ESC_Group_ChangeProfilePhoto_ScrollGrid_ProfilePhoto_SetGrid = function(element, elementIndex)
    Controller:RefreshHeadElement(element, elementIndex)
  end,
  ESC_Group_ChangeProfilePhoto_ScrollGrid_ProfilePhoto_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ClickHeadElement(str)
  end,
  ESC_Group_ChangeProfilePhoto_Btn_Close_Click = function(btn, str)
    Controller:CloseChangeHeadPanel(false)
  end,
  ESC_Group_ChangeProfilePhoto_Btn_Use_Click = function(btn, str)
    Controller:CloseChangeHeadPanel(true)
  end,
  ESC_Group_AllRep_Btn_BG_Click = function(btn, str)
    View.Group_AllRep.self:SetActive(false)
  end,
  ESC_Group_ChangeProfilePhoto_Btn_BG_Click = function(btn, str)
    Controller:CloseChangeHeadPanel(false)
  end,
  ESC_Group_Info_Group_License_Btn_Lv_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({id = 86000004}))
  end,
  ESC_Group_Info_Btn_LCZspine_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    local gender = PlayerData:GetUserInfo().gender or 1
    local characterId = gender == 1 and 70000067 or 70000063
    local json = Json.encode({characterId = characterId})
    UIManager:Open("UI/ChangeSkin/ChangeSkin", json)
  end,
  ESC_NewScrollGrid_BtnList_SetGrid = function(element, elementIndex)
    local info = DataModel.FuncShowList[elementIndex]
    element.Btn_Func.self:SetClickParam(elementIndex)
    element.Btn_Func.Img_Icon:SetSprite(info.icon)
    element.Btn_Func.Txt_Name:SetText(info.name)
    element.Btn_Func.Img_Tip:SetActive(false)
    if info.prefab == "UI/Achievement/Achievement" then
      element.Btn_Func.Img_Tip:SetActive(RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0)
    end
    if info.prefab == "UI/Home_MachiningMenu/Home_MachiningMenu" then
      local machiningData = require("UIHome_MachiningMenu/UIHome_MachiningMenuDataModel")
      machiningData.InitData()
      element.Btn_Func.Img_Tip:SetActive(machiningData.GetRedPointState())
    end
    if info.prefab == "UI/CollectionCard/CardBooklet" then
      local isRed = require("UICardBooklet/UICardBookletDataModel").CheckRed()
      element.Btn_Func.Img_Tip:SetActive(isRed)
    end
    if info.prefab == "UI/DailyAttendance/DailyAttendance" then
      local isRed = require("UIDailyAttendance/UIDailyAttendanceDataModel").GetRedState()
      element.Btn_Func.Img_Tip:SetActive(isRed)
    end
    if info.prefab == "UI/Store/Store" then
      local StoreDataModel = require("UIStore/UIStoreDataModel")
      element.Btn_Func.Img_Tip:SetActive(StoreDataModel.GetStoreRedState())
    end
    if info.prefab == "UI/Entrust/Entrust" then
      element.Btn_Func.Img_Tip:SetActive(PlayerData.IsEntrustShowRed())
    end
    if info.prefab == "UI/Gacha/GachaNew" then
      local red = require("UIGachaNew/UIGachaNewDataModel").GachaIsRedPoint()
      element.Btn_Func.Img_Tip:SetActive(red)
    end
    if info.prefab == "UI/StageQuest/StageQuest" then
      if info.funcId == 125 then
        local red = require("UIStageQuest/UIStageQuestDataModel"):GetRedPoint(nil)
        element.Btn_Func.Img_Tip:SetActive(red)
      elseif info.funcId == 132 then
        local red = require("UIStageQuest/UIStageQuestDataModel"):GetRedPoint(nil, 4)
        element.Btn_Func.Img_Tip:SetActive(red)
      end
    end
    if info.funcId == 111 then
      element.Btn_Func.Img_Tip:SetActive(QuestTrace.CheckQuestCanReceive())
    end
    if info.prefab == "UI/Login/AcountInfo" then
      CtrlUserCenter:InitElement(element)
    end
    if info.prefab == "UI/Login/Link_Login/LinkPasswordSet" then
      CtrlLinkPasswordSet:InitElement(element)
    end
    if info.prefab == "UI/Activity/ActivityMain" then
      local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
      element.Btn_Func.Img_Tip:SetActive(ActivityMainDataModel.GetMainAllRedState())
    end
  end,
  ESC_NewScrollGrid_BtnList_Group_Item_Btn_Func_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.FuncShowList[idx]
    if info.prefab == "" then
      CommonTips.OpenTips(80600368)
      return
    end
    if (info.prefab == "UI/Home_MachiningMenu/Home_MachiningMenu" or info.prefab == "UI/Prison/Overview/Prison" or info.prefab == "UI/Database/Database" or info.prefab == "UI/PlotReview/PlotReview" or info.prefab == "UI/CollectionCard/CardBooklet" or info.prefab == "UI/TrainSound/TrainSound" or info.prefab == "UI/StageQuest/StageQuest" or info.prefab == "UI/Activity/ActivityMain") and CommonTips.GuideAsset() then
      return
    end
    if info.prefab == "UI/Squads/Squads" then
      local status = {
        Current = "MainUI",
        hasOpenThreeView = false,
        squadIndex = PlayerData.BattleInfo.squadIndex
      }
      Controller:ExitTo(info.prefab, Json.encode(status))
      return
    elseif info.prefab == "UI/Store/Store" then
      Controller:OpenStoreBuyDiamond()
      return
    elseif info.prefab == "UI/PlotReview/PlotReview" then
      Net:SendProto("plot.info", function(json)
        Controller:ExitTo("UI/PlotReview/PlotReview", Json.encode(json.plot_paragraph))
      end)
      return
    elseif info.prefab == "UI/Login/AcountInfo" then
      FuncController:OnFuncAccountInfo()
      return
    elseif info.prefab == "UI/community/community" then
      FuncController:OnFuncCommunity()
      return
    elseif info.prefab == "UI/Login/Link_Login/LinkPasswordSet" then
      CtrlLinkPasswordSet:OnBtnLinkPasswordSet()
      return
    elseif info.prefab == "UI/clientservice/clientservice" then
      FuncController:OnFuncServices()
      return
    elseif info.prefab == "UI/BP_Quest/BattlePass_Quest" then
      local isOpen, currentBattleId = PlayerData:GetNowPassData()
      if PlayerData.CurrentBattleId ~= nil and PlayerData.CurrentBattleId ~= currentBattleId or PlayerData.CurrentBattleId == nil then
        Net:SendProto("battle_pass.bp_info", function(json)
          if json.quests then
            for k, v in pairs(json.quests) do
              PlayerData.ServerData.quests[k] = v
            end
          end
          Controller:ExitTo(info.prefab)
        end)
      else
        Net:SendProto("quest.list", function(json)
          PlayerData.ServerData.quests = json.quests
          Controller:ExitTo(info.prefab)
        end, EnumDefine.QuestListDefine.All)
      end
      return
    elseif info.prefab == "UI/StageQuest/StageQuest" then
      if info.funcId == 132 then
        Net:SendProto("quest.stage_quests", function(json)
          Controller:ExitTo(info.prefab, Json.encode({titleIndex = 4}))
        end)
      else
        Net:SendProto("quest.stage_quests", function(json)
          Controller:ExitTo(info.prefab)
        end)
      end
      return
    elseif info.prefab == "UI/MainUI/PassageTrafficRank" then
      Net:SendProto("main.overview", function(json)
        local UIPassageTrafficRankDataModel = require("UIPassageTrafficRank/UIPassageTrafficRankDataModel")
        UIPassageTrafficRankDataModel.clearScore = json.current_clean or 1
        Net:SendProto("station.psg_source_info", function(json)
          PlayerData.RefreshSolicitData(json)
          Controller:ExitTo(info.prefab)
        end)
      end)
      return
    elseif info.prefab == "UI/Gacha/GachaNew" then
      Net:SendProto("recruit.pool_info", function(json)
        UIManager:Open("UI/Gacha/GachaNew")
      end)
      return
    elseif info.funcId == 108 then
      CommonTips.OpenToHomeCarriageeditor()
      return
    end
    if info.param ~= nil and info.param ~= "" then
      Controller:ExitTo(info.prefab, Json.encode(info.param))
    else
      Controller:ExitTo(info.prefab)
    end
  end,
  ESC_Btn_Friends_Btn_CustomerService_Click = function(btn, str)
    CtrlFuncBtns:OnBtnCustomerService()
  end,
  ESC_Group_Info_Txt_UID_Btn_Copy_Click = function(btn, str)
    CS.UnityEngine.GUIUtility.systemCopyBuffer = PlayerData:GetUserInfo().uid
    CommonTips.OpenTips(80602254)
  end,
  ESC_Group_Info_Group_Gold_Btn_Detail_Click = function(btn, str)
    Controller.OnGoldDetailBtnClick()
  end,
  ESC_Group_Info_Group_MoreInfo_Group_Machine_Btn_Add_Click = function(btn, str)
  end,
  ESC_Group_Info_Group_MoreInfo_Group_Machine_Btn_Icon_Click = function(btn, str)
  end,
  ESC_Group_AllCoin_Btn_BG_Click = function(btn, str)
    Controller.CloseGoldDetailPanel()
  end,
  ESC_Group_AllCoin_ScrollGrid_CoinList_SetGrid = function(element, elementIndex)
    Controller.RefreshGoldDetailElement(element, elementIndex)
  end,
  ESC_Group_AllCoin_Btn_Close_Click = function(btn, str)
    Controller.CloseGoldDetailPanel()
  end,
  ESC_Group_LevelReward_Btn_Close_Click = function(btn, str)
  end,
  ESC_Group_LevelReward_Img_BG_Group_Tab_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
  end,
  ESC_Group_LevelReward_Img_BG_Group_Tab_ScrollGrid_Tab_Group_Item_Btn_Unfinished_Click = function(btn, str)
  end,
  ESC_Group_LevelReward_Img_BG_Group_TopRight_Group_Unlock_StaticGrid_UnlockRight_SetGrid = function(element, elementIndex)
  end,
  ESC_Group_LevelReward_Img_BG_Group_BotRight_Img_RewardBg_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  ESC_Group_LevelReward_Img_BG_Group_BotRight_Img_RewardBg_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  ESC_Group_LevelReward_Img_BG_Group_TakeBtn_Btn_Take_Click = function(btn, str)
  end,
  ESC_ScrollGrid_BtnList_SetGrid = function(element, elementIndex)
    local info = DataModel.FuncShowList[elementIndex]
    element.Btn_Func.self:SetClickParam(elementIndex)
    element.Btn_Func.Img_Icon:SetSprite(info.icon)
    element.Btn_Func.Txt_Name:SetText(info.name)
    element.Btn_Func.Img_Tip:SetActive(false)
    if info.prefab == "UI/Achievement/Achievement" then
      element.Btn_Func.Img_Tip:SetActive(RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0)
    end
  end,
  ESC_ScrollGrid_BtnList_Group_Item_Btn_Func_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.FuncShowList[idx]
    if info.prefab == "" then
      CommonTips.OpenTips(80600368)
      return
    end
    if info.prefab == "UI/Squads/Squads" then
      local status = {
        Current = "MainUI",
        hasOpenThreeView = false,
        squadIndex = PlayerData.BattleInfo.squadIndex
      }
      Controller:ExitTo(info.prefab, Json.encode(status))
      return
    elseif info.prefab == "UI/Store/Store" then
      Controller:OpenStoreBuyDiamond()
      return
    elseif info.prefab == "UI/PlotReview/PlotReview" then
      Net:SendProto("plot.info", function(json)
        Controller:ExitTo("UI/PlotReview/PlotReview", Json.encode(json.plot_paragraph))
      end)
      return
    end
    if info.param ~= nil and info.param ~= "" then
      Controller:ExitTo(info.prefab, Json.encode(info.param))
    else
      Controller:ExitTo(info.prefab)
    end
  end
}
return ViewFunction
