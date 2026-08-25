local CompActivityDrawGroup, Super = NewViewComponent("CompActivityDrawGroup")

function CompActivityDrawGroup:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Event_Activity_RewardPoolResource(uiNode)
  self.lotteryTid = data.lotteryTid
  self.btnText = data.drawBtnText
  self.singleDrawconsume = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("SingleDrawconsume", self.lotteryTid)
  self.costTid = self.singleDrawconsume[1] or 0
  self.costNum = self.singleDrawconsume[2] or 0
  self.singleDrawNum = 1
  self.multiDrawNum = ActivityDrawPrizeModel.Instance:GetLotteryMultiDropTime(self.lotteryTid)
  local painting = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("NPCPaintingResources", self.lotteryTid)
  local awakerTid = AwakerDataUtils.GetAwakerTidByPainting(painting)
  if 0 == awakerTid and self.lotteryTid ~= 126065 then
    self._originalNpcPos = CS.UnityEngine.Vector2(641.0, -91.0)
    self._originalNpcScale = CS.UnityEngine.Vector3(0.61, 0.61, 1)
  end
end

function CompActivityDrawGroup:OnEnterComponent()
  self:AddButtonClickListener(self.ui.Btn_Awaker_Once, function()
    ActivityDrawPrizeController.Instance:ReqReset(self.lotteryTid, function()
      ActivityDrawPrizeModel.Instance:Set_curPage(CommonDefine.LotteryPage.Pool)
    end)
  end)
  self:RegisterLocalNotify(NotifyId.UpdateAllLotteryMultipleDrawTimes, self._RefreshAllChangeInfo, self)
  self:_Refresh()
end

function CompActivityDrawGroup:_Refresh()
  self:_RefreshDrawBtn()
  self:SetImage(self.ui.Image_Awaker_Icon_Ten, ItemDataUtils.GetItemIcon(self.costTid))
  self:SetImage(self.ui.Image_AllChange_Icon, ItemDataUtils.GetItemIcon(self.costTid))
  local coreResetRemainTime = ActivityDrawPrizeModel.Instance:GetCoreResetRemainTime(self.lotteryTid)
  self.ui.Text_Awaker_Once:SetActive(true)
  self:SetText(self.ui.Text_Awaker_Once, LT.Textf("LotteryCoreRewardResetTimes", string.format("<color=#FFFFFF>%s</color>", coreResetRemainTime)))
  local painting = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("NPCPaintingResources", self.lotteryTid)
  local awakerTid = AwakerDataUtils.GetAwakerTidByPainting(painting)
  if 0 == awakerTid then
    self.ui.Image_Npc:SetActive(self.lotteryTid ~= 126065)
    self.ui.Image_BigNpc:SetActive(self.lotteryTid == 126065)
    self.ui.Image_Awaker:SetActive(false)
    self:SetImage(self.ui.Image_Npc, painting)
    self:SetImage(self.ui.Image_BigNpc, painting)
    local activeNpcGo = self.lotteryTid == 126065 and self.ui.Image_BigNpc or self.ui.Image_Npc
    self:_ApplyNPCOffsetAndScale(activeNpcGo)
  else
    self.ui.Image_Npc:SetActive(false)
    self.ui.Image_BigNpc:SetActive(false)
    self.ui.Image_Awaker:SetActive(true)
    self:AddViewComponentOnce(self.ui.Image_Awaker, UICompAwakerPortrait, {
      awakerTid = awakerTid,
      portraitAlign = CommonDefine.PortraitAlign.Center
    })
    self:_ApplyNPCOffsetAndScale(self.ui.Image_Awaker)
  end
  self:_InitSubtitles()
  
  local function RefreshCountDown()
    local openCountDown = ActivityDrawPrizeModel.Instance:GetPrizePoolOpenCountDown(self.lotteryTid)
    local closeCountDown = ActivityDrawPrizeModel.Instance:GetPrizePoolCloseCountDown(self.lotteryTid)
    local isOpen = openCountDown <= 0
    if not isOpen then
      self.ui.Btn_Awaker_Once:SetActive(false)
      self.ui.Btn_Awaker_Ten:SetActive(false)
    end
    self.ui.Group_OpenTime:SetActive(not isOpen)
    if openCountDown > 0 then
      local d, h, _, _ = TimeUtils.ConvertTime(openCountDown)
      self:SetText(self.ui.Text_OpenTime, LT.Textf("StageUnlockCountdownText", d, h))
    end
    if closeCountDown > 0 then
      self:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(closeCountDown))
    else
      self:SetText(self.ui.Text_Time, "")
    end
  end
  
  RefreshCountDown()
  self.timer = self:BindTimer(1, -1, function()
    RefreshCountDown()
  end)
end

function CompActivityDrawGroup:_RefreshDrawBtn()
  self.ui.Btn_AllChange:SetActive(false)
  self.multiDrawNum = ActivityDrawPrizeModel.Instance:GetLotteryMultiDropTime(self.lotteryTid)
  self:SetTextColorType(self.ui.Text_Awaker_Ten, self:_GetDrawTextColorType(self.multiDrawNum))
  local canReset = ActivityDrawPrizeModel.Instance:GetPrizePoolCanReset(self.lotteryTid)
  local isDrawOut = ActivityDrawPrizeModel.Instance:GetPrizePoolIsDrawOut(self.lotteryTid)
  local coreResetRemainTime = ActivityDrawPrizeModel.Instance:GetCoreResetRemainTime(self.lotteryTid)
  if coreResetRemainTime <= 0 then
    ActivityDrawPrizeController.Instance:OnGetAllLotteryMultipleDrawTimes(self.lotteryTid)
  end
  self.ui.Btn_Awaker_Once:SetActive(canReset)
  self.ui.Btn_Awaker_Ten:SetActive(not isDrawOut)
  self:SetText(self.ui.Text_Awaker_Ten, ItemNumUtils.GetStr(self.multiDrawNum * self.costNum))
  self:_InitDrawBtnGroup(self.ui.Btn_Awaker_Ten, self.multiDrawNum)
end

function CompActivityDrawGroup:_RefreshAllChangeInfo()
  local coreResetRemainTime = ActivityDrawPrizeModel.Instance:GetCoreResetRemainTime(self.lotteryTid)
  local allChangeNum = ActivityDrawPrizeModel.Instance:GetAllLotteryMultipleDrawTimes()
  self.ui.Btn_AllChange:SetActive(coreResetRemainTime <= 0 and allChangeNum > 0)
  self:SetText(self.ui.Text_AllChange, ItemNumUtils.GetStr(self.multiDrawNum * self.costNum * allChangeNum))
  self:AddButtonClickListener(self.ui.Btn_AllChange, System.fn(self, self._OnClickAllDraw))
end

function CompActivityDrawGroup:_InitSubtitles()
  if ActivityDrawPrizeModel.Instance.curPage == CommonDefine.LotteryPage.Pool then
    self.ui.Group_Desc:SetActive(false)
    return
  end
  self.ui.Group_Desc:SetActive(true)
  local hasCoreAward = ActivityDrawPrizeModel.Instance.drawRewards.hasCoreAward
  local voiceCfgField = hasCoreAward and "CoreRewardDialogue" or "RegularRewardDialogue"
  local showVoices = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField(voiceCfgField, self.lotteryTid)
  local showVoiceKeyWord = showVoices[1]
  self:SetText(self.ui.Text_Awaker_Desc, LT.Text(showVoiceKeyWord))
end

function CompActivityDrawGroup:_InitDrawBtnGroup(obj, drawTime)
  local txt = self.btnText and self.btnText or "LotteryDrawBtnText"
  self:AddButtonClickListener(obj, function()
    self:_OnClickDraw(drawTime)
  end)
  self:SetButtonState(obj, self:_GetDrawBtnState(drawTime))
  self:SetButtonText(obj, LT.Textf(txt, drawTime))
end

function CompActivityDrawGroup:_GetDrawBtnState(drawTime)
  return CommonDefine.BtnType.High
end

function CompActivityDrawGroup:_GetDrawTextColorType(drawTime)
  return self:_CheckDrawCurrencyEnough(drawTime) and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
end

function CompActivityDrawGroup:_CheckDrawCurrencyEnough(drawTime)
  local costNumAllNum = self.costNum * drawTime
  local haveNum = ItemDataUtils.GetItemNum(self.costTid) or 0
  return costNumAllNum <= haveNum
end

function CompActivityDrawGroup:_OnClickDraw(drawTime)
  if not self:_CheckDrawCurrencyEnough(drawTime) then
    Alert.ShowWithParams(10825, {
      ItemDataUtils.GetItemName(self.costTid)
    })
    return
  end
  ActivityDrawPrizeController.Instance:ReqLottery(self.lotteryTid, drawTime, function(rewardList)
    local isDrawOut = ActivityDrawPrizeModel.Instance:GetPrizePoolIsDrawOut(self.lotteryTid)
    if isDrawOut then
      Alert.Show(10828)
    end
    local isDrawCoreReward = false
    for _, rewardData in pairs(rewardList.items or {}) do
      local itemTid = rewardData.tid
      local rewardType = ActivityDrawPrizeModel.Instance:GetRewardItemRewardType(self.lotteryTid, itemTid, rewardData.num)
      if rewardType == CommonDefine.LotteryRewardType.Core then
        isDrawCoreReward = true
      end
    end
    local soundEventList
    if isDrawCoreReward then
      soundEventList = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("CoreRewardSE", self.lotteryTid)
    else
      soundEventList = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("RegularRewardSE", self.lotteryTid)
    end
    local soundEvent = soundEventList and soundEventList[1]
    if soundEvent then
      AudioManager.Instance:PostSoundEvent(soundEvent)
    end
    ActivityDrawPrizeModel.Instance:Set_drawRewards(rewardList)
    ActivityDrawPrizeModel.Instance:Set_curPage(CommonDefine.LotteryPage.Result)
  end)
end

function CompActivityDrawGroup:_OnClickAllDraw()
  if not self:_CheckDrawCurrencyEnough(self.multiDrawNum) then
    Alert.ShowWithParams(10825, {
      ItemDataUtils.GetItemName(self.costTid)
    })
    return
  end
  ActivityDrawPrizeController.Instance:ReqAllLottery(self.lotteryTid, function(rewardList)
    local isDrawCoreReward = false
    for _, rewardData in pairs(rewardList.items or {}) do
      local itemTid = rewardData.tid
      local rewardType = ActivityDrawPrizeModel.Instance:GetRewardItemRewardType(self.lotteryTid, itemTid, rewardData.num)
      if rewardType == CommonDefine.LotteryRewardType.Core then
        isDrawCoreReward = true
      end
    end
    local soundEventList
    if isDrawCoreReward then
      soundEventList = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("CoreRewardSE", self.lotteryTid)
    else
      soundEventList = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("RegularRewardSE", self.lotteryTid)
    end
    local soundEvent = soundEventList and soundEventList[1]
    if soundEvent then
      AudioManager.Instance:PostSoundEvent(soundEvent)
    end
    ActivityDrawPrizeModel.Instance:Set_drawRewards(rewardList)
    ActivityDrawPrizeModel.Instance:Set_curPage(CommonDefine.LotteryPage.Result)
  end)
end

function CompActivityDrawGroup:_ParseNPCOffsetAndScale()
  local raw = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("NPCOffsetAndScale", self.lotteryTid)
  if not raw then
    return nil
  end
  if type(raw) == "table" then
    return tonumber(raw[1]) or 0, tonumber(raw[2]) or 0, tonumber(raw[3]) or 1
  end
  return nil
end

function CompActivityDrawGroup:_ApplyNPCOffsetAndScale(targetGo)
  if not targetGo or not self._originalNpcPos then
    return
  end
  local offsetX, offsetY, scale = self:_ParseNPCOffsetAndScale()
  if not offsetX then
    return
  end
  targetGo.transform.anchoredPosition = CS.UnityEngine.Vector2(self._originalNpcPos.x + offsetX, self._originalNpcPos.y + offsetY)
  targetGo.transform.localScale = CS.UnityEngine.Vector3(self._originalNpcScale.x * scale, self._originalNpcScale.y * scale, 1)
end

function CompActivityDrawGroup:_RestoreNpcAlpha()
  local npcNodes = {
    self.ui.Image_Npc,
    self.ui.Image_BigNpc,
    self.ui.Image_Awaker
  }
  for _, node in ipairs(npcNodes) do
    if node then
      local image = node:GetComponent(typeof(CS.UnityEngine.UI.Image))
      if image then
        image.color = CS.UnityEngine.Color(1, 1, 1, 1)
      end
    end
  end
end

function CompActivityDrawGroup:OnExitComponent()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
  Super.OnExitComponent(self)
end

return CompActivityDrawGroup
