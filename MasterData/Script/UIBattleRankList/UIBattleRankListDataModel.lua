local View = require("UIBattleRankList/UIBattleRankListView")
local DataModel = {}
DataModel.stationId = nil
DataModel.serverRankList = {}
DataModel.serverSelfRank = {}
DataModel.levelAreaList = {}
DataModel.selectLevelAreaSelfRankData = nil
DataModel.levelAreaIndex = nil
DataModel.levelAreaElementList = {}
DataModel.rankBgList = {
  "UI/RankList/first_bg",
  "UI/RankList/second_bg",
  "UI/RankList/third_bg"
}
DataModel.defaultRankBg = "UI/RankList/other_bg"
DataModel.rankElements = {}
DataModel.giveLiveC = nil

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.serverRankList = data.rankList or {}
  DataModel.serverSelfRank = data.selfRank
  DataModel.stationId = data.stationId
  DataModel.lastIdx = data.lastIdx
end

function DataModel.SortServerData()
  if #DataModel.serverRankList > 0 then
    table.sort(DataModel.serverRankList, function(a, b)
      if a.val == b.val then
        return a.update_ts < b.update_ts
      end
      return a.val > b.val
    end)
  end
  for i, v in ipairs(DataModel.serverRankList) do
    v.rank = i
    if tostring(v.uid) == PlayerData:GetUserInfo().uid then
      local rankData = DataModel.GetCurLevelSelfRankData()
      if rankData then
        rankData.rank = i
      end
    end
  end
end

function DataModel.InitData()
  DataModel.levelAreaList = {}
  DataModel.selectLevelAreaSelfRankData = nil
  DataModel.levelAreaIndex = nil
  DataModel.levelAreaElementList = {}
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  local isOneBased = rankCA.sectionType == "onebased"
  for i, v in ipairs(rankCA.gradeSectionList) do
    local minLevel
    if isOneBased then
      minLevel = 1
    elseif i == 1 then
      minLevel = 1
    else
      minLevel = rankCA.gradeSectionList[i - 1].grade + 1
    end
    table.insert(DataModel.levelAreaList, {
      minLevel = minLevel,
      maxLevel = v.grade
    })
  end
end

function DataModel.RefreshOnShow()
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  View.Group_Rank.Group_Top.Txt_Name:SetText(rankCA.name)
  View.Group_Rank.Group_Top.Txt_EngName:SetText(rankCA.nameEN)
  View.Group_Rank.Group_List.Txt_Time:SetText(rankCA.rankName)
  View.Group_Rank.Group_Top.Img_BG:SetSprite(rankCA.titlePng)
  View.Group_Rank.Group_Top.Group_Section.Group_Show:SetActive(rankCA.isInquireArea)
  View.Group_Rank.Group_Top.Group_Section.Btn_Click:SetActive(rankCA.isInquireArea)
  View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_Show:SetActive(true)
  View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_NotShow:SetActive(false)
  View.Group_Rank.Group_Top.Btn_CloseToggleArea:SetActive(false)
  View.Group_Rank.Group_Top.Group_ToggleArea:SetActive(false)
  local userLv = PlayerData:GetUserInfo().lv
  if DataModel.lastIdx then
    DataModel.SelectLevelArea(DataModel.lastIdx)
  else
    for i, v in ipairs(DataModel.levelAreaList) do
      if userLv >= v.minLevel and userLv <= v.maxLevel then
        DataModel.SelectLevelArea(i)
        break
      end
    end
  end
  View.Img_GiveLikeMask:SetActive(false)
  DataModel.RefreshGiveLike()
end

function DataModel.SelectLevelArea(areaIndex)
  if DataModel.levelAreaIndex == areaIndex then
    return
  end
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  if DataModel.levelAreaIndex then
    local ctr = DataModel.levelAreaElementList[DataModel.levelAreaIndex]
    if ctr then
      ctr.Group_On:SetActive(false)
      ctr.Group_Off:SetActive(true)
    end
  end
  local ctr = DataModel.levelAreaElementList[areaIndex]
  if ctr then
    ctr.Group_On:SetActive(true)
    ctr.Group_Off:SetActive(false)
  end
  DataModel.levelAreaIndex = areaIndex
  DataModel.selectLevelAreaSelfRankData = DataModel.GetSelfRankDataByLevelAreaIndex(DataModel.levelAreaIndex)
  local info = DataModel.levelAreaList[areaIndex]
  local areaTxt = string.format(GetText(80601250), info.minLevel, info.maxLevel)
  View.Group_Rank.Group_Top.Group_Section.Txt_Grade:SetText(areaTxt)
  DataModel.ShowSelfRank(areaIndex)
  local dataCount = #DataModel.serverRankList > rankCA.peopleNum and rankCA.peopleNum or #DataModel.serverRankList
  DataModel.rankElements = {}
  View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetDataCount(dataCount)
  View.Group_Rank.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Rank.Group_List.Group_Empty:SetActive(dataCount == 0)
end

function DataModel.ShowSelfRank(areaIndex)
  local userInfo = PlayerData:GetUserInfo()
  local rankData = DataModel.GetSelfRankDataByLevelAreaIndex(areaIndex)
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  if rankData then
    local rank = rankData.rank
    local bgPath = DataModel.rankBgList[rank] or DataModel.defaultRankBg
    View.Group_Rank.Group_List.Group_Oneself.Img_BG:SetSprite(bgPath)
    local showRankTxt = rank > #DataModel.rankBgList
    View.Group_Rank.Group_List.Group_Oneself.Txt_Order:SetActive(showRankTxt)
    if showRankTxt then
      local rankTxt = tostring(rank)
      if rank >= rankCA.rankNumMax then
        rankTxt = string.format(GetText(80601252), rankCA.rankNumMax)
      end
      View.Group_Rank.Group_List.Group_Oneself.Txt_Order:SetText(rankTxt)
    end
    View.Group_Rank.Group_List.Group_Oneself.Group_Content.Group_Date.Txt_Num:SetText(math.floor(rankData.val))
    View.Group_Rank.Group_List.Group_Oneself.Group_Content.Txt_Time:SetActive(true)
    View.Group_Rank.Group_List.Group_Oneself.Group_Content.Txt_Time:SetText(os.date("%Y/%m/%d/%H:%M", rankData.update_ts))
  else
    View.Group_Rank.Group_List.Group_Oneself.Txt_Order:SetActive(true)
    View.Group_Rank.Group_List.Group_Oneself.Img_BG:SetSprite(DataModel.defaultRankBg)
    View.Group_Rank.Group_List.Group_Oneself.Txt_Order:SetText(GetText(80601253))
    View.Group_Rank.Group_List.Group_Oneself.Group_Content.Group_Date.Txt_Num:SetText(0)
    View.Group_Rank.Group_List.Group_Oneself.Group_Content.Txt_Time:SetActive(false)
  end
  DataModel.ShowRankTeam(rankData, View.Group_Rank.Group_List.Group_Oneself.Group_RoleList)
  local headPath, photoFactory = DataModel.GetHeadPath(userInfo.avatar, userInfo.gender)
  if headPath then
    View.Group_Rank.Group_List.Group_Oneself.Btn_ProfilePhoto.Img_Head:SetSprite(headPath)
    CommonTips:SetPlayerHeadShader(View.Group_Rank.Group_List.Group_Oneself.Btn_ProfilePhoto.Img_spAdd, photoFactory)
  end
  View.Group_Rank.Group_List.Group_Oneself.Group_Name.Txt_Name.Group_Grade.Txt_Grade:SetText(userInfo.lv)
  View.Group_Rank.Group_List.Group_Oneself.Group_Name.Txt_Name:SetText(userInfo.role_name)
  View.Group_Rank.Group_List.Group_Oneself.Img_LikesNum.Txt_:SetText(userInfo.being_like_count)
end

function DataModel.ShowRankTeam(rankData, ctrl)
  local sortRids = {}
  if rankData and rankData.rids then
    for i, v in pairs(rankData.rids) do
      table.insert(sortRids, {
        unitId = tonumber(i),
        viewId = v
      })
    end
    table.sort(sortRids, function(a, b)
      return a.unitId < b.unitId
    end)
  end
  for i, v in ipairs(sortRids) do
    local viewCA = PlayerData:GetFactoryData(v.viewId, "UnitViewFactory")
    ctrl["Img_Face_00" .. i - 1].Btn_ProfilePhoto.Img_Head:SetSprite(viewCA.face)
  end
  ctrl:SetActive(0 < #sortRids)
end

function DataModel.GetCurLevelSelfRankData()
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  local minLv, maxLv = DataModel.GetCurLevelTween()
  local levelTween = minLv .. "-" .. maxLv
  local selfRankKey = rankCA.rankType .. ":" .. rankCA.timeType .. ":" .. DataModel.stationId .. ":" .. levelTween
  return DataModel.serverSelfRank[selfRankKey]
end

function DataModel.GetLevelTweenByLevelAreaIndex(areaIndex)
  local info = DataModel.levelAreaList[areaIndex]
  if not info then
    return
  end
  return info.minLevel .. "-" .. info.maxLevel
end

function DataModel.GetSelfRankDataByLevelAreaIndex(areaIndex)
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  local levelTween = DataModel.GetLevelTweenByLevelAreaIndex(areaIndex)
  if not levelTween then
    return
  end
  local selfRankKey = rankCA.rankType .. ":" .. rankCA.timeType .. ":" .. DataModel.stationId .. ":" .. levelTween
  return DataModel.serverSelfRank[selfRankKey]
end

function DataModel.GetCurLevelTween()
  local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
  local userLv = PlayerData:GetUserInfo().lv
  local isOneBased = rankCA.sectionType == "onebased"
  local minLv = 0
  for i, v in ipairs(rankCA.gradeSectionList) do
    if isOneBased then
      minLv = 1
    elseif i == 1 then
      minLv = 1
    else
      minLv = rankCA.gradeSectionList[i - 1].grade + 1
    end
    if userLv >= minLv and userLv <= v.grade then
      return minLv, v.grade
    end
  end
end

function DataModel.GetHeadPath(avatar, gender)
  if avatar and avatar ~= "" then
    local photoCA = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
    return photoCA.imagePath, photoCA
  else
    local configCA = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    return configCA.playerHeadList[gender + 1].playerHeadPath, nil
  end
end

function DataModel.RefreshGiveLike()
  local num, maxNum = PlayerData.GetGiveLikeNum()
  View.Group_Rank.Group_Top.Group_LikesNum.Group_NumLikes.Txt_:SetText(string.format(GetText(80609549), num, maxNum))
end

return DataModel
