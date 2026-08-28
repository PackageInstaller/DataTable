local View = require("UICityMap/UICityMapView")
local DataModel = require("UICityMap/UICityMapDataModel")
local HomeCommon = require("Common/HomeCommon")
local Controller = {}

local function OpenCityMapDo(info)
  DataModel.cityMapId = info.mId
  Controller:Init()
  View.self:PlayAnim("In")
end

local function guideDo(info)
  GuideManager:ExecuteClientOnlyGuide(info.mId)
end

local function OpenPlaygroundDo(info)
  local t = {}
  t.playgroundId = info.mId
  t.stationId = DataModel.stationId
  t.backSceneName = MainManager.bgSceneName
  t.backUI = "UI/CityMap/CityMap"
  t.backParams = {
    stationId = DataModel.initParams.stationId
  }
  PlayerData.OpenToPlayground(t)
end

local function CheckQuestingDisplay(mId)
  local checkShow = PlayerData:IsHaveQuest(mId)
  checkShow = checkShow and QuestProcess.CheckQuestTime(mId)
  checkShow = checkShow and QuestProcess.CheckQuestPreConditionComplete(mId)
  local questCfg = PlayerData:GetFactoryData(mId)
  if questCfg.parentQuest > 0 then
    local parentQuestCfg = PlayerData:GetFactoryData(questCfg.parentQuest)
    if parentQuestCfg.isAnecdote then
      local branchQuest = PlayerData.ServerData.quests.branch_quests
      local info = branchQuest[tostring(questCfg.parentQuest)]
      if info and info.unlock == 0 and info.recv == 0 then
        return false
      end
    end
  end
  if questCfg.isAnecdote then
    local branchQuest = PlayerData.ServerData.quests.branch_quests
    local info = branchQuest[tostring(mId)]
    if info and info.unlock == 0 and info.recv == 0 then
      return false
    end
  end
  return checkShow
end

local function CheckNoQuestingDisplay(mid)
  return not CheckQuestingDisplay(mid)
end

local function CheckQuestCompleteDisplay(mId)
  return PlayerData.IsQuestComplete(mId)
end

local function CheckQuestIncompleteDisplay(mId)
  return not PlayerData.IsQuestComplete(mId)
end

local function CheckDevDisplay(val)
  local curStationDevData = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.stationId)]
  return val <= curStationDevData
end

local function CheckLvDisplay(val)
  return val <= PlayerData:GetPlayerLevel()
end

local function CheckStationUnlockDisplay(mId)
  local homeCommon = require("Common/HomeCommon")
  return homeCommon.CheckStationUnlock(mId)
end

local function CheckRepLvLock(val)
  local stationId = DataModel.stationId
  local stationCA = PlayerData:GetFactoryData(stationId)
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  if val > curLv then
    return true
  end
  return false
end

local function CheckPlayerLvLock(val)
  return val > PlayerData:GetPlayerLevel()
end

local function CheckItemLock(mId)
  return PlayerData:GetGoodsById(mId).num > 0
end

local function CheckQuestLock(questId)
  local questState = PlayerData.GetQuestState(questId)
  return questState == EnumDefine.EQuestState.Lock or questState == EnumDefine.EQuestState.UnFinish
end

local function InitShowConstruct(stationCA)
  DataModel.ConstructMaxNum = 0
  DataModel.ConstructNowNum = 0
  DataModel.ConstructNowCA = {}
  local StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.stationId)]
  DataModel.StationState = StationList.state
  for k, v in pairs(StationList.construction) do
    DataModel.ConstructNowNum = DataModel.ConstructNowNum + v.proportion
  end
  local construction_count = 0
  for i = 1, #stationCA.constructStageList do
    local row = stationCA.constructStageList[i]
    DataModel.ConstructMaxNum = DataModel.ConstructMaxNum + row.constructNum
    DataModel.ConstructNowCA = row
    construction_count = i
    if row.state and row.state ~= -1 and DataModel.ConstructNowNum >= DataModel.ConstructMaxNum and DataModel.StationState < row.state then
      DataModel.StationState = row.state
      PlayerData:GetHomeInfo().stations[tostring(DataModel.stationId)].state = row.state
    end
    if DataModel.ConstructNowNum < DataModel.ConstructMaxNum then
      break
    end
  end
  DataModel.Index_Construct = construction_count
  local row_server = StationList.construction[construction_count]
  local Group_Construct = View.Group_Construct
  Group_Construct.Txt_Num:SetText(row_server.proportion .. "/" .. DataModel.ConstructNowCA.constructNum)
  Group_Construct.Txt_Dec:SetText(DataModel.ConstructNowCA.name)
  Group_Construct.Img_PB:SetFilledImgAmount(row_server.proportion / DataModel.ConstructNowCA.constructNum)
  Group_Construct.Btn_Construct:SetSprite(stationCA.constructIconPath)
  Group_Construct.Img_RedPoint:SetActive(PlayerData:GetConstructStageRewardState(DataModel.stationId))
end

local function RefreshMissIonRed()
  View.Group_TopRight.Btn_Mission.Img_Remind:SetActive(false)
  if PlayerData:GetAllBattlePassRedState() then
    View.Group_TopRight.Btn_Mission.Img_Remind:SetActive(true)
  end
end

function Controller:Init()
  if CommonTips.IsResEN() then
    View.Group_City.Img_Danger.Txt_DL_En:SetText("DEVELOPMENT")
  end
  HomeCommon.DailyCheckBarStoreShopRedPoint()
  DataModel.devNum = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.stationId)].dev_degree or 0
  local stationCA = PlayerData:GetFactoryData(DataModel.stationId, "HomeStationFactory")
  local cityMapId = DataModel.GetCurCityMapId()
  local listCA = PlayerData:GetFactoryData(cityMapId, "CityMapFactory")
  View.ScrollView_Map.Viewport.Group_BG.self:SetAnchoredPosition(Vector2(listCA.offsetX, listCA.offsetY))
  View.Group_City.Img_City.Txt_Name:SetText(stationCA.name)
  View.Group_City.Img_City.Txt_NameEN:SetText(stationCA.nameEN)
  View.Group_City.Img_City:SetSprite(stationCA.cityMapIconPath)
  local dangerInfo = PlayerData:GetFactoryData(99900076, "ConfigFactory").dangerList[stationCA.dangerLevel]
  View.Group_City.Img_Danger:SetSprite(dangerInfo.cityDanger)
  View.Group_City.Img_Danger.Txt_Num:SetText(stationCA.dangerLevel)
  View.Group_City.Img_Danger.Txt_DNum:SetText(string.format("%.0f", DataModel.devNum))
  View.Group_City.Img_Danger.Txt_DL:SetText(dangerInfo.dangerText)
  local forceName = ""
  if listCA.isShowRep and 0 < stationCA.force then
    local tagCA = PlayerData:GetFactoryData(stationCA.force, "TagFactory")
    forceName = string.format(GetText(80601533), tagCA.tagName)
  end
  View.Group_City.Img_City.Txt_Force:SetActive(forceName ~= "")
  View.Group_City.Img_City.Txt_Force:SetText(forceName)
  Controller:SetBgInfo(listCA.bgList)
  local count = View.ScrollView_Map.Viewport.Group_BG.transform.childCount
  local npcCount = #listCA.bubbleList
  DataModel.showCount = npcCount
  View.Group_Construct.self:SetActive(listCA.isShowConstruct)
  if listCA.isShowConstruct then
    InitShowConstruct(stationCA)
  end
  DataModel.curShowBubbleList = {}
  local elementIdx = 1
  for i = 1, npcCount do
    local element = View.ScrollView_Map.Viewport.Group_BG["Group_Build" .. elementIdx]
    if element ~= nil then
      local checkShow = true
      local info = listCA.bubbleList[i]
      local bubbleCA = PlayerData:GetFactoryData(info.id)
      if bubbleCA ~= nil then
        checkShow = checkShow and QuestProcess.CheckTime(bubbleCA.activityId, bubbleCA.startTime, bubbleCA.endTime)
        if checkShow then
          for i, v in ipairs(bubbleCA.displayConditionsList) do
            local isDisplay = true
            if v.condition == "Questing" then
              isDisplay = CheckQuestingDisplay(v.mId)
            elseif v.condition == "NoQuesting" then
              isDisplay = CheckNoQuestingDisplay(v.mId)
            elseif v.condition == "QuestComplete" then
              isDisplay = CheckQuestCompleteDisplay(v.mId)
            elseif v.condition == "QuestIncomplete" then
              isDisplay = CheckQuestIncompleteDisplay(v.mId)
            elseif v.condition == "DEV" then
              isDisplay = CheckDevDisplay(v.val)
            elseif v.condition == "LV" then
              isDisplay = CheckLvDisplay(v.val)
            elseif v.condition == "Station" then
              isDisplay = CheckStationUnlockDisplay(v.mId)
            end
            checkShow = checkShow and isDisplay
            if not checkShow then
              break
            end
          end
        end
        if checkShow then
          element.self:SetAnchoredPosition(Vector2(info.x, info.y))
          element.self:SetActive(true)
          local t = {}
          t.id = info.id
          t.bubbleCA = bubbleCA
          DataModel.curShowBubbleList[elementIdx] = t
          local checkShowSpecial = bubbleCA.func ~= "" and 0 < bubbleCA.dialogId
          checkShowSpecial = checkShowSpecial and PlayerData:GetPlayerPrefs("int", "Dialog" .. bubbleCA.dialogId) == 0
          if bubbleCA.isSpecial == false then
            element.Btn_Build.self:SetActive(true)
            element.Btn_Special.self:SetActive(false)
            element.Btn_Build.Group_Anim.Img_BuildMask:SetActive(not bubbleCA.isInstance)
            element.Btn_Build.Group_Anim.Img_InstanceMask:SetActive(bubbleCA.isInstance)
            element.Btn_Build.Group_Anim.Img_Mask.Img_Icon:SetSprite(bubbleCA.iconPath)
            element.Btn_Build.Group_Anim.Group_Name.Txt_Name:SetText(bubbleCA.name)
            element.Btn_Build.Group_Anim.Group_Name.Img_Icon:SetSprite(bubbleCA.nameIconPath)
            element.Btn_Build.Group_Anim.Group_Effect.self:SetActive(not bubbleCA.isLock)
            if bubbleCA.frontIconPath and bubbleCA.frontIconPath ~= "" then
              element.Btn_Build.Group_Anim.Img_Front:SetSprite(bubbleCA.frontIconPath)
              element.Btn_Build.Group_Anim.Img_Front:SetActive(true)
            else
              element.Btn_Build.Group_Anim.Img_Front:SetActive(false)
            end
            if not bubbleCA.isLock then
              if bubbleCA.isInstance then
                element.Btn_Build.Group_Anim.Group_Effect.Group_Instance:HideDynamicGameObject()
                element.Btn_Build.Group_Anim.Group_Effect.Group_Instance:SetDynamicGameObject(bubbleCA.effectPath, 0, 0)
              else
                element.Btn_Build.Group_Anim.Group_Effect.Group_Build:HideDynamicGameObject()
                element.Btn_Build.Group_Anim.Group_Effect.Group_Build:SetDynamicGameObject(bubbleCA.effectPath, 0, 0)
              end
            end
            element.Btn_Build.self:SetClickParam(elementIdx)
            local isShowEventRed = false
            local isShowRed = false
            if bubbleCA.func == "OpenUI" or bubbleCA.func == "OpenBuilding" then
              isShowEventRed = QuestProcess.IsHaveEventOpen(bubbleCA.buildingId)
            elseif bubbleCA.func == "OpenScene" then
              isShowEventRed = QuestProcess.IsHaveEventOpen(bubbleCA.stationPlace)
            end
            if not isShowEventRed and (bubbleCA.btnType == "HomeSafe" or bubbleCA.btnType == "RubbishStation" or bubbleCA.btnType == "RestArea") then
              isShowRed = RedPointNodeStr.IsHaveRed(bubbleCA.btnType)
            end
            element.Btn_Build.Group_Anim.Group_Track_Event.self:SetActive(isShowEventRed)
            element.Btn_Build.Group_Anim.Img_RedPoint:SetActive(isShowRed)
            local conditionLock = false
            if not bubbleCA.isLock then
              for k, v in ipairs(bubbleCA.unlockConditionsList) do
                if v.condition == "LV" then
                  conditionLock = CheckPlayerLvLock(v.val)
                elseif v.condition == "REPLV" then
                  conditionLock = CheckRepLvLock(v.val)
                elseif v.condition == "Item" then
                  conditionLock = not CheckItemLock(v.mId)
                elseif v.condition == "Quest" then
                  conditionLock = CheckQuestLock(v.mId)
                end
                if conditionLock then
                  t.lockText = v.textId
                  break
                end
              end
            end
            t.isLock = conditionLock
            element.Btn_Build.Group_Anim.Img_Lock.self:SetActive(bubbleCA.isLock or conditionLock)
          else
            element.Btn_Build.self:SetActive(false)
            element.Btn_Special.self:SetActive(true)
            element.Btn_Special.Group_Anim.Img_Special:SetSprite(bubbleCA.iconPath)
            element.Btn_Special.Group_Anim.Group_Name.Txt_Name:SetText(bubbleCA.name)
            element.Btn_Special.Group_Anim.Group_Name.Img_Icon:SetSprite(bubbleCA.nameIconPath)
            element.Btn_Special.self:SetClickParam(elementIdx)
            element.Btn_Special.Group_Anim.Img_Tip:SetActive(checkShowSpecial)
          end
          elementIdx = elementIdx + 1
        end
      end
    end
  end
  for i = elementIdx, count do
    local element = View.ScrollView_Map.Viewport.Group_BG["Group_Build" .. i]
    if element ~= nil then
      element.self:SetActive(false)
    end
  end
  View.Group_Reputation.self:SetActive(listCA.isShowRep)
  if HomeCommon.GetCurLvRepData(DataModel.stationId) ~= nil then
    HomeCommon.SetReputationElement(View.Group_Reputation, DataModel.stationId)
  end
  RefreshMissIonRed()
  QuestTrace.SetQuestTrace(View.Group_Navigation, 2)
end

function Controller:ClickBtn(idx, extraData)
  local info
  if extraData then
    local data = PlayerData:GetFactoryData(extraData.bubbleId)
    info = {
      bubbleCA = data,
      idx = extraData.idx
    }
    local conditionLock = false
    if not data.isLock then
      for k, v in ipairs(data.unlockConditionsList) do
        if v.condition == "LV" then
          conditionLock = CheckPlayerLvLock(v.val)
        elseif v.condition == "REPLV" then
          conditionLock = CheckRepLvLock(v.val)
        elseif v.condition == "Item" then
          conditionLock = not CheckItemLock(v.mId)
        elseif v.condition == "Quest" then
          conditionLock = CheckQuestLock(v.mId)
        end
        if conditionLock then
          info.lockText = v.textId
          break
        end
      end
    end
    info.isLock = conditionLock
  else
    info = DataModel.curShowBubbleList[idx]
  end
  if info.isLock then
    CommonTips.OpenTips(info.lockText)
    return
  end
  local bubbleCA = info.bubbleCA
  local detailDo
  local isPlayOut = true
  if bubbleCA ~= nil then
    local checkTime = true
    checkTime = QuestProcess.CheckTime(bubbleCA.activityId, bubbleCA.startTime, bubbleCA.endTime)
    if checkTime then
      for i, v in ipairs(bubbleCA.displayConditionsList) do
        if v.condition == "Questing" then
          local isDisplay = CheckQuestingDisplay(v.mId)
          checkTime = checkTime and isDisplay
          if not checkTime then
            break
          end
        end
      end
    end
    if not checkTime then
      CommonTips.OpenTips(80602659)
      return
    end
    if bubbleCA.func == "OpenUI" then
      local isReturn = false
      if bubbleCA.uiPath == "UI/InsZone/StoryTips" or bubbleCA.uiPath == "UI/Guidance/Guidance_Tips" then
        isPlayOut = false
      end
      if not isReturn then
        function detailDo()
          if bubbleCA.uiPath == "UI/Activity/ActivityMain" then
            UIManager:Open(bubbleCA.uiPath, Json.encode({
              id = bubbleCA.activityId,
              
              isCityMapIn = true
            }))
            require("UIActivityMain/UIActivityMainView").Group_List.ScrollGrid_List.grid.self:SetActive(false)
          elseif bubbleCA.uiPath == "UI/CubeRogue/OverView/CubeRogueOverview" then
            Net:SendProto("cube.info", function(json)
              PlayerData.TempCache.CubeRogueData = json.cube
              UIManager:Open("UI/CubeRogue/OverView/CubeRogueOverView", Json.encode({
                activityId = bubbleCA.activityId,
                isCityMapIn = true
              }))
            end)
          else
            local t = {}
            t.stationId = DataModel.stationId
            t.buildingId = bubbleCA.buildingId
            t.npcId = bubbleCA.npcId
            t.bgPath = bubbleCA.bgPath
            t.bgColor = bubbleCA.bgColor
            t.isCityMapIn = true
            t.name = bubbleCA.name
            t.textId = bubbleCA.textId
            t.idx = info.idx
            UIManager:Open(bubbleCA.uiPath, Json.encode(t))
          end
        end
      end
    elseif bubbleCA.func == "OpenScene" then
      function detailDo()
        if bubbleCA.stationPlace == 81500010 then
          PrisonController.OpenPrisonBuildUI()
        else
          local stationPlace = PlayerData:GetFactoryData(bubbleCA.stationPlace, "HomeStationPlaceFactory")
          HomeStationStoreManager:Create(stationPlace.resId, stationPlace.id)
          local coachCA = PlayerData:GetFactoryData(stationPlace.resId, "HomeCoachFactory")
          HomeStationStoreManager:Load(coachCA.defaultTemplate)
          for i, v in pairs(stationPlace.npcList) do
            HomeStationStoreManager:CreateCustom(v.id, 0, v.isRandom, v.npcX, v.npcZ, v.tree)
          end
          local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
          local conductor = PlayerData:GetUserInfo().gender == 1 and homeConfig.conductorM or homeConfig.conductorW
          local c = PlayerData:GetFactoryData(stationPlace.serverId, "HomeCharacterFactory")
          HomeStationStoreManager:CreateSpeicalCharacter(stationPlace.serverId, 0, 0, c.interactiveIconPath)
          UIManager:Open("UI/CityStore/CityStore", Json.encode({
            StationId = tostring(DataModel.stationId),
            PlaceId = tostring(bubbleCA.stationPlace)
          }))
          HomeStationStoreManager:CreateCustom(conductor, 0, true, 0, 0, "PassengerKCD:move")
          local sound = SoundManager:CreateSound(stationPlace.bgm)
          if sound ~= nil then
            sound:Play()
          end
        end
      end
    elseif bubbleCA.func == "OpenDialog" then
      isPlayOut = false
      
      function detailDo()
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = bubbleCA.dialogId
        }))
      end
    elseif bubbleCA.func == "OpenDungeon" then
      function detailDo()
        local status = {}
        
        status.chapterId = bubbleCA.dungeonId
        status.startNew = true
        status.GoBackUI = "UI/CityMap/CityMap"
        local t = {}
        t.stationId = DataModel.stationId
        t.cityMapId = DataModel.cityMapId
        status.GoBackUIParam = Json.encode(t)
        PlayerData.Last_Chapter_Parms = status
        PlayerData.BattleCallBackPage = "UI/InsZone/InsZone"
        UIManager:Open("UI/InsZone/InsZone", Json.encode(status))
      end
    elseif bubbleCA.func == "Tips" then
      isPlayOut = false
      
      function detailDo()
        CommonTips.OpenTips(bubbleCA.textId)
      end
    elseif bubbleCA.func == "OpenLevel" then
      function detailDo()
        local levelId = bubbleCA.levelId
        
        local status = {
          Current = "Chapter",
          squadIndex = PlayerData.BattleInfo.squadIndex,
          hasOpenThreeView = false
        }
        local t = {}
        t.stationId = DataModel.stationId
        t.cityMapId = DataModel.cityMapId
        status.extraUIParamData = t
        PlayerData.BattleInfo.battleStageId = levelId
        PlayerData.BattleCallBackPage = "UI/CityMap/CityMap"
        PlayerData.Last_Chapter_Parms = nil
        UIManager:Open("UI/Squads/Squads", Json.encode(status))
      end
    elseif bubbleCA.func == "OpenBuilding" then
      function detailDo()
        local buildingCA = PlayerData:GetFactoryData(bubbleCA.buildingId, "BuildingFactory")
        
        local t = {}
        t.stationId = DataModel.stationId
        t.buildingId = bubbleCA.buildingId
        t.npcId = bubbleCA.npcId
        t.bgPath = bubbleCA.bgPath
        t.bgColor = bubbleCA.bgColor
        t.isCityMapIn = true
        t.name = bubbleCA.name
        t.textId = bubbleCA.textId
        t.startTime = bubbleCA.startTime
        t.endTime = bubbleCA.endTime
        t.idx = info.idx
        if bubbleCA.buildingId == 84400137 then
          if not PrisonData.GetSeverPrisonData() then
            UIManager:Open(buildingCA.uiPath, Json.encode(t))
            PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
          else
            Net:SendProto("prison.building_orders", function(json)
              local OrderData = require("UIHYOrderStation/PrisonHyOrderData")
              OrderData.SetOrderData(json.prison_orders)
              Net:SendProto("prison.orders", function(json)
                OrderData.recordOrders = json.prison_orders
                if json.building then
                  local useTime = json.building["84400137"] and json.building["84400137"].prison_cnt
                  OrderData.useTime = useTime and useTime or 0
                end
                UIManager:Open(buildingCA.uiPath, Json.encode(t))
                PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
              end)
            end, 84400137)
          end
        else
          UIManager:Open(buildingCA.uiPath, Json.encode(t))
          PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
        end
      end
    elseif bubbleCA.func == "OpenCityMap" then
      detailDo = OpenCityMapDo
    elseif bubbleCA.func == "Guide" then
      isPlayOut = false
      detailDo = guideDo
    elseif bubbleCA.func == "OpenPlayground" then
      detailDo = OpenPlaygroundDo
    end
  end
  if detailDo then
    if extraData then
      detailDo(bubbleCA)
      return
    end
    local element = View.ScrollView_Map.Viewport.Group_BG["Group_Build" .. idx]
    if isPlayOut then
      element.self:SelectPlayAnim("PressDown")
    else
      element.self:SelectPlayAnim("PressDown2")
    end
    if isPlayOut then
      View.self:PlayAnim("Out", function()
        detailDo(bubbleCA)
      end)
    else
      detailDo(bubbleCA)
    end
  end
end

function Controller:SetBgInfo(bgList)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local scaleOneDaySecond = 86400 / homeConfig.dayScale
  local scaleTimeToday = (TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600) % scaleOneDaySecond
  local todayZeroTimeStamp = scaleTimeToday / scaleOneDaySecond * 86400
  local idx = 1
  for k, v in pairs(bgList) do
    local h = tonumber(string.sub(v.changeTime, 1, 2))
    local m = tonumber(string.sub(v.changeTime, 4, 5))
    local s = tonumber(string.sub(v.changeTime, 7, 8))
    local time = h * 3600 + m * 60 + s
    if todayZeroTimeStamp < time then
      idx = k
      break
    end
  end
  idx = idx - 1
  if idx <= 0 then
    idx = #bgList
  end
  local detailInfo = bgList[idx]
  View.ScrollView_Map.Img_BG:SetSprite(detailInfo.bgPath)
  View.ScrollView_Map.Viewport.Group_BG.Group_Effect:HideDynamicGameObject()
  if 0 < detailInfo.effectListId then
    local listCA = PlayerData:GetFactoryData(detailInfo.effectListId, "ListFactory")
    if 0 < #listCA.effectList then
      local effectPath
      local weight = 0
      for k, v in pairs(listCA.effectList) do
        weight = weight + v.weight
      end
      local randomNum = math.random(1, weight)
      for k, v in pairs(listCA.effectList) do
        randomNum = randomNum - v.weight
        if randomNum <= 0 then
          effectPath = v.effectPath
          break
        end
      end
      if effectPath then
        View.ScrollView_Map.Viewport.Group_BG.Group_Effect:SetDynamicGameObject(effectPath, 0, 0)
      end
    end
  end
end

function Controller:FuncActive()
  local funcTable = {}
  funcTable[100] = function(active)
    View.Group_TopRight.Btn_Mission.self:SetActive(active)
    if active then
      local isOpen = PlayerData:GetNowPassData()
      View.Group_TopRight.Btn_Mission.self:SetActive(isOpen)
    end
  end
  funcTable[101] = function(active)
    View.Group_TopRight.Btn_Store.self:SetActive(active)
    if active then
      local StoreDataModel = require("UIStore/UIStoreDataModel")
      View.Group_TopRight.Btn_Store.Img_Remind.self:SetActive(StoreDataModel.GetStoreRedState())
    end
  end
  funcTable[102] = function(active)
    View.Group_TopRight.Btn_Headhunt.self:SetActive(active)
    if active then
      local red = require("UIGachaNew/UIGachaNewDataModel").GachaIsRedPoint()
      View.Group_TopRight.Btn_Headhunt.Img_Remind.self:SetActive(red)
    end
  end
  funcTable[103] = function(active)
    View.Group_TopRight.Btn_Depot.self:SetActive(active)
  end
  funcTable[104] = function(active)
    View.Group_TopRight.Btn_Member.self:SetActive(active)
    View.Group_TopRight.Btn_Member.Img_Remind.self:SetActive(PlayerData.isAwakeRed)
  end
  funcTable[105] = function(active)
    View.Group_TopRight.Btn_Squads.self:SetActive(active)
  end
  funcTable[118] = function(active)
    View.Group_TopRight.Btn_Activity:SetActive(false)
  end
  funcTable[120] = function(active)
    View.Group_TopRight.Btn_ActivityNew:SetActive(true)
    local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    View.Group_TopRight.Btn_ActivityNew.Img_Remind:SetActive(ActivityMainDataModel.GetMainAllRedState())
  end
  
  local function funcViewShow(activeTable)
    for k, v in pairs(funcTable) do
      v(activeTable[k] ~= nil)
    end
  end
  
  local funcCommon = require("Common/FuncCommon")
  funcCommon.CheckActiveFunc(funcViewShow)
end

function Controller:PlayBgm()
  local bgm = SoundManager:GetBgmSource()
  if bgm.name == "Empty" then
    local info = HomeCommon.GetCurShowSceneInfo(DataModel.stationId)
    local sound = SoundManager:CreateSound(info.bgmId)
    if sound ~= nil then
      sound:Play()
    end
  end
end

function Controller:ClickReturn()
  if DataModel.cityMapId and DataModel.cityMapId > 0 then
    local ca = PlayerData:GetFactoryData(DataModel.cityMapId)
    local exitId = ca.exitId
    if 0 < exitId then
      local factoryName = DataManager:GetFactoryNameById(exitId)
      if factoryName == "HomeStationFactory" then
        DataModel.cityMapId = 0
      else
        DataModel.cityMapId = exitId
      end
      View.self:PlayAnim("Out", function()
        Controller:Init()
        View.self:PlayAnim("In")
      end)
      return
    end
  end
  UIManager:GoHome()
end

function Controller.GetBubbleIsOpen(bubbleId)
  local bubbleCA = PlayerData:GetFactoryData(bubbleId)
  if not bubbleCA then
    return false
  end
  local checkShow = true
  checkShow = checkShow and QuestProcess.CheckTime(bubbleCA.activityId, bubbleCA.startTime, bubbleCA.endTime)
  if checkShow then
    for i, v in ipairs(bubbleCA.displayConditionsList) do
      local isDisplay = true
      if v.condition == "Questing" then
        isDisplay = CheckQuestingDisplay(v.mId)
      elseif v.condition == "NoQuesting" then
        isDisplay = CheckNoQuestingDisplay(v.mId)
      elseif v.condition == "QuestComplete" then
        isDisplay = CheckQuestCompleteDisplay(v.mId)
      elseif v.condition == "QuestIncomplete" then
        isDisplay = CheckQuestIncompleteDisplay(v.mId)
      elseif v.condition == "DEV" then
        isDisplay = CheckDevDisplay(v.val)
      elseif v.condition == "LV" then
        isDisplay = CheckLvDisplay(v.val)
      elseif v.condition == "Station" then
        isDisplay = CheckStationUnlockDisplay(v.mId)
      end
      checkShow = checkShow and isDisplay
      if not checkShow then
        break
      end
    end
  end
  if checkShow then
    local conditionLock = false
    if not bubbleCA.isLock and bubbleCA.unlockConditionsList then
      for k, v in ipairs(bubbleCA.unlockConditionsList) do
        if v.condition == "LV" then
          conditionLock = CheckPlayerLvLock(v.val)
        elseif v.condition == "REPLV" then
          conditionLock = CheckRepLvLock(v.val)
        elseif v.condition == "Item" then
          conditionLock = not CheckItemLock(v.mId)
        elseif v.condition == "QuestId" then
          conditionLock = CheckQuestLock(v.mId)
        end
        if conditionLock then
          checkShow = false
          break
        end
      end
    end
  end
  return checkShow
end

return Controller
