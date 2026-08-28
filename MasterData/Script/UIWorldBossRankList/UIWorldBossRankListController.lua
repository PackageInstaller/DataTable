local View = require("UIWorldBossRankList/UIWorldBossRankListView")
local DataModel = require("UIWorldBossRankList/UIWorldBossRankListDataModel")
local Controller = {}

function Controller:Init(activityId)
  DataModel.activityId = activityId
  local actCA = PlayerData:GetFactoryData(activityId)
  if actCA == nil then
    return
  end
  local rankList = {}
  local normalList = actCA.bossNormalList
  for i = 1, #normalList do
    rankList[#rankList + 1] = normalList[i].id
  end
  local finalList = actCA.bossFinalList
  for i = 1, #finalList do
    rankList[#rankList + 1] = finalList[i].id
  end
  DataModel.rankList = rankList
  DataModel.curTab = nil
  View.Group_Tab.ScrollGrid_Tab.grid.self:SetDataCount(#rankList)
  DataModel.QuickClickTime = 10
  Controller:SetTab(1)
end

function Controller:SetBossElement(element, elementIndex)
  local rankId = DataModel.rankList[elementIndex]
  if rankId == nil then
    return
  end
  local bossData = PlayerData:GetFactoryData(rankId)
  element.Txt_Name:SetText(bossData.name)
  if elementIndex == DataModel.curTab then
    element.Img_:SetSprite(DataModel.SelectBg[1])
  else
    element.Img_:SetSprite(DataModel.SelectBg[2])
  end
  element.Btn_:SetClickParam(elementIndex)
end

function Controller:SetTab(idx)
  if DataModel.QuickClickTime < DataModel.QuickClickLimit then
    CommonTips.OpenTips(80601254)
    return
  end
  if idx == DataModel.curTab then
    return
  end
  DataModel.curTab = idx
  local rankId = DataModel.rankList[idx]
  if rankId == nil then
    return
  end
  View.Group_Tab.ScrollGrid_Tab.grid.self:RefreshAllElement()
  local bossData = PlayerData:GetFactoryData(rankId)
  local rankCfg = PlayerData:GetFactoryData(bossData.rankId)
  View.Group_Rank.Group_Top.Txt_EngName:SetText(bossData.nameE)
  View.Group_Rank.Group_Top.Txt_Name:SetText(bossData.name)
  View.Group_Reward:SetActive(#bossData.rankRewardList > 0)
  if #bossData.rankRewardList > 0 then
    View.Group_Reward.Group_Reward.Txt_Title:SetText(string.format(GetText(80610559), bossData.rankRewardList[1].rank))
    if #bossData.rankRewardList > 1 then
      local titleTextTransoform = View.Group_Reward.Group_Reward.Txt_Title.transform.localPosition
      local tipsTextTransoform = View.Group_Reward.Group_Reward.Txt_Tips.transform.localPosition
      titleTextTransoform.x = 156.8 - (#bossData.rankRewardList - 1) * 120
      tipsTextTransoform.x = 112.6 - (#bossData.rankRewardList - 1) * 120
      View.Group_Reward.Group_Reward.Txt_Title.transform.localPosition = titleTextTransoform
      View.Group_Reward.Group_Reward.Txt_Tips.transform.localPosition = tipsTextTransoform
      View.Group_Reward.Group_Reward.StaticGrid_Reward.grid.self:SetDataCount(2)
    else
      local titleTextTransoform = View.Group_Reward.Group_Reward.Txt_Title.transform.localPosition
      local tipsTextTransoform = View.Group_Reward.Group_Reward.Txt_Tips.transform.localPosition
      titleTextTransoform.x = 156.8
      tipsTextTransoform.x = 112.6
      View.Group_Reward.Group_Reward.Txt_Title.transform.localPosition = titleTextTransoform
      View.Group_Reward.Group_Reward.Txt_Tips.transform.localPosition = tipsTextTransoform
      View.Group_Reward.Group_Reward.StaticGrid_Reward.grid.self:SetDataCount(1)
    end
    View.Group_Reward.Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  end
  DataModel.isRanking = true
  Net:SendProto("main.roll_rank", function(json)
    local cacheData = {}
    cacheData.has_more = json.has_more
    cacheData.request_id = json.request_id
    cacheData.next_index = json.next_index
    DataModel.rankCache = cacheData
    DataModel.QuickClickTime = 0
    DataModel.CurDetailInfo = json.rank_list
    DataModel.rankElements = {}
    local serverNum = json.total_members
    if serverNum == 0 then
      View.Group_Rank.Group_List.Group_Empty:SetActive(true)
      View.Group_Rank.Group_List.Group_Oneself:SetActive(false)
      View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetActive(false)
      return
    end
    View.Group_Rank.Group_List.Group_Empty:SetActive(false)
    View.Group_Rank.Group_List.Group_Oneself:SetActive(true)
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetActive(true)
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetDataCount(serverNum)
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:MoveToTop()
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_Rank.Group_List.Group_Empty:SetActive(serverNum == 0)
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
    Controller:SetOneElement(View.Group_Rank.Group_List.Group_Oneself, t)
    DataModel.isRanking = false
  end, rankCfg.rankType, "forever", "", rankCfg.peopleNum, nil, nil, rankId)
end

function Controller:AddRollRank()
  if DataModel.isRanking then
    return
  end
  local idx = DataModel.curTab
  local rankId = DataModel.rankList[idx]
  if rankId == nil then
    return
  end
  local bossData = PlayerData:GetFactoryData(rankId)
  local rankCfg = PlayerData:GetFactoryData(bossData.rankId)
  DataModel.isRankIng = true
  Net:SendProto("main.roll_rank", function(json)
    if json.status and json.status == 1 then
      Controller:SelectTab(idx)
      return
    end
    DataModel.QuickClickTime = 0
    for i = 1, #json.rank_list do
      DataModel.CurDetailInfo[DataModel.rankCache.next_index + i] = json.rank_list[i]
    end
    local cacheData = {}
    cacheData.has_more = json.has_more
    cacheData.request_id = json.request_id
    cacheData.next_index = json.next_index
    DataModel.rankCache = cacheData
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
    DataModel.isRanking = false
  end, rankCfg.rankType, "forever", "", rankCfg.peopleNum, DataModel.rankCache.request_id, DataModel.rankCache.next_index, rankId)
end

function Controller:SetRankElement(element, elementIndex)
  local info = DataModel.CurDetailInfo[elementIndex]
  if info ~= nil then
    self:SetOneElement(element, info)
    DataModel.rankElements[elementIndex] = element
  elseif elementIndex == DataModel.rankCache.next_index + 1 then
    Controller:AddRollRank()
  end
end

function Controller:SetOneElement(element, info)
  local sortValue = info.rank
  local numValue = math.floor(info.val + 0.5)
  local bgIdx = math.min(sortValue, 4)
  if sortValue == 0 then
    bgIdx = 4
  end
  element.Img_BG:SetSprite(DataModel.RankBg[bgIdx])
  element.Txt_Order:SetActive(4 <= bgIdx)
  if sortValue == 0 or numValue <= 0 then
    sortValue = GetText(80601253)
  elseif info.self and sortValue > info.rankNumMax then
    sortValue = string.format(GetText(80601252), info.rankNumMax)
  end
  if sortValue == 0 then
    element.Txt_Order:SetText("- -")
  else
    element.Txt_Order:SetText(sortValue)
  end
  if info.avatar ~= "" and 0 < info.avatar then
    local headId = tonumber(info.avatar)
    local photoFactory = PlayerData:GetFactoryData(headId, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      element.Btn_ProfilePhoto.Img_Head:SetSprite(photoFactory.imagePath)
      CommonTips:SetPlayerHeadShader(element.Btn_ProfilePhoto.Img_spAdd, photoFactory)
    end
  end
  element.Btn_ProfilePhoto:SetClickParam(info.uid)
  element.Group_Grade.Txt_Grade:SetText(info.lv)
  element.Txt_Name:SetText(info.role_name)
  if element.Txt_Name.Img_Oneself then
    element.Txt_Name.Img_Oneself:SetActive(not info.self and info.uid == PlayerData:GetUserInfo().uid)
  end
  element.Group_Content.Txt_Num:SetText(DataModel.SimpleDamageValue(numValue))
end

function Controller:OpenFriends(uid)
  UIManager:Open("UI/Friends/Friends", Json.encode({uid = uid}))
end

return Controller
