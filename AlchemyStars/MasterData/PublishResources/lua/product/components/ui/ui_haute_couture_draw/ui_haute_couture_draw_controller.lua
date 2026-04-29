_class("UIHauteCoutureDrawController", UIController)
UIHauteCoutureDrawController = UIHauteCoutureDrawController

function UIHauteCoutureDrawController:Constructor()
end

function UIHauteCoutureDrawController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._buyComponet = self._campaign:GetLocalProcess()._buyGiftComponent
  self._buyComponetInfo = self._campaign:GetLocalProcess()._buyGiftComponentInfo
  self._component = self._campaign:GetLocalProcess()._seniorSkinComponent
  self._componentInfo = self._campaign:GetLocalProcess()._seniorSkinComponentInfo
  local time = self._componentInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    res:SetSucc(false)
    return
  end
  self._closed = false
  self._componentId = self._component:GetComponentCfgId()
  self._cfg = Cfg.cfg_senior_skin_draw({
    ComponentId = self._componentId
  })[1]
  self._prizes = Cfg.cfg_component_senior_skin_weight({
    ComponentID = self._componentId
  })
  self._drawCost = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId
  })
  self._maxRows = self._cfg.PrizeRows
  self._maxCols = self._cfg.PrizeCols
  self._specialIdx = self._cfg.SpecialIdx
  self._allPrizes = {}
  table.sort(self._prizes, function(a, b)
    return a.RewardSortOrder > b.RewardSortOrder
  end)
end

function UIHauteCoutureDrawController:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIHauteCoutureDrawController:_GetSeniorSkinComponent()
  local cmptId = ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN
  return self._campaign:GetComponent(cmptId)
end

function UIHauteCoutureDrawController:OnShow(uiParams)
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._drawDes = self:GetUIComponent("UILocalizationText", "drawDes")
  self._drawTitle = self:GetUIComponent("UILocalizedTMP", "drawTitle")
  self._moneyNum = self:GetUIComponent("UILocalizationText", "moneyNum")
  self._moneyIcon = self:GetUIComponent("Image", "moneyIcon")
  self._pools = self:GetUIComponent("UISelectObjectPath", "PrizeList")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._logoImg = self:GetUIComponent("RawImageLoader", "logo")
  self._imgDes = self:GetUIComponent("UILocalizationText", "imgDes")
  self._drawBtnOj = self:GetGameObject("drawbtn")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._endTime = self:GetUIComponent("UILocalizationText", "endtime")
  self._countParent = self:GetGameObject("normalSingleGo")
  self._freeGo = self:GetGameObject("free")
  self._probalityBtn = self:GetGameObject("probabilityBtn")
  self._buyBtn = self:GetGameObject("buybtn")
  self._prizeEff = self:GetUIComponent("Transform", "PrizeEff")
  self._prizeEff.gameObject:SetActive(false)
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end)
  local currency = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self._topTips = currency:SpawnObject("UICurrencyMenu")
  self._topTips:SetData({
    RoleAssetID.RoleAssetDrawCardSeniorSkin
  }, false)
  self._seniorSkinItem = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetDrawCardSeniorSkin)
  self._seniorSkinItem:SetAddCallBack(function(id, go)
    self:buybtnOnClick()
  end)
  self:_LoadVideo()
  self:_LoadPrize()
  self:_OnValue()
  self:_RefreshReward()
  self._timer = 0
  self:checkEndTime()
  self:playAnim()
  self:checkAllPrizeCollected()
  self._oldBgm = AudioHelperController.GetCurrentBgm()
  AudioHelperController.PlayBGMById(CriAudioIDConst.BGSeniorSkin, AudioConstValue.BGMCrossFadeTime)
end

function UIHauteCoutureDrawController:OnUpdate(dtMS)
  if not self._closed then
    self._timer = self._timer + dtMS
    if self._timer > 1000 then
      self._timer = 0
      self:checkEndTime()
    end
  end
  if self._tl then
    self._tl:Update(dtMS)
    if self._tl:Over() then
      self._tl:Start()
    end
  end
end

function UIHauteCoutureDrawController:OnHide()
  if self._tl then
    self._tl:Stop()
    self._tl = nil
  end
  AudioHelperController.PlayBGMById(self._oldBgm, AudioConstValue.BGMCrossFadeTime)
end

function UIHauteCoutureDrawController:_OnValue()
  self._logoImg:LoadImage(self._cfg.LogoName)
  self._bg:LoadImage(self._cfg.BgName)
  self._drawTitle:SetText(StringTable.Get(self._cfg.TitleStr))
  self._drawTitle.color = Color.white
  local mat = self:GetAsset("ui_campaign_senior_skin_title.mat", LoadType.Mat)
  local old = self._drawTitle.fontMaterial
  self._drawTitle.fontMaterial = mat
  self._drawTitle.fontMaterial:SetTexture("_MainTex", old:GetTexture("_MainTex"))
  self._drawDes:SetText(StringTable.Get(self._cfg.DesStr))
  self._imgDes:SetText(StringTable.Get(self._cfg.ImgDes))
end

function UIHauteCoutureDrawController:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self._cfg.VideoName .. ".mp4", LoadType.VideoClip)
  Log.debug("[guide movie] move url ", url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawController")
  self._vp:Play()
  self._vp.loopPointReached = self._vp.loopPointReached + self._LoopPointReached
end

function UIHauteCoutureDrawController:_LoadPrize()
  local currentRowPrizeCount = 0
  local idList = {}
  for i = 1, table.count(self._prizes) do
    table.insert(idList, i)
  end
  if self._specialIdx then
    table.remove(idList, self._specialIdx)
  end
  self._pools:SpawnObjects("UIHauteCoutureDrawPrizeItem", #idList)
  local pools = self._pools:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local idx = idList[i]
    item:SetData(idx, self._componentId)
    table.insert(self._allPrizes, item)
  end
  if self._specialIdx then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItem")
    item:SetData(self._specialIdx, self._componentId, true)
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
end

function UIHauteCoutureDrawController:probabilityBtnOnClick(go)
  self:ShowDialog("UIHauteCoutureDrawDynamicProbablityController", self._prizes, self._componentInfo, self._componentId)
end

function UIHauteCoutureDrawController:rulebtnOnClick(go)
  if self._closed then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UIHauteCoutureDrawRulesController", false, self._prizes)
end

function UIHauteCoutureDrawController:buybtnOnClick(go)
  if self._closed then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeController", self._buyComponet)
end

function UIHauteCoutureDrawController:drawBtnOnClick(go)
  if self._closed then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  local nextDraw = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId,
    SeqID = self._componentInfo.shake_num + 1
  })[1]
  local id = nextDraw.CostItemID
  if self:GetModule(RoleModule):GetAssetCount(id) < nextDraw.CostItemCount then
    ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_tips"))
    GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeController", self._buyComponet)
    return
  end
  self:StartTask(self.drawAnim, self)
end

function UIHauteCoutureDrawController:_RefreshReward()
  if self._allPrizes then
    for k, v in pairs(self._allPrizes) do
      local state = table.icontains(self._componentInfo.shake_win_ids, k)
      v:Flush(state)
      v:SetGray(false)
    end
  end
  if self._component:AllAwardCollected() then
    self._drawBtnOj:SetActive(false)
  else
    local curDrawCost = Cfg.cfg_component_senior_skin_cost({
      ComponentID = self._componentId,
      SeqID = self._componentInfo.shake_num + 1
    })[1]
    local itemCfg = Cfg.cfg_top_tips[curDrawCost.CostItemID]
    if itemCfg then
      self._moneyIcon.sprite = self._uiCommonAtlas:GetSprite(itemCfg.Icon)
    end
    self._moneyNum:SetText(curDrawCost.CostItemCount)
    self._freeGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._countParent:SetActive(curDrawCost.CostItemCount > 0)
  end
end

function UIHauteCoutureDrawController:CalculatePrizeProbablity(prizeId, round)
  local prizeData = Cfg.cfg_component_senior_skin_weight({
    ComponentID = self._componentId,
    RewardID = prizeId
  })[1]
  local weight = prizeData.weight
  local rarelevel = prizeData.RareLevel
  if round < rarelevel then
    return "0.00%"
  else
  end
end

function UIHauteCoutureDrawController:CalculateAllPrizeProbablity()
  local prizeData = Cfg.cfg_component_senior_skin_weight({})
  self._allProbablities = {}
  local currentRound = 1
  for i = 1, #prizeData do
    for k, v in paris(prizeData) do
      if currentRound < v.RareLevel then
        if self._allProbablities[k] == nil then
          self._allProbablities[k] = {}
        end
        self._allProbablities[k][i] = "0.00%"
      elseif i == 1 then
        self._allProbablities[k][i] = v.weight / self:CalculateTotalWeight(prizeData, currentRound) * 100 .. "%"
      else
        self:CalNotGotCurrentPrizeProbablity(k, currentRound)
      end
    end
  end
end

function UIHauteCoutureDrawController:CalNotGotCurrentPrizeProbablity(prizeId, round)
  local res = 1
  for i = 1, round do
    res = res * (1 - self._allProbablities[prizeId][i])
  end
  return res
end

function UIHauteCoutureDrawController:CalculateTotalWeight(prizeData, round)
  local total = 0
  for _, v in pairs(prizeData) do
    if round < v.RareLevel then
      total = total + v.Weight
    end
  end
  return total
end

function UIHauteCoutureDrawController:checkEndTime()
  local time = self._componentInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    local timeStr = StringTable.Get("str_activity_finished")
    self._endTime:SetText(timeStr)
    self._timeStr = timeStr
    self._closed = true
  else
    local timeStr = HelperProxy:GetInstance():FormatTime_3(time - now)
    if self._timeStr ~= timeStr then
      self._endTime:SetText(StringTable.Get("str_senior_skin_draw_end_time", timeStr))
      self._timeStr = timeStr
    end
    self._closed = false
  end
end

function UIHauteCoutureDrawController:fgOnClick(go)
  self:ShowDialog("UIHauteVideoController", self._cfg)
end

function UIHauteCoutureDrawController:GetCurrentVideoFrame()
  return self._vp.frame
end

function UIHauteCoutureDrawController:SetVideoPlay(playing)
  if playing then
    self._vp:Play()
  else
    self._vp:Pause()
  end
end

function UIHauteCoutureDrawController:playAnim()
  local rect1 = self:GetUIComponent("RectTransform", "bg1")
  local rect2 = self:GetUIComponent("RectTransform", "bg2")
  local image1 = self:GetUIComponent("RawImageLoader", "bg1")
  local image2 = self:GetUIComponent("RawImageLoader", "bg2")
  local griphic2 = self:GetUIComponent("RawImage", "bg2")
  image1:LoadImage("senior_pray1_cg1600064")
  image2:LoadImage("senior_pray2_cg1600064")
  griphic2.color = Color(1, 1, 1, 0)
  self._isFirst = true
  self._tl = EZTL_Sequence:New({
    EZTL_Wait:New(4000),
    EZTL_Callback:New(function()
      if self._isFirst then
        rect2.anchoredPosition = Vector2(486, 0)
        image1:LoadImage("senior_pray1_cg1600064")
        image2:LoadImage("senior_pray2_cg1600064")
        griphic2.color = Color(1, 1, 1, 0)
        self._isFirst = false
      else
        rect2.anchoredPosition = Vector2(486, 0)
        image1:LoadImage("senior_pray2_cg1600064")
        image2:LoadImage("senior_pray1_cg1600064")
        griphic2.color = Color(1, 1, 1, 0)
        self._isFirst = true
      end
    end),
    EZTL_Parallel:New({
      EZTL_AnchorMove:New(rect2, Vector2(466, 0), 1000),
      EZTL_AlphaTween:New(griphic2, 1, 1000)
    }, nil, nil)
  })
  self._tl:Start()
end

function UIHauteCoutureDrawController:canDrawSpecialAward()
  return self._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawController:drawAnim(TT)
  self:Lock("UIHauteCoutureDrawController:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawController:drawBtnOnClick")
    return
  end
  Log.debug("高级时装抽奖结果:", rewards)
  local targetid = rewards
  local collectedAwards = {}
  for _, id in pairs(self._componentInfo.shake_win_ids) do
    collectedAwards[id] = true
  end
  local targetidx
  local idxs = {}
  for idx, item in ipairs(self._allPrizes) do
    local id = item:GetCfgID()
    if not collectedAwards[id] then
      if id == targetid then
        targetidx = idx
      elseif idx == self._specialIdx then
        if self:canDrawSpecialAward() then
          table.insert(idxs, idx)
        end
      else
        table.insert(idxs, idx)
      end
      if idx == self._specialIdx then
        item:SetGray(self:canDrawSpecialAward())
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
  self._campaign = UIActivityCampaign:New()
  local resC = AsyncRequestRes:New()
  self._campaign:LoadCampaignInfo(TT, resC, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  self._campaign:ReLoadCampaignInfo_Force(TT, resC)
  self._buyComponet = self._campaign:GetLocalProcess()._buyGiftComponent
  self._buyComponetInfo = self._campaign:GetLocalProcess()._buyGiftComponentInfo
  self._component = self._campaign:GetLocalProcess()._seniorSkinComponent
  self._componentInfo = self._campaign:GetLocalProcess()._seniorSkinComponentInfo
  if self._componentInfo.shake_num == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
  end
  local _cfg = Cfg.cfg_component_senior_skin_weight[rewards]
  if not _cfg then
    Log.error("###[UIHauteCoutureDrawController] cfg is nil ! id --> ", rewards)
    return
  end
  local reawrdList = {}
  local reward = RoleAsset:New()
  reward.assetid = _cfg.RewardID
  reward.count = _cfg.RewardCount
  table.insert(reawrdList, reward)
  if _cfg.AppendGlow and 0 < _cfg.AppendGlow then
    local rewardGp = RoleAsset:New()
    rewardGp.assetid = RoleAssetID.RoleAssetGlow
    rewardGp.count = _cfg.AppendGlow
    table.insert(reawrdList, rewardGp)
  end
  if self._specialIdx == targetid then
    local skin = RoleAsset:New()
    skin.assetid = _cfg.RewardID - 4000000
    skin.count = _cfg.RewardCount
    self:ShowDialog("UIPetSkinObtainController", skin, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
      self:ShowDialog("UIHauteCoutureGetItemController", reawrdList, nil, true, function()
        self:_RefreshReward()
        self:checkAllPrizeCollected()
      end)
    end)
  else
    self:ShowDialog("UIHauteCoutureGetItemController", reawrdList, nil, true, function()
      self:_RefreshReward()
      self:checkAllPrizeCollected()
    end)
  end
  self:UnLock("UIHauteCoutureDrawController:drawBtnOnClick")
end

function UIHauteCoutureDrawController:checkAllPrizeCollected()
  if self._component:AllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetDrawCardSeniorSkin)
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
    local desRect = self._imgDes:GetComponent(typeof(UnityEngine.RectTransform))
    desRect.anchoredPosition = Vector2(desRect.anchoredPosition.x, 186)
  end
end
