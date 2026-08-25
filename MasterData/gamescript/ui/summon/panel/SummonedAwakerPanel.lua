local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonedAwakerPanel, Super = System.NewClass("SummonedAwakerPanel", UIBasePanel)
SummonedAwakerPanel.uiResCls = UI_Summon_Popup_Total_ShowResource

function SummonedAwakerPanel:ctor(result, poolId, summonModel)
  Super.ctor(self)
  self.result = result
  self.poolId = poolId
  self.summonModel = summonModel
  UIManager.Instance:CloseByUrl(Urls.SummonResultPanel)
  CameraManager:SetUICameraModel(true)
end

function SummonedAwakerPanel:OnBind(binder)
  self.binder = binder
  local soundID = CommonDefine.SummonSoundID.ShowResult
  if soundID then
    AudioManager.Instance:PostSoundEvent(soundID)
  end
  local showSSRBg = self.result.highestQuality == CommonDefine.CommonQuality.Orange
  binder:BindToVisible(self.ui.Image_Enter, function()
    return showSSRBg
  end)
  binder:BindToVisible(self.ui.Image_Ordinary, function()
    return not showSSRBg
  end)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    SummonUiUtils.isQuickSummon = false
    self:Close()
  end))
  local firstGainMap = {}
  for index, item in ipairs(self.result.itemList) do
    item._orignIndex = index
    if item.firstGain then
      firstGainMap[item.tid] = item.firstGain
    end
  end
  table.sort(self.result.itemList, function(a, b)
    local aCfg = DT.Item[a.tid]
    local bCfg = DT.Item[b.tid]
    local aWeight = CommonDefine.QualitySortValueTable[aCfg.Quality]
    local bWeight = CommonDefine.QualitySortValueTable[bCfg.Quality]
    if aWeight ~= bWeight then
      return aWeight > bWeight
    end
    if firstGainMap[a.tid] ~= firstGainMap[b.tid] then
      return firstGainMap[a.tid]
    end
    if aCfg.BaseSortID ~= bCfg.BaseSortID then
      return aCfg.BaseSortID < bCfg.BaseSortID
    end
    if ItemDataUtils.GetItemType(a.tid) == cd.ItemType.Weapon and ItemDataUtils.GetItemType(b.tid) == cd.ItemType.Weapon then
      local aRef, bRef = a.autoRefineInfo, b.autoRefineInfo
      if aRef and bRef then
        local al, bl = aRef.targetLevel or 0, bRef.targetLevel or 0
        if al ~= bl then
          return al < bl
        end
      elseif aRef or bRef then
        return not aRef
      end
    end
    return a._orignIndex < b._orignIndex
  end)
  do
    local seenWeaponTid = {}
    for _, summonResultItem in ipairs(self.result.itemList) do
      if ItemDataUtils.GetItemType(summonResultItem.tid) == cd.ItemType.Weapon then
        local tid = summonResultItem.tid
        if seenWeaponTid[tid] then
          summonResultItem.displayAutoRefineInfo = summonResultItem.autoRefineInfo or {targetLevel = 1}
        else
          seenWeaponTid[tid] = true
          summonResultItem.displayAutoRefineInfo = nil
        end
      end
    end
  end
  do
    local seenAwakerTid = {}
    for _, summonResultItem in ipairs(self.result.itemList) do
      local cfg = DT.Item[summonResultItem.tid]
      if cfg and (cfg.Type == cd.ItemType.AwakerItem or cfg.Type == CommonDefine.ItemType.Awaker) then
        local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(summonResultItem.tid) or summonResultItem.tid
        if seenAwakerTid[awakerTid] then
          summonResultItem.displayAwakerClip = true
        else
          seenAwakerTid[awakerTid] = true
          summonResultItem.displayAwakerClip = nil
        end
      end
    end
  end
  local itemList = {
    binder:BindComponent(SummonedAwakerItem(self.ui.UI_Summon_Item_Total_Show01, self.result.itemList[1], self.result.awakerFragmentCount_2)),
    binder:BindComponent(SummonedAwakerItem(self.ui.UI_Summon_Item_Total_Show02, self.result.itemList[2], self.result.awakerFragmentCount_2)),
    binder:BindComponent(SummonedAwakerItem(self.ui.UI_Summon_Item_Total_Show03, self.result.itemList[3], self.result.awakerFragmentCount_2)),
    binder:BindComponent(SummonedAwakerItem(self.ui.UI_Summon_Item_Total_Show04, self.result.itemList[4], self.result.awakerFragmentCount_2)),
    binder:BindComponent(SummonedAwakerItem(self.ui.UI_Summon_Item_Total_Show05, self.result.itemList[5], self.result.awakerFragmentCount_2))
  }
  self.itemList = itemList
  local fxDelayTime = CommonDefine.SummonFXTime.QualityFXAppearTime
  local fxTimeSpan = CommonDefine.SummonFXTime.QualityFXTimeSpan
  for _, item in ipairs(itemList) do
    if item:NeedShowFX() then
      item:ShowFX(fxDelayTime)
      fxDelayTime = fxDelayTime + fxTimeSpan
    end
  end
  local clipDelayTime = fxDelayTime
  if clipDelayTime > CommonDefine.SummonFXTime.QualityFXAppearTime then
    clipDelayTime = clipDelayTime - fxTimeSpan
  else
    clipDelayTime = clipDelayTime - CommonDefine.SummonFXTime.QualityFXAppearTime
  end
  clipDelayTime = clipDelayTime + CommonDefine.SummonFXTime.AwakerClipAppearTime
  local clipTimeSpan = CommonDefine.SummonFXTime.AwakerClipTimeSpan
  for _, item in ipairs(itemList) do
    if item:NeedShowClip() then
      item:ShowClip(clipDelayTime)
      clipDelayTime = clipDelayTime + clipTimeSpan
    end
  end
  local animName
  if self.result.highestQuality == CommonDefine.CommonQuality.Purple then
    animName = "UI_Summon_Popup_Total_Show_SR_Open"
  elseif self.result.highestQuality == CommonDefine.CommonQuality.Orange then
    animName = "UI_Summon_Popup_Total_Show_SSR_Open"
  end
  if animName then
    local animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
    local callback = System.fn(self, self.AniCallBack)
    animController:PlayMultiState(animName, callback, 1, false)
  end
  self:_CreateShareBtnCom()
  local coinList = DT.Constant.SummonPanelCurrencies.Data
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, coinList))
  self:BindSummonAgain(binder)
  self:BindExtrraItemInfo(binder)
end

function SummonedAwakerPanel:BindExtrraItemInfo(binder)
  local itemList = self.result.itemList
  if not itemList then
    binder:SetActive(self.ui.Item_Side_Tip_1, false)
    return
  end
  local extraItemInfoList = {}
  local extraItemTidInfoMap = {}
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  if poolCfg.TenTimesBonus and poolCfg.TenTimesBonus[1] then
    extraItemTidInfoMap[poolCfg.TenTimesBonus[1]] = {
      itemTid = poolCfg.TenTimesBonus[1],
      count = 0
    }
    table.insert(extraItemInfoList, extraItemTidInfoMap[poolCfg.TenTimesBonus[1]])
  end
  extraItemTidInfoMap[cd.CurrencyType.SummonGiftMoney] = {
    itemTid = cd.CurrencyType.SummonGiftMoney,
    count = 0
  }
  table.insert(extraItemInfoList, extraItemTidInfoMap[cd.CurrencyType.SummonGiftMoney])
  for _, itemData in ipairs(itemList) do
    local extraItems = itemData.extraItems
    if extraItems and table.next(extraItems) then
      for _, extra in ipairs(extraItems) do
        if extra.changedNum and extraItemTidInfoMap[extra.tid] then
          local extraItemInfo = extraItemTidInfoMap[extra.tid]
          extraItemInfo.count = extraItemInfo.count + extra.changedNum
        end
      end
    end
  end
  local zeroCount = 0
  for i, extraItemInfo in ipairs(extraItemInfoList) do
    if extraItemInfo.count > 0 then
      local gameObj = self.ui["Item_Side_Tip_Extra" .. i - zeroCount]
      gameObj:SetActive(true)
      local extraItemComp = binder:BindComponent(SummonResultExtraItemInfo(gameObj))
      local itemCfg = DT.Item[extraItemInfo.itemTid]
      extraItemComp:DisplayItem(itemCfg, extraItemInfo.count, "Summon")
    else
      local gameObj = self.ui["Item_Side_Tip_Extra" .. i]
      gameObj:SetActive(false)
      zeroCount = zeroCount + 1
    end
  end
  local totalGameObjCount = 2
  for index = #extraItemInfoList + 1, totalGameObjCount do
    local gameObj = self.ui["Item_Side_Tip_Extra" .. index]
    gameObj:SetActive(false)
  end
end

function SummonedAwakerPanel:BindAutoComposeItemInfo(binder)
  local allItems = self.result.itemList
  local autoComposeItems = {}
  for _, itemData in ipairs(allItems) do
    for _, extraItem in pairs(itemData.extraItems) do
      if extraItem.reason == "AutoDecompose" and extraItem.tid ~= cd.CurrencyType.JuniorMoney then
        local cur = autoComposeItems[extraItem.tid]
        if cur then
          cur.changedNum = cur.changedNum + (extraItem.changedNum or 0)
        else
          autoComposeItems[extraItem.tid] = table.clone(extraItem)
        end
      end
    end
  end
  self.binder:SetActive(self.ui.Group_SSRAutoDecompose, table.next(autoComposeItems))
  self.binder:SetActive(self.ui.Item_Side_Tip_AutoDecompose_1, false)
  self.binder:SetActive(self.ui.Item_Side_Tip_AutoDecompose_2, false)
  local index = 1
  for tid, itemInfo in pairs(autoComposeItems) do
    local gameObj = self.ui["Item_Side_Tip_AutoDecompose_" .. index]
    if gameObj then
      self.binder:SetActive(gameObj, true)
      self.binder:BindComponent(SummonPopTipItem(gameObj, tid, itemInfo.changedNum))
    end
    index = index + 1
  end
end

function SummonedAwakerPanel:BindSummonAgain(binder)
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  if poolCfg.Type == cd.SummonPoolType.NewbiePool then
    self:BindFirstResummon()
  else
    self:BindNormalSummonAgain()
  end
end

function SummonedAwakerPanel:BindFirstResummon()
  self.binder:SetActive(self.ui.Btn_Awaker_Ten, false)
  self.binder:SetActive(self.ui.Text_Multi_Tips, false)
  self.binder:BindToRaw(function(_, isFirstResummon)
    self.binder:SetActive(self.ui.Btn_Again, isFirstResummon)
    if not isFirstResummon then
      self.binder:SetActive(self.ui.UI_Common_Btn_Back3, true)
      self:PlayUIExportAnimation(self.ui.UI_Common_Btn_Back3, true, nil, true)
    else
      self.binder:SetActive(self.ui.UI_Common_Btn_Back3, false)
    end
    self.binder:SetActive(self.ui.Btn_Confirm, isFirstResummon)
  end, function()
    do return SummonDataUtils.IsFirstResummon end
    return SummonDataUtils.IsFirstResummon, self.poolId
  end)
  self.binder:BindZ1Button(self.ui.Btn_Again, function()
    if self.summonModel then
      self.summonModel:ReqMultiSummon(CommonDefine.MultiSummonTimes, function()
        self:Close()
      end)
    end
  end)
  self.binder:BindZ1Button(self.ui.Btn_Confirm, function()
    Alert.Show(300002, nil, function()
      SummonDataUtils.ReqConfirmSummonResult(self.poolId, function(data)
      end)
      ClientDataUtils.SetData(cd.ClientDataMainKey.Client, cd.ClientSubKey.FirstResummon, 1)
      self:CheckShowShare()
    end)
  end)
end

function SummonedAwakerPanel:BindNormalSummonAgain()
  self.binder:SetActive(self.ui.Btn_Again, false)
  self.binder:SetActive(self.ui.UI_Common_Btn_Back3, true)
  self.binder:SetActive(self.ui.Btn_Confirm, false)
  self.binder:BindToVisible(self.ui.Btn_Awaker_Ten, function()
    local visible = SummonDataUtils.IsLeftSummonTimes(self.poolId)
    if visible then
      self.binder:SetButtonInteractable(self.ui.Btn_Awaker_Ten, false)
      local SHOW_RESUMMON_BTN_TIME = DT.GetConstant("SummonCD")
      self.binder:BindTimer(SHOW_RESUMMON_BTN_TIME, 0, nil, function()
        self.binder:SetButtonInteractable(self.ui.Btn_Awaker_Ten, true)
      end)
    end
    return visible
  end)
  self.binder:SetActive(self.ui.Text_Multi_Tips, true)
  self.binder:BindZ1Button(self.ui.Btn_Awaker_Ten, function()
    if not SummonDataUtils.GetPoolData(self.poolId) then
      return
    end
    local noLeftSummonTimes = not SummonDataUtils.IsLeftSummonTimes(self.poolId)
    if noLeftSummonTimes then
      return
    end
    if self.summonModel then
      self.summonModel:ReqMultiSummon(CommonDefine.MultiSummonTimes, function()
        self:Close()
      end, self.poolId)
    end
  end, function()
    local noLeftSummonTimes = not SummonDataUtils.IsLeftSummonTimes(self.poolId)
    if noLeftSummonTimes then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end)
  self.binder:BindToImage(self.ui.Image_Awaker_Icon_2, function()
    local costTid = SummonDataUtils.Get10TimesPrice(self.poolId)
    do return ItemDataUtils.GetSmallIcon end
    return ItemDataUtils.GetSmallIcon, costTid
  end)
  self.binder:BindToText(self.ui.Text_Awaker_Ten, function()
    local _, count = SummonDataUtils.Get10TimesPrice(self.poolId)
    do return ItemNumUtils.GetStr end
    return ItemNumUtils.GetStr, count or 5
  end)
  self.binder:BindToText(self.ui.Text_ReSummon, function()
    do return LT.Text end
    return LT.Text, "Summon_DrawTenTimes_Btn"
  end)
  self.binder:BindToText(self.ui.Text_Multi_Tips, function()
    local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
    local poolData = SummonDataUtils.GetPoolData(self.poolId)
    if poolCfg.Type == CommonDefine.SummonPoolType.OpenServerPool then
      do return LT.Textf, "Summon_Times_Left" end
      return LT.Textf, "Summon_Times_Left", poolData and poolData.summonTimes or 0
    end
    return ""
  end)
  self.binder:BindToRaw(function()
    self.binder:SetToggle(self.ui.Toggle_ReSummon, SummonUiUtils.isQuickSummon)
  end, function()
    return SummonUiUtils.isQuickSummon
  end)
  self.binder:BindToToggleValueChange(self.ui.Toggle_ReSummon, function(isOn)
    SummonUiUtils.isQuickSummon = isOn
  end)
end

function SummonedAwakerPanel:OnUnbind()
  CameraManager:SetUICameraModel(false)
end

function SummonedAwakerPanel:OnClickClose()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  if poolCfg.Type == CommonDefine.SummonPoolType.Begin then
    self:OnBeginPoolClose()
  else
    self:Close()
  end
end

function SummonedAwakerPanel:OnBeginPoolClose()
  local leftReSelectTimes = self.result.reSummonTimes or 0
  if leftReSelectTimes >= 0 then
    local function confirmResultFunc()
      SummonDataUtils.ReqConfirmSummonResult(self.poolId, function(data)
        DataCenter.summonData.deletePool = data.deletePool
        
        self:Close()
      end)
    end
    
    Alert.Show(20060, nil, confirmResultFunc, nil)
  end
end

function SummonedAwakerPanel:Close()
  self.closeBtn:PlayCloseAnim()
  Super.Close(self)
  AudioManager.Instance:PostSoundEvent("SET_STATE_A_INTERFACE_AWAKING")
  PopTipsManager.Instance:SetTutorialLock(false)
end

function SummonedAwakerPanel:AniCallBack()
  self:CheckShowShare()
  if SummonDataUtils.IsFirstResummon(self.poolId) then
    local guideAvgId = DT.GetConstant("ResummonFreeChancesAvg")
    AvgStoryManager.Instance:PlayStoryOnce(guideAvgId)
  end
end

function SummonedAwakerPanel:CheckShowShare()
  if self.shareCom then
    local bShow = not SummonDataUtils.IsFirstResummon(self.poolId)
    self.shareCom:SetVisible(bShow)
  end
end

function SummonedAwakerPanel:SetVisibleAboutShare(bShow)
  self.ui.UI_Common_Btn_Back3:SetActive(bShow)
  self.shareCom:SetVisible(bShow)
  for _, item in ipairs(self.itemList) do
    item:HideText_Label(bShow)
  end
end

function SummonedAwakerPanel:ShowSharePanel()
  self:SetVisibleAboutShare(false)
  
  local function afterCall()
    self:SetVisibleAboutShare(true)
  end
  
  local tid1, tid2 = self:_SelectShareSummonItems()
  if not tid1 then
    return
  end
  SdkMgr.Instance:GetShare():OpenShareSummonPanel(tid1, tid2, afterCall, self.poolId)
end

function SummonedAwakerPanel:_SelectShareSummonItems()
  local result = self.result
  if not (result and result.itemList) or 0 == #result.itemList then
    return nil, nil
  end
  local items = result.itemList
  local defaultTid1 = items[1] and items[1].tid or nil
  local defaultTid2 = items[2] and items[2].tid or nil
  local ssrQuality = CommonDefine.CommonQuality.Orange
  local ssrItems = {}
  for idx, item in ipairs(items) do
    local cfg = DT.Item[item.tid]
    if cfg and cfg.Quality == ssrQuality then
      item._shareIndex = idx
      table.insert(ssrItems, item)
    end
  end
  if 5 ~= #items or #ssrItems < 3 then
    return defaultTid1, defaultTid2
  end
  local weeklyRecRoleList = DT.GetOriginalConstant("WeeklyRecCommonRoleList")
  
  local function isRoleItem(cfg)
    return cfg.Type == cd.ItemType.AwakerItem or cfg.Type == CommonDefine.ItemType.Awaker
  end
  
  local function isWeaponItem(cfg)
    return cfg.Type == cd.ItemType.Weapon
  end
  
  local function isNonLimitedRole(roleTid)
    if not weeklyRecRoleList then
      return false
    end
    for _, v in ipairs(weeklyRecRoleList) do
      if v == roleTid then
        return true
      end
    end
    return false
  end
  
  local function isLimitedItem(itemData, cfg)
    if isRoleItem(cfg) then
      local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemData.tid)
      return not isNonLimitedRole(awakerTid)
    elseif isWeaponItem(cfg) then
      local recommendTid = cfg.RecommendedAwaker
      if not recommendTid then
        return true
      end
      return not isNonLimitedRole(recommendTid)
    end
    return true
  end
  
  local uniqueTidMap = {}
  local dedupList = {}
  for _, item in ipairs(ssrItems) do
    if not uniqueTidMap[item.tid] then
      uniqueTidMap[item.tid] = true
      table.insert(dedupList, item)
    end
  end
  local candidateList = ssrItems
  if #dedupList >= 2 then
    candidateList = dedupList
  end
  local scoredList = {}
  for _, item in ipairs(candidateList) do
    local cfg = DT.Item[item.tid]
    if cfg then
      local roleFlag = isRoleItem(cfg)
      local limitedFlag = isLimitedItem(item, cfg)
      table.insert(scoredList, {
        item = item,
        isLimited = limitedFlag,
        isRole = roleFlag,
        index = item._shareIndex or 0
      })
    end
  end
  if 0 == #scoredList then
    return defaultTid1, defaultTid2
  end
  table.sort(scoredList, function(a, b)
    if a.isLimited ~= b.isLimited then
      return a.isLimited and not b.isLimited
    end
    if a.isRole ~= b.isRole then
      return a.isRole and not b.isRole
    end
    return a.index < b.index
  end)
  local tid1 = scoredList[1] and scoredList[1].item.tid or defaultTid1
  local tid2 = scoredList[2] and scoredList[2].item.tid or defaultTid2
  return tid1, tid2
end

function SummonedAwakerPanel:_CreateShareBtnCom()
  if SteamSdk.Instance:IsSteam() or ApplicationUtils.IsWindowsOrEditor() then
    self.ui.Btn_Share:SetActive(false)
    return
  end
  local bShow = false
  local list = DT.GetOriginalConstant("ShareBtnStates")
  for _, summonItem in ipairs(self.result.itemList) do
    local itemCfg = DT.Item[summonItem.tid]
    for _, v in ipairs(list) do
      if v == itemCfg.Quality then
        bShow = true
        break
      end
    end
  end
  if bShow then
    self.shareCom = self.binder:BindComponent(ShareBtnCom(self.ui.Btn_Share, System.fn(self, self.ShowSharePanel), "Image_Bg"))
  else
    self.ui.Btn_Share:SetActive(false)
  end
end

return SummonedAwakerPanel
