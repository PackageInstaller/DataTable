local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_CircularScrollView = typeof(CS.UICircularScrollView.CircularScrollView)
local GameObject = CS.UnityEngine.GameObject
local AwakerAffectionPanel, Super = System.NewClass("AwakerAffectionPanel", UIBasePanel)
AwakerAffectionPanel.uiResCls = UI_Awaker_Popup_Topped_Tip2Resource

function AwakerAffectionPanel:ctor(awakerId)
  Super.ctor(self)
  self.awakerId = awakerId
end

function AwakerAffectionPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(AwakerAffectionModel, self.awakerId)
  self:BindMaskClose(binder)
  self:BindIllustrate(binder)
  self:BindLvScroll(binder)
  self:BindCurlike(binder)
  self:BindReward(binder)
  self:BindFile(binder)
  self:BindButton(binder)
  self:BindBreakthrough(binder)
end

function AwakerAffectionPanel:BindButton(binder)
  self.ui.Btn_Confirm:SetActive(true)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    if self:_NeedBreakthrough() then
      local itemEnough = AwakerFavorabilityCfgUtils.HasEnoughBreakoutItems(self.awakerId, self.model:GetSelectLv())
      local available = self.model:IsBreakthroughAvailable()
      if available and itemEnough then
        self:_ShowBreakthroughConfirm()
      elseif available then
        local costList = AwakerFavorabilityCfgUtils.GetBreakoutCostForLevel(self.awakerId, self.model:GetSelectLv())
        if costList[1] then
          Alert.ShowStr(LT.Textf("Shop_Buy_Lack_Money", ItemNumUtils.GetNameStr(costList[1].itemId)))
        end
      end
      return
    end
    local unlock = self.model:UnlockReward()
    if not unlock then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "GainLikeReward", function()
      self.model:UpdateAwakerlikeReward(CommonDefine.AffectionRewardState.AlreadyGain)
      self:UpdateRewardShow()
      EventMgr.Instance.AwakerAffecttionEvent:Dispatch()
    end, function(_, code)
    end, self.awakerId, self.model:GetSelectLv())
  end, function()
    if self:_NeedBreakthrough() then
      local available = self.model:IsBreakthroughAvailable()
      return available and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
    end
    local unlock = self.model:UnlockReward()
    return unlock and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  end, function()
    if self:_NeedBreakthrough() then
      do return LT.Text end
      return LT.Text, "AwakerFavorBreakThrough"
    end
    do return LT.Text end
    return LT.Text, "BreakThrough_Preview_Btn_Str"
  end)
end

function AwakerAffectionPanel:BindFile(binder)
  local storyCfgMap = {}
  local condition = CommonDefine.AwakerFileUnlock_Condition
  self.storyCfgMap = storyCfgMap
  for _, config in pairs(DT.AwakerStory) do
    if config.ActorIndex == self.awakerId then
      local lvCondition = condition.AwakerFavorabilityLevel
      local typeMatch = config.ConditionType == lvCondition or config.ConditionType_1 == lvCondition
      if typeMatch then
        local lv = 0
        if config.ConditionType == lvCondition then
          lv = config.ConditionPara[1]
        else
          lv = config.ConditionPara_1[1]
        end
        storyCfgMap[lv] = config
      end
    end
  end
  local voiceCfgMap = {}
  self.voiceCfgMap = voiceCfgMap
  for _, config in pairs(DT.Voice) do
    if config.AwakerID == self.awakerId then
      local lvCondition = condition.AwakerFavorabilityLevel
      local typeMatch = config.ConditionType == lvCondition or config.ConditionType_1 == lvCondition
      if typeMatch then
        local lv = 0
        if config.ConditionType == lvCondition then
          lv = config.ConditionPara[1]
        else
          lv = config.ConditionPara_1[1]
        end
        voiceCfgMap[lv] = config
      end
    end
  end
  binder:BindToRaw(function(childBinder, selectLv)
    self:UpdateFileShow(childBinder)
  end, function()
    do return self.model.GetSelectLv end
    return self.model.GetSelectLv, self.model
  end)
end

function AwakerAffectionPanel:UpdateFileShow(binder)
  local selectLv = self.model:GetSelectLv()
  local cfg = self.storyCfgMap[selectLv] or self.voiceCfgMap[selectLv]
  if not cfg then
    self.ui.Group_Unlock:SetActive(false)
    self.ui.Text_Data:SetActive(false)
    self.ui.Text_Special1:SetActive(false)
    self.ui.Text_Special2:SetActive(false)
    return
  end
  self.ui.Group_Unlock:SetActive(true)
  self.ui.Text_Data:SetActive(true)
  binder:SetText(self.ui.Text_Data, cfg.Title or cfg.AwakerVoiceTitle)
  local conditionNotNil = cfg.ConditionType ~= nil
  self.ui.Text_Special1:SetActive(conditionNotNil)
  if conditionNotNil then
    local finish = self:IsConditionFinish(cfg.ConditionType, cfg.ConditionPara)
    binder:SetText(self.ui.Text_Special1, cfg.UnlockDesc)
    binder:BindToTextColor(self.ui.Text_Special1, function()
      return finish and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
    end)
    self.ui.Image_Icon_Hook_1:SetActive(finish)
    self.ui.Image_Icon_Cond_1:SetActive(not finish)
  end
  local conditionNotNil1 = nil ~= cfg.ConditionType_1
  self.ui.Text_Special2:SetActive(conditionNotNil1)
  if conditionNotNil1 then
    local finish = self:IsConditionFinish(cfg.ConditionType_1, cfg.ConditionPara_1)
    binder:SetText(self.ui.Text_Special2, cfg.UnlockDesc_1)
    binder:BindToTextColor(self.ui.Text_Special2, function()
      return finish and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
    end)
    self.ui.Image_Icon_Hook_2:SetActive(finish)
    self.ui.Image_Icon_Cond_2:SetActive(not finish)
  end
end

function AwakerAffectionPanel:IsConditionFinish(conditionType, param)
  do return AwakerAffectDataUtils.StoryOrVoiceUnlockCheck, self.awakerId, conditionType end
  return AwakerAffectDataUtils.StoryOrVoiceUnlockCheck, self.awakerId, conditionType, param
end

function AwakerAffectionPanel:UpdateRewardShow()
  if self.model:HasReward() then
    self.ui.Group_Reward:SetActive(true)
    local unlock = self.model:UnlockReward()
    local canGet = self.model:RewardCanGet()
    local received = not canGet and unlock
    self.ui.Group_Button:SetActive(not received)
    self.ui.RewardReceived:SetActive(received)
  else
    self.ui.Group_Reward:SetActive(false)
    self.ui.RewardReceived:SetActive(false)
    self.ui.Group_Button:SetActive(false)
  end
end

function AwakerAffectionPanel:BindReward(binder)
  local circularScrollView = self.ui.ScrollView:GetComponent(T_CircularScrollView)
  local itemTemplate = circularScrollView and circularScrollView.itemGameObject
  if circularScrollView then
    circularScrollView.enabled = false
  end
  self._rewardItemGOs = {}
  binder:BindToRaw(function(childBinder, selectLv)
    self:UpdateRewardShow()
    if self._rewardItemBinders then
      for _, b in ipairs(self._rewardItemBinders) do
        b:teardown()
      end
    end
    self._rewardItemBinders = {}
    local list = self.model:GetRewardList()
    if not itemTemplate then
      return
    end
    local contentTransform = self.ui.Content.transform
    for i, data in ipairs(list) do
      local itemGO = self._rewardItemGOs[i]
      if not itemGO or IsNil(itemGO) then
        itemGO = GameObject.Instantiate(itemTemplate, contentTransform)
        itemGO.name = "RewardItem_" .. i
        self._rewardItemGOs[i] = itemGO
      end
      itemGO:SetActive(true)
      local itemBinder = binder:createChild(data)
      table.insert(self._rewardItemBinders, itemBinder)
      local itemData = {
        itemTid = data[1],
        itemCount = data[2],
        isGotFunc = function()
          local unlock = self.model:UnlockReward()
          local canGet = self.model:RewardCanGet()
          return not canGet and unlock
        end
      }
      itemBinder:BindComponent(CommonIconItemType2(itemGO, itemData))
    end
    for i = #list + 1, #self._rewardItemGOs do
      local go = self._rewardItemGOs[i]
      if go and not IsNil(go) then
        go:SetActive(false)
      end
    end
  end, function()
    do return self.model.GetSelectLv end
    return self.model.GetSelectLv, self.model
  end)
  local contentNodeLayout = self.ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  if contentNodeLayout then
    contentNodeLayout.enabled = true
  end
end

function AwakerAffectionPanel:BindCurlike(binder)
  binder:BindToText(self.ui.Text_Steps, function()
    do return self.model.GetAwakerLike end
    return self.model.GetAwakerLike, self.model
  end)
end

function AwakerAffectionPanel:BindLvScroll(binder)
  local array = {}
  local awakerId = self.awakerId
  local cfg = DT.AwakerFavorability[awakerId]
  local datalist = cfg.data_list
  for _, v in ipairs(datalist) do
    if v.AwakerFavorabilityLevel > 1 then
      table.insert(array, v)
    end
  end
  binder:BindToCircularListView(self.ui.ScrollView_Item, function()
    return array
  end, function(itemBinder, obj, index)
    itemBinder:BindComponent(AwakerAffectionItem(obj, array[index], self.model))
  end)
  local startMoveCnt = 2
  local viewShowCnt = 4
  local itemCnt = self.model:GetMaxLv() - 1
  if viewShowCnt >= itemCnt then
    return
  end
  self.ScrollRect = self.ui.ScrollView_Item:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  local offsetPerItem = 1.0 / (itemCnt - viewShowCnt)
  local lvIndex = self.model:GetSelectLv() - 1
  if lvIndex > 2 then
    local offset = lvIndex - startMoveCnt
    self.ScrollRect.horizontalNormalizedPosition = offset * offsetPerItem
  end
end

function AwakerAffectionPanel:_UpdateLvScrollPosition()
  local startMoveCnt = 2
  local viewShowCnt = 4
  local itemCnt = self.model:GetMaxLv() - 1
  if viewShowCnt >= itemCnt then
    return
  end
  self.ScrollRect = self.ui.ScrollView_Item:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  local offsetPerItem = 1.0 / (itemCnt - viewShowCnt)
  local lvIndex = self.model:GetSelectLv() - 1
  if lvIndex > 2 then
    local offset = lvIndex - startMoveCnt
    self.ScrollRect.horizontalNormalizedPosition = offset * offsetPerItem
  end
end

function AwakerAffectionPanel:BindIllustrate(binder)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Question, function()
    local title = LT.Text("AwakerFavorability_Description_Title")
    local detail = LT.Text("AwakerFavorability_Description_Detail")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, detail)
  end)
end

function AwakerAffectionPanel:BindMaskClose(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function AwakerAffectionPanel:_IsAtBreakthroughLevel()
  do return AwakerFavorabilityCfgUtils.HasBreakoutCost, self.awakerId, self.model:GetSelectLv() end
  return AwakerFavorabilityCfgUtils.HasBreakoutCost, self.awakerId, self.model:GetSelectLv()
end

function AwakerAffectionPanel:_NeedBreakthrough()
  local breakthroughLv = self.model:GetBreakthroughLevel()
  local maxLv = AwakerFavorabilityCfgUtils.GetAwakerMaxLikeLevel(self.awakerId)
  if breakthroughLv >= maxLv then
    return false
  end
  local curLv = AwakerFavorabilityCfgUtils.GetAwkerLikeLevel(self.awakerId)
  local selectLv = self.model:GetSelectLv()
  return maxLv > curLv and breakthroughLv < selectLv and curLv < selectLv
end

function AwakerAffectionPanel:BindBreakthrough(binder)
  if not self.ui.Group_Breakthrough then
    return
  end
  binder:BindToVisible(self.ui.Group_Breakthrough, function()
    do return self._NeedBreakthrough end
    return self._NeedBreakthrough, self
  end)
  if self.ui.ScrollView_Breakthrough then
    local btCircular = self.ui.ScrollView_Breakthrough:GetComponent(T_CircularScrollView)
    local btTemplate = btCircular and btCircular.itemGameObject
    if btCircular then
      btCircular.enabled = false
    end
    self._btItemGOs = {}
    binder:BindToRaw(function(childBinder, selectLv)
      if self._btItemBinders then
        for _, b in ipairs(self._btItemBinders) do
          b:teardown()
        end
      end
      self._btItemBinders = {}
      local costList = AwakerFavorabilityCfgUtils.GetBreakoutCostForLevel(self.awakerId, self.model:GetSelectLv())
      if not btTemplate or 0 == #costList then
        for _, go in ipairs(self._btItemGOs) do
          if go and not IsNil(go) then
            go:SetActive(false)
          end
        end
        return
      end
      local contentTransform = self.ui.ScrollView_Breakthrough:GetComponent(T_ScrollRect).content.transform
      for i, data in ipairs(costList) do
        local itemGO = self._btItemGOs[i]
        if not itemGO or IsNil(itemGO) then
          itemGO = GameObject.Instantiate(btTemplate, contentTransform)
          itemGO.name = "BtItem_" .. i
          self._btItemGOs[i] = itemGO
        end
        itemGO:SetActive(true)
        local itemBinder = binder:createChild(data)
        table.insert(self._btItemBinders, itemBinder)
        local itemData = {
          id = data.itemId,
          requiredCount = data.count
        }
        itemBinder:BindComponent(AwakerBreakthroughMaterial(itemGO, itemData))
      end
      for i = #costList + 1, #self._btItemGOs do
        local go = self._btItemGOs[i]
        if go and not IsNil(go) then
          go:SetActive(false)
        end
      end
    end, function()
      do return self.model.GetSelectLv end
      return self.model.GetSelectLv, self.model
    end)
    local contentNode = self.ui.ScrollView_Breakthrough:GetComponent(T_ScrollRect).content
    local contentNodeLayout = contentNode and contentNode:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
    if contentNodeLayout then
      contentNodeLayout.enabled = true
    end
  end
end

function AwakerAffectionPanel:_ShowBreakthroughConfirm()
  local costList = AwakerFavorabilityCfgUtils.GetBreakoutCostForLevel(self.awakerId, self.model:GetSelectLv())
  if 0 == #costList then
    return
  end
  local itemList = {}
  for _, cost in ipairs(costList) do
    table.insert(itemList, {
      itemId = cost.itemId,
      itemNum = cost.count
    })
  end
  UIManager.Instance:Reopen(Urls.CommonItemConsumeView, {
    tipText = LT.Text("AwakerFavorBreakThroughPopTip"),
    itemList = itemList,
    confirmCallback = function()
      self:_ReqBreakthrough()
    end
  })
end

function AwakerAffectionPanel:_ReqBreakthrough()
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnLikeBreak", function()
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    self.model:UpdateBreakthroughLevel()
    self.model:UpdateMaxAndMinLv()
    self:_UpdateLvScrollPosition()
    EventMgr.Instance.AwakerAffecttionEvent:Dispatch()
    local nextLv = self.model:GetSelectLv()
    UIManager.Instance:Reopen(Urls.ActiveSuccessPanel, LT.Text("AwakerFavorBreakThroughSuccessTip"), nil, nil, LT.Textf("AwakerFavorBreakThroughSuccessSubTip", nextLv - 1, nextLv), true)
  end, function(_, code)
    Logger.Proto("AwakerAffectionPanel:_ReqBreakthrough failed, code=%s", code)
  end, self.awakerId)
end

return AwakerAffectionPanel
