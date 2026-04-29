_class("UIHauteCoutureDrawMainBLH", UIHauteCoutureDrawBase)
UIHauteCoutureDrawMainBLH = UIHauteCoutureDrawMainBLH

function UIHauteCoutureDrawMainBLH:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
end

function UIHauteCoutureDrawMainBLH:CloseSelf()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  self.controller:CloseDialog()
end

function UIHauteCoutureDrawMainBLH:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:_LoadPrize()
  self:CheckAllPrizeCollected()
  self:_LoadVideo()
end

function UIHauteCoutureDrawMainBLH:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
end

function UIHauteCoutureDrawMainBLH:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "LashShowCoutureEnter"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDrawMainBLH:InitWidgets()
  self:InitWidgetsBase()
  self._prizeTop = self:GetUIComponent("UISelectObjectPath", "PrizeListTop")
  self._prizeBottom = self:GetUIComponent("UISelectObjectPath", "PrizeListBottom")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._rootGo = self:GetGameObject("Root")
  self._rootAni = self:GetUIComponent("Animation", "RootAni")
  self._enterAniPool = self:GetUIComponent("UISelectObjectPath", "EnterAnimation")
  self._enterAniGo = self:GetGameObject("EnterAnimation")
  self.drawTitle = self:GetUIComponent("RollingText", "drawTitle")
  self._pause = self:GetGameObject("pause")
end

function UIHauteCoutureDrawMainBLH:GetCoinId()
  return self.controller.CtxData:CostItemID()
end

function UIHauteCoutureDrawMainBLH:_OnValue()
  self.drawTitle:RefreshText(StringTable.Get("str_senior_skin_draw_des_gl"))
end

function UIHauteCoutureDrawMainBLH:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.MiniVideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
  self._playing = true
  self._pause:SetActive(not self._playing)
end

function UIHauteCoutureDrawMainBLH:LoadVideo(url)
  Log.debug("[guide movie] move url ", url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
  self._rt = UnityEngine.RenderTexture:New(339, 190, 16)
  self._rawImage.texture = self._rt
  self._vp.targetTexture = self._rt
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawV2Controller")
  self._vp:Play()
  self._vp.frame = 0
  GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawV2Controller"):Render()
end

function UIHauteCoutureDrawMainBLH:_LoadPrize()
  local specialIndex = 0
  if self.controller._specialIdx then
    specialIndex = self.controller._specialIdx
  end
  local prizes = self.controller._prizes
  local idList = {}
  for i = 1, table.count(prizes) do
    local prize = prizes[i]
    if specialIndex ~= prize.RewardSortOrder then
      table.insert(idList, prize.RewardSortOrder)
    end
  end
  local topItemNum = 3
  self._prizeTop:SpawnObjects("UIHauteCoutureDrawPrizeItemBLH", topItemNum)
  self._prizeBottom:SpawnObjects("UIHauteCoutureDrawPrizeItemBLH", #idList - topItemNum)
  local topPools = self._prizeTop:GetAllSpawnList()
  for i = 1, #topPools do
    local item = topPools[i]
    local idx = idList[i]
    item:SetData(idx, self.controller._componentId, false, self.controller.CtxData)
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
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItemBLH")
    item:SetData(specialIndex, self.controller._componentId, true, self.controller.CtxData)
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainBLH:_RefreshReward()
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
      self._moneyNum:SetText("<color=#f83e13>" .. curDrawCost.CostItemCount .. "</color>")
    else
      self._moneyNum:SetText(curDrawCost.CostItemCount)
    end
    self._freeGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._redGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._countParent:SetActive(curDrawCost.CostItemCount > 0)
  end
end

function UIHauteCoutureDrawMainBLH:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainBLH:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDrawMainBLH:HandleDrawBtnClick()
  if self.controller._closed then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  local nextDraw = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self.controller._componentId,
    SeqID = self.controller._componentInfo.shake_num + 1
  })[1]
  local id = nextDraw.CostItemID
  if self:GetModule(RoleModule):GetAssetCount(id) < nextDraw.CostItemCount then
    local cfg_item = Cfg.cfg_item[id]
    local costName = ""
    if cfg_item then
      costName = StringTable.Get(cfg_item.Name)
    end
    ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_cost_not_enough", costName))
    GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeV2Controller", self.controller.hcType, self.controller._buyComponet, self.controller.CtxData)
    return
  end
  self:StartTask(self.DrawAnim, self)
end

function UIHauteCoutureDrawMainBLH:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawMainBLH:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawMainBLH:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawMainBLH:drawBtnOnClick")
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
  self._prizeEff.gameObject:SetActive(false)
  self.controller._campaign = UIActivityCampaign:New()
  local resC = AsyncRequestRes:New()
  self.controller._campaign:LoadCampaignInfo(TT, resC, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  self.controller._campaign:ReLoadCampaignInfo_Force(TT, resC)
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
  if self.controller._specialIdx == targetidx then
    local skin = RoleAsset:New()
    skin.assetid = weightCfg.RewardID - 4000000
    skin.count = weightCfg.RewardCount
    self:ShowDialog("UIPetSkinObtainController", skin, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
      self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
        self:_RefreshReward()
        self:CheckAllPrizeCollected()
      end, self.controller.CtxData)
    end)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
      self:_RefreshReward()
      self:CheckAllPrizeCollected()
    end, self.controller.CtxData)
  end
  self:UnLock("UIHauteCoutureDrawMainBLH:drawBtnOnClick")
end

function UIHauteCoutureDrawMainBLH:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawMainBLH:VideoMaskOnClick(go)
  self:HandleFgBtnClick()
end

function UIHauteCoutureDrawMainBLH:VideoMaskOnClick1(go)
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

function UIHauteCoutureDrawMainBLH:CheckEndTime()
  local time = self.controller._componentInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    local timeStr = StringTable.Get("str_activity_finished")
    self:SetEndTime(timeStr)
    self._timeStr = timeStr
    return true
  else
    local timeStr = HelperProxy:GetInstance():FormatTime_3(time - now, "#f1de3a")
    if self._timeStr ~= timeStr then
      self:SetEndTime(StringTable.Get("str_senior_skin_draw_end_time", timeStr))
      self._timeStr = timeStr
    end
    return false
  end
  return true
end
