local View = require("UIFriends/UIFriendsView")
local ChangePosterGirlDataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local DataModel = require("UIFriends/UIFriendsDataModel")
local Controller = {}

function Controller.LoadPlayer(_gender, Player, idx)
  local isOwn = DataModel.status == 0
  local data
  if not isOwn then
    data = DataModel.GetFriendData()[idx]
  end
  ChangeSkinUtil.InitUICaptainSpineSkin(Player, "dorm_stand", data)
end

local function LoadRolePaint(roleId)
  View.Group_CallingCard:SetActive(true)
  View.Group_CardChoose:SetActive(false)
  View.Group_ListMain:SetActive(false)
  View.Group_CallingCard.Group_CardShow.Img_Show.StaticGrid_CollectCard.grid.self:RefreshAllElement()
  local viewId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
  if DataModel.status == 0 then
    local saveId = ChangePosterGirlDataModel.GetViewId(roleId)
    if saveId ~= 0 then
      viewId = saveId
    end
  end
  local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local spineUrl = viewCA.spineUrl
  if spineUrl ~= nil and spineUrl ~= "" then
    View.Group_CallingCard.Group_Assistant.SpineAnimation_Character:SetData(viewCA.spineUrl)
    View.Group_CallingCard.Group_Assistant.SpineAnimation_Character:SetAnchoredPositionX(370 + viewCA.spineX)
    View.Group_CallingCard.Group_Assistant.SpineAnimation_Character:SetAnchoredPositionY(-1300 + viewCA.spineY)
    View.Group_CallingCard.Group_Assistant.SpineAnimation_Character:SetLocalScale(100, 100, 100)
  end
  View.Group_CallingCard.Group_Assistant.Img_SpineBG:SetActive(false)
  if viewCA.SpineBackground and viewCA.SpineBackground ~= "" then
    View.Group_CallingCard.Group_Assistant.Img_SpineBG:SetActive(true)
    View.Group_CallingCard.Group_Assistant.Img_SpineBG:SetSprite(viewCA.SpineBackground)
    DataModel.offsetX = viewCA.SpineBGX and viewCA.SpineBGX or 0
    DataModel.offsetY = viewCA.SpineBGY and viewCA.SpineBGY or 0
    local x = DataModel.bgSpineX - DataModel.offsetX
    local y = viewCA.SpineBGY and viewCA.SpineBGY or 0
    View.Group_CallingCard.Group_Assistant.Img_SpineBG.transform.localPosition = Vector3(x, y, 0)
    local scale = viewCA.SpineBGScale or 1
    View.Group_CallingCard.Group_Assistant.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  View.Group_CallingCard.Img_Train.SpineAnimation_Character:SetActive(false)
  local gender = PlayerData:GetUserInfo().gender
  if DataModel.status ~= 0 then
    local data = DataModel.GetFriendData()[DataModel.selectIdx]
    gender = data and data.gender or gender
  end
  Controller.LoadPlayer(gender, View.Group_CallingCard.Img_Train.SpineAnimation_Player, DataModel.selectIdx)
end

function Controller.UpdatePersonInfo()
  local isOwn = DataModel.status == 0
  local data
  if not isOwn then
    data = DataModel.GetFriendData()[DataModel.selectIdx]
  end
  local mileageNum = DataModel.GetMileageNum(data and data.total_distance)
  DataModel.PlayerInfoList[1] = mileageNum
  local maxSpeed = DataModel.GetMaxSpeed(data and data.speed)
  DataModel.PlayerInfoList[2] = maxSpeed
  local tradeLv = DataModel.GetTradeLv(data and data.trade_lv)
  DataModel.PlayerInfoList[3] = tradeLv
  DataModel.PlayerInfoList[4] = DataModel.GetProfitDaily(data and data.profit_daily) or 0
  local totalGoods = DataModel.GetGoodsNum(data and data.goods_lit)
  DataModel.PlayerInfoList[5] = totalGoods
  local roleNum, skinNum = DataModel.GetRoleInfo(data and data.hero_num, data and data.hero_skin_cnt)
  DataModel.PlayerInfoList[6] = roleNum
  local trainSkinNum = DataModel.GetTrainSkinNum(data and data.skin_num)
  DataModel.PlayerInfoList[7] = trainSkinNum
  DataModel.PlayerInfoList[8] = skinNum
  local todayMileageNum = data and data.today_distance or DataModel.today_distance
  todayMileageNum = DataModel.GetTodayMileageNum(todayMileageNum)
  DataModel.PlayerInfoList[9] = todayMileageNum
  local todayProfit = data and data.today_profit or DataModel.today_profit
  todayProfit = math.floor(todayProfit or 0)
  DataModel.PlayerInfoList[10] = todayProfit
end

function Controller.UpdateFriendInfo(idx)
  local data = DataModel.GetFriendData()[idx]
  local mileageNum = DataModel.GetMileageNum(data.total_distance)
  DataModel.PlayerInfoList[4] = mileageNum
  local maxSpeed = DataModel.GetMaxSpeed(data.speed)
  DataModel.PlayerInfoList[1] = maxSpeed
  local tradeLv = DataModel.GetTradeLv(data.trade_lv)
  DataModel.PlayerInfoList[2] = tradeLv
  local totalGoods = DataModel.GetGoodsNum(data.goods_lit)
  DataModel.PlayerInfoList[5] = totalGoods
  local roleNum, skinNum = DataModel.GetRoleInfo(data.hero_num, data.hero_skin_cnt)
  local trainSkinNum = DataModel.GetTrainSkinNum(data.skin_num)
  DataModel.PlayerInfoList[3] = trainSkinNum
  DataModel.PlayerInfoList[6] = skinNum
  local todayMileageNum = DataModel.GetTodayMileageNum(data.today_distance)
  DataModel.PlayerInfoList[7] = todayMileageNum
  local todayProfit = math.floor(data.today_profit or 0)
  DataModel.PlayerInfoList[8] = todayProfit
  local points = data.tower_pt
  DataModel.PlayerInfoList[9] = points
end

function Controller.RefreshCardInfo()
  local isOwn = DataModel.status == 0
  local data
  if not isOwn then
    data = DataModel.GetFriendData()[DataModel.selectIdx]
  end
  View.Group_Top:SetActive(false)
  if data and type(data.receptionist_id) ~= "table" then
    data.receptionist_id = {
      [1] = data.receptionist_id
    }
  end
  local roleId = data and data.receptionist_id[1] or PlayerData:GetUserInfo().receptionist_id[1]
  LoadRolePaint(roleId)
  local uid = DataModel.GetUID(data and data.uid)
  View.Group_CallingCard.Img_Name.Group_Account.Txt_UID:SetText(uid)
  local name = DataModel.GetPlayerName(data and data.role_name)
  View.Group_CallingCard.Img_Name.Group_Account.Group_AccountInfo.Txt_Name:SetText(name)
  local lv = DataModel.GetPlayerLV(data and data.lv)
  lv = lv or 1
  View.Group_CallingCard.Img_Name.Group_Account.Group_AccountInfo.Txt_Level:SetText("LV " .. lv)
  local idx = lv // 10 + 1
  local lvIconPath = PlayerData:GetFactoryData(99900051).Playerranklist[idx].show
  View.Group_CallingCard.Img_Name.Img_Lv:SetSprite(lvIconPath)
  local gold = DataModel.GetGold(data and data.gold)
  View.Group_CallingCard.Img_Name.Img_Money.Txt_:SetText(gold)
  local gender = PlayerData:GetUserInfo().gender
  if DataModel.status ~= 0 then
    local data = DataModel.GetFriendData()[DataModel.selectIdx]
    gender = data and data.gender or gender
  end
  local headPah, photoFactory = DataModel.GetHeadPath(data and data.avatar, gender)
  View.Group_CallingCard.Img_Name.Img_Head.Img_Mask.Img_Character:SetSprite(headPah)
  CommonTips:SetPlayerHeadShader(View.Group_CallingCard.Img_Name.Img_Head.Img_Mask.Img_spAdd, photoFactory)
  local totalRep = DataModel.GetTotalRep(data and data.all_rep)
  View.Group_CallingCard.Img_Name.Img_CityPrestige.Group_.Txt_CityPrestige:SetText(totalRep)
  local points = data and data.tower_pt or DataModel.tower_points
  View.Group_CallingCard.Img_Name.Img_VR.Group_.Txt_VRNum:SetText(points)
  Controller.UpdatePersonInfo()
  View.Group_CallingCard.Img_Info.StaticGrid_Text.grid.self:RefreshAllElement()
  View.Group_CallingCard.Img_Info2.Group_LoginInfo:SetActive(false)
  local cityName = DataModel.GetCityName(data and data.position)
  View.Group_CallingCard.Img_Info2.Group_PositionInfo.Txt_PositionInfo:SetText(cityName)
  local path = DataModel.GetHeadTrainSkinPath(data and tonumber(data.head_skin))
  View.Group_CallingCard.Img_Train:SetSprite(path)
  View.Group_CallingCard.Img_Imput:SetActive(DataModel.status == 0 or DataModel.status == 1)
  if DataModel.showQQInfo == false then
    View.Group_CallingCard.Img_Imput:SetActive(false)
  end
  View.Group_CallingCard.Img_Imput.Img_Icon2:SetActive(DataModel.status == 0)
  View.Group_CallingCard.Img_Imput.Txt_Number:SetText(data and data.qq or PlayerData:GetUserInfo().qq)
  Controller:RefreshImgInfo()
  if isOwn then
    Controller:RefreshHelpRoles()
  else
    Controller:RefreshHelpRoles(data.uid)
  end
  local fashion_num = DataModel.GetFashionNum(data and data.fashion_num)
  View.Group_CallingCard.Group_Fashion.Txt_Num:SetText(fashion_num)
end

function Controller:RefreshImgInfo()
  View.Group_CallingCard.Img_Info:SetEnableAnimator(false)
  View.Group_CallingCard.Img_Name.Btn_Info.Img_Info:SetLocalEulerAngles(0)
  DataModel.isInfoShowing = false
end

function Controller:OnClickBtnInfoShow()
  DataModel.isInfoShowing = not DataModel.isInfoShowing
  if DataModel.isInfoShowing then
    View.Group_CallingCard.Img_Name.Btn_Info.Img_Info:SetLocalScale(-1, 1, 1)
    View.Group_CallingCard.Img_Info:SetEnableAnimator(true)
    View.self:SelectPlayAnim(View.Group_CallingCard.Img_Info.self, "Open")
    View.Group_CallingCard.Img_Info:SetEnableAnimator(true)
  else
    View.Group_CallingCard.Img_Name.Btn_Info.Img_Info:SetLocalScale(1, 1, 1)
    View.Group_CallingCard.Img_Info:SetEnableAnimator(true)
    View.self:SelectPlayAnim(View.Group_CallingCard.Img_Info.self, "Close")
    View.Group_CallingCard.Img_Info:SetEnableAnimator(true)
  end
end

local function UpdateList(lastStatus, status)
  local data = DataModel.GetFriendData()
  local count = #data
  View.Group_ListMain.NewScrollGrid_.grid.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    View.Group_ListMain.NewScrollGrid_.grid.self:SetDataCount(count)
    if lastStatus ~= status then
      View.Group_ListMain.NewScrollGrid_.grid.self:RefreshAllElement()
      View.Group_ListMain.NewScrollGrid_.grid.self:MoveToTop()
    else
      View.Group_ListMain.NewScrollGrid_.grid.self:RefreshAllElement()
    end
  end))
end

function Controller.RefreshPanel(status)
  View.Group_RightList.Group_CallingCard.Btn_CallingCard.Img_UnSelected.Img_Selected:SetActive(false)
  View.Group_RightList.Group_List.Btn_List.Img_UnSelected.Img_Selected:SetActive(false)
  View.Group_RightList.Group_Add.Btn_Add.Img_UnSelected.Img_Selected:SetActive(false)
  View.Group_RightList.Group_Request.Btn_Request.Img_UnSelected.Img_Selected:SetActive(false)
  View.Group_RightList.Group_Invite.Btn_Request.Img_UnSelected.Img_Selected:SetActive(false)
  View.Group_RightList.Group_Request.Img_Tips:SetActive(DataModel.applyRed)
  View.Group_RightList.Group_Invite.Img_Tips:SetActive(DataModel.inviteRed)
  View.Group_CallingCard.Group_Btn.Btn_Add:SetActive(false)
  View.Group_CallingCard.Group_Btn.Btn_Visit:SetActive(status == 1)
  View.Group_CallingCard:SetActive(false)
  View.Group_Invite:SetActive(false)
  View.Group_ListMain:SetActive(false)
  View.Group_ListMain:SetActive(true)
  View.Group_Top:SetActive(true)
  View.Group_Top.InputField_Search:SetActive(true)
  View.Group_Top.Btn_Refresh:SetActive(status == 2)
  View.Group_CallingCard.Group_CardShow.Img_Show.Btn_Change:SetActive(status == 0)
  View.Group_CallingCard.Img_Imput:SetActive(false)
  local lastStatus = DataModel.status
  DataModel.status = status
  if status == 0 then
    View.Group_RightList.Group_CallingCard.Btn_CallingCard.Img_UnSelected.Img_Selected:SetActive(true)
    Controller.RefreshCardInfo()
    return
  end
  View.Group_Top.InputField_Search:SetText("")
  if status == 1 then
    if DataModel.searchFriend then
      DataModel.searchFriend = false
      DataModel.UpdateListData(1, DataModel.serverFriends)
    end
    View.Group_RightList.Group_List.Btn_List.Img_UnSelected.Img_Selected:SetActive(true)
    UpdateList(lastStatus, status)
    return
  end
  if status == 2 then
    if next(DataModel.AddList) == nil then
      Controller.GetRecommendFriend()
    else
      View.Group_RightList.Group_Add.Btn_Add.Img_UnSelected.Img_Selected:SetActive(true)
      UpdateList(lastStatus, status)
    end
    return
  end
  if status == 3 then
    View.Group_Top.InputField_Search:SetActive(false)
    View.Group_RightList.Group_Request.Btn_Request.Img_UnSelected.Img_Selected:SetActive(true)
    UpdateList(lastStatus, status)
    return
  end
  if status == 4 then
    View.Group_ListMain:SetActive(false)
    View.Group_Top:SetActive(false)
    View.Group_RightList.Group_Invite.Btn_Request.Img_UnSelected.Img_Selected:SetActive(true)
    View.Group_Invite:SetActive(true)
    View.Group_Invite.Group_Invite.Img_Copy.Txt_InvitationCode:SetText(DataModel.inviteCode)
    View.Group_Invite.Group_Invite.Group_Rewards.ScrollGrid_Rewards.grid.self:SetDataCount(#DataModel.inviteRewardList)
    View.Group_Invite.Group_Invite.Group_Rewards.ScrollGrid_Rewards.grid.self:RefreshAllElement()
    View.Group_Invite.Group_Inviter.Group_Rewards.ScrollGrid_Rewards.grid.self:SetDataCount(#DataModel.bindRewardList)
    View.Group_Invite.Group_Inviter.Group_Rewards.ScrollGrid_Rewards.grid.self:RefreshAllElement()
    View.Group_Invite.Group_Invitee.StaticGrid_Invitee.grid.self:RefreshAllElement()
    local isBind = DataModel.bindInviteCode ~= ""
    View.Group_Invite.Group_Inviter.InputField_InviteCode.Btn_Confirm:SetActive(not isBind)
    View.Group_Invite.Group_Inviter.InputField_InviteCode.Txt_Bind:SetActive(isBind)
    View.Group_Invite.Group_Inviter.InputField_InviteCode:SetText(DataModel.bindInviteCode)
    View.Group_Invite.Group_Inviter.InputField_InviteCode.Img.raycastTarget = not isBind
    return
  end
end

function Controller.CheckFriendCardInfo(idx)
  local data = DataModel.GetFriendData()[idx]
  if data == nil then
    return
  end
  DataModel.selectIdx = idx
  Controller.RefreshCardInfo()
end

local function VisitFriendsTrainCallback()
  local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
  if SliceSceneManager ~= nil then
    SliceSceneManager.loadedScene:Clear()
  end
  if MainManager.bgSceneName == "Home" then
    View.self:StartC(LuaUtil.cs_generator(function()
      LoadingManager:SetLoadingPercent(0.3)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      UIManager:Open("UI/Friends/FriendTrain", Json.encode({backScene = "Home"}))
      LoadingManager:SetLoadingPercent(0.8)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
      LoadingManager:SetLoadingPercent(1)
    end))
  else
    CBus:ChangeScene("Home", function()
      UIManager:Open("UI/Friends/FriendTrain", Json.encode({backScene = "Main"}))
    end)
  end
end

function Controller.CheckFriendTrain(idx)
  DataModel.selectIdx = idx
  local data = DataModel.GetFriendData()[DataModel.selectIdx]
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
    CommonTips.OpenLoading(nil, "", path, VisitFriendsTrainCallback)
  end, data.uid)
end

function Controller.AddFriend(idx)
  local data = DataModel.GetFriendData()[idx]
  if data == nil then
    return
  end
  DataModel.selectIdx = idx
  Net:SendProto("friend.add_request", function()
    View.self:SelectPlayAnim(View.Group_Top.Group_MessageItem.self, "SendMessage")
  end, data.uid)
end

function Controller.DelFriend()
  local data = DataModel.GetFriendData()[DataModel.selectIdx]
  if data == nil then
    return
  end
  Net:SendProto("friend.delete", function()
    View.Group_FriendsTip:SetActive(false)
    local removeUid = DataModel.FriendList[DataModel.selectIdx].uid
    table.remove(DataModel.FriendList, DataModel.selectIdx)
    DataModel.friendCnt = DataModel.friendCnt - 1
    UpdateList(-1, -1)
    for k, v in pairs(DataModel.serverFriends) do
      if k == removeUid then
        DataModel.serverFriends[k] = nil
        break
      end
    end
    View.Group_RightList.Group_List.Btn_List.Img_UnSelected.Txt_Num:SetText(DataModel.friendCnt .. "/" .. DataModel.friendMaxNum)
  end, data.uid)
end

function Controller.AgreeFriendRequest(idx)
  local data = DataModel.GetFriendData()[idx]
  if data == nil then
    return
  end
  DataModel.selectIdx = idx
  Net:SendProto("friend.accept_request", function(json)
    local data = DataModel.GetFriendData()[idx]
    for k, v in pairs(json.new_friend) do
      v.uid = k
      table.insert(DataModel.FriendList, v)
      DataModel.serverFriends[k] = v
    end
    table.remove(DataModel.ApplyList, idx)
    DataModel.friendCnt = DataModel.friendCnt + 1
    UpdateList(-1, -1)
    DataModel.applyRed = #DataModel.AddList > 0
    PlayerData:GetUserInfo().friend_ss = DataModel.applyRed == false and DataModel.inviteRed == false and 0 or 1
    View.Group_RightList.Group_Request.Img_Tips:SetActive(DataModel.applyRed)
    View.Group_RightList.Group_List.Btn_List.Img_UnSelected.Txt_Num:SetText(DataModel.friendCnt .. "/" .. DataModel.friendMaxNum)
  end, data.uid)
end

function Controller.RefuseFriendRequest(idx)
  local data = DataModel.GetFriendData()[idx]
  if data == nil then
    return
  end
  DataModel.selectIdx = idx
  Net:SendProto("friend.refuse_request", function()
    table.remove(DataModel.ApplyList, idx)
    DataModel.applyRed = #DataModel.AddList > 0
    PlayerData:GetUserInfo().friend_ss = DataModel.applyRed == false and DataModel.inviteRed == false and 0 or 1
    View.Group_RightList.Group_Request.Img_Tips:SetActive(DataModel.applyRed)
    UpdateList(-1, -1)
  end, data.uid)
end

function Controller.SetQQInfo()
  local qq = View.Group_FriendsInput.InputField_Penguin:GetText()
  Net:SendProto("main.contact", function()
    View.Group_FriendsInput:SetActive(false)
    PlayerData:GetUserInfo().qq = qq
    View.Group_CallingCard.Img_Imput.Txt_Number:SetText(PlayerData:GetUserInfo().qq)
  end, qq)
end

function Controller.SetRemark()
  local remark = View.Group_FriendsInput.InputField_Remark:GetText()
  local data = DataModel.GetFriendData()[DataModel.selectIdx]
  Net:SendProto("friend.remark", function()
    View.Group_FriendsInput:SetActive(false)
    data.remark = remark
    UpdateList(-1, -1)
  end, data.uid, remark)
end

function Controller.SearchFriend()
  local content = View.Group_Top.InputField_Search:GetText()
  if content == "" or content == nil then
    CommonTips.OpenTips(80608739)
    return
  end
  for i, v in ipairs(DataModel.FriendList) do
    if v.uid == content or v.role_name == content then
      CommonTips.OpenTips(80608787)
      return
    end
  end
  Net:SendProto("friend.search", function(json)
    DataModel.UpdateListData(2, json.search_info)
    View.Group_RightList.Group_Add.Btn_Add.Img_UnSelected.Img_Selected:SetActive(true)
    UpdateList(0, 1)
  end, content)
end

function Controller.GetRecommendFriend()
  Net:SendProto("friend.recommend", function(json)
    DataModel.UpdateListData(2, json.friends)
    View.Group_RightList.Group_Add.Btn_Add.Img_UnSelected.Img_Selected:SetActive(true)
    UpdateList(0, 1)
  end)
end

function Controller.SetShowCard()
  local count = #DataModel.showCardList
  local change = false
  for i = 1, count do
    if DataModel.showCardList[i] ~= PlayerData:GetUserInfo().sh_cards[i] then
      change = true
    end
  end
  if change == false then
    View.Group_CardChoose:SetActive(false)
    return
  end
  local data = ""
  if 0 < count then
    data = DataModel.showCardList[1]
  end
  for i = 2, count do
    data = data .. "," .. DataModel.showCardList[i]
  end
  Net:SendProto("main.set_card", function()
    View.Group_CardChoose:SetActive(false)
    PlayerData:GetUserInfo().sh_cards = Clone(DataModel.showCardList)
  end, data)
end

function Controller.MacthFriend()
  local content = View.Group_Top.InputField_Search:GetText()
  if content == "" or content == nil then
    CommonTips.OpenTips(80608739)
    return
  end
  local searchData = DataModel.serverFriends
  local data = {}
  for k, v in pairs(searchData) do
    if tonumber(content) then
      if string.find(k, content) ~= nil then
        v.uid = k
        table.insert(data, v)
      end
    elseif string.find(v.role_name, content) ~= nil then
      v.uid = k
      table.insert(data, v)
    end
  end
  DataModel.FriendList = data
  DataModel.searchFriend = true
  UpdateList(0, 1)
  if next(data) == nil then
    CommonTips.OpenTips(80608740)
    return
  end
end

function Controller.RefreshRewardItem(element, elementIndex, isBind)
  local data = DataModel.inviteRewardList[elementIndex]
  if isBind then
    data = DataModel.bindRewardList[elementIndex]
    element.Img_ItemMask:SetActive(DataModel.bindInviteCode ~= "")
  end
  local cfg = PlayerData:GetFactoryData(data.id)
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[cfg.qualityInt + 1])
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[cfg.qualityInt + 1])
  element.Img_Item:SetSprite(cfg.iconPath)
  element.Txt_Num:SetText(data.num)
  element.Btn_Item:SetClickParam(data.id)
end

function Controller.BindFriend()
  local code = View.Group_Invite.Group_Inviter.InputField_InviteCode:GetText()
  if code == "" or code == nil then
    CommonTips.OpenTips(80600225)
    return
  end
  Net:SendProto("friend.bond_other", function(json)
    DataModel.bindInviteCode = code
    local isBind = DataModel.bindInviteCode ~= ""
    View.Group_Invite.Group_Inviter.InputField_InviteCode.Btn_Confirm:SetActive(not isBind)
    View.Group_Invite.Group_Inviter.InputField_InviteCode.Txt_Bind:SetActive(isBind)
    View.Group_Invite.Group_Inviter.InputField_InviteCode:SetText(DataModel.bindInviteCode)
    View.Group_Invite.Group_Inviter.InputField_InviteCode.Img.raycastTarget = not isBind
    View.Group_Invite.Group_Inviter.Group_Rewards.ScrollGrid_Rewards.grid.self:RefreshAllElement()
    CommonTips.OpenShowItem(json.reward)
  end, code)
end

function Controller.RecBindReward(idx)
  local data = DataModel.inviteList[idx]
  local uid = data.uid
  Net:SendProto("friend.rcv_invitation_reward", function(json)
    CommonTips.OpenShowItem(json.reward)
    data.rcv = 1
    View.Group_Invite.Group_Invitee.StaticGrid_Invitee.grid.self:RefreshAllElement()
    DataModel.inviteRed = false
    for i, v in ipairs(DataModel.inviteList) do
      if v.rcv == 0 then
        DataModel.inviteRed = true
        break
      end
    end
    PlayerData:GetUserInfo().friend_ss = DataModel.applyRed == false and DataModel.inviteRed == false and 0 or 1
    View.Group_RightList.Group_Invite.Img_Tips:SetActive(DataModel.inviteRed)
  end, uid)
end

function Controller:RefreshHelpRoles(friendId)
  if friendId == nil then
    friendId = ""
  end
  View.Group_CallingCard.Group_HelpBattle.StaticGrid_RwardList.self:SetActive(false)
  DataModel.helpRoles = {}
  DataModel.helpSpineRoles = {}
  DataModel.curFriendId = friendId
  View.Group_CallingCard.Group_HelpBattle.StaticGrid_RoleList.self:SetActive(false)
  Net:SendProto("battle.help_info", function(json)
    local helpRoles = {}
    if DataModel.status == 0 then
      DataModel.helpRoles = json.help.help_roles
      for i = 1, #DataModel.helpRoles do
        if DataModel.helpRoles[i] ~= nil and DataModel.helpRoles[i] ~= "" then
          DataModel.helpSpineRoles[#DataModel.helpSpineRoles + 1] = DataModel.helpRoles[i]
        end
      end
      DataModel.rewardNum = json.help.reward_cnt or 0
      if 0 < DataModel.rewardNum then
        View.Group_CallingCard.Group_HelpBattle.StaticGrid_RwardList.self:SetActive(true)
        local helpBattleConfig = PlayerData:GetFactoryData(99900217)
        local rewardCount = math.min(#helpBattleConfig.helpBattleRewardList, 3)
        View.Group_CallingCard.Group_HelpBattle.StaticGrid_RwardList.grid.self:SetDataCount(rewardCount)
        View.Group_CallingCard.Group_HelpBattle.StaticGrid_RwardList.grid.self:RefreshAllElement()
      end
    else
      helpRoles = json.other_help.heros
      if helpRoles then
        for k, v in pairs(helpRoles) do
          v.id = k
          DataModel.helpRoles[#DataModel.helpRoles + 1] = v
          DataModel.helpSpineRoles[#DataModel.helpSpineRoles + 1] = v
        end
      end
    end
    View.Group_CallingCard.Group_HelpBattle.StaticGrid_RoleList.self:SetActive(true)
    View.Group_CallingCard.Group_HelpBattle.StaticGrid_RoleList.grid.self:RefreshAllElement()
    View.Group_CallingCard.Img_Train.StaticGrid_HelpRoleList.grid.self:SetDataCount(#DataModel.helpSpineRoles)
    View.Group_CallingCard.Img_Train.StaticGrid_HelpRoleList.grid.self:RefreshAllElement()
  end, friendId)
end

function Controller:OnSetRewardGrid(element, elementIndex)
  local helpBattleConfig = PlayerData:GetFactoryData(99900217)
  local rewardData = helpBattleConfig.helpBattleRewardList[elementIndex]
  element.Txt_Num:SetText(PlayerData:NumToFormatString(DataModel.rewardNum * rewardData.num))
  local rewardCA = PlayerData:GetFactoryData(rewardData.id)
  element.Img_Icon:SetSprite(rewardCA.tipsPath)
end

function Controller:OnSetHelpRoleGrid(element, elementIndex)
  local roleId = DataModel.helpRoles[elementIndex]
  if roleId == nil or roleId == "" then
    element.Img_Face:SetActive(false)
    element.Group_Lv:SetActive(false)
    element.Group_Awake:SetActive(false)
    element.StaticGrid_BK.self:SetActive(false)
    return
  end
  element.Img_Face:SetActive(true)
  element.Group_Lv:SetActive(true)
  element.Group_Awake:SetActive(true)
  element.StaticGrid_BK.self:SetActive(true)
  element.StaticGrid_BK.grid.self:SetDataCount(5)
  element.StaticGrid_BK.grid.self:RefreshAllElement()
  local roleData = roleId
  if DataModel.status == 0 then
    roleData = PlayerData:GetRoleById(roleId)
  else
    roleId = roleData.id
  end
  if next(roleData) == nil then
    return
  end
  local roleCA = PlayerData:GetFactoryData(roleId)
  if roleData.current_skin ~= nil then
    local portraitId = roleData.current_skin[1]
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Img_Face:SetSprite(portrailData.face)
  elseif roleData.skin_list ~= nil then
    local portraitId = next(roleData.skin_list)
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Img_Face:SetSprite(portrailData.face)
  else
    local portraitId = roleCA.viewId
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Img_Face:SetSprite(portrailData.face)
  end
  element.Group_Lv.Txt_Lv:SetText(roleData.lv)
  for i = 1, 5 do
    element.Group_Awake["Img_Awake_" .. i]:SetActive(false)
  end
  element.Group_Awake.Img_Awake_5_Golden:SetActive(false)
  local resonanceLv = roleData.resonance_lv
  if resonanceLv < 5 then
    element.Group_Awake["Img_Awake_" .. resonanceLv]:SetActive(true)
  elseif roleData.unlock_final_skill then
    element.Group_Awake.Img_Awake_5_Golden:SetActive(true)
  else
    element.Group_Awake.Img_Awake_5:SetActive(true)
  end
  local awakeLv = roleData.awake_lv
  for i = 1, 5 do
    element.StaticGrid_BK.grid[i].Img_On:SetActive(i <= awakeLv)
    element.StaticGrid_BK.grid[i].Img_Off:SetActive(i > awakeLv)
  end
end

function Controller:OnSetHelpRoleSpineGrid(element, elementIndex)
  local roleId = DataModel.helpSpineRoles[elementIndex]
  if roleId == nil or roleId == "" then
    return
  end
  local roleData = roleId
  if DataModel.status == 0 then
    roleData = PlayerData:GetRoleById(roleId)
  else
    roleId = roleData.id
  end
  local portraitId
  if roleData ~= nil and next(roleData) ~= nil and roleData.current_skin ~= nil then
    portraitId = roleData.current_skin[1]
  elseif roleData.skin_list ~= nil then
    portraitId = next(roleData.skin_list)
  else
    portraitId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
  end
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  element.self:SetData(portrailData.HomeresDir, "dorm_stand")
end

function Controller:GetHelpReward()
  Net:SendProto("battle.rec_help_reward", function(json)
    CommonTips.OpenShowItem(json.reward)
    View.Group_CallingCard.Group_HelpBattle.StaticGrid_RwardList.self:SetActive(false)
  end)
end

function Controller:InitView(initParams)
  ComBtnShareComp.InitButton(View.Btn_Share)
end

return Controller
