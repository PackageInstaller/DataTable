_class("UIHauteCoutureDrawMainKR_Review", UIHauteCoutureDrawBase)
UIHauteCoutureDrawMainKR_Review = UIHauteCoutureDrawMainKR_Review

function UIHauteCoutureDrawMainKR_Review:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
end

function UIHauteCoutureDrawMainKR_Review:CloseSelf()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  self.controller:CloseDialog()
end

function UIHauteCoutureDrawMainKR_Review:OnShow(uiParams)
  self:InitWidgets()
  self._prizes = self.controller._prizes
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:_LoadPrize()
  self:CheckAllPrizeCollected()
  self:StartTask(self.CheckAndDoEnterAni, self)
end

function UIHauteCoutureDrawMainKR_Review:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
end

function UIHauteCoutureDrawMainKR_Review:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "LashShowCoutureEnter"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDrawMainKR_Review:InitWidgets()
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
  self._duplicateTip = self:GetGameObject("DuplicateTip")
  self._logoImg = self:GetUIComponent("RawImageLoader", "logo")
end

function UIHauteCoutureDrawMainKR_Review:GetCoinId()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinKR_Re
end

function UIHauteCoutureDrawMainKR_Review:_OnValue()
  self.drawTitle:RefreshText(StringTable.Get("str_senior_skin_draw_des_kr"))
  self._logoImg:LoadImage("krsenior_re_zjm_titile")
end

function UIHauteCoutureDrawMainKR_Review:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.MiniVideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
  self._playing = true
  self._pause:SetActive(not self._playing)
end

function UIHauteCoutureDrawMainKR_Review:LoadVideo(url)
  Log.debug("[guide movie] move url ", url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
  self._rt = UnityEngine.RenderTexture:New(512, 384, 16)
  self._rawImage.texture = self._rt
  self._vp.targetTexture = self._rt
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawV2ReviewController")
  self._vp:Play()
  self._vp.loopPointReached = self._vp.loopPointReached + self._LoopPointReached
  GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawV2ReviewController"):Render()
  self._vp.frame = 0
end

function UIHauteCoutureDrawMainKR_Review:_LoadPrize()
  self._replaceIdxs = GameGlobal.GetModule(CampaignModule):GetSeniorSkinDuplicateRewardIndexs(self._prizes, self.controller._componentInfo)
  self._duplicateTip:SetActive(#self._replaceIdxs > 0)
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
  self._prizeTop:SpawnObjects("UIHauteCoutureDrawPrizeItemKR", topItemNum)
  self._prizeBottom:SpawnObjects("UIHauteCoutureDrawPrizeItemKR", #idList - topItemNum)
  local topPools = self._prizeTop:GetAllSpawnList()
  for i = 1, #topPools do
    local item = topPools[i]
    local idx = idList[i]
    item:SetData(idx, self.controller._componentId, false, self.controller.CtxData, table.icontains(self._replaceIdxs, self:_GetOrderId(idx)))
    table.insert(self._allPrizes, item)
  end
  local bottomPoos = self._prizeBottom:GetAllSpawnList()
  for i = 1, #bottomPoos do
    local item = bottomPoos[i]
    local idx = idList[i + topItemNum]
    item:SetData(idx, self.controller._componentId, false, self.controller.CtxData, table.icontains(self._replaceIdxs, self:_GetOrderId(idx)))
    table.insert(self._allPrizes, item)
  end
  if specialIndex then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItemKR")
    item:SetData(specialIndex, self.controller._componentId, true, self.controller.CtxData, table.icontains(self._replaceIdxs, self:_GetOrderId(specialIndex)))
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainKR_Review:_GetOrderId(id)
  if not self._prizes then
    return
  end
  for index, value in ipairs(self._prizes) do
    if value.RewardSortOrder == id then
      return index
    end
  end
end

function UIHauteCoutureDrawMainKR_Review:_RefreshReward()
  self._replaceIdxs = GameGlobal.GetModule(CampaignModule):GetSeniorSkinDuplicateRewardIndexs(self._prizes, self.controller._componentInfo)
  self._duplicateTip:SetActive(#self._replaceIdxs > 0)
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
    self._freeGo:SetActive(0 >= curDrawCost.CostItemCount)
    self._redGo:SetActive(0 >= curDrawCost.CostItemCount)
    self._countParent:SetActive(0 < curDrawCost.CostItemCount)
  end
end

function UIHauteCoutureDrawMainKR_Review:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainKR_Review:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDrawMainKR_Review:HandleDrawBtnClick()
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

function UIHauteCoutureDrawMainKR_Review:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawMainKR_Review:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawMainKR_Review:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawMainKR_Review:drawBtnOnClick")
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
  self.controller._campaign:LoadCampaignInfo(TT, resC, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
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
  self:UnLock("UIHauteCoutureDrawMainKR_Review:drawBtnOnClick")
end

function UIHauteCoutureDrawMainKR_Review:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawMainKR_Review:CheckAndDoEnterAni(TT)
  local key = self:GetEnterAniKey()
  if UnityEngine.PlayerPrefs.HasKey(key) then
    local lastShow = UnityEngine.PlayerPrefs.GetFloat(key)
    local nextRefresh = GameGlobal.GetModule(LoginModule):GetSignRefreshTime()
    if nextRefresh - lastShow < 86400 then
      self._enterAniGo:SetActive(false)
      self:_EnterRoot(TT)
      return
    end
  end
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UnityEngine.PlayerPrefs.SetFloat(key, now)
  self._rootGo:SetActive(false)
  local enterAni = self._enterAniPool:SpawnObject("UIHauteCoutureDrawEnterAni")
  local clipLength = enterAni:GetClipLength()
  YIELD(TT, clipLength * 1000 - 200)
  self._enterAniGo:SetActive(false)
  self:_EnterRoot(TT)
end

function UIHauteCoutureDrawMainKR_Review:_EnterRoot(TT)
  self._rootGo:SetActive(true)
  self._rootAni:Play("uieffanim_UIHauteCoutureDrawMainKR")
  self._videoGo = self:GetGameObject("VideoMask")
  self:_LoadVideo()
end

function UIHauteCoutureDrawMainKR_Review:VideoMaskOnClick(go)
  self:HandleFgBtnClick()
end

function UIHauteCoutureDrawMainKR_Review:VideoMaskOnClick1(go)
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

function UIHauteCoutureDrawMainKR_Review:DuplicateTipOnClick(go)
  self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
end
