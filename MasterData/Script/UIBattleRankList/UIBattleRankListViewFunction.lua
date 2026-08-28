local View = require("UIBattleRankList/UIBattleRankListView")
local DataModel = require("UIBattleRankList/UIBattleRankListDataModel")
local ViewFunction = {
  BattleRankList_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
    local rankData = DataModel.serverRankList[elementIndex]
    local bgPath = DataModel.rankBgList[elementIndex] or DataModel.defaultRankBg
    element:SetActive(true)
    element.Img_BG:SetSprite(bgPath)
    local showRankTxt = elementIndex > #DataModel.rankBgList
    element.Txt_Order:SetActive(showRankTxt)
    if showRankTxt then
      element.Txt_Order:SetText(elementIndex)
    end
    DataModel.ShowRankTeam(rankData, element.Group_RoleList)
    local headPath, photoFactory = DataModel.GetHeadPath(rankData.avatar, rankData.gender)
    if headPath then
      element.Btn_ProfilePhoto.Img_Head:SetSprite(headPath)
      CommonTips:SetPlayerHeadShader(element.Btn_ProfilePhoto.Img_spAdd, photoFactory)
    end
    element.Group_Name.Txt_Name.Group_Grade.Txt_Grade:SetText(rankData.lv)
    element.Group_Name.Txt_Name:SetText(rankData.role_name)
    local iconPath = rankCA.iconPng
    element.Group_Content.Group_Date.Img_Icon:SetSprite(iconPath)
    element.Group_Content.Group_Date.Txt_Num:SetText(math.floor(rankData.val))
    element.Group_Content.Txt_Time:SetText(os.date("%Y/%m/%d/%H:%M", rankData.update_ts))
    element.Btn_ProfilePhoto:SetClickParam(rankData.uid)
    local selfRank = rankData.uid == PlayerData:GetUserInfo().uid
    element.Img_Oneself:SetActive(selfRank)
    element.Group_Likes:SetActive(not selfRank)
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
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    UIManager:Open("UI/Friends/Friends", Json.encode({uid = str}))
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_RoleList_Img_Face_000_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_RoleList_Img_Face_001_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_RoleList_Img_Face_002_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_RoleList_Img_Face_003_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_RoleList_Img_Face_004_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_Group_Oneself_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_Group_Oneself_Group_RoleList_Img_Face_000_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_Group_Oneself_Group_RoleList_Img_Face_001_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_Group_Oneself_Group_RoleList_Img_Face_002_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_Group_Oneself_Group_RoleList_Img_Face_003_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_List_Group_Oneself_Group_RoleList_Img_Face_004_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  BattleRankList_Group_Rank_Group_Top_Group_Section_Btn_Click_Click = function(btn, str)
    View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_Show:SetActive(false)
    View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_NotShow:SetActive(true)
    View.Group_Rank.Group_Top.Btn_CloseToggleArea:SetActive(true)
    View.Group_Rank.Group_Top.Group_ToggleArea:SetActive(true)
    DataModel.levelAreaElementList = {}
    View.Group_Rank.Group_Top.Group_ToggleArea.StaticGrid_Toggle.grid.self:SetDataCount(#DataModel.levelAreaList)
    View.Group_Rank.Group_Top.Group_ToggleArea.StaticGrid_Toggle.grid.self:RefreshAllElement()
  end,
  BattleRankList_Group_Rank_Group_Top_Btn_CloseToggleArea_Click = function(btn, str)
    View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_Show:SetActive(true)
    View.Group_Rank.Group_Top.Group_Section.Group_Show.Img_NotShow:SetActive(false)
    View.Group_Rank.Group_Top.Btn_CloseToggleArea:SetActive(false)
    View.Group_Rank.Group_Top.Group_ToggleArea:SetActive(false)
  end,
  BattleRankList_Group_Rank_Group_Top_Group_ToggleArea_StaticGrid_Toggle_SetGrid = function(element, elementIndex)
    local info = DataModel.levelAreaList[elementIndex]
    local areaTxt = string.format(GetText(80601250), info.minLevel, info.maxLevel)
    element.Group_On.Txt_Grade:SetText(areaTxt)
    element.Group_Off.Txt_Grade:SetText(areaTxt)
    local show = DataModel.levelAreaIndex == elementIndex
    element.Group_On:SetActive(show)
    element.Group_Off:SetActive(not show)
    element.Btn_Click:SetClickParam(elementIndex)
    DataModel.levelAreaElementList[elementIndex] = element
  end,
  BattleRankList_Group_Rank_Group_Top_Group_ToggleArea_StaticGrid_Toggle_Group_Toggle_Btn_Click_Click = function(btn, str)
    local rankCA = PlayerData:GetFactoryData(84300005, "RankFactory")
    local info = DataModel.levelAreaList[tonumber(str)]
    local levelTween = info.minLevel .. "-" .. info.maxLevel
    Net:SendProto("main.rank", function(json)
      if json.rank_list then
        DataModel.serverRankList = json.rank_list
      end
      if json.my_rank then
        DataModel.serverSelfRank = json.my_rank
      end
      DataModel.SortServerData()
      DataModel.SelectLevelArea(tonumber(str))
    end, rankCA.rankType, rankCA.timeType, levelTween, DataModel.stationId, rankCA.peopleNum)
  end,
  BattleRankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Group_Likes_Group_Unlike_Btn__Click = function(btn, str)
    if PlayerData.IsGiveLikeMax() then
      CommonTips.OpenTips(80609371)
      return
    end
    local rankData = DataModel.serverRankList[tonumber(str)]
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
        DataModel.giveLiveC = View.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
          View.Img_GiveLikeMask:SetActive(false)
        end))
        DataModel.RefreshGiveLike()
      end
      
      PlayerData.GiveLive(rankData.uid, EnumDefine.GiveLikeType.Other, callBack)
    end
  end,
  BattleRankList_Group_Rank_Group_Top_Group_LikesNum_Btn__Click = function(btn, str)
    CommonTips.OpenRankGiveLikeTips()
  end
}
return ViewFunction
