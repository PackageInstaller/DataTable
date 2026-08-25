local ActivityStageGroupItem, Super = System.NewComponent("ActivityStageGroupItem")

function ActivityStageGroupItem:ctor(go, uiRes, stageNum, stageGroupId, activityTid, data, clickCb)
  Super.ctor(self)
  self.ui = uiRes(go)
  self.stageNum = stageNum
  self.stageGroupId = stageGroupId
  self.activityTid = activityTid
  self.clickCb = clickCb
  self.data = data
  self._isTimeToOpen = Vue.ref(false)
end

function ActivityStageGroupItem:OnBind(binder)
  self.binder = binder
  self.ui.uiNode:SetActive(self.stageGroupId ~= nil)
  if not self.stageGroupId then
    return
  end
  self:SetStageGroupInfo()
  self:SetTimeAndStageGroupToOpen()
  self:SetTimeToClose()
  self:SetProgress()
  self:SetLimitSchool()
  self:BindKillCount()
  self:BindNewStageGroupRed({
    self.stageGroupId
  })
  self.binder:BindTimer(0.3, -1, function()
    self:SetTimeAndStageGroupToOpen()
    self:SetTimeToClose()
  end)
end

function ActivityStageGroupItem:BindNewStageGroupRed(stageGroupList)
  if not stageGroupList or not self.ui.NewTag_Challenge then
    return
  end
  self.binder:SetActive(self.ui.NewTag_Challenge, true)
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Challenge, RedDotDefine.DynamicRedDotID.StageGroupEntry, {
    stageGroupTid = self.stageGroupId
  }))
end

function ActivityStageGroupItem:SetStageGroupInfo()
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  self.binder:SetText(self.ui.Text_Name, stageGroupCfg.Name)
  if stageGroupCfg.DailyIcon then
    self.binder:SetImage(self.ui.Image_Base, stageGroupCfg.DailyIcon[1])
  end
  if self.ui.Text_StageNum and self.stageNum then
    local desc = ""
    local stageNum = StrUtils.ParseEmojiNumber(self.stageNum, "Number1")
    if self.stageNum < 10 then
      local str0 = "<sprite=\"Number1\" index=0>"
      desc = string.format("%s%s", str0, stageNum)
    else
      desc = stageNum
    end
    self.binder:SetText(self.ui.Text_StageNum, desc)
  end
  self.binder:BindToRaw(function(_, icon)
    self:ShowEffect(icon)
  end, function()
    return stageGroupCfg.DailyIcon and stageGroupCfg.DailyIcon[1]
  end)
  self.binder:BindZ1Button(self.ui.Image_Container, function()
    if not self._isTimeToOpen.value then
      local tips = LT.Text(DT.TipsType[20032].Title)
      Alert.ShowStr(tips)
      return
    end
    if self.isTimeClosed then
      local tips = LT.Text("AbyssChallengeEndTips")
      Alert.ShowStr(tips)
      return
    end
    if not self.isStageUnlock then
      local featureId = self:_GetFraturId()
      PlayerDataUtils.AlertLockedTips(featureId, self.stageGroupId)
      return
    end
    if CopyDataUtils.HasDisplayTime(self.stageGroupId) then
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.NewStageGroupUnlock, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
    end
    local redKey = PlayerDataUtils.GetFeatureByKey(self.stageGroupId)
    if redKey then
      RedPointDataUtils.ReqRemoveData(redKey, RedPointDataUtils.RedAttrType.IsNew, self.stageGroupId)
    end
    if self:CheckIsCanClick() and self.clickCb then
      self.clickCb(self.stageGroupId)
    end
  end)
  if self.ui.ScrollView_Award then
    self.binder:BindToCircularListView(self.ui.ScrollView_Award, function()
      return stageGroupCfg.StageGroupDropPreview
    end, function(itemBinder, item, index)
      local itemData = {
        itemTid = stageGroupCfg.StageGroupDropPreview[index],
        tipPosY = -350
      }
      itemBinder:BindComponent(CommonIconItemType2(item, itemData))
    end)
  end
  if self.ui.Content then
    local LayoutGroup = self.ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
    LayoutGroup.enabled = table.length(stageGroupCfg.StageGroupDropPreview) <= 2
  end
end

function ActivityStageGroupItem:IsStageGroupOpen()
  if self._isTimeToOpen.value and not self.isTimeClosed and self.isStageUnlock then
    return true
  end
end

function ActivityStageGroupItem:CheckIsCanClick()
  return true
end

function ActivityStageGroupItem:ShowEffect(iconName)
  if not iconName and type(iconName) ~= "string" then
    return
  end
  if "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_12.png" == iconName then
    self.ui.UI_Events_VX_Lake01:SetActive(true)
    self.ui.UI_Events_VX_Lake02:SetActive(false)
    self.ui.UI_Events_VX_Lake03:SetActive(false)
  elseif "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_11.png" == iconName then
    self.ui.UI_Events_VX_Lake01:SetActive(false)
    self.ui.UI_Events_VX_Lake02:SetActive(true)
    self.ui.UI_Events_VX_Lake03:SetActive(false)
  elseif "UIResources/UIBigImages/UI_Events/UI_Events_Image_Icon_10.png" == iconName then
    self.ui.UI_Events_VX_Lake01:SetActive(false)
    self.ui.UI_Events_VX_Lake02:SetActive(false)
    self.ui.UI_Events_VX_Lake03:SetActive(true)
  end
  if not (self.ui.UI_Event_FlowerEffect_01 and self.ui.UI_Event_FlowerEffect_02) or not self.ui.UI_Event_FlowerEffect_03 then
    return
  end
  if "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_01.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_02.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_03.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_04.png" == iconName then
    self.ui.UI_Event_FlowerEffect_01:SetActive(true)
    self.ui.UI_Event_FlowerEffect_02:SetActive(false)
    self.ui.UI_Event_FlowerEffect_03:SetActive(false)
  elseif "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_05.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_06.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_07.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_08.png" == iconName then
    self.ui.UI_Event_FlowerEffect_01:SetActive(false)
    self.ui.UI_Event_FlowerEffect_02:SetActive(true)
    self.ui.UI_Event_FlowerEffect_03:SetActive(false)
  elseif "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_09.png" == iconName or "UIResources/UIBigImages/UI_Events/UI_Events_Image_Flower_10.png" == iconName then
    self.ui.UI_Event_FlowerEffect_01:SetActive(false)
    self.ui.UI_Event_FlowerEffect_02:SetActive(false)
    self.ui.UI_Event_FlowerEffect_03:SetActive(true)
  end
end

function ActivityStageGroupItem:SetTimeAndStageGroupToOpen()
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  local openTime = stageGroupCfg.StageDisplayDate or 0
  local curTime = TimeUtils.GetServerTime()
  local isTimeToOpen = openTime <= curTime
  self._isTimeToOpen.value = isTimeToOpen
  self.isStageUnlock = self:_IsFratureUnlock()
  local isUnlocked = self.isStageUnlock and isTimeToOpen
  self.ui.Image_Base:SetActive(isUnlocked)
  self.ui.Image_Disable:SetActive(not isUnlocked)
  self.binder:SetTextColorType(self.ui.Text_Name, isUnlocked and cd.ColorType.Light or cd.ColorType.Dark)
  if self.ui.Text_StageNum then
    self.binder:SetCanvasGroup(self.ui.Text_StageNum, isUnlocked and 1 or 0.5)
  end
  if isTimeToOpen then
    self.binder:SetText(self.ui.Text_Timing, "")
    self.binder:SetActive(self.ui.Text_Timing, false)
    if self.ui.Image_Timing then
      self.ui.Image_Timing:SetActive(false)
    end
  else
    self.binder:SetText(self.ui.Text_Timing, LT.Textf("StageOpenCountdownText", TimeUtils.format2Hour(openTime - curTime)))
    self.binder:SetActive(self.ui.Text_Timing, true)
    if self.ui.Image_Timing then
      self.ui.Image_Timing:SetActive(true)
    end
  end
  if self.ui.Text_C_LockTips then
    self.ui.Text_C_LockTips:SetActive(isTimeToOpen and not self.isStageUnlock)
  end
end

function ActivityStageGroupItem:SetTimeToClose()
  if not self.ui.Text_Timing_Close then
    return
  end
  local stageGroupCfg = DT.StageGroup[self.stageGroupId]
  local closeTime = stageGroupCfg.StageGroupCloseDate
  local openTime = stageGroupCfg.StageDisplayDate or 0
  local now = TimeUtils.GetServerTime()
  if not closeTime or openTime > now then
    self.binder:SetActive(self.ui.Image_Finish, false)
    self.binder:SetActive(self.ui.Text_Timing_Close, false)
    return
  end
  self.binder:SetActive(self.ui.Text_Timing_Close, true)
  local curTime = TimeUtils.GetServerTime()
  local leftTime = closeTime - curTime
  self.isTimeClosed = leftTime <= 0
  if leftTime > 0 then
    self.binder:SetActive(self.ui.Image_Finish, false)
    self.binder:SetText(self.ui.Text_Timing_Close, LT.Textf("StageCloseCountdownText", TimeUtils.format2Hour(leftTime)))
  elseif self.ui.Image_Finish then
    self.binder:SetActive(self.ui.Text_Timing_Close, false)
    self.binder:SetActive(self.ui.Image_Finish, true)
  else
    self.binder:SetText(self.ui.Text_Timing_Close, string.color(LT.Text("StageClosedText"), "#ff5a5a"))
  end
end

function ActivityStageGroupItem:SetLimitSchool()
  if not self.ui.Image_Career then
    return
  end
  local stageDataList = CopyDataUtils.GetCfgStageList(self.stageGroupId)
  local firstStageData = stageDataList[1]
  if not firstStageData then
    return
  end
  local limits, limitSchoolIcon = CopyDataUtils.GetAwakerRequirement(firstStageData.ID)
  if limitSchoolIcon then
    if self.ui.Text_CareerLimit then
      self.binder:SetActive(self.ui.Text_CareerLimit, false)
    end
    self.binder:SetActive(self.ui.Image_Career, true)
    self.binder:SetImage(self.ui.Image_Career, limitSchoolIcon)
    if self.ui.Text_CareerCount then
      if limits[1] then
        self.binder:SetText(self.ui.Text_CareerCount, ItemNumUtils.GetStr(limits[1][2]))
      end
      self.binder:SetActive(self.ui.Text_CareerCount, nil ~= limits[1])
    end
    if self.ui.Text_CareerCount2 then
      if limits[2] then
        self.binder:SetText(self.ui.Text_CareerCount2, ItemNumUtils.GetStr(limits[2][2]))
      end
      self.binder:SetActive(self.ui.Text_CareerCount2, nil ~= limits[2])
    end
  else
    if self.ui.Text_CareerLimit then
      self.binder:SetActive(self.ui.Text_CareerLimit, true)
    end
    self.binder:SetActive(self.ui.Image_Career, false)
  end
end

function ActivityStageGroupItem:BindKillCount()
  if not self.ui.Text_KilledCount then
    return
  end
  self.binder:BindToRaw(function(cbinder, count)
    cbinder:SetActive(self.ui.Text_KilledCount, count >= 0)
    cbinder:SetText(self.ui.Text_KilledCount, LT.Textf("KilledMonsterCount", count))
  end, function()
    if not self._isTimeToOpen.value then
      return -1
    end
    local killCountKey = "StageGroupWinCount_" .. self.stageGroupId
    return PlayerDataUtils.GetGlobalBaseStatsData(killCountKey) or 0
  end)
end

function ActivityStageGroupItem:_GetFraturId()
  local groupType = CopyDataUtils.GetStageGroupType(self.stageGroupId)
  if groupType == CommonDefine.StageGroupType.SEWD then
    return CommonDefine.FeatureId.SalvadorActivity
  elseif groupType == CommonDefine.StageGroupType.A24 then
    return CommonDefine.FeatureId.TwentyFourActivity
  elseif groupType == CommonDefine.StageGroupType.Lily then
    return CommonDefine.FeatureId.MagicStoryActivityReproduce
  end
end

function ActivityStageGroupItem:_IsFratureUnlock()
  local featureId = self:_GetFraturId()
  if not featureId then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(featureId, self.stageGroupId)
  return unlocked
end

function ActivityStageGroupItem:SetProgress()
  if not self.ui.Text_Promote or not self.ui.Text_Base then
    return
  end
  if self.ui.Text_Promote then
    self.binder:SetText(self.ui.Text_Promote, "")
  end
  if self.ui.Text_Base then
    self.binder:SetText(self.ui.Text_Base, "")
  end
  self.ui.Image_Finish:SetActive(false)
  CopyDataUtils.ReqCopyData("", self.stageGroupId, function()
    if not self.ui or IsNil(self.ui.uiNode) or not self.binder then
      return
    end
    local stageDataList = CopyDataUtils.GetStageList(self.stageGroupId) or {}
    local totalNum = #stageDataList
    local curNum = 0
    for _, stageData in ipairs(stageDataList) do
      if stageData.firstRewardDraw then
        curNum = curNum + 1
      end
    end
    self.binder:SetText(self.ui.Text_Promote, curNum)
    if self.ui.Text_Base then
      self.binder:SetText(self.ui.Text_Base, totalNum)
    end
    self.ui.Image_Finish:SetActive(curNum > 0 and curNum == totalNum)
  end)
end

return ActivityStageGroupItem
