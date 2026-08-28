local DataModel = require("UIWitchesRanking/UIWitchesRankingDataModel")
local View = require("UIWitchesRanking/UIWitchesRankingView")
local Controller = {}

function Controller:Init()
  Controller:RefreshRankReward()
  Controller.RefreshGiveLike()
  Controller:SelectTab(DataModel.CurTab)
  local cfg = PlayerData:GetFactoryData(86000051)
  View.Group_RankRewards.Group_Reward.Group_Reward.Txt_Title:SetText(string.format(GetText(80610559), cfg.rankingReward[1].rank))
end

function Controller:SetRewardElement(element, elementIndex)
  local reward = DataModel.RewardList[elementIndex]
  local rewardCfg = PlayerData:GetFactoryData(reward.id)
  element.Img_Item:SetSprite(rewardCfg.tipsPath)
  element.Txt_Num:SetText(rewardCfg.num)
  element.Btn_Item:SetClickParam(reward.id)
end

function Controller:RefreshRankReward()
  View.Group_RankRewards.Group_Reward.Group_Reward.StaticGrid_Reward.grid.self:SetDataCount(#DataModel.RewardList)
  View.Group_RankRewards.Group_Reward.Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
end

function Controller:TabElementClick(btn, str)
  local idx = tonumber(str)
  if DataModel.CurTab == idx then
    return
  end
  Controller:SelectTab(idx)
  View.Group_Tab.ScrollGrid_Tab.grid.self:RefreshAllElement()
end

function Controller:SelectTab(idx)
  if DataModel.QuickClickTime < DataModel.QuickClickLimit then
    CommonTips.OpenTips(80601254)
    return
  end
  idx = tonumber(idx)
  DataModel.CurTab = idx
  if idx == 1 then
    local rankCfg = PlayerData:GetFactoryData(DataModel.RankDailyId)
    local rankType = rankCfg.rankType
    local timeTypeStr = "daily"
    Net:SendProto("main.rank", function(json)
      DataModel.QuickClickTime = 0
      DataModel.dailyRankList = json.rank_list
      DataModel.rankElements = {}
      local serverNum = #DataModel.dailyRankList
      View.Group_RankRewards.Group_RankList.Group_Empty:SetActive(serverNum == 0)
      View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:SetActive(0 < serverNum)
      if 0 < serverNum then
        View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:SetDataCount(serverNum)
        View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:RefreshAllElement()
      end
      local t = {}
      local my_rank = json.my_rank
      t.rank = my_rank and my_rank.rank or 0
      t.val = my_rank and my_rank.val or 0
      t.user_seal = my_rank and my_rank.user_seal or {}
      t.rids = my_rank and my_rank.rids or {}
      DataModel.myRank = my_rank and my_rank.rank or 0
      t.avatar = PlayerData:GetUserInfo().avatar
      t.role_name = PlayerData:GetUserInfo().role_name or ""
      t.rankNumMax = rankCfg.rankNumMax
      t.lv = PlayerData:GetPlayerLevel()
      t.self = true
      Controller:SetOneElement(View.Group_RankRewards.Group_RankList.Group_Self, t)
      Controller:RefreshSelfGiveLike()
    end, rankType, timeTypeStr, nil, nil, rankCfg.peopleNum)
  elseif idx == 2 then
    DataModel.rankElements = {}
    local serverNum = #DataModel.serverRankList
    View.Group_RankRewards.Group_RankList.Group_Empty:SetActive(serverNum == 0)
    View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:SetActive(0 < serverNum)
    if 0 < serverNum then
      View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:SetDataCount(DataModel.showLimitIndex)
      View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:RefreshAllElement()
    end
    local rankCfg = PlayerData:GetFactoryData(DataModel.RankForeverId)
    local t = {}
    local my_rank = DataModel.severSelfRank
    t.rank = my_rank and my_rank.rank or 0
    t.val = my_rank and my_rank.val or 0
    t.user_seal = my_rank and my_rank.user_seal or {}
    t.rids = my_rank and my_rank.rids or {}
    DataModel.myRank = my_rank and my_rank.rank or 0
    t.avatar = PlayerData:GetUserInfo().avatar
    t.role_name = PlayerData:GetUserInfo().role_name or ""
    t.rankNumMax = rankCfg.rankNumMax
    t.lv = PlayerData:GetPlayerLevel()
    t.self = true
    Controller:SetOneElement(View.Group_RankRewards.Group_RankList.Group_Self, t)
    Controller:RefreshSelfGiveLike()
  end
  View.Group_RankRewards.Group_Tab.Btn_Day.Img_Off:SetActive(idx ~= 1)
  View.Group_RankRewards.Group_Tab.Btn_Day.Img_On:SetActive(idx == 1)
  View.Group_RankRewards.Group_Tab.Btn_All.Img_Off:SetActive(idx ~= 2)
  View.Group_RankRewards.Group_Tab.Btn_All.Img_On:SetActive(idx == 2)
  View.Group_RankRewards.Txt_DailyTip:SetActive(idx == 1)
  View.Group_RankRewards.Group_Reward:SetActive(idx == 2)
end

function Controller:SetRankElement(element, elementIndex)
  local rankList = DataModel.GetRankList()
  local info = rankList[elementIndex]
  self:SetOneElement(element, info)
  self:RefreshElementGiveLike(element, elementIndex)
  DataModel.rankElements[elementIndex] = element
end

function Controller:SetOneElement(element, info)
  local sortValue = info.rank
  local numValue = math.floor(info.val + 0.5)
  element.Img_BG.Img_No1:SetActive(sortValue == 1)
  element.Img_BG.Img_No2:SetActive(sortValue == 2)
  element.Img_BG.Img_No3:SetActive(sortValue == 3)
  element.Img_BG.Img_No4:SetActive(4 <= sortValue or sortValue == 0)
  if sortValue == 0 or numValue <= 0 then
    sortValue = GetText(80601253)
  elseif info.self and sortValue > info.rankNumMax then
    sortValue = string.format(GetText(80601252), info.rankNumMax)
  end
  if sortValue == 0 then
    element.Img_BG.Img_No4.Txt_Num:SetText("- -")
  else
    element.Img_BG.Img_No4.Txt_Num:SetText(sortValue)
  end
  if info.avatar ~= "" and 0 < info.avatar then
    local headId = tonumber(info.avatar)
    local photoFactory = PlayerData:GetFactoryData(headId, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      element.Group_Head.Img_ProfilePhoto.Img_Head:SetSprite(photoFactory.imagePath)
      CommonTips:SetPlayerHeadShader(element.Group_Head.Img_ProfilePhoto.Img_spAdd, photoFactory)
    end
  end
  element.Txt_Name:SetText(info.role_name)
  if element.Txt_Name.Img_Oneself then
    element.Txt_Name.Img_Oneself:SetActive(not info.self and info.uid == PlayerData:GetUserInfo().uid)
  end
  element.Group_Damage.Txt_Num:SetText(DataModel.SimpleDamageValue(numValue))
  element.Group_Head.Btn_Click:SetClickParam(info.uid)
  DataModel.CurInfoSeal = Clone(info.user_seal)
  DataModel.CurTeamInfo = {}
  for i, v in pairs(info.rids) do
    table.insert(DataModel.CurTeamInfo, {roleId = i, viewId = v})
  end
  element.StaticGrid_Seal.grid.self:SetDataCount(4)
  element.StaticGrid_Seal.grid.self:RefreshAllElement()
  element.StaticGrid_Team.grid.self:SetDataCount(table.count(DataModel.CurTeamInfo))
  element.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:SetSealElement(element, elementIndex)
  local seal = DataModel.CurInfoSeal[elementIndex]
  element.Img_icon:SetActive(seal)
  if seal then
    local cfg = PlayerData:GetFactoryData(seal)
    element.Img_icon:SetSprite(cfg.iconPath)
  end
end

function Controller:SetTeamElement(element, elementIndex)
  local data = DataModel.CurTeamInfo[elementIndex]
  local viewCfg = PlayerData:GetFactoryData(data.viewId)
  element.Img_ProfilePhoto.Img_Head:SetSprite(viewCfg.face)
end

function Controller:RefreshElementGiveLike(element, elementIndex)
  local rankList = DataModel.GetRankList()
  local rankData = rankList[elementIndex]
  element:SetActive(true)
  element.Group_Likes:SetActive(rankData.uid ~= PlayerData:GetUserInfo().uid)
  element.Group_Likes:SetEnableAnimator(false)
  if element.Group_Likes.IsActive then
    local isGiveLike = PlayerData.IsGiveLike(rankData.uid)
    element.Group_Likes.Group_Unlike:SetActive(not isGiveLike)
    element.Group_Likes.Group_Liked:SetActive(isGiveLike)
    element.Group_Likes.Group_Unlike.Btn_:SetClickParam(elementIndex)
    element.Group_Likes.Group_Liked.Group_Likes_effect_blue:SetOrder(View.self.CurrOrder)
    element.Group_Likes.Group_Liked.Group_Likes_effect_blue:SetActive(false)
    element.Group_Likes.Group_Liked:SetLocalScale(1, 1, 1)
    element.Group_Likes.Group_Liked:SetAnchoredPositionY(1)
    element.Group_Likes.Group_Liked.transform.localRotation = Quaternion.Euler(0, 0, 0)
  end
  element.Img_LikesNum.Txt_:SetText(rankData.being_like_count)
end

function Controller:RefreshSelfGiveLike()
  View.Group_RankRewards.Group_RankList.Group_Self.Img_LikesNum.Txt_:SetText(PlayerData:GetUserInfo().being_like_count)
end

function Controller.RefreshGiveLike()
  local num, maxNum = PlayerData.GetGiveLikeNum()
  View.Group_RankRewards.Group_LikesNum.Group_NumLikes.Txt_:SetText(string.format(GetText(80609549), num, maxNum))
end

function Controller.RollGetServerRankData()
  local rankId = DataModel.RankForeverId
  local rankCA = PlayerData:GetFactoryData(rankId, "RankFactory")
  local levelTween = WitchData.GetSelfLevelTween(rankId)
  local cacheInfo = DataModel.serveRankCacheInfo
  Net:SendProto("main.roll_rank", function(json)
    for i, v in pairs(json.rank_list) do
      table.insert(DataModel.serverRankList, v)
    end
    DataModel.RefreshServerRankCacheInfo(json)
    DataModel.RefreshSeverRankShowLimitNum(json.has_more)
    View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:SetDataCount(DataModel.showLimitIndex)
    View.Group_RankRewards.Group_RankList.ScrollGrid_RankList.grid.self:RefreshAllElement()
  end, rankCA.rankType, rankCA.timeType, levelTween, rankCA.peopleNum, cacheInfo.request_id, cacheInfo.next_index)
end

return Controller
