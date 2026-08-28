local View = require("UIActivityMain/UIActivityMainView")
local DataModel = require("UIActivityMain/UIActivityMainDataModel")
local Controller = require("UIActivityMain/UIActivityMainController")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  ActivityMain_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_Group_List_ScrollGrid_List_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.backToHome then
      UIManager:GoHome()
      return
    end
    if DataModel.LeftActivityCA.showUI ~= "" and DataModel.LeftActivityCA.showUI ~= nil then
      UIManager:GoBack()
      UIManager:GoBack()
      return
    end
    if DataModel.isGobackTwo then
      UIManager:GoBack(false)
    end
    UIManager:GoBack()
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ActivityMain_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ActivityMain_Group_SignIn_Group_EventSignIn_ScrollGrid_Board_SetGrid = function(element, elementIndex)
    Controller:SignInSetElement(element, elementIndex)
  end,
  ActivityMain_Group_SignIn_Group_EventSignIn_ScrollGrid_Board_Group_Item_Group_Item_BtnPolygon_BG_Click = function(btn, str)
    Controller:SignInClickElement(tonumber(str))
  end,
  ActivityMain_Group_SignIn_Group_EventSignIn_Group_Decorate_Btn_Details_Click = function(btn, str)
  end,
  ActivityMain_Group_BlackTea_Group_NotJoin_Group_Add_Btn__Click = function(btn, str)
    if DataModel.BlackTeaType == DataModel.BlackTeaTypeList.Lock then
      CommonTips.OpenTips(80602587)
    end
    local timeList = DataModel.IsActiveNewTimeOpen(nil, DataModel.LeftActivityCA.index)
    if timeList.isContinue == false and not TimeUtil:IsActive(DataModel.ActivityCA.startTime, DataModel.ActivityCA.endTime) then
      Controller:OpenRightPage()
      return
    end
    if DataModel.BlackTeaType == DataModel.BlackTeaTypeList.NotEnabled then
      local function callBack()
        Net:SendProto("main.participate", function(Jsons)
          if Jsons.activity then
            PlayerData.ServerData.all_activities.ing[tostring(DataModel.LeftActivityCA.id)] = Jsons.activity
          end
          Controller:RefreshBlackTeaJoinPage()
          Controller:RefreshLeftRedState()
        end, DataModel.LeftActivityCA.id)
      end
      
      if DataModel.ActivityCA.joinPlotId and DataModel.ActivityCA.joinPlotId ~= "" then
        UIManager:Open("UI/Dialog/Dialog", Json.encode({
          id = DataModel.ActivityCA.joinPlotId
        }), callBack, callBack)
      end
    end
  end,
  ActivityMain_Group_BlackTea_Group_NotJoin_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:NotJoinRewardSetElemnt(element, tonumber(elementIndex))
  end,
  ActivityMain_Group_BlackTea_Group_NotJoin_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:NotJoinRewardClickElemnt(str)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Quest_Btn__Click = function(btn, str)
    UIManager:Open("UI/Activity/BlackTea/ActivityAchievement")
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_StageAll_Btn__Click = function(btn, str)
    Net:SendProto("quest.list", function(Json)
      UIManager:Open("UI/Activity/BlackTea/ServerProgress")
    end, 6)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_StageOne_Btn__Click = function(btn, str)
    Net:SendProto("quest.list", function(Json)
      UIManager:Open("UI/Activity/BlackTea/PersonalProgress")
    end, 6)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Store_Btn__Click = function(btn, str)
    local parms = {}
    parms.activityId = DataModel.LeftActivityCA.id
    parms.shopId = DataModel.ActivityCA.activityStoreList[1].id
    parms.ca = PlayerData:GetFactoryData(parms.shopId)
    Net:SendProto("shop.info", function(json)
      UIManager:Open("UI/Activity/BlackTea/ActiveStore", Json.encode(parms))
    end)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Coin_Btn_GoldCoin_Click = function(btn, str)
    CommonTips.OpenRewardDetail(DataModel.CoinId)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Plot_Group_Plot1_Btn__Click = function(btn, str)
    Controller:OnClickPlot1()
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Plot_Group_Plot2_Btn__Click = function(btn, str)
    Controller:OnClickPlot2()
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Card_Btn__Click = function(btn, str)
    local cardPackId = DataModel.ActivityCA.activityCardPack
    local activityName = DataModel.ActivityCA.name
    
    local function callBack()
      Controller:RefreshCard("Group_BlackTea")
      Controller:RefreshLeftRedState()
    end
    
    UIManager:Open("UI/CollectionCard/CardPack_Open", Json.encode({cardPackId = cardPackId, activityName = activityName}), callBack)
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Buff_Btn__Click = function(btn, str)
    UIManager:Open("UI/Activity/BlackTea/BuffTips")
  end,
  ActivityMain_Group_Construction_Group_NotJoin_Group_Add_Btn__Click = function(btn, str)
    if DataModel.ConstructionType == DataModel.ConstructionTypeList.Lock then
      CommonTips.OpenTips(80602587)
    end
    if TimeUtil:IsActive(DataModel.ActivityCA.startTime, DataModel.ActivityCA.endTime) == false then
      return
    end
    if DataModel.ConstructionType == DataModel.ConstructionTypeList.NotEnabled then
      local function callBack()
        Net:SendProto("main.participate", function(Jsons)
          if Jsons.activity then
            PlayerData.ServerData.all_activities.ing[tostring(DataModel.LeftActivityCA.id)] = Jsons.activity
          end
          Controller:RefreshConstructionJoinPage()
          Controller:RefreshLeftRedState()
        end, DataModel.LeftActivityCA.id)
      end
      
      if DataModel.ActivityCA.joinPlotId and DataModel.ActivityCA.joinPlotId ~= "" then
        UIManager:Open("UI/Dialog/Dialog", Json.encode({
          id = DataModel.ActivityCA.joinPlotId
        }), callBack, callBack)
      end
    end
  end,
  ActivityMain_Group_Construction_Group_NotJoin_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:NotJoinRewardSetElemnt(element, tonumber(elementIndex))
  end,
  ActivityMain_Group_Construction_Group_NotJoin_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:NotJoinRewardClickElemnt(str)
  end,
  ActivityMain_Group_Construction_Group_Join_Group_StageAll_Btn__Click = function(btn, str)
    Net:SendProto("quest.list", function(jsons)
      UIManager:Open("UI/Activity/Construction/AnitaRocketBase/ServerConstruction", Json.encode({
        type = "All",
        id = DataModel.ActivityCA.id
      }))
    end, 6)
  end,
  ActivityMain_Group_Construction_Group_Join_Group_StageOne_Btn__Click = function(btn, str)
    Net:SendProto("quest.list", function(jsons)
      UIManager:Open("UI/Activity/Construction/AnitaRocketBase/ServerConstruction", Json.encode({
        type = "One",
        id = DataModel.ActivityCA.id
      }))
    end, 6)
  end,
  ActivityMain_Group_Construction_Group_Join_Group_Card_Btn__Click = function(btn, str)
    local cardPackId = DataModel.ActivityCA.activityCardPack
    local activityName = DataModel.ActivityCA.name
    
    local function callBack()
      Controller:RefreshCard("Group_Construction")
      Controller:RefreshLeftRedState()
    end
    
    UIManager:Open("UI/CollectionCard/CardPack_Open", Json.encode({cardPackId = cardPackId, activityName = activityName}), callBack)
  end,
  ActivityMain_Group_Construction_Group_Join_Group_Skip_Group_Skip1_Btn__Click = function(btn, str)
    Controller:ConstructionSkip(1)
  end,
  ActivityMain_Group_Construction_Group_Join_Group_Skip_Group_Skip2_Btn__Click = function(btn, str)
    Controller:ConstructionSkip(2)
  end,
  ActivityMain_Group_Construction_Group_Join_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(DataModel.ActivityCA.helpId)
  end,
  ActivityMain_Group_Construction_Group_Join_Btn_Rank_Click = function(btn, str)
    Controller:OpenRankList()
  end,
  ActivityMain_Group_Construction_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:JoinConstructionSetElemnt(element, tonumber(elementIndex))
  end,
  ActivityMain_Group_Construction_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:NotJoinRewardClickElemnt(str)
  end,
  ActivityMain_Group_LevelReward_Drag_LevelReward_BeginDrag = function(direction, dragPos)
    DataModel.startPos = dragPos
    DataModel.onDragLastPos = dragPos
    DataModel.dragEuler = 0
    DataModel.startDragTime = os.time()
    DataModel.startEuler = math.floor(View.Group_LevelReward.Group_Effect.Group_In.transform.localEulerAngles.y)
  end,
  ActivityMain_Group_LevelReward_Drag_LevelReward_EndDrag = function(direction, dragPos)
    if DataModel.dragEuler == 0 then
      return
    end
    local levelStageIndex = DataModel.levelStageIndex
    local middleTransIndex = DataModel.middleTransIndex
    if os.time() - DataModel.startDragTime < 0.1 then
      levelStageIndex = DataModel.dragEuler > 0 and levelStageIndex + 1 or levelStageIndex - 1
      middleTransIndex = DataModel.dragEuler > 0 and middleTransIndex + 1 or middleTransIndex - 1
    else
      levelStageIndex = DataModel.levelStageIndex + math.modf(DataModel.dragEuler / 60)
      middleTransIndex = DataModel.middleTransIndex + math.modf(DataModel.dragEuler / 60)
      local overDragEuler = math.abs(DataModel.dragEuler) % 60
      if 15 < overDragEuler then
        levelStageIndex = DataModel.dragEuler > 0 and levelStageIndex + 1 or levelStageIndex - 1
        middleTransIndex = DataModel.dragEuler > 0 and middleTransIndex + 1 or middleTransIndex - 1
      end
    end
    if levelStageIndex > #DataModel.levelTemplate then
      levelStageIndex = 1
    end
    if levelStageIndex < 1 then
      levelStageIndex = #DataModel.levelTemplate
    end
    if middleTransIndex > #DataModel.levelTrans then
      middleTransIndex = 1
    end
    if middleTransIndex < 1 then
      middleTransIndex = #DataModel.levelTrans
    end
    local correctEuler = 60 * (middleTransIndex - 1)
    local fromQua = View.Group_LevelReward.Group_Effect.Group_In.transform.localRotation
    local toQua = Quaternion.Euler(0, correctEuler, 0)
    DataModel.levelRewardEndCoroutine = View.self:StartC(LuaUtil.cs_generator(function()
      local time = 0
      while time < 0.1 do
        time = time + Time.deltaTime
        if 0.1 < time then
          time = 0.1
        end
        local t = time / 0.1
        View.Group_LevelReward.Group_Effect.Group_In.transform.localRotation = Quaternion.Lerp(fromQua, toQua, t)
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      end
      local soundList = {30002620, 30002624}
      local sound = SoundManager:CreateSound(soundList[math.random(1, #soundList)])
      if sound then
        sound:Play()
      end
      Controller.RefreshLevelRewardSelect(middleTransIndex)
      Controller.RefreshLevelReward(levelStageIndex)
      if 0 < DataModel.dragEuler then
        Controller.RefreshLevelTrans(DataModel.middleTransIndex + 2, DataModel.levelStageIndex + 2)
      else
        Controller.RefreshLevelTrans(DataModel.middleTransIndex - 2, DataModel.levelStageIndex - 2)
      end
    end))
    local canvasGroup = View.Group_LevelReward.Group_LevelReward_New.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    local alpha = canvasGroup.alpha
    if alpha < 1 then
      DOTweenTools.DOFade(View.Group_LevelReward.Group_LevelReward_New.transform, 1, 0.5)
    end
  end,
  ActivityMain_Group_LevelReward_Drag_LevelReward_OnDrag = function(direction, dragPos)
    if not DataModel.onDragLastPos then
      return
    end
    local deltaX = DataModel.onDragLastPos.x - dragPos.x
    DataModel.onDragLastPos = dragPos
    if deltaX ~= 0 then
      DataModel.dragEuler = DataModel.dragEuler + deltaX * 0.1
    end
    if math.abs(DataModel.dragEuler) > 60 then
      DataModel.dragEuler = 0 < DataModel.dragEuler and 60 or -60
    end
    View.Group_LevelReward.Group_Effect.Group_In.transform.localRotation = Quaternion.Euler(0, DataModel.startEuler + DataModel.dragEuler, 0)
    local canvasGroup = View.Group_LevelReward.Group_LevelReward_New.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    local alpha = canvasGroup.alpha
    alpha = 1 - math.abs(DataModel.dragEuler) / 60
    if alpha < 0.3 then
      alpha = 0.3
    end
    if 1 < alpha then
      alpha = 1
    end
    canvasGroup.alpha = alpha
  end,
  ActivityMain_Group_Construction_Group_Join_Slider__Slider = function(slider, value)
  end,
  ActivityMain_Group_Construction_Group_Join_Slider__SliderDown = function(slider)
  end,
  ActivityMain_Group_Construction_Group_Join_Slider__SliderUp = function(slider)
  end,
  ActivityMain_Group_LevelReward_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
  end,
  ActivityMain_Group_LevelReward_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  ActivityMain_Group_LevelReward_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ActivityMain_Group_LevelReward_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ActivityMain_Group_LevelReward_Group_LevelReward_New_Group_Layout_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
    local info = cfg.Playerranklist and cfg.Playerranklist[DataModel.levelStageIndex]
    local levelCfg = PlayerData:GetFactoryData(info.id, "ListFactory")
    local elementCfg = levelCfg.Unlockright[elementIndex]
    element.Group_Bg.Txt_:SetText(GetText(elementCfg.id))
    element.Group_Bgopen:SetActive(DataModel.rankReward[info.level])
    element.Group_Bgopen.Txt_:SetText(GetText(elementCfg.id))
  end,
  ActivityMain_Group_LevelReward_Group_LevelReward_New_Group_Layout_Group_Rewards_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
    local info = cfg.Playerranklist and cfg.Playerranklist[DataModel.levelStageIndex]
    local levelCfg = PlayerData:GetFactoryData(info.id, "ListFactory")
    local rewardInfo = levelCfg.reward[elementIndex]
    CommonItem:SetItem(element.Group_Item, rewardInfo)
    element.Group_Item.Btn_Item:SetClickParam(rewardInfo.id)
  end,
  ActivityMain_Group_LevelReward_Group_LevelReward_New_Group_Layout_Group_Rewards_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main_ScrollGrid_Main_SetGrid = function(element, elementIndex)
    Controller:SetActivitySignInElement(element, elementIndex)
    element.Img_BG.Btn_Bottom:SetClickParam(elementIndex)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main_ScrollGrid_Main_Group_Item_Img_BG_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:SetActivitySignInRewardItemElement(element, elementIndex)
    element.Btn_Item:SetClickParam(DataModel.ActivitySignInRewardCA[elementIndex].id)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main_ScrollGrid_Main_Group_Item_Img_BG_Btn_Bottom_Click = function(btn, str)
    Controller:ActivitySignInClickElement(str)
  end,
  ActivityMain_Group_LevelReward_Group_LevelReward_New_Group_Layout_Group_Claim_Btn_Claimed_Click = function(btn, str)
    local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
    local info = cfg.Playerranklist and cfg.Playerranklist[DataModel.levelStageIndex]
    Net:SendProto("home.rank_reward", function(json)
      CommonTips.OpenShowItem(json.reward)
      table.insert(PlayerData:GetHomeInfo().rank_reward, info.level)
      DataModel.rankReward[info.level] = 1
      btn:SetActive(false)
      View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Claim.Group_ButtonClaimed:SetActive(true)
      local trans = DataModel.levelTrans[DataModel.middleTransIndex]
      trans.Group_LevelReward.Group_UnLock:SetActive(true)
      trans.Group_LevelReward.Group_Drawing:SetActive(false)
      DataModel.levelTrans[DataModel.middleTransIndex] = trans
      Controller.RefreshLeftRedState()
    end, tostring(DataModel.levelStageIndex - 1))
  end,
  ActivityMain_Group_Construction_Group_Join_Btn_Store_Click = function(btn, str)
    if DataModel.ActivityCA and DataModel.ActivityCA.correspondingBuild and #DataModel.ActivityCA.correspondingBuild > 0 then
      local exchangeId = DataModel.ActivityCA.correspondingBuild[1].id
      Controller:OpenExchangePanel(exchangeId)
    end
  end,
  ActivityMain_Group_Construction_Group_Join_Btn_Level_Click = function(btn, str)
    UIManager:Open("UI/BuildLevel/BuildLevel", Json.encode({buildingId = 84400001, IsActivityMainIn = true}))
  end,
  ActivityMain_Group_BlackTea_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(DataModel.ActivityCA.helpId)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main_ScrollGrid_Main_Group_Item_Img_BG_Group_Reward_StaticGrid_Reward_Group_SignRWItem_Btn_Item_Click = function(btn, str)
    if not str or str == "" then
      return
    end
    local cfg = PlayerData:GetFactoryData(str)
    if not cfg then
      return
    end
    CommonTips.OpenPreItemTips({
      itemId = tonumber(str)
    })
  end,
  ActivityMain_Group_BlackTea_Group_Join_Group_Plot_Group_Level_Btn__Click = function(btn, str)
    UIManager:Open("UI/Activity/BlackTea/BlackLevel", Json.encode({
      activityId = DataModel.ActivityCA.id
    }))
  end,
  ActivityMain_Group_BlackTea_Btn_Video_Click = function(btn, str)
    local webUrl = DataModel.ActivityCA.videoAddress
    local pathList = string.split(webUrl, "|")
    local videoPath = pathList[1]
    if GameSetting.fromRes ~= "CN" then
      if GameSetting.fromRes == "KR" then
        videoPath = pathList[3]
      else
        videoPath = pathList[2]
      end
    end
    if videoPath == nil or videoPath == "" then
      return
    end
    CS.UnityEngine.Application.OpenURL(videoPath)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_Btn_Main_Click = function(btn, str)
    Controller:ClickTabBtn(DataModel.TabType.Main)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Main_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Main_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_Btn_Plot_Click = function(btn, str)
    Controller:ClickTabBtn(DataModel.TabType.Plot)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Plot_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Plot_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_Btn_Time_Click = function(btn, str)
    Controller:ClickTabBtn(DataModel.TabType.Time)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Time_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Time_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_Btn_Operate_Click = function(btn, str)
    Controller:ClickTabBtn(DataModel.TabType.Operate)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Operate_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_ScrollView_Tab_Viewport_Content_ScrollGrid_Operate_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main1_ScrollGrid_Main1_SetGrid = function(element, elementIndex)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main1_ScrollGrid_Main1_Group_Item_Img_BG_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main1_ScrollGrid_Main1_Group_Item_Img_BG_Group_Reward_StaticGrid_Reward_Group_SignRWItem_Btn_Item_Click = function(btn, str)
  end,
  ActivityMain_Group_ActivitySignIn_Group_Main1_ScrollGrid_Main1_Group_Item_Img_BG_Btn_Bottom_Click = function(btn, str)
  end,
  ActivityMain_Group_ActivitySignIn_Group_jump_Btn_Card_Click = function(btn, str)
  end,
  ActivityMain_Group_ActivitySignIn_Group_jump_Btn_detail_Click = function(btn, str)
  end,
  ActivityMain_Group_List_ScrollView_Tab_Viewport_Content_Btn_Main_Click = function(btn, str)
    Controller:ClickTabBtn(DataModel.TabType.Main)
  end,
  ActivityMain_Group_List_ScrollView_Tab_Viewport_Content_ScrollGrid_Main_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_Group_List_ScrollView_Tab_Viewport_Content_ScrollGrid_Main_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_Group_List_ScrollView_Tab_Viewport_Content_Btn_Plot_Click = function(btn, str)
    Controller:ClickTabBtn(DataModel.TabType.Plot)
  end,
  ActivityMain_Group_List_ScrollView_Tab_Viewport_Content_ScrollGrid_Plot_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ActivityMain_Group_List_ScrollView_Tab_Viewport_Content_ScrollGrid_Plot_Group_Tab_Btn_Tab_Click = function(btn, str)
    Controller:ClickLeftActive(tonumber(str))
  end,
  ActivityMain_Group_Residue_Group_BlackTea_Group_Residue_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:NotJoinRewardSetElemnt(element, tonumber(elementIndex))
  end,
  ActivityMain_Group_Residue_Group_BlackTea_Group_Residue_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:NotJoinRewardClickElemnt(str)
  end,
  ActivityMain_Group_Residue_Group_Monster_Group_Residue_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:NotJoinRewardSetElemnt(element, tonumber(elementIndex))
  end,
  ActivityMain_Group_Residue_Group_Monster_Group_Residue_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:NotJoinRewardClickElemnt(str)
  end,
  ActivityMain_Group_Residue_Group_BlackTea_Group_Residue_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(DataModel.ActivityCA.helpId)
  end,
  ActivityMain_Group_Residue_Group_Monster_Group_Residue_Btn_Help_Click = function(btn, str)
    CommonTips.OpenHelp(DataModel.ActivityCA.helpId)
  end,
  ActivityMain_Group_Residue_Group_Construction_Group_Residue_Group_Preview_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  ActivityMain_Group_Residue_Group_Construction_Group_Residue_Group_Preview_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  ActivityMain_Group_Residue_Group_Construction_Group_Residue_Btn_Help_Click = function(btn, str)
  end,
  ActivityMain_Group_Residue_Group_Construction_Group_Residue_ScrollGrid_List_SetGrid = function(element, elementIndex)
  end,
  ActivityMain_Group_Residue_Group_Construction_Group_Residue_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end
}
return ViewFunction
