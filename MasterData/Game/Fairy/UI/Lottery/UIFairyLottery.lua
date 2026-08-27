local UIFairyLottery = class("UIFairyLottery", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local cs_ResLoader = CS.ResLoader
local cs_Ease = CS.DG.Tweening.Ease

function UIFairyLottery:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_bg, self, self._Back)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_coin, self, self._OnClickShowLotteryItem)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.__OnClickShowTip)
  UIUtil.AddButtonListener(self.ui.btn_1Lottery, self, self.__OnClickDrillOne)
  UIUtil.AddButtonListener(self.ui.btn_10Lottery, self, self.__OnClickDrillTan)
  UIUtil.AddButtonListener(self.ui.Btn_Next, self, self._OnClickToNextLottery)
  UIUtil.AddButtonListener(self.ui.Btn_Last, self, self._OnClickToLastLottery)
  self.__onceCallback = BindCallback(self, self.__OnDrillCompelete, false)
  self.__tenCallback = BindCallback(self, self.__OnDrillCompelete, true)
  self.__RefreshLotteryUI = BindCallback(self, function()
    self:SwitchFairyLottery(self.fairyLotteryPoolPageIndex)
  end)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshLotteryUI)
  self.resloader = cs_ResLoader.Create()
  self.countSizeX = self.ui.rect_count.sizeDelta.x
  self.countDefaultPos = self.ui.rect_CurrNum.anchoredPosition
end

function UIFairyLottery:InitFairyLottery()
  self.lotteryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
  self.fairyLotteryPoolDataList = PlayerDataCenter.allLtrData:GetFairyLtrPoolDataList()
  self:SwitchFairyLottery(1)
  self:RefreshFairyLotterySwitchStage()
end

function UIFairyLottery:RefreshLotteryUI(showfairyCfg, resCfg)
  local ltrCfg = self:GetCurrentFairyLotteryPoolData():GetLtrPoolDataCfg()
  local lotteryCostItemId1 = ltrCfg.costId1
  local lotteryCostItemId2 = ltrCfg.costId2
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(lotteryCostItemId1)
  self.ui.tex_Count.text = tostring(PlayerDataCenter:GetItemCount(lotteryCostItemId1))
  self.ui.img_smallIcon1.sprite = CRH:GetSpriteByItemId(lotteryCostItemId1, true)
  self.ui.img_smallIcon10.sprite = CRH:GetSpriteByItemId(lotteryCostItemId2, true)
  self.__lotteryItemId = lotteryCostItemId1
  local fairyLotteryPoolData = self:GetCurrentFairyLotteryPoolData()
  local ptNum = fairyLotteryPoolData:GetLtrPoolTotalNum()
  local maxPtNum = fairyLotteryPoolData:GetFirstBigPrizeNum()
  local isLimit = fairyLotteryPoolData:IsLtrPoolLimitTime()
  local hasGetFirstGuarantee = false
  self:RefreshGuaranteedCount(hasGetFirstGuarantee, ptNum, maxPtNum)
  self:RefreshLimitFairyName(isLimit, LanguageUtil.GetLocaleText(showfairyCfg.name), LanguageUtil.GetLocaleText(ltrCfg.intro_des))
  local startTime, endTime = fairyLotteryPoolData:GetStartAndEndTime()
  self:RefreshLimitTime(isLimit, endTime)
  local picPath = PathConsts:GetFairyPicPath(resCfg.src_id_pic)
  self:RefreshFairyImage(picPath)
  local bgImagePath = isLimit and "Res/Images/NoAtlas/UI_FairyLotteryBG2.png" or "Res/Images/NoAtlas/UI_FairyLotteryBG.png"
  self:RefreshBgImage(bgImagePath)
  UIUtil.RefreshTopResId({
    self.__lotteryItemId
  })
end

function UIFairyLottery:GetCurrentFairyLotteryPoolData()
  return self.fairyLotteryPoolDataList[self.fairyLotteryPoolPageIndex]
end

function UIFairyLottery:RefreshGuaranteedCount(isLtrPt, currentCount, allCount)
  self.ui.LotteryProgress:SetActive(isLtrPt)
  if isLtrPt then
    self.ui.tex_GuaranteedProgress:SetIndex(0, tostring(currentCount), tostring(allCount))
  end
end

function UIFairyLottery:RefreshLimitFairyName(isLimit, name, des)
  self.ui.tex_FairyName.text = name
  self:RefreshLimitFairyUpName(isLimit, des)
end

function UIFairyLottery:RefreshLimitFairyUpName(isLimit, des)
  self.ui.tex_fariyUpName.gameObject:SetActive(isLimit)
  self.ui.tex_fariyUpName.text.text = des
end

function UIFairyLottery:RefreshLimitTime(isLimit, endTime)
  self.ui.LotteryTime:SetActive(isLimit)
  if self._countdownTimerId ~= nil then
    TimerManager:StopTimer(self._countdownTimerId)
    self._countdownTimerId = nil
  end
  if isLimit then
    self.ui.tex_LimitTime:SetIndex(0, TimeUtil:TimestampToDateString(endTime, false, true))
    self:__CountDownEndTime()
    self._countdownTimerId = TimerManager:StartTimer(1, self.__CountDownEndTime, self)
  end
end

function UIFairyLottery:RefreshFairyImage(picPath)
  self.ui.img_Fairy.enabled = false
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if not IsNull(texture) and not IsNull(self.ui.img_Fairy) then
      self.ui.img_Fairy.texture = texture
      self.ui.img_Fairy.enabled = true
    end
  end)
end

function UIFairyLottery:RefreshBgImage(picPath)
  self.ui.Bottom.enabled = false
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if not IsNull(texture) and not IsNull(self.ui.Bottom) then
      self.ui.Bottom.texture = texture
      self.ui.Bottom.enabled = true
    end
  end)
end

function UIFairyLottery:RefreshFairyLotterySwitchStage()
  local isMulti = #self.fairyLotteryPoolDataList > 1
  self.ui.Btn_Next.gameObject:SetActive(isMulti and self.fairyLotteryPoolPageIndex < #self.fairyLotteryPoolDataList)
  self.ui.Btn_Last.gameObject:SetActive(isMulti and 1 < self.fairyLotteryPoolPageIndex)
  self.ui.obj_PageDotList:SetActive(isMulti)
end

function UIFairyLottery:SwitchFairyLottery(pageIndex)
  local newFairyLotteryPoolData = self.fairyLotteryPoolDataList[pageIndex]
  if newFairyLotteryPoolData == nil then
    error("not have legal fairy lottery pool, pls check")
    return
  end
  self.fairyLotteryPoolPageIndex = pageIndex
  local ltrCfg = newFairyLotteryPoolData:GetLtrPoolDataCfg()
  local poolId = ltrCfg.lottery_id
  self.lotteryCtrl:SelectLtrPool(poolId)
  local isUp, upFairyId = table.unpack(newFairyLotteryPoolData:IsHeroInfoBtnOpen())
  local showfairyId = isUp and upFairyId or 1
  local showfairyCfg = ConfigData.fairy_data[showfairyId]
  local dafultSkinId = showfairyCfg.src_id
  local resCfg = ConfigData.fairy_res[dafultSkinId][3]
  self:RefreshLotteryUI(showfairyCfg, resCfg)
  self:PlayUIFairyLotteryAnim()
  self:RefreshPageDot()
end

function UIFairyLottery:__CountDownEndTime()
  local startTime, endTime = self:GetCurrentFairyLotteryPoolData():GetStartAndEndTime()
  local diff = endTime - PlayerDataCenter.timestamp
  if 0 < diff then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diff, false, true)
    if 0 < d then
      self.ui.tex_TimeLeft:SetIndex(0, string.format("%02d", d), string.format("%02d", h))
    else
      self.ui.tex_TimeLeft:SetIndex(1, string.format("%02d", h), string.format("%02d", m))
    end
  else
    self.ui.tex_TimeLeft:SetIndex(1, "00", "00")
    if self._countdownTimerId ~= nil then
      TimerManager:StopTimer(self._countdownTimerId)
      self._countdownTimerId = nil
    end
  end
end

function UIFairyLottery:__OnClickShowTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryPoolDetail, function(win)
    if win == nil then
      return
    end
    win:InitLtrPoolDetail(self:GetCurrentFairyLotteryPoolData(), nil, function()
    end)
  end)
end

function UIFairyLottery:__OnClickDrillOne()
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  if fairyCtrl and fairyCtrl:GetFairyCountIsMax() then
    local msg = string.format(ConfigData:GetTipContent(22017))
    cs_MessageCommon.ShowMessageBox(msg, function()
      JumpManager:Jump(JumpManager.eJumpTarget.DynFairy, nil, nil, {1})
    end, nil)
    return
  end
  self.lotteryCtrl:LtrDrawOne(self.__onceCallback)
end

function UIFairyLottery:__OnClickDrillTan()
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  if fairyCtrl and fairyCtrl:GetFairyCountIsMax() then
    local msg = string.format(ConfigData:GetTipContent(22017))
    cs_MessageCommon.ShowMessageBox(msg, function()
      JumpManager:Jump(JumpManager.eJumpTarget.DynFairy, nil, nil, {1})
    end, nil)
    return
  end
  self.lotteryCtrl:LtrDrawTen(self.__tenCallback)
end

function UIFairyLottery:__OnDrillCompelete(isTan, objList)
  if objList.Count ~= 2 then
    error("fairy drill not have enough msg")
    return
  end
  local rewardList = objList[0]
  local syncUpdateDiff = objList[1]
  local index2fairyDataDic = {}
  if syncUpdateDiff.fairy ~= nil then
    local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
    local fairyUpdateList = syncUpdateDiff.fairy.data
    for _, fairyMsg in ipairs(fairyUpdateList) do
      local uid = fairyMsg.base.uid
      local fairyData = fairyCtrl:GetFairyDataByUID(uid)
      if fairyData == nil then
        error("can't get new fairyData UID:" .. tostring(uid))
      else
        local fairyItemID = fairyData:GetFairyItemID()
        for index, rewardMsg in ipairs(rewardList) do
          if rewardMsg.item == fairyItemID and index2fairyDataDic[index] == nil then
            index2fairyDataDic[index] = fairyData
            break
          end
        end
      end
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FairyLotteryShow, function(window)
    if window ~= nil then
      self:Hide()
      window:InitFairyLotteryShow(function()
        UIManager:ShowWindowAsync(UIWindowTypeID.FairyLotteryResult, function(window)
          if window ~= nil then
            window:InitFairyLotteryResult(rewardList, index2fairyDataDic, function()
              self:Show()
            end)
          end
        end)
      end)
    end
  end)
end

function UIFairyLottery:_OnClickShowLotteryItem()
  local itemId = self.__lotteryItemId
  local itemCfg = ConfigData.item[itemId]
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end)
end

function UIFairyLottery:_OnClickToNextLottery()
  if self.fairyLotteryPoolPageIndex < #self.fairyLotteryPoolDataList then
    self.fairyLotteryPoolPageIndex = self.fairyLotteryPoolPageIndex + 1
    self:SwitchFairyLottery(self.fairyLotteryPoolPageIndex)
  end
  self:RefreshFairyLotterySwitchStage()
end

function UIFairyLottery:_OnClickToLastLottery()
  if self.fairyLotteryPoolPageIndex > 1 then
    self.fairyLotteryPoolPageIndex = self.fairyLotteryPoolPageIndex - 1
    self:SwitchFairyLottery(self.fairyLotteryPoolPageIndex)
  end
  self:RefreshFairyLotterySwitchStage()
end

function UIFairyLottery:RefreshPageDot()
  if #self.fairyLotteryPoolDataList <= 1 then
    return
  end
  local totalCount = #self.fairyLotteryPoolDataList
  self.ui.rect_count.sizeDelta = Vector2.New(self.countSizeX * totalCount, self.ui.rect_count.sizeDelta.y)
  self.ui.rect_CurrNum.anchoredPosition = Vector2.Temp(self.countDefaultPos.x + self.countSizeX * (self.fairyLotteryPoolPageIndex - 1), self.countDefaultPos.y)
end

function UIFairyLottery:_Back()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFairyLottery:PlayUIFairyLotteryAnim()
  self.ui.anim_imgFairy:DOFade(0, 0.25):From():SetDelay(0.15):SetEase(cs_Ease.OutQuad):SetLink(self.gameObject)
  self.ui.anim_infoGroup:DOFade(0, 0.25):From():SetDelay(0.3):SetEase(cs_Ease.OutQuad):SetLink(self.gameObject)
end

function UIFairyLottery:__StopTween()
  self.ui.anim_imgFairy.color = Color.white
  self.ui.anim_infoGroup.alpha = 1
  self.ui.anim_imgFairy:DOComplete()
  self.ui.anim_infoGroup:DOComplete()
end

function UIFairyLottery:OnHide()
  self:__StopTween()
end

function UIFairyLottery:OnDelete()
  self:__StopTween()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshLotteryUI)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  if self._countdownTimerId ~= nil then
    TimerManager:StopTimer(self._countdownTimerId)
    self._countdownTimerId = nil
  end
  base.OnDelete(self)
end

return UIFairyLottery
