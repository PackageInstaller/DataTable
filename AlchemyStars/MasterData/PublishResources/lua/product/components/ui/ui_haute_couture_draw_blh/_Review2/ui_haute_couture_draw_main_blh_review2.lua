_class("UIHauteCoutureDrawMainBLH_Review2", UIHauteCoutureDrawBase)
UIHauteCoutureDrawMainBLH_Review2 = UIHauteCoutureDrawMainBLH_Review2

function UIHauteCoutureDrawMainBLH_Review2:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
  local open_id = GameGlobal.GameLogic():GetOpenId()
  self._openID = "UIHauteCoutureDrawMainBLH_Review2" .. open_id
end

function UIHauteCoutureDrawMainBLH_Review2:CloseSelf()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  self.controller:CloseDialog()
end

function UIHauteCoutureDrawMainBLH_Review2:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:CheckFirstVedioPlay()
end

function UIHauteCoutureDrawMainBLH_Review2:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
end

function UIHauteCoutureDrawMainBLH_Review2:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "LashShowCoutureEnter"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDrawMainBLH_Review2:InitWidgets()
  self:InitWidgetsBase()
  self._prizeBottom = self:GetUIComponent("UISelectObjectPath", "PrizeListBottom")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._rootGo = self:GetGameObject("Root")
  self._rootAni = self:GetUIComponent("Animation", "RootAni")
  self.drawTitle = self:GetUIComponent("RollingText", "drawTitle")
  self._pause = self:GetGameObject("pause")
  local selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = selectInfoPool:SpawnObject("UISelectInfo")
  local spineBgPool = self:GetUIComponent("UISelectObjectPath", "spineBg")
  self._spineBg = spineBgPool:SpawnObject("UISpineBg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._enterAniPool = self:GetUIComponent("UISelectObjectPath", "EnterAnimation")
  self._enterAniGo = self:GetGameObject("EnterAnimation")
  self._enterAniGo:SetActive(false)
  self._backBtn:SetData(function()
    self:CloseSelf()
  end, function()
    self:HandleRuleBtnClick()
  end, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshSeniorSkinRedPoint)
  end)
  self._backBtn:GetGameObject("ButtonHelp"):SetActive(true)
end

function UIHauteCoutureDrawMainBLH_Review2:GetCoinId()
  return self.controller.CtxData:CostItemID()
end

function UIHauteCoutureDrawMainBLH_Review2:GetSkinId()
  return self.controller.CtxData:GetSkinId()
end

function UIHauteCoutureDrawMainBLH_Review2:_OnValue()
  self.drawTitle:RefreshText(StringTable.Get("str_senior_skin_draw_des_gl"))
  local skinId = self:GetSkinId()
  if skinId then
    self._spineBg:SetData(skinId)
  end
end

function UIHauteCoutureDrawMainBLH_Review2:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.MiniVideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
  self._playing = true
  self._pause:SetActive(not self._playing)
end

function UIHauteCoutureDrawMainBLH_Review2:LoadVideo(url)
  Log.debug("[guide movie] move url ", url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
  self._rt = UnityEngine.RenderTexture:New(339, 190, 16)
  self._rawImage.texture = self._rt
  self._vp.targetTexture = self._rt
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawV2ReviewController")
  self._vp:Play()
  self._vp.frame = 0
  GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawV2ReviewController"):Render()
end

function UIHauteCoutureDrawMainBLH_Review2:_LoadPrize()
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
  self._prizeBottom:SpawnObjects("UIHauteCoutureDrawPrizeItemBLHReview2", #idList)
  local bottomPoos = self._prizeBottom:GetAllSpawnList()
  for i = 1, #bottomPoos do
    local item = bottomPoos[i]
    local sortOrder = idList[i]
    local idx = 10 - sortOrder + 1
    item:SetData(sortOrder, self.controller._componentId, false, ctx, table.icontains(self._replaceIdxs, idx), function(id, pos)
      self._selectInfo:SetData(id, pos)
    end)
    table.insert(self._allPrizes, item)
  end
  if specialIndex then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItemBLHReview2")
    local sortOrder = 10
    item:SetData(sortOrder, self.controller._componentId, true, ctx, table.icontains(self._replaceIdxs, specialIndex))
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
  self:GetGameObject("duplicateTip"):SetActive(#self._replaceIdxs > 0)
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

function UIHauteCoutureDrawMainBLH_Review2:_RefreshReward()
  if self._allPrizes then
    for k, v in pairs(self._allPrizes) do
      local itemId = v:GetCfgID()
      local state = table.icontains(self.controller._componentInfo.shake_win_ids, itemId)
      v:Flush(state)
      v:SetGray(true)
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

function UIHauteCoutureDrawMainBLH_Review2:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainBLH_Review2:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDrawMainBLH_Review2:HandleDrawBtnClick()
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

function UIHauteCoutureDrawMainBLH_Review2:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawMainBLH_Review2:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawMainBLH_Review2:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawMainBLH_Review2:drawBtnOnClick")
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
        item:SetBlack(self:CanDrawSpecialAward())
      else
        item:SetGray(true)
      end
    else
      item:SetGray(true)
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
  local yieldTime = self._allPrizes[targetidx]:PlayGetAnim()
  self:StartTask(function(TT)
    YIELD(TT, yieldTime)
    if self._allPrizes[targetidx]:IsHauteCouture() then
      local skin = RoleAsset:New()
      skin.assetid = weightCfg.RewardID - RoleAssetID.RoleAssetPetSkinBegin
      skin.count = weightCfg.RewardCount
      local unlockCgId
      local skinCfg = Cfg.cfg_pet_skin[skin.assetid]
      if skinCfg then
        unlockCgId = skinCfg.ImmediateCgId
      end
      self:ShowDialog("UIPetSkinObtainController", skin, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
        self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
          self:_RefreshReward()
          self:CheckAllPrizeCollected()
          self:_RefreshItemGray()
          if unlockCgId then
            local cfg_cg = Cfg.cfg_cg_book[unlockCgId]
            if cfg_cg then
              self:ShowDialog("UIPetSkinsGetCgController", cfg_cg.StaticPic, false, skinCfg.CgId, 1)
            end
            ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_new_cg_tips"))
          end
        end, self.controller.CtxData)
      end)
    else
      self:StartTask(function(TT)
        self:Lock("UIHauteCoutureDrawGetItemV2Controller_inAnim")
        YIELD(TT, 334)
        self:UnLock("UIHauteCoutureDrawGetItemV2Controller_inAnim")
      end)
      self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
        self:_RefreshReward()
        self:CheckAllPrizeCollected()
        self:_RefreshItemGray()
      end, self.controller.CtxData)
    end
  end)
  self:UnLock("UIHauteCoutureDrawMainBLH_Review2:drawBtnOnClick")
end

function UIHauteCoutureDrawMainBLH_Review2:_RefreshItemGray()
  for _, price in pairs(self._allPrizes) do
    price:SetBlack(true)
  end
end

function UIHauteCoutureDrawMainBLH_Review2:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawMainBLH_Review2:VideoMaskOnClick(go)
  self:HandleFgBtnClick()
end

function UIHauteCoutureDrawMainBLH_Review2:VideoMaskOnClick1(go)
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

function UIHauteCoutureDrawMainBLH_Review2:CheckEndTime()
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

function UIHauteCoutureDrawMainBLH_Review2:DuplicateTipOnClick()
  self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
end

function UIHauteCoutureDrawMainBLH_Review2:CheckFirstVedioPlay()
  self:StartTask(function(TT)
    local campaign = self.controller._campaign
    if campaign and campaign:CheckCampaignNew() then
      campaign:ClearCampaignNew(TT)
      self._enterAniGo:SetActive(true)
      self:Lock("UIHauteCoutureDrawMainBLH_Review2_CheckFirstVedioPlay")
      self._enterAniPool:SpawnObject("UIHauteCoutureDrawEnterAni")
      YIELD(TT, 2200)
      self:StartTask(function(YY)
        self:PlayInAnim(YY)
      end)
      YIELD(TT, 750)
      self._enterAniGo:SetActive(false)
      self:UnLock("UIHauteCoutureDrawMainBLH_Review2_CheckFirstVedioPlay")
    else
      self:PlayInAnim(TT)
    end
  end)
end

function UIHauteCoutureDrawMainBLH_Review2:PlayInAnim(TT)
  self:Lock("uianim_UIHauteCoutureDrawMainBLH_Review2_in")
  self._anim:Play("uianim_UIHauteCoutureDrawMainBLH_Review2_in")
  self:_LoadPrize()
  self:CheckAllPrizeCollected()
  self:_LoadVideo()
  YIELD(TT, 2667)
  self:UnLock("uianim_UIHauteCoutureDrawMainBLH_Review2_in")
end
