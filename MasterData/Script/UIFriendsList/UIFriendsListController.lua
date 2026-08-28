local View = require("UIFriendsList/UIFriendsListView")
local DataModel = require("UIFriendsList/UIFriendsListDataModel")
local HomeController = require("UIHome/UIHomeController")
local HomeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local HomeCoachController = require("UIHomeCoach/UIHomeCoachController")
local passengerDataModel = require("UIPassenger/UIPassengerDataModel")
local Controller = {}

function Controller:Init()
  local index = DataModel.TabIndex
  View.Img_BG.Group_List.Btn_List.Img_Select:SetActive(index == 1)
  View.Img_BG.Group_List.Btn_Log.Img_Select:SetActive(index == 2)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Friends.self:SetActive(index == 1)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Log.self:SetActive(index == 2)
  View.Img_BG.Group_Title.Img_TodayVisit.Txt_Num:SetText(DataModel.TodayLookCount)
  View.Img_BG.Group_Title.Img_TotallyVisit.Txt_Num:SetText(DataModel.TotalLookCount)
  Controller:RefreshFriendList()
  View.self:PlayAnim("FriendsList_In")
end

function Controller:SwitchTabIndex(index)
  DataModel.TabIndex = index
  View.Img_BG.Group_List.Btn_List.Img_Select:SetActive(index == 1)
  View.Img_BG.Group_List.Btn_Log.Img_Select:SetActive(index == 2)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Friends.self:SetActive(index == 1)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Log.self:SetActive(index == 2)
  if index == 1 then
    Net:SendProto("friend.friends", function(json1)
      DataModel.friendsCnt = json1.friend_cnt
      DataModel.InitFriend(json1.friends)
      DataModel.TodayLookCount = json1.coach_look_cnt_today or 0
      DataModel.TotalLookCount = json1.coach_look_cnt_forever or 0
      Controller:RefreshFriendList(true)
      View.self:PlayAnimOnce("FriendsChange_List")
    end, DataModel.onePageNum, 1)
  else
    Net:SendProto("friend.block_record", function(json1)
      View.self:PlayAnimOnce("FriendsChange_Log")
      DataModel.InitLog(json1.rank_list)
      Controller:RefreshLogList()
    end)
  end
  View.Img_BG.Group_Title.Img_TodayVisit.Txt_Num:SetText(DataModel.TodayLookCount)
  View.Img_BG.Group_Title.Img_TotallyVisit.Txt_Num:SetText(DataModel.TotalLookCount)
end

function Controller:GetNewPageFriends()
  local curPage = #DataModel.FriendList / DataModel.onePageNum
  curPage = math.floor(curPage + 0.1)
  Net:SendProto("friend.friends", function(json1)
    DataModel.friendsCnt = json1.friend_cnt
    DataModel.AddFriends(json1.friends)
    DataModel.TodayLookCount = json1.coach_look_cnt_today or 0
    DataModel.TotalLookCount = json1.coach_look_cnt_forever or 0
    Controller:RefreshFriendList()
    View.Img_BG.Group_Title.Img_TodayVisit.Txt_Num:SetText(DataModel.TodayLookCount)
    View.Img_BG.Group_Title.Img_TotallyVisit.Txt_Num:SetText(DataModel.TotalLookCount)
  end, DataModel.onePageNum, curPage + 1)
end

function Controller:SetFriendElement(element, elementIndex)
  local data = DataModel.FriendList[elementIndex]
  if data == nil then
    return
  end
  element.Txt_Name:SetText(data.role_name)
  element.Txt_Name.Txt_LV:SetText("Lv" .. data.lv)
  if data.avatar and data.avatar ~= "" and data.avatar > 0 then
    element.Img_HeadBG.Img_Mask.Img_Head:SetSprite(PlayerData:GetFactoryData(data.avatar).imagePath)
    CommonTips:SetPlayerHeadShader(element.Img_HeadBG.Img_Mask.Img_spAdd, PlayerData:GetFactoryData(data.avatar))
  end
  local cityId = data.position
  local stationCfg = PlayerData:GetFactoryData(cityId) or {}
  element.Img_Location.Txt_City:SetText(stationCfg.name or GetText(80607961))
  element.Btn_Visit:SetClickParam(elementIndex)
  local CurStayCity = require("UIHome/UIHomeTradeDataModel").CurStayCity or 0
  element.Btn_Visit.Img_Cant:SetActive(tostring(CurStayCity) ~= data.position)
  if PlayerData.visitMode and PlayerData.visitInfo and PlayerData.visitInfo.uid and PlayerData.visitInfo.uid ~= "" then
    element.Btn_Visit.Img_AlreadyIn:SetActive(tostring(PlayerData.visitInfo.uid) == tostring(data.uid))
  else
    element.Btn_Visit.Img_AlreadyIn:SetActive(false)
  end
  local canSteal = data.steal_ss == 1 and data.stolen_cnt < DataModel.stealNum
  element.Img_HeadBG.Img_GarbageStationBG.Img_Open:SetActive(canSteal)
  element.Img_HeadBG.Img_GarbageStationBG.Img_Close:SetActive(not canSteal)
  if elementIndex == #DataModel.FriendList and elementIndex % DataModel.onePageNum == 0 and elementIndex < DataModel.friendsCnt then
    Controller:GetNewPageFriends()
  end
end

function Controller:RefreshFriendList(isTop)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Friends.grid.self:SetDataCount(#DataModel.FriendList)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Friends.grid.self:RefreshAllElement()
  if isTop then
    View.Img_BG.Group_List.Group_List.ScrollGrid_Friends.grid.self:MoveToTop()
  end
end

function Controller:SetLogElement(element, elementIndex)
  local data = DataModel.LogList[elementIndex]
  element.Txt_Name:SetText(data.role_name)
  element.Txt_Name.Txt_LV:SetText("Lv" .. data.lv)
  element.Img_HeadBG.Img_Mask.Img_Head:SetSprite(PlayerData:GetFactoryData(data.avatar).imagePath)
  CommonTips:SetPlayerHeadShader(element.Img_HeadBG.Img_Mask.Img_spAdd, PlayerData:GetFactoryData(data.avatar))
  element.Img_HeadBG.Img_GarbageStationBG.Img_Open:SetActive(data.open_stolen)
  element.Img_HeadBG.Img_GarbageStationBG.Img_Close:SetActive(not data.open_stolen)
  element.Txt_Clear:SetText(string.format(GetText(80610914), data.steal_num))
  local timeTable = TimeUtil:FormatUnixTime2Date(data.steal_ts)
  element.Txt_Time:SetText(timeTable.year .. "/" .. timeTable.month .. "/" .. timeTable.day)
end

function Controller:RefreshLogList()
  View.Img_BG.Group_List.Group_List.ScrollGrid_Log.grid.self:SetDataCount(#DataModel.LogList)
  View.Img_BG.Group_List.Group_List.ScrollGrid_Log.grid.self:RefreshAllElement()
end

local function VisitFriendsTrainCallback()
  local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
  if SliceSceneManager ~= nil then
    SliceSceneManager.loadedScene:Clear()
  end
  if MainManager.bgSceneName == "Home" and not DataModel.IsGoingHome then
    View.self:StartC(LuaUtil.cs_generator(function()
      LoadingManager:SetLoadingPercent(0.3)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      Controller.OpenFriendsList()
      LoadingManager:SetLoadingPercent(0.8)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      LoadingManager:SetLoadingPercent(1)
    end))
  elseif DataModel.IsGoingHome then
    View.self:StartC(LuaUtil.cs_generator(function()
      LoadingManager:SetLoadingPercent(0.3)
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
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      UIManager:Open("UI/Friends/FriendTrain", Json.encode({
        backScene = "Home",
        backUI = "FriendsList"
      }))
      LoadingManager:SetLoadingPercent(0.8)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      LoadingManager:SetLoadingPercent(1)
    end))
  else
    CBus:ChangeScene("Home", function()
      UIManager:Open("UI/Friends/FriendTrain", Json.encode({
        backScene = "Main",
        backUI = "FriendsList"
      }))
    end)
  end
end

function Controller:TryVisitFriend(index)
  local data = DataModel.FriendList[index]
  if data == nil then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived ~= 2 then
    CommonTips.OpenTips(80609381)
    return
  end
  local CurStayCity = require("UIHome/UIHomeTradeDataModel").CurStayCity or 0
  if tostring(CurStayCity) ~= data.position then
    CommonTips.OpenTips(80609382)
    return
  end
  if PlayerData.visitMode and PlayerData.visitInfo and PlayerData.visitInfo.uid and PlayerData.visitInfo.uid ~= "" and tostring(PlayerData.visitInfo.uid) == tostring(data.uid) then
    return
  end
  Net:SendProto("friend.coach", function(json)
    PlayerData.visitMode = true
    PlayerData.visitInfo = {}
    PlayerData.visitInfo.furdata = json.furniture
    PlayerData.visitInfo.coach_template = json.coach_template
    PlayerData.visitInfo.pets = json.pets or {}
    PlayerData.visitInfo.roles = json.roles or {}
    PlayerData.visitInfo.coach_store = json.coach_store
    PlayerData.visitInfo.rubbish_area = json.rubbish_area
    PlayerData.visitInfo.my_rubbish_area = json.my_rubbish_area
    PlayerData.visitInfo.interact = json.interact or 0
    PlayerData.visitInfo.cur_hair = json.cur_hair
    local coachInfos = json.coach_template
    PlayerData.visitInfo.coachData = {}
    for k, v in ipairs(coachInfos) do
      local uid = v
      local coachInfo = json.coach_store[uid]
      table.insert(PlayerData.visitInfo.coachData, coachInfo)
    end
    PlayerData.visitInfo.guard = data.guard
    PlayerData.visitInfo.guard_many = data.guard_many
    PlayerData.visitInfo.lv = data.lv
    PlayerData.visitInfo.role_name = data.role_name
    PlayerData.visitInfo.avatar = data.avatar
    PlayerData.visitInfo.gender = data.gender
    PlayerData.visitInfo.uid = data.uid
    local loadingConfig = PlayerData:GetFactoryData(99900036, "ConfigFactory")
    local randomNum = math.random(1, #loadingConfig.enterHomeUIList)
    local path = loadingConfig.enterHomeUIList[randomNum].imagePath
    if MainManager.bgSceneName == "Home" then
      DataModel.IsGoingHome = true
    else
      DataModel.IsGoingHome = false
    end
    CommonTips.OpenLoading(nil, "", path, VisitFriendsTrainCallback)
  end, data.uid)
end

function Controller.OpenFriendsList()
  Net:SendProto("friend.friends", function(json)
    UIManager:Open("UI/Friends/FriendsList", Json.encode(json))
  end, DataModel.onePageNum, 1)
end

return Controller
