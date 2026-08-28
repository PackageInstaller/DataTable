local View = require("UIHomeInvest/UIHomeInvestView")
local DataModel = require("UIHomeInvest/UIHomeInvestDataModel")
local Controller = require("UIHomeInvest/UIHomeInvestController")
local ViewFunction = {
  HomeInvest_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Main.Group_Drink.self.IsActive then
      Controller:DrinkReturnToMain()
      return
    end
    if View.Group_Invest.self.IsActive or View.Group_Goods.self.IsActive or View.Group_GoodInvest.self.IsActive then
      Controller:ReturnToMain()
      return
    end
    if DataModel.IsBossBattle then
      UIManager:Open("UI/CityMap/CityMap", Json.encode({
        stationId = DataModel.StationId
      }))
    else
      UIManager:GoBack()
    end
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80303386}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomeInvest_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_Invest_Click = function(btn, str)
    Controller:ShowInvest()
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_BattleBoss_Click = function(btn, str)
    local turntableBattleCA = PlayerData:GetFactoryData(DataModel.StationCA.turntableId)
    if PlayerData:GetUserInfo().lv < turntableBattleCA.openLv then
      CommonTips.OpenTips(80607472)
      return
    end
    local parms = {
      stationId = DataModel.StationId,
      buildingId = DataModel.BuildingId,
      npcId = DataModel.NpcId,
      bgPath = DataModel.BgPath,
      bgColor = DataModel.BgColor
    }
    UIManager:Open("UI/BattleBoss/BattleBoss", Json.encode({
      stationId = DataModel.StationId,
      turntableId = DataModel.StationCA.turntableId,
      callBack = parms
    }))
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_shop_Click = function(btn, str)
    Controller:OpenExchangeBuild()
  end,
  HomeInvest_Group_Main_Btn_Rank_Click = function(btn, str)
    local rankCA = PlayerData:GetFactoryData(84300006, "RankFactory")
    local rankType = rankCA.rankType
    local timeType = rankCA.timeType
    local BattleRankListDataModel = require("UIBattleRankList/UIBattleRankListDataModel")
    local minLv, maxLv = BattleRankListDataModel.GetCurLevelTween()
    local levelTween = ""
    if minLv and maxLv then
      levelTween = minLv .. "-" .. maxLv
    end
    Net:SendProto("main.rank", function(json)
      if json.rank_list and json.my_rank then
        UIManager:Open("UI/RankList/InvestmentRankList", Json.encode({
          stationId = DataModel.StationId,
          selfRank = json.my_rank,
          rankList = json.rank_list
        }))
      end
    end, rankType, timeType, levelTween, DataModel.StationId, rankCA.peopleNum)
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_GoodsOut_Click = function(btn, str)
    Controller:OnGoodsOutBtnClick()
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_GoodsTag_Click = function(btn, str)
    Controller:OnGoodsTagBtnClick()
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_GoodsInvest_Click = function(btn, str)
    Controller:OnGoodsInvestBtnClick()
  end,
  HomeInvest_Group_Main_Group_Btn_Btn_Drink_Click = function(btn, str)
    Controller:OpenDrink()
  end,
  HomeInvest_Group_Main_Group_Drink_Group_Energy_Btn_Energy_Click = function(btn, str)
  end,
  HomeInvest_Group_Main_Group_Drink_StaticGrid_Drink_SetGrid = function(element, elementIndex)
    Controller:RefreshDrinkElement(element, elementIndex)
  end,
  HomeInvest_Group_Main_Group_Drink_StaticGrid_Drink_Group_Drink_Btn_Click_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:Drink(idx)
  end,
  HomeInvest_Group_TishiWindow_Btn_Close_Click = function(btn, str)
    View.Group_TishiWindow.self:SetActive(false)
  end,
  HomeInvest_Group_TishiWindow_Txt_NoReminded_Btn_Check_Click = function(btn, str)
    local isActive = View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check.IsActive
    View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(not isActive)
  end,
  HomeInvest_Group_TishiWindow_Btn_Confirm_Click = function(btn, str)
    Controller:ConfirmReplaceBuff()
  end,
  HomeInvest_Group_TishiWindow_Btn_Cancel_Click = function(btn, str)
    View.Group_TishiWindow.self:SetActive(false)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_SetGrid = function(element, elementIndex)
    local info = DataModel.InvestList[elementIndex]
    element.Img_BG.Txt_Name:SetText(info.name)
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewardList)
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
    element.Img_BG.Group_Reward.ScrollGrid_Reward.grid.self:MoveToTop()
    element.Img_BG.Group_TZ.Btn_TZ.self:SetActive(info.remainNum > 0)
    element.Img_BG.Group_TZ.Btn_NotTZ.self:SetActive(info.remainNum <= 0)
    element.Img_BG.Group_TZ.Btn_TZ.self:SetClickParam(elementIndex)
    element.Img_BG.Img_Tuijian.Txt_1:SetText(string.format(GetText(80600686), info.remainNum))
    local costInfo = info.costList[1]
    local itemCA = PlayerData:GetFactoryData(costInfo.id, "ItemFactory")
    element.Img_BG.Group_Cost.Img_Cost:SetSprite(itemCA.buyPath or itemCA.iconPath)
    element.Img_BG.Group_Cost.Txt_.Txt_Cost:SetText(costInfo.num)
    local isShow = DataModel.CurRepLv < info.repGrade
    element.Img_BG.Img_WeiDaDao.self:SetActive(isShow)
    if isShow then
      element.Img_BG.Img_WeiDaDao.Txt_JieSuo:SetText(string.format(GetText(80600687), info.repGrade))
    end
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_TZ_Btn_TZ_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:DoInvest(idx)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_TZ_Btn_NotTZ_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Zhu_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      homeCommon.SetReputationElement(View.Group_Invest.Group_Zhu.Group_Reputation, DataModel.StationId)
    end)
  end,
  HomeInvest_Group_Invest_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Group_FZ_Btn_Icon_Click = function(btn, str)
    View.Group_Invest.Group_Tips.self:SetActive(true)
  end,
  HomeInvest_Group_Invest_Group_Ding_Img_BG_Btn_Xk_Click = function(btn, str)
    Controller:ShowTradePermission()
  end,
  HomeInvest_Group_Invest_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Invest.Group_Tips.self:SetActive(false)
  end,
  HomeInvest_Group_Invest_Group_XK_Btn_Close_Click = function(btn, str)
    View.Group_Invest.Group_XK.self:SetActive(false)
  end,
  HomeInvest_Group_Invest_Group_XK_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:RefreshXKElement(element, elementIndex)
  end,
  HomeInvest_Group_Invest_Group_XK_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenGoodsTips(id, 1)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local info = DataModel.InvestList[tonumber(element.ParentParam)]
    local rewardInfo = info.rewardList[elementIndex]
    local BtnItem = require("Common/BtnItem")
    BtnItem:SetItem(element.Group_Item, {
      id = rewardInfo.id,
      num = rewardInfo.num
    })
    element.Group_Item.Btn_Item:SetClickParam(rewardInfo.id)
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = itemId})
  end,
  HomeInvest_Group_Invest_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeInvest_Group_Invest_Group_Ding_Btn_Refresh_Click = function(btn, str)
    Controller:ItemUseRefresh()
  end,
  HomeInvest_Group_Invest_ScrollGrid_Level_Group_Item_Img_BG_Group_TZ_Btn_NotEnough_Click = function(btn, str)
  end,
  HomeInvest_Group_Goods_Btn_Change_Click = function(btn, str)
    Controller:OnGoodsChangeBtnClick()
  end,
  HomeInvest_Group_Goods_Group_Out_Group_Quest_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:RefreshGoodsQuestElementShow(element, elementIndex)
  end,
  HomeInvest_Group_Goods_Group_Out_Group_Quest_ScrollGrid__Group_Item_Group_change_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeInvest_Group_Goods_Group_Tag_ScrollGrid_item_SetGrid = function(element, elementIndex)
    Controller:RefreshTagQuestElementShow(element, elementIndex)
  end,
  HomeInvest_Group_Goods_Group_Tag_ScrollGrid_item_Group_Item_Btn__Click = function(btn, str)
  end,
  HomeInvest_Group_Goods_Group_Tag_ScrollGrid_item_Group_Item_Btn__Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeInvest_Group_Goods_Group_Goods_Btn__Click = function(btn, str)
    View.Group_Goods.Group_Goods:SetActive(false)
  end,
  HomeInvest_Group_Goods_Group_Goods_ScrollGrid_Good_SetGrid = function(element, elementIndex)
    Controller:RefreshTagGoodListElementShow(element, elementIndex)
  end,
  HomeInvest_Group_Goods_Group_Goods_ScrollGrid_Good_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Good1_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Good1_Group_Invert_Btn_Invert_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Good2_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeInvest_Group_GoodInvest_Group_Good2_Group_Invert_Btn_Invert_Click = function(btn, str)
  end,
  HomeInvest_Btn_Rank_Click = function(btn, str)
  end,
  HomeInvest_Group_Main_Btn_Invest_Click = function(btn, str)
    Controller:ShowInvest()
  end,
  HomeInvest_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end
}
return ViewFunction
