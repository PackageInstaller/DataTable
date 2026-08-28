local CommonItem = require("Common/BtnItem")
local View = require("UIActivityMain/UIActivityMainView")
local DataModel = require("UIActivityMain/UIActivityMainDataModel")
local CardPackDataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local ServerProgressDataModel = require("UIServerProgress/UIServerProgressDataModel")
local PersonalProgressDataModel = require("UIPersonalProgress/UIPersonalProgressDataModel")
local AchievementDataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")
local ServerConstructionDataModel = require("UIServerConstruction/UIServerConstructionDataModel")
local Controller = {}

function Controller:InitPageShow()
  for k, v in pairs(DataModel.ClosePageList) do
    if View[v] then
      View[v].self:SetActive(false)
    end
  end
end

function Controller:Init(id)
  local index = DataModel.GetIndex(id)
  Controller:InitPageShow()
  DataModel.SetNextRefreshListTime()
  Controller:ClickTabBtn(nil, index)
end

function Controller:SetElement(element, elementIndex)
  local row = DataModel.LeftListNow[tonumber(elementIndex)]
  local Btn_Tab = element.Btn_Tab
  Btn_Tab:SetClickParam(elementIndex)
  Btn_Tab.Img_Unselected:SetActive(tonumber(elementIndex) ~= DataModel.ChooseLeftIndex)
  Btn_Tab.Img_Selected:SetActive(tonumber(elementIndex) == DataModel.ChooseLeftIndex)
  Btn_Tab.Img_Red:SetActive(DataModel.GetLeftListRedState(row.id))
  Btn_Tab.Img_New:SetActive(false)
  Btn_Tab.Txt_Name:SetText(GetText(row.name))
  Btn_Tab:SetSprite(row.png)
  Btn_Tab.Group_Time.self:SetActive(false)
  Btn_Tab.Group_Lv.self:SetActive(false)
  Btn_Tab.Group_Task.self:SetActive(false)
  if row.isCountDownNow then
    Btn_Tab.Group_Time.self:SetActive(true)
    local lastTime = TimeUtil:SecondToTable(row.remainingTime)
    if lastTime.day > 0 then
      Btn_Tab.Group_Time.Txt_Time:SetText(string.format(GetText(80609200), lastTime.day))
    elseif 0 < lastTime.hour then
      Btn_Tab.Group_Time.Txt_Time:SetText(string.format(GetText(80609201), lastTime.hour))
    else
      Btn_Tab.Group_Time.Txt_Time:SetText(string.format(GetText(80609201), 1))
    end
  elseif row.isShowLvNow then
    Btn_Tab.Group_Lv.self:SetActive(true)
    local needLv = row.showLv
    Btn_Tab.Group_Lv.Txt_Lv:SetText(string.format(GetText(80610982), needLv))
  elseif row.isTaskNow then
    Btn_Tab.Group_Task.self:SetActive(true)
    local questId = row.activeCA.questId
    local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
    Btn_Tab.Group_Task.Txt_Task:SetText(string.format(GetText(80611017), questCA.name))
  elseif row.isShowTradeLvNow then
    Btn_Tab.Group_Lv.self:SetActive(true)
    local needLv = row.showTradeLv
    Btn_Tab.Group_Lv.Txt_Lv:SetText(string.format(GetText(80611500), needLv))
  end
end

function Controller:ClickTabBtn(tabType, index, force)
  if tabType == DataModel.TabIndex then
    if tabType == DataModel.TabType.Time then
      tabType = DataModel.TabType.Main
    elseif tabType == DataModel.TabType.Main then
      tabType = DataModel.TabType.Plot
    elseif tabType == DataModel.TabType.Plot then
      tabType = DataModel.TabType.Operate
    elseif tabType == DataModel.TabType.Operate then
      tabType = DataModel.TabType.Time
    end
  end
  if tabType == nil then
    tabType = DataModel.TabIndex
  end
  if (tabType == DataModel.TabType.Plot or tabType == DataModel.TabType.Operate) and CommonTips.GuideAsset() then
    return
  end
  local ScrollNow
  local ScrollTime = View.ScrollView_Tab.Viewport.Content.ScrollGrid_Time
  local ScrollMain = View.ScrollView_Tab.Viewport.Content.ScrollGrid_Main
  local ScrollPlot = View.ScrollView_Tab.Viewport.Content.ScrollGrid_Plot
  local ScrollOperate = View.ScrollView_Tab.Viewport.Content.ScrollGrid_Operate
  local list = {}
  if tabType == DataModel.TabType.Main then
    list = DataModel.MainList
    ScrollNow = ScrollMain
  elseif tabType == DataModel.TabType.Plot then
    list = DataModel.PlotList
    ScrollNow = ScrollPlot
  elseif tabType == DataModel.TabType.Time then
    list = DataModel.TimeList
    ScrollNow = ScrollTime
  elseif tabType == DataModel.TabType.Operate then
    list = DataModel.OperateList
    ScrollNow = ScrollOperate
  end
  local count = #list
  if 0 < count then
    View.ScrollView_Tab.Viewport.Content.Btn_Time.Img_Selected:SetActive(tabType == DataModel.TabType.Time)
    View.ScrollView_Tab.Viewport.Content.Btn_Main.Img_Selected:SetActive(tabType == DataModel.TabType.Main)
    View.ScrollView_Tab.Viewport.Content.Btn_Plot.Img_Selected:SetActive(tabType == DataModel.TabType.Plot)
    View.ScrollView_Tab.Viewport.Content.Btn_Operate.Img_Selected:SetActive(tabType == DataModel.TabType.Operate)
    ScrollTime.self:SetActive(tabType == DataModel.TabType.Time)
    ScrollMain.self:SetActive(tabType == DataModel.TabType.Main)
    ScrollPlot.self:SetActive(tabType == DataModel.TabType.Plot)
    ScrollOperate.self:SetActive(tabType == DataModel.TabType.Operate)
    Controller:CloseOldUI()
    DataModel.LeftListNow = {}
    DataModel.LeftListNow = list
    DataModel.TabIndex = tabType
    DataModel.TabScrollNow = ScrollNow
    DataModel.TabScrollNow.grid.self:SetDataCount(table.count(DataModel.LeftListNow))
    DataModel.TabScrollNow.grid.self:RefreshAllElement()
    Controller:setScrollHeight(ScrollNow, count)
    DataModel.TabScrollNow.grid.self:MoveToPos(index or 1)
    Controller:ClickLeftActive(index or 1, true, true)
    Controller:RefreshLeftRedState()
  end
end

function Controller:setScrollHeight(ScrollNow, count)
  local maxHeight = 640
  local curHeight = 0
  curHeight = count * 113
  if maxHeight < curHeight then
    ScrollNow.self:SetHeight(maxHeight)
    ScrollNow.grid.self.ScrollRect.enabled = true
  else
    ScrollNow.self:SetHeight(curHeight)
    ScrollNow.grid.self.ScrollRect.enabled = false
  end
end

function Controller:Open_Group_SignIn(row)
  View.Group_SignIn.Group_EventSignIn.Img_:SetSprite(GetResPath(88300038))
  View.Group_SignIn.Group_EventSignIn.Group_Decorate.Img_Title:SetSprite(GetResPath(88300040))
  for k, v in pairs(PlayerData:GetSignInfo()) do
    local activityCA = PlayerData:GetActivityCABySignId(k)
    if activityCA and activityCA.mod == "\231\173\190\229\136\176" and row.activeCA.signinId == tonumber(k) then
      local singInCA = PlayerData:GetFactoryData(k)
      DataModel.SignInConfig = singInCA
      DataModel.SignInConfig.Sever = v
      break
    end
  end
  local signCount = table.count(DataModel.SignInConfig.SigninRewardList)
  View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:SetDataCount(signCount)
  View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:RefreshAllElement()
  local isOffest = false
  if DataModel.SignInConfig.Sever.count >= signCount - 2 then
    View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:MoveToPos(signCount - 2)
  else
    View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:MoveToPos(DataModel.SignInConfig.Sever.count + 1)
    isOffest = true
  end
  if isOffest then
    local anchoredPositionX = View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self.RectTransform.anchoredPosition.x
    local anchoredPositionY = View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self.RectTransform.anchoredPosition.y
    local result = (DataModel.SignInConfig.Sever.count - 1) / 5
    local diffPoint = 0.9 - 0.016 * (DataModel.SignInConfig.Sever.count - 1)
    diffPoint = diffPoint < 0 and 0.85 or diffPoint
    local offset = 10 + math.ceil(result) * diffPoint
    anchoredPositionX = anchoredPositionX + offset * (DataModel.SignInConfig.Sever.count - 1)
    View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self.RectTransform.anchoredPosition = Vector2(anchoredPositionX, anchoredPositionY)
    View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:HandleScrollEvent(Vector2(0, 0))
  end
  View.Group_SignIn.Img_BG:SetSprite(row.activeCA.bgPath)
  View.Group_SignIn.Img_Background:SetActive(false)
  View.Group_SignIn.Group_EventSignIn.Group_Decorate.Group_Time.self:SetActive(false)
  if row.activeCA.isTime == true then
    View.Group_SignIn.Group_EventSignIn.Group_Decorate.Group_Time.self:SetActive(true)
    local timeStart = TimeUtil:GetTimeTable(DataModel.SignInConfig.startTime)
    local timeEnd = TimeUtil:GetTimeTable(DataModel.SignInConfig.endTime)
    local a_1 = timeStart.year .. "/" .. timeStart.month .. "/" .. timeStart.day
    local b_1 = timeStart.hour .. ":" .. timeStart.minute
    local a_2 = timeEnd.year .. "/" .. timeEnd.month .. "/" .. timeEnd.day
    local b_2 = timeEnd.hour .. ":" .. timeEnd.minute
    local str = string.format(GetText(80602405), a_1, b_1, a_2, b_2)
    View.Group_SignIn.Group_EventSignIn.Group_Decorate.Group_Time.Txt_EndTime:SetText(str)
  end
end

function Controller:SignInSetElement(element, elementIndex)
  local Group_Item = element.Group_Item
  Group_Item.Img_Mark:SetActive(false)
  Group_Item.BtnPolygon_BG:SetClickParam(elementIndex)
  Group_Item.Img_Oh:SetActive(false)
  local sign = PlayerData:GetSignInfo()[tostring(DataModel.SignInConfig.id)]
  if tonumber(elementIndex) <= sign.count then
    Group_Item.Img_Mark:SetActive(true)
  else
    Group_Item.Img_Mark:SetActive(false)
  end
  if tonumber(elementIndex) == sign.count + 1 and sign.status == 0 then
    Group_Item.Img_Oh:SetActive(true)
  end
  local reward_t = DataModel.SignInConfig.SigninRewardList[tonumber(elementIndex)]
  local pngQuality = reward_t.pngQuality
  local nameQuality = reward_t.nameQuality
  local name = reward_t.name
  local color = reward_t.color
  local rewardId = reward_t.id
  local awardList = PlayerData:GetFactoryData(rewardId).awardList
  Group_Item.Txt_Num:SetText("")
  Group_Item.Group_Name.Img_Name.Txt_Name:SetText("")
  if -1 < name then
    Group_Item.Group_Name.Img_Name.Txt_Name:SetText(GetText(name))
  end
  if awardList and awardList[1] then
    local itemId = awardList[1].id
    local reward = PlayerData:GetFactoryData(itemId)
    local num = awardList[1].num
    Group_Item.Txt_Num:SetText(num)
    if name == -1 then
      Group_Item.Group_Name.Img_Name.Txt_Name:SetText(reward.name)
    end
  end
  Group_Item.Img_Frame:SetActive(pngQuality ~= "")
  if pngQuality ~= "" then
    Group_Item.Img_Frame.Txt_Des:SetText(GetText(nameQuality))
    Group_Item.Img_Frame.Txt_Des:SetColor("#" .. color)
    Group_Item.Img_Frame:SetSprite(pngQuality)
  end
  if PlayerData:GetUserInfo().gender == 1 then
    Group_Item.Img_Icon:SetSprite(reward_t.pngMan)
  else
    Group_Item.Img_Icon:SetSprite(reward_t.pngWoman)
  end
end

function Controller:SignInClickElement(str)
  local index = str
  local sign = PlayerData:GetSignInfo()[tostring(DataModel.SignInConfig.id)]
  local id = DataModel.SignInConfig.id
  if sign then
    if sign.status == 1 then
      if index <= sign.count then
        CommonTips.OpenTips(80600191)
        return
      else
        CommonTips.OpenTips(80600194)
        return
      end
    elseif index == sign.count + 1 then
      if sign.status == 1 then
        CommonTips.OpenTips(80600191)
        return
      end
      Net:SendProto("main.sign_in", function(json)
        SdkReporter.TrackSignReward({
          id = id,
          day = sign.count + 1
        })
        if json.reward.role then
          for k, v in pairs(json.reward.role) do
            local ca = PlayerData:GetFactoryData(k)
            local hero_list = {}
            hero_list.hero_id = ca.id
            hero_list.hero_name = ca.name
            hero_list.event_seq = "main.sign_in"
            hero_list.get_times = PlayerData:GetSeverTime()
            ReportTrackEvent.hero_get(hero_list)
          end
        end
        View.Group_SignIn.Group_EventSignIn.ScrollGrid_Board.grid.self:RefreshAllElement()
        CommonTips.OpenShowItem(json.reward)
        PlayerData.ServerData.sign_info = json.user_info.sign_info
        Controller:RefreshLeftRedState()
      end, DataModel.ActivityCA.id)
    elseif index < sign.count + 1 then
      CommonTips.OpenTips(80600191)
      return
    else
      CommonTips.OpenTips(80600194)
      return
    end
  end
end

function Controller:QuestIsFinish(questId)
  if questId == nil then
    return false
  end
  local type = PlayerData.GetQuestState(questId)
  if type == EnumDefine.EQuestState.UnFinish or type == EnumDefine.EQuestState.Lock then
    return false
  end
  return true
end

function Controller:SkipStation(stationId)
  local parms = {}
  parms.index = DataModel.ChooseLeftIndex
  parms.id = DataModel.ActivityCA.id
  UIManager:Open("UI/MainUI/MainUI", Json.encode({isActivity = true}), function()
    UIManager:Open("UI/Activity/ActivityMain", Json.encode(parms))
  end)
  local MapController = require("UIHome/UIHomeMapController")
  MapController:AutoToClickStation(stationId, true)
end

function Controller:SkipQuest(questId)
  if questId == nil then
    return
  end
  UIManager:Open("UI/Quest/Quest", Json.encode({questId = questId}))
end

function Controller:OnClickPlot1()
  local skipId = DataModel.ActivityCA.sequenceList[1].skipId
  local skipCA = PlayerData:GetFactoryData(skipId)
  if DataModel.Plot1Type == DataModel.PlotType.AllNotFinish then
    Controller:SkipStation(skipCA.skipStationStart)
  end
  if DataModel.Plot1Type == DataModel.PlotType.AllFinish then
    Controller:SkipStation(skipCA.skipStationEnd)
  end
  if DataModel.Plot1Type == DataModel.PlotType.Quest then
    Controller:SkipQuest(DataModel.Plot1NowQuestId)
  end
end

function Controller:OnClickPlot2()
  local skipId = DataModel.ActivityCA.sequenceList[2].skipId
  local skipCA = PlayerData:GetFactoryData(skipId)
  if DataModel.Plot2Type == DataModel.PlotType.AllNotFinish then
    Controller:SkipStation(skipCA.skipStationStart)
  end
  if DataModel.Plot2Type == DataModel.PlotType.AllFinish then
    Controller:SkipStation(skipCA.skipStationEnd)
  end
  if DataModel.Plot2Type == DataModel.PlotType.Quest then
    Controller:SkipQuest(DataModel.Plot2NowQuestId)
  end
end

local function ResetGroupJoin(pageName)
  for k, v in pairs(View[pageName].Group_Join) do
    if v ~= "Btn_Help" and v ~= "self" and v.self then
      v.self:SetActive(false)
    end
  end
end

function Controller:RefreshPlotShow(index, lastTime)
  local nowPlot, type
  local skipId = DataModel.ActivityCA.sequenceList[index].skipId
  local skipCA = PlayerData:GetFactoryData(skipId)
  local questId
  if index == 1 then
    type = DataModel.Plot1Type
    questId = DataModel.Plot1NowQuestId
    nowPlot = View.Group_BlackTea.Group_Join.Group_Plot.Group_Plot1
  end
  if index == 2 then
    type = DataModel.Plot2Type
    questId = DataModel.Plot2NowQuestId
    nowPlot = View.Group_BlackTea.Group_Join.Group_Plot.Group_Plot2
  end
  if type == 4 then
    local name = PlayerData:GetFactoryData(skipCA.skipStationStart).name
    nowPlot.Group_Can.self:SetActive(true)
    nowPlot.Group_Can.Txt_Name:SetText(string.format(GetText(80602585), name))
  end
  if type == 5 then
    local name = PlayerData:GetFactoryData(skipCA.skipStationEnd).name
    nowPlot.Group_Can.self:SetActive(true)
    nowPlot.Group_Can.Txt_Name:SetText(string.format(GetText(80602585), name))
  end
  if type == 6 and questId then
    local name = PlayerData:GetFactoryData(questId).name
    nowPlot.Group_Can.self:SetActive(true)
    nowPlot.Group_Can.Txt_Name:SetText(name)
  end
  if type == 2 and lastTime then
    nowPlot.Group_Time.self:SetActive(true)
    local time = TimeUtil:SecondToTable(lastTime)
    if time.day > 0 then
      nowPlot.Group_Time.Txt_Time:SetText(string.format(GetText(80602584), time.day, time.hour))
    else
      nowPlot.Group_Time.Txt_Time:SetText(string.format(GetText(80603020), time.hour, time.minute))
    end
  end
end

function Controller:RefreshPlot()
  local timeList = DataModel.IsActiveNewTimeOpen(nil, DataModel.LeftActivityCA.index)
  DataModel.Plot1Type = DataModel.PlotType.NotEnabled
  DataModel.Plot2Type = DataModel.PlotType.NotEnabled
  DataModel.Plot1NowQuestId = nil
  DataModel.Plot2NowQuestId = nil
  local Group_Plot = View.Group_BlackTea.Group_Join.Group_Plot
  Group_Plot.self:SetActive(true)
  
  local function refresh()
    Group_Plot.Group_Level.self:SetActive(false)
    Group_Plot.Group_Finish.self:SetActive(false)
    local sequenceList = DataModel.ActivityCA.sequenceList
    Group_Plot.Group_Plot1.self:SetActive(sequenceList[1])
    if sequenceList[1] then
      Group_Plot.Group_Plot1.Group_Can.self:SetActive(false)
      Group_Plot.Group_Plot1.Group_Can.Img_RedPoint:SetActive(false)
      Group_Plot.Group_Plot1.Group_Time.self:SetActive(false)
      Group_Plot.Group_Plot1.Group_Quest.self:SetActive(false)
      local lastTime = TimeUtil:LastTime(sequenceList[1].startTime)
      if lastTime < 0 then
        DataModel.Plot1Type = DataModel.PlotType.Enabled
        if 0 < sequenceList[1].questId and DataModel:QuestIsFinish(sequenceList[1].questId) == false then
          DataModel.Plot1Type = DataModel.PlotType.Lock
          Group_Plot.Group_Plot1.Group_Quest.self:SetActive(true)
          local questCA = PlayerData:GetFactoryData(sequenceList[1].questId)
          Group_Plot.Group_Plot1.Group_Quest.Txt_Quest:SetText(string.format(GetText(DataModel.ActivityCA.unlockTips), questCA.name))
        else
          local skipCA = PlayerData:GetFactoryData(sequenceList[1].skipId)
          local finishCount = 0
          local allCount = table.count(skipCA.skipQuestList)
          if skipCA.skipQuestList and 0 < table.count(skipCA.skipQuestList) then
            for k, v in pairs(skipCA.skipQuestList) do
              if v.id ~= -1 then
                if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.UnFinish then
                  DataModel.Plot1NowQuestId = v.id
                  DataModel.Plot1Type = DataModel.PlotType.Quest
                  break
                end
                if DataModel:QuestIsFinish(v.id) then
                  finishCount = finishCount + 1
                end
              end
            end
          end
          if finishCount == 0 and DataModel.Plot1NowQuestId == nil then
            DataModel.Plot1Type = DataModel.PlotType.AllNotFinish
          end
          if finishCount == allCount then
            DataModel.Plot1Type = DataModel.PlotType.AllFinish
          end
          Controller:RefreshPlotShow(1, nil)
        end
      else
        DataModel.Plot1Type = DataModel.PlotType.NotEnabled
        Controller:RefreshPlotShow(1, lastTime)
      end
    end
    Group_Plot.Group_Plot2.self:SetActive(sequenceList[2])
    if sequenceList[2] then
      Group_Plot.Group_Plot2.Group_Can.self:SetActive(false)
      Group_Plot.Group_Plot2.Group_Can.Img_RedPoint:SetActive(false)
      Group_Plot.Group_Plot2.Group_Time.self:SetActive(false)
      Group_Plot.Group_Plot2.Group_Quest.self:SetActive(false)
      local lastTime = TimeUtil:LastTime(sequenceList[2].startTime)
      if lastTime < 0 then
        DataModel.Plot2Type = DataModel.PlotType.Enabled
        if 0 < sequenceList[2].questId and DataModel:QuestIsFinish(sequenceList[2].questId) == false then
          DataModel.Plot2Type = DataModel.PlotType.Lock
          Group_Plot.Group_Plot2.Group_Quest.self:SetActive(true)
          local questCA = PlayerData:GetFactoryData(sequenceList[2].questId)
          Group_Plot.Group_Plot2.Group_Quest.Txt_Quest:SetText(string.format(GetText(DataModel.ActivityCA.unlockTips), questCA.name))
        else
          local skipCA = PlayerData:GetFactoryData(sequenceList[2].skipId)
          local finishCount = 0
          local allCount = table.count(skipCA.skipQuestList)
          if skipCA.skipQuestList and 0 < table.count(skipCA.skipQuestList) then
            for k, v in pairs(skipCA.skipQuestList) do
              if v.id ~= -1 then
                if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.UnFinish then
                  DataModel.Plot2NowQuestId = v.id
                  DataModel.Plot2Type = DataModel.PlotType.Quest
                  break
                end
                if DataModel:QuestIsFinish(v.id) then
                  finishCount = finishCount + 1
                end
              end
            end
          end
          if finishCount == 0 and DataModel.Plot2NowQuestId == nil then
            DataModel.Plot2Type = DataModel.PlotType.AllNotFinish
          end
          if finishCount == allCount then
            DataModel.Plot2Type = DataModel.PlotType.AllFinish
          end
          Controller:RefreshPlotShow(2, nil)
        end
      else
        DataModel.Plot2Type = DataModel.PlotType.NotEnabled
        Controller:RefreshPlotShow(2, lastTime)
      end
    end
    if 0 < DataModel.ActivityCA.levelQuest and DataModel:QuestIsFinish(DataModel.ActivityCA.levelQuest) == true then
      Group_Plot.Group_Plot1.self:SetActive(false)
      Group_Plot.Group_Plot2.self:SetActive(false)
      Group_Plot.Group_Level.self:SetActive(true)
    end
  end
  
  if timeList.isContinue == true then
    refresh()
    return
  end
  if timeList.isActive then
    refresh()
  else
    Group_Plot.Group_Finish.self:SetActive(true)
    Group_Plot.Group_Plot1.self:SetActive(false)
    Group_Plot.Group_Plot2.self:SetActive(false)
    Group_Plot.Group_Finish.self:SetActive(false)
    local lastTime = TimeUtil:LastTime(DataModel.LeftActivityCA.endTime)
    local time = TimeUtil:SecondToTable(lastTime)
    if time.day > 0 then
      Group_Plot.Group_Finish.Txt_Time:SetText(string.format(GetText(80602423), time.day, time.hour))
    else
      Group_Plot.Group_Finish.Txt_Time:SetText(string.format(GetText(80602689), time.hour, time.minute))
    end
  end
end

function Controller:RefreshLeftRedState()
  local Btn_Time = View.ScrollView_Tab.Viewport.Content.Btn_Time
  local Btn_Main = View.ScrollView_Tab.Viewport.Content.Btn_Main
  local Btn_Plot = View.ScrollView_Tab.Viewport.Content.Btn_Plot
  local Btn_Operate = View.ScrollView_Tab.Viewport.Content.Btn_Operate
  Btn_Time.Img_Red:SetActive(DataModel.GetTimeRed())
  Btn_Main.Img_Red:SetActive(DataModel.GetMainRed())
  Btn_Plot.Img_Red:SetActive(DataModel.GetPlotRed())
  Btn_Operate.Img_Red:SetActive(DataModel.GetOperateRed())
  if DataModel.TabScrollNow then
    DataModel.TabScrollNow.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshCard(pageName)
  if DataModel.ActivityCA.activityCardPack <= 0 then
    return
  end
  DataModel.CardPackInfo = CardPackDataModel.GetCardPackInfo(DataModel.ActivityCA.activityCardPack)
  View[pageName].Group_Join.Group_Card.self:SetActive(true)
  View[pageName].Group_Join.Group_Card.Img_RedPoint:SetActive(DataModel.CardPackInfo.extraCardStatus == 1)
  View[pageName].Group_Join.Group_Card.Txt_Num:SetText(string.format(GetText(80603017), DataModel.CardPackInfo.ownCount, DataModel.CardPackInfo.allCount))
end

function Controller:RefreshQuest()
  View.Group_BlackTea.Group_Join.Group_Quest.self:SetActive(false)
  if TimeUtil:IsActive(DataModel.LeftActivityCA.startTime, DataModel.LeftActivityCA.endTime) then
    View.Group_BlackTea.Group_Join.Group_Quest.self:SetActive(true)
    local finishNum, totalNum = AchievementDataModel.GetProgressInfo()
    View.Group_BlackTea.Group_Join.Group_Quest.Txt_Num:SetText(math.ceil(finishNum / totalNum * 100) .. "%")
    View.Group_BlackTea.Group_Join.Group_Quest.Group_Can.Img_RedPoint:SetActive(DataModel.GetAchievementRed())
  end
end

function Controller:RefreshBuff()
  if DataModel.ActivityCA.isTriggerTime then
    local st
    if PlayerData.ServerData.all_activities.ing[tostring(DataModel.ActivityCA.id)] then
      st = PlayerData.ServerData.all_activities.ing[tostring(DataModel.ActivityCA.id)].st
    end
    if st ~= nil then
      local endTime = st + DataModel.ActivityCA.buffContinueTime * 86400
      if endTime < TimeUtil:GetServerTimeStamp() then
        return
      end
    end
  elseif TimeUtil:IsActive(DataModel.ActivityCA.startTime, DataModel.ActivityCA.endTime) == false then
    return
  end
  local StageInfo = ServerProgressDataModel.GetCurStageInfo()
  local cfg = StageInfo.cfg
  if cfg then
    View.Group_BlackTea.Group_Join.Group_Buff.self:SetActive(true)
    local Group_Buff = View.Group_BlackTea.Group_Join.Group_Buff
    local buyIcon = cfg.buyPng
    local buyNum = cfg.buyNum == 0 and "" or string.format(GetText(80602624), cfg.buyNum)
    Group_Buff.Group_Buy.Img_Bg:SetSprite(buyIcon)
    Group_Buff.Group_Buy.Txt_Num:SetText(buyNum)
    local revenueIcon = cfg.revenuePng
    local revenueNum = cfg.revenueNum == 0 and "" or string.format(GetText(80602625), cfg.revenueNum)
    Group_Buff.Group_Revenue.Img_Bg:SetSprite(revenueIcon)
    Group_Buff.Group_Revenue.Txt_Num:SetText(revenueNum)
  end
end

function Controller:RefreshBlackTeaJoinPage()
  local Group_BlackTea = View.Group_BlackTea
  Group_BlackTea.Group_NotJoin.self:SetActive(false)
  local Group_Join = View.Group_BlackTea.Group_Join
  Group_Join.self:SetActive(true)
  DataModel.BlackTeaType = DataModel.BlackTeaTypeList.NotFinish
  ResetGroupJoin("Group_BlackTea")
  Group_BlackTea.Btn_Help.self:SetActive(true)
  Group_BlackTea.Btn_Help.self:SetLocalPositionX(-513)
  Group_BlackTea.Group_Time.self:SetActive(false)
  local timeList = DataModel.IsActiveNewTimeOpen(nil, DataModel.LeftActivityCA.index)
  if DataModel.ActivityCA.isTriggerTime == false and timeList.isContinue == false then
    Group_BlackTea.Group_Time.self:SetActive(true)
    Group_BlackTea.Btn_Help.self:SetLocalPositionX(54)
    local timeStart = string.gsub(DataModel.ActivityCA.startTime, "-", "/")
    timeStart = string.sub(timeStart, 1, 16)
    local timeEnd = string.gsub(DataModel.ActivityCA.endTime, "-", "/")
    timeEnd = string.sub(timeEnd, 1, 16)
    Group_BlackTea.Group_Time.Txt_EndTime:SetText(timeStart .. "-" .. timeEnd)
  end
  if DataModel.ActivityCA.activityStoreList and table.count(DataModel.ActivityCA.activityStoreList) > 0 then
    Group_Join.Group_Coin.self:SetActive(true)
    if DataModel.ActivityCA.activityStoreList[1].id and PlayerData:GetFactoryData(DataModel.ActivityCA.activityStoreList[1].id) then
      local ca = PlayerData:GetFactoryData(DataModel.ActivityCA.activityStoreList[1].id)
      if ca.currencyShow and 0 < table.count(ca.currencyShow) then
        for k, v in pairs(ca.currencyShow) do
          if tonumber(v.id) == 11400231 then
            local currencyCA = PlayerData:GetFactoryData(v.id)
            Group_Join.Group_Coin.Txt_Num:SetText(PlayerData:GetGoodsById(currencyCA.id).num)
            Group_Join.Group_Coin.Img_Icon:SetSprite(currencyCA.buyPath)
            DataModel.CoinId = currencyCA.id
          end
        end
      end
    end
  end
  Group_Join.Group_StageAll.self:SetActive(true)
  Group_Join.Group_StageAll.Group_Can.Img_RedPoint:SetActive(ServerProgressDataModel.GetRedPointState())
  Group_Join.Group_StageOne.self:SetActive(true)
  Group_Join.Group_StageOne.Group_Can.Img_RedPoint:SetActive(PersonalProgressDataModel.GetRedPointState())
  Group_Join.Group_Store.self:SetActive(true)
  Controller:RefreshQuest()
  Controller:RefreshCard("Group_BlackTea")
  Controller:RefreshBuff()
  Controller:RefreshPlot()
end

function Controller:Open_Group_BlackTea(row)
  local Group_BlackTea = View.Group_BlackTea
  Group_BlackTea.Group_Time.self:SetActive(false)
  Group_BlackTea.Group_Join.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.self:SetActive(false)
  Group_BlackTea.Group_Join.Group_Quest.Group_Can.Img_:SetSprite(GetResPath(88300026))
  Group_BlackTea.Group_Join.Group_StageAll.Group_Can.Img_:SetSprite(GetResPath(88300033))
  Group_BlackTea.Group_Join.Group_StageOne.Group_Can.Img_:SetSprite(GetResPath(88300032))
  Group_BlackTea.Group_Join.Group_Store.Img_:SetSprite(GetResPath(88300025))
  Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.self:SetActive(false)
  Group_BlackTea.Group_NotJoin.Group_Preview.self:SetActive(false)
  local isAdd = PlayerData:GetActivityAct(row.id)
  local timeList = DataModel.IsActiveNewTimeOpen(nil, DataModel.LeftActivityCA.index)
  local lastTime = ""
  local time
  if isAdd == false then
    Group_BlackTea.Group_NotJoin.self:SetActive(true)
    Group_BlackTea.Group_NotJoin.Group_Add.self:SetActive(true)
    if row.activeCA.rewardPreviewList and table.count(row.activeCA.rewardPreviewList) > 0 then
      DataModel.NotJoinReward = {}
      for k, v in pairs(row.activeCA.rewardPreviewList) do
        table.insert(DataModel.NotJoinReward, v)
      end
      Group_BlackTea.Group_NotJoin.Group_Preview.self:SetActive(true)
      Group_BlackTea.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(table.count(row.activeCA.rewardPreviewList))
      Group_BlackTea.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
    end
    Group_BlackTea.Group_Time.self:SetActive(false)
    Group_BlackTea.Btn_Help.self:SetLocalPositionX(-513)
    if row.activeCA.isTriggerTime == false and timeList.isContinue == false then
      Group_BlackTea.Group_Time.self:SetActive(true)
      Group_BlackTea.Btn_Help.self:SetLocalPositionX(54)
      local timeStart = string.gsub(row.activeCA.startTime, "-", "/")
      timeStart = string.sub(timeStart, 1, 16)
      local timeEnd = string.gsub(row.activeCA.endTime, "-", "/")
      timeEnd = string.sub(timeEnd, 1, 16)
      Group_BlackTea.Group_Time.Txt_EndTime:SetText(timeStart .. "-" .. timeEnd)
    end
    lastTime = TimeUtil:LastTime(row.activeCA.endTime)
    if 0 < lastTime then
      time = TimeUtil:SecondToTable(lastTime)
    end
    if timeList.isActive then
      if row.activeCA.questId ~= -1 and DataModel:QuestIsFinish(row.activeCA.questId) == false then
        DataModel.BlackTeaType = DataModel.BlackTeaTypeList.Lock
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.self:SetActive(true)
        local questCA = PlayerData:GetFactoryData(row.activeCA.questId)
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.Txt_Quest:SetText(string.format(GetText(DataModel.ActivityCA.unlockTips), questCA.name))
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.Txt_Time:SetActive(false)
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.Txt_Time:SetActive(row.activeCA.isTriggerTime == false and timeList.isContinue == false)
        if time and 0 < time.day then
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Quest.Txt_Time:SetText(string.format(GetText(80602586), time.day))
        end
        return
      end
      Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.self:SetActive(true)
      Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.Txt_Time:SetActive(false)
      if row.activeCA.isTriggerTime == false and timeList.isContinue == false and time and 0 < time.day then
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.Txt_Time:SetActive(true)
        Group_BlackTea.Group_NotJoin.Group_Add.Group_Can.Txt_Time:SetText(string.format(GetText(80602586), time.day))
      end
      DataModel.BlackTeaType = DataModel.BlackTeaTypeList.NotEnabled
    else
      Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.self:SetActive(true)
      local lastTime = TimeUtil:LastTime(row.endTime)
      Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText("")
      if 0 < lastTime then
        local time = TimeUtil:SecondToTable(lastTime)
        if 0 < time.day then
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText(string.format(GetText(80602423), time.day, time.hour))
        else
          Group_BlackTea.Group_NotJoin.Group_Add.Group_Finish.Txt_Time:SetText(string.format(GetText(80602689), time.hour, time.minute))
        end
      end
    end
  else
    Controller:RefreshBlackTeaJoinPage()
  end
end

function Controller:NotJoinRewardSetElemnt(element, elementIndex)
  local row = DataModel.NotJoinReward[elementIndex]
  CommonItem:SetActivityPreviewItem(element.Group_Item, row)
  element.Group_Item.Btn_Item:SetClickParam(row.id)
end

function Controller:NotJoinRewardClickElemnt(id)
  CommonTips.OpenPreRewardDetailTips(id, nil, nil, true)
end

function Controller:ConstructionSkip(index)
  if index == 1 then
    Controller:SkipStation(DataModel.ActivityCA.skipStationStart)
  else
    Controller:SkipStation(DataModel.ActivityCA.skipStationEnd)
  end
end

function Controller:JoinConstructionSetElemnt(element, elementIndex)
  local row = DataModel.ConstructionPreviewList[elementIndex]
  element.Group_Item.Btn_Item:SetClickParam(row.id)
  local ca = PlayerData:GetFactoryData(row.id)
  element.Group_Item.Img_Item:SetSprite(ca.iconPath or ca.imagePath)
  element.Group_Item.Txt_Name:SetText(ca.name)
end

function Controller:RefreshConstructionScheduleAndSkip()
  Net:SendProto("quest.list", function(Json)
    if DataModel.ActivityCA.showUI ~= "Group_Construction" then
      return
    end
    local Group_Schedule = View.Group_Construction.Group_Join.Group_Schedule
    Group_Schedule.self:SetActive(true)
    local max_num = DataModel.ActivityCA.constructionLimit
    local now_num = PlayerData:GetActivityServerConstructionCstNum(DataModel.ActivityCA.id)
    now_num = math.min(now_num, max_num)
    Group_Schedule.Txt_Num:SetText(string.format(GetText(80606881), math.floor(now_num / max_num * 100)))
    Group_Schedule.Img_PB:SetFilledImgAmount(now_num / max_num)
    Group_Schedule.Img_PB.Img_.transform.localPosition = Vector3(DataModel.pbLength * (now_num / max_num) + DataModel.posXMin, 0, 0)
    local serverState = PlayerData:GetActivityServerConstruction(DataModel.ActivityCA.id) and PlayerData:GetActivityServerConstruction(DataModel.ActivityCA.id).completed ~= 0
    local maxCount = table.count(DataModel.ActivityCA.personalConstructionList)
    local maxConstruction = DataModel.ActivityCA.personalConstructionList[maxCount].construction
    local personalState = maxConstruction <= PlayerData:GetActivityPersonalConstructionCstNum(DataModel.ActivityCA.id)
    local Group_Skip = View.Group_Construction.Group_Join.Group_Skip
    Group_Skip.self:SetActive(true)
    Group_Skip.Group_Skip1.self:SetActive(false)
    Group_Skip.Group_Skip2.self:SetActive(false)
    if personalState and serverState and max_num <= now_num then
      Group_Skip.Group_Skip2.self:SetActive(true)
      local name = PlayerData:GetFactoryData(DataModel.ActivityCA.skipStationEnd).name
      Group_Skip.Group_Skip2.Txt_Name:SetText(name)
      View.Group_Construction.Group_.Img_Icon:SetSprite("UI/Activity/Construction/AnitaRocketBase/Main/img_icon")
    else
      Group_Skip.Group_Skip1.self:SetActive(true)
      local name = PlayerData:GetFactoryData(DataModel.ActivityCA.skipStationStart).name
      Group_Skip.Group_Skip1.Txt_Name:SetText(name)
      View.Group_Construction.Group_.Img_Icon:SetSprite("UI/Activity/Construction/AnitaRocketBase/Main/img_icon_not")
    end
    local isRecv = PlayerData:GetActivityData(DataModel.ActivityCA.id) and PlayerData:GetActivityData(DataModel.ActivityCA.id).completed ~= 0
    if isRecv == false and personalState and serverState and max_num <= now_num then
      local isTip = PlayerData:GetPlayerPrefs("string", "constructionSchedule")
      if isTip == nil or isTip == "" then
        CommonTips.OpenCompletePopup(DataModel.ActivityCA.id)
      end
    end
  end, 6)
end

function Controller:RefreshConstructionJoinPage()
  local Group_Construction = View.Group_Construction
  Group_Construction.Group_NotJoin.self:SetActive(false)
  local Group_Join = View.Group_Construction.Group_Join
  Group_Join.self:SetActive(true)
  DataModel.ConstructionType = DataModel.ConstructionTypeList.Enabled
  ResetGroupJoin("Group_Construction")
  Group_Join.Btn_Help.self:SetActive(true)
  Group_Join.Group_StageAll.self:SetActive(true)
  Group_Join.Group_StageAll.Group_Can.Img_RedPoint:SetActive(ServerConstructionDataModel:GetRedPointState("all", DataModel.ActivityCA.id))
  Group_Join.Group_StageOne.self:SetActive(true)
  Group_Join.Group_StageOne.Group_Can.Img_RedPoint:SetActive(ServerConstructionDataModel:GetRedPointState("one", DataModel.ActivityCA.id))
  Controller:RefreshCard("Group_Construction")
  Controller:RefreshConstructionScheduleAndSkip()
  Group_Join.Btn_Rank.self:SetActive(false)
  local isShowSkip = false
  if DataModel.ActivityCA.skipQuestLimit and DataModel.ActivityCA.skipQuestLimit > 0 then
    isShowSkip = not DataModel:QuestIsFinish(DataModel.ActivityCA.skipQuestLimit)
  end
  if DataModel.ActivityCA.activityRankList and 0 < table.count(DataModel.ActivityCA.activityRankList) then
    Group_Join.Btn_Rank.self:SetActive(true)
    isShowSkip = isShowSkip or not Controller:IsRankListTimeEnd()
    if not isShowSkip then
      Group_Join.Btn_Rank:SetLocalPosition(Vector3(575, -13, 0))
    else
      Group_Join.Btn_Rank:SetLocalPosition(Vector3(575, 472, 0))
    end
  end
  Group_Join.Btn_Level.self:SetActive(isShowSkip)
  Group_Join.Btn_Store.self:SetActive(true)
  if DataModel.ActivityCA.correspondingBuild and 0 < #DataModel.ActivityCA.correspondingBuild then
    local buildCA = PlayerData:GetFactoryData(DataModel.ActivityCA.correspondingBuild[1].id)
    local storeId = buildCA.exchangeStoreList[1].id
    local storeCA = PlayerData:GetFactoryData(storeId)
    local coinId = storeCA.currencyShow[1].id
    local coinCA = PlayerData:GetFactoryData(coinId)
    Group_Join.Btn_Store.Group_Currency.Txt_Num:SetText(PlayerData:GetGoodsById(coinId).num)
    Group_Join.Btn_Store.Group_Currency.Img_Currency:SetSprite(coinCA.buyPath)
  end
  local curNum = PlayerData:GetActivityPersonalConstructionCstNum(DataModel.ActivityCA.id)
  local personlist = DataModel.ActivityCA.personalConstructionList
  local prog
  if personlist and 0 < #personlist then
    prog = math.min(curNum / personlist[#personlist].construction, 1)
  else
    prog = 1
  end
  Group_Join.Group_OneSchedule.self:SetActive(true)
  Group_Join.Group_OneSchedule.Txt_Num:SetText(string.format(GetText(80606881), math.floor(prog * 100)))
  Group_Join.Group_OneSchedule.Img_PB:SetFilledImgAmount(prog)
end

function Controller:Open_Group_Construction(row)
  View.Group_Construction.Group_NotJoin.Img_3:SetSprite(GetResPath(88300034))
  View.Group_Construction.Group_Join.Btn_Store.Img_1:SetSprite(GetResPath(88300036))
  View.Group_Construction.Group_Join.Img_3:SetSprite(GetResPath(88300034))
  View.Group_Construction.Group_.Img_Icon:SetSprite(GetResPath(88300085))
  local Group_Construction = View.Group_Construction
  Group_Construction.Group_Join.self:SetActive(false)
  Group_Construction.Group_NotJoin.self:SetActive(false)
  DataModel.ConstructionPreviewList = {}
  Group_Construction.ScrollGrid_List.self:SetActive(false)
  if DataModel.ActivityCA.constructionPreviewList and table.count(DataModel.ActivityCA.constructionPreviewList) > 0 then
    for k, v in pairs(DataModel.ActivityCA.constructionPreviewList) do
      table.insert(DataModel.ConstructionPreviewList, v)
    end
    Group_Construction.ScrollGrid_List.self:SetActive(true)
    local cells = Group_Construction.ScrollGrid_List.grid.self.Cells
    local count = cells.Count
    for i = 0, count - 1 do
      local compent = cells[i]:GetComponent(typeof(CS.Seven.UIGridItemIndex))
      if compent == nil then
        error("UIGridItemIndex \232\132\154\230\156\172\228\184\162\228\186\134")
      end
    end
    Group_Construction.ScrollGrid_List.grid.self:SetDataCount(#DataModel.ConstructionPreviewList)
    Group_Construction.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  Group_Construction.Group_NotJoin.Group_Add.Group_Can.self:SetActive(false)
  Group_Construction.Group_NotJoin.Group_Add.Group_Quest.self:SetActive(false)
  Group_Construction.Group_NotJoin.Group_Preview.self:SetActive(false)
  if row.activeCA.isTime == false then
    Group_Construction.Group_NotJoin.self:SetActive(true)
    Group_Construction.Group_NotJoin.Group_Add.self:SetActive(true)
    if row.activeCA.rewardPreviewList and 0 < table.count(row.activeCA.rewardPreviewList) then
      DataModel.NotJoinReward = {}
      for k, v in pairs(row.activeCA.rewardPreviewList) do
        table.insert(DataModel.NotJoinReward, v)
      end
      Group_Construction.Group_NotJoin.Group_Preview.self:SetActive(true)
      Group_Construction.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(table.count(row.activeCA.rewardPreviewList))
      Group_Construction.Group_NotJoin.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
    end
    local isAdd = PlayerData:GetActivityAct(row.id)
    if isAdd == false then
      if row.activeCA.questId ~= -1 and DataModel:QuestIsFinish(row.activeCA.questId) == false then
        DataModel.ConstructionType = DataModel.ConstructionTypeList.Lock
        Group_Construction.Group_NotJoin.Group_Add.Group_Quest.self:SetActive(true)
        local questCA = PlayerData:GetFactoryData(row.activeCA.questId)
        Group_Construction.Group_NotJoin.Group_Add.Group_Quest.Txt_Quest:SetText(string.format(GetText(DataModel.ActivityCA.unlockTips), questCA.name))
        return
      end
      Group_Construction.Group_NotJoin.Group_Add.Group_Can.self:SetActive(true)
      DataModel.ConstructionType = DataModel.ConstructionTypeList.NotEnabled
      return
    end
    Controller:RefreshConstructionJoinPage()
  else
  end
end

function Controller:SetActivityCountDownData()
  local row = DataModel.LeftListNow[DataModel.ChooseLeftIndex]
  local showResidueUI = row.activeCA.showResidueUI
  local Group_Residue = View.Group_Residue[showResidueUI].Group_Residue
  local lastTime = TimeUtil:SecondToTable(row.remainingTime)
  if lastTime.day > 0 then
    Group_Residue.Group_Time.Txt_Time:SetText(string.format(GetText(80609204), lastTime.day))
  elseif 0 < lastTime.hour then
    Group_Residue.Group_Time.Txt_Time:SetText(string.format(GetText(80609205), lastTime.hour))
  else
    Group_Residue.Group_Time.Txt_Time:SetText(string.format(GetText(80609205), 1))
  end
  DataModel.NotJoinReward = {}
  for k, v in pairs(row.activeCA.rewardPreviewList) do
    table.insert(DataModel.NotJoinReward, v)
  end
  Group_Residue.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(table.count(DataModel.NotJoinReward))
  Group_Residue.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
  if showResidueUI == "Group_Monster" then
    View.Group_Residue.Group_Monster.Group_Bg.Img_Dec:SetSprite(GetResPath(88300041))
  end
end

function Controller:OpenRightPage()
  local row = DataModel.LeftListNow[DataModel.ChooseLeftIndex]
  DataModel.LeftActivityCA = row
  DataModel.ActivityCA = row.activeCA
  if row.isCountDownNow or row.isShowLvNow then
    local showResidueUI = row.activeCA.showResidueUI
    if showResidueUI ~= "" then
      DataModel.backToHome = true
      UIManager:Open(showResidueUI, Json.encode({
        activityId = row.activeCA.id
      }))
      return
    end
  end
  if DataModel.LeftActivityCA.showUI == "" or DataModel.LeftActivityCA.showUI == nil then
    UIManager:LoadSplitPrefab(View, "UI/Activity/ActivityMain", row.activeCA.showUI)
    View[row.activeCA.showUI].self:SetActive(true)
  elseif not DataModel.isGoback then
    UIManager:Open(DataModel.LeftActivityCA.showUI, Json.encode({
      activityId = row.activeCA.id,
      closeTime = row.endTime,
      index = DataModel.ChooseLeftIndex,
      isCityMapIn = DataModel.isCityMapIn
    }))
  end
  DataModel.isGoback = false
  if row.activeCA.id == 86000007 then
    DataModel.TabScrollNow.grid.self:RefreshAllElement()
  end
  if row.activeCA.showUI ~= "" then
    if row.activeCA.showUI == "Group_BlackTea" then
      Controller:Open_Group_BlackTea(row)
    end
    if row.activeCA.showUI == "Group_SignIn" then
      Controller:Open_Group_SignIn(row)
    end
    if row.activeCA.showUI == "Group_Construction" then
      Controller:Open_Group_Construction(row)
    end
    if row.activeCA.showUI == "Group_LevelReward" then
      Controller:Open_Group_LevelReward(row)
    end
    if row.activeCA.showUI == "Group_ActivitySignIn" then
      Controller:Open_Group_ActivitySignIn(row)
    end
  end
end

function Controller:RefreshLeftList(id)
  DataModel.RefreshActivityData()
  DataModel.TabScrollNow.grid.self:SetDataCount(table.count(DataModel.LeftListNow))
  DataModel.TabScrollNow.grid.self:RefreshAllElement()
  Controller:InitPageShow()
  DataModel.SetNextRefreshListTime()
  DataModel.isRefresh = false
end

function Controller:CloseOldUI()
  if DataModel.ChooseLeftIndex then
    local old_row = DataModel.LeftListNow[DataModel.ChooseLeftIndex]
    if View[old_row.activeCA.showUI] then
      View[old_row.activeCA.showUI].self:SetActive(false)
    end
    if old_row.isCountDownNow or old_row.isShowLvNow then
      if old_row.activeCA.showResidueUI ~= "" then
        UIManager:GoBack(false)
      elseif DataModel.LeftActivityCA.showUI ~= "" and DataModel.LeftActivityCA.showUI ~= nil then
        UIManager:GoBack(false)
      end
    elseif DataModel.LeftActivityCA.showUI ~= "" and DataModel.LeftActivityCA.showUI ~= nil then
      UIManager:GoBack(false)
    end
  end
end

function Controller:ClickLeftActive(index, isRefresh, isChangeTab)
  if DataModel.ChooseLeftIndex and DataModel.ChooseLeftIndex == index and isRefresh ~= true and isChangeTab ~= true then
    return
  end
  local row = DataModel.LeftListNow[index]
  if row.activeCA.mod ~= "\231\173\190\229\136\176" and row.activeCA.mod ~= "\230\180\187\229\138\168\231\173\190\229\136\176" and row.activeCA.mod ~= "\229\136\151\232\189\166\230\137\167\231\133\167" and row.activeCA.mod ~= "\229\155\158\229\189\146\230\180\187\229\138\168" and CommonTips.GuideAsset() then
    return
  end
  if isChangeTab ~= true then
    Controller:CloseOldUI()
  end
  if row.id == 86000043 then
    View.Group_ActivitySignIn.Img_BG:SetSprite(row.activeCA.bgPath)
  else
    View.Img_BackGround:SetSprite(row.activeCA.bgPath)
  end
  if PlayerData:GetPlayerPrefs("int", "ActivityCountDown" .. row.id) == 0 then
    PlayerData:SetPlayerPrefs("int", "ActivityCountDown" .. row.id, 1)
  end
  if PlayerData:GetPlayerPrefs("int", "ActivityCloseCountDown" .. row.id) == 0 then
    PlayerData:SetPlayerPrefs("int", "ActivityCloseCountDown" .. row.id, 1)
    local timeTable = TimeUtil:GetLogicServerDayTable()
    if timeTable then
      PlayerData:SetPlayerPrefs("int", "LastActivityLoginDay" .. row.id, timeTable.day)
    end
    local Btn_Main = View.ScrollView_Tab.Viewport.Content.Btn_Main
    local Btn_Plot = View.ScrollView_Tab.Viewport.Content.Btn_Plot
    Btn_Main.Img_Red:SetActive(DataModel.GetMainRed())
    Btn_Plot.Img_Red:SetActive(DataModel.GetPlotRed())
  end
  DataModel.ChooseLeftIndex = index
  DataModel.TabScrollNow.grid.self:RefreshAllElement()
  Controller:OpenRightPage()
  local sound = SoundManager:CreateSound(row.activeCA.voiceActivity)
  if sound ~= nil then
    sound:Play()
  elseif 0 >= row.activeCA.voiceActivity then
    require("UIMainUI/UIMainUIController"):PlayBGM()
  end
end

function Controller:ClickLeftActiveById(activityId)
  for i, v in ipairs(DataModel.LeftList) do
    if v.id == activityId then
      if v.tabType == "Main" then
        Controller:ClickTabBtn(DataModel.TabType.Main)
        break
      end
      if v.tabType == "Plot" then
        Controller:ClickTabBtn(DataModel.TabType.Plot)
        break
      end
      if v.tabType == "Time" then
        Controller:ClickTabBtn(DataModel.TabType.Time)
        break
      end
      if v.tabType == "Operate" then
        Controller:ClickTabBtn(DataModel.TabType.Operate)
      end
      break
    end
  end
  for i, v in ipairs(DataModel.LeftListNow) do
    if v.id == activityId then
      Controller:ClickLeftActive(i)
      DataModel.TabScrollNow.grid.self:MoveToPos(i or 1)
      return
    end
  end
  UIManager:GoHome()
end

function Controller:Open_Group_LevelReward(row)
  DataModel.levelStageIndex = 1
  DataModel.middleTransIndex = 1
  DataModel.rankReward = {}
  for i, v in pairs(PlayerData:GetHomeInfo().rank_reward) do
    DataModel.rankReward[v] = 1
  end
  DataModel.levelTemplate = {
    View.Group_LevelReward.Group_Template.Group_LevelReward1,
    View.Group_LevelReward.Group_Template.Group_LevelReward2,
    View.Group_LevelReward.Group_Template.Group_LevelReward3,
    View.Group_LevelReward.Group_Template.Group_LevelReward4,
    View.Group_LevelReward.Group_Template.Group_LevelReward5,
    View.Group_LevelReward.Group_Template.Group_LevelReward6,
    View.Group_LevelReward.Group_Template.Group_LevelReward7,
    View.Group_LevelReward.Group_Template.Group_LevelReward8,
    View.Group_LevelReward.Group_Template.Group_LevelReward9
  }
  DataModel.levelTrans = {
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.Group_Pivot1.Group_LevelRewardCard,
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.Group_Pivot2.Group_LevelRewardCard,
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.Group_Pivot3.Group_LevelRewardCard,
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.Group_Pivot4.Group_LevelRewardCard,
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.Group_Pivot5.Group_LevelRewardCard,
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.Group_Pivot6.Group_LevelRewardCard
  }
  for i, v in ipairs(DataModel.levelTrans) do
    v:SetEnableAnimator(false)
    local pos = v.Group_LevelReward.transform.localPosition
    v.Group_LevelReward.transform.localPosition = Vector3(pos.x, 0, pos.y)
    pos = v.Group_LevelReward_Back.transform.localPosition
    v.Group_LevelReward_Back.transform.localPosition = Vector3(pos.x, 0, pos.z)
    v.Group_LevelReward.Group_UnLock.gameObject:SetActive(false)
    v.Group_LevelReward.Group_Lock.gameObject:SetActive(false)
    v.Group_LevelReward.Group_Drawing.gameObject:SetActive(false)
    v.Group_LevelReward.Group_Select.gameObject:SetActive(false)
  end
  local canvasGroup = View.Group_LevelReward.Group_LevelReward_New.self:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  canvasGroup.alpha = 1
  View.Group_LevelReward.Group_Effect.Group_In.transform.localRotation = Quaternion.Euler(0, 0, 0)
  local stageIndex = 1
  local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
  for i, v in ipairs(cfg.Playerranklist) do
    if v.level > PlayerData:GetUserInfo().lv then
      stageIndex = i - 1
      break
    elseif v.level == PlayerData:GetUserInfo().lv then
      stageIndex = i
      break
    end
  end
  Controller.RefreshLevelReward(stageIndex)
  Controller.RefreshLevelTransOnShow(1, stageIndex)
  View.Group_LevelReward.Drag_LevelReward:SetActive(false)
  View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot:SetEnableAnimator(true)
  View.self:SelectPlayAnim(View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot.self, "Effect_levelRaward_6", function()
    View.Group_LevelReward.Group_Effect.Group_In.Group_Pivot:SetEnableAnimator(false)
    Controller.RefreshLevelRewardSelect(1)
    View.Group_LevelReward.Drag_LevelReward:SetActive(true)
  end)
  View.self:SelectPlayAnim(View.Group_LevelReward.self, "LevelReward_in", function()
    View.Group_LevelReward:SetEnableAnimator(false)
  end)
  local sound = SoundManager:CreateSound(30002625)
  if sound then
    sound:Play()
  end
  if DataModel.levelRewardEndCoroutine then
    View.self:StopC(DataModel.levelRewardEndCoroutine)
    DataModel.levelRewardEndCoroutine = nil
  end
end

function Controller.RefreshLevelTransOnShow(transIndex, stageIndex)
  DataModel.firstInit = true
  Controller.RefreshLevelTrans(transIndex, stageIndex)
  Controller.RefreshLevelTrans(transIndex + 1, stageIndex + 1)
  Controller.RefreshLevelTrans(transIndex - 1, stageIndex - 1)
  Controller.RefreshLevelTrans(transIndex + 2, stageIndex + 2)
  Controller.RefreshLevelTrans(transIndex - 2, stageIndex - 2)
  DataModel.firstInit = false
end

function Controller.RefreshLevelTrans(transIndex, stageIndex)
  if transIndex < 1 then
    transIndex = #DataModel.levelTrans + transIndex
  end
  if transIndex > #DataModel.levelTrans then
    transIndex = transIndex - #DataModel.levelTrans
  end
  if stageIndex < 1 then
    stageIndex = #DataModel.levelTemplate + stageIndex
  end
  if stageIndex > #DataModel.levelTemplate then
    stageIndex = stageIndex - #DataModel.levelTemplate
  end
  local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
  local info = cfg.Playerranklist and cfg.Playerranklist[stageIndex]
  if info then
    local trans = DataModel.levelTrans[transIndex]
    trans:SetEnableAnimator(false)
    local pos = trans.Group_LevelReward.transform.localPosition
    trans.Group_LevelReward.transform.localPosition = Vector3(pos.x, 0, pos.y)
    pos = trans.Group_LevelReward_Back.transform.localPosition
    trans.Group_LevelReward_Back.transform.localPosition = Vector3(pos.x, 0, pos.z)
    local showLock = PlayerData:GetUserInfo().lv < info.level
    trans.Group_LevelReward.Group_UnLock.gameObject:SetActive(not showLock and DataModel.rankReward[info.level])
    if DataModel.firstInit then
      View.self:SelectPlayAnim(trans.Group_LevelReward.Group_UnLock.self, "LevelReward_UnLock", function()
        trans.Group_LevelReward.Group_UnLock:SetEnableAnimator(false)
      end)
    else
      trans.Group_LevelReward.Group_UnLock:SetEnableAnimator(false)
    end
    trans.Group_LevelReward.Group_Lock.gameObject:SetActive(showLock)
    local lockAnimator = trans.Group_LevelReward.Group_Lock.gameObject:GetComponent(typeof(CS.UnityEngine.Animator))
    lockAnimator:Play(DataModel.firstInit and "LevelReward_Lock" or "LevelReward_Lock_Loop")
    trans.Group_LevelReward.Group_Drawing.gameObject:SetActive(not showLock and not DataModel.rankReward[info.level])
    local canReceiveAnimator = trans.Group_LevelReward.Group_Drawing.gameObject:GetComponent(typeof(CS.UnityEngine.Animator))
    canReceiveAnimator:Play(DataModel.firstInit and "LevelReward_Drawing_FirstTime" or "LevelReward_Drawing_Loop")
    trans.Group_LevelReward.Group_Select.gameObject:SetActive(false)
    local templateTrans = DataModel.levelTemplate[stageIndex]
    local material = templateTrans.transform:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material
    trans.Group_LevelReward.transform:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material = material
  end
end

function Controller.RefreshLevelRewardSelect(transIndex)
  local oldTrans = DataModel.levelTrans[DataModel.middleTransIndex]
  if oldTrans then
    oldTrans:SetEnableAnimator(false)
    local pos = oldTrans.Group_LevelReward.transform.localPosition
    oldTrans.Group_LevelReward.transform.localPosition = Vector3(pos.x, 0, pos.z)
    pos = oldTrans.Group_LevelReward_Back.transform.localPosition
    oldTrans.Group_LevelReward_Back.transform.localPosition = Vector3(pos.x, 0, pos.z)
    oldTrans.Group_LevelReward.Group_Select.gameObject:SetActive(false)
  end
  local newTrans = DataModel.levelTrans[transIndex]
  if newTrans then
    newTrans.Group_LevelReward.Group_Select:SetActive(true)
    newTrans.Group_LevelReward.Group_Select:SelectPlayAnim("LevelReward_Select")
    newTrans:SetEnableAnimator(true)
    local animator = newTrans.transform.gameObject:GetComponent(typeof(CS.UnityEngine.Animator))
    animator:Play("LevelReward_Float", 0, 0)
  end
  DataModel.middleTransIndex = transIndex
end

function Controller.RefreshLevelReward(stageIndex)
  DataModel.levelStageIndex = stageIndex
  local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
  local info = cfg.Playerranklist and cfg.Playerranklist[stageIndex]
  if info then
    View.Group_LevelReward.Group_LevelReward_New.Group_Level.Group_Text.Txt_Num:SetText(info.level)
    local levelCfg = PlayerData:GetFactoryData(info.id, "ListFactory")
    local showReward = table.count(levelCfg.reward) > 0
    local showLockRight = 0 < table.count(levelCfg.Unlockright)
    View.Group_LevelReward.Group_LevelReward_New.Group_Level.Group_Text.Txt_Name:SetText(levelCfg.Rankname)
    View.Group_LevelReward.Group_LevelReward_New.Group_Level.Img_:SetSprite(levelCfg.icon)
    local userLv = PlayerData:GetUserInfo().lv
    View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Claim.Group_ButtonNotClaimed:SetActive(showReward and userLv < info.level)
    View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Claim.Group_ButtonClaimed:SetActive(showReward and DataModel.rankReward[info.level])
    View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Claim.Btn_Claimed:SetActive(showReward and userLv >= info.level and not DataModel.rankReward[info.level])
    View.Group_LevelReward.Group_LevelReward_New.Group_Layout.StaticGrid_Item.grid.self:SetActive(showLockRight)
    if showLockRight then
      View.Group_LevelReward.Group_LevelReward_New.Group_Layout.StaticGrid_Item.grid.self:SetDataCount(table.count(levelCfg.Unlockright))
      View.Group_LevelReward.Group_LevelReward_New.Group_Layout.StaticGrid_Item.grid.self:RefreshAllElement()
    end
    View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Rewards.ScrollGrid_Reward.grid.self:SetActive(showReward)
    if showReward then
      View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Rewards.ScrollGrid_Reward.grid.self:SetDataCount(table.count(levelCfg.reward))
      View.Group_LevelReward.Group_LevelReward_New.Group_Layout.Group_Rewards.ScrollGrid_Reward.grid.self:RefreshAllElement()
    end
  end
end

function Controller:OpenRankList()
  local t = {}
  t.rankList = DataModel.ActivityCA.activityRankList
  UIManager:Open("UI/RankList/RankList", Json.encode(t))
end

function Controller:IsRankListTimeEnd()
  local rankListId = DataModel.ActivityCA.activityRankList[1].id
  local rankListCA = PlayerData:GetFactoryData(rankListId)
  if rankListCA.statisticsEndTime and rankListCA.statisticsEndTime ~= nil then
    return TimeUtil:GetServerTimeStamp() >= TimeUtil:TimeStamp(rankListCA.statisticsEndTime)
  else
    return false
  end
end

function Controller:Open_Group_ActivitySignIn(row)
  local Group_ActivitySignIn = View.Group_ActivitySignIn
  local activeCA = row.activeCA
  Group_ActivitySignIn.Group_Img:SetActive(activeCA.signTitleImg and activeCA.signTitleImg ~= "")
  Group_ActivitySignIn.Group_Img.Img_Time.Img_:SetActive(activeCA.timeLineBG and activeCA.timeLineBG ~= "")
  Group_ActivitySignIn.Group_Img.Img_Time.Img_:SetSprite(activeCA.timeLineBG)
  Group_ActivitySignIn.Group_Img.Img_Time.Img_:SetNativeSize()
  Group_ActivitySignIn.Group_Img.Img_Time.Txt_Time:SetColor("#" .. activeCA.timeColor)
  Group_ActivitySignIn.Group_Img.Img_Time.Img_TimeIcon:SetColor("#" .. activeCA.timeColor)
  Group_ActivitySignIn.Img_BG:SetSprite(activeCA.bgPath)
  if activeCA.signTitleImg and activeCA.signTitleImg ~= "" then
    Group_ActivitySignIn.Group_Title:SetActive(false)
    Group_ActivitySignIn.Group_Img.Img_Title:SetSprite(activeCA.signTitleImg)
    Group_ActivitySignIn.Group_Img.Img_Title:SetNativeSize()
    Group_ActivitySignIn.Group_Img.Img_Title:SetAnchoredPosition(Vector2(activeCA.ImgX, activeCA.ImgY))
    local startTime = TimeUtil:GetTimeTable(activeCA.startTime)
    local endTime = TimeUtil:GetTimeTable(activeCA.endTime)
    local str = string.format(GetText(80600005), startTime.year, startTime.month, startTime.day, startTime.hour .. ":" .. startTime.minute, endTime.year, endTime.month, endTime.day, endTime.hour .. ":" .. endTime.minute)
    Group_ActivitySignIn.Group_Img.Img_Time.Txt_Time:SetText(str)
    Group_ActivitySignIn.Group_Img.Img_Time:SetColor("#" .. activeCA.timeLineColor)
    Group_ActivitySignIn.Group_Img.Img_Time:SetAnchoredPosition(Vector2(activeCA.timeImgX, activeCA.timeImgY))
  elseif activeCA.isNew then
    Group_ActivitySignIn.Group_Title:SetActive(false)
    Group_ActivitySignIn.Group_RightTitle:SetActive(false)
    Group_ActivitySignIn.Group_LeftTitle:SetActive(false)
    local setType = activeCA.setType
    if setType == "0" then
      Group_ActivitySignIn.Group_LeftTitle:SetActive(true)
      local ctr = Group_ActivitySignIn.Group_LeftTitle
      ctr.Group_Text.Txt_Title:SetText(activeCA.name)
      ctr.Group_Text.Txt_Title:SetColor(activeCA.titleColor)
      ctr.Group_Text.Img_Icon:SetActive(activeCA.signIcon ~= "")
      ctr.Group_Text.Img_Icon:SetSprite(activeCA.signIcon)
      ctr.Group_Text.Group_SmallText.Txt_AboveC:SetActive(activeCA.signTitleAboveC and activeCA.signTitleAboveC > 0)
      ctr.Group_Text.Group_SmallText.Txt_AboveC:SetText(GetText(activeCA.signTitleAboveC))
      ctr.Group_Text.Group_SmallText.Txt_BottomC:SetActive(activeCA.signTitleBottomC and 0 < activeCA.signTitleBottomC)
      ctr.Group_Text.Group_SmallText.Txt_BottomC:SetText(GetText(activeCA.signTitleBottomC))
      ctr.Group_Text.Group_SmallText.Txt_AboveE:SetActive(activeCA.signTitleAboveE and 0 < activeCA.signTitleAboveE)
      ctr.Group_Text.Group_SmallText.Txt_AboveE:SetText(GetText(activeCA.signTitleAboveE))
      ctr.Group_Text.Group_SmallText.Txt_BottomE:SetActive(activeCA.signTitleBottomE and 0 < activeCA.signTitleBottomE)
      ctr.Group_Text.Group_SmallText.Txt_BottomE:SetText(GetText(activeCA.signTitleBottomE))
      local startTime = TimeUtil:GetTimeTable(activeCA.startTime)
      local endTime = TimeUtil:GetTimeTable(activeCA.endTime)
      local str = string.format(GetText(80600005), startTime.year, startTime.month, startTime.day, startTime.hour .. ":" .. startTime.minute, endTime.year, endTime.month, endTime.day, endTime.hour .. ":" .. endTime.minute)
      ctr.Group_Text.Txt_Title.Img_Time.Txt_Time:SetText(str)
      ctr.Group_Text.Txt_Title.Img_Time:SetColor("#" .. activeCA.timeLineColor)
    elseif setType == "1" then
      Group_ActivitySignIn.Group_RightTitle:SetActive(true)
      local ctr = Group_ActivitySignIn.Group_RightTitle
      ctr.Group_Text.Txt_Title:SetText(activeCA.name)
      ctr.Group_Text.Txt_Title:SetColor(activeCA.titleColor)
      ctr.Group_Text.Img_Icon:SetActive(activeCA.signIcon ~= "")
      ctr.Group_Text.Img_Icon:SetSprite(activeCA.signIcon)
      ctr.Group_Text.Group_SmallText.Txt_AboveC:SetActive(activeCA.signTitleAboveC and activeCA.signTitleAboveC > 0)
      ctr.Group_Text.Group_SmallText.Txt_AboveC:SetText(GetText(activeCA.signTitleAboveC))
      ctr.Group_Text.Group_SmallText.Txt_BottomC:SetActive(activeCA.signTitleBottomC and 0 < activeCA.signTitleBottomC)
      ctr.Group_Text.Group_SmallText.Txt_BottomC:SetText(GetText(activeCA.signTitleBottomC))
      ctr.Group_Text.Group_SmallText.Txt_AboveE:SetActive(activeCA.signTitleAboveE and 0 < activeCA.signTitleAboveE)
      ctr.Group_Text.Group_SmallText.Txt_AboveE:SetText(GetText(activeCA.signTitleAboveE))
      ctr.Group_Text.Group_SmallText.Txt_BottomE:SetActive(activeCA.signTitleBottomE and 0 < activeCA.signTitleBottomE)
      ctr.Group_Text.Group_SmallText.Txt_BottomE:SetText(GetText(activeCA.signTitleBottomE))
      local startTime = TimeUtil:GetTimeTable(activeCA.startTime)
      local endTime = TimeUtil:GetTimeTable(activeCA.endTime)
      local str = string.format(GetText(80600005), startTime.year, startTime.month, startTime.day, startTime.hour .. ":" .. startTime.minute, endTime.year, endTime.month, endTime.day, endTime.hour .. ":" .. endTime.minute)
      ctr.Img_Time.Txt_Time:SetText(str)
      ctr.Img_Time:SetColor("#" .. activeCA.timeLineColor)
    end
  else
    Group_ActivitySignIn.Group_Title:SetActive(true)
    Group_ActivitySignIn.Group_RightTitle:SetActive(false)
    Group_ActivitySignIn.Group_LeftTitle:SetActive(false)
    Group_ActivitySignIn.Group_Title.Txt_Title:SetText(activeCA.name)
    Group_ActivitySignIn.Group_Title.Txt_Title.Img_Icon:SetActive(activeCA.signIcon ~= "")
    Group_ActivitySignIn.Group_Title.Txt_Title.Img_Icon:SetSprite(activeCA.signIcon)
    Group_ActivitySignIn.Group_Title.Txt_Title:SetColor(activeCA.titleColor)
    Group_ActivitySignIn.Group_Title.Txt_Title.Img_Icon:SetColor(activeCA.titleColor)
    Group_ActivitySignIn.Group_Title.Img_Title:SetSprite(GetResPath(88300087))
    Group_ActivitySignIn.Group_Title.Img_Title:SetColor(activeCA.titleColor)
    local startTime = TimeUtil:GetTimeTable(activeCA.startTime)
    local endTime = TimeUtil:GetTimeTable(activeCA.endTime)
    local str = string.format(GetText(80600005), startTime.year, startTime.month, startTime.day, startTime.hour .. ":" .. startTime.minute, endTime.year, endTime.month, endTime.day, endTime.hour .. ":" .. endTime.minute)
    Group_ActivitySignIn.Group_Title.Img_Time.Txt_Time:SetText(str)
    Group_ActivitySignIn.Group_Title.Img_Time:SetColor("#" .. activeCA.timeLineColor)
  end
  local sign_ca = PlayerData:GetFactoryData(activeCA.signinId)
  DataModel.ActivitySignInCA = sign_ca
  DataModel.ActivitySignInStateList = {}
  if sign_ca then
    DataModel.RefreshSignInStateList()
    DataModel.SetNextRefreshListTime()
    Group_ActivitySignIn.Group_Main.ScrollGrid_Main.grid.self:SetDataCount(table.count(sign_ca.SigninRewardList))
    Group_ActivitySignIn.Group_Main.ScrollGrid_Main.grid.self:RefreshAllElement()
  end
  if activeCA.isSkip then
    View.Group_ActivitySignIn.Group_jump:SetActive(true)
    local btnList = activeCA.btnList
    if btnList and btnList[1] then
      local exId = btnList[1].id
      local x = btnList[1].x
      local y = btnList[1].y
      if x then
        View.Group_ActivitySignIn.Group_jump.self:SetLocalPositionX(x)
      end
      if y then
        View.Group_ActivitySignIn.Group_jump.self:SetLocalPositionY(y)
      end
      if exId then
        View.Group_ActivitySignIn.Group_jump.Btn_Card:SetClickFunction(function()
          local t = {}
          t.poolId = exId
          UIManager:Open("UI/Gacha/GachaNew", Json.encode(t))
        end)
        do
          local exCa = PlayerData:GetFactoryData(exId, "ExtractFactory")
          if exCa and exCa.btnList then
            local btnInfo = exCa.btnList[1]
            if btnInfo then
              do
                local unitCa = PlayerData:GetFactoryData(btnInfo.id, "UnitFactory")
                if unitCa then
                  View.Group_ActivitySignIn.Group_jump.Txt_role:SetText(unitCa.name)
                  View.Group_ActivitySignIn.Group_jump.Btn_detail:SetClickFunction(function()
                    CommonTips.OpenUnitDetail({
                      id = btnInfo.id,
                      isGoback = true
                    })
                  end)
                end
              end
            end
          end
        end
      end
    end
  else
    View.Group_ActivitySignIn.Group_jump:SetActive(false)
  end
end

function Controller:SetActivitySignInElement(element, elementIndex)
  local row = DataModel.ActivitySignInCA.SigninRewardList[elementIndex]
  element.Img_Mask:SetSprite(DataModel.ActivityCA.signMask)
  element.Img_BG.Txt_Day:SetText(tostring(elementIndex))
  element.Img_BG.Txt_Day:SetAlignment(DataModel.ActivityCA.dayAligningType or 4)
  element.Img_BG.Group_Reward.Group_Icon:SetActive(DataModel.ActivityCA.isIconOpen)
  element.Img_BG.Btn_Bottom.Group_Bottom:SetActive(DataModel.ActivityCA.isBtnContentOpen)
  element.Img_BG.Txt_Day:SetAnchoredPositionY(DataModel.ActivityCA.dayTxtY)
  element.Img_BG.Txt_Day:SetTxtFontSize(DataModel.ActivityCA.dayTxtSize)
  element.Img_BG.Btn_Bottom:SetAnchoredPositionY(DataModel.ActivityCA.btnBottomY)
  element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetTxtFontSize(DataModel.ActivityCA.btnBottomTxtSize)
  local signInStateType = DataModel.ActivitySignInStateList[elementIndex] or DataModel.ActivitySignInStateType.NotInTime
  if signInStateType == DataModel.ActivitySignInStateType.NotInTime then
    element.Img_BG.Txt_Day:SetColor("#" .. DataModel.ActivityCA.unSignInColor or "FFFFFF")
    element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetColor("#" .. DataModel.ActivityCA.unSignInColor or "FFFFFF")
    element.Img_BG:SetSprite(DataModel.ActivityCA.signBG)
    element.Img_BG.Group_Reward.Group_Icon.Img_Icon:SetSprite(DataModel.ActivityCA.unClaimedIcon)
    element.Img_BG.Btn_Bottom:SetSprite(DataModel.ActivityCA.notTimeBottom)
    element.Img_BG.Btn_Bottom.Group_Bottom.Img_BottomIcon:SetSprite(DataModel.ActivityCA.notTimeBtn)
    element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetText(GetText(80608947))
    element.Img_Mask:SetActive(false)
  elseif signInStateType == DataModel.ActivitySignInStateType.CanSign then
    if DataModel.ActivityCA.signIconImg and DataModel.ActivityCA.signIconImg ~= "" then
      element.Img_BG.Group_Reward.Group_Icon.Img_Icon:SetSprite(DataModel.ActivityCA.signIconImg)
    else
      element.Img_BG.Group_Reward.Group_Icon.Img_Icon:SetSprite(DataModel.ActivityCA.unClaimedIcon)
    end
    if DataModel.ActivityCA.signBgImg and DataModel.ActivityCA.signBgImg ~= "" then
      element.Img_BG:SetSprite(DataModel.ActivityCA.signBgImg)
    else
      element.Img_BG:SetSprite(DataModel.ActivityCA.signBG)
    end
    element.Img_BG.Txt_Day:SetColor("#" .. DataModel.ActivityCA.signColor or "FFFFFF")
    element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetColor("#" .. DataModel.ActivityCA.signColor or "FFFFFF")
    element.Img_BG.Btn_Bottom:SetSprite(DataModel.ActivityCA.signBottom)
    element.Img_BG.Btn_Bottom.Group_Bottom.Img_BottomIcon:SetSprite(DataModel.ActivityCA.signBtn)
    element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetText(GetText(80608946))
    element.Img_Mask:SetActive(false)
  elseif signInStateType == DataModel.ActivitySignInStateType.Signed then
    element.Img_BG.Txt_Day:SetColor("#" .. DataModel.ActivityCA.signedColor or "FFFFFF")
    element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetColor("#" .. DataModel.ActivityCA.signedColor or "FFFFFF")
    element.Img_BG:SetSprite(DataModel.ActivityCA.signedBG)
    element.Img_BG.Group_Reward.Group_Icon.Img_Icon:SetSprite(DataModel.ActivityCA.claimedIcon)
    element.Img_BG.Btn_Bottom:SetSprite(DataModel.ActivityCA.signedBottom)
    element.Img_BG.Btn_Bottom.Group_Bottom.Img_BottomIcon:SetSprite(DataModel.ActivityCA.signedBtn)
    element.Img_BG.Btn_Bottom.Group_Bottom.Txt_Sign:SetText(GetText(80608948))
    element.Img_Mask:SetActive(DataModel.ActivityCA.signMask ~= "")
  end
  element.Img_BG.Btn_Bottom.Group_Bottom.Img_BottomIcon:SetActive(DataModel.ActivityCA.isBtnIcon)
  LayoutRebuilder.ForceRebuildLayoutImmediate(element.Img_BG.Group_Reward.Rect)
  local reward_caId = row.id
  local reward_ca = PlayerData:GetFactoryData(reward_caId)
  local rewardList = reward_ca.awardList
  DataModel.ActivitySignInRewardCA = rewardList
  DataModel.ActivitySignInDayIndex = elementIndex
  element.Img_BG.Group_Reward.StaticGrid_Reward.grid.self:SetDataCount(table.count(rewardList))
  element.Img_BG.Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
end

function Controller:SetActivitySignInRewardItemElement(element, elementIndex)
  local row = DataModel.ActivitySignInRewardCA[elementIndex]
  CommonItem:SetItem(element, {
    id = row.id,
    num = row.num
  }, EnumDefine.ItemType.Item)
  local signInStateType = DataModel.ActivitySignInStateList[DataModel.ActivitySignInDayIndex]
  local bgPath = "UI/Activity/ActivitySignIn/NewYear2025/ItemBG"
  if signInStateType == DataModel.ActivitySignInStateType.CanSign and DataModel.ActivityCA.rewardSBG ~= "" then
    bgPath = DataModel.ActivityCA.rewardSBG
  elseif signInStateType == DataModel.ActivitySignInStateType.NotInTime and DataModel.ActivityCA.rewardNotBG ~= "" then
    bgPath = DataModel.ActivityCA.rewardNotBG
  elseif signInStateType == DataModel.ActivitySignInStateType.Signed and DataModel.ActivityCA.rewardBG ~= "" then
    bgPath = DataModel.ActivityCA.rewardBG
  end
  element.Img_BG:SetSprite(bgPath)
end

function Controller:ActivitySignInClickElement(str)
  local elementIndex = tonumber(str)
  local serverData = PlayerData:GetSignInfo()[tostring(DataModel.ActivityCA.signinId)]
  if not serverData then
    return
  end
  local isJoined = serverData.need + serverData.count > 0
  if not isJoined and TimeUtil:IsActive(DataModel.ActivityCA.endTime, DataModel.ActivityCA.rewardEndTime) then
    CommonTips.OpenTips(80600175)
    return
  end
  if 0 < DataModel.ActivityCA.questId and not self:QuestIsFinish(DataModel.ActivityCA.questId) then
    if 0 < DataModel.ActivityCA.unlockTips then
      local questName = PlayerData:GetFactoryData(DataModel.ActivityCA.questId).name
      CommonTips.OpenTips(string.format(GetText(DataModel.ActivityCA.unlockTips), questName))
    else
      CommonTips.OpenTips(80602587)
    end
    return
  end
  if DataModel.ActivitySignInStateList[elementIndex] == DataModel.ActivitySignInStateType.NotInTime then
    CommonTips.OpenTips(80606906)
  elseif DataModel.ActivitySignInStateList[elementIndex] == DataModel.ActivitySignInStateType.CanSign then
    local activityId = DataModel.ActivityCA.id
    if not activityId then
      return
    end
    if serverData.need > 0 then
      Net:SendProto("main.sign_in", function(json)
        SdkReporter.TrackSignReward({
          id = DataModel.ActivityCA.signinId,
          day = serverData.count + serverData.need
        })
        if json.reward.role then
          for k, v in pairs(json.reward.role) do
            local ca = PlayerData:GetFactoryData(k)
            local hero_list = {}
            hero_list.hero_id = ca.id
            hero_list.hero_name = ca.name
            hero_list.event_seq = "main.sign_in"
            hero_list.get_times = PlayerData:GetSeverTime()
            ReportTrackEvent.hero_get(hero_list)
          end
        end
        DataModel.RefreshSignInStateList()
        View.Group_ActivitySignIn.Group_Main.ScrollGrid_Main.grid.self:RefreshAllElement()
        CommonTips.OpenShowItem(json.reward)
        PlayerData.ServerData.sign_info = json.user_info.sign_info
        Controller:RefreshLeftRedState()
      end, activityId)
    end
  elseif DataModel.ActivitySignInStateList[elementIndex] == DataModel.ActivitySignInStateType.Signed then
    CommonTips.OpenTips(80606907)
  end
end

function Controller:OpenExchangePanel(exchangeId)
  local buildingCA = PlayerData:GetFactoryData(exchangeId, "BuildingFactory")
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
      buildingId = exchangeId,
      isCityMapIn = false,
      name = buildingCA.name,
      initMode = "Exchange"
    }))
    PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
  end, storeId)
end

return Controller
