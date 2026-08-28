local DataModel = require("UIInvestmentRankList/UIInvestmentRankListDataModel")
local View = require("UIInvestmentRankList/UIInvestmentRankListView")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  DataModel.CurTabIndex = 0
  DataModel.CurTimeType = 0
  View.Group_Rank.self:SetActive(false)
  local hasStation = false
  for i = 1, #DataModel.RankListInfo do
    if DataModel.RankListInfo[i].rankCA.skipStation == DataModel.StationId then
      Controller:SelectTab(i)
      hasStation = true
    end
  end
  if not hasStation then
    Controller:SelectTab(1)
  end
  View.Group_Tab.ScrollGrid_Tab.grid.self:SetDataCount(#DataModel.RankListInfo)
  View.Group_Tab.ScrollGrid_Tab.grid.self:RefreshAllElement()
  Controller.RefreshGiveLike()
end

function Controller:RefreshTabElement(element, elementIndex)
  local info = DataModel.RankListInfo[elementIndex]
  element.Group_Off.Txt_Name:SetText(info.rankCA.tabName)
  element.Group_On.Txt_Name:SetText(info.rankCA.tabName)
  element.Group_On.self:SetActive(elementIndex == DataModel.CurTabIndex)
  element.Group_Off.self:SetActive(elementIndex ~= DataModel.CurTabIndex)
  element.Btn_:SetClickParam(elementIndex)
end

function Controller:TabElementClick(btn, str)
  local idx = tonumber(str)
  Controller:SelectTab(idx)
  View.Group_Tab.ScrollGrid_Tab.grid.self:RefreshAllElement()
end

function Controller:RefreshRankElement(element, elementIndex)
  local info = DataModel.CurDetailInfo[elementIndex]
  self:SetOneElement(element, info)
  self.RefreshElementGiveLike(element, elementIndex)
  DataModel.rankElements[elementIndex] = element
end

function Controller.RefreshElementGiveLike(element, elementIndex)
  local rankData = DataModel.CurDetailInfo[elementIndex]
  element:SetActive(true)
  element.Group_Likes:SetActive(rankData.uid ~= PlayerData:GetUserInfo().uid)
  element.Group_Likes:SetEnableAnimator(false)
  if element.Group_Likes.IsActive then
    local isGiveLike = PlayerData.IsGiveLike(rankData.uid)
    element.Group_Likes.Group_Unlike:SetActive(not isGiveLike)
    element.Group_Likes.Group_Liked:SetActive(isGiveLike)
    element.Group_Likes.Group_Unlike.Btn_:SetClickParam(elementIndex)
    element.Group_Likes.Group_Liked.Group_Likes_effect:SetOrder(View.self.CurrOrder)
    element.Group_Likes.Group_Liked.Group_Likes_effect:SetActive(false)
  end
  element.Img_LikesNum.Txt_:SetText(rankData.being_like_count)
end

function Controller.RefreshGiveLike()
  local num, maxNum = PlayerData.GetGiveLikeNum()
  View.Group_Rank.Group_Top.Group_LikesNum.Group_NumLikes.Txt_:SetText(string.format(GetText(80609549), num, maxNum))
end

function Controller:SelectTab(tabIndex, timeType, rankLvIdx)
  if DataModel.QuickClickTime < DataModel.QuickClickLimit then
    CommonTips.OpenTips(80601254)
    return
  end
  if tabIndex == 1 then
    View.Group_Rank.Group_Top.Group_Select.Btn_Buff:SetActive(false)
    View.Group_BuffTips:SetActive(false)
  end
  local rankInfo = DataModel.RankListInfo[tabIndex]
  if DataModel.CurTabIndex ~= tabIndex and rankInfo then
    if rankInfo.rankCA.topTips and rankInfo.rankCA.topTips > 0 then
      View.Group_TopTips.self:SetActive(true)
      View.Group_TopTips.Txt_Tips:SetText(GetText(rankInfo.rankCA.topTips))
    else
      View.Group_TopTips.self:SetActive(false)
    end
  end
  if timeType == nil and rankInfo then
    if rankInfo.rankCA.timeType == "weekly" then
      timeType = DataModel.TimeType.weekly
    elseif rankInfo.rankCA.timeType == "forever" then
      timeType = DataModel.TimeType.forever
    else
      timeType = DataModel.TimeType.forever
    end
  end
  local minLv = 0
  local maxLv = 0
  if next(rankInfo.rankLv) then
    View.Group_Rank.Group_Top.Group_Section:SetActive(true)
    if rankLvIdx == nil then
      rankLvIdx = rankInfo.rankLvSelfIdx
    end
    minLv = rankInfo.rankLv[rankLvIdx].minLv
    maxLv = rankInfo.rankLv[rankLvIdx].maxLv
    if minLv == 1 and maxLv == 999 then
      View.Group_Rank.Group_Top.Group_Section.self:SetActive(false)
    else
      View.Group_Rank.Group_Top.Group_Section.self:SetActive(true)
      local txt = ""
      if rankLvIdx == #rankInfo.rankLv and rankInfo.rankCA.sectionType ~= "onebased" then
        txt = string.format(GetText(80601372), minLv)
      else
        txt = string.format(GetText(80601250), minLv, maxLv)
      end
      View.Group_Rank.Group_Top.Group_Section.Txt_Grade:SetText(txt)
    end
  else
    View.Group_Rank.Group_Top.Group_Section:SetActive(false)
  end
  local isSameClick = false
  if DataModel.CurTabIndex == tabIndex and DataModel.CurTimeType == timeType then
    isSameClick = true
  end
  DataModel.CurTimeType = timeType
  DataModel.CurTabIndex = tabIndex
  if not isSameClick then
    if rankInfo.rankCA.timeType == "total" then
      View.Group_Rank.Group_Top.Group_Select.self:SetActive(true)
      if timeType == DataModel.TimeType.forever then
        DOTweenTools.DOLocalMoveXCallback(View.Group_Rank.Group_Top.Group_Select.Img_Select.transform, 100, 0.25, function()
          Controller:SwitchSelectTab(timeType)
        end)
      elseif timeType == DataModel.TimeType.monthly then
        DOTweenTools.DOLocalMoveXCallback(View.Group_Rank.Group_Top.Group_Select.Img_Select.transform, 269, 0.25, function()
          Controller:SwitchSelectTab(timeType)
        end)
      elseif timeType == DataModel.TimeType.weekly then
        DOTweenTools.DOLocalMoveXCallback(View.Group_Rank.Group_Top.Group_Select.Img_Select.transform, 430, 0.25, function()
          Controller:SwitchSelectTab(timeType)
        end)
      elseif timeType == DataModel.TimeType.daily then
        DOTweenTools.DOLocalMoveXCallback(View.Group_Rank.Group_Top.Group_Select.Img_Select.transform, 594, 0.25, function()
          Controller:SwitchSelectTab(timeType)
        end)
      end
    else
      View.Group_Rank.Group_Top.Group_Select.self:SetActive(false)
    end
    View.Group_Rank.Group_Top.Img_BG:SetSprite(rankInfo.rankCA.titlePng)
    View.Group_Rank.Group_Top.Txt_Name:SetText(rankInfo.rankCA.name)
    View.Group_Rank.Group_Top.Txt_EngName:SetText(rankInfo.rankCA.nameEN)
    local textId
    if timeType == DataModel.TimeType.forever then
      textId = 0
    elseif timeType == DataModel.TimeType.monthly then
      textId = 80602029
    elseif timeType == DataModel.TimeType.weekly then
      textId = 80601251
    elseif timeType == DataModel.TimeType.daily then
      textId = 80609803
    end
    if textId == 0 then
      View.Group_Rank.Group_Top.Txt_Time:SetText("")
    else
      View.Group_Rank.Group_Top.Txt_Time:SetText(GetText(textId))
    end
    View.Group_Rank.Group_List.Txt_Name:SetText(rankInfo.rankCA.rankName)
  end
  View.Group_Rank.Group_Top.Btn_CloseToggleArea:SetActive(false)
  View.Group_Rank.Group_Top.Group_ToggleArea.self:SetActive(false)
  View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_NotShow:SetActive(true)
  View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_Show:SetActive(false)
  local sid
  if tabIndex == 1 then
    sid = nil
  else
    sid = rankInfo.rankCA.skipStation
  end
  local rankType = rankInfo.rankCA.rankType
  local timeTypeStr = DataModel.TimeTypeToStr[timeType]
  local levelTween = minLv .. "-" .. maxLv
  Net:SendProto("main.rank", function(json)
    DataModel.CurRankLvIdx = rankLvIdx
    DataModel.QuickClickTime = 0
    View.Group_Rank.self:SetActive(true)
    DataModel.CurDetailInfo = json.rank_list
    DataModel.CurShowIconPng = rankInfo.rankCA.iconPng
    DataModel.rankElements = {}
    local serverNum = #DataModel.CurDetailInfo
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetDataCount(serverNum)
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_Rank.Group_List.Group_Empty.self:SetActive(serverNum == 0)
    local t = {}
    local myRankKey = rankType .. ":" .. timeTypeStr
    if sid then
      myRankKey = myRankKey .. ":" .. sid
    end
    if rankInfo.rankCA.sectionType == "onebased" and 0 < maxLv then
      myRankKey = myRankKey .. ":" .. minLv .. "-" .. maxLv
    end
    local my_rank = json.my_rank[myRankKey]
    if my_rank == nil then
      my_rank = json.my_rank
    end
    t.rank = my_rank and my_rank.rank or 0
    t.val = my_rank and my_rank.val or 0
    DataModel.myRank = my_rank and my_rank.rank or 0
    t.avatar = PlayerData:GetUserInfo().avatar
    t.role_name = PlayerData:GetUserInfo().role_name or ""
    t.rankNumMax = rankInfo.rankCA.rankNumMax
    t.lv = PlayerData:GetPlayerLevel()
    t.self = true
    self:SetOneElement(View.Group_Rank.Group_List.Group_Oneself, t)
    View.Group_Rank.Group_List.Group_Oneself.Img_LikesNum.Txt_:SetText(PlayerData:GetUserInfo().being_like_count)
  end, rankType, timeTypeStr, levelTween, sid, rankInfo.rankCA.peopleNum)
end

function Controller:SwitchSelectTab(timeType)
  View.Group_Rank.Group_Top.Group_Select.Group_Total.Group_On.self:SetActive(timeType == DataModel.TimeType.forever)
  View.Group_Rank.Group_Top.Group_Select.Group_Total.Group_Off.self:SetActive(timeType ~= DataModel.TimeType.forever)
  View.Group_Rank.Group_Top.Group_Select.Group_Month.Group_On.self:SetActive(timeType == DataModel.TimeType.monthly)
  View.Group_Rank.Group_Top.Group_Select.Group_Month.Group_Off.self:SetActive(timeType ~= DataModel.TimeType.monthly)
  View.Group_Rank.Group_Top.Group_Select.Group_Week.Group_On.self:SetActive(timeType == DataModel.TimeType.weekly)
  View.Group_Rank.Group_Top.Group_Select.Group_Week.Group_Off.self:SetActive(timeType ~= DataModel.TimeType.weekly)
  View.Group_Rank.Group_Top.Group_Select.Group_Day.Group_On.self:SetActive(timeType == DataModel.TimeType.daily)
  View.Group_Rank.Group_Top.Group_Select.Group_Day.Group_Off.self:SetActive(timeType ~= DataModel.TimeType.daily)
  View.Group_Rank.Group_Top.Group_Select.Btn_Buff:SetActive(timeType == DataModel.TimeType.forever and DataModel.CurTabIndex ~= 1)
  View.Group_BuffTips:SetActive(false)
end

function Controller:SetOneElement(element, info)
  local sortValue = info.rank
  local numValue = math.floor(info.val + 0.5)
  local imgPath = DataModel.ImgPath[(sortValue == 0 or 3 < sortValue) and 4 or sortValue]
  element.Img_BG:SetSprite(imgPath)
  element.Txt_Order:SetActive(3 < sortValue or sortValue == 0)
  if sortValue == 0 or numValue <= 0 then
    sortValue = GetText(80601253)
  elseif info.self and sortValue > info.rankNumMax then
    sortValue = string.format(GetText(80601252), info.rankNumMax)
  end
  element.Txt_Order:SetText(sortValue)
  if info.avatar ~= "" and 0 < info.avatar then
    local headId = tonumber(info.avatar)
    local photoFactory = PlayerData:GetFactoryData(headId, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      element.Btn_ProfilePhoto.Img_Head:SetSprite(photoFactory.imagePath)
      CommonTips:SetPlayerHeadShader(element.Btn_ProfilePhoto.Img_spAdd, photoFactory)
    end
  end
  element.Txt_Name:SetText(info.role_name)
  if element.Txt_Name.Img_Oneself then
    element.Txt_Name.Img_Oneself:SetActive(not info.self and info.uid == PlayerData:GetUserInfo().uid)
  end
  element.Group_Content.Img_Icon:SetSprite(DataModel.CurShowIconPng)
  element.Group_Content.Txt_Num:SetText(numValue)
  element.Txt_Name.Group_Grade.Txt_Grade:SetText(info.lv)
end

function Controller:ProfilePhotoClick(btn, str)
end

function Controller:ShowRankLvToggleArea(isShow)
  View.Group_Rank.Group_Top.Group_ToggleArea.self:SetActive(isShow)
  View.Group_Rank.Group_Top.Btn_CloseToggleArea:SetActive(isShow)
  View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_NotShow:SetActive(not isShow)
  View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_Show:SetActive(isShow)
  if isShow then
    View.Group_Rank.Group_Top.Group_ToggleArea.StaticGrid_Toggle.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshLvToggleElement(element, elementIndex)
  local rankInfo = DataModel.RankListInfo[DataModel.CurTabIndex]
  local rankLv = rankInfo.rankLv
  local lvInfo = rankLv[elementIndex]
  if lvInfo == nil then
    element.self:SetActive(false)
  else
    element.self:SetActive(true)
    element.Group_On.self:SetActive(elementIndex == DataModel.CurRankLvIdx)
    element.Group_Off.self:SetActive(elementIndex ~= DataModel.CurRankLvIdx)
    txt = string.format(GetText(80601250), lvInfo.minLv, lvInfo.maxLv)
    element.Group_On.Txt_Grade:SetText(txt)
    element.Group_Off.Txt_Grade:SetText(txt)
    element.Btn_Click:SetClickParam(elementIndex)
  end
end

function Controller:ClickLvToggle(str)
  local lvIdx = tonumber(str)
  Controller:SelectTab(DataModel.CurTabIndex, DataModel.CurTimeType, lvIdx)
end

function Controller:ShowBuffPanel()
  DataModel.CollectRankInfo()
  if table.count(DataModel.RankBuffInfoList) == 0 then
    View.Group_BuffTips:SetActive(false)
    return
  end
  if DataModel.CurTabIndex == 1 then
    View.Group_BuffTips:SetActive(false)
    return
  end
  View.Group_BuffTips:SetActive(true)
  local curSelectStation = DataModel.RankListInfo[DataModel.CurTabIndex].rankCA.skipStation
  local stationCfg = PlayerData:GetFactoryData(curSelectStation)
  local myRankIndex = 0
  for i = 1, 4 do
    local data = DataModel.RankBuffInfoList[i]
    local ctr = View.Group_BuffTips.Group_Buff["Group_" .. i]
    ctr.Txt_:SetText(data.startIndex .. "-" .. data.endIndex)
    ctr.Txt_Buff:SetText(string.format(data.buffDesc, stationCfg.name, data.buffValue))
    if DataModel.myRank >= data.startIndex and DataModel.myRank <= data.endIndex then
      myRankIndex = i
    end
  end
  if 0 < DataModel.myRank and 0 < myRankIndex then
    local data = DataModel.RankBuffInfoList[myRankIndex]
    View.Group_BuffTips.Group_Buff.Group_BuffOn.Txt_Buff:SetText(string.format(data.buffDesc, stationCfg.name, data.buffValue))
    View.Group_BuffTips.Group_Buff.Group_BuffOn:SetActive(true)
    View.Group_BuffTips.Group_Buff.Group_BuffOff:SetActive(false)
  else
    View.Group_BuffTips.Group_Buff.Group_BuffOn:SetActive(false)
    View.Group_BuffTips.Group_Buff.Group_BuffOff:SetActive(true)
  end
end

return Controller
