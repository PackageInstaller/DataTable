local AWKAER_SUBTITLE_SHOW_LINE = 2
local AWAKER_SUBTITLE_ROLL_TIMES = 1000
local SUBTITLES_PER_LINE_HEIGHT = 39.38
local CONTENT_ORI_HEIGHT = 16
local RectTransform = CS.UnityEngine.RectTransform
local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonResultItemDetail, Super = System.NewComponent("SummonResultItemDetail")

function SummonResultItemDetail:OnBind(binder)
  self.binder = binder
  self.binder:BindEvent(EventMgr.Instance.HideWhenCaptureScreen, System.fn(self, self.HideWhenCaptureScreen))
  self.ui.Btn_Click_1:SetActive(false)
  local sideTips = {
    self.ui.Item_Side_Tip_1,
    self.ui.Item_Side_Tip_2,
    self.ui.Item_Side_Tip_3,
    self.ui.Item_Side_Tip_4
  }
  self.extraItemInfoList = {}
  for _, gameObj in ipairs(sideTips) do
    table.insert(self.extraItemInfoList, self.binder:BindComponent(SummonResultExtraItemInfo(gameObj)))
  end
  self.awaiterList = {}
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self._isPlayingAnim then
      return
    end
    local soundID = CommonDefine.SummonSoundID.SkipItemDetail
    if soundID then
      AudioManager.Instance:PostSoundEvent(soundID)
    end
    if self.onEndOfDisplay then
      self:_Clear()
      self.onEndOfDisplay()
      self.onEndOfDisplay = nil
    end
  end)
  self.awakerPortrait = binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker))
  self.awakerPortrait:ChangeMaterialMask(CommonRes.UIPortraitMask.summonShowMask)
  self.rollAwakerSubTitleRT = self.ui.Content:GetComponent(typeof(RectTransform))
  self.txtTmpComp = self.binder:GetTextComp(self.ui.Text_Voice_1)
end

function SummonResultItemDetail:Display(summonItem, awakerFragmentCount, onEndOfDisplay)
  print("---------------display", table.tostring(summonItem))
  local itemCfg = DT.Item[summonItem.tid]
  self.onEndOfDisplay = onEndOfDisplay
  self.compAwakerWeapon = nil
  if itemCfg.Type == CommonDefine.ItemType.Weapon then
    self:_DisplayWeapon(itemCfg)
  elseif itemCfg.Type == CommonDefine.ItemType.AwakerItem then
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(summonItem.tid)
    local awakerCfg = DT.AwakerConfig[awakerTid]
    self:_DisplayAwaker(awakerCfg)
  end
  if summonItem.transItems then
    self:_DisplayExtraItemsDirectly(summonItem.transItems)
  else
    self:_DisplayExtraItems(summonItem.extraItems, awakerFragmentCount, summonItem.summonType)
  end
  self:_DisplayAutoRefine(summonItem.displayAutoRefineInfo or summonItem.autoRefineInfo)
  local animAwaiter = Awaiter.Get()
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.animController:PlayMultiState(self.animName, function()
    animAwaiter:SetCompleted()
    if self.compAwakerWeapon then
      self.compAwakerWeapon:UnfrozenGyroscopedCtrl()
    end
  end, 1, false)
  table.insert(self.awaiterList, animAwaiter)
  self.endAwaiter = Awaiter.WhenAll(self.awaiterList)
  self.endAwaiter:OnCompleted(function()
  end)
  self._isPlayingAnim = true
  self.binder:BindTimer(CommonDefine.SummonItemDetailStayTime, 0, nil, function()
    self._isPlayingAnim = false
  end)
end

function SummonResultItemDetail:_DisplayAutoRefine(refineInfo)
  assert(self.ui.Group_AutoRefine, "没有 Group_AutoRefine 节点")
  local level = refineInfo and refineInfo.targetLevel
  self.binder:SetActive(self.ui.Group_AutoRefine, nil ~= level)
  if not level then
    return
  end
  local fourStarGameObjs = {
    self.ui.Star_1,
    self.ui.Star_2,
    self.ui.Star_3,
    self.ui.Star_4
  }
  UIUtils.SetWeaponStar(self.binder, fourStarGameObjs, level)
end

function SummonResultItemDetail:HideWhenCaptureScreen(value)
  self.ui.Text_Voice_1:SetActive(value)
end

function SummonResultItemDetail:DisplayAwaker(awakerTid, extraItems, awakerFragmentCount, onEndOfDisplay)
  self.onEndOfDisplay = onEndOfDisplay
  local awakerCfg = DT.AwakerConfig[awakerTid]
  self:_DisplayAwaker(awakerCfg)
  self:_DisplayExtraItems(extraItems, awakerFragmentCount)
  local animAwaiter = Awaiter.Get()
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.animController:PlayMultiState(self.animName, function()
    animAwaiter:SetCompleted()
  end, 1, false)
  table.insert(self.awaiterList, animAwaiter)
  self.endAwaiter = Awaiter.WhenAll(self.awaiterList)
  self.endAwaiter:OnCompleted(function()
  end)
  self._isPlayingAnim = true
  self.binder:BindTimer(CommonDefine.SummonItemDetailStayTime, 0, nil, function()
    self._isPlayingAnim = false
  end)
end

function SummonResultItemDetail:DisplaySkin(skinTid)
  local awakerTid = AwakerSkinUtils.GetAwakerTidBySkin(skinTid)
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awakerTid)
  self:_DisplayAwaker(awakerCfg, skinTid)
  self:_DisplayExtraItems({}, 0)
  local animAwaiter = Awaiter.Get()
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.animController:PlayMultiState(self.animName, function()
    animAwaiter:SetCompleted()
  end, 1, false)
  table.insert(self.awaiterList, animAwaiter)
  local awakerSkinTid = AwakerSkinUtils.GetSkinByItem(skinTid)
  self.ui.Image_Quality_Txt:SetActive(false)
  self.ui.UI_Common_SkinStar:SetActive(true)
  AwakerUiUtils.RefreshAwakerSkinStarGroup(self, self.binder, awakerSkinTid)
  self.endAwaiter = Awaiter.WhenAll(self.awaiterList)
  self.endAwaiter:OnCompleted(function()
  end)
  self._isPlayingAnim = true
  self.binder:BindTimer(CommonDefine.SummonItemDetailStayTime, 0, nil, function()
    self._isPlayingAnim = false
  end)
end

function SummonResultItemDetail:_DisplayWeapon(itemCfg)
  self.ui.UI_Common_SkinStar:SetActive(false)
  self.ui.ScrollView:SetActive(false)
  self.ui.Image_Frame:SetActive(false)
  self.ui.Image_Awaker:SetActive(false)
  self.ui.Container_Awaker:SetActive(false)
  self.ui.Image_Weapons_1:SetActive(true)
  self.binder:SetText(self.ui.Text_Name, LT.Text(itemCfg.Name))
  self.binder:SetText(self.ui.Text_Name_type, "")
  if self.ui.Image_Weapons_FX then
    self.ui.Image_Weapons_FX:SetActive(false)
    self.ui.Image_Weapons_FX:SetActive(true)
  end
  local itemLogo = CommonDefine.SummonItemLogo[itemCfg.Quality]
  if itemLogo then
    self.binder:SetImage(self.ui.Image_Positioning, itemLogo.NormalSmall)
    self.binder:SetImage(self.ui.Positioning_glow, itemLogo.GlowSmall)
    self.ui.Image_Quality_Txt:SetActive(true)
  else
    self.ui.Image_Quality_Txt:SetActive(false)
  end
  if self.weaponBinder then
    self.weaponBinder:teardown()
    self.weaponBinder = nil
  end
  self.weaponBinder = self.binder:createChild(self.binder)
  self.compAwakerWeapon = self.weaponBinder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon, itemCfg.SpIcon, 0.66))
  self.compAwakerWeapon:FrozenGyroscopedCtrl()
end

function SummonResultItemDetail:_DisplayAwaker(awakerCfg, skinTid)
  self.ui.UI_Common_SkinStar:SetActive(false)
  self.ui.Image_Quality_Txt:SetActive(true)
  self.ui.ScrollView:SetActive(true)
  self.ui.Image_Frame:SetActive(true)
  self.ui.Image_Awaker:SetActive(false)
  self.ui.Container_Awaker:SetActive(true)
  self.ui.Image_Weapons_1:SetActive(false)
  self.binder:SetText(self.ui.Text_Name, LT.Text(awakerCfg.Name))
  self.binder:SetText(self.ui.Text_Name_type, LT.Text(DT.CommonID[awakerCfg.Type].Desc))
  if self.ui.Image_Weapons_FX then
    self.ui.Image_Weapons_FX:SetActive(false)
  end
  if skinTid then
    local skinResNum = AwakerSkinUtils.GetSkinResNum(skinTid)
    self.awakerPortrait.portraitNo.value = skinResNum
  else
    self.awakerPortrait.awakerTid.value = awakerCfg.ID
  end
  self.awakerPortrait:PlayShowAni()
  if skinTid then
    local itemCfg = DT.Item[skinTid]
    self.binder:SetImage(self.ui.Image_Positioning, CommonRes.SummonSkin.Normal)
    self.binder:SetImage(self.ui.Positioning_glow, CommonRes.SummonSkin.Glow)
    self.binder:SetText(self.ui.Text_Name, LT.Text(itemCfg.Name))
    self.binder:SetText(self.ui.Text_Name_type, LT.Text("AwakerSkinTypeName"))
  else
    local schoolCfg = DT.SchoolConfig[awakerCfg.School]
    local schoolLogo = AwakerDataUtils.GetSummonSchoolLogo(schoolCfg.NameEn, awakerCfg.Quality)
    self.binder:SetImage(self.ui.Image_Positioning, schoolLogo.NormalSmall)
    self.binder:SetImage(self.ui.Positioning_glow, schoolLogo.GlowSmall)
  end
  local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceId(CommonDefine.AwakerVoiceTrigger.GetAwaker, awakerCfg.ID, skinTid)
  local voiceConfig = DT.Voice[voiceId]
  if not voiceConfig then
    Logger.Error("y语音_Voice_A.csv 没有配置 [%s] 唤醒语音", LT.Text(awakerCfg.Name))
    return
  end
  self.binder:SetText(self.ui.Text_Voice_1, voiceConfig.AwakerVoiceContent)
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Voice_1, 0, 0, 0, 5, false, true)
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  local voiceAwaiter = Awaiter.Get()
  self.soundEventName = soundEventName
  self.binder:BindTimer(duration, 0, nil, function()
    AwakerFaceManager.Instance:StopSwitchFace()
    voiceAwaiter:SetCompleted()
  end)
  table.insert(self.awaiterList, voiceAwaiter)
  AudioManager.Instance:PostSoundEvent(self.soundEventName)
  AwakerFaceManager.Instance:SwitchFace(voiceConfig.AwakerID, voiceConfig.FacialExpressionSwitch)
end

function SummonResultItemDetail:_DisplayExtraItems(extraItems, awakerFragmentCount, summonType)
  local displayInfo = {}
  extraItems = self:_FilterDisplayExtraItems(extraItems, summonType)
  for idx, extraItemInfo in ipairs(self.extraItemInfoList) do
    local extraItem = extraItems[idx]
    if extraItem then
      extraItemInfo.ui.uiNode:SetActive(true)
      local type, param_1, param_2, param_3 = extraItemInfo:CalcDisplayInfo(extraItem, awakerFragmentCount)
      table.insert(displayInfo, {
        ui = extraItemInfo,
        type = type,
        param_1 = param_1,
        param_2 = param_2,
        param_3 = param_3
      })
    else
      extraItemInfo.ui.uiNode:SetActive(false)
    end
  end
  if 2 == #displayInfo and displayInfo[1].type == "Item" and displayInfo[2].type == "ClipItemTrans" and displayInfo[1].param_1.ID == displayInfo[2].param_1.ID then
    displayInfo[1].param_2 = displayInfo[1].param_2 - displayInfo[2].param_2
  end
  for _, info in ipairs(displayInfo) do
    self:_ProcessExtraItemDisplayInfo(info)
  end
end

local unDisplayItemTids = {
  DT.GetConstant("DiamondItemTid")
}

function SummonResultItemDetail:_FilterDisplayExtraItems(extraItems, summonType)
  extraItems = extraItems or {}
  summonType = summonType or CommonDefine.SummonType.Normal
  for i = #extraItems, 1, -1 do
    if summonType == CommonDefine.SummonType.Diamond and table.contains(unDisplayItemTids, extraItems[i].tid) then
      table.remove(extraItems, i)
    end
  end
  return extraItems
end

function SummonResultItemDetail:_ProcessExtraItemDisplayInfo(info)
  if info.type == "ClipItem" then
    info.ui:DisplayAwakerClipItem(info.param_1, info.param_2, info.param_3)
  elseif info.type == "ClipItemTrans" then
    info.ui:DisplayAwakerClipItemTransform(info.param_1, info.param_2, info.param_3)
  elseif info.type == "Item" then
    info.ui:DisplayItem(info.param_1, info.param_2, info.param_3)
  end
end

function SummonResultItemDetail:_DisplayExtraItemsDirectly(transItems)
  for idx, info in ipairs(self.extraItemInfoList) do
    local item = transItems[idx]
    if item then
      local itemCfg = DT.Item[item.tid]
      local reason = "Summon"
      info.ui.uiNode:SetActive(true)
      info:DisplayItem(itemCfg, item.count or item.num, reason)
    else
      info.ui.uiNode:SetActive(false)
    end
  end
end

function SummonResultItemDetail:OnUnbind()
  Super.OnUnbind(self)
  self:_Clear()
end

function SummonResultItemDetail:_Clear()
  if self.soundEventName then
    AudioManager.Instance:StopPlayingSound(self.soundEventName)
    self.soundEventName = nil
  end
  if self.animController then
    self.animController:ClearCompleteCb()
    self.animController:StopPlayableGraph()
    self.animController = nil
  end
  self:_RecycleAwaiters()
  AwakerFaceManager.Instance:StopSwitchFace()
end

function SummonResultItemDetail:InitSubtitlesDisplay()
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
  local duration = AudioManager.Instance:GetEventDuration(self.soundEventName)
  self.rollAwakerSubTitleRT.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
  local textLineCnt = self:_GetTextLineCnt()
  if textLineCnt > AWKAER_SUBTITLE_SHOW_LINE then
    local startPos = self.rollAwakerSubTitleRT.anchoredPosition.y
    local endPos = (textLineCnt - AWKAER_SUBTITLE_SHOW_LINE) * SUBTITLES_PER_LINE_HEIGHT + CONTENT_ORI_HEIGHT
    local delta = endPos - startPos
    local showVal = startPos
    self.voiceCloseTimer = self.binder:BindTimer(duration / AWAKER_SUBTITLE_ROLL_TIMES, AWAKER_SUBTITLE_ROLL_TIMES, function()
      self.rollAwakerSubTitleRT.anchoredPosition = CS.UnityEngine.Vector2(0, showVal)
      showVal = showVal + delta / AWAKER_SUBTITLE_ROLL_TIMES
    end)
  end
  local ScrollView_ChaperDragListner = self.ui.ScrollView:GetComponent(typeof(CS.Z1Client.DragListener))
  
  function ScrollView_ChaperDragListner.dragFunc()
    if not self.voiceCloseTimer then
      return
    end
    self.binder:StopTimer(self.voiceCloseTimer)
    self.voiceCloseTimer = nil
  end
end

function SummonResultItemDetail:_GetTextLineCnt()
  local height = self.txtTmpComp.preferredHeight + CONTENT_ORI_HEIGHT
  do return math.floor end
  return math.floor, height // SUBTITLES_PER_LINE_HEIGHT
end

function SummonResultItemDetail:_RecycleAwaiters()
  for i = #self.awaiterList, 1, -1 do
    local awaiter = self.awaiterList[i]
    awaiter:Recycle()
    table.remove(self.awaiterList, i)
  end
  if self.endAwaiter then
    self.endAwaiter:Recycle()
    self.endAwaiter = nil
  end
end

function SummonResultItemDetail:SetExtraItemListStates(bShow)
  local alpha = bShow and 1 or 0
  self.binder:SetCanvasGroup(self.ui.Item_Side_Tip_1, alpha)
  self.binder:SetCanvasGroup(self.ui.Item_Side_Tip_2, alpha)
end

return SummonResultItemDetail
