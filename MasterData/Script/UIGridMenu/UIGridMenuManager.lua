local View = require("UIGridMenu/UIGridMenuView")
local BtnItem = require("Common/BtnItem")
local UIGridMenuManager = {
  MonopolyMgr = nil,
  gridInfo = nil,
  mapInfo = nil,
  CurDetailInfo = nil,
  ImgPath = {
    "UI/RankList/first_bg",
    "UI/RankList/second_bg",
    "UI/RankList/third_bg",
    "UI/RankList/other_bg"
  },
  investList = {},
  buffList = {},
  curPanelIndex = 0,
  curRewardType = 1,
  gridInfo_rank = 0,
  curGridLv = nil,
  openSound = nil,
  lvUpSound = nil
}

function UIGridMenuManager.Init(gridId, mapId)
  UIGridMenuManager.mapInfo = PlayerData:GetFactoryData(mapId, "MonopolyGameMapFactory")
  UIGridMenuManager.gridInfo = PlayerData:GetFactoryData(gridId, "MonopolyGameGridFactory")
  if not UIGridMenuManager.gridInfo then
    return
  end
  View.Btn_Main.Img_On:SetActive(true)
  View.Btn_Invest.Img_On:SetActive(false)
  UIGridMenuManager.OpenCityMenuPanel()
  UIGridMenuManager.PlayOpenSound()
end

function UIGridMenuManager.Release()
  UIGridMenuManager.curGridLv = nil
end

function UIGridMenuManager.PlayOpenSound()
  local sound = SoundManager:CreateSound(30006378)
  if sound then
    sound:Play()
  end
end

function UIGridMenuManager.PlayLvUpSound()
  local sound = SoundManager:CreateSound(30001330)
  if sound then
    sound:Play()
  end
end

function UIGridMenuManager.OpenCityMenuPanel()
  UIGridMenuManager.curPanelIndex = 1
  UIGridMenuManager.curGridLv = nil
  View.Img_Plane.Img_BG:SetActive(true)
  View.Img_Left:SetActive(true)
  View.Group_Monopolis:SetActive(false)
  View.Group_Invest:SetActive(false)
  UIGridMenuManager.RefreshCityLv()
  UIGridMenuManager.RefreshGetBtnShow()
  UIGridMenuManager.RefreshBuffGodShow()
end

function UIGridMenuManager.OpenInvestPanel()
  View.Btn_Main.Img_On:SetActive(false)
  View.Btn_Invest.Img_On:SetActive(true)
  View.self:PlayAnimOnce("Group_Invest_In2", function()
    UIGridMenuManager.curPanelIndex = 2
    View.Group_Invest:SetActive(true)
    View.Img_Left:SetActive(true)
    View.Img_Plane.Img_BG:SetActive(false)
    View.Group_Monopolis:SetActive(false)
    UIGridMenuManager.RefreshAllMyMoneyNum()
    UIGridMenuManager.RefreshInvestRemainNum()
    UIGridMenuManager.RefreshMyInvestMoneyNum()
    UIGridMenuManager.investList = UIGridMenuManager.MonopolyMgr.investList or {}
    View.Group_Invest.Group_Right.ScrollGrid_InvestList.grid.self:SetDataCount(#UIGridMenuManager.investList)
    View.Group_Invest.Group_Right.ScrollGrid_InvestList.grid.self:RefreshAllElement()
  end)
end

function UIGridMenuManager.OpenRankPanel(gridId, isPlayAni)
  local gridInfo = PlayerData:GetFactoryData(gridId, "MonopolyGameGridFactory")
  UIGridMenuManager.gridInfo_rank = gridInfo
  if not gridInfo then
    return
  end
  View.Group_Monopolis:SetActive(true)
  if isPlayAni then
    View.self:PlayAnimOnce("GridMenu_Group_Monopolis")
  end
  View.Group_Monopolis.Btn_CitySwitch.Txt_City:SetText(gridInfo.name)
  UIGridMenuManager.OnClickDayRewardBtn()
  UIGridMenuManager.HideCityListPanel()
  Net:SendProto("main.rank", function(json)
    if json ~= nil then
      UIGridMenuManager.CurDetailInfo = json.rank_list
    end
    if UIGridMenuManager.CurDetailInfo == nil then
      return
    end
    UIGridMenuManager.curPanelIndex = 3
    View.Group_Monopolis.Group_CityList:SetActive(false)
    View.Group_Invest:SetActive(false)
    View.Img_Plane.Img_BG:SetActive(false)
    View.Img_Left:SetActive(false)
    local rankNum = #UIGridMenuManager.CurDetailInfo
    if 0 < rankNum then
      View.Group_Monopolis.Group_RankList.ScrollGrid_RankList.grid.self.gameObject:SetActive(true)
      View.Group_Monopolis.Group_RankList.ScrollGrid_RankList.grid.self:SetDataCount(rankNum)
      View.Group_Monopolis.Group_RankList.ScrollGrid_RankList.grid.self:RefreshAllElement()
    else
      View.Group_Monopolis.Group_RankList.ScrollGrid_RankList.grid.self.gameObject:SetActive(false)
    end
    if json.my_rank then
      local t = {}
      t.rank = json.my_rank.rank or 0
      t.val = json.my_rank.val or 0
      t.avatar = PlayerData:GetUserInfo().avatar
      t.role_name = PlayerData:GetUserInfo().role_name or ""
      t.rankNumMax = 0
      t.lv = PlayerData:GetPlayerLevel()
      t.self = true
      UIGridMenuManager.SetOneRankElement(View.Group_Monopolis.Group_RankList.Group_Oneself, t)
    end
  end, "monopolyInvest", "forever", nil, nil, nil, nil, gridId)
end

function UIGridMenuManager.RefreshRankElement(element, elementIndex)
  local info = UIGridMenuManager.CurDetailInfo[elementIndex]
  UIGridMenuManager.SetOneRankElement(element, info)
end

function UIGridMenuManager.SetOneRankElement(element, info)
  if element == nil or info == nil then
    return
  end
  local sortValue = info.rank
  element.Img_No1:SetActive(sortValue == 1)
  element.Img_No2:SetActive(sortValue == 2)
  element.Img_No3:SetActive(sortValue == 3)
  element.Img_No4:SetActive(3 < sortValue or sortValue == 0)
  element.Img_No4.Txt_Num:SetText(0 < sortValue and tostring(sortValue) or "--")
  if info.avatar ~= "" and 0 < info.avatar then
    local headId = tonumber(info.avatar)
    local photoFactory = PlayerData:GetFactoryData(headId, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      element.Group_Head.Img_ProfilePhoto.Img_Head:SetSprite(photoFactory.imagePath)
      CommonTips:SetPlayerHeadShader(element.Group_Head.Img_ProfilePhoto.Img_spAdd, photoFactory)
    end
  end
  element.Txt_Name:SetText(info.role_name)
  element.Group_LV.Txt_LV:SetText(info.lv)
  element.Group_Coin.Txt_Num:SetText(info.val)
end

function UIGridMenuManager.OpenCityListPanel()
  if not UIGridMenuManager.mapInfo then
    return
  end
  View.Group_Monopolis.Btn_CitySwitch.Img_1:SetActive(true)
  View.Group_Monopolis.Group_CityList:SetActive(true)
  local rankGridList = UIGridMenuManager.mapInfo.rankGridList or {}
  if 0 < #rankGridList then
    View.Group_Monopolis.Group_CityList.ScrollGrid_CityList.grid.self.gameObject:SetActive(true)
    View.Group_Monopolis.Group_CityList.ScrollGrid_CityList.grid.self:SetDataCount(#rankGridList)
    View.Group_Monopolis.Group_CityList.ScrollGrid_CityList.grid.self:RefreshAllElement()
  else
    View.Group_Monopolis.Group_CityList.ScrollGrid_CityList.grid.self.gameObject:SetActive(false)
  end
end

function UIGridMenuManager.RefreshCityElement(element, elementIndex)
  if not element or not UIGridMenuManager.mapInfo then
    return
  end
  local rankGridList = UIGridMenuManager.mapInfo.rankGridList or {}
  local info = rankGridList[elementIndex]
  if not info then
    return
  end
  local gridInfo = PlayerData:GetFactoryData(info.id, "MonopolyGameGridFactory")
  if not gridInfo then
    return
  end
  local isPresent = info.id == UIGridMenuManager.gridInfo.id
  if isPresent then
    element.Txt_City:SetActive(false)
    element.Group_Present:SetActive(true)
    element.Group_Present.Txt_City:SetText(gridInfo.name)
  else
    element.Group_Present:SetActive(false)
    element.Txt_City:SetActive(true)
    element.Txt_City:SetText(gridInfo.name)
  end
  element.Btn_Change:SetClickFunction(function()
    UIGridMenuManager.OpenRankPanel(info.id)
  end)
end

function UIGridMenuManager.HideCityListPanel()
  View.Group_Monopolis.Group_CityList:SetActive(false)
  View.Group_Monopolis.Btn_CitySwitch.Img_1:SetActive(false)
end

function UIGridMenuManager.OnClickDayRewardBtn()
  View.Group_Monopolis.Group_RewardList.Btn_Day.Img_Active:SetActive(true)
  View.Group_Monopolis.Group_RewardList.Btn_Issue.Img_Active:SetActive(false)
  UIGridMenuManager.curRewardType = 1
  UIGridMenuManager.RefreshRewardListShow()
end

function UIGridMenuManager.OnClickIssueRewardBtn()
  View.Group_Monopolis.Group_RewardList.Btn_Day.Img_Active:SetActive(false)
  View.Group_Monopolis.Group_RewardList.Btn_Issue.Img_Active:SetActive(true)
  UIGridMenuManager.curRewardType = 2
  UIGridMenuManager.RefreshRewardListShow()
end

function UIGridMenuManager.RefreshRewardListShow()
  if not UIGridMenuManager.gridInfo_rank then
    return
  end
  local rankList = {}
  if UIGridMenuManager.curRewardType == 1 then
    rankList = UIGridMenuManager.gridInfo_rank.rankInningList or {}
  else
    rankList = UIGridMenuManager.gridInfo_rank.rankIssueList or {}
  end
  if 0 < #rankList then
    View.Group_Monopolis.Group_RewardList.ScrollGrid_RewardList.grid.self.gameObject:SetActive(true)
    View.Group_Monopolis.Group_RewardList.ScrollGrid_RewardList.grid.self:SetDataCount(#rankList)
    View.Group_Monopolis.Group_RewardList.ScrollGrid_RewardList.grid.self:RefreshAllElement()
    View.Group_Monopolis.Group_RewardList.ScrollGrid_RewardList.grid.self:MoveToTop()
  else
    View.Group_Monopolis.Group_RewardList.ScrollGrid_RewardList.grid.self.gameObject:SetActive(false)
  end
end

function UIGridMenuManager.RefreshRankRewardElement(element, elementIndex)
  if not element or not UIGridMenuManager.gridInfo_rank then
    return
  end
  local rankList = {}
  if UIGridMenuManager.curRewardType == 1 then
    rankList = UIGridMenuManager.gridInfo_rank.rankInningList or {}
  else
    rankList = UIGridMenuManager.gridInfo_rank.rankIssueList or {}
  end
  local info = rankList[elementIndex]
  if not info then
    return
  end
  local lsInfo = rankList[elementIndex - 1]
  local rank = GetText(80609831)
  if lsInfo then
    local of = info.rank - lsInfo.rank
    if 1 < of then
      rank = string.format(rank, tostring(lsInfo.rank + 1) .. "~" .. tostring(info.rank))
    else
      rank = string.format(rank, tostring(info.rank))
    end
  elseif 1 < info.rank then
    rank = string.format(rank, "1" .. "~" .. tostring(info.rank))
  else
    rank = string.format(rank, tostring(info.rank))
  end
  element.Txt_Rank:SetText(rank)
  local ca = PlayerData:GetFactoryData(info.reward, "ListFactory")
  if ca then
    local rewardList = ca.rewardList or {}
    element.StaticGrid_Reward.grid.self:SetParentParam(elementIndex)
    element.StaticGrid_Reward.grid.self:SetDataCount(3 < #rewardList and 3 or #rewardList)
    element.StaticGrid_Reward.grid.self:RefreshAllElement()
  end
end

function UIGridMenuManager.RefreshRewardElement(element, elementIndex)
  local index = tonumber(element.ParentParam)
  local rankList = {}
  if UIGridMenuManager.curRewardType == 1 then
    rankList = UIGridMenuManager.gridInfo_rank.rankInningList or {}
  else
    rankList = UIGridMenuManager.gridInfo_rank.rankIssueList or {}
  end
  local info = rankList[index]
  if not info then
    return
  end
  local ca = PlayerData:GetFactoryData(info.reward, "ListFactory")
  if ca then
    local rewardList = ca.rewardList or {}
    if rewardList[elementIndex] then
      BtnItem:SetItem(element, {
        id = rewardList[elementIndex].id,
        num = rewardList[elementIndex].num
      })
      element.Btn_Item:SetClickParam(rewardList[elementIndex].id)
    end
  end
end

function UIGridMenuManager.RefreshCityLv()
  if not View.Img_Plane.Img_BG.self.gameObject.activeSelf and not View.Group_Invest.self.gameObject.activeSelf then
    return
  end
  if not UIGridMenuManager.gridInfo then
    return
  end
  local lv, coin, nextCost, isFull = UIGridMenuManager.MonopolyMgr.GetGridInvestInfo(UIGridMenuManager.gridInfo.id)
  if UIGridMenuManager.curGridLv and lv > UIGridMenuManager.curGridLv then
    UIGridMenuManager.OpenLvUpShow(UIGridMenuManager.curGridLv, lv)
  end
  UIGridMenuManager.curGridLv = lv
  View.Img_Left.Group_Lv.Img_Icon.Img_.Txt_LV:SetText(tostring(lv))
  View.Img_Left.Group_Lv.Txt_CityName:SetText(UIGridMenuManager.gridInfo.name)
  if not string.nilorempty(UIGridMenuManager.gridInfo.gridImg) then
    View.Img_Left.Img_City:SetSprite(UIGridMenuManager.gridInfo.gridImg)
  end
  local ratio = isFull and 1 or coin / (nextCost == 0 and 1 or nextCost)
  View.Img_Left.Group_Lv.Txt_Exp:SetText(string.format(GetText(80609615), coin, nextCost))
  View.Img_Left.Group_Lv.Img_BG.Img_ProgressBar:SetFilledImgAmount(ratio)
  local outputNum = UIGridMenuManager.MonopolyMgr.GetCityGridOutputNum(tostring(UIGridMenuManager.gridInfo.id)) or 0
  local investCoin = UIGridMenuManager.MonopolyMgr.GetGridInvestMoney(tostring(UIGridMenuManager.gridInfo.id)) or 0
  View.Img_Plane.Img_BG.Group_Info.Txt_OutputNum:SetText(string.format(GetText(80609596), outputNum))
  View.Img_Plane.Img_BG.Group_Info.Txt_InvestNum:SetText(string.format(GetText(80609597), investCoin))
  if UIGridMenuManager.gridInfo.stationGradeList and UIGridMenuManager.gridInfo.stationGradeList[lv] then
    local outputMax = UIGridMenuManager.gridInfo.stationGradeList[lv].saveMax
    local num = UIGridMenuManager.gridInfo.stationGradeList[lv].num
    local buffRatio = UIGridMenuManager.GetBuffGodOutputNum()
    View.Img_Plane.Img_BG.Group_Info.Txt_OutPut.Img_UP:SetActive(0 < buffRatio)
    View.Img_Plane.Img_BG.Group_Info.Txt_OutPut.Img_Down:SetActive(buffRatio < 0)
    View.Img_Plane.Img_BG.Group_God.Img_Des.Img_Debuff:SetActive(buffRatio < 0)
    num = num * (1 + buffRatio)
    num = math.ceil(num)
    View.Img_Plane.Img_BG.Group_Info.Txt_OutPutLimit:SetText(string.format(GetText(80609598), outputMax))
    View.Img_Plane.Img_BG.Group_Info.Txt_OutPut:SetText(string.format(GetText(80609599), num))
  end
end

function UIGridMenuManager.OpenLvUpShow(oldLv, newLv)
  View.Group_LV:SetActive(true)
  UIGridMenuManager.PlayLvUpSound()
  View.self:PlayAnimOnce("GridMenu_Group_LV", function()
    View.Group_LV:SetActive(false)
  end)
  View.Group_LV.Img_LvUP.Txt_OldLV:SetText(tostring(oldLv))
  View.Group_LV.Img_LvUP.Txt_NewLV:SetText(tostring(newLv))
end

local function SetBuffGodShowState(state)
  View.Img_Plane.Img_BG.Group_God.Img_Des:SetActive(state)
  View.Img_Plane.Img_BG.Group_God.Group_Time:SetActive(state)
  View.Img_Plane.Img_BG.Group_God.Img_God:SetActive(state)
end

function UIGridMenuManager.GetBuffGodOutputNum()
  if not UIGridMenuManager.buffList then
    return 0
  end
  local ratio = 0
  for i = 1, #UIGridMenuManager.buffList do
    local buffInfo = PlayerData:GetFactoryData(UIGridMenuManager.buffList[i].id, "HomeBuffFactory")
    if buffInfo and buffInfo.buffType == "StationEarning" then
      ratio = ratio + buffInfo.param
    end
  end
  return ratio
end

function UIGridMenuManager.RefreshBuffGodShow()
  if not UIGridMenuManager.MonopolyMgr then
    return
  end
  local godId = UIGridMenuManager.MonopolyMgr.GetMyBuffGodId()
  if not godId then
    SetBuffGodShowState(false)
    return
  end
  local eventInfo = PlayerData:GetFactoryData(godId, "MonopolyEventFactory")
  if not eventInfo then
    SetBuffGodShowState(false)
    return
  end
  SetBuffGodShowState(true)
  View.Img_Plane.Img_BG.Group_God.Img_Des.Txt_:SetText(string.format(GetText(80609660), eventInfo.name))
  if eventInfo.buffList then
    UIGridMenuManager.buffList = eventInfo.buffList
    local count = table.count(eventInfo.buffList)
    View.Img_Plane.Img_BG.Group_God.Img_Des.StaticGrid_Txt.grid.self:SetDataCount(count)
    View.Img_Plane.Img_BG.Group_God.Img_Des.StaticGrid_Txt.grid.self:RefreshAllElement()
  end
  View.Img_Plane.Img_BG.Group_God.Img_God:SetSprite(eventInfo.buffImg)
  UIGridMenuManager.RefreshBuffGodRemainTime()
end

function UIGridMenuManager.RefreshBuffGodRemainTime()
  if not UIGridMenuManager.MonopolyMgr then
    return
  end
  local needRefresh, timeStr = UIGridMenuManager.MonopolyMgr.GetBuffGodRefreshRemainTime()
  if needRefresh then
    SetBuffGodShowState(false)
    return
  end
  View.Img_Plane.Img_BG.Group_God.Group_Time.Txt_Time:SetText(timeStr)
end

function UIGridMenuManager.RefreshDescElement(element, elementIndex)
  if not element then
    return
  end
  UIGridMenuManager.buffList = UIGridMenuManager.buffList or {}
  local info = UIGridMenuManager.buffList[elementIndex]
  if info then
    local buffInfo = PlayerData:GetFactoryData(info.id, "HomeBuffFactory")
    if buffInfo then
      element.Txt_BuffDes:SetText(tostring(elementIndex) .. "." .. tostring(buffInfo.desc))
    end
  end
end

function UIGridMenuManager.RefreshGetBtnShow()
  if not View.Img_Plane.Img_BG.self.gameObject.activeSelf then
    return
  end
  if not UIGridMenuManager.gridInfo then
    return
  end
  local outputNum = UIGridMenuManager.MonopolyMgr.GetCityGridOutputNum(tostring(UIGridMenuManager.gridInfo.id)) or 0
  View.Img_Plane.Img_BG.Btn_Get.Img_RedPoint:SetActive(0 < outputNum)
end

function UIGridMenuManager.RefreshAllMyMoneyNum()
  View.Group_Invest.Group_Right.Img_Coin.Txt_Num:SetText(PlayerData:GetGoodsById(UIGridMenuManager.MonopolyMgr.investItem).num)
end

function UIGridMenuManager.RefreshInvestRemainNum()
  if not UIGridMenuManager.gridInfo then
    return
  end
  local investNum = UIGridMenuManager.MonopolyMgr.GetGridInvestNum(tostring(UIGridMenuManager.gridInfo.id)) or 0
  local maxTime = UIGridMenuManager.MonopolyMgr.GetMaxInvestTime()
  local canInvestNum = maxTime - investNum
  View.Group_Invest.Group_Right.Group_Top.Img_InvestTimes.Txt_InvestTimes:SetText(string.format(GetText(80609849), canInvestNum))
end

function UIGridMenuManager.RefreshMyInvestMoneyNum()
  View.Group_Invest.Group_Right.Group_Top.Txt_InvestNum:SetText(UIGridMenuManager.MonopolyMgr.GetGridInvestMoney(tostring(UIGridMenuManager.gridInfo.id)))
end

function UIGridMenuManager.RefreshInvestElement(element, elementIndex)
  local info = UIGridMenuManager.investList[elementIndex]
  if not info then
    return
  end
  UIGridMenuManager.SetOneInvestElement(element, info)
  element.Btn_Invest:SetClickParam(tostring(elementIndex))
end

function UIGridMenuManager.SetOneInvestElement(element, info)
  if element == nil or info == nil then
    return
  end
  element.Group_Cost.Txt_CostNum:SetText(tostring(info.num))
  local myMoney = PlayerData:GetGoodsById(UIGridMenuManager.MonopolyMgr.investItem).num
  element.Img_Unable:SetActive(myMoney < info.num)
  element.Btn_Invest:SetActive(myMoney >= info.num)
end

function UIGridMenuManager.OnInvestElementTZBtnClick(index)
  local investNum = UIGridMenuManager.MonopolyMgr.GetGridInvestNum(tostring(UIGridMenuManager.gridInfo.id)) or 0
  local maxTime = UIGridMenuManager.MonopolyMgr.GetMaxInvestTime()
  local canInvestNum = maxTime - investNum
  if canInvestNum <= 0 then
    CommonTips.OpenTips(80601933)
    return
  end
  local info = UIGridMenuManager.investList[index]
  if not info then
    return
  end
  local myMoney = PlayerData:GetGoodsById(UIGridMenuManager.MonopolyMgr.investItem).num
  if myMoney < info.num then
    CommonTips.OpenTips(80609186)
    return
  end
  
  local function cbSuccess(json)
    if string.nilorempty(json.rc) then
      local use = {}
      use[UIGridMenuManager.MonopolyMgr.investItem] = info.num
      PlayerData:RefreshUseItems(use)
      UIGridMenuManager.MonopolyMgr.RefreshMoneyNum()
      UIGridMenuManager.RefreshAllMyMoneyNum()
      UIGridMenuManager.MonopolyMgr.AddGridInvestNum(tostring(UIGridMenuManager.gridInfo.id))
      UIGridMenuManager.RefreshInvestRemainNum()
      UIGridMenuManager.MonopolyMgr.AddGridInvestMoney(tostring(UIGridMenuManager.gridInfo.id), info.num)
      UIGridMenuManager.RefreshMyInvestMoneyNum()
      View.Group_Invest.Group_Right.ScrollGrid_InvestList.grid.self:RefreshAllElement()
      UIGridMenuManager.RefreshCityLv()
    end
  end
  
  local function cbFail(json)
    UIGridMenuManager.MonopolyMgr.CheckTimeIsOverAndBack()
  end
  
  Net:SendProto("monopoly.monopoly_invest", cbSuccess, index - 1, cbFail)
end

function UIGridMenuManager.CloseInvestPanel()
  View.self:PlayAnimOnce("Group_Invest_Out2", function()
    View.Group_Invest:SetActive(false)
    View.Img_Plane.Img_BG:SetActive(true)
    View.Img_Left:SetActive(true)
  end)
end

function UIGridMenuManager.OnInvestBtnClick()
  if not UIGridMenuManager.gridInfo then
    return
  end
  local isRank = UIGridMenuManager.gridInfo.isRank
  if not isRank then
    CommonTips.OpenTips(80609186)
    return
  end
  local moneyNum = PlayerData:GetGoodsById(UIGridMenuManager.MonopolyMgr.investItem).num
  if moneyNum <= 0 then
    CommonTips.OpenTips(80609186)
    return
  end
  UIGridMenuManager.OpenInvestPanel()
end

function UIGridMenuManager.OnRankBtnClick()
  if not UIGridMenuManager.gridInfo then
    return
  end
  local isRank = UIGridMenuManager.gridInfo.isRank
  if not isRank then
    CommonTips.OpenTips(80609186)
    return
  end
  UIGridMenuManager.OpenRankPanel(UIGridMenuManager.gridInfo.id, true)
end

function UIGridMenuManager.OnCloseBtnClick()
  if UIGridMenuManager.curPanelIndex == 3 then
    UIGridMenuManager.OpenCityMenuPanel()
  else
    UIManager:ClosePanel()
  end
end

function UIGridMenuManager.OnGetBtnClick()
  if not UIGridMenuManager.gridInfo then
    return
  end
  local outputNum = UIGridMenuManager.MonopolyMgr.GetCityGridOutputNum(tostring(UIGridMenuManager.gridInfo.id)) or 0
  if outputNum <= 0 then
    CommonTips.OpenTips(80609310)
    return
  end
  UIGridMenuManager.MonopolyMgr.ReqGetGridOutput(UIGridMenuManager.gridInfo.id, nil, function()
    UIGridMenuManager.RefreshCityLv()
    UIGridMenuManager.RefreshGetBtnShow()
  end)
end

return UIGridMenuManager
