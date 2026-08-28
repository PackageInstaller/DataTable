local View = require("UIRevenueOverview/UIRevenueOverviewView")
local DataModel = require("UIRevenueOverview/UIRevenueOverviewDataModel")
local ViewFunction = {
  RevenueOverview_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  RevenueOverview_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  RevenueOverview_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  RevenueOverview_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80304770}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  RevenueOverview_Group_Tab_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
    local info = DataModel.tabData[elementIndex]
    local tabIndex = DataModel.tabIndex
    element.Group_On:SetActive(elementIndex == tabIndex)
    element.Group_On.Txt_Name:SetText(GetText(info.name))
    element.Group_On.Img_Icon:SetSprite(info.icon)
    element.Group_Off:SetActive(elementIndex ~= tabIndex)
    element.Group_Off.Txt_Name:SetText(GetText(info.name))
    element.Group_Off.Img_Icon:SetSprite(info.icon)
    element.Btn_:SetClickParam(elementIndex)
    DataModel.tabElements[elementIndex] = element
  end,
  RevenueOverview_Group_Tab_ScrollGrid_Tab_Group_Item_Btn__Click = function(btn, str)
    DataModel.ClickRightTab(tonumber(str))
  end,
  RevenueOverview_Group_Report_Group_Ratio_Group_Label_ScrollGrid__SetGrid = function(element, elementIndex)
    local info = DataModel.ratioIncomeList[elementIndex]
    element.Group_Title.Group_Top:SetActive(elementIndex == 1 and info.income > 0)
    element.Group_Title.Txt_Title:SetText(GetText(info.name))
    element.Img_Label:SetSprite(info.labelBg)
    element.Img_BG:SetActive(elementIndex % 2 == 0)
    local ratio = DataModel.todayTotalIncome == 0 and 0 or info.income / DataModel.todayTotalIncome * 100
    element.Txt_Num:SetText(ClearFollowZero(ratio, 1) .. "%")
  end,
  RevenueOverview_Group_Report_Group_Pick_Btn_Report_Click = function(btn, str)
    local curShowType = DataModel.curPanelType
    if curShowType == DataModel.PanelType.Income then
      return
    end
    DataModel.curPanelType = DataModel.PanelType.Income
    DataModel.ShowIncomeTab()
    View.self:PlayAnimOnce("Group_RecentDays")
  end,
  RevenueOverview_Group_Report_Group_Pick_Btn_Ratio_Click = function(btn, str)
    local curShowType = DataModel.curPanelType
    if curShowType == DataModel.PanelType.IncomeRatio then
      return
    end
    DataModel.curPanelType = DataModel.PanelType.IncomeRatio
    DataModel.ShowIncomeRatio()
    View.self:PlayAnimOnce("Group_Ratio")
  end,
  RevenueOverview_Group_Rank_Img_Lv_Btn__Click = function(btn, str)
    DataModel.ClickGradeSection()
  end,
  RevenueOverview_Group_Rank_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local tabIndex = DataModel.tabIndex
    local rankId = DataModel.rankType[tonumber(tabIndex)]
    local rankCA = PlayerData:GetFactoryData(rankId, "RankFactory")
    local rankList
    if DataModel.curPanelType == DataModel.PanelType.ServerRank then
      rankList = DataModel.serverRankList[tonumber(tabIndex)][DataModel.rankLevelTabIndex]
    elseif DataModel.curPanelType == DataModel.PanelType.FriendRank then
      rankList = DataModel.friendRankList[tonumber(tabIndex)][DataModel.rankLevelTabIndex]
    end
    local rankData = rankList and rankList[elementIndex]
    if not rankData then
      return
    end
    local isSelf = rankData.uid == PlayerData:GetUserInfo().uid
    element:SetActive(true)
    local bgPath = DataModel.rankBgList[elementIndex] or DataModel.defaultRankBg
    element.Img_BG:SetSprite(bgPath)
    local ratioBgPath = DataModel.rankRatioBgList[elementIndex] or DataModel.defaultRankRatioBg
    element.Btn_Ratio:SetSprite(ratioBgPath)
    if elementIndex > #DataModel.rankBgList then
      element.Txt_Order:SetText(elementIndex)
    end
    element.Txt_Order:SetActive(elementIndex > #DataModel.rankBgList)
    local headPath, photoFactory = DataModel.GetHeadPath(rankData.avatar, rankData.gender)
    if headPath then
      element.Btn_ProfilePhoto.Img_Head:SetSprite(headPath)
      CommonTips:SetPlayerHeadShader(element.Btn_ProfilePhoto.Img_spAdd, photoFactory)
    end
    element.Group_NameGrade.Group_Grade.Txt_Grade:SetText(rankData.lv)
    element.Group_NameGrade.Txt_Name:SetText(rankData.role_name)
    element.Group_Content.Txt_Num:SetText(math.floor(rankData.val))
    element.Img_Oneself:SetActive(isSelf)
    element.Btn_Ratio:SetClickParam(elementIndex)
    element.Group_Likes:SetActive(not isSelf)
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
    DataModel.rankElements[elementIndex] = element
  end,
  RevenueOverview_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  RevenueOverview_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Btn_Ratio_Click = function(btn, str)
    DataModel.ClickRankRatio(str)
  end,
  RevenueOverview_Group_Rank_Group_Pick_Btn_All_Click = function(btn, str)
    DataModel.ClickServerRank()
  end,
  RevenueOverview_Group_Rank_Group_Pick_Btn_Friend_Click = function(btn, str)
    DataModel.ClickFriendRank()
  end,
  RevenueOverview_Group_Rank_Group_OtherRatio_Group_Label_ScrollGrid__SetGrid = function(element, elementIndex)
    local info = DataModel.rankRatioIncomeList[elementIndex]
    element.Group_Title.Group_Top:SetActive(elementIndex == 1 and info.income > 0)
    element.Group_Title.Txt_Title:SetText(GetText(info.name))
    element.Img_Label:SetSprite(info.labelBg)
    element.Img_BG:SetActive(elementIndex % 2 == 0)
    local ratio = DataModel.rankRatioTotalIncome == 0 and 0 or info.income / DataModel.rankRatioTotalIncome * 100
    element.Txt_Num:SetText(ClearFollowZero(ratio, 1) .. "%")
  end,
  RevenueOverview_Group_Rank_Group_OtherRatio_Group_Title_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  RevenueOverview_Group_Rank_Group_OtherRatio_Btn_Close_Click = function(btn, str)
    View.Group_Rank.Group_OtherRatio:SetActive(false)
  end,
  RevenueOverview_Group_Rank_Group_Oneself_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  RevenueOverview_Group_Rank_Group_Oneself_Btn_Ratio_Click = function(btn, str)
    DataModel.ClickRankRatio(str, true)
  end,
  RevenueOverview_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_Likes_Group_Unlike_Btn__Click = function(btn, str)
    if PlayerData.IsGiveLikeMax() then
      CommonTips.OpenTips(80609371)
      return
    end
    local rankList
    local tabIndex = DataModel.tabIndex
    if DataModel.curPanelType == DataModel.PanelType.ServerRank then
      rankList = DataModel.serverRankList[tonumber(tabIndex)][DataModel.rankLevelTabIndex]
    elseif DataModel.curPanelType == DataModel.PanelType.FriendRank then
      rankList = DataModel.friendRankList[tonumber(tabIndex)][DataModel.rankLevelTabIndex]
    end
    local rankData = rankList and rankList[tonumber(str)]
    if rankData then
      View.Img_GiveLikeMask:SetActive(true)
      
      local function callBack(json)
        rankData.being_like_count = rankData.being_like_count + 1
        rankData.being_like_count = math.floor(rankData.being_like_count)
        local element = DataModel.rankElements[tonumber(str)]
        if element then
          element.Group_Likes.Group_Unlike:SetActive(false)
          element.Group_Likes.Group_Liked:SetActive(true)
          element.Group_Likes.Group_Liked.Group_Likes_effect:SetActive(false)
          element.Group_Likes.Group_Liked.Group_Likes_effect:SetActive(true)
          element.Group_Likes:SetEnableAnimator(true)
          element.Group_Likes.transform:GetComponent(typeof(CS.UIAnimator)):SetCallBack(function()
            if json.reward then
              CommonTips.OpenShowItem(json.reward)
            end
          end)
          element.Group_Likes.transform:GetComponent(typeof(CS.UIAnimator)).animator:Play("Group_Likes", 0, 0)
          element.Img_LikesNum.Txt_:SetText(rankData.being_like_count)
        end
        DataModel.RefreshRankGiveLike()
        DataModel.giveLiveC = View.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
          View.Img_GiveLikeMask:SetActive(false)
        end))
      end
      
      PlayerData.GiveLive(rankData.uid, EnumDefine.GiveLikeType.Revenue, callBack)
    end
  end,
  RevenueOverview_Group_Rank_Group_Oneself_Group_Likes_Group_Unlike_Btn__Click = function(btn, str)
  end,
  RevenueOverview_Group_Rank_Group_Title_Group_LikesNum_Btn__Click = function(btn, str)
    CommonTips.OpenRankGiveLikeTips()
  end,
  RevenueOverview_Group_Rank_Group_LVInterval_StaticGrid__SetGrid = function(element, elementIndex)
    local rankId = DataModel.rankType[tonumber(DataModel.tabIndex)]
    local levelTween = DataModel.GetLevelTween(rankId, elementIndex)
    element.Group_Unchoose.Btn_.Txt_:SetText("Lv." .. levelTween)
    element.Group_Unchoose.Btn_:SetClickParam(elementIndex)
    element.Group_Choose.Img_.Txt_:SetText("Lv." .. levelTween)
    element.Group_Choose:SetActive(DataModel.rankLevelTabIndex == elementIndex)
    element.Group_Unchoose:SetActive(DataModel.rankLevelTabIndex ~= elementIndex)
  end,
  RevenueOverview_Group_Rank_Group_LVInterval_StaticGrid__Group_Item_Group_Unchoose_Btn__Click = function(btn, str)
    local rankLevelTabIndex = tonumber(str)
    local tabIndex = DataModel.tabIndex
    local rankId = DataModel.rankType[tonumber(tabIndex)]
    DataModel.rankLevelTabIndex = rankLevelTabIndex
    local showType = DataModel.curPanelType
    if showType == DataModel.PanelType.ServerRank then
      local function callBack()
        DataModel.RefreshServerRank()
        
        View.self:PlayAnimOnce("RevenueOverview_Group_Rank")
      end
      
      DataModel.GetRankData(tabIndex, rankLevelTabIndex, DataModel.RankTab.Server, callBack)
    elseif showType == DataModel.PanelType.FriendRank then
      local function callBack()
        DataModel.RefreshFriendRank()
        
        View.self:PlayAnimOnce("RevenueOverview_Group_Rank")
      end
      
      DataModel.GetRankData(tabIndex, rankLevelTabIndex, DataModel.RankTab.Friend, callBack)
    end
    View.Group_Rank.Group_LVInterval:SetActive(false)
    local levelTween = DataModel.GetLevelTween(rankId, rankLevelTabIndex)
    View.Group_Rank.Img_Lv.Txt_:SetText("LV." .. levelTween)
  end,
  RevenueOverview_Group_Money_Img_Lv_Btn__Click = function(btn, str)
    DataModel.ClickHuRunGradeSection()
  end,
  RevenueOverview_Group_Money_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local rankList
    local rankLevelTabIndex = DataModel.rankLevelTabIndex
    if DataModel.curPanelType == DataModel.PanelType.HuRunServerRank then
      rankList = DataModel.huRunSeverRankList[rankLevelTabIndex]
    elseif DataModel.curPanelType == DataModel.PanelType.HuRunFriendRank then
      rankList = DataModel.huRunFriendRankList[rankLevelTabIndex]
    end
    local rankData = rankList and rankList[elementIndex]
    if not rankData then
      if DataModel.huRunServeRankLevelCacheInfo[rankLevelTabIndex].has_more then
        DataModel.huRunServeRankLevelCacheInfo[rankLevelTabIndex].has_more = false
        DataModel.RollGetHuRunServerRankData(rankLevelTabIndex)
      end
      element.Img_Empty:SetActive(true)
    else
      element.Img_Empty:SetActive(false)
      local isSelf = rankData.uid == PlayerData:GetUserInfo().uid
      element:SetActive(true)
      local bgPath = DataModel.rankBgList[elementIndex] or DataModel.defaultRankBg
      element.Img_BG:SetSprite(bgPath)
      if elementIndex > #DataModel.rankBgList then
        element.Txt_Order:SetText(elementIndex)
      end
      element.Txt_Order:SetActive(elementIndex > #DataModel.rankBgList)
      local headPath, photoFactory = DataModel.GetHeadPath(rankData.avatar, rankData.gender)
      if headPath then
        element.Btn_ProfilePhoto.Img_Head:SetSprite(headPath)
        CommonTips:SetPlayerHeadShader(element.Btn_ProfilePhoto.Img_spAdd, photoFactory)
      end
      element.Group_NameGrade.Group_Grade.Txt_Grade:SetText(rankData.lv)
      element.Group_NameGrade.Txt_Name:SetText(rankData.role_name)
      element.Group_Content.Txt_Num:SetText(math.floor(rankData.val))
      element.Img_Oneself:SetActive(isSelf)
      DataModel.rankElements[elementIndex] = element
    end
  end,
  RevenueOverview_Group_Money_Group_List_ScrollGrid_List_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  RevenueOverview_Group_Money_Group_Oneself_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  RevenueOverview_Group_Money_Group_Pick_Btn_Friend_Click = function(btn, str)
    DataModel.ClickHuRunFriendRank()
  end,
  RevenueOverview_Group_Money_Group_Pick_Btn_All_Click = function(btn, str)
    DataModel.ClickHuRunServerRank()
  end,
  RevenueOverview_Group_Money_Group_LVInterval_StaticGrid__SetGrid = function(element, elementIndex)
    local rankId = 84300033
    local levelTween = DataModel.GetLevelTween(rankId, elementIndex)
    element.Group_Unchoose.Btn_.Txt_:SetText("Lv." .. levelTween)
    element.Group_Unchoose.Btn_:SetClickParam(elementIndex)
    element.Group_Choose.Img_.Txt_:SetText("Lv." .. levelTween)
    element.Group_Choose:SetActive(DataModel.rankLevelTabIndex == elementIndex)
    element.Group_Unchoose:SetActive(DataModel.rankLevelTabIndex ~= elementIndex)
  end,
  RevenueOverview_Group_Money_Group_LVInterval_StaticGrid__Group_Item_Group_Unchoose_Btn__Click = function(btn, str)
    local rankLevelTabIndex = tonumber(str)
    local rankId = 84300033
    DataModel.rankLevelTabIndex = rankLevelTabIndex
    local showType = DataModel.curPanelType
    if showType == DataModel.PanelType.HuRunServerRank then
      local function callBack()
        DataModel.RefreshHuRunServerRank()
      end
      
      DataModel.GetHuRunServerRankData(rankLevelTabIndex, callBack)
    elseif showType == DataModel.PanelType.HuRunFriendRank then
      local function callBack()
        DataModel.RefreshFriendRank()
      end
      
      DataModel.GetHuRunFriendRankData(rankLevelTabIndex, callBack)
    end
    View.Group_Money.Group_LVInterval:SetActive(false)
    local levelTween = DataModel.GetLevelTween(rankId, rankLevelTabIndex)
    View.Group_Money.Img_Lv.Txt_:SetText("LV." .. levelTween)
  end,
  RevenueOverview_Group_PickPanel_Group_Report_Btn__Click = function(btn, str)
    DataModel.ClickIncomeMenu()
  end,
  RevenueOverview_Group_PickPanel_Group_Rank_Btn__Click = function(btn, str)
    DataModel.ClickRankMenu()
  end,
  RevenueOverview_Group_PickPanel_Group_Hurun_Btn__Click = function(btn, str)
    DataModel.ClickHuRunMenu()
  end
}
return ViewFunction
