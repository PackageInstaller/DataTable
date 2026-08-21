_class("UIHauteCoutureDrawMainGL_Review", UIHauteCoutureDrawBase)
UIHauteCoutureDrawMainGL_Review = UIHauteCoutureDrawMainGL_Review

function UIHauteCoutureDrawMainGL_Review:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
end

function UIHauteCoutureDrawMainGL_Review:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:_LoadPrize()
  self:CheckAllPrizeCollected()
  self:StartTask(self.CheckAndDoEnterAni, self)
end

function UIHauteCoutureDrawBgGL:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
end

function UIHauteCoutureDrawMainGL_Review:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "LashShowCoutureEnter"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDrawMainGL_Review:InitWidgets()
  self:InitWidgetsBase()
  self._prizeTop = self:GetUIComponent("UISelectObjectPath", "PrizeListTop")
  self._prizeBottom = self:GetUIComponent("UISelectObjectPath", "PrizeListBottom")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._rootGo = self:GetGameObject("Root")
  self._rootAni = self:GetUIComponent("Animation", "RootAni")
  self._enterAniPool = self:GetUIComponent("UISelectObjectPath", "EnterAnimation")
  self._enterAniGo = self:GetGameObject("EnterAnimation")
  self.drawTitle = self:GetUIComponent("RollingText", "drawTitle")
end

function UIHauteCoutureDrawMainGL_Review:GetCoinId()
  return RoleAssetID.RoleAssetDrawCardSeniorSkinGL_Re
end

function UIHauteCoutureDrawMainGL_Review:_OnValue()
  self.drawTitle:RefreshText(StringTable.Get("str_senior_skin_draw_des_gl"))
end

function UIHauteCoutureDrawMainGL_Review:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.VideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
end

function UIHauteCoutureDrawMainGL_Review:_LoadPrize()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local ctx = campaignModule:GetCurHauteCouture_Review()
  self._componentId = self.controller._componentId
  self._componentInfo = self.controller._componentInfo
  self._prizes = Cfg.cfg_component_senior_skin_weight({
    ComponentID = self._componentId
  })
  table.sort(self._prizes, function(a, b)
    return a.RewardSortOrder > b.RewardSortOrder
  end)
  self._replaceIdxs = campaignModule:GetSeniorSkinDuplicateRewardIndexs(self._prizes, self._componentInfo)
  local specialIndex = 1
  local prizes = self.controller._prizes
  local idList = {}
  for i = 1, table.count(prizes) do
    local prize = prizes[i]
    local specailPrizeOrder = 10
    if specailPrizeOrder ~= prize.RewardSortOrder then
      table.insert(idList, prize.RewardSortOrder)
    end
  end
  local topItemNum = 3
  self._prizeTop:SpawnObjects("UIHauteCoutureDrawPrizeItemGL", topItemNum)
  self._prizeBottom:SpawnObjects("UIHauteCoutureDrawPrizeItemGL", #idList - topItemNum)
  local topPools = self._prizeTop:GetAllSpawnList()
  for i = 1, #topPools do
    local item = topPools[i]
    local sortOrder = idList[i]
    local idx = 10 - sortOrder + 1
    item:SetData(sortOrder, self.controller._componentId, false, ctx, table.icontains(self._replaceIdxs, idx))
    table.insert(self._allPrizes, item)
  end
  local bottomPoos = self._prizeBottom:GetAllSpawnList()
  for i = 1, #bottomPoos do
    local item = bottomPoos[i]
    local sortOrder = idList[i + topItemNum]
    local idx = 10 - sortOrder + 1
    item:SetData(sortOrder, self.controller._componentId, false, ctx, table.icontains(self._replaceIdxs, idx))
    table.insert(self._allPrizes, item)
  end
  if specialIndex then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItemGL")
    local sortOrder = 10
    item:SetData(sortOrder, self.controller._componentId, true, ctx, table.icontains(self._replaceIdxs, specialIndex))
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
  self:GetGameObject("duplicateTip"):SetActive(#self._replaceIdxs > 0)
end

function UIHauteCoutureDrawMainGL_Review:_RefreshReward()
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

function UIHauteCoutureDrawMainGL_Review:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainGL_Review:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDrawMainGL_Review:HandleDrawBtnClick()
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
    ToastManager.ShowToast(StringTable.Get("str_item_not_enough_gl"))
    GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeV2Controller", self.controller.hcType, self.controller._buyComponet, self.controller.CtxData)
    return
  end
  self:StartTask(self.DrawAnim, self)
end

function UIHauteCoutureDrawMainGL_Review:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawMainGL_Review:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawMainGL_Review:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawMainGL_Review:drawBtnOnClick")
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
      elseif item:IsSpecailPrize() then
        if self:CanDrawSpecialAward() then
          table.insert(idxs, idx)
        end
      else
        table.insert(idxs, idx)
      end
      if item:IsSpecailPrize() then
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
  if self._allPrizes[targetidx]:IsHauteCouture() then
    local skin = RoleAsset:New()
    skin.assetid = weightCfg.RewardID - RoleAssetID.RoleAssetPetSkinBegin
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
  self:UnLock("UIHauteCoutureDrawMainGL_Review:drawBtnOnClick")
end

function UIHauteCoutureDrawMainGL_Review:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawMainGL_Review:CheckAndDoEnterAni(TT)
  local key = self:GetEnterAniKey()
  if UnityEngine.PlayerPrefs.HasKey(key) then
    local lastShow = UnityEngine.PlayerPrefs.GetFloat(key)
    local nextRefresh = GameGlobal.GetModule(LoginModule):GetSignRefreshTime()
    if nextRefresh - lastShow < 86400 then
      self._enterAniGo:SetActive(false)
      self:_EnterRoot()
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
  self:_EnterRoot()
end

function UIHauteCoutureDrawMainGL_Review:_EnterRoot()
  self._rootGo:SetActive(true)
  self._rootAni:Play("UIHauteCoutureDrawMainGL")
  self:_LoadVideo()
end

function UIHauteCoutureDrawMainGL_Review:DuplicateTipOnClick()
  self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
end
