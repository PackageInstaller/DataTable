_class("UIBattlePassCN1RewardMain", UICustomWidget)
UIBattlePassCN1RewardMain = UIBattlePassCN1RewardMain

function UIBattlePassCN1RewardMain:OnShow(uiParams)
end

function UIBattlePassCN1RewardMain:OnHide()
end

function UIBattlePassCN1RewardMain:SetData(campaign, tipsCallback, uiView)
  self._campaign = campaign
  self._tipsCallback = tipsCallback
  self._uiOwner = uiView
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_LVReward(self._campaign)
  UIActivityBattlePassHelper.SetSpecialImgInfo(self._campaign, self, "imgRoot", "img")
  UIActivityBattlePassHelper.SetSkinBtnInfo(self._campaign, 1, self, "_skinBtnA", self._tipsCallback)
  UIActivityBattlePassHelper.SetSkinBtnInfo(self._campaign, 2, self, "_skinBtnB", self._tipsCallback)
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetRemainingTime()
  self:Refresh_ByParams({
    resetPos = false,
    expData = false,
    expUpgrade = false,
    anim_PlayIn = false,
    anim_ListItem = false
  })
  self:_OnScrollMove()
end

function UIBattlePassCN1RewardMain:Refresh_ByParams(params)
  if not self.view then
    return
  end
  params = params or {}
  if params.expData == true then
    self:_SetExpInfo(params.expUpgrade)
  end
  self:_SetBuyGfitBtn()
  self:_SetClaimAllBtn()
  self:_SetLeftReward()
  self:_SetDynamicList()
  if params.resetPos then
    local pos = self._component:GetShowLvOnEnter() - 1
    self._dynamicListHelper:MovePanelToItemIndex(pos, 0)
  end
  self:_SetRightReward(self._rightRewardIndex)
  self:_CheckPoint()
  if params.anim_PlayIn then
    self:_PlayAnimIn()
  end
end

function UIBattlePassCN1RewardMain:_SetRemainingTime()
  local endTime = self._componentInfo.m_close_time
  local obj = UIWidgetHelper.SpawnObject(self, "_timePool", "UIActivityCommonRemainingTime")
  obj:SetData(endTime, nil, nil)
  local tb = UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(self._campaign, self, "_Time")
  UIStyleHelper.FitStyle_Widget(tb.bg, obj, "bg")
  UIStyleHelper.FitStyle_Widget(tb.icon, obj, "icon")
  UIStyleHelper.FitStyle_Widget(tb.txtTime, obj, "txtDesc")
  UIStyleHelper.FitStyle_Widget(tb.txtTime, obj, "txtTime")
end

function UIBattlePassCN1RewardMain:_SetExpInfo(upgrade)
  local obj = UIWidgetHelper.SpawnObject(self, "expInfoPool", "UIBattlePassCN1ExpInfo")
  obj:SetData(1, self._campaign, upgrade, function()
    self:Refresh_ByParams({
      resetPos = false,
      expData = true,
      expUpgrade = true,
      anim_PlayIn = true,
      anim_ListItem = false
    })
  end)
end

function UIBattlePassCN1RewardMain:_SetLeftReward()
  local obj = UIWidgetHelper.SpawnObject(self, "_leftItemPool", "UIBattlePassCN1RewardCellFixed")
  obj:SetData(self._campaign, self._component)
end

function UIBattlePassCN1RewardMain:_SetRightReward(index)
  self._rightItemShow = index ~= nil
  self:GetGameObject("rightItem"):SetActive(self._rightItemShow)
  if not self._rightItemShow then
    return
  end
  self._rightRewardIndex = index
  local obj = UIWidgetHelper.SpawnObject(self, "_rightItemPool", "UIBattlePassCN1RewardCell")
  self:_SetCellData(obj, index, true)
end

function UIBattlePassCN1RewardMain:_SetBuyGfitBtn()
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(self._campaign)
  local state = componentInfo.m_buy_state
  local id = {
    [BuyGiftStateType.EBGST_INIT] = "str_activity_battlepass_tab_reward_buy_btn_1",
    [BuyGiftStateType.EBGST_ADVANCED] = "str_activity_battlepass_tab_reward_buy_btn_2",
    [BuyGiftStateType.EBGST_LUXURY] = "str_activity_battlepass_tab_reward_buy_btn_2"
  }
  local str = StringTable.Get(id[state])
  UIWidgetHelper.SetLocalizationText(self, "_txtBuyGift", str)
end

function UIBattlePassCN1RewardMain:_SetClaimAllBtn()
  local bShow = UIActivityBattlePassHelper.CheckComponentRedPoint(self._campaign, self._cmptId)
  self:GetGameObject("_claimAllBtn"):SetActive(bShow)
end

function UIBattlePassCN1RewardMain:_SetDynamicList()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIBattlePassCN1RewardCell", function(listItem, itemIndex)
      self:_SetCellData(listItem, itemIndex)
    end)
    local sr = self:GetUIComponent("ScrollRect", "_dynamicList")
    sr.onValueChanged:AddListener(function()
      self:_OnScrollMove()
    end)
  end
  local itemCount = self._componentInfo.m_max_level
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIBattlePassCN1RewardMain:_SetCellData(listItem, index, rightItem)
  listItem:SetData(index, self._campaign, self._component, function(lv, adv)
    self._component:Start_HandleReceiveLevelReward(lv, adv, function(res, rewards)
      self:_OnGetRewards(res, rewards, lv, adv)
    end)
  end, self._tipsCallback, rightItem)
end

function UIBattlePassCN1RewardMain:_OnScrollMove()
  local cells = self._dynamicListHelper:GetVisibleItem()
  Log.debug("UIBattlePassCN1RewardMain:_OnScrollMove() table.count(cells) = ", table.count(cells))
  if table.count(cells) == 0 then
    return
  end
  local id = cells[#cells].item._index
  Log.debug("UIBattlePassCN1RewardMain:_OnScrollMove() id = ", id)
  local next = self._component:GetNextPreviewLvFromConfig(id)
  self:_SetRightReward(next)
end

function UIBattlePassCN1RewardMain:_FindClaimItem(lv, adv)
  local tb = {}
  local cells = self._dynamicListHelper:GetVisibleItem()
  for _, v in ipairs(cells) do
    if lv == nil or v.item._index == lv then
      local ids = adv == nil and {1, 2} or adv == false and {1} or {2}
      for __, idx in ipairs(ids) do
        local obj = v.item:FindClaimItemIcon(idx)
        if obj then
          table.insert(tb, obj)
        end
      end
    end
  end
  return tb
end

function UIBattlePassCN1RewardMain:_OnGetRewards(res, rewards, lv, adv)
  if res:GetSucc() then
    local tb = self:_FindClaimItem(lv, adv)
    if #tb == 0 then
      UIActivityHelper.ShowUIGetRewards(rewards, true)
    else
      for i, v in ipairs(tb) do
        if i == 1 then
          v:PlayAnimTaken(function()
            UIActivityHelper.ShowUIGetRewards(rewards, true)
          end)
        else
          v:PlayAnimTaken()
        end
      end
    end
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:Refresh_ByParams({
        resetPos = true,
        expData = true,
        expUpgrade = false,
        anim_PlayIn = true,
        anim_ListItem = false
      })
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
end

function UIBattlePassCN1RewardMain:BuyGiftBtnOnClick(go)
  Log.info("UIBattlePassCN1RewardMain:BuyGiftBtnOnClick")
  self._uiOwner:PlayAnim("buy_out", function(callback)
    UIActivityBattlePassHelper.OpenBuyGiftController(function(upgrade)
      self._uiOwner:PlayAnim("buy_in")
      self:Refresh_ByParams({
        resetPos = false,
        expData = true,
        expUpgrade = upgrade,
        anim_PlayIn = false
      })
    end)
  end)
end

function UIBattlePassCN1RewardMain:ClaimAllBtnOnClick(go)
  Log.info("UIBattlePassCN1RewardMain:ClaimAllBtnOnClick")
  self._component:Start_HandleOneKeyReceiveReward(function(res, rewards)
    self:_OnGetRewards(res, rewards)
  end)
end

function UIBattlePassCN1RewardMain:AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIBattlePassCN1RewardMain:RemoveEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UIBattlePassCN1RewardMain:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UIBattlePassCN1RewardMain:_CheckPoint()
  local obj = self:GetGameObject("claimAllRed")
  local show = self._campaign and UIActivityBattlePassHelper.CalcRed_Reward(self._campaign) or false
  obj:SetActive(show)
end

function UIBattlePassCN1RewardMain:_PlayAnimIn()
  local animName = "UIeff_UIBattlePassCN1RewardMain_in"
  local duration = 450
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, duration)
end

function UIBattlePassCN1RewardMain:_DebugPlayAnimTaken()
  local lv, adv = 5, false
  local reward = NewRoleAsset(3000001, 10)
  local rewards = {reward}
  local tb = self:_FindClaimItem(lv, adv)
  if #tb == 0 then
    UIActivityHelper.ShowUIGetRewards(rewards, true)
  else
    for i, v in ipairs(tb) do
      if i == 1 then
        v:PlayAnimTaken(function()
          UIActivityHelper.ShowUIGetRewards(rewards, true)
        end)
      else
        v:PlayAnimTaken()
      end
    end
  end
end
