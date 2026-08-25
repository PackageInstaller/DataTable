local cfgLuckyBagNoDropPreview = DT.GetOriginalConstant("LuckyBagNoDropPreview")
local SummonLuckyBag, Super = System.NewComponent("SummonLuckyBag")
SummonLuckyBag.uiResCls = UI_Summon_Panel_LuckyBagResource

function SummonLuckyBag:ctor(uiNode, poolId)
  Super.ctor(self)
  self.ui = SummonLuckyBag.uiResCls(uiNode)
  self.poolId = poolId
  self.poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  self.poolType = self.poolCfg.Type
  self._showAwakerIndex = 1
  self._showWeaponIndex = 1
end

function SummonLuckyBag:OnBind(binder)
  self.binder = binder
  self:BindTips()
  self:SplitAwakerAndWeapons()
  self:RefreshAwakerAndWeapon()
  self:SetExtraReward()
  self:BindGiftTask()
  self.binder:BindEvent(EventMgr.Instance.BeforeClosePanelEvent, System.fn(self, self.OnBeforeClosePanel))
end

function SummonLuckyBag:BindTips()
  self.binder:SetActive(self.ui.Group_Tip_1, SummonDataUtils.IsLuckyBagPool(self.poolId))
  self.binder:SetActive(self.ui.Group_Tip_2, SummonDataUtils.IsLuckyBagPool(self.poolId))
end

function SummonLuckyBag:SplitAwakerAndWeapons()
  local poolCfg = self.poolCfg
  local detailItems = poolCfg.DetailItem or {}
  local awakerTids = {}
  local weaponTids = {}
  local Type_Awaker = cd.ItemType.AwakerItem
  local Type_Weapon = cd.ItemType.Weapon
  if self.poolType == cd.SummonPoolType.ChooseUp then
    local SSRAwakerDIYSelectOneDropList = DT.Constant.SSRAwakerDIYSelectOneDrop.Data or {}
    local dropPool
    for i = 2, #SSRAwakerDIYSelectOneDropList, 2 do
      if SSRAwakerDIYSelectOneDropList[i] == self.poolId then
        dropPool = DT.Drop[SSRAwakerDIYSelectOneDropList[i - 1]].data_list
        break
      end
    end
    dropPool = dropPool or DT.Drop[DT.GetConstant("SSRAwakerSelectOneDrop")].data_list
    for _, dropData in ipairs(dropPool) do
      local itemCfg = ItemDataUtils.GetItemConfig(dropData.DropItem)
      local itemSpTid = itemCfg.SpParam and itemCfg.SpParam[1]
      if itemCfg.Type == Type_Awaker and itemSpTid then
        table.insert(awakerTids, itemSpTid)
        table.insert(weaponTids, DT.AwakerConfig[itemSpTid].RecommendWeapon[1])
      end
    end
  else
    for _, itemTid in ipairs(detailItems) do
      local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
      local itemSpTid = itemCfg.SpParam and itemCfg.SpParam[1]
      if itemCfg.Type == Type_Awaker and itemSpTid then
        table.insert(awakerTids, itemSpTid)
      elseif itemCfg.Type == Type_Weapon then
        table.insert(weaponTids, itemTid)
      end
    end
  end
  self.awakerTids = awakerTids
  self.weaponTids = weaponTids
end

function SummonLuckyBag:SetExtraReward()
  local TenTimesBonus = self.poolCfg.TenTimesBonus
  local bonusItemId, bonusItemNum = TenTimesBonus and TenTimesBonus[1], TenTimesBonus and TenTimesBonus[2]
  if bonusItemId and bonusItemNum then
    self.binder:SetActive(self.ui.Group_Extra, true)
    UIAdditionalRewardUtils.BindAdditionalReward(self.binder, self.ui.Text_Additional, self.ui.Image_Additional_Icon, bonusItemId, bonusItemNum)
    self.binder:SetText(self.ui.Text_Additional_Str, LT.Text("ExtraGift"))
  else
    self.binder:SetActive(self.ui.Group_Extra, false)
  end
end

function SummonLuckyBag:BindGiftTask()
  local poolCfg = SummonDataUtils.GetSummonConfig(self.poolId)
  local taskTid = poolCfg and poolCfg.SummonTask
  if type(taskTid) == "table" then
    taskTid = taskTid[1]
  end
  taskTid = tonumber(taskTid)
  if not taskTid then
    self.ui.UI_Summon_GiftTask:SetActive(false)
    return
  end
  self.ui.UI_Summon_GiftTask:SetActive(true)
  self.binder:BindComponent(SummonGiftTask(self.ui.UI_Summon_GiftTask, taskTid, System.fn(self, self.ReqTaskReward)))
end

function SummonLuckyBag:ReqTaskReward(taskTid)
  SummonDataUtils.ReqTaskReward(taskTid)
end

function SummonLuckyBag:RefreshAwakerAndWeapon()
  local showIndex
  if self.poolType == cd.SummonPoolType.ChooseUp then
    showIndex = math.random(1, #self.awakerTids)
    while self._showAwakerWeaponIndex == showIndex do
      showIndex = math.random(1, #self.awakerTids)
    end
    self._showAwakerWeaponIndex = showIndex
  end
  self:RefreshAwaker(showIndex)
  self:RefreshWeapon(showIndex)
  self.binder:BindTimer(6, 0, nil, System.fn(self, self.RefreshAwakerAndWeapon))
end

function SummonLuckyBag:RefreshAwaker(showIndex)
  if table.contains(cfgLuckyBagNoDropPreview, self.poolId) then
    self.binder:SetActive(self.ui.Group_LuckyBag_Awaker, false)
    return
  end
  self.binder:SetActive(self.ui.Group_LuckyBag_Awaker, true)
  local delay = not self._isChangedWeapon and 0 or 0.3
  self.binder:BindTimer(delay, 0, nil, function()
    local awakerTid = self:GetNextAwaker(showIndex)
    assert(awakerTid, "福袋卡池的DetailItem没有找到唤醒体:" .. self.poolCfg.CnID)
    self.binder:SetImage(self.ui.Image_LuckyBag_AwakerCareer, AwakerDataUtils.GetAwakerSchoolIcon(awakerTid))
    if not self._awakerPortraitComp then
      local portraitAlign = CommonDefine.PortraitAlign.Center
      self._awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.AwakerCon, awakerTid, nil, nil, portraitAlign))
    else
      self._awakerPortraitComp:ChangeAwakerTid(awakerTid)
    end
    if self.ui.UI_Summon_Btn_Jump_Awaker then
      if not self._awakerJumpUI then
        self._awakerJumpUI = UI_Summon_Btn_JumpResource(self.ui.UI_Summon_Btn_Jump_Awaker)
      end
      SummonUiUtils.RefreshAwakerJumpButtonInfo(self.binder, self._awakerJumpUI, false, awakerTid)
    end
    self.binder:BindButtonClick(self.ui.Btn_Awaker, System.fn(self, self._OnClickAwaker))
  end)
  if not self._isChangedAwaker then
    self.ui.UI_Vx_Awaker:SetActive(false)
  else
    self.ui.UI_Vx_Awaker:SetActive(false)
    self.ui.UI_Vx_Awaker:SetActive(true)
  end
  self._isChangedAwaker = true
end

function SummonLuckyBag:RefreshWeapon(showIndex)
  if table.contains(cfgLuckyBagNoDropPreview, self.poolId) then
    self.binder:SetActive(self.ui.Group_LuckyBag_Weapon, false)
    return
  end
  self.binder:SetActive(self.ui.Group_LuckyBag_Weapon, true)
  local delay = not self._isChangedWeapon and 0 or 0.3
  self.binder:BindTimer(delay, 0, nil, function()
    local weaponTid = self:GetNextWeapon(showIndex)
    local weaponSpIcon = ItemDataUtils.GetSpIcon(weaponTid)
    if self._weaponPrefab then
      self._weaponPrefab.binder:teardown()
    end
    self._weaponPrefab = self.binder:BindComponent(AwakerWeaponPrefab(self.ui.WeaponCon, weaponSpIcon, 1))
    if self.ui.UI_Summon_Btn_Jump_Weapon then
      if not self._weaponJumpUI then
        self._weaponJumpUI = UI_Summon_Btn_JumpResource(self.ui.UI_Summon_Btn_Jump_Weapon)
      end
      SummonUiUtils.RefreshWeaponJumpButtonInfo(self.binder, self._weaponJumpUI, false, weaponTid)
    end
    self.binder:BindButtonClick(self.ui.Btn_Weapon, System.fn(self, self._OnClickWeapon))
  end)
  if not self._isChangedWeapon then
    self.ui.UI_Vx_Weapon:SetActive(false)
  else
    self.ui.UI_Vx_Weapon:SetActive(false)
    self.ui.UI_Vx_Weapon:SetActive(true)
  end
  self._isChangedWeapon = true
end

function SummonLuckyBag:GetNextAwaker(showIndex)
  if not showIndex then
    showIndex = math.random(1, #self.awakerTids)
    while self._showAwakerIndex == showIndex do
      showIndex = math.random(1, #self.awakerTids)
    end
  end
  self._showAwakerIndex = showIndex
  return self.awakerTids[showIndex]
end

function SummonLuckyBag:GetNextWeapon(showIndex)
  if not showIndex then
    showIndex = math.random(1, #self.weaponTids)
    while self._showWeaponIndex == showIndex do
      showIndex = math.random(1, #self.weaponTids)
    end
  end
  self._showWeaponIndex = showIndex
  return self.weaponTids[showIndex]
end

function SummonLuckyBag:_OnClickAwaker()
  local awakerTid = self.awakerTids[self._showAwakerIndex]
  if not awakerTid then
    return
  end
  
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(awakerTid)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function SummonLuckyBag:_OnClickWeapon()
  local weaponTid = self.weaponTids[self._showWeaponIndex]
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Weapon, nil, weaponTid)
end

function SummonLuckyBag:OnBeforeClosePanel(url)
  if Urls.SummonPanel == url then
    self.binder:SetActive(self.ui.uiNode, false)
  end
end

return SummonLuckyBag
