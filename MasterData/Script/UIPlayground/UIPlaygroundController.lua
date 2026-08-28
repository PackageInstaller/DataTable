local View = require("UIPlayground/UIPlaygroundView")
local DataModel = require("UIPlayground/UIPlaygroundDataModel")
local HomeCommon = require("Common/HomeCommon")
local Controller = {}

function Controller:SetDefaultPanel()
  local playgroundEntrance = HomeManager.homeTran.parent:GetComponent(typeof(CS.eden.home.PlaygroundEntrance))
  CS.FRef.setProperty(playgroundEntrance, "_defaultPanel", "UI/Playground/Playground")
end

function Controller:LoadHome()
  if not DataModel.isLoad then
    DataModel.isLoad = true
    TrainCameraManager:OpenCamera(2)
    DataModel.InitRoomInfo()
    HomeManager:RefreshData(CommonCoachData.roomID, CommonCoachData.roomData)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.TempRefreshRoomPileUpData()
    local HomeController = require("UIHome/UIHomeController")
    HomeController.InitAllFurnitureExtraData()
    HomeManager:OpenHome(0)
    local playgroundCA = PlayerData:GetFactoryData(DataModel.initParams.playgroundId, "PlaygroundFactory")
    HomeManager:SetPlaygroundScenePosX(HomeManager:GetTotalRoomSize() - HomeManager:GetRoomSize(0) + playgroundCA.sceneDefaultOffsetX)
    Controller:CreateBattleCharacter()
  end
  DataModel.cacheDebuff = 0
  DataModel.cacheClean = 0
  DataModel.InitQuestInfo()
  Controller:CheckQuestProcess()
  HomeCharacterManager:ReShowAll(true)
  Controller:RefreshQuestShow()
  View.Img_LV.Txt_Num:SetText(CommonCoachData.GetCurPlaygroundServerInfo().lv)
  local user_info = PlayerData:GetUserInfo()
  if user_info.avatar ~= nil and user_info.avatar ~= "" then
    DataModel.headSelectId = tonumber(user_info.avatar)
    DataModel.usedHeadId = DataModel.headSelectId
    local photoFactory = PlayerData:GetFactoryData(user_info.avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      View.Img_LV.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
      CommonTips:SetPlayerHeadShader(View.Img_LV.Btn_ProfilePhoto.Img_spAdd, photoFactory)
    end
  else
    local gender = user_info.gender or 1
    local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if head ~= nil and head.playerHeadList ~= nil then
      View.Img_LV.Btn_ProfilePhoto.Img_Client:SetSprite(head.playerHeadList[gender + 1].playerHeadPath)
    end
  end
  local ca = PlayerData:GetFactoryData(11400218)
  View.Group_Store.Img_Icon:SetSprite(ca.buyPath)
  View.Group_Store.Txt_Num:SetText(PlayerData:GetGoodsById(11400218).num)
  ca = PlayerData:GetFactoryData(11400212)
  View.Group_Exchange.Img_Icon:SetSprite(ca.buyPath)
  View.Group_Exchange.Txt_Num:SetText(PlayerData:GetGoodsById(11400212).num)
  Net:SendProto("playground.clean_status", function(json)
    local current_clean = json.current_clean
    DataModel.cacheClean = current_clean
    if current_clean < 1 then
      View.Btn_Moster.Btn_Debuff:SetActive(true)
    elseif DataModel.cacheDebuff == 0 then
      View.Btn_Moster.Btn_Debuff:SetActive(false)
    end
    View.Img_Cleanliness.Txt_Percentage:SetText(string.format(GetText(80607672), math.floor(current_clean * 100)))
    View.Img_Cleanliness.Img_full:SetFilledImgAmount(current_clean)
  end, DataModel.initParams.playgroundId)
  local visitorNum = PlayerData.GetVisitorsNum(DataModel.initParams.playgroundId)
  View.Btn_Tourist.Txt_Num:SetText(visitorNum)
  View.Img_LV.Txt_TurnoverNum:SetText(0)
  Net:SendProto("main.overview", function(json)
    if json.hty_record then
      local todayHtyData = json.hty_record.day and json.hty_record.day[5]
      local todayConsume = todayHtyData and todayHtyData.money or 0
      View.Img_LV.Txt_TurnoverNum:SetText(PlayerData:TransitionNum(math.floor(todayConsume)))
    end
  end, "island", DataModel.initParams.playgroundId)
  View.Img_LV.Img_MoneyBg.Txt_GoldenNum:SetText(0)
  View.Img_LV.Group_Reward:SetActive(false)
  Net:SendProto("playground.park_reward", function(json)
    if json and json.interface then
      local curConsume = json.interface.gold or 0
      View.Img_LV.Img_MoneyBg.Txt_GoldenNum:SetText(curConsume)
      local showTip = false
      if 100000 <= curConsume then
        showTip = true
      end
      if not showTip then
        local time = PlayerData:GetPlayerPrefs("int", "PlayGroundGetReward")
        if time == 0 or TimeUtil:GetServerTimeStamp() - time >= 86400 then
          showTip = true
        end
      end
      View.Img_LV.Group_Reward:SetActive(showTip)
    end
  end, 0, DataModel.initParams.playgroundId)
  View.Btn_Moster.Group_Reward:SetActive(false)
  Net:SendProto("playground.fg_reward_list", function(json)
    DataModel.helpReward = json.fg_reward or {}
    View.Btn_Moster.Group_Reward:SetActive(table.count(DataModel.helpReward) > 0)
  end, 0)
end

function Controller:DoDecorate()
  PlayerData.TempCache.BeginDecorateTimeStamp = TimeUtil:GetServerTimeStamp()
  local t = {}
  t.playgroundId = DataModel.initParams.playgroundId
  UIManager:Open("UI/Home/HomeCoach", Json.encode(t))
end

function Controller:Return()
  DataModel.isLoad = false
  
  local function cb()
    local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
    if SliceSceneManager ~= nil then
      SliceSceneManager.loadedScene:Clear()
    end
    CBus:ChangeScene(DataModel.initParams.backSceneName, function()
      if DataModel.initParams.backParams then
        UIManager:Open(DataModel.initParams.backUI, Json.encode(DataModel.initParams.backParams))
      else
        UIManager:Open(DataModel.initParams.backUI)
      end
    end)
    GameSetting:LoadPlayerSetting()
    PlayerData:ResetCharacterFilter()
    PlayerData:ResetSuaqsFilter()
    PlayerData:ResetDepotFilter()
  end
  
  local playgroundCA = PlayerData:GetFactoryData(DataModel.initParams.playgroundId)
  local randomNum = math.random(1, #playgroundCA.loadingList)
  CommonTips.OpenLoading(nil, "", playgroundCA.loadingList[randomNum].imagePath, cb)
end

function Controller:Home()
  DataModel.isLoad = false
  CommonCoachData.GoHome()
end

function Controller:ClearCacheEventList()
  if DataModel.cacheEventChaIdInfo == nil then
    return
  end
  for i, v in pairs(DataModel.cacheEventChaIdInfo) do
    local character = HomeCharacterManager:GetHomeCharactersByIdx(i)
    if character ~= nil then
      HomeCharacterManager:RemoveCharacter(character)
    end
  end
  DataModel.cacheEventChaIdInfo = {}
end

function Controller:CheckQuestProcess()
  Controller:ClearCacheEventList()
  local params = {}
  params.url = View.self.url
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  local t = Clone(DataModel.initParams)
  t.scene = MainManager.bgSceneName
  status.extraUIParamData = t
  params.status = status
  DataModel.cacheEventList = QuestProcess.CheckEventOpen(DataModel.initParams.playgroundId, params)
  if #DataModel.cacheEventList > 0 then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    for i, v in ipairs(DataModel.cacheEventList) do
      local tileIdx = v.qXPos * HomeManager.TileIdxParam + v.qYPos
      local character = HomeCharacterManager:CreateCharacter(v.homeQId, 0, tileIdx)
      character.pro = 1
      DataModel.cacheEventChaIdInfo[character.id] = v.homeQId
      local effectPart = character.effectPart
      if v.isPrefabBubble then
        effectPart:SetTouchEventWithObj(v.bubbleString, tostring(i))
        local characterCA = PlayerData:GetFactoryData(v.homeQId)
        effectPart:SetTouchEventPos(characterCA.bubbleX, characterCA.bubbleY, characterCA.bubbleZ)
      else
        effectPart:SetTouchEvent(v.bubbleString, tostring(i))
      end
    end
  end
end

function Controller.CreateVisitors()
  local playgroundId = DataModel.initParams.playgroundId
  local visitorData = PlayerData.GetVisitorsData(playgroundId)
  local createNum = 0
  local maxCreateNum = 20
  for _, v in pairs(visitorData) do
    for k, num in pairs(v.vt_info) do
      local roomIdx = math.random(0, #CommonCoachData.roomID - 1)
      local split = string.split(k, ":")
      local passageId = split[1]
      local passageCA = PlayerData:GetFactoryData(passageId, "PassageFactory")
      for i = 1, num do
        HomeCharacterManager:CreateCharacter(passageCA.homePassage, roomIdx, -1)
        createNum = createNum + 1
        if createNum == maxCreateNum then
          return
        end
      end
    end
  end
end

function Controller:CreateRoles()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local gender = PlayerData:GetUserInfo().gender or 1
  local conductor = homeConfig.conductorW
  if gender == 1 then
    conductor = homeConfig.conductorM
  end
  HomeCharacterManager:CreateCharacter(conductor, 0, -1)
  local playgroundCA = PlayerData:GetFactoryData(DataModel.initParams.playgroundId)
  local stepNum = playgroundCA.charNumMax
  local roles = PlayerData.ServerData.roles
  local rolesCount = table.count(roles)
  if rolesCount < stepNum * #CommonCoachData.roomID then
    stepNum = math.floor(rolesCount / #CommonCoachData.roomID)
  end
  local addCount = 0
  for k, v in pairs(roles) do
    local unitCA = PlayerData:GetFactoryData(k, "unitFactory")
    local roomIdx = math.floor(addCount / stepNum)
    if roomIdx >= #CommonCoachData.roomID then
      break
    end
    HomeCharacterManager:CreateCharacter(unitCA.homeCharacter, roomIdx, -1)
    addCount = addCount + 1
  end
end

function Controller:CreateBattleCharacter()
  Controller:ClearCacheBattleCharacter()
  Net:SendProto("playground.levels", function(json)
    PlayerData:GetHomeInfo().playground.levels = json.levels
    CommonCoachData.GetCurPlaygroundServerInfo().debuff = json.debuff
    local curTime = TimeUtil:GetServerTimeStamp()
    for i, v in ipairs(json.levels) do
      local levelId = v.id
      local createTime = v.created_ts or 0
      local time = curTime - createTime
      if not (time < 0) then
        local levelCA = PlayerData:GetFactoryData(levelId)
        if levelCA.homeChrId and 0 < levelCA.homeChrId then
          local roomIdx = math.random(0, #CommonCoachData.roomID - 1)
          local homeCharacter = HomeCharacterManager:CreateCharacter(levelCA.homeChrId, roomIdx, -1)
          local characterCA = PlayerData:GetFactoryData(levelCA.homeChrId)
          local status = {
            Current = "Chapter",
            squadIndex = PlayerData.BattleInfo.squadIndex,
            hasOpenThreeView = false,
            pgUniqueId = v.unique_id
          }
          local t = Clone(DataModel.initParams)
          t.scene = MainManager.bgSceneName
          status.extraUIParamData = t
          local sParams = "levelId#" .. tostring(levelId) .. "#" .. View.self.url .. "#" .. Json.encode(status)
          local playgroundCA = PlayerData:GetFactoryData(DataModel.initParams.playgroundId)
          local bubblePath = ""
          for i1 = #playgroundCA.bubbleList, 1, -1 do
            local v1 = playgroundCA.bubbleList[i1]
            if time >= v1.changeTime * 3600 then
              bubblePath = v1.bubblePath
              break
            end
          end
          if bubblePath ~= "" then
            local effectPart = homeCharacter.effectPart
            effectPart:SetTouchEventWithObj(bubblePath, sParams)
            effectPart:SetTouchEventPos(characterCA.bubbleX, characterCA.bubbleY, characterCA.bubbleZ)
          end
          local chrInfo = {}
          chrInfo.idx = homeCharacter.id
          chrInfo.chaCAId = levelCA.homeChrId
          chrInfo.time = time
          table.insert(DataModel.cacheBattleChaInfo, chrInfo)
        end
      end
    end
    Controller:SortBattleChaInfo()
    Controller:RefreshBattleInfo()
    if not DataModel.cacheBattleChaInfo or table.count(DataModel.cacheBattleChaInfo) == 0 then
      Controller.CreateVisitors()
      Controller:CreateRoles()
    end
  end, DataModel.initParams.playgroundId)
end

function Controller:SortBattleChaInfo()
  table.sort(DataModel.cacheBattleChaInfo, function(a, b)
    if a.time == b.time then
      return false
    end
    return a.time > b.time
  end)
end

function Controller:RefreshBattleInfo()
  View.Btn_Moster.Txt_Num:SetText(#DataModel.cacheBattleChaInfo)
  local debuff = CommonCoachData.GetCurPlaygroundServerInfo().debuff or 0
  DataModel.cacheDebuff = debuff
  local isShow = 0 < debuff
  View.Btn_Moster.Btn_Debuff:SetActive(isShow or DataModel.cacheClean < 1)
end

function Controller:ClickMonsterBtn()
  if table.count(DataModel.helpReward) > 0 then
    UIManager:Open("UI/Playground/FriendIslandUpdate/FightAward/FightAward", Json.encode({
      reward = DataModel.helpReward
    }), function()
      DataModel.helpReward = {}
      View.Btn_Moster.Group_Reward:SetActive(false)
    end)
    return
  end
  local count = #DataModel.cacheBattleChaInfo
  if count == 0 then
    local ca = PlayerData:GetFactoryData(DataModel.initParams.playgroundId)
    CommonTips.OpenTips(ca.noMONTips)
    return
  end
  if DataModel.battleFindIdx > #DataModel.cacheBattleChaInfo then
    DataModel.battleFindIdx = 1
  end
  if DataModel.battleFindIdx <= #DataModel.cacheBattleChaInfo then
    local chaInfo = DataModel.cacheBattleChaInfo[DataModel.battleFindIdx]
    local character = HomeCharacterManager:GetHomeCharactersByIdx(chaInfo.idx)
    if character ~= nil then
      local pos = character.view.transform.localPosition
      HomeManager:HomeCameraMoveXTween(pos, 0.5)
    end
  end
  DataModel.battleFindIdx = DataModel.battleFindIdx + 1
end

function Controller:ClearCacheBattleCharacter()
  for i, chaInfo in ipairs(DataModel.cacheBattleChaInfo) do
    local character = HomeCharacterManager:GetHomeCharactersByIdx(chaInfo.idx)
    if character ~= nil then
      HomeCharacterManager:RemoveCharacter(character)
    end
  end
  DataModel.cacheBattleChaInfo = {}
end

function Controller:ShowDebuffTips(isShow)
  View.Group_DebuffTips.self:SetActive(isShow)
end

function Controller:RefreshQuestShow()
  local questId = PlayerData:GetPlayerPrefs("int", "PlaygroundQuestTrace" .. DataModel.initParams.playgroundId)
  if 0 < questId and PlayerData.GetQuestState(questId) == EnumDefine.EQuestState.Receive then
    local nextQuestId = 0
    if 0 < #DataModel.cachePlotQuestIdx and #DataModel.questList >= DataModel.cachePlotQuestIdx[1] then
      nextQuestId = DataModel.questList[DataModel.cachePlotQuestIdx[1]]
      table.remove(DataModel.cachePlotQuestIdx, 1)
    end
    if nextQuestId == 0 and DataModel.cacheQuestIdx[questId] then
      local idx = DataModel.cacheQuestIdx[questId]
      if #DataModel.questList >= idx + 1 then
        nextQuestId = DataModel.questList[idx + 1]
        local state = PlayerData.GetQuestState(nextQuestId)
        if state == EnumDefine.EQuestState.Receive or state == EnumDefine.EQuestState.Lock then
          nextQuestId = 0
        end
      end
    end
    PlayerData:SetPlayerPrefs("int", "PlaygroundQuestTrace" .. DataModel.initParams.playgroundId, nextQuestId)
    questId = nextQuestId
  end
  if 0 < questId then
    local questCA = PlayerData:GetFactoryData(questId)
    if questCA then
      local showTxt = questCA.describe
      if questCA.isShowProgress then
        local state, pcnt = PlayerData.GetQuestState(questId)
        if state == EnumDefine.EQuestState.Receive then
          PlayerData:SetPlayerPrefs("int", "PlaygroundQuestTrace" .. DataModel.initParams.playgroundId, 0)
          showTxt = ""
        else
          showTxt = showTxt .. string.format("(%d/%d)", pcnt, questCA.num)
        end
      end
      View.Group_Navigation.Btn_Navigation.Txt_Target:SetText(showTxt)
    end
  else
    View.Group_Navigation.Btn_Navigation.Txt_Target:SetText("")
  end
  local islandTaskDataModel = require("UIIslandTask/UIIslandTaskDataModel")
  local isShowRed = islandTaskDataModel.IsCanReceive(true, DataModel.initParams.playgroundId)
  View.Group_Navigation.Img_RedPoint:SetActive(isShowRed)
end

function Controller:ClickQuest()
  local t = {}
  t.playgroundId = DataModel.initParams.playgroundId
  UIManager:Open("UI/Island_Task/IslandTask", Json.encode(t))
end

function Controller:ShowQuickJump(isShow, callback)
  if isShow == View.Group_QuickJump.Btn_Close.IsActive then
    return
  end
  
  local function showUI()
    View.Group_QuickJump.self:SetActive(isShow)
    View.Group_QuickJump.Btn_Close:SetActive(isShow)
    View.Group_QuickJump.Group_Windows.self:SetActive(isShow)
  end
  
  if isShow then
    showUI()
    local playgroundId = CommonCoachData.GetPlaygroundId()
    local playgroundCA = PlayerData:GetFactoryData(playgroundId)
    DataModel.maxCoachNum = #playgroundCA.extendList + 1
    DataModel.camRoom = HomeManager.camRoom
    DataModel.lastSelectIdx = DataModel.camRoom
    View.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.grid.self:RefreshAllElement()
    View.self:PlayAnimOnce("In_Jump", function()
      if callback then
        callback()
      end
    end)
  else
    View.self:PlayAnimOnce("Out_Jump", function()
      showUI()
      if callback then
        callback()
      end
    end)
  end
end

function Controller:ClickQuickJumpShow(isShow)
  View.Btn_NAV:SetBtnInteractable(false)
  View.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
  Controller:ShowQuickJump(isShow, function()
    View.Btn_NAV:SetBtnInteractable(true)
    View.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
  end)
end

function Controller:RefreshQuickJumpElement(element, elementIndex)
  if elementIndex > DataModel.maxCoachNum then
    element:SetActive(false)
    return
  end
  element:SetActive(true)
  local isEmpty = not CommonCoachData.roomID[elementIndex]
  if not isEmpty then
    local id = CommonCoachData.roomID[elementIndex]
    local coachCA = PlayerData:GetFactoryData(id, "HomeCoachFactory")
    local typeCA = PlayerData:GetFactoryData(coachCA.coachType, "TagFactory")
    local toRoomIdx = elementIndex - 1
    element.Btn_train:SetClickParam(toRoomIdx)
    if toRoomIdx == DataModel.camRoom then
      DataModel.lastSelectElement = element
    end
    element.Btn_train.Img_Select:SetActive(toRoomIdx == DataModel.camRoom)
    element.Btn_train.Img_UnSelect:SetActive(toRoomIdx ~= DataModel.camRoom)
    element.Btn_train.Img_Select.Img_Icon:SetSprite(typeCA.skipJumpIcon)
    element.Btn_train.Img_UnSelect.Img_Icon:SetSprite(typeCA.skipJumpIcon2)
    local showTxt = string.format("%02d", elementIndex)
    element.Btn_train.Img_Select.Txt_Select:SetText(showTxt)
    element.Btn_train.Img_UnSelect.Txt_UnSelect:SetText(showTxt)
    element.Btn_train.Img_Empty:SetActive(false)
  else
    element.Btn_train.Img_Empty:SetActive(true)
    element.Btn_train.Img_Select:SetActive(false)
    element.Btn_train.Img_UnSelect:SetActive(false)
    local showTxt = string.format("%02d", elementIndex)
    element.Btn_train.Img_Empty.Txt_Empty:SetText(showTxt)
  end
end

function Controller:ClickQuickJump(btn, str)
  local idx = tonumber(str)
  if idx == nil or idx < 0 then
    CommonTips.OpenTips(80608256)
    return
  end
  if DataModel.lastSelectIdx == idx then
    return
  end
  if DataModel.lastSelectIdx and View.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.grid[DataModel.lastSelectIdx + 1] then
    local element = View.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.grid[DataModel.lastSelectIdx + 1]
    element.Btn_train.Img_Select:SetActive(false)
    element.Btn_train.Img_UnSelect:SetActive(true)
  end
  MainManager:SetTrainViewFilter(30, false)
  HomeManager:OpenHome(idx)
  local curElement = View.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.grid[idx + 1]
  if curElement then
    curElement.Btn_train.Img_Select:SetActive(true)
    curElement.Btn_train.Img_UnSelect:SetActive(false)
  end
  DataModel.lastSelectIdx = idx
end

function Controller:Extend()
  local curCount = #CommonCoachData.roomID
  local playgroundCA = PlayerData:GetFactoryData(DataModel.initParams.playgroundId)
  if curCount > #playgroundCA.extendList then
    CommonTips.OpenTips(playgroundCA.extendLimitTips)
    return
  end
  local curExtendCoachId = playgroundCA.extendList[curCount].id
  local t = {}
  t.playgroundId = DataModel.initParams.playgroundId
  t.coachId = curExtendCoachId
  UIManager:Open("UI/Playground/Extend", Json.encode(t))
end

function Controller:OpenBuildingShop()
  local data = PlayerData:GetFactoryData(84400105)
  Net:SendProto("shop.info", function(json)
    UIManager:Open("UI/Building/BuildingShop", Json.encode({
      stationId = data.stationId,
      buildId = 84400087
    }), function()
      Controller:RefreshQuestShow()
    end)
  end)
end

function Controller:OpenExchangeStation()
  local ca = PlayerData:GetFactoryData(84400105)
  local data
  for _, v in ipairs(ca.openPageList) do
    if v.bubId == 86400214 then
      data = v
    end
  end
  if data then
    require("UICityMap/UICityMapController"):ClickBtn(nil, {
      bubbleId = data.bubId,
      idx = data.listIndex
    })
  end
end

function Controller:OpenLMUI()
  Net:SendProto("main.overview", function(json)
    UIManager:Open("UI/Island_Management/LM_UI", Json.encode(json))
  end, "island", 87300002)
end

function Controller:OpenHelp()
  CommonTips.OpenHelp(80305458)
end

function Controller:OpenIslandBattle()
  local activityCA = PlayerData:GetFactoryData(86000016)
  if activityCA.levelEndTime ~= "" and TimeUtil:GetServerTimeStamp() > TimeUtil:TimeStamp(activityCA.levelEndTime) then
    CommonTips.OpenTips(80607798)
    return
  end
  local isLandDataModel = require("UIIslandActivity/UIIslandActivityDataModel")
  if activityCA.levelQuestLimit ~= -1 and isLandDataModel:QuestIsFinish(activityCA.levelQuestLimit) == false then
    local questCA = PlayerData:GetFactoryData(activityCA.levelQuestLimit)
    local text = string.format(GetText(80607796), questCA.name)
    CommonTips.OpenTips(text, true)
    return
  end
  UIManager:Open("UI/Island_Battle/Island_Battle", Json.encode({activityId = 86000016, isPlayGround = true}))
end

function Controller:OpenRubbish()
  local ufid = ""
  local id
  for k, v in pairs(CommonCoachData.GetFurData()) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600474 then
      ufid = k
      id = v.id
    end
  end
  if ufid ~= "" then
    UIManager:Open("UI/Island_Rubbish/HomeRubbish", Json.encode({
      ufid = ufid,
      furId = id,
      noChangeSkin = true
    }))
  end
end

return Controller
