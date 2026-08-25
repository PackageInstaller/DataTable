local TempVector2 = CS.UnityEngine.Vector2(0, 0)
local PopUpAdPanel, Super = System.NewClass("PopUpAdPanel", ActivityBasePanel)
PopUpAdPanel.uiResCls = UI_Event_Popup_NewTipResource

function PopUpAdPanel:ctor(adTidList, closeCb)
  Super.ctor(self)
  self.adTidList = adTidList
  self:SortAdTidList()
  self.closeCb = closeCb
  self.showIndex = 1
  self.adCount = #self.adTidList
end

function PopUpAdPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Left, System.fn(self, self.OnClickLeft))
  binder:BindButtonClick(self.ui.Btn_Right, System.fn(self, self.OnClickRight))
  binder:BindButtonClick(self.ui.Btn_Goto, System.fn(self, self.OnClickGoto))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.UI_Summon_Btn_Jump, System.fn(self, self.OnClickSummonJump))
  binder:SetText(self.ui.Text_C_Goto, LT.Text("GoTo"))
  self:CreataRewardTable()
  self:RefreshAd()
  self:ClearStalePopupAdClientData()
end

function PopUpAdPanel:OnClickGoto()
  local activityId, poolId, shopTid = self:GetCurAdActivityOrPoolId()
  if activityId then
    if not ActivityDataUtils.IsActivityOpen(activityId) then
      Alert.Show(20183)
      return
    end
    local activityCfg = DT.Activity[activityId]
    if activityCfg.WhereShow == ActivityDefine.WhereShow.GamePassport then
      UIManager.Instance:Reopen(Urls.ActivityGamePassportPanel, nil, activityId)
      return
    end
    ActivityDataUtils.OpenActivityMainPanel(activityId)
  elseif poolId then
    if not SummonDataUtils.IsSummonPoolOpen(poolId) then
      Alert.Show(20183)
      return
    end
    SummonDataUtils.OpenSummonPanel(poolId)
  elseif shopTid then
    if not MainShopDataUtils.IsShopOpen(shopTid) then
      Alert.Show(20183)
      return
    end
    local shopType = MainShopDataUtils.GetShopTypeByShopTid(shopTid)
    MainShopDataUtils.OnOpenShop(shopType)
  end
end

function PopUpAdPanel:SortAdTidList()
  table.sort(self.adTidList, function(a, b)
    local cfgA = DT.PopupAd[a]
    local cfgB = DT.PopupAd[b]
    local priorityA = cfgA.Priority or 99999999
    local priorityB = cfgB.Priority or 99999999
    if priorityA ~= priorityB then
      return priorityA < priorityB
    end
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
end

function PopUpAdPanel:RefreshAd()
  if IsNil(self.ui.DescView) then
    return
  end
  self:SetIndicator()
  local adTid = self.adTidList[self.showIndex]
  local adCfg = DT.PopupAd[adTid]
  if not adCfg then
    return
  end
  self:SetBgOffset(adCfg.Offset)
  self.binder:SetActive(self.ui.Btn_Left, self.adCount > 1)
  self.binder:SetActive(self.ui.Btn_Right, self.adCount > 1)
  self:_ClearTimer()
  self:RefreshShowItems(adCfg.ShowItem)
  self.binder:SetText(self.ui.Text_Title, adCfg.TitleText)
  self.binder:SetText(self.ui.Text_C_InfoTitle, adCfg.SubTitleText)
  self:_RefreshAdDesc(adCfg)
  self:_ClearPortraitComp()
  self:_ClearPWeaponComp()
  if adCfg.BgRes then
    self.binder:SetImage(self.ui.Basemap, adCfg.BgRes)
  end
  if self._activityPrefabBg then
    self._activityPrefabBg.binder:teardown()
    self._activityPrefabBg = nil
  end
  local sizeDelta = self.ui.DescView.transform.sizeDelta
  TempVector2.x = sizeDelta.x
  TempVector2.y = 396
  if self.rewardList then
    local isShowReward = self.rewardList and #self.rewardList > 0 or false
    if isShowReward then
      TempVector2.y = 261
    end
  end
  self.ui.DescView.transform.sizeDelta = TempVector2
  self.binder:BindTimer(0.3, 0, nil, function()
    local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc, 50)
    TempVector2.y = height
    self.ui.Content.transform.sizeDelta = TempVector2
  end)
  local activityId, poolId, shopTid = self:GetCurAdActivityOrPoolId()
  if activityId then
    self:RefreshActivityAd(activityId, adCfg)
  elseif poolId then
    self:RefreshSummonAd(poolId, adCfg)
  elseif shopTid then
    self:RefreshShopAd(shopTid, adCfg)
  end
end

function PopUpAdPanel:_RefreshAdDesc(adCfg)
  local showDesc = LT.Text(adCfg.DescriptionText)
  if adCfg.PopupType ~= PopupAdDefine.PopupAdType.Activity then
    local titleContentFormt = "【%s】\n%s\n\n"
    if not LT.IsEndofWithChinesePeriod() then
      titleContentFormt = [[
[%s]
%s

]]
    end
    if adCfg.ExtraParam and table.next(adCfg.ExtraParam) then
      local showAwakerDesc = ""
      for _, cfgTid in ipairs(adCfg.ExtraParam) do
        local awakerCfg = DT.AwakerConfig[cfgTid]
        if awakerCfg then
          showAwakerDesc = showAwakerDesc .. string.format(titleContentFormt, LT.Text(awakerCfg.Name), LT.Text(awakerCfg.Introduction))
        else
          local weaponCfg = DT.Item[cfgTid]
          if not weaponCfg then
          else
            showAwakerDesc = showAwakerDesc .. string.format(titleContentFormt, LT.Text(weaponCfg.Name), LT.Text(weaponCfg.Desc))
          end
        end
      end
      showDesc = showAwakerDesc
    end
  end
  local scrollRect = self.ui.DescView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  scrollRect.verticalNormalizedPosition = 1
  self.binder:SetText(self.ui.Text_Desc, showDesc)
end

function PopUpAdPanel:SetBgOffset(offset)
  offset = offset or {0, 0}
  local offsetVector2 = CS.UnityEngine.Vector2(offset[1], offset[2])
  self.ui.Basemap.transform.anchoredPosition = offsetVector2
  self.ui.Image_NewActivity.transform.anchoredPosition = offsetVector2
  self.ui.Image_Activity.transform.anchoredPosition = offsetVector2
end

function PopUpAdPanel:SetIndicator()
  if not self._indicatorBrightList then
    self._indicatorList = {
      self.ui.PageDot
    }
    self._indicatorBrightList = {
      self.ui.Page_Bright
    }
    local indicatorPrefab = self.ui.PageDot
    local parent = self.ui.PageDot.transform.parent
    for i = 1, self.adCount - 1 do
      local indicator = CS.UnityEngine.GameObject.Instantiate(indicatorPrefab, parent)
      table.insert(self._indicatorList, indicator)
      local brightGo = indicator.transform:GetChild(0).gameObject
      table.insert(self._indicatorBrightList, brightGo)
    end
  end
  for i = 1, #self._indicatorBrightList do
    self._indicatorList[i]:SetActive(i <= self.adCount)
    self._indicatorBrightList[i]:SetActive(i == self.showIndex)
  end
end

function PopUpAdPanel:GetCurAdCfg()
  return DT.PopupAd[self.adTidList[self.showIndex]]
end

function PopUpAdPanel:GetCurAdActivityOrPoolId()
  local adTid = self.adTidList[self.showIndex]
  local adCfg = DT.PopupAd[adTid]
  local activityId, poolId, shopTid
  for _, activityOrPoolId in ipairs(adCfg.LinkedActivity) do
    if ActivityDataUtils.GetConfig(activityOrPoolId) then
      activityId = activityOrPoolId
      break
    elseif SummonDataUtils.GetCfg(activityOrPoolId) then
      poolId = activityOrPoolId
      break
    elseif MainShopDataUtils.IsShopTid(activityOrPoolId) then
      shopTid = activityOrPoolId
      break
    end
  end
  return activityId, poolId, shopTid
end

function PopUpAdPanel:RefreshActivityAd(activityId, popUpAdCfg)
  local activityCfg = DT.Activity[activityId]
  if not activityCfg or not popUpAdCfg then
    return
  end
  self.binder:SetActive(self.ui.Group_Weapon, false)
  self.binder:SetImage(self.ui.Basemap, popUpAdCfg.BgRes or false)
  local picture = popUpAdCfg.BgRes or ArtCollectionModel:GetPictureByActivity(activityId) or activityCfg.ActivityPicture
  print("----------------activityId", activityId, "picture", picture or "nil")
  if not picture and not popUpAdCfg.BgRes then
    local activityDefine = ActivityDefine.ActivityCompClsInfo[activityCfg.ActivityType]
    if activityDefine and activityDefine.resPath and self.ui.Group_ActivityPrefab then
      self.binder:SetActive(self.ui.Group_ActivityPrefab, true)
      self._activityPrefabBg = self.binder:BindNewComponent(self.ui.Group_ActivityPrefab, CGActivityComp, activityDefine.resPath, activityDefine, false)
    end
  elseif not popUpAdCfg.BgRes and (string.find(picture, "UI_Large_Collection/") or string.find(picture, "UI_Events_")) then
    self.binder:SetActive(self.ui.Image_NewActivity, false)
    self.binder:SetActive(self.ui.Image_Activity, true)
    self.binder:SetImage(self.ui.Image_Activity, picture)
  else
    self.binder:SetActive(self.ui.Image_NewActivity, true)
    self.binder:SetActive(self.ui.Image_Activity, false)
    self.binder:SetImage(self.ui.Image_NewActivity, picture)
  end
  self.binder:SetActive(self.ui.Group_Awaker, false)
  self.binder:SetActive(self.ui.Group_Weapon, false)
  self.binder:SetActive(self.ui.UI_Summon_Btn_Jump, false)
  if popUpAdCfg.AwakerResNum then
    local skinTid = popUpAdCfg.AwakerResNum
    skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
    self.binder:SetActive(self.ui.UI_Summon_Btn_Jump, true)
    self:_SetSkinJumpButtonInfo(self.ui.UI_Summon_Btn_Jump, skinTid)
    self:_SetPortraitComp(nil, AwakerSkinUtils.GetSkinResNum(popUpAdCfg.AwakerResNum))
  elseif popUpAdCfg.ExtraParam and DT.Item[popUpAdCfg.ExtraParam[1]].Type == cd.ItemType.Weapon then
    self.binder:SetActive(self.ui.Group_Weapon, true)
    self.binder:SetActive(self.ui.Image_Decorate, false)
    local showItemTid = popUpAdCfg.ExtraParam[1]
    self:_BindWeaponPrefab(popUpAdCfg.ExtraParam[1])
    self:_SetWeaponJumpButtonInfo(self.ui.UI_Summon_Btn_Jump, nil, showItemTid)
  else
    self.binder:SetActive(self.ui.UI_Summon_Btn_Jump, false)
  end
  self.binder:SetActive(self.ui.Group_Activity_Name, false)
  self:SetActivityTimer(activityId)
end

function PopUpAdPanel:SetActivityTimer(activityId)
  local activityData = ActivityManager.Instance.model:GetActivityDataClient(activityId)
  if not activityData then
    return
  end
  self.activityData = activityData
  self.binder:SetActive(self.ui.Text_Remainder, true)
  self.ui.Text_Time = self.ui.Text_Remainder
  local activityCfg = ActivityDataUtils.GetConfig(activityId)
  if activityCfg.ActivityType == ActivityDefine.ActivityType.PreOrder then
    self:_BindPreOrderActivityTimer()
  elseif activityCfg.ActivityType == ActivityDefine.ActivityType.NewPreOrder then
    self:_BindPreOrderActivityTimer()
  else
    self:_BindActivityTimer()
  end
end

function PopUpAdPanel:_BindPreOrderActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  if self.activityData.isUnlockExtraTask then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  local leftTime = self.activityData.finishTime - TimeUtils.GetServerTime()
  if leftTime <= 0 then
    self.binder:SetText(self.ui.Text_Time, "")
    return
  end
  self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  if self._activityTimer then
    self.binder:StopTimer(self._activityTimer)
  end
  self._activityTimer = self.binder:BindTimer(1, -1, function()
    if self.activityData.isUnlockExtraTask then
      self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
      self:_ClearTimer()
      return
    end
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearTimer()
      return
    end
    self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  end, function()
    self.binder:SetText(self.ui.Text_Time, "")
    self:_ClearTimer()
  end)
end

function PopUpAdPanel:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  self:_ClearTimer()
  self:_TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  if now > self.activityData.endTime then
    return
  end
  self._activityTimer = self.binder:BindTimer(1, -1, System.bind(self._TimerFixedUpdate, self))
end

function PopUpAdPanel:_TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local finishTimeCountdown = (self.activityData.finishTime or 0) - now
  local endTimeCountdown = (self.activityData.endTime or 0) - now
  if finishTimeCountdown < 0 and endTimeCountdown < 0 then
    self:_ClearTimer()
  end
  ActivityUiUtils.RefreshActivityCountDown(self.binder, self.ui.Text_Time, self.activityData)
end

function PopUpAdPanel:_SetPortraitComp(awakerTid, resNum)
  self.binder:SetActive(self.ui.Group_Awaker_Portrait, true)
  local align = CommonDefine.PortraitAlign.Center
  self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Group_Awaker_Portrait, not resNum and awakerTid or nil, resNum, nil, align))
end

function PopUpAdPanel:_ClearPortraitComp()
  if self.awakerPortraitComp then
    self.awakerPortraitComp.binder:teardown()
    self.awakerPortraitComp = nil
  end
  if self.binder and not IsNil(self.ui.Group_Awaker_Portrait) then
    self.binder:SetActive(self.ui.Group_Awaker_Portrait, false)
  end
end

function PopUpAdPanel:_ClearPWeaponComp()
  if self._weaponPrefabComp then
    self._weaponPrefabComp.binder:teardown()
  end
end

function PopUpAdPanel:_ClearTimer()
  if self._timer then
    self.binder:StopTimer(self._timer)
    self._timer = nil
  end
  if self._activityTimer then
    self.binder:StopTimer(self._activityTimer)
    self._activityTimer = nil
  end
end

function PopUpAdPanel:RefreshSummonAd(poolId, popUpAdCfg)
  local poolCfg = DT.Summon[poolId]
  if not poolCfg then
    return
  end
  self.binder:SetActive(self.ui.Group_Activity_Name, false)
  local showItemTid = self:GetPoolShowItemTid()
  local itemCfg = showItemTid and DT.Item[showItemTid] or nil
  if not popUpAdCfg.BgRes then
    self.binder:SetImage(self.ui.Basemap, poolCfg.BaseMap)
    local poolBgImage = SummonDataUtils.GetBgImage(poolId)
    self.binder:SetActive(self.ui.Group_Awaker, "" ~= poolBgImage)
    self.binder:SetActive(self.ui.Group_Weapon, "" ~= poolBgImage and showItemTid and itemCfg.Type == cd.ItemType.Weapon)
    self.binder:SetImage(self.ui.Image_Awaker, poolBgImage)
    if not poolBgImage then
      self:SetWeapon(poolId)
    end
  else
    self.binder:SetActive(self.ui.Group_Awaker, false)
    self.binder:SetActive(self.ui.Group_Weapon, false)
  end
  self.binder:SetActive(self.ui.Image_Activity, false)
  self.binder:SetActive(self.ui.Image_NewActivity, false)
  self.binder:SetActive(self.ui.Basemap, true)
  self:_BindPoolTimer(poolId)
  if showItemTid and not poolCfg.PoolGroup then
    self.binder:SetActive(self.ui.UI_Summon_Btn_Jump, true)
    if itemCfg.Type == cd.ItemType.Weapon then
      self:_SetWeaponJumpButtonInfo(self.ui.UI_Summon_Btn_Jump, poolCfg, showItemTid)
    elseif itemCfg.Type == cd.ItemType.AwakerItem then
      self:_SetAwakerJumpButtonInfo(self.ui.UI_Summon_Btn_Jump, poolCfg, showItemTid)
    else
      self.binder:SetActive(self.ui.UI_Summon_Btn_Jump, false)
    end
  else
    self.binder:SetActive(self.ui.UI_Summon_Btn_Jump, false)
  end
end

function PopUpAdPanel:RefreshShopAd(shopTid, popUpAdCfg)
  self.binder:SetActive(self.ui.Image_NewActivity, false)
  self.binder:SetActive(self.ui.Image_Activity, false)
  self.binder:SetActive(self.ui.Group_Awaker, false)
  self.binder:SetActive(self.ui.Group_Weapon, false)
  local skinTid = popUpAdCfg and popUpAdCfg.AwakerResNum
  if skinTid then
    local resNum = AwakerSkinUtils.GetSkinResNum(skinTid)
    self:_SetPortraitComp(nil, resNum)
    self:_SetSkinJumpButtonInfo(self.ui.UI_Summon_Btn_Jump, skinTid)
  end
  self.binder:SetActive(self.ui.Group_Activity_Name, true)
  local shopTypeCfg = MainShopDataUtils.GetShopTypeCfg(shopTid)
  self.binder:SetText(self.ui.Text_Activity_Name, shopTypeCfg.ShopName)
  self.binder:SetActive(self.ui.Text_Remainder, false)
end

function PopUpAdPanel:GetPoolShowItemTid()
  local _, poolId = self:GetCurAdActivityOrPoolId()
  local poolCfg = DT.Summon[poolId or 0]
  if not poolCfg then
    return
  end
  local detailItem = poolCfg.DetailItem or {}
  if 1 == #detailItem then
    return detailItem[1]
  end
end

function PopUpAdPanel:OnClickSummonJump()
  local adCfg = self:GetCurAdCfg()
  if adCfg.AwakerResNum then
    UIManager.Instance:Reopen(Urls.AwakerPaintingView, nil, nil, adCfg.AwakerResNum)
    return
  end
  local showItemTid = self:GetPoolShowItemTid()
  if not showItemTid then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.UI_Summon_Btn_Jump, nil, showItemTid)
end

function PopUpAdPanel:_SetWeaponJumpButtonInfo(summonBtnGo, summonCfg, itemTid)
  local summonBtnUI = UI_Summon_Btn_JumpResource(summonBtnGo)
  self.binder:SetActive(summonBtnUI.Image_Icon, summonCfg and 1 ~= summonCfg.HideDetailBtn or true)
  local itemCfg = DT.Item[itemTid]
  self.binder:SetActive(summonBtnUI.Text_Name, true)
  self.binder:SetText(summonBtnUI.Text_Name, itemCfg.Name)
  self.binder:SetActive(summonBtnUI.Image_Positioning, true)
  self.binder:SetImage(summonBtnUI.Image_Positioning, CommonDefine.ItemCommonIcon.Weapon)
  local qualityIcon = CommonDefine.AwakerQualityIcon[itemCfg.Quality]
  if qualityIcon then
    summonBtnUI.Image_SSR:SetActive(true)
  else
    summonBtnUI.Image_SSR:SetActive(false)
  end
  self.binder:SetActive(summonBtnUI.Image_Up, false)
  self.binder:SetActive(summonBtnUI.Image_Bg, true)
end

function PopUpAdPanel:_SetSkinJumpButtonInfo(summonBtnGo, skinTid)
  local summonBtnUI = UI_Summon_Btn_JumpResource(summonBtnGo)
  self.binder:SetActive(summonBtnUI.Image_Icon, true)
  self.binder:SetActive(summonBtnUI.Image_Positioning, true)
  self.binder:SetImage(summonBtnUI.Image_Positioning, CommonRes.SkinIcon)
  self.binder:SetActive(summonBtnUI.Image_Bg, true)
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  self.binder:SetActive(summonBtnUI.Text_Name, true)
  self.binder:SetText(summonBtnUI.Text_Name, skinCfg.Name)
  summonBtnUI.Image_SSR:SetActive(false)
  summonBtnUI.Image_Up:SetActive(false)
end

function PopUpAdPanel:_SetAwakerJumpButtonInfo(summonBtnGo, summonCfg, itemID)
  local summonBtnUI = UI_Summon_Btn_JumpResource(summonBtnGo)
  self.binder:SetActive(summonBtnUI.Image_Icon, 1 ~= summonCfg.HideDetailBtn)
  self.binder:SetActive(summonBtnUI.Image_Bg, true)
  local itemCfg = DT.Item[itemID]
  local awakerTid = itemCfg.SpParam and itemCfg.SpParam[1]
  if not awakerTid then
    return
  end
  local awakerCfg = DT.AwakerConfig[awakerTid]
  self.binder:SetActive(summonBtnUI.Text_Name, true)
  self.binder:SetText(summonBtnUI.Text_Name, awakerCfg.Name)
  local schoolCfg = DT.SchoolConfig[awakerCfg.School]
  self.binder:SetActive(summonBtnUI.Image_Positioning, true)
  self.binder:SetImage(summonBtnUI.Image_Positioning, schoolCfg.Icon)
  local qualityIcon = CommonDefine.AwakerQualityIcon[awakerCfg.Quality]
  if qualityIcon then
    summonBtnUI.Image_SSR:SetActive(true)
  else
    summonBtnUI.Image_SSR:SetActive(false)
  end
  summonBtnUI.Image_Up:SetActive(false)
end

function PopUpAdPanel:SetWeapon(poolId)
  local poolCfg = DT.Summon[poolId] or {}
  local poolShowItemTids = poolCfg.DetailItem or {}
  local isContainsWeapon = ItemDataUtils.CheckItemTidsContainType(poolShowItemTids, CommonDefine.ItemType.Weapon)
  local isShowSingleWeapon = isContainsWeapon and table.next(poolShowItemTids) and 1 == #poolShowItemTids
  self.binder:SetActive(self.ui.Image_Decorate, false)
  self.binder:SetActive(self.ui.Group_Weapon, isShowSingleWeapon)
  if isShowSingleWeapon then
    local showWeaponTid = poolShowItemTids[1]
    local showWeaponCfg = DT.Item[showWeaponTid]
    if not showWeaponCfg then
      return
    end
    local showSchoolId = poolCfg.ShowSchool
    if showSchoolId then
      local schoolCfg = DT.SchoolConfig[showSchoolId]
      local showSchoolType = schoolCfg and schoolCfg.NameEn
      local summonWeaponFrame = schoolCfg and schoolCfg.SummonWeaponFrame
      if showSchoolType and summonWeaponFrame then
        self.binder:SetImageSync(self.ui.Image_Decorate, summonWeaponFrame)
        self.binder:SetActive(self.ui.Image_Decorate, true)
      end
    end
    self:_BindWeaponPrefab(poolShowItemTids[1])
  end
end

function PopUpAdPanel:_BindWeaponPrefab(weaponTid)
  local showWeaponTid = weaponTid
  local showWeaponCfg = DT.Item[showWeaponTid]
  if not showWeaponCfg then
    return
  end
  local weaponSpIcon = showWeaponCfg.SpIcon
  if weaponSpIcon then
    self._weaponPrefabComp = self.binder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon_Large, weaponSpIcon, 0.7, function(weaponGO)
      if self.ui and self.ui.Image_Quality then
        local imageQualityCopy = CS.UnityEngine.GameObject.Instantiate(self.ui.Image_Quality, self.ui.Image_Quality.transform.position, self.ui.Image_Quality.transform.rotation, weaponGO.transform)
        imageQualityCopy:SetActive(true)
        imageQualityCopy.transform.localScale = CS.UnityEngine.Vector3(1.47, 1.47, 1.47)
      end
    end))
  end
end

function PopUpAdPanel:_BindPoolTimer(poolId)
  local poolData = SummonDataUtils.GetPoolData(poolId)
  if not poolData then
    print("PopUpAdPanel:_BindActivityTimer activityData is nil")
    return
  end
  self.binder:SetActive(self.ui.Text_Remainder, true)
  local endTime = poolData.endTime
  if not endTime then
    self.binder:SetText(self.ui.Text_Remainder, LT.Text("ActivityTimePermanent"))
    return
  end
  local leftTime = endTime - TimeUtils.GetServerTime()
  if leftTime <= 0 then
    self.binder:SetText(self.ui.Text_Remainder, LT.Text("ActivityTimeExpired"))
    return
  end
  self.binder:SetText(self.ui.Text_Remainder, TimeUtils.ActivityCountDownFormat(leftTime))
  self._timer = self.binder:BindTimer(1, -1, function()
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearTimer()
      return
    end
    self.binder:SetText(self.ui.Text_Remainder, TimeUtils.ActivityCountDownFormat(leftTime))
  end, function()
    self.binder:SetText(self.ui.Text_Remainder, LT.Text("ActivityTimeExpired"))
    self:_ClearTimer()
  end)
end

function PopUpAdPanel:OnUnbind()
  Super.OnUnbind(self)
  table.clear(self._indicatorList)
  table.clear(self._indicatorBrightList)
  self._indicatorList = nil
  self._indicatorBrightList = nil
  if self.closeCb then
    self.closeCb()
  end
end

function PopUpAdPanel:OnClickLeft()
  self.showIndex = self.showIndex - 1
  if self.showIndex < 1 then
    self.showIndex = self.adCount
  end
  self:RefreshAd(self.adTidList[self.showIndex])
end

function PopUpAdPanel:OnClickRight()
  self.showIndex = self.showIndex + 1
  if self.showIndex > self.adCount then
    self.showIndex = 1
  end
  self:RefreshAd(self.adTidList[self.showIndex])
end

function PopUpAdPanel:CreataRewardTable()
  local baseGameObj = self.ui.UI_Dungeous_Item_Award_1
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = UIBasePanel.CreateTableview(self, self.ui.RewardScrollView, function()
    return #self.rewardList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local itemData = self.rewardList[idx]
    itemComps[gameObj] = self.binder:BindComponent(require("UI.Public.Item.CommonIconItemType2")(gameObj, itemData))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function PopUpAdPanel:RefreshShowItems(ShowItems)
  local rewards = {}
  for _, itemTid in ipairs(ShowItems or {}) do
    table.insert(rewards, {itemTid = itemTid, itemCount = ""})
  end
  self.rewardList = rewards
  self.tableView:ReloadData()
end

function PopUpAdPanel:ClearStalePopupAdClientData()
  local subTable = ClientDataUtils.GetSubTable(cd.ClientDataMainKey.PopupAd)
  if not subTable or next(subTable) == nil then
    return
  end
  local now = TimeUtils.GetServerTime()
  local currentSet = {}
  for _, adTid in ipairs(self.adTidList) do
    currentSet[tostring(adTid)] = true
  end
  local toRemove = {}
  for subKey, forbidPopTime in pairs(subTable) do
    if "" ~= subKey and not currentSet[subKey] and forbidPopTime and now > forbidPopTime then
      table.insert(toRemove, subKey)
    end
  end
  if #toRemove > 0 then
    ClientDataUtils.DelSubKeys(cd.ClientDataMainKey.PopupAd, toRemove, true)
  end
end

return PopUpAdPanel
