local DiamondChargeItemTid = DT.GetConstant("DiamondChargeItemTid")
local DiamondItemTid = DT.GetConstant("DiamondItemTid")
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local MidJumpBtnPosX = -137
local MidJumpBtnPosY = -304
local JUMPBTNNUM = 8
local _FirstResumonAlerted = false
local SummonPoolType = CommonDefine.SummonPoolType
local ItemType = CommonDefine.ItemType
local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector2 = CS.UnityEngine.Vector2
local TypeImage = typeof(CS.UnityEngine.UI.Image)
local SummonPanel, Super = System.NewClass("SummonPanel", UIBasePanel)
SummonPanel.uiResCls = UI_Summon_Panel_MainResource

function SummonPanel:ctor(poolId, isMainBanner)
  Super.ctor(self)
  self.poolId = poolId
  self.isMainBanner = isMainBanner
  self.poolIntoModelDict = {}
  self.clipsToPlay = ""
end

function SummonPanel:OnBind(binder)
  local model = binder:createModel(SummonPanelModel, self.poolId, self.isMainBanner)
  self.model = model
  self.binder = binder
  self.timer = binder:BindTimer(1, -1, System.fn(self, self.TimerTick))
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.rebrushAnimController = self.ui.UI_Summon_Vx_Refurbish_01:GetComponent(typeof(UIAnimationController))
  self:_RefreshCashPoolItemEnoughFlag(self.model.curPoolId)
  self:_BindCashPoolItemSnapshot(binder)
  self:BindComp(binder)
  self:BindRaw(binder)
  self:BindText(binder)
  self:BindImage(binder)
  self:BindVisable(binder)
  self:BindButton(binder)
  self:BindCircularListView(binder)
  self:BindDailySummonButton(binder)
  self:BindWeaponPreview(binder)
  self:OnRefreshRemainingTimes(binder)
  self:BindSummonItemDesc(binder)
  self:BindLuckyBag(binder)
  self:BindPoolGroup(binder)
  self:BindGiftTask(binder)
  self:_OnBindMultiAwakerWeaponComp(binder)
  self:_OnBindSpecialChooseUp(binder)
  self:_OnBindEvent(binder)
  self:_OnBindCurrencyGroup(binder)
  SummonPanel_WishAwaker.OnBind(self, binder)
  SummonPanel_CategorySelect.OnBind(self, binder)
  LateUpdateBeat.Instance:Add(self.PlayAnimation, self)
  SummonUiUtils.isQuickSummon = false
end

function SummonPanel:_OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.OnChooseUpAwaker, function()
    self:_OnChooseUpAwaker(binder, self.model.curPoolId)
  end)
  binder:BindEvent(EventMgr.Instance.OnSummonPoolClosed, function()
    self:_LuckyBagClosed(self.model.curPoolId)
  end)
  binder:BindEvent(EventMgr.Instance.OnLuckyBagSummon, function()
    self:_OnLuckyBagSummon(binder, self.model.curPoolId)
  end)
end

function SummonPanel:OnUnbind()
  Super.OnUnbind(self)
  LateUpdateBeat.Instance:Remove(self.PlayAnimation, self)
end

function SummonPanel:BindJumpButton(poolId, binder)
  if not self.ui then
    return
  end
  if not self.btnRes then
    self.btnRes = {}
  end
  for i = 1, JUMPBTNNUM do
    local btnObj = self.ui["UI_Summon_Btn_Jump_" .. i]
    binder:SetActive(btnObj, false)
    if not self.btnRes[i] then
      self.btnRes[i] = UI_Summon_Btn_JumpResource(btnObj)
    end
  end
  local btnNum = 0
  local summonCfg = self.model.poolCfg
  local btnPosList = summonCfg.DetailBtnPos
  local btnTidList = summonCfg.DetailItem or {}
  if not (summonCfg and btnPosList) or not btnTidList then
    return
  end
  if self.model.chooseItemTid then
    btnTidList = {
      self.model.chooseItemTid
    }
    btnPosList = {
      {MidJumpBtnPosX, MidJumpBtnPosY}
    }
  end
  btnNum = #btnTidList
  for i = 1, JUMPBTNNUM do
    local btnObj = self.ui["UI_Summon_Btn_Jump_" .. i]
    binder:SetActive(btnObj, i <= btnNum)
    if i <= btnNum then
      local itemID = btnTidList[i]
      local itemCfg = DT.Item[itemID]
      if itemCfg.Type == ItemType.Weapon then
        self:InitWeaponJumpBtn(binder, btnObj, itemID, btnPosList, i, summonCfg)
      else
        self:InitAwakerJumpBtn(binder, btnObj, itemID, btnPosList, i, summonCfg)
      end
    end
  end
end

function SummonPanel:InitWeaponJumpBtn(binder, btnObj, itemID, btnPosList, idx, summonCfg)
  self:_SetWeaponJumpButtonInfo(self.btnRes[idx], summonCfg, itemID)
  self.SetButtonLocation(btnObj, btnPosList[idx][1], btnPosList[idx][2])
end

function SummonPanel:InitAwakerJumpBtn(binder, btnObj, itemID, btnPosList, idx, summonCfg)
  local awakerTid = DT.Item[itemID].SpParam[1]
  self:_SetAwakerJumpButtonInfo(self.btnRes[idx], summonCfg, awakerTid)
  self.SetButtonLocation(btnObj, btnPosList[idx][1], btnPosList[idx][2])
end

function SummonPanel:BindDailySummonButton(binder)
  binder:BindToVisible(self.ui.UI_Common_Item_Hint, function()
    return false
  end)
  binder:BindToRaw(function(cBinder, nVal, _)
    local nPoolId = nVal[1]
    local nSummonTimes = nVal[2]
    local haveDiscountCfg = SummonDataUtils.CheckDiscountSummon(nPoolId)
    local needSelectBeforeSummon = SummonDataUtils.NeedSelectBeforeSummon(nPoolId)
    local needShowDailySummonBtn = haveDiscountCfg and 0 == nSummonTimes and not needSelectBeforeSummon
    cBinder:SetActive(self.ui.Btn_Awaker_Daily, needShowDailySummonBtn)
    cBinder:SetActive(self.ui.Image_Gradient, needShowDailySummonBtn)
    cBinder:SetActive(self.ui.Text_Additional, needShowDailySummonBtn)
    cBinder:SetActive(self.ui.Text_Additional_Str, needShowDailySummonBtn)
    cBinder:SetActive(self.ui.Image_Additional_Icon, needShowDailySummonBtn)
    if needShowDailySummonBtn then
      self.rebrushAnimController:PlayState("UI_Summon_Vx_Refurbish_01")
    end
  end, function()
    local playerStatsType = SummonDataUtils.GetPlayerStatsTypeByPoolId(self.model.curPoolId)
    local dailySummonTimes = PlayerDataUtils.GetStatsDataByKeyType(CommonDefine.PlayerStatsKey.daily, playerStatsType)
    return {
      self.model.curPoolId,
      dailySummonTimes
    }
  end)
  binder:BindToImage(self.ui.Image_Btn_Awaker_Daily, function()
    local costItemId, _ = SummonDataUtils.GetSummonDiscountCostInfo(self.model.curPoolId)
    return costItemId and DT.Item[costItemId] and DT.Item[costItemId].Icon
  end)
  binder:BindToText(self.ui.Text_Daily, function()
    do return LT.Text end
    return LT.Text, "SummonDailyDiscount"
  end)
  self.ui.Text_Daily:SetActive(false)
  binder:BindToText(self.ui.Text_Awaker_Daily, function()
    local _, costNum = SummonDataUtils.GetSummonDiscountCostInfo(self.model.curPoolId)
    return costNum and LT.Text(ItemNumUtils.GetStr(costNum)) or ""
  end)
  local extraInfoParam = DT.GetOriginalConstant("SummonDiscountExtraAward")
  UIAdditionalRewardUtils.BindAdditionalReward(self.binder, self.ui.Text_Additional, self.ui.Image_Additional_Icon, extraInfoParam[1], extraInfoParam[2])
  binder:SetText(self.ui.Text_Additional_Str, LT.Text("ExtraGift"))
end

function SummonPanel:OnClickDailySummon()
  local discountCareer = SummonDataUtils.GetDiscountCareer()
  local curPoolCfg = SummonDataUtils.GetSummonConfig(self.model.curPoolId)
  if curPoolCfg.Type == CommonDefine.SummonPoolType.NormalAwaker and discountCareer ~= curPoolCfg.ShowSchool then
    return
  end
  if self.model:WeaponCntMaxCheck() then
    return
  end
  local poolId = self.model.curPoolId
  SummonDataUtils.SetSummonGainShowList({})
  local costItemId, costItemNum = SummonDataUtils.GetSummonDiscountCostInfo(poolId)
  local ownedNum = ItemDataUtils.GetItemNum(costItemId)
  if costItemNum > ownedNum then
    Alert.Show(10635, nil, function()
      UIManager.Instance:Reopen(Urls.ChargeMainPanel)
    end)
    return
  end
  if ItemDataUtils.IsPayMoneyType(costItemId) then
    Alert.ShowPayMoneyBuyConfirm(costItemNum, function()
      self:ReqSummon(poolId)
    end)
  else
    self:ReqSummon(poolId)
  end
end

function SummonPanel:ReqSummon(poolId)
  SummonDataUtils.ReqSummon(poolId, 1, CommonDefine.SummonType.Diamond, function(summonResult)
    local function showRewardFunc()
      PopTipsManager.Instance:SetTutorialLock(false)
    end
    
    UIManager.Instance:CloseByUrl(Urls.SummonedAwakerPanel)
    UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, poolId, true, showRewardFunc)
  end)
end

function SummonPanel.SetButtonLocation(btnObj, x, y)
  local btnRect = btnObj:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not btnRect then
    return
  end
  btnRect.localPosition = CS.UnityEngine.Vector3(x, y, 0)
end

function SummonPanel:_SetWeaponJumpButtonInfo(ui, summonCfg, itemTid)
  SummonUiUtils.RefreshWeaponJumpButtonInfo(self.binder, ui, 1 == summonCfg.HideDetailBtn, itemTid)
end

function SummonPanel:_SetAwakerJumpButtonInfo(ui, summonCfg, awakerTid)
  SummonUiUtils.RefreshAwakerJumpButtonInfo(self.binder, ui, 1 == summonCfg.HideDetailBtn, awakerTid)
end

function SummonPanel:_BindCashPoolItemSnapshot(binder)
  binder:BindToRaw(function(_, poolId)
    self:_RefreshCashPoolItemEnoughFlag(poolId)
  end, function()
    return self.model.curPoolId
  end)
end

function SummonPanel:_RefreshCashPoolItemEnoughFlag(poolId)
  self._cashPoolItemEnoughMap = self._cashPoolItemEnoughMap or {}
  if not poolId or poolId <= 0 then
    return
  end
  if not SummonCfgUtils.IsCashDirectPurchasePool(poolId) then
    return
  end
  local targetCostItemTid, targetCostItemNum = SummonDataUtils.Get10TimesPrice(poolId)
  local ownedNum = ItemDataUtils.GetItemNum(targetCostItemTid)
  self._cashPoolItemEnoughMap[poolId] = ownedNum > 0 and targetCostItemNum <= ownedNum
end

function SummonPanel:_HasCashPoolEnoughItem(poolId)
  return self._cashPoolItemEnoughMap and self._cashPoolItemEnoughMap[poolId] == true
end

function SummonPanel:_OnBindCurrencyGroup(binder)
  binder:BindToRaw(function(itemBinder, poolId)
    local targetCurrencyList = {DiamondChargeItemTid, DiamondItemTid}
    local costItemTidList = SummonCfgUtils.GetPoolCostItemTidList(poolId)
    for _, costItemTid in ipairs(costItemTidList) do
      table.insert(targetCurrencyList, 1, costItemTid)
    end
    itemBinder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, targetCurrencyList))
  end, function()
    return self.model.curPoolId
  end)
end

function SummonPanel:BindComp(binder)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  binder:BindButtonClick(self.ui.Btn_Prob, function()
    local curPoolId = self.model.curPoolId
    local introModel = self.poolIntoModelDict[curPoolId]
    if not introModel then
      local schoolEn, poolType = nil, self.model.poolCfg.Type
      if poolType == cd.SummonPoolType.NormalAwaker or poolType == cd.SummonPoolType.LuckyBag then
        local showSchool = self.model.poolCfg.ShowSchool
        schoolEn = showSchool and DT.SchoolConfig[showSchool].NameEn
      end
      introModel = binder:createModel(SummonIntroModel, curPoolId, schoolEn)
      self.poolIntoModelDict[curPoolId] = introModel
    end
    SummonDataUtils.OpenIntroPanel(introModel)
  end)
  binder:BindButtonClick(self.ui.Btn_Exchange, function()
    local shopType = CommonDefine.MainShopTypeTag.AdvanceDC
    MainShopDataUtils.OnOpenShop(shopType, function()
      AudioManager.Instance:PostSoundEvent("SET_STATE_A_INTERFACE_AWAKING")
    end)
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Realms, CommonDefine.RedDotType.Dot, nil, function()
    if self:_IsNormalAwakerPool() then
      do return RedPointDataUtils.GetRedPointState end
      return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.DrawCardChooseCareer
    end
    do return RedPointDataUtils.IsShowNormalWeaponPoolTargetedRed end
    return RedPointDataUtils.IsShowNormalWeaponPoolTargetedRed, self.model.curPoolId
  end))
end

function SummonPanel:BindRaw(binder)
  binder:BindToRaw(function(itemBinder, vt)
    if not vt then
      return
    end
    local poolId = vt[1]
    local costItemTid = vt[2]
    local costItemNum = vt[3]
    if poolId <= 0 then
      return
    end
    local poolCfg = SummonDataUtils.GetSummonConfig(poolId)
    local poolData = SummonDataUtils.GetPoolData(poolId)
    if poolCfg and poolData then
      self:RefreshShow(itemBinder, poolCfg)
      self:DifficultShow(itemBinder, poolCfg.ShowSchool)
      self:BeginPoolShow(itemBinder, poolCfg, poolData)
      self:_RefreshOnceSummonBtn()
      if not SummonCfgUtils.IsCashDirectPurchasePool(poolId) and poolCfg.TenTimesConsumeTicket then
        local oldPrice = CommonDefine.MultiSummonTimes * costItemNum
        local discountedPrice = poolCfg.TenTimesConsumeTicket[2]
        if oldPrice > discountedPrice then
          binder:SetText(self.ui.Text_Origin_Price, tostring(oldPrice))
          local discountedOff = math.floor((discountedPrice - oldPrice) / oldPrice * 100)
          binder:SetText(self.ui.Text_Price_Off, tostring(discountedOff) .. "%")
        end
      else
        binder:SetText(self.ui.Text_Origin_Price, "")
        binder:SetText(self.ui.Text_Price_Off, "")
      end
    end
    binder:SetText(self.ui.Text_Awaker_Once, ItemNumUtils.GetStr(costItemNum))
    if SummonCfgUtils.IsCashDirectPurchasePool(poolId) then
      local noLeftSummonTimes = not SummonDataUtils.IsLeftSummonTimes(self.model.curPoolId)
      if not noLeftSummonTimes and self:_HasCashPoolEnoughItem(self.model.curPoolId) then
        binder:SetActive(self.ui.Image_Awaker_Icon, false)
        binder:SetActive(self.ui.Text_Name, false)
        binder:SetText(self.ui.Text_Awaker_Ten, "")
      else
        binder:SetActive(self.ui.Text_Name, true)
        local _, priceStr = SummonCfgUtils.GetCashDirectPurchaseChargeInfo(poolId)
        binder:SetActive(self.ui.Image_Awaker_Icon, false)
        binder:SetText(self.ui.Text_Awaker_Ten, priceStr or "")
      end
    else
      binder:SetActive(self.ui.Text_Name, true)
      local tenTimesPrice = costItemNum * CommonDefine.MultiSummonTimes
      if poolCfg.TenTimesConsumeTicket ~= nil then
        tenTimesPrice = poolCfg.TenTimesConsumeTicket[2]
      end
      binder:SetImage(self.ui.Image_Awaker_Icon, ItemDataUtils.GetSmallIcon(costItemTid))
      binder:SetActive(self.ui.Image_Awaker_Icon, true)
      if self.model:IsTenSummonDiscount() then
        local colorCode = DT.ColorConfig.UXScore.Light
        tenTimesPrice = string.format("<color=%s>%s</color>", colorCode, ItemNumUtils.GetStr(tenTimesPrice))
        binder:SetText(self.ui.Text_Awaker_Ten, tenTimesPrice)
      else
        binder:SetText(self.ui.Text_Awaker_Ten, ItemNumUtils.GetStr(tenTimesPrice))
      end
    end
    local isFirstResummon = SummonDataUtils.IsFirstResummon(poolCfg.ID)
    local isFreeSummon = vt[6]
    itemBinder:SetActive(self.ui.Group_Cost_Ten, not isFirstResummon and not isFreeSummon)
    itemBinder:SetActive(self.ui.Text_FreeTen, isFirstResummon or isFreeSummon)
  end, function()
    local poolId = self.model.curPoolId
    if 0 == poolId then
      return {
        poolId,
        0,
        0,
        0
      }
    end
    local costItemId, costItemNum = SummonDataUtils.GetSummonCostInfo(poolId)
    local ownedNum = ItemDataUtils.GetItemNum(costItemId)
    local poolData = SummonDataUtils.GetPoolData(poolId)
    local isFreeSummon = SummonDataUtils.IsSummonPoolHaveFree(poolId) > 0
    return {
      poolId,
      costItemId,
      costItemNum,
      ownedNum,
      poolData,
      isFreeSummon,
      self.model.chooseItemTid,
      SummonDataUtils.GetChooseUpSSRItemTid(self.model.poolCfg.Type, self.model.curPoolId)
    }
  end)
  binder:BindToRaw(function(itemBinder, isNormalAwakerPool)
    if isNormalAwakerPool then
      NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_SummonFiveBtn", self.ui.Btn_Awaker_Ten, Urls.SummonPanel)
    else
      NewbieGuideManager.Instance:UnregisterNewbieGo("GuideGo_SummonFiveBtn")
    end
  end, function()
    return self.model.poolCfg.Type == CommonDefine.SummonPoolType.NewbiePool
  end)
  FrameWaiter.OnNextFrame(function()
    binder:BindToRaw(function(itemBinder)
      local curPoolId = self.model.curPoolId
      if 0 == curPoolId then
        return
      end
      local poolTidList = self.model.poolTidList
      for _, tid in ipairs(poolTidList) do
        self.RemovePoolRedData(tid)
      end
      self:BindJumpButton(curPoolId, itemBinder)
    end, function()
      return {
        self.model.curPoolId,
        self.model.chooseItemTid
      }
    end)
  end)
end

function SummonPanel:BindText(binder)
  binder:BindToText(self.ui.Text_Time, function()
    do return LT.Text end
    return LT.Text, self.model.leftTimeText
  end)
  binder:BindToText(self.ui.Text_Hint, function()
    if self:_IsNormalAwakerPool() then
      do return LT.Text end
      return LT.Text, "Summon_SelectSchool_Tips"
    elseif self:_IsNormalWeaponPool() then
      do return LT.Text end
      return LT.Text, "Summon_SelectWeapon_Tips"
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Free, function()
    do return LT.Text end
    return LT.Text, "Summon_Free"
  end)
  binder:BindToText(self.ui.Text_Realms, function()
    if self:_IsNormalAwakerPool() then
      do return LT.Text end
      return LT.Text, "Summon_SelectSchool"
    elseif self:_IsNormalWeaponPool() then
      do return LT.Text end
      return LT.Text, "Summon_SelectWeapon"
    end
    return ""
  end)
  binder:BindToRaw(function(itemBinder, curPoolId, oldPoolId)
    local rst = ""
    local poolConfig = SummonDataUtils.GetSummonConfig(curPoolId)
    if not poolConfig then
      itemBinder:SetText(self.ui.Text_Desc_2, rst)
      itemBinder:SetActive(self.ui.Text_Desc_2, false)
      return
    end
    if poolConfig.Type == CommonDefine.SummonPoolType.ChooseUp then
      local awakerTid = SummonDataUtils.GetChooseUpSSRAwakerTid(poolConfig.Type, curPoolId)
      if awakerTid then
        local shoolTid = AwakerCfgUtils.GetCfgField("School", awakerTid)
        local schoolColor = SummonUiUtils.GetSummonColorBySchool(shoolTid)
        rst = LT.Textf(poolConfig.ShortDesc, schoolColor, AwakerDataUtils.GetSchoolName(shoolTid))
      else
        rst = LT.Text("GoldenWeekSummonDesc2")
      end
    elseif poolConfig and poolConfig.ShortDesc then
      local poolData = SummonDataUtils.GetPoolData(curPoolId)
      local leftTimes = poolData.leftSummonSSRNum
      if leftTimes then
        rst = LT.Textf(poolConfig.ShortDesc, leftTimes)
      end
    end
    itemBinder:SetText(self.ui.Text_Desc_2, rst)
    itemBinder:SetActive(self.ui.Text_Desc_2, "" ~= rst)
    itemBinder:BindToRaw(function()
      self:_OnChooseUpAwaker(itemBinder, curPoolId, oldPoolId)
    end, function()
      do return SummonDataUtils.GetChooseUpSSRItemTid, self.model.poolCfg.Type end
      return SummonDataUtils.GetChooseUpSSRItemTid, self.model.poolCfg.Type, self.model.curPoolId
    end)
  end, function()
    return self.model.curPoolId
  end, true)
end

function SummonPanel:_OnChooseUpAwaker(itemBinder, curPoolId, oldPoolId)
  local poolConfig = SummonDataUtils.GetSummonConfig(curPoolId)
  if not poolConfig then
    return
  end
  local poolTypeNeedShow = poolConfig.Type ~= CommonDefine.SummonPoolType.ChooseUp or not SummonDataUtils.GetChooseUpSSRItemTid(poolConfig.Type, curPoolId)
  CS.UnityEngine.GameObject.Destroy(self._baseMapObj)
  self._baseMapObj = nil
  if poolConfig.VXPrefab and poolTypeNeedShow then
    local prefab = self.binder:LoadAsset(poolConfig.VXPrefab)
    self._baseMapObj = self.binder:Instantiate(prefab, self.ui.Basemap.transform)
    self:_OnPoolVXFx(self._baseMapObj)
  end
  if not self:_NeedShowAwakerWeaponGroup(poolConfig.Type) then
    self.ui.Group_AwakerWeapon:SetActive(false)
    if self:IsPoolSpecial(curPoolId) then
      self.ui.bg.transform.anchoredPosition = CS.UnityEngine.Vector2(-40, 0)
    else
      self.ui.bg.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
    end
    self.binder:SetActive(self.ui.bg, true)
  end
  if oldPoolId then
    self.clipsToPlay = AddClipToPlay(self.clipsToPlay, "UI_Summon_Panel_Main_Change")
  end
  if self:_NeedShowAwakerWeaponGroup(poolConfig.Type) then
    self.ui.Group_AwakerWeapon:SetActive(false)
    if self:IsPoolSpecial(curPoolId) then
      self.ui.bg.transform.anchoredPosition = CS.UnityEngine.Vector2(-40, 0)
    else
      self.ui.bg.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
    end
    self.binder:SetActive(self.ui.bg, true)
    FrameWaiter.OnNextFrame(function()
      if self:_NeedShowAwakerWeaponGroup(poolConfig.Type) then
        self.ui.Group_AwakerWeapon:SetActive(true)
        if self:IsPoolSpecial(curPoolId) then
          self.ui.bg.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
          self.binder:SetActive(self.ui.bg, false)
          self.binder:BindTimer(0.03, 0, nil, function()
            self.binder:SetActive(self.ui.bg, false)
          end)
        end
        local portraitAlign = CommonDefine.PortraitAlign.Center
        local awakerTid = self:_GetShowAwakerTid()
        if awakerTid then
          itemBinder:BindComponent(AwakerPortraitComp(self.ui.AwakerCon, awakerTid, nil, nil, portraitAlign))
          local awakerInfoUi = UI_Summon_Btn_JumpResource(self.ui.UI_Summon_Btn_Jump_Awaker)
          SummonUiUtils.RefreshAwakerJumpButtonInfo(itemBinder, awakerInfoUi, false, awakerTid)
          local targetWeaponTid = self:_GetShowWeaponTid(awakerTid)
          if targetWeaponTid then
            local weaponSpIcon = ItemDataUtils.GetSpIcon(targetWeaponTid)
            itemBinder:BindComponent(AwakerWeaponPrefab(self.ui.WeaponCon, weaponSpIcon, 1))
            local weaponInfoUi = UI_Summon_Btn_JumpResource(self.ui.UI_Summon_Btn_Jump_Weapon)
            SummonUiUtils.RefreshWeaponJumpButtonInfo(itemBinder, weaponInfoUi, false, targetWeaponTid)
          end
        end
      end
    end, 2)
    self.clipsToPlay = AddClipToPlay(self.clipsToPlay, "UI_Summon_Panel_Main_Group_AwakerWeapon_Open")
  end
end

function SummonPanel:PlayAnimation()
  if not self.clipsToPlay then
    return
  end
  if self._isPlayingOpenAnim then
    self.clipsToPlay = nil
    return
  end
  if not self._playedOpenAnim then
    self.clipsToPlay = AddClipToPlay(self.clipsToPlay, "UI_Summon_Panel_Main_Open")
    self._isPlayingOpenAnim = true
  end
  self.uiAnimController:ClearCompleteCb()
  self.uiAnimController:StopPlayableGraph()
  self.uiAnimController:PlayMultiState(self.clipsToPlay, function()
    if self._isPlayingOpenAnim then
      self._isPlayingOpenAnim = false
      self:PlayAnimation()
    else
      self.uiAnimController:LoopPlayState("UI_Summon_Panel_Main_Working")
    end
  end)
  self.clipsToPlay = nil
  self._playedOpenAnim = true
end

function SummonPanel:BindImage(binder)
  binder:BindToImage(self.ui.Image_Realms, function()
    local rst = ""
    if table.contains(DT.Constant.SummonCareerSelectList.Data, self.model.curPoolId) then
      local schoolConfig = SummonDataUtils.GetSummonShowSchoolConfig(self.model.curPoolId)
      if schoolConfig and schoolConfig.Icon then
        rst = schoolConfig.Icon
      end
    end
    return rst
  end)
  binder:BindToVisible(self.ui.Image_Awaker_Icon_2, function()
    return not SummonCfgUtils.IsCashDirectPurchasePool(self.model.curPoolId)
  end)
  binder:BindToImage(self.ui.Image_Awaker_Icon_2, function()
    local costTid = SummonDataUtils.Get10TimesPrice(self.model.curPoolId)
    do return ItemDataUtils.GetSmallIcon end
    return ItemDataUtils.GetSmallIcon, costTid
  end)
  binder:BindToImage(self.ui.Image_Light, function()
    if table.contains(DT.Constant.SummonCareerSelectList.Data, self.model.curPoolId) then
      local schoolConfig = SummonDataUtils.GetSummonShowSchoolConfig(self.model.curPoolId)
      return schoolConfig.SummonLightPic
    end
    return nil
  end)
  binder:BindToVisible(self.ui.Image_Light, function()
    do return table.contains, DT.Constant.SummonCareerSelectList.Data end
    return table.contains, DT.Constant.SummonCareerSelectList.Data, self.model.curPoolId
  end)
end

function SummonPanel:BindCircularListView(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Summon_Toggle, function()
    self._showPoolList = SummonDataUtils.GetShowPoolList()
    return self._showPoolList
  end, function(itemBinder, obj, index)
    local showData = self._showPoolList[index]
    
    local function clickFunc(clickedPoolId)
      self.model:SetCurrPoolId(clickedPoolId)
      self.model:SetPoolTidList(showData.poolTidList or {})
      self:OnRefreshRemainingTimes(binder)
    end
    
    local function redFunc()
      local redList = {}
      for i, tid in ipairs(showData.poolTidList) do
        if not SummonDataUtils.IsLuckyBagPool(tid) then
          table.insert(redList, RedPointDataUtils.CheckSummonRed(tid))
        end
      end
      do return RedPointDataUtils.PickHighWeightRedData end
      return RedPointDataUtils.PickHighWeightRedData, redList, ipairs(showData.poolTidList)
    end
    
    itemBinder:BindComponent(SummonListItem(obj, showData, clickFunc, redFunc, self.model))
  end)
end

function SummonPanel:OnRefreshRemainingTimes(binder)
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  local poolData = SummonDataUtils.GetPoolData(self.model.curPoolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(self.model.curPoolId)
  local poolType = poolCfg.Type
  if nil == poolData or poolType == SummonPoolType.NormalWeapon then
    binder:SetActive(self.ui.Text_Remainder, false)
    binder:SetActive(self.ui.Image_Remainder, false)
    return
  end
  binder:SetActive(self.ui.Text_Remainder, false)
  binder:SetActive(self.ui.Image_Remainder, false)
  if nil ~= poolData and nil ~= poolData.endTime then
    local timeStr = ""
    if poolData and poolData.endTime then
      local leftTime = poolData.endTime - TimeUtils.GetServerTime()
      if leftTime > 0 then
        local d = math.floor(leftTime / 3600 / 24)
        if d > 0 then
          timeStr = TimeUtils.ActivityCountDownFormat(leftTime)
        else
          timeStr = LT.Textf("Summon_Time_Remain2", TimeUtils.format(leftTime, CommonDefine.TimeParseType.hms))
        end
      end
    end
    binder:SetActive(self.ui.Text_Remainder, true)
    binder:SetActive(self.ui.Image_Remainder, true)
    binder:SetText(self.ui.Text_Remainder, timeStr)
    binder:SetActive(self.ui.Image_Time_Icon, true)
  end
  if not table.contains({
    cd.SummonPoolType.LuckyBag,
    cd.SummonPoolType.TripleLuckyBag
  }, poolType) then
    self:OnRefreshLuckyBagRemainingTimes(binder)
  end
end

function SummonPanel:OnRefreshLuckyBagRemainingTimes(binder)
  local poolData = SummonDataUtils.GetPoolData(self.model.curPoolId)
  if poolData.summonTimes ~= nil and poolData.summonTimes > 0 then
    local timeStr = LT.Textf("Summon_Times_Left", poolData.summonTimes)
    binder:SetActive(self.ui.Text_Remainder, true)
    binder:SetActive(self.ui.Image_Remainder, true)
    binder:SetText(self.ui.Text_Remainder, timeStr)
    binder:SetActive(self.ui.Image_Time_Icon, false)
  end
end

function SummonPanel:BindLuckyBag(binder)
  binder:BindToRaw(function(itemBinder, curPoolId, prePoolId)
    local poolId = self.model.curPoolId
    local isLuckyBag = SummonDataUtils.IsLuckyBagPool(curPoolId)
    if isLuckyBag then
      poolId = self.model.curPoolId
      itemBinder:BindNewComponent(self.ui.bg, SummonLuckyBag, SummonLuckyBag.uiResCls, poolId)
    end
  end, function()
    return self.model.curPoolId
  end)
end

function SummonPanel:BindPoolGroup(binder)
  self._poolGroupItem = binder:BindNewComponent(self.ui.uiNode, SummonPoolGroupItem, UI_Summon_MixPoolGroupResource, self.model)
end

function SummonPanel:BindGiftTask(binder)
  binder:BindToRaw(function(itemBinder, curPoolId)
    local skinTaskInfo = ActivityCfgUtils.GetSummonSkinTaskInfo(curPoolId)
    itemBinder:BindComponent(ActivitySkinTaskItem(self.ui.UI_Summon_GiftTask, skinTaskInfo))
  end, function()
    return self.model.curPoolId
  end)
end

function SummonPanel:BindSummonItemDesc(binder)
  binder:BindToRaw(function(itemBinder, weaponTid)
    local itemCfg = ItemDataUtils.GetItemConfig(weaponTid) or {}
    itemBinder:SetActive(self.ui.stroyDesc, 0 ~= weaponTid)
    itemBinder:SetActive(self.ui.Group_RecAwaker, itemCfg.RecommendedAwaker)
    local detailAwakerCfg = itemCfg.SubType == cd.ItemSubType.Awaker and itemCfg.SpParam and AwakerDataUtils.GetAwakerConfig(itemCfg.SpParam[1]) or nil
    itemBinder:SetText(self.ui.Text_Stroy, detailAwakerCfg and detailAwakerCfg.Introduction or itemCfg.Desc)
    if itemCfg.RecommendedAwaker then
      self:SetRecommendAwaker(itemBinder, itemCfg.RecommendedAwaker)
      self.ui.StoryView.transform.sizeDelta = Vector2(426, 180)
    else
      self.ui.StoryView.transform.sizeDelta = Vector2(426, 260)
    end
  end, function()
    local selectWeaponTid = SummonDataUtils.GetChooseUpMapByType(self.model.poolCfg.Type)
    if selectWeaponTid then
      return selectWeaponTid
    end
    local poolConfig = SummonDataUtils.GetSummonConfig(self.model.curPoolId)
    if not poolConfig then
      return 0
    end
    local DetailItem = poolConfig.DetailItem or {}
    local onlyOne = 1 == #DetailItem
    local firstItem = DetailItem[1]
    if onlyOne then
      return firstItem
    end
    return 0
  end)
end

function SummonPanel:SetRecommendAwaker(itemBinder, awakerTid)
  itemBinder:BindButtonClick(self.ui.Btn_RecAwaker_Click, function()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(awakerTid)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end)
  itemBinder:SetImage(self.ui.Icon_RecAwaker, AwakerDataUtils.GetLittleIcon(awakerTid, true))
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(awakerTid)
  itemBinder:SetImage(self.ui.Image_RecAwaker_Career, AwakerDataUtils.GetSchoolIcon(awakerCfg.School))
  itemBinder:SetImage(self.ui.Image_RecAwaker_Quality, ItemQualityCfgUtils.GetCfgField("ItemQualityColor", awakerCfg.Quality))
end

function SummonPanel:BindVisable(binder)
  binder:BindToVisible(self.ui.Btn_Choose, function()
    return self:_IsChooseUpAwakerPool() and not SummonDataUtils.GetChooseUpSSRItemTid(self.model.poolCfg.Type, self.model.curPoolId)
  end)
  binder:BindToVisible(self.ui.Btn_Awaker_Ten, function()
    if SummonDataUtils.NeedSelectBeforeSummon(self.model.curPoolId) then
      return false
    end
    return not self:_IsChooseUpAwakerPool() or SummonDataUtils.GetChooseUpSSRItemTid(self.model.poolCfg.Type, self.model.curPoolId)
  end)
  binder:BindToRaw(function(itemBinder, isNormalPool)
    itemBinder:SetActive(self.ui.Btn_Realms, isNormalPool)
    self.ui.Btn_Trial.transform.anchoredPosition = CS.UnityEngine.Vector2(isNormalPool and 207 or 57, -3.1)
  end, function()
    return self:_IsNormalAwakerPool() or self:_IsNormalWeaponPool()
  end)
  binder:BindToVisible(self.ui.Btn_Trial, function()
    do return self.IsAwakerPool end
    return self.IsAwakerPool, self
  end)
  binder:BindToVisible(self.ui.Image_Hint, function()
    local showSelectAwaker = self:_IsNormalAwakerPool() and RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.DrawCardChooseCareer)
    local showSelectWeapon = self:_IsNormalWeaponPool() and not SummonDataUtils.GetChooseUpMapByType(CommonDefine.SummonPoolType.NormalWeapon)
    return showSelectAwaker or showSelectWeapon
  end)
  binder:BindToVisible(self.ui.Group_Discount, function()
    do return self.model.IsTenSummonDiscount end
    return self.model.IsTenSummonDiscount, self.model
  end)
end

function SummonPanel:BindButton(binder)
  binder:BindZ1Button(self.ui.Btn_Awaker_Once, function()
    self.model:ReqSingleSummon()
  end, function()
    if self.model:CheckTargetedPoolNotSelect() then
      binder:SetTextColorType(self.ui.Text_Awaker_Once, CommonDefine.ColorType.Dark)
      return CommonDefine.BtnType.Unclickable
    end
    binder:SetTextColorType(self.ui.Text_Awaker_Once, CommonDefine.ColorType.Light)
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Summon_DrawOnce_Btn"
  end, function()
    return false
  end)
  binder:BindZ1Button(self.ui.Btn_Awaker_Ten, function()
    local curPoolId = self.model.curPoolId
    if SummonCfgUtils.IsCashDirectPurchasePool(curPoolId) then
      if not self.model:CheckCanMultiSummon() then
        return
      end
      if SummonDataUtils.TryAutoSummonByItemCount(curPoolId) then
        return
      end
      self.model:ReqCashDirectPurchase()
      return
    end
    if SummonDataUtils.IsFirstResummon(curPoolId) and not _FirstResumonAlerted then
      Alert.Show(300001, nil, function()
        _FirstResumonAlerted = true
        self.model:ReqMultiSummon(CommonDefine.MultiSummonTimes)
      end)
      return
    end
    self.model:ReqMultiSummon(CommonDefine.MultiSummonTimes)
  end, function()
    local targetPoolNotSelect = self.model:CheckTargetedPoolNotSelect()
    local noLeftSummonTimes = not SummonDataUtils.IsLeftSummonTimes(self.model.curPoolId)
    if targetPoolNotSelect or noLeftSummonTimes then
      binder:SetTextColorType(self.ui.Text_Awaker_Ten, CommonDefine.ColorType.Dark)
      return CommonDefine.BtnType.Unclickable
    end
    binder:SetTextColorType(self.ui.Text_Awaker_Ten, CommonDefine.ColorType.Light)
    if SummonCfgUtils.IsCashDirectPurchasePool(self.model.curPoolId) and self:_HasCashPoolEnoughItem(self.model.curPoolId) then
      return CommonDefine.BtnType.Normal
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Summon_DrawTenTimes_Btn"
  end, function()
    do return RedPointDataUtils.IsShowPoolCurrencyEnough end
    return RedPointDataUtils.IsShowPoolCurrencyEnough, self.model.curPoolId
  end)
  binder:BindZ1Button(self.ui.Btn_Awaker_Daily, function()
    self:OnClickDailySummon()
  end, function()
    local curPoolCfg = self.model.poolCfg
    if not curPoolCfg or self.model:CheckTargetedPoolNotSelect() then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Summon_DrawOnce_Btn"
  end)
  binder:BindZ1Button(self.ui.Btn_Choose, function()
    UIManager.Instance:Reopen(Urls.SummonUpAwakerWeaponPanel, self.model.curPoolId)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "SummonSelectAwakeBtnTips"
  end, function()
    do return RedPointDataUtils.IsShowPoolCurrencyEnough end
    return RedPointDataUtils.IsShowPoolCurrencyEnough, self.model.curPoolId
  end)
  binder:BindZ1Button(self.ui.Btn_Realms, function()
    if self:_IsNormalAwakerPool() then
      SummonDataUtils.OpenCareerSelectPanel(self.model)
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.DrawCardChooseCareer, RedPointDataUtils.RedAttrType.Red)
    elseif self:_IsNormalWeaponPool() then
      local viewData = {
        tids = DropDataUtils.GetDropItemTids(DT.GetConstant("SelectSSRWeaponDropList")),
        confirmFunc = System.fn(self, self.ChangeSelectWeapon),
        selectTid = self.model.chooseItemTid
      }
      PublicUIController.Instance:OnOpenSelectItemBaseView(viewData)
    end
  end)
  binder:BindZ1Button(self.ui.Btn_Trial, function()
    local isLimitAwaker = table.contains({
      cd.SummonPoolType.LimitAwaker,
      cd.SummonPoolType.TargetedAwakerWeapon
    }, self.model.poolCfg.Type)
    local trialType = isLimitAwaker and cd.TrialType.Limit or cd.TrialType.Normal
    UIManager.Instance:Reopen(Urls.TaskMainView, CommonDefine.TaskPage.AwakerTrial, function()
      UIManager.Instance:Reopen(Urls.MainPanel)
      local panel = UIManager.Instance:GetWindow(Urls.FreeTrialView)
      local awakerTid = self:GetChooseUpTrialAwakerTid()
      panel:SetDefaultStageId(trialType, nil, awakerTid)
    end)
  end)
  binder:SetText(self.ui.Text_Trial, LT.Text("SummonTrial"))
end

function SummonPanel:ChangeSelectWeapon(tid)
  SummonDataUtils.ReqChooseUpSSR(SummonPoolType.NormalWeapon, tid)
end

function SummonPanel:TimerTick()
  local poolData = SummonDataUtils.GetPoolData(self.model.curPoolId)
  if nil == poolData then
    self:_ResetPoolSelect()
    return
  end
  if nil ~= poolData and nil ~= poolData.endTime then
    local timeStr = ""
    if poolData and poolData.endTime then
      local leftTime = poolData.endTime - TimeUtils.GetServerTime()
      if leftTime > 0 then
        local d, h, m = math.floor(leftTime / 3600 / 24), math.floor(leftTime / 3600 % 24), math.floor(leftTime % 3600 / 60)
        timeStr = LT.Textf("剩余时间：\n%s", string.format("%02d天%02d时%02d分", d, h, m))
      end
    end
    self.model:SetLeftTimeText(timeStr)
  end
  if nil ~= poolData.summonTimes and poolData.summonTimes > 0 then
    self.model:SetLeftTimeText(LT.Textf("Summon_Times_Left", poolData.summonTimes))
  end
  self:OnRefreshRemainingTimes(self.binder)
  self:_TryAutoSummonForChargedPool()
end

function SummonPanel:_TryAutoSummonForChargedPool()
  local curPoolId = self.model.curPoolId
  if not SummonCfgUtils.IsCashDirectPurchasePool(curPoolId) then
    return
  end
  if not self.model:HasChargedPool(curPoolId) then
    return
  end
  if not SummonDataUtils.IsLeftSummonTimes(curPoolId) then
    return
  end
  local result = SummonDataUtils.TryAutoSummonByItemCount(curPoolId)
  if result then
    self.model:SetChargedPool(curPoolId, nil)
  end
end

function SummonPanel:Close()
  self.closeWithoutAnim = true
  self.closeBtn:PlayCloseAnim()
  if self._poolGroupItem and not IsNil(self._poolGroupItem.ui.uiNode) then
    self._poolGroupItem.ui.uiNode:SetActive(false)
  end
  UIManager.Instance:ReShowBehindPanel(self)
  
  function self.PlayWorkingAnim()
  end
  
  self.uiAnimController:ClearCompleteCb()
  self.uiAnimController:StopPlayableGraph()
  self:_DisableAllCanvasGroupInteractable()
  self.uiAnimController:PlayState("UI_Summon_Panel_Main_End", function()
    self:_ResumeAllCanvasGroupInteractable()
    Super.Close(self)
  end)
end

function SummonPanel:RefreshShow(binder, poolCfg)
  binder:SetActive(self.ui.Image_Line_Role1, poolCfg.Type ~= SummonPoolType.LimitWeapon)
  binder:SetActive(self.ui.Image_Line_Cards_1, poolCfg.Type == SummonPoolType.LimitWeapon)
  binder:SetActive(self.ui.Image_Line_Cards_2, poolCfg.Type == SummonPoolType.LimitWeapon)
  binder:SetImage(self.ui.Image_D_Bg, poolCfg.Image)
  binder:SetText(self.ui.Text_Bg_Label, poolCfg.Name)
  binder:SetText(self.ui.Text_Bg_Name, poolCfg.Title)
  self:AjustTextCompSize(binder, poolCfg)
  self:_BindFirstResummon(binder, poolCfg)
  self:_BindTenBtnDesc(binder, poolCfg)
  self:_RefreshPoolDescText(binder, poolCfg)
  binder:SetActive(self.ui.Group_School_Intro, poolCfg.ShowSchool ~= nil)
  binder:SetText(self.ui.Text_Recommend, LT.Text(poolCfg.Name))
  local poolBgImage = SummonDataUtils.GetBgImage(poolCfg.ID)
  binder:SetImageSync(self.ui.bg, poolBgImage)
  binder:SetImageSync(self.ui.Basemap, poolCfg.BaseMap)
end

function SummonPanel:DifficultShow(binder, poolSchool)
  if poolSchool then
    local schoolConfig = DT.SchoolConfig[poolSchool]
    if schoolConfig then
      binder:SetImage(self.ui.Image_School_Icon, schoolConfig.Icon)
      binder:SetText(self.ui.Text_School_Intro, LT.Text(schoolConfig.SchoolFeature))
      local difficulty = schoolConfig.Difficulty or 0
      local starStr = "★"
      local showStarStr = ""
      for _ = 1, difficulty do
        showStarStr = showStarStr .. starStr
      end
      binder:SetText(self.ui.Text_Difficult, showStarStr)
    end
  end
end

function SummonPanel:BeginPoolShow(_, poolCfg, poolData)
  if poolCfg.Type ~= SummonPoolType.Begin then
    if poolData.summonTimes ~= nil and poolData.summonTimes > 0 then
      self.model:SetLeftTimeText(LT.Textf("Summon_Times_Left", poolData.summonTimes))
    elseif nil ~= poolData.endTime then
      local leftTime = 0
      if poolCfg.Type ~= SummonPoolType.NormalWeapon then
        local endTime = poolData.endTime
        leftTime = endTime - TimeUtils.GetServerTime()
      end
      if leftTime > 0 then
        local d, h, m = math.floor(leftTime / 3600 / 24), math.floor(leftTime / 3600 % 24), math.floor(leftTime % 3600 / 60)
        self.model:SetLeftTimeText(LT.Textf("SummonCountdown", string.format("%02d天%02d时%02d分", d, h, m)))
      else
        self.model:SetLeftTimeText("")
      end
    else
      self.model:SetLeftTimeText("")
    end
  else
    self.model:SetLeftTimeText("")
  end
  SummonPanel_WishAwaker.BeginPoolShow(self, _, poolCfg, poolData)
  SummonPanel_CategorySelect.BeginPoolShow(self, _, poolCfg, poolData)
end

function SummonPanel.RemovePoolRedData(poolId)
  if SummonDataUtils.CheckDiscountSummon(poolId) then
    local redType = SummonDataUtils.GetRedTypeByPoolId(poolId)
    RedPointDataUtils.ReqRemoveData(redType, RedPointDataUtils.RedAttrType.IsNew)
  end
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.SummonUpPoolRed, RedPointDataUtils.RedAttrType.IsNew, poolId)
  if poolId == DT.GetConstant("SchoolSummonInitShow") or table.contains(DT.Constant.SummonCareerSelectList.Data, poolId) then
    for _, val in pairs(DT.Constant.SummonCareerSelectList.Data) do
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.SummonUpPoolRed, RedPointDataUtils.RedAttrType.IsNew, val)
    end
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.SummonUpPoolRed, RedPointDataUtils.RedAttrType.IsNew, DT.GetConstant("SchoolSummonInitShow"))
  end
end

function SummonPanel:AjustTextCompSize(binder, poolCfg)
  local textWidth = self:_NeedShowAwakerWeaponGroup(poolCfg.Type) and 538.1 or 603.5609
  local textHeight = 242
  local isLuckyBag = SummonDataUtils.IsLuckyBagPool(poolCfg.ID)
  if isLuckyBag then
    textWidth = 505
  end
  if poolCfg.Type == CommonDefine.SummonPoolType.NewbiePool then
    textHeight = 161
  end
  self.ui.Text_Type.transform.sizeDelta = Vector2(textWidth, textHeight)
  binder:SetText(self.ui.Text_Type, self:_GetTextBgTypeStr(poolCfg))
  binder:SetActive(self.ui.Text_Type, true)
end

function SummonPanel:_GetPoolDescText(poolCfg)
  local desc1 = poolCfg.Desc
  local awakerTid = SummonDataUtils.GetChooseUpSSRAwakerTid(poolCfg.Type, poolCfg.ID)
  if poolCfg.Type == CommonDefine.SummonPoolType.ChooseUp then
    local shoolTid = AwakerCfgUtils.GetCfgField("School", awakerTid)
    local shoolColor = SummonUiUtils.GetSummonColorBySchool(shoolTid)
    desc1 = LT.Textf(desc1, shoolColor)
  end
  if SummonDataUtils.IsCategorySelectPool(poolCfg.ID) then
    do return SummonPanel_CategorySelect.GetCategorySelectDesc, self, poolCfg.ID end
    return SummonPanel_CategorySelect.GetCategorySelectDesc, self, poolCfg.ID, desc1, shoolColor
  end
  if SummonDataUtils.IsWishPool(poolCfg.ID) then
    do return SummonPanel_WishAwaker.GetWishAwakerDesc, self, poolCfg.ID end
    return SummonPanel_WishAwaker.GetWishAwakerDesc, self, poolCfg.ID, desc1, shoolColor
  end
  return desc1
end

function SummonPanel:_RefreshPoolDescText(binder, poolCfg)
  local desc1 = self:_GetPoolDescText(poolCfg)
  binder:SetText(self.ui.Text_Desc_1, desc1)
  if SummonDataUtils.IsCategorySelectPool(poolCfg.ID) then
    binder:SetActive(self.ui.Text_Desc_1, nil ~= desc1 and "" ~= desc1)
  end
end

function SummonPanel:_BindFirstResummon(binder, poolCfg)
  binder:SetText(self.ui.Text_FirstResummonTitle, LT.Text("SummonFirstTitle"))
  binder:BindToRaw(function(itemBinder, isFirstResummon)
    itemBinder:SetActive(self.ui.Tag_FistLimit, isFirstResummon)
    itemBinder:SetText(self.ui.Text_FirstResummon, isFirstResummon and LT.Text("SummonFirstDesc") or poolCfg.Desc)
    self:_RefreshPoolDescText(itemBinder, poolCfg)
    itemBinder:SetActive(self.ui.Text_Awaker_TenFirst, isFirstResummon)
    itemBinder:SetText(self.ui.Text_Awaker_TenFirst, ItemNumUtils.GetStr(CommonDefine.MultiSummonTimes))
    itemBinder:SetText(self.ui.Text_Awaker_TenFirstLine, "-")
    itemBinder:SetText(self.ui.Text_Awaker_TenFirst, ItemNumUtils.GetStr(CommonDefine.MultiSummonTimes))
  end, function()
    do return SummonDataUtils.IsFirstResummon end
    return SummonDataUtils.IsFirstResummon, poolCfg.ID
  end)
end

function SummonPanel:_BindTenBtnDesc(binder, poolCfg)
  binder:BindToRaw(function(itemBinder, poolData)
    local viewData = self:_GetTenBtnDescViewData(poolData)
    if not viewData then
      itemBinder:SetActive(self.ui.Text_TenBtn_Desc, false)
      return
    end
    itemBinder:SetActive(self.ui.Text_TenBtn_Desc, viewData.isActive)
    itemBinder:SetText(self.ui.Text_TenBtn_Desc, viewData.descText)
  end, function()
    return {
      poolCfgID = poolCfg.ID,
      poolType = poolCfg.Type,
      freeFiveTime = SummonDataUtils.IsSummonPoolHaveFree(poolCfg.ID)
    }
  end)
end

function SummonPanel:_GetTenBtnDescViewData(poolData)
  local poolTypeViewStrategy = {
    [CommonDefine.SummonPoolType.TripleLuckyBag] = {
      isActive = true,
      descText = LT.Text("TripleSummonReward")
    }
  }
  local strategy = poolTypeViewStrategy[poolData.poolType]
  if strategy then
    return strategy
  end
  local freeFiveTime = poolData.freeFiveTime
  return {
    isActive = freeFiveTime > 0,
    descText = LT.Textf("FiveFreePullsTips", freeFiveTime)
  }
end

function SummonPanel:_GetTextBgTypeVisible(poolCfg)
  local probabilityUpDesc = poolCfg.ProbabilityUpDesc
  return probabilityUpDesc or self.model.chooseItemTid
end

function SummonPanel:_GetTextBgTypeStr(poolCfg)
  local probabilityUpDesc = poolCfg.ProbabilityUpDesc
  local showText = ""
  if self:_IsChooseUpAwakerPool() then
    local awakerTid = SummonDataUtils.GetChooseUpSSRAwakerTid(poolCfg.Type, poolCfg.ID)
    if awakerTid then
      local awakerName = AwakerCfgUtils.GetCfgField("Name", awakerTid) or ""
      local awakerSchool = AwakerCfgUtils.GetCfgField("School", awakerTid) or ""
      local weaponTid = AwakerCfgUtils.GetFirstRecommendWeapon(awakerTid)
      local weaponName = ItemDataUtils.GetItemName(weaponTid) or ""
      local showColor = SummonUiUtils.GetSummonColorBySchool(awakerSchool)
      do return LT.Textf, probabilityUpDesc, showColor, LT.Text(awakerName), LT.Text(weaponName) end
      return LT.Textf, probabilityUpDesc, showColor, LT.Text(awakerName), LT.Text(weaponName)
    end
    do return LT.Text end
    return LT.Text, "GoldenWeekSummonDesc1", AwakerCfgUtils.GetFirstRecommendWeapon(awakerTid), "", SummonUiUtils.GetSummonColorBySchool(awakerSchool), LT.Textf, probabilityUpDesc, showColor, LT.Text(awakerName), LT.Text(weaponName)
  end
  if probabilityUpDesc then
    showText = LT.Text(probabilityUpDesc)
  end
  if poolCfg.PlaceholderDef then
    local showValGroup = self:_GetProbabilityUpFomatValGroup(poolCfg.PlaceholderDef, SummonDataUtils.GetPoolData(poolCfg.ID))
    showText = LT.Textf(probabilityUpDesc, table.unpack(showValGroup))
  end
  if self.model.chooseItemTid then
    showText = LT.Textf("SummonProbabilityUpDescFormat", LT.Text(ItemDataUtils.GetItemName(self.model.chooseItemTid)))
  end
  if SummonDataUtils.IsCategorySelectPool(self.model.curPoolId) then
    showText = SummonPanel_CategorySelect.GetTypeDesc(self, self.model.curPoolId, showText)
  elseif SummonDataUtils.IsWishPool(self.model.curPoolId) then
    showText = SummonPanel_WishAwaker.GetTypeDesc(self, self.model.curPoolId, showText)
  end
  return showText
end

function SummonPanel:_GetProbabilityUpFomatValGroup(placeholderDef, poolData)
  local rst = {}
  for _, type in pairs(placeholderDef) do
    if type == CommonDefine.ProbabilityUpDescFormatType.LeftTimes then
      table.insert(rst, poolData.leftSummonSSRNum)
    end
  end
  return rst
end

function SummonPanel:_ResetPoolSelect()
  local poolList = SummonDataUtils.GetSortedPoolList()
  if SummonDataUtils.GetSummonPoolNum(poolList) > 0 then
    local targetPoolTid = poolList[1].tid
    self.model:SetCurrPoolId(targetPoolTid)
    for _, showPoolData in pairs(self._showPoolList) do
      if table.contains(showPoolData.poolTidList, targetPoolTid) then
        self.model:SetPoolTidList(showPoolData.poolTidList)
      end
    end
  else
    self.model:SetCurrPoolId(0)
    self.model:SetPoolTidList({})
  end
end

function SummonPanel:BindWeaponPreview(binder)
  binder:BindToRaw(function(cBinder)
    local poolCfg = self.model.poolCfg
    if not table.next(poolCfg) then
      return
    end
    local poolShowItemTids = poolCfg.DetailItem or {}
    if self.model.chooseItemTid then
      poolShowItemTids = {
        self.model.chooseItemTid
      }
    end
    local isContainsWeapon = ItemDataUtils.CheckItemTidsContainType(poolShowItemTids, CommonDefine.ItemType.Weapon)
    local isShowSingleWeapon = isContainsWeapon and table.next(poolShowItemTids) and 1 == #poolShowItemTids
    local isShowMultiAwakerWeapon = poolCfg.Type == CommonDefine.SummonPoolType.MultiAwakerWeapon
    self.ui.bg:SetActive(poolCfg.BackgroundImage and not isShowSingleWeapon or isShowMultiAwakerWeapon)
    self.ui.bg:GetComponent(TypeImage).enabled = not isShowMultiAwakerWeapon
    self.ui.Image_Decorate:SetActive(false)
    self.ui.Image_Weapon_Large:SetActive(isShowSingleWeapon)
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
          cBinder:SetImageSync(self.ui.Image_Decorate, summonWeaponFrame)
          self.ui.Image_Decorate:SetActive(true)
        end
      end
      local weaponSpIcon = showWeaponCfg.SpIcon
      if weaponSpIcon then
        cBinder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon_Large, weaponSpIcon, 0.7, function(weaponGO)
          if self.ui and self.ui.Image_Quality then
            local imageQualityCopy = CS.UnityEngine.GameObject.Instantiate(self.ui.Image_Quality, self.ui.Image_Quality.transform.position, self.ui.Image_Quality.transform.rotation, weaponGO.transform)
            imageQualityCopy:SetActive(true)
            imageQualityCopy.transform.localScale = CS.UnityEngine.Vector3(1.47, 1.47, 1.47)
          end
        end))
      end
    end
  end, function()
    return {
      self.model.curPoolId,
      self.model.chooseItemTid
    }
  end)
end

function SummonPanel:PlayWorkingAnim()
  self.uiAnimController:PlayState("UI_Summon_Panel_Main_Working", nil)
end

function SummonPanel:_IsChooseUpAwakerPool()
  do return SummonDataUtils.CheckPoolType, self.model.curPoolId end
  return SummonDataUtils.CheckPoolType, self.model.curPoolId, CommonDefine.SummonPoolType.ChooseUp
end

function SummonPanel:_IsNormalAwakerPool(poolTid)
  poolTid = poolTid or self.model.curPoolId
  do return table.contains, (SummonDataUtils.GetSelectCareerList()) end
  return table.contains, SummonDataUtils.GetSelectCareerList(), poolTid
end

function SummonPanel:_IsNormalWeaponPool(poolTid)
  poolTid = poolTid or self.model.curPoolId
  do return SummonDataUtils.CheckPoolType, poolTid end
  return SummonDataUtils.CheckPoolType, poolTid, CommonDefine.SummonPoolType.NormalWeapon
end

function SummonPanel:_GetShowAwakerTid()
  if self.model.poolCfg.Type == CommonDefine.SummonPoolType.AwakerWeapon then
    do return SummonCfgUtils.GetShowAwakerTidByCorrectedAwardSSR end
    return SummonCfgUtils.GetShowAwakerTidByCorrectedAwardSSR, self.model.curPoolId, nil
  elseif self.model.poolCfg.Type == CommonDefine.SummonPoolType.TargetedAwakerWeapon then
    local showInfo = self:_GetPoolShowAwakerWeaponInfo()
    return showInfo and showInfo.awakerTid
  end
  do return SummonDataUtils.GetChooseUpSSRAwakerTid, self.model.poolCfg.Type end
  return SummonDataUtils.GetChooseUpSSRAwakerTid, self.model.poolCfg.Type, self.model.curPoolId
end

function SummonPanel:_GetShowWeaponTid(awakerTid)
  if self.model.poolCfg.Type == CommonDefine.SummonPoolType.AwakerWeapon then
    do return SummonCfgUtils.GetShowWeaponTidByCorrectedAwardSSR end
    return SummonCfgUtils.GetShowWeaponTidByCorrectedAwardSSR, self.model.curPoolId
  elseif self.model.poolCfg.Type == CommonDefine.SummonPoolType.TargetedAwakerWeapon then
    local showInfo = self:_GetPoolShowAwakerWeaponInfo()
    return showInfo and showInfo.weaponTid
  end
  do return AwakerCfgUtils.GetFirstRecommendWeapon end
  return AwakerCfgUtils.GetFirstRecommendWeapon, awakerTid
end

function SummonPanel:_GetPoolShowAwakerWeaponInfo()
  if self.model.poolCfg.Type == CommonDefine.SummonPoolType.TargetedAwakerWeapon then
    do return SummonCfgUtils.GetTargetedAwakerWeaponSummonShowInfo end
    return SummonCfgUtils.GetTargetedAwakerWeaponSummonShowInfo, self.model.curPoolId
  end
  return nil
end

function SummonPanel:_NeedShowAwakerWeaponGroup(poolType)
  poolType = poolType or self.model.poolCfg.Type
  local isChooseUpAwakerPool = self:_IsChooseUpAwakerPool() and SummonDataUtils.GetChooseUpSSRItemTid(self.model.poolCfg.Type, self.model.curPoolId)
  local isAwakerWeaponPool = poolType == CommonDefine.SummonPoolType.AwakerWeapon
  local isTargetedAwakerWeaponPool = poolType == CommonDefine.SummonPoolType.TargetedAwakerWeapon
  return isChooseUpAwakerPool or isAwakerWeaponPool or isTargetedAwakerWeaponPool
end

function SummonPanel:_OnPoolVXFx(fxGameObj)
  if IsNil(fxGameObj) then
    return
  end
  local uiAnimController = fxGameObj:GetComponent(typeof(UIAnimationController))
  if not uiAnimController then
    return
  end
  local clips = uiAnimController.animationInfoList
  if clips.Count >= 1 then
    uiAnimController:PlayState(clips[0].clip.name, function()
      if clips.Count >= 2 then
        uiAnimController:LoopPlayState(clips[1].clip.name, nil)
      end
    end)
  end
end

function SummonPanel:IsAwakerPool(poolTid)
  poolTid = poolTid or self.model.curPoolId
  local poolCfg = SummonDataUtils.GetSummonConfig(poolTid)
  local type = poolCfg and poolCfg.Type
  do return table.contains, {
    CommonDefine.SummonPoolType.LimitAwaker,
    CommonDefine.SummonPoolType.NormalAwaker,
    CommonDefine.SummonPoolType.TargetedAwakerWeapon
  } end
  return table.contains, {
    CommonDefine.SummonPoolType.LimitAwaker,
    CommonDefine.SummonPoolType.NormalAwaker,
    CommonDefine.SummonPoolType.TargetedAwakerWeapon
  }, type, CommonDefine.SummonPoolType.NormalAwaker, CommonDefine.SummonPoolType.TargetedAwakerWeapon
end

function SummonPanel:GetChooseUpTrialAwakerTid()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.model.curPoolId)
  local type = poolCfg and poolCfg.Type
  if type == CommonDefine.SummonPoolType.LimitAwaker then
    local itemTid = poolCfg.DetailItem and poolCfg.DetailItem[1]
    do return ItemDataUtils.GetAwakerTidByItemTid end
    return ItemDataUtils.GetAwakerTidByItemTid, itemTid
  end
  if type == CommonDefine.SummonPoolType.TargetedAwakerWeapon then
    local summonShowInfo = SummonCfgUtils.GetTargetedAwakerWeaponSummonShowInfo(self.model.curPoolId)
    return summonShowInfo and summonShowInfo.awakerTid
  end
end

function SummonPanel:_LuckyBagClosed(curPoolId)
  if SummonDataUtils.IsLuckyBagPool(curPoolId) then
    self.model:SetPoolTidList({})
  else
    self.model:SetPoolTidList(self._showPoolList[1].poolTidList)
  end
end

function SummonPanel:_OnLuckyBagSummon(binder, curPoolId)
  local poolCfg = SummonDataUtils.GetSummonConfig(curPoolId)
  self._showPoolList = SummonDataUtils.GetShowPoolList()
  local showLuckyBag = false
  for i = 1, #self._showPoolList do
    if self._showPoolList[i].poolGroupId and self._showPoolList[i].poolGroupId == poolCfg.PoolGroup and SummonDataUtils.CheckPoolListItemIsShow(self._showPoolList[i].poolTidList) then
      showLuckyBag = true
      break
    end
  end
  if not showLuckyBag then
    return
  end
  local poolTidList = self.model.poolTidList
  for i = 1, #poolTidList do
    local poolTid = poolTidList[i]
    local subKey = cd.ClientSubKey.TimeLimitedLuckyBagGroupFirstOpen_ .. poolTid
    if not SummonDataUtils.CheckPoolIsSummonOut(poolTid) then
      ClientDataUtils.SetData(cd.ClientDataMainKey.TimeLimitedLuckyBagGroupFirstOpen, subKey, 0)
      self.model:SetCurrPoolId(poolTid)
      self.model:SetPoolTidList(self.model.poolTidList or {})
      self:OnRefreshRemainingTimes(binder)
      break
    elseif ClientDataUtils.GetData(cd.ClientDataMainKey.TimeLimitedLuckyBagGroupFirstOpen, subKey, 1) then
      ClientDataUtils.SetData(cd.ClientDataMainKey.TimeLimitedLuckyBagGroupFirstOpen, subKey, 0)
    end
  end
end

function SummonPanel:_OnBindMultiAwakerWeaponComp(binder)
  binder:BindToRaw(function(itemBinder, poolTid)
    local poolType = SummonCfgUtils.GetCfgField("Type", poolTid)
    if poolType ~= CommonDefine.SummonPoolType.MultiAwakerWeapon then
      return
    end
    local viewData = {poolId = poolTid, showNum = 3}
    itemBinder:BindNewComponent(self.ui.bg, SummonMultiAwakerWeaponComp, SummonMultiAwakerWeaponComp.uiResCls, viewData)
  end, function()
    return self.model.curPoolId
  end)
end

function SummonPanel:IsPoolSpecial(poolTid)
  local SSRAwakerSpecialShowList = DT.Constant.SSRAwakerSpecialShow.Data or {}
  local isSpecial = false
  for _, specialTid in pairs(SSRAwakerSpecialShowList) do
    if specialTid == poolTid and DT.Summon[poolTid].Type == CommonDefine.SummonPoolType.ChooseUp then
      isSpecial = true
      break
    end
  end
  return isSpecial
end

function SummonPanel:_OnBindSpecialChooseUp(binder)
  binder:BindToRaw(function(itemBinder, poolTid)
    if not self:IsPoolSpecial(poolTid) or self:_NeedShowAwakerWeaponGroup() then
      return
    end
    itemBinder:BindNewComponent(self.ui.bg, SummonLuckyBag, SummonLuckyBag.uiResCls, poolTid)
  end, function()
    return self.model.curPoolId
  end)
end

function SummonPanel:_RefreshDailySummonBtn()
  local poolId = self.model and self.model.curPoolId
  if not poolId then
    return
  end
  local playerStatsType = SummonDataUtils.GetPlayerStatsTypeByPoolId(poolId)
  local dailySummonTimes = PlayerDataUtils.GetStatsDataByKeyType(CommonDefine.PlayerStatsKey.daily, playerStatsType)
  local haveDiscountCfg = SummonDataUtils.CheckDiscountSummon(poolId)
  local needSelectBeforeSummon = SummonDataUtils.NeedSelectBeforeSummon(poolId)
  local needShowDailySummonBtn = haveDiscountCfg and 0 == dailySummonTimes and not needSelectBeforeSummon
  self.binder:SetActive(self.ui.Btn_Awaker_Daily, needShowDailySummonBtn)
  self.binder:SetActive(self.ui.Image_Gradient, needShowDailySummonBtn)
  self.binder:SetActive(self.ui.Text_Additional, needShowDailySummonBtn)
  self.binder:SetActive(self.ui.Text_Additional_Str, needShowDailySummonBtn)
  self.binder:SetActive(self.ui.Image_Additional_Icon, needShowDailySummonBtn)
  if needShowDailySummonBtn then
    self.rebrushAnimController:PlayState("UI_Summon_Vx_Refurbish_01")
  end
end

function SummonPanel:_RefreshOnceSummonBtn()
  local poolCfg = SummonCfgUtils.GetCfg(self.model.curPoolId)
  if not poolCfg then
    return
  end
  if SummonCfgUtils.IsCashDirectPurchasePool(poolCfg.ID) then
    self.binder:SetActive(self.ui.Btn_Awaker_Once, false)
    return
  end
  local btnSummon1Visible = not table.contains(DT.GetOriginalConstant("OnceBtnHideSummonType"), poolCfg.Type)
  if self:_IsChooseUpAwakerPool() and not SummonDataUtils.GetChooseUpSSRItemTid(poolCfg.Type, poolCfg.ID) then
    btnSummon1Visible = false
  end
  local costItemInfo = SummonCfgUtils.GetPoolOneTimesConsumeItemInfo(poolCfg.ID)
  if not costItemInfo then
    btnSummon1Visible = false
  end
  if self:_IsChooseUpAwakerPool() and not SummonDataUtils.GetChooseUpSSRItemTid(poolCfg.Type, poolCfg.ID) then
    btnSummon1Visible = false
  end
  if SummonDataUtils.NeedSelectBeforeSummon(poolCfg.ID) then
    btnSummon1Visible = false
  end
  self.binder:SetActive(self.ui.Btn_Awaker_Once, btnSummon1Visible)
  self:_RefreshDailySummonBtn()
end

function SummonPanel:_OnOpenOtherFullScreenPanel()
  Super._OnOpenOtherFullScreenPanel(self)
  self.binder:SetActive(self.ui.UI_Summon_Vx_Refurbish_01, false)
end

function SummonPanel:SetRendered(isRendering)
  Super.SetRendered(self, isRendering)
  if isRendering then
    self.binder:SetActive(self.ui.UI_Summon_Vx_Refurbish_01, true)
  end
end

return SummonPanel
