local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local ActivityDrawPrizeResultView, Super = NewClass("ActivityDrawPrizeResultView", BaseView)
ActivityDrawPrizeResultView.uiResCls = UI_Event_Activity_RewardResultResource

function ActivityDrawPrizeResultView:ctor()
  Super.ctor(self)
  self.model = ActivityDrawPrizeModel.Instance
  self.rewardGoGroup = {}
  self.rewardEffectGroup = {}
  self.timerList = {}
end

function ActivityDrawPrizeResultView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OnActivityDrawPrizeLottery, System.fn(self, self.RefreshView))
end

function ActivityDrawPrizeResultView:_InitRewards()
  self.scrollView = self.ui.ScrollView_Reward:GetComponent(T_ScrollRect)
  self.ui.UI_Vx_Effect:SetActive(false)
  self.ui.UI_Vx_Effect:SetActive(true)
  for _, rewardGo in ipairs(self.rewardGoGroup) do
    rewardGo:SetActive(false)
  end
  local rewardCount = table.length(self.drawItems)
  if rewardCount <= 0 then
    return
  end
  local row = math.ceil(rewardCount / 5)
  local height = row * 144 + (row - 1) * 22
  local sizeDelta = self.ui.Content.transform.sizeDelta
  sizeDelta.y = height
  self.ui.Content.transform.sizeDelta = sizeDelta
  self.scrollView.verticalNormalizedPosition = 1
  local lastPageIdx = math.floor(rewardCount / 20) * 20 + 1
  for idx = 1, rewardCount do
    local rewardGo = self.rewardGoGroup[idx]
    if not rewardGo then
      rewardGo = GameObject.Instantiate(self.ui.UI_Common_Item_WuPin_Type2, self.ui.Content.transform)
      self.rewardGoGroup[idx] = rewardGo
      if rewardGo then
        local effect = {}
        effect.Orange = CS.Framework.GameObjectUtil.FindChildByPath(rewardGo, "UI_Vx_Item_Goldenglow")
        effect.Purple = CS.Framework.GameObjectUtil.FindChildByPath(rewardGo, "UI_Vx_Item_Purpleglow")
        effect.Blue = CS.Framework.GameObjectUtil.FindChildByPath(rewardGo, "UI_Vx_Item_Blueglow")
        effect.Green = CS.Framework.GameObjectUtil.FindChildByPath(rewardGo, "UI_Vx_Item_Greenglow")
        self.rewardEffectGroup[idx] = effect
      end
    end
    local rewardData = self.drawItems[idx]
    if rewardData then
      rewardGo:SetActive(true)
    end
    local rewardItem = CS.Framework.GameObjectUtil.FindChildByPath(rewardGo, "Group_Item")
    local rewardTypeCanvas = CS.Framework.GameObjectUtil.FindChildByPath(rewardGo, "Group_Typs"):GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    rewardTypeCanvas.alpha = 0
    rewardItem:SetActive(false)
    local tid = rewardData.tid or 0
    local num = rewardData.num or 0
    local uid = rewardData.uid or 0
    local itemType = ItemDataUtils.GetItemType(tid)
    local isWeaponReward = itemType == CommonDefine.ItemType.Weapon
    for key, effect in pairs(self.rewardEffectGroup[idx]) do
      effect:SetActive(false)
    end
    if isWeaponReward and (rewardData.reason == cd.ItemReason.AutoDecompose or rewardData.reason == cd.ItemReason.WeaponAutoRefine) then
      num = 1
    end
    local itemBagData = ItemDataUtils.GetItemByTid(tid)
    local weaponLevel
    if isWeaponReward then
      weaponLevel = itemBagData and itemBagData.level or 0
      uid = itemBagData and itemBagData.uid or uid
    end
    local lotteryRewardType = self.model:GetRewardItemRewardType(self.lotteryTid, tid, num)
    local isCoreReward = lotteryRewardType == CommonDefine.LotteryRewardType.Core
    local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
    local itemData = {
      itemTid = tid,
      itemCount = not isWeaponReward and num or 0,
      clickFunc = function()
        ItemDataUtils.ShowItemDetailTips(self.binder, rewardGo, uid, tid)
      end,
      weaponLevel = weaponLevel
    }
    if rewardData.reason == cd.ItemReason.AutoDecompose then
      itemData.extraDesc = LT.Text("WeaponRefined_04")
    elseif isCoreReward then
      itemData.extraDesc = itemAwardTypeDescMap[CommonDefine.ItemAwardType.CoreReward]
      itemData.extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue
    end
    if self.timerList[idx] then
      self:StopTimer(self.timerList[idx])
    end
    if rewardData then
      local audioEvent = "Play_Vfx_Activity_Unveil_Content_Nor"
      self.timerList[idx] = self:BindTimer(0.12 * idx, 0, nil, function()
        local quality = DT.Item[tid].Quality
        for key, effect in pairs(self.rewardEffectGroup[idx]) do
          effect:SetActive(key == quality)
        end
        rewardItem:SetActive(true)
        rewardTypeCanvas.alpha = 1
        if isCoreReward then
          audioEvent = "Play_Vfx_Activity_Unveil_Content_Adv"
        end
        AudioManager.Instance:PostSoundEvent(audioEvent)
        local pageFull = 0 == idx % 20
        local isLastPage = idx == lastPageIdx
        if pageFull then
          self.scrollView.verticalNormalizedPosition = 1 - idx / rewardCount
        end
        if isLastPage then
          self.scrollView.verticalNormalizedPosition = 0
        end
      end)
    end
    self:AddViewComponentOnce(rewardGo, CompPublicIconItemType2, itemData)
  end
end

function ActivityDrawPrizeResultView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Btn_Mask:SetActive(true)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self.model:Set_curPage(CommonDefine.LotteryPage.Pool)
  end)
  self:RefreshView()
end

function ActivityDrawPrizeResultView:RefreshView()
  self.lotteryTid = self.model.curSelectTab
  self.multiDrawNum = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("MultipleDraw", self.lotteryTid) or 0
  self.drawItems = self.model.drawRewards.items
  self:_InitRewards()
end

function ActivityDrawPrizeResultView:OnExitView()
  Super.OnExitView(self)
  for idx, timer in pairs(self.timerList) do
    if timer then
      self:StopTimer(timer)
    end
  end
end

return ActivityDrawPrizeResultView
