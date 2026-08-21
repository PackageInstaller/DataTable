_class("UIHauteCoutureDrawMainPLM_Review", UIHauteCoutureDrawBase)
UIHauteCoutureDrawMainPLM_Review = UIHauteCoutureDrawMainPLM_Review

function UIHauteCoutureDrawMainPLM_Review:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
  local open_id = GameGlobal.GameLogic():GetOpenId()
  self._openID = "UIHauteCoutureDrawMainPLM_Review" .. open_id
end

function UIHauteCoutureDrawMainPLM_Review:OnShow(uiParams)
  self:InitWidgets()
  self._prizes = self.controller._prizes
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:_LoadPrize()
  self:CheckAllPrizeCollected()
  self:StartTask(self.CheckAndDoEnterAni, self)
  self._isActive = true
end

function UIHauteCoutureDrawMainPLM_Review:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self._isActive = false
  self:UnLock("UIHauteCoutureDrawMainPLM_Review:drawBtnOnClick")
end

function UIHauteCoutureDrawMainPLM_Review:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "LashShowCoutureEnter"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDrawMainPLM_Review:InitWidgets()
  self:InitWidgetsBase()
  self._prizeTop = self:GetUIComponent("UISelectObjectPath", "PrizeListTop")
  self._prizeBottom = self:GetUIComponent("UISelectObjectPath", "PrizeListBottom")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._rootGo = self:GetGameObject("Root")
  self._rootAni = self:GetUIComponent("Animation", "RootAni")
  self._enterAniPool = self:GetUIComponent("UISelectObjectPath", "EnterAnimation")
  self._enterAniGo = self:GetGameObject("EnterAnimation")
  self._endTimeImgOther = self:GetGameObject("endTimeImgOther")
  self._endTimeImgOther:SetActive(false)
  self._particleSystem = self:GetGameObject("ParticleSystem")
  self._particleSystem2 = self:GetGameObject("ParticleSystem2")
  self._eff = self:GetGameObject("eff")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._particleSystem.layer = 10
  self._particleSystem2.layer = 10
  self._duplicateTip = self:GetGameObject("DuplicateTip")
end

function UIHauteCoutureDrawMainPLM_Review:CloseSelf()
  self:StartTask(function(TT)
    self._anim:Play("uieff_UIHauteCoutureDrawMainPLM_out")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHauteCoutureDrawBgPLMAnimOut)
    YIELD(TT, 200)
    self.controller:CloseDialog()
  end)
end

function UIHauteCoutureDrawMainPLM_Review:SetEndTime(timeStr)
  if self._endtime then
    self._endtime:SetText(timeStr)
    self._endtimeOther = self:GetUIComponent("UILocalizationText", "endtimeOther")
    self._endtimeOther:SetText(timeStr)
  end
end

function UIHauteCoutureDrawMainPLM_Review:GetCoinId()
  return 3000378
end

function UIHauteCoutureDrawMainPLM_Review:_OnValue()
end

function UIHauteCoutureDrawMainPLM_Review:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.VideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
end

function UIHauteCoutureDrawMainPLM_Review:_LoadPrize()
  self._replaceIdxs = GameGlobal.GetModule(CampaignModule):GetSeniorSkinDuplicateRewardIndexs(self._prizes, self.controller._componentInfo)
  self._duplicateTip:SetActive(#self._replaceIdxs > 0)
  local specialIndex = 1
  local specailPrizeOrder = 10
  local prizes = self.controller._prizes
  local idList = {}
  for i = 1, table.count(prizes) do
    local prize = prizes[i]
    if specailPrizeOrder ~= prize.RewardSortOrder then
      table.insert(idList, prize.RewardSortOrder)
    end
  end
  local topItemNum = 3
  self._prizeTop:SpawnObjects("UIHauteCoutureDrawPrizeItemPLMReview", topItemNum)
  self._prizeBottom:SpawnObjects("UIHauteCoutureDrawPrizeItemPLMReview", #idList - topItemNum)
  local topPools = self._prizeTop:GetAllSpawnList()
  for i = 1, #topPools do
    local item = topPools[i]
    local idx = idList[i]
    item:SetData(idx, self.controller._componentId, false, self.controller.CtxData, table.icontains(self._replaceIdxs, specailPrizeOrder - idx + 1))
    table.insert(self._allPrizes, item)
  end
  local bottomPoos = self._prizeBottom:GetAllSpawnList()
  for i = 1, #bottomPoos do
    local item = bottomPoos[i]
    local idx = idList[i + topItemNum]
    item:SetData(idx, self.controller._componentId, false, self.controller.CtxData)
    table.insert(self._allPrizes, item)
  end
  if specialIndex then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItemPLMReview")
    item:SetData(specailPrizeOrder, self.controller._componentId, true, self.controller.CtxData, table.icontains(self._replaceIdxs, specialIndex))
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
  if #self._replaceIdxs > 0 then
    local isOpen = LocalDB.HasKey(self._openID)
    if not isOpen then
      LocalDB.SetInt(self._openID, 1)
      self:StartTask(function(TT)
        self:Lock("UIHauteCoutureDuplicateReward_in")
        YIELD(TT, 1200)
        self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
        self:UnLock("UIHauteCoutureDuplicateReward_in")
      end)
    end
  end
end

function UIHauteCoutureDrawMainPLM_Review:_RefreshReward()
  if self._allPrizes then
    for k, v in pairs(self._allPrizes) do
      local itemId = v:GetCfgID()
      local state = table.icontains(self.controller._componentInfo.shake_win_ids, itemId)
      v:Flush(state)
      v:SetGray(false)
    end
  end
  if self:IsAllAwardCollected() then
    self._drawBtnOj:SetActive(false)
    self._endTimeImgOther:SetActive(true)
  else
    local tmp = Cfg.cfg_component_senior_skin_cost({
      ComponentID = self.controller._componentId,
      SeqID = self.controller._componentInfo.shake_num + 1
    })
    if not tmp then
      return
    end
    local curDrawCost = tmp[1]
    local itemModule = GameGlobal.GetModule(ItemModule)
    local count = itemModule:GetItemCount(curDrawCost.CostItemID)
    if count < curDrawCost.CostItemCount then
      self._moneyNum:SetText("<color=#f64b39>" .. curDrawCost.CostItemCount .. "</color>")
    else
      self._moneyNum:SetText(curDrawCost.CostItemCount)
    end
    self._freeGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._redGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._countParent:SetActive(curDrawCost.CostItemCount > 0)
  end
end

function UIHauteCoutureDrawMainPLM_Review:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainPLM_Review:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDrawMainPLM_Review:HandleDrawBtnClick()
  if self.controller._closed then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local nextDraw = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self.controller._componentId,
    SeqID = self.controller._componentInfo.shake_num + 1
  })[1]
  local id = nextDraw.CostItemID
  if self:GetModule(RoleModule):GetAssetCount(id) < nextDraw.CostItemCount then
    ToastManager.ShowToast(StringTable.Get("str_item_not_enough_plm"))
    GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeV2Controller", self.controller.hcType, self.controller._buyComponet, self.controller.CtxData)
    return
  end
  self:StartTask(self.DrawAnim, self)
end

function UIHauteCoutureDrawMainPLM_Review:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawMainPLM_Review:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawMainPLM_Review:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not self._isActive then
    Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
    return
  end
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawMainPLM_Review:drawBtnOnClick")
    return
  end
  Log.debug("高级时装抽奖结果:", rewards)
  local targetid = rewards
  local collectedAwards = {}
  for _, id in pairs(self.controller._componentInfo.shake_win_ids) do
    collectedAwards[id] = true
  end
  local targetidx
  local idxs = {}
  for idx, item in ipairs(self._allPrizes) do
    local id = item:GetCfgID()
    if not collectedAwards[id] then
      if id == targetid then
        targetidx = idx
      elseif idx == self.controller._specialIdx then
        if self:CanDrawSpecialAward() then
          table.insert(idxs, idx)
        end
      else
        table.insert(idxs, idx)
      end
      if idx == self.controller._specialIdx then
        item:SetGray(self:CanDrawSpecialAward())
      else
        item:SetGray(true)
      end
    else
      item:SetGray(false)
    end
  end
  if #idxs == 0 then
  else
    table.shuffle(idxs)
    table.insert(idxs, 1, targetidx)
    local rdmIdx = {}
    local count = #idxs
    local flashCount = 18
    for i = 1, flashCount do
      table.insert(rdmIdx, idxs[Mathf.Repeat(i - 1, count) + 1])
    end
    local last
    for i = 1, flashCount do
      if not self._isActive then
        Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
        return
      end
      local idx = rdmIdx[flashCount - i + 1]
      if last then
        self._allPrizes[last]:SetGray(true)
      end
      self._allPrizes[idx]:SetGray(false)
      last = idx
      if i == flashCount then
        YIELD(TT, 100)
      elseif i > flashCount - 2 then
        YIELD(TT, 500)
      elseif i > flashCount - 3 then
        YIELD(TT, 280)
      elseif i == 2 then
        YIELD(TT, 200)
      elseif i == 1 then
        YIELD(TT, 400)
      else
        YIELD(TT, 100)
      end
    end
  end
  self._prizeEff.position = self._allPrizes[targetidx]:GetGameObject().transform.position
  self._prizeEff.gameObject:SetActive(true)
  YIELD(TT, 1000)
  if not self._isActive then
    Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
    return
  end
  self._prizeEff.gameObject:SetActive(false)
  self.controller._campaign = UIActivityCampaign:New()
  local resC = AsyncRequestRes:New()
  self.controller._campaign:LoadCampaignInfo(TT, resC, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  if not self._isActive then
    Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
    return
  end
  self.controller._campaign:ReLoadCampaignInfo_Force(TT, resC)
  if not self._isActive then
    Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
    return
  end
  self.controller._buyComponet = self.controller._campaign:GetLocalProcess()._buyGiftComponent
  self.controller._buyComponetInfo = self.controller._campaign:GetLocalProcess()._buyGiftComponentInfo
  self.controller._component = self.controller._campaign:GetLocalProcess()._seniorSkinComponent
  self.controller._componentInfo = self.controller._campaign:GetLocalProcess()._seniorSkinComponentInfo
  if self.controller._componentInfo.shake_num == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
  end
  local weightCfg = Cfg.cfg_component_senior_skin_weight[rewards]
  if not weightCfg then
    Log.error("###[UIHauteCoutureDrawController] cfg is nil ! id --> ", rewards)
    return
  end
  local reawrdList = {}
  local reward = RoleAsset:New()
  reward.assetid = weightCfg.RewardID
  reward.count = weightCfg.RewardCount
  table.insert(reawrdList, reward)
  if weightCfg.AppendGlow and 0 < weightCfg.AppendGlow then
    local rewardGp = RoleAsset:New()
    rewardGp.assetid = RoleAssetID.RoleAssetGlow
    rewardGp.count = weightCfg.AppendGlow
    table.insert(reawrdList, rewardGp)
  end
  local reawrdList = self._allPrizes[targetidx]._assetList
  local specialInclude = false
  for key, value in pairs(self._replaceIdxs) do
    if value == 1 then
      specialInclude = true
      break
    end
  end
  if self.controller._specialIdx == targetidx and not specialInclude then
    local skin = RoleAsset:New()
    skin.assetid = weightCfg.RewardID - 4000000
    skin.count = weightCfg.RewardCount
    self:ShowDialog("UIPetSkinObtainController", skin, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
      if not self._isActive then
        Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
        return
      end
      self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
        if not self._isActive then
          Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
          return
        end
        self:_RefreshReward()
        self:CheckAllPrizeCollected()
      end, self.controller.CtxData)
    end)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
      if not self._isActive then
        Log.error("###[UIHauteCoutureDrawMainPLM_Review] 异常中断，界面被关闭")
        return
      end
      self:_RefreshReward()
      self:CheckAllPrizeCollected()
    end, self.controller.CtxData)
  end
  self:UnLock("UIHauteCoutureDrawMainPLM_Review:drawBtnOnClick")
end

function UIHauteCoutureDrawMainPLM_Review:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._endTimeImgOther:SetActive(true)
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawMainPLM_Review:CheckAndDoEnterAni(TT)
  local key = self:GetEnterAniKey()
  if UnityEngine.PlayerPrefs.HasKey(key) then
    local lastShow = UnityEngine.PlayerPrefs.GetFloat(key)
    local nextRefresh = GameGlobal.GetModule(LoginModule):GetSignRefreshTime()
    if nextRefresh - lastShow < 86400 then
      self._enterAniGo:SetActive(false)
      self:_EnterRoot()
      self._eff:SetActive(true)
      return
    end
  end
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UnityEngine.PlayerPrefs.SetFloat(key, now)
  self._rootGo:SetActive(false)
  local enterAni = self._enterAniPool:SpawnObject("UIHauteCoutureDrawEnterAniPLM")
  local clipLength = enterAni:GetClipLength()
  YIELD(TT, clipLength * 1000 - 600)
  self:_EnterRoot()
  YIELD(TT, 300)
  self._enterAniGo:SetActive(false)
  self._eff:SetActive(true)
end

function UIHauteCoutureDrawMainPLM_Review:_EnterRoot()
  self._rootGo:SetActive(true)
  self._rootAni:Play("uieff_UIHauteCoutureDrawMainPLM_in")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHauteCoutureDrawBgPLMAnimIn)
  local topPools = self._prizeTop:GetAllSpawnList()
  for i = 1, #topPools do
    local item = topPools[i]
    item:PlayAnim(i)
  end
  local bottomPoos = self._prizeBottom:GetAllSpawnList()
  for i = 1, #bottomPoos do
    local item = bottomPoos[i]
    item:PlayAnim(i + 3)
  end
  self:_LoadVideo()
end

function UIHauteCoutureDrawMainPLM_Review:VideoMaskOnClick(go)
  self:HandleFgBtnClick()
end

function UIHauteCoutureDrawMainPLM_Review:VideoMaskOnClick1(go)
  if self._playing then
    self._playing = false
  else
    self._playing = true
  end
  if self._playing then
    self._vp:Play()
  else
    self._vp:Pause()
  end
  self._pause:SetActive(not self._playing)
end

function UIHauteCoutureDrawMainPLM_Review:DuplicateTipOnClick(go)
  self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
end
