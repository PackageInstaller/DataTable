local DataModel = {}

function DataModel.init(friends, requests)
  DataModel.cardDataList = {}
  DataModel.selectCardId = -1
  DataModel.showCardList = Clone(PlayerData:GetUserInfo().sh_cards)
  DataModel.cardCnt = #DataModel.showCardList
  DataModel.maxCardCnt = 7
  DataModel.PlayerInfoList = {}
  DataModel.serverFriends = friends
  DataModel.FriendList = DataModel.UpdateListData(1, friends)
  DataModel.friendCnt = #DataModel.FriendList
  DataModel.searchFriend = false
  DataModel.AddList = {}
  DataModel.ApplyList = DataModel.UpdateListData(3, requests)
  DataModel.selectIdx = -1
  DataModel.applyRed = #DataModel.ApplyList > 0
  local friendCfg = PlayerData:GetFactoryData(99900192)
  DataModel.friendMaxNum = friendCfg.maxNum
  DataModel.showQQInfo = friendCfg.isNumberOpen
  DataModel.inviteLimit = friendCfg.inviteLimit
  DataModel.bindRewardList = friendCfg.bindRewardList
  DataModel.inviteRewardList = friendCfg.inviteRewardList
  DataModel.inviteList = {}
  DataModel.inviteRed = false
  for k, v in pairs(DataModel.serverInviteData) do
    v.uid = k
    table.insert(DataModel.inviteList, v)
    if v.rcv == 0 then
      DataModel.inviteRed = true
    end
  end
  DataModel.status = -1
end

function DataModel.GetFriendData()
  if DataModel.status == 1 then
    return DataModel.FriendList
  elseif DataModel.status == 2 then
    return DataModel.AddList
  elseif DataModel.status == 3 then
    return DataModel.ApplyList
  elseif DataModel.status == 5 then
    return DataModel.playerData
  end
  return DataModel.FriendList
end

function DataModel.UpdateListData(status, data)
  local nowData = {}
  if data then
    if status == 1 then
      DataModel.FriendList = nowData
    elseif status == 2 then
      DataModel.AddList = nowData
    else
      DataModel.ApplyList = nowData
    end
    for k, v in pairs(data) do
      v.uid = k
      table.insert(nowData, v)
    end
  end
  table.sort(nowData, function(t1, t2)
    local date1 = os.date("*t", t1.login_time)
    local date2 = os.date("*t", t1.login_time)
    if date1.year == date2.year and date1.month == date2.month and date1.day == date2.day and t1.lv ~= t2.lv then
      return t1.lv > t2.lv
    end
    if t1.login_time ~= t2.login_time then
      return t1.login_time > t2.login_time
    end
    return false
  end)
  return nowData
end

function DataModel.CardIsSelect(cardId)
  for i, v in ipairs(DataModel.showCardList) do
    if tonumber(v) == cardId then
      return true, i
    end
  end
  return false, -1
end

function DataModel.UpdateShowCardList(cardId, suitIdx)
  if suitIdx then
    local cnt = 0
    local data = DataModel.cardDataList[suitIdx]
    for i, v in ipairs(data.list) do
      cnt = cnt + 1
      DataModel.showCardList[cnt] = v
    end
    data = DataModel.cardDataList[suitIdx + 1]
    if data and data.ShowTitle == false then
      for i, v in ipairs(data.list) do
        if cnt < DataModel.maxCardCnt then
          cnt = cnt + 1
          DataModel.showCardList[cnt] = v
        end
      end
    end
    for i = cnt + 1, DataModel.maxCardCnt do
      DataModel.showCardList[i] = nil
    end
    DataModel.cardCnt = cnt
    DataModel.selectCardId = -1
    return
  end
  local idx = -1
  for k, v in pairs(DataModel.showCardList) do
    if tonumber(v) == cardId then
      idx = k
      break
    end
  end
  if idx == -1 then
    if DataModel.cardCnt < DataModel.maxCardCnt then
      table.insert(DataModel.showCardList, cardId)
      DataModel.cardCnt = DataModel.cardCnt + 1
    end
  else
    table.remove(DataModel.showCardList, idx)
    DataModel.cardCnt = DataModel.cardCnt - 1
  end
end

function DataModel.CardIsOwn(cardId)
  local isOwn = false
  local cardList = PlayerData.ServerData.books.card_pack or {}
  if cardList[tostring(cardId)] then
    isOwn = true
  end
  return isOwn
end

function DataModel.SetCardList()
  if next(DataModel.cardDataList) then
    return
  end
  local cardPackList = PlayerData:GetFactoryData(99900065).cardPackList
  local index = 0
  local itemHeight1 = 340
  local itemHeight2 = 278
  local spaceX = 0
  local top = 0
  local bottom = 368
  local currentTimeStamp = TimeUtil.GetServerTimeStamp()
  for i, v in ipairs(cardPackList) do
    if currentTimeStamp >= TimeUtil:TimeStamp(v.startTime) then
      local cardPackId = v.id
      local cfg = PlayerData:GetFactoryData(cardPackId)
      local count = 0
      local cardList = {}
      local isOwn = DataModel.CardIsOwn(cfg.topCard)
      if isOwn then
        table.insert(cardList, cfg.topCard)
        count = count + 1
      end
      for i, v in ipairs(cfg.otherCardList) do
        local isOwn = DataModel.CardIsOwn(v.id)
        if isOwn then
          count = count + 1
          table.insert(cardList, v.id)
        end
      end
      local maxNum = 4
      local row = math.ceil(count / maxNum)
      for i = 1, row do
        local pos = DataModel.cardDataList[index] and DataModel.cardDataList[index].pos or 0
        index = index + 1
        if i == 1 then
          if index == 1 then
            pos = 0
            pos = -top
          else
            pos = pos - itemHeight1 - spaceX
          end
        else
          pos = pos - itemHeight2 - spaceX
        end
        local data = {
          list = {},
          cardPackId = cardPackId,
          ShowTitle = i == 1,
          pos = pos,
          id = index
        }
        for i2 = 1, maxNum do
          table.insert(data.list, cardList[i2 + (i - 1) * maxNum])
        end
        DataModel.cardDataList[index] = data
      end
    end
  end
  if 0 < index then
    DataModel.height = -DataModel.cardDataList[index].pos + itemHeight1 + 191
    DataModel.height = -DataModel.cardDataList[index].pos + itemHeight1 + bottom
  end
end

function DataModel.GetHeadTrainSkinPath(skinId)
  local path = ""
  if skinId then
    local skinList = PlayerData:GetFactoryData(81200024).skinList
    for i, v in ipairs(skinList) do
      if v.id == skinId then
        path = v.skinshow
        break
      end
    end
  else
    local coach = PlayerData:GetHomeInfo().coach or {}
    if coach[1] then
      local skinId = tonumber(coach[1].skin)
      local skinList = PlayerData:GetFactoryData(81200024).skinList
      for i, v in ipairs(skinList) do
        if v.id == skinId then
          path = v.skinshow
          break
        end
      end
    end
  end
  return path
end

function DataModel.GetUID(uid)
  uid = uid and uid or PlayerData:GetUserInfo().uid
  return "UID:" .. uid
end

function DataModel.GetFashionNum(num)
  return num and num or PlayerData:GetUserInfo().fashion
end

function DataModel.GetPlayerName(name)
  return name and name or PlayerData:GetUserInfo().role_name
end

function DataModel.GetGold(gold)
  return gold and gold or PlayerData:GetUserInfo().gold
end

function DataModel.GetHeadPath(avatar, gender)
  local avatar = avatar and avatar or PlayerData:GetUserInfo().avatar
  if avatar == "" then
    local gender = gender or 1
    local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if head ~= nil and head.playerHeadList ~= nil then
      return head.playerHeadList[gender + 1].playerHeadPath, nil
    end
  end
  local photoFactory = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
  if photoFactory ~= nil then
    return photoFactory.imagePath, photoFactory
  end
  return "", nil
end

function DataModel.GetPlayerLV(lv)
  return lv and lv or PlayerData:GetUserInfo().lv
end

function DataModel.GetTotalRep(rep)
  if rep then
    return math.floor(rep)
  end
  local totalRep = 0
  local homeCommon = require("Common/HomeCommon")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.stationList) do
    local stationCA = PlayerData:GetFactoryData(v.id, "HomeStationFactory")
    if stationCA.isShowRep then
      local rep = homeCommon.GetReputationValue(v.id)
      totalRep = totalRep + rep
    end
  end
  return totalRep
end

function DataModel.GetTradeLv(trade_lv)
  return trade_lv and trade_lv or PlayerData:GetHomeInfo().trade_lv
end

function DataModel.GetGoodsNum(goodsNum)
  return goodsNum and goodsNum or PlayerData:GetUserInfo().space_info.max_train_goods_num
end

function DataModel.GetMileageNum(mileage)
  local disRatio = PlayerData:GetFactoryData(99900014).disRatio
  if mileage then
    return math.floor(mileage * disRatio) .. "km"
  end
  local mileageNum = math.floor((PlayerData:GetHomeInfo().drive_distance or 0) * disRatio)
  return mileageNum .. "km"
end

function DataModel.GetTodayMileageNum(mileage)
  if mileage == "" or mileage == nil then
    mileage = 0
  end
  local disRatio = PlayerData:GetFactoryData(99900014).disRatio
  return math.ceil(mileage * disRatio) .. "km"
end

function DataModel.GetRoleInfo(roleNum, skinNum)
  if roleNum then
    return roleNum, skinNum
  end
  local roleNum = 0
  local skinNum = 0
  for k, v in pairs(PlayerData:GetRoles()) do
    roleNum = roleNum + 1
    for k, v in pairs(v.skin_list) do
      skinNum = skinNum + 1
    end
    skinNum = skinNum - 1
  end
  return roleNum, skinNum
end

function DataModel.GetMaxSpeed(maxSpeed)
  local speed = maxSpeed and maxSpeed or PlayerData.GetCoachMaxSpeed()
  return speed .. "km/h"
end

function DataModel.GetTrainSkinNum(SkinNum)
  if SkinNum then
    return SkinNum
  end
  local cnt = 0
  local skinItemList = PlayerData:GetFactoryData(99900044).skinItemList
  for i, v in ipairs(skinItemList) do
    local num = PlayerData:GetGoodsById(v.id).num
    if 0 < num then
      cnt = cnt + 1
    end
  end
  local coach = PlayerData:GetHomeInfo().coach or {}
  local head = coach[1]
  if head then
    local skin_house = head.skin_house or {}
    cnt = cnt + #skin_house
  end
  return cnt
end

function DataModel.GetCityName(cityId)
  if cityId then
    local stationCfg = PlayerData:GetFactoryData(cityId) or {}
    return stationCfg.name or GetText(80607961)
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 2 then
    local CurStayCity = require("UIHome/UIHomeTradeDataModel").CurStayCity
    return PlayerData:GetFactoryData(CurStayCity).name
  end
  return GetText(80607961)
end

function DataModel.GetShowCardList()
  if DataModel.status == 0 then
    return DataModel.showCardList
  end
  return DataModel.GetFriendData()[DataModel.selectIdx].cards
end

function DataModel.GetLoginTimeInfo(timestamp)
  local current_time = TimeUtil:GetServerTimeStamp()
  local diff = current_time - timestamp
  local one_day = 86400
  local timetable = os.date("*t", current_time)
  local today = os.time({
    year = timetable.year,
    month = timetable.month,
    day = timetable.day,
    hour = 0,
    minute = 0,
    second = 0
  })
  local yesterday = today - one_day
  if timestamp >= today then
    return GetText(80607904)
  elseif timestamp >= yesterday then
    return GetText(80608580)
  else
    local days = math.floor(diff / one_day)
    local years = math.floor(days / 365)
    if 1 <= years then
      return string.format(GetText(80608591), years)
    else
      return string.format(GetText(80608590), days)
    end
  end
end

function DataModel.GetProfitDaily(profit_daily)
  return profit_daily and profit_daily or DataModel.profit_daily or 0
end

return DataModel
