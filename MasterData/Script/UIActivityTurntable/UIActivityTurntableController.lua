local View = require("UIActivityTurntable/UIActivityTurntableView")
local DataModel = require("UIActivityTurntable/UIActivityTurntableDataModel")
local CommonItem = require("Common/BtnItem")
local ActivityMainController = require("UIActivityMain/UIActivityMainController")
local Controller = {
  curIndex = 1,
  rewardIndex = 1,
  curSelectedImg = nil,
  isTurning = false,
  stopIndex = 0
}

function Controller.ReqTurnInfoAndRefreshContent()
  Net:SendProto("turntable.info", function(json)
    if json and string.nilorempty(json.rc) then
      DataModel.ParseProtoInfo(json.turntable)
      DataModel.InitTempDailyCnt()
      Controller.RefreshContentShow()
    end
  end)
end

function Controller.Init()
  Controller.ReqTurnInfoAndRefreshContent()
  DataModel.InitDayRefreshTime()
end

function Controller.OnUpdate()
  Controller.DayRefreshOrderPanel()
end

function Controller.Release()
  TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
  Controller.curSelectedImg = nil
  Controller.isTurning = false
  Controller.curIndex = 1
  Controller.stopIndex = 0
  DataModel.TempRewardCountList = {}
  DataModel.allWeight = 0
end

function Controller.DayRefreshOrderPanel()
  if TimeUtil:GetServerTimeStamp() > DataModel.nextRefreshTime then
    DataModel.InitDayRefreshTime()
    Controller.ReqTurnInfoAndRefreshContent()
  end
end

function Controller.RefreshContentShow()
  if not DataModel.turntableProtoInfo then
    return
  end
  Controller.RefreshRewardList()
  Controller.RefreshBestReward()
  Controller.RefreshMoney()
  Controller.RefreshRemainTurnTime()
  Controller.RefreshTurnCost()
  Controller.RefreshSkip()
  Controller.RefreshEndTimeShow()
end

function Controller.RefreshRewardList()
  local rewardList = DataModel.rewardList
  if not rewardList then
    return
  end
  DataModel.TempRewardCountList = {}
  View.Group_Main.StaticGrid_Reward.grid.self:SetDataCount(#rewardList)
  View.Group_Main.StaticGrid_Reward.grid.self:RefreshAllElement()
end

function Controller.RefreshRewardElement(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  local rewardList = DataModel.rewardList
  if not rewardList then
    return
  end
  local rewardInfo = rewardList[elementIndex]
  if not rewardInfo then
    return
  end
  element.Img_Selected:SetActive(Controller.stopIndex == elementIndex)
  element.Group_Best:SetActive(rewardInfo.isBest)
  local itemCa = PlayerData:GetFactoryData(rewardInfo.id)
  if itemCa then
    local quality_int
    if itemCa.qualityInt ~= nil then
      quality_int = itemCa.qualityInt + 1
    elseif itemCa.rarityInt ~= nil then
      quality_int = itemCa.rarityInt + 1
    else
      quality_int = 1
    end
    if DataModel.boxPathList and DataModel.boxPathList[quality_int] then
      element.Img_Bottom:SetSprite(DataModel.boxPathList[quality_int].path)
    end
    element.Img_Item:SetSprite(itemCa.iconPath or itemCa.imagePath)
    element.Txt_Num:SetText(tostring(rewardInfo.num))
    local factoryName = DataManager:GetFactoryNameById(rewardInfo.id)
    if factoryName == "UnitViewFactory" then
      element.Group_Break:SetActive(true)
      element.Group_Break.Img_Mask.Img_Face:SetSprite(itemCa.face)
    else
      element.Group_Break:SetActive(false)
    end
  end
  element.Btn_Item:SetClickParam(rewardInfo.id)
  local remainCount = DataModel.GetRemainCountByIndex(elementIndex)
  element.Group_Finish:SetActive(remainCount == 0)
  if remainCount == -1 then
    element.Txt_T:SetActive(false)
  else
    element.Txt_T:SetActive(true)
    element.Txt_T:SetText(string.format(GetText(80611805), remainCount))
  end
  DataModel.TempRewardCountList[elementIndex] = remainCount
end

function Controller.RefreshElementRemainCountShow(element, remainCount)
  if not element or not remainCount then
    return
  end
  element:Find("Group_Finish").gameObject:SetActive(remainCount == 0)
  local txtT = element:Find("Txt_T").gameObject:GetComponent(typeof(CS.Seven.UITxt))
  if remainCount == -1 then
    txtT.gameObject:SetActive(false)
  else
    txtT.gameObject:SetActive(true)
    txtT:SetText(string.format(GetText(80611805), remainCount))
  end
end

function Controller.RefreshMoney()
  local user_info = PlayerData:GetUserInfo()
  if user_info then
    View.Group_Main.Group_GoldCoin.Txt_Num:SetText(user_info.gold or 0)
  end
  View.Group_Main.Group_Diamond.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num or 0)
  if DataModel.activityCfg and DataModel.activityCfg.turntableCoinId then
    local itemCa = PlayerData:GetFactoryData(DataModel.activityCfg.turntableCoinId, "ItemFactory")
    if itemCa and not string.nilorempty(itemCa.iconPath) then
      View.Group_Main.Group_ItemCoin.Img_Icon:SetSprite(itemCa.iconPath)
    end
    local num = PlayerData:GetGoodsById(DataModel.activityCfg.turntableCoinId).num or 0
    View.Group_Main.Group_ItemCoin.Txt_Num:SetText(num)
  end
end

function Controller.RefreshBestReward()
  local isAllBestGot = DataModel.GetIsAllBestGot()
  if isAllBestGot then
    View.Group_Main.Txt_Score:SetText(GetText(80611823))
  else
    View.Group_Main.Txt_Score:SetText(string.format(GetText(80611806), DataModel.GetMustBestNeedCount()))
  end
  if DataModel.activityCfg then
    View.Group_Main.Txt_T1:SetText(tostring(DataModel.activityCfg.turntableName1))
    if not string.nilorempty(DataModel.activityCfg.turntableName2) then
      View.Group_Main.Txt_T2:SetText(DataModel.activityCfg.turntableName2)
    end
    if not string.nilorempty(DataModel.activityCfg.turntableBgPath) then
      View.Group_Main.Img_Poster:SetSprite(DataModel.activityCfg.turntableBgPath)
    end
    local isNoneView = DataModel.activityCfg.turntableViewType == "None"
    View.Group_Main.Btn_View:SetActive(not isNoneView)
  end
  local canNotGetCount = DataModel.GetMustNotGetBestCount() or 0
  View.Group_Main.Txt_Pre:SetText(canNotGetCount <= 0 and GetText(80611899) or string.format(GetText(80611898), canNotGetCount))
end

function Controller.RefreshRemainTurnTime()
  View.Group_Main.Txt_D:SetText(string.format(GetText(80611807), DataModel.GetRemainTurnTime()))
end

function Controller.RefreshTurnCost()
  if DataModel.singleCostCfg then
    local itemCa = PlayerData:GetFactoryData(DataModel.singleCostCfg.id, "ItemFactory")
    if itemCa and not string.nilorempty(itemCa.buyPath) then
      View.Group_Main.Btn_One.Group_Cost.Img_Icon:SetSprite(itemCa.buyPath)
    end
    View.Group_Main.Btn_One.Group_Cost.Txt_Num:SetText(DataModel.singleCostCfg.num)
  end
  if DataModel.multiCostCfg then
    local itemCa = PlayerData:GetFactoryData(DataModel.multiCostCfg.id, "ItemFactory")
    if itemCa and not string.nilorempty(itemCa.buyPath) then
      View.Group_Main.Btn_Many.Group_Cost.Img_Icon:SetSprite(itemCa.buyPath)
    end
    View.Group_Main.Btn_Many.Txt_T:SetText(string.format(GetText(80611808), DataModel.multiTimes))
    View.Group_Main.Btn_Many.Group_Cost.Txt_Num:SetText(DataModel.multiCostCfg.num)
  end
end

function Controller.RefreshSkip()
  View.Group_Main.Group_Skip.Btn_Skip.Img_Selected:SetActive(DataModel.isSkip)
end

function Controller.OnSkipBtnClick()
  DataModel.isSkip = not DataModel.isSkip
  PlayerData:SetPlayerPrefs("int", "Activity_Turntable_Skip_State", DataModel.isSkip and 1 or 0)
  Controller.RefreshSkip()
end

function Controller.ShowBuyItem()
  DataModel.IsEnough = false
  local itemId = 0
  local needNum = 0
  if DataModel.IsSingle then
    if not DataModel.singleCostCfg then
      return
    end
    itemId = DataModel.singleCostCfg.id
    needNum = DataModel.singleCostCfg.num or 0
  else
    if not DataModel.multiCostCfg then
      return
    end
    itemId = DataModel.multiCostCfg.id
    needNum = DataModel.multiCostCfg.num or 0
  end
  local hasNum = PlayerData:GetGoodsById(itemId).num or 0
  local itemCa = PlayerData:GetFactoryData(itemId, "ItemFactory")
  DataModel.MoneyNum = PlayerData:GetGoodsById(DataModel.moneyId).num or 0
  if needNum <= hasNum then
    View.Group_BuyItem.self:SetActive(true)
    DataModel.IsEnough = true
    CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item1, {id = itemId, num = hasNum})
    CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item2, {
      id = itemId,
      num = hasNum - needNum
    })
    if itemCa then
      View.Group_BuyItem.Group_Middle.Txt_Des:SetText(string.format(GetText(80611896), needNum, itemCa.name))
    end
    View.Group_BuyItem.Group_Middle.Txt_Have:SetActive(false)
  else
    if not DataModel.activityCfg.isTurntableBuy then
      View.Group_BuyItem.self:SetActive(false)
      CommonTips.OpenTips(80600488)
      return
    end
    View.Group_BuyItem.self:SetActive(true)
    DataModel.IsEnough = false
    local offsetNum = needNum - hasNum
    local costMoney = offsetNum * DataModel.onceCostMoneyNum
    CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item1, {
      id = DataModel.moneyId,
      num = costMoney
    })
    CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item2, {id = itemId, num = offsetNum})
    local moneyItemCa = PlayerData:GetFactoryData(DataModel.moneyId, "ItemFactory")
    if moneyItemCa then
      View.Group_BuyItem.Group_Middle.Txt_Des:SetText(string.format(GetText(80611897), costMoney, moneyItemCa.name, offsetNum, itemCa.name))
    end
    DataModel.Price = costMoney
    DataModel.NeedNum = offsetNum
    View.Group_BuyItem.Group_Middle.Txt_Have:SetActive(true)
    View.Group_BuyItem.Group_Middle.Txt_Have:SetText(string.format(GetText(80600521), DataModel.MoneyNum))
  end
end

function Controller.OnOneBtnClick()
  local isAllItemGot = DataModel.GetIsAllTurntableItemGot()
  if isAllItemGot then
    CommonTips.OpenTips(80611906)
    return
  end
  DataModel.IsSingle = true
  Controller.ShowBuyItem()
end

function Controller.OnManyBtnClick()
  local isAllItemGot = DataModel.GetIsAllTurntableItemGot()
  if isAllItemGot then
    CommonTips.OpenTips(80611906)
    return
  end
  local isLessThan = DataModel.GetIsItemRemainLessTen()
  if isLessThan then
    CommonTips.OpenTips(80611907)
    return
  end
  DataModel.IsSingle = false
  Controller.ShowBuyItem()
end

function Controller.OnBuyItemConfirmBtnClick()
  if not DataModel.IsEnough and DataModel.Price > DataModel.MoneyNum then
    local function callback()
      CommonTips.OpenStoreBuy()
    end
    
    CommonTips.OnPrompt(80600147, GetText(80600068), GetText(80600067), callback)
  else
    local function cb()
      View.Group_BuyItem.self:SetActive(false)
      
      Controller.SendTurnReq()
    end
    
    if DataModel.IsEnough then
      cb()
    else
      Net:SendProto("shop.buy", function(json)
        cb(json)
      end, tostring(DataModel.ShopId), 1, DataModel.NeedNum, DataModel.CommodityId)
    end
  end
end

function Controller.OnSkinDetailBtnClick()
  if not DataModel.activityCfg then
    return
  end
  if DataModel.activityCfg.turntableViewType == "None" then
    return
  end
  if DataModel.activityCfg.turntableViewType == "Skin" then
    CommonTips.OpenSkinViewTips({
      id = DataModel.activityCfg.turntableViewId,
      isSkinView = true
    }, nil, false)
  end
end

function Controller.SendTurnReq()
  local isSingle = DataModel.IsSingle
  if Controller.isTurning then
    return
  end
  local isCan = DataModel.GetIsCanTurn(isSingle)
  if not isCan then
    return
  end
  Net:SendProto("turntable.turn", function(json)
    if json and string.nilorempty(json.rc) then
      DataModel.getRewardList = {}
      if json.turns then
        for i = 1, #json.turns do
          local index = tonumber(json.turns[i])
          if index then
            index = index + 1
            table.insert(DataModel.getRewardList, index)
          end
        end
      end
      DataModel.ParseProtoInfo(json.turntable)
      local costItem = {}
      if isSingle then
        if DataModel.singleCostCfg then
          costItem[DataModel.singleCostCfg.id] = DataModel.singleCostCfg.num
        end
      elseif DataModel.multiCostCfg then
        costItem[DataModel.multiCostCfg.id] = DataModel.multiCostCfg.num
      end
      PlayerData:RefreshUseItems(costItem)
      ActivityMainController:RefreshLeftRedState()
      if DataModel.isSkip then
        DataModel.AddDailyTurnTime(isSingle)
        local rewardList = {}
        for i = 1, #DataModel.getRewardList do
          local rewardInfo = DataModel.rewardList[DataModel.getRewardList[i]]
          if rewardInfo then
            local temp = {}
            temp.id = rewardInfo.id
            temp.num = rewardInfo.num
            table.insert(rewardList, temp)
          end
        end
        local t = {}
        t.clientCustom = rewardList
        CommonTips.OpenShowItem(t)
        local lastIndex = DataModel.getRewardList[#DataModel.getRewardList]
        Controller.stopIndex = lastIndex or 0
        Controller.curIndex = lastIndex or 1
        Controller.RefreshContentShow()
      else
        Controller.RefreshMoney()
        Controller.RefreshBestReward()
        Controller.DoStartCircleAni()
      end
    end
  end, isSingle and 1 or DataModel.multiTimes, DataModel.activityId)
end

function Controller.DoStartCircleAni()
  if not (DataModel.rewardList and DataModel.getRewardList) or #DataModel.getRewardList == 0 then
    return
  end
  DataModel.AddDailyTurnTime(true)
  Controller.RefreshRemainTurnTime()
  Controller.isTurning = true
  View.Img_Mask:SetActive(true)
  Controller.curIndex = Controller.curIndex or 1
  TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
  local tempIndex = Controller.curIndex
  local element = View.Group_Main.StaticGrid_Reward.grid.self:GetChildByIndex(tempIndex - 1)
  local count = 1
  if Controller.curSelectedImg then
    Controller.curSelectedImg.gameObject:SetActive(false)
  end
  local imgSelected = element:Find("Img_Selected")
  imgSelected.gameObject:SetActive(true)
  Controller.curSelectedImg = imgSelected
  TimerHelper.Start("Activity_Turntable_BeforeCircle_Timer", DataModel.circleInterval, function()
    tempIndex = tempIndex + 1
    count = count + 1
    if tempIndex > #DataModel.rewardList then
      tempIndex = 1
    end
    element = View.Group_Main.StaticGrid_Reward.grid.self:GetChildByIndex(tempIndex - 1)
    if Controller.curSelectedImg then
      Controller.curSelectedImg.gameObject:SetActive(false)
    end
    imgSelected = element:Find("Img_Selected")
    imgSelected.gameObject:SetActive(true)
    Controller.curSelectedImg = imgSelected
    Controller.PlaySound(DataModel.turnSoundId)
    if count >= DataModel.beforeCircleCount * #DataModel.rewardList + 1 then
      TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
      Controller.DoLastCircleAni()
    end
  end)
end

function Controller.DoLastCircleAni()
  if not DataModel.getRewardList or #DataModel.getRewardList == 0 then
    return
  end
  Controller.rewardIndex = DataModel.getRewardList[1]
  local lastIndexList = DataModel.GetLastAnimationIndexListByIndex(Controller.rewardIndex)
  if not lastIndexList or #lastIndexList == 0 then
    return
  end
  local firstIndex = lastIndexList[1]
  local offsetIndex = Controller.rewardIndex - Controller.curIndex
  if offsetIndex == DataModel.lastShowCount then
    Controller.DoFinalAniFunc(Controller.curIndex)
  else
    local tempIndex = Controller.curIndex
    TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
    TimerHelper.Start("Activity_Turntable_BeforeCircle_Timer", DataModel.circleInterval, function()
      if Controller.curSelectedImg then
        Controller.curSelectedImg.gameObject:SetActive(false)
      end
      tempIndex = tempIndex + 1
      if tempIndex > #DataModel.rewardList then
        tempIndex = 1
      end
      local element = View.Group_Main.StaticGrid_Reward.grid.self:GetChildByIndex(tempIndex - 1)
      local imgSelected = element:Find("Img_Selected")
      imgSelected.gameObject:SetActive(true)
      Controller.curSelectedImg = imgSelected
      Controller.PlaySound(DataModel.turnSoundId)
      if tempIndex == #DataModel.rewardList and firstIndex == 1 or tempIndex == firstIndex - 1 then
        Controller.DoFinalAniFunc(tempIndex)
      end
    end)
  end
end

function Controller.DoFinalAniFunc(startIndex)
  local interval = DataModel.circleInterval * 2
  local tempInterval = 0
  local tempIndex = startIndex
  TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
  TimerHelper.Start("Activity_Turntable_BeforeCircle_Timer", DataModel.circleInterval, function()
    tempInterval = tempInterval + DataModel.circleInterval
    if tempInterval == interval then
      tempInterval = 0
      interval = interval + DataModel.circleInterval
      tempIndex = tempIndex + 1
      if tempIndex > #DataModel.rewardList then
        tempIndex = 1
      end
      if Controller.curSelectedImg then
        Controller.curSelectedImg.gameObject:SetActive(false)
      end
      local element = View.Group_Main.StaticGrid_Reward.grid.self:GetChildByIndex(tempIndex - 1)
      local imgSelected = element:Find("Img_Selected")
      imgSelected.gameObject:SetActive(true)
      Controller.curSelectedImg = imgSelected
      Controller.PlaySound(DataModel.turnSoundId)
      if tempIndex == Controller.rewardIndex then
        TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
        Controller.curIndex = Controller.rewardIndex
        Controller.PlaySound(DataModel.selectSoundId)
        table.remove(DataModel.getRewardList, 1)
        DataModel.TempRewardCountList[tempIndex] = DataModel.TempRewardCountList[tempIndex] or 0
        if 0 < DataModel.TempRewardCountList[tempIndex] then
          DataModel.TempRewardCountList[tempIndex] = DataModel.TempRewardCountList[tempIndex] - 1
          Controller.RefreshElementRemainCountShow(element, DataModel.TempRewardCountList[tempIndex])
        end
        local rewardInfo = DataModel.rewardList[Controller.rewardIndex]
        if rewardInfo then
          TimerHelper.Start("Activity_Turntable_BeforeCircle_Timer", 0.3, function()
            TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
            
            local function doStopFunc()
              TimerHelper.Stop("Activity_Turntable_BeforeCircle_Timer")
              if not (DataModel.rewardList and DataModel.getRewardList) or #DataModel.getRewardList == 0 then
                Controller.isTurning = false
                Controller.stopIndex = Controller.curIndex
                DataModel.InitTempDailyCnt()
                Controller.RefreshContentShow()
                View.Img_Mask:SetActive(false)
              else
                Controller.DoStartCircleAni()
              end
            end
            
            CommonTips.OpenShowItem({
              items = {
                [tostring(rewardInfo.id)] = {
                  num = rewardInfo.num
                }
              }
            }, function()
              doStopFunc()
            end, nil, true)
            TimerHelper.Start("Activity_Turntable_BeforeCircle_Timer", DataModel.itemTipsStayTime, function()
              UIManager:CloseTip("UI/Common/ShowItem")
              doStopFunc()
            end)
          end)
        end
      end
    end
  end)
end

function Controller.PlaySound(id)
  if not id then
    return
  end
  local sound = SoundManager:CreateSound(id)
  if sound then
    sound:Play()
  end
end

function Controller.RefreshEndTimeShow()
  if not DataModel.activityCfg then
    return
  end
  View.Group_Main.Txt_Time:SetText(string.format(GetText(80610042), DataModel.activityCfg.endTime))
end

function Controller.ShowProbabilityPanel()
  if not DataModel.probabilityRewardList then
    return
  end
  View.Group_Probability:SetActive(true)
  View.Group_Probability.Group_Probability.ScrollGrid_detail.grid.self:SetDataCount(#DataModel.probabilityRewardList)
  View.Group_Probability.Group_Probability.ScrollGrid_detail.grid.self:RefreshAllElement()
end

function Controller.RefreshProbabilityItemElement(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  if not DataModel.probabilityRewardList then
    return
  end
  local rewardInfo = DataModel.probabilityRewardList[elementIndex]
  if not rewardInfo then
    return
  end
  local itemCa = PlayerData:GetFactoryData(rewardInfo.id)
  local factoryName = DataManager:GetFactoryNameById(rewardInfo.id)
  local itemName = factoryName == "UnitViewFactory" and itemCa.SkinName or itemCa.name
  element.Txt_Name:SetText(string.format(GetText(80611908), itemName, rewardInfo.num))
  element.Txt_Num:SetText(rewardInfo.max == 0 and GetText(80611909) or tostring(rewardInfo.max))
  DataModel.allWeight = DataModel.allWeight == 0 and 1 or DataModel.allWeight
  element.Txt_Probability:SetText(tostring(PlayerData:GetPreciseDecimalFloor(rewardInfo.weight / DataModel.allWeight * 100, 1) .. "%"))
end

return Controller
