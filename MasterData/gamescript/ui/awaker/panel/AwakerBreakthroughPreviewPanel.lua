local typeof = _ENV.typeof
local AwakerBreakThrough = CommonDefine.AwakerBreakThrough
local BtnType = CommonDefine.BtnType
local Animator = CS.UnityEngine.Animator
local GameObject = CS.UnityEngine.GameObject
local AwakerBreakthroughPreviewPanel, Super = System.NewClass("AwakerBreakthroughPreviewPanel", UIBasePanel)
AwakerBreakthroughPreviewPanel.uiResCls = UI_Awaker_Popup_Topped_TipResource

function AwakerBreakthroughPreviewPanel:ctor(model)
  Super.ctor(self)
  self.model = model
end

function AwakerBreakthroughPreviewPanel:InitUI(uiNode)
  Super.InitUI(self, uiNode)
  local tid = self.model.selectAwakerId
  local maxStar = self.model:GetAwakerBreakthroughMaxStar(tid)
  self.breakthroughStars = AwakerBreakthroughStars(self.ui.RootStars, maxStar)
end

function AwakerBreakthroughPreviewPanel:OnBind(binder)
  local awakerTid = self.model.selectAwakerId
  local nextStar = self.model:GetAwakerCurrBreakthroughStar(awakerTid) + 1
  local maxStars = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
  local hasUnreceivedReward = false
  for star = 1, maxStars do
    local receiveState = self.model:GetBreakthroughRewardReceiveState(awakerTid, star)
    if receiveState == CommonDefine.AwakerBreakThrough.RewardAvailable then
      hasUnreceivedReward = true
      self.model:SetBreakthroughStarPreview(awakerTid, star)
      break
    end
  end
  if not hasUnreceivedReward then
    local previewStar = nextStar < maxStars and nextStar or maxStars
    self.model:SetBreakthroughStarPreview(awakerTid, previewStar)
  end
  binder:BindToText(self.ui.Text_Steps, function()
    local previewLv = self.model:GetAwakerBreakthroughStarPreview(awakerTid)
    do return LT.Textf, "BreakthroughTitleText" end
    return LT.Textf, "BreakthroughTitleText", previewLv
  end)
  self.breakthroughStars:BindStarRed(binder, awakerTid)
  binder:BindToRaw(function(_, star)
    if not star then
      return
    end
    local currBreakthroughStar = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    local numStars = self.breakthroughStars:NumStars()
    for idx = 1, numStars do
      if idx <= currBreakthroughStar then
        if idx == star then
          self.breakthroughStars:TurnOnAndLocate(idx)
        else
          self.breakthroughStars:TurnOn(idx)
        end
      elseif idx == star then
        self.breakthroughStars:TurnOffAndLocate(idx)
      else
        self.breakthroughStars:TurnOff(idx)
      end
    end
    self.ui.Group_UP:SetActive(star > 1)
    self.ui.Group_Down:SetActive(star < numStars)
    if star <= currBreakthroughStar then
      local text = LT.Text("BreakThrough_Preview_Completed_Tips")
      binder:SetText(self.ui.Text_Introduce, text)
    else
      local cfg = DT.AwakerBreakThrough[awakerTid]
      local data = cfg.data_list[star]
      local text = LT.Text(data.BreakthroughConditionDescription)
      binder:SetText(self.ui.Text_Introduce, text)
    end
  end, function()
    do return self.model.GetAwakerBreakthroughStarPreview, self.model end
    return self.model.GetAwakerBreakthroughStarPreview, self.model, awakerTid
  end)
  local starRootTrans = self.ui.RootStars.transform
  for idx = 0, starRootTrans.childCount - 1 do
    local starGO = starRootTrans:GetChild(idx).gameObject
    binder:BindButtonClick(starGO, function()
      self.model:SetBreakthroughStarPreview(awakerTid, idx + 1)
    end)
  end
  binder:BindToRaw(function(childBinder, mtrlCost)
    local _previewStar = self.model:GetAwakerBreakthroughStarPreview(awakerTid)
    local currStar = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    local mtrlRootTrans = self.ui.RootMaterials.transform
    for idx = 0, mtrlRootTrans.childCount - 1 do
      local mtrlGO = mtrlRootTrans:GetChild(idx).gameObject
      local cost = mtrlCost[idx + 1]
      local itemID = cost and cost.id or -1
      local item = ItemDataUtils.GetItemByTid(itemID)
      local itemInfo = {
        id = itemID,
        currCount = item and item.num or 0,
        requiredCount = cost and cost.count or 0
      }
      childBinder:BindComponent(AwakerBreakthroughMaterial(mtrlGO, itemInfo, _previewStar <= currStar))
    end
  end, function()
    do return self.model.GetAwakerBreakthroughMtrlCostPreview, self.model end
    return self.model.GetAwakerBreakthroughMtrlCostPreview, self.model, awakerTid
  end)
  binder:BindToText(self.ui.Text_Coin_Count, function()
    do return self.model.GetAwakerBreakthroughGoldCostPreview, self.model end
    return self.model.GetAwakerBreakthroughGoldCostPreview, self.model, awakerTid
  end)
  binder:BindToRaw(function(childBinder, rewardList)
    local rewardGOList = self:_PrepareRewardGOList(#rewardList)
    for idx, reward in ipairs(rewardList) do
      local rewardGO = rewardGOList[idx]
      childBinder:BindComponent(AwakerBreakthroughReward(self.model, rewardGO, reward))
    end
  end, function()
    do return self.model.GetAwakerBreakthroughRewardPreview, self.model end
    return self.model.GetAwakerBreakthroughRewardPreview, self.model, awakerTid
  end)
  binder:BindButtonClick(self.ui.Btn_Click_UP, function()
    local star = self.model:GetAwakerBreakthroughStarPreview(awakerTid)
    self.model:SetBreakthroughStarPreview(awakerTid, star - 1)
  end)
  binder:BindButtonClick(self.ui.Btn_Click_Down, function()
    local star = self.model:GetAwakerBreakthroughStarPreview(awakerTid)
    self.model:SetBreakthroughStarPreview(awakerTid, star + 1)
  end)
  binder:BindToVisible(self.ui.RewardReceived, function()
    local state = self.model:GetAwakerBreakthroughRewardReceiveStatePreview(awakerTid)
    return state == AwakerBreakThrough.RewardReceived
  end)
  binder:BindToVisible(self.ui.Group_Button, function()
    local state = self.model:GetAwakerBreakthroughRewardReceiveStatePreview(awakerTid)
    return state ~= AwakerBreakThrough.RewardReceived
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    local receiveState = self.model:GetAwakerBreakthroughRewardReceiveStatePreview(awakerTid)
    if receiveState == CommonDefine.AwakerBreakThrough.RewardAvailable then
      local rewardList = self.model:GetAwakerBreakthroughRewardPreview(awakerTid)
      local items = {}
      for _, reward in ipairs(rewardList) do
        table.insert(items, {
          tid = reward.id,
          changedNum = reward.count
        })
      end
      local star = self.model:GetAwakerBreakthroughStarPreview(awakerTid)
      self.model:ReqGainBreakReward(awakerTid, star, function()
        self.model:SetBreakthroughStarPreview(awakerTid, star)
        ItemDataUtils.ShowRewardPanel(LT.Text("ItemGain_String_MainTitle"), "", items)
      end)
    elseif receiveState == CommonDefine.AwakerBreakThrough.RewardUnavailable then
      Alert.Show(10562)
    end
  end, function()
    local receiveState = self.model:GetAwakerBreakthroughRewardReceiveStatePreview(awakerTid)
    return receiveState == AwakerBreakThrough.RewardAvailable and BtnType.High or BtnType.Unclickable
  end, function()
    do return LT.Text end
    return LT.Text, "BreakThrough_Preview_Btn_Str"
  end, function()
    local star = self.model:GetAwakerBreakthroughStarPreview(awakerTid)
    local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
    local redType = AwakerRedUtils.GetBreakthroughPreviewRed(awaker, star) and RedPointDataUtils.RedAttrType.Red
    return redType
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnCancelClick))
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.OnCancelClick))
end

function AwakerBreakthroughPreviewPanel:OnCancelClick()
  self:Close()
end

function AwakerBreakthroughPreviewPanel:_PrepareRewardGOList(numRewards)
  local rewardGOList = {}
  local rewardRootTrans = self.ui.RootRewards.transform
  if numRewards > rewardRootTrans.childCount then
    local temp = rewardRootTrans:GetChild(0).gameObject
    for idx = 1, numRewards - rewardRootTrans.childCount do
      GameObject.Instantiate(temp, rewardRootTrans)
    end
  end
  for idx = 0, rewardRootTrans.childCount - 1 do
    local rewardGO = rewardRootTrans:GetChild(idx).gameObject
    if numRewards > idx then
      rewardGO:SetActive(true)
      table.insert(rewardGOList, rewardGO)
    else
      rewardGO:SetActive(false)
    end
  end
  return rewardGOList
end

return AwakerBreakthroughPreviewPanel
