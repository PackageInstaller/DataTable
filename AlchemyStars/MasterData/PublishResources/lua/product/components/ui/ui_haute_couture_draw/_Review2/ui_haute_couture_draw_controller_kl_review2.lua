_class("UIHauteCoutureDrawControllerKLReview2", UIController)
UIHauteCoutureDrawControllerKLReview2 = UIHauteCoutureDrawControllerKLReview2

function UIHauteCoutureDrawControllerKLReview2:Constructor()
  self._moneyNumColor = {
    Color(1, 1, 1),
    Color(0.984313725490196, 0.23137254901960785, 0.23137254901960785)
  }
  self._costID = 3000365
  local open_id = GameGlobal.GameLogic():GetOpenId()
  self._openID = "UIHauteCoutureDrawControllerKLReview2" .. open_id
end

function UIHauteCoutureDrawControllerKLReview2:LoadDataOnEnter(TT, res, uiParams)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
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
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self._closed = false
  self._componentId = self._component:GetComponentCfgId()
  self.m_cfg = Cfg.cfg_senior_skin_draw({
    ComponentId = self._componentId
  })[1]
  self._prizes = Cfg.cfg_component_senior_skin_weight({
    ComponentID = self._componentId
  })
  self._drawCost = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId
  })
  self._maxRows = self.m_cfg.PrizeRows
  self._maxCols = self.m_cfg.PrizeCols
  self._specialIdx = self.m_cfg.SpecialIdx
  self._allPrizes = {}
  table.sort(self._prizes, function(a, b)
    return a.RewardSortOrder > b.RewardSortOrder
  end)
end

function UIHauteCoutureDrawControllerKLReview2:_GetBuyGiftComponent()
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  return self._campaign:GetComponent(cmptId)
end

function UIHauteCoutureDrawControllerKLReview2:_GetSeniorSkinComponent()
  local cmptId = ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN
  return self._campaign:GetComponent(cmptId)
end

function UIHauteCoutureDrawControllerKLReview2:OnShow(uiParams)
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._drawDes = self:GetUIComponent("UILocalizationText", "drawDes")
  self._moneyNum = self:GetUIComponent("UILocalizationText", "moneyNum")
  self._moneyIcon = self:GetUIComponent("Image", "moneyIcon")
  self._pools = self:GetUIComponent("UISelectObjectPath", "PrizeList")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._logoImg = self:GetUIComponent("RawImageLoader", "logo")
  self._imgDes = self:GetUIComponent("UILocalizationText", "imgDes")
  self._drawBtnOj = self:GetGameObject("drawbtn")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._countParent = self:GetGameObject("normalSingleGo")
  self._freeGo = self:GetGameObject("free")
  self._probalityBtn = self:GetGameObject("probabilityBtn")
  self._buyBtn = self:GetGameObject("buybtn")
  self._prizeEff = self:GetUIComponent("Transform", "PrizeEff")
  self._prizeEff.gameObject:SetActive(false)
  self._endtime = self:GetUIComponent("UILocalizationText", "endtime")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = itemInfo:SpawnObject("UIHauteSelectInfo")
  self._enterAnim = self:GetUIComponent("Animation", "enterAnim")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._enterAnimObj = self:GetGameObject("enterAnim")
  self._enterAnimObj:SetActive(false)
  self._eff2Obj = self:GetGameObject("eff2")
  self._eff3Obj = self:GetGameObject("eff3")
  self._redGo = self:GetGameObject("redGo")
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtn = btns:SpawnObject("UINewCommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end)
  local currency = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self._topTips = currency:SpawnObject("UINewCurrencyMenu")
  self._topTips:SetData({
    self._costID
  }, false)
  self._seniorSkinItem = self._topTips:GetItemByTypeId(self._costID)
  self._seniorSkinItem:SetAddCallBack(function(id, go)
    self:BuybtnOnClick()
  end)
  self:_LoadVideo()
  self:_OnValue()
  self:_RefreshReward()
  self:CheckAllPrizeCollected()
  self._oldBgm = AudioHelperController.GetCurrentBgm()
  AudioHelperController.PlayBGMById(CriAudioIDConst.BGSeniorSkin, AudioConstValue.BGMCrossFadeTime)
  self:CheckEndTime()
  self._timeTask = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CheckEndTime()
  end)
  self:CheckFirstVedioPlay()
  self:GetGameObject("ImgEdge_LT").transform.position = self:GetGameObject("LeftTop").transform.position
  self:GetGameObject("ImgEdge_RB").transform.position = self:GetGameObject("RightBottom").transform.position
end

function UIHauteCoutureDrawControllerKLReview2:OnUpdate(dtMS)
end

function UIHauteCoutureDrawControllerKLReview2:ItemCountChanged()
  local cfg = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId,
    SeqID = self._componentInfo.shake_num + 1
  })
  local curDrawCost = cfg and cfg[1] or Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId,
    SeqID = self._componentInfo.shake_num
  })[1]
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itemNum = itemModule:GetItemCount(curDrawCost.CostItemID)
  if itemNum >= curDrawCost.CostItemCount then
    self._moneyNum.color = self._moneyNumColor[1]
    self._redGo:SetActive(true)
  else
    self._moneyNum.color = self._moneyNumColor[2]
    self._redGo:SetActive(false)
  end
end

function UIHauteCoutureDrawControllerKLReview2:OnHide()
  if self._tl then
    self._tl:Stop()
    self._tl = nil
  end
  if self._timeTask then
    GameGlobal.Timer():CancelEvent(self._timeTask)
  end
  AudioHelperController.PlayBGMById(self._oldBgm, AudioConstValue.BGMCrossFadeTime)
end

function UIHauteCoutureDrawControllerKLReview2:_OnValue()
  self._drawDes:SetText(StringTable.Get(self.m_cfg.DesStr))
  self._imgDes:SetText(StringTable.Get(self.m_cfg.ImgDes))
end

function UIHauteCoutureDrawControllerKLReview2:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.m_cfg.VideoName .. ".mp4", LoadType.VideoClip)
  Log.debug("[guide movie] move url ", url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHauteCoutureDrawControllerKLReview2")
  self._vp:Play()
  self._vp.loopPointReached = self._vp.loopPointReached + self._LoopPointReached
end

function UIHauteCoutureDrawControllerKLReview2:SetEndTime(timeStr)
  if self._endtime then
    self._endtime:SetText(timeStr)
  end
end

function UIHauteCoutureDrawControllerKLReview2:GetEndTimeColor()
  return "#eb8a35"
end

function UIHauteCoutureDrawControllerKLReview2:CheckEndTime()
  local time = self._componentInfo.m_close_time
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  if time < now then
    local timeStr = StringTable.Get("str_activity_finished")
    self:SetEndTime(timeStr)
    self._timeStr = timeStr
    return true
  else
    local timeStr = HelperProxy:GetInstance():FormatTime_3(time - now, self:GetEndTimeColor())
    if self._timeStr ~= timeStr then
      self:SetEndTime(StringTable.Get("str_senior_skin_draw_end_time", timeStr))
      self._timeStr = timeStr
    end
    return false
  end
  return true
end

function UIHauteCoutureDrawControllerKLReview2:_LoadPrize()
  self._replaceIdxs = self._campaignModule:GetSeniorSkinDuplicateRewardIndexs(self._prizes, self._componentInfo)
  self:GetGameObject("duplicateTip"):SetActive(#self._replaceIdxs > 0)
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
    local index = 10 - idx + 1
    item:SetData(idx, self._componentId, nil, table.icontains(self._replaceIdxs, index), function(id, pos)
      self:ItemClick(id, pos)
    end)
    table.insert(self._allPrizes, item)
  end
  if self._specialIdx then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItem")
    local index = 10 - self._specialIdx + 1
    item:SetData(self._specialIdx, self._componentId, true, table.icontains(self._replaceIdxs, index), function(id, pos)
      self:ItemClick(id, pos)
    end)
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
        self:ShowDialog("UIHauteCoutureDrawDuplicateRewardKL", self._prizes, self._replaceIdxs)
        self:UnLock("UIHauteCoutureDuplicateReward_in")
      end)
    end
  end
end

function UIHauteCoutureDrawControllerKLReview2:ProbabilityBtnOnClick(go)
  if self:CheckEndTime() then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIHauteCoutureDrawDynamicProbablityController", self._prizes, self._componentInfo, self._componentId, self._replaceIdxs)
end

function UIHauteCoutureDrawControllerKLReview2:RuleBtnOnClick(go)
  if self:CheckEndTime() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIHauteCoutureDrawRulesController", false, self._prizes, self._replaceIdxs)
end

function UIHauteCoutureDrawControllerKLReview2:BuybtnOnClick(go)
  if self:CheckEndTime() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeController_Review2", self._buyComponet)
end

function UIHauteCoutureDrawControllerKLReview2:DrawBtnOnClick(go)
  if self:CheckEndTime() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local cfg = Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId,
    SeqID = self._componentInfo.shake_num + 1
  })
  local nextDraw = cfg and cfg[1] or Cfg.cfg_component_senior_skin_cost({
    ComponentID = self._componentId,
    SeqID = self._componentInfo.shake_num
  })[1]
  local id = nextDraw.CostItemID
  if self:GetModule(RoleModule):GetAssetCount(id) < nextDraw.CostItemCount then
    ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_tips"))
    GameGlobal.UIStateManager():ShowDialog("UIHauteCoutureDrawChargeController_Review2", self._buyComponet)
    return
  end
  self:StartTask(self.DrawAnim, self)
end

function UIHauteCoutureDrawControllerKLReview2:_RefreshReward()
  if self._allPrizes then
    for k, v in pairs(self._allPrizes) do
      local itemId = v:GetCfgID()
      local state = table.icontains(self._componentInfo.shake_win_ids, itemId)
      v:Flush(state)
      v:SetGray(false)
    end
  end
  if self._component:AllAwardCollected() then
    self._drawBtnOj:SetActive(false)
  else
    local cfg = Cfg.cfg_component_senior_skin_cost({
      ComponentID = self._componentId,
      SeqID = self._componentInfo.shake_num + 1
    })
    local curDrawCost = cfg and cfg[1] or Cfg.cfg_component_senior_skin_cost({
      ComponentID = self._componentId,
      SeqID = self._componentInfo.shake_num
    })[1]
    local itemCfg = Cfg.cfg_top_tips[curDrawCost.CostItemID]
    if itemCfg then
      self._moneyIcon.sprite = self._uiCommonAtlas:GetSprite(itemCfg.Icon)
    end
    local itemModule = GameGlobal.GetModule(ItemModule)
    local itemNum = itemModule:GetItemCount(curDrawCost.CostItemID)
    if itemNum >= curDrawCost.CostItemCount then
      self._moneyNum.color = self._moneyNumColor[1]
      self._redGo:SetActive(true)
    else
      self._moneyNum.color = self._moneyNumColor[2]
      self._redGo:SetActive(false)
    end
    self._moneyNum:SetText(curDrawCost.CostItemCount)
    self._freeGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._countParent:SetActive(curDrawCost.CostItemCount > 0)
  end
end

function UIHauteCoutureDrawControllerKLReview2:CalculatePrizeProbablity(prizeId, round)
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

function UIHauteCoutureDrawControllerKLReview2:CalculateAllPrizeProbablity()
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

function UIHauteCoutureDrawControllerKLReview2:CalNotGotCurrentPrizeProbablity(prizeId, round)
  local res = 1
  for i = 1, round do
    res = res * (1 - self._allProbablities[prizeId][i])
  end
  return res
end

function UIHauteCoutureDrawControllerKLReview2:CalculateTotalWeight(prizeData, round)
  local total = 0
  for _, v in pairs(prizeData) do
    if round < v.RareLevel then
      total = total + v.Weight
    end
  end
  return total
end

function UIHauteCoutureDrawControllerKLReview2:VideoBtnOnClick(go)
  if self:CheckEndTime() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIHauteVideoController", self.m_cfg)
end

function UIHauteCoutureDrawControllerKLReview2:GetCurrentVideoFrame()
  return self._vp.frame
end

function UIHauteCoutureDrawControllerKLReview2:SetVideoPlay(playing)
  if playing then
    self._vp:Play()
  else
    self._vp:Pause()
  end
end

function UIHauteCoutureDrawControllerKLReview2:CanDrawSpecialAward()
  return self._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawControllerKLReview2:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawControllerKLReview2:drawBtnOnClick")
  self._eff2Obj:SetActive(true)
  local res = AsyncRequestRes:New()
  local result, rewards = self._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawControllerKLReview2:drawBtnOnClick")
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
        if self:CanDrawSpecialAward() then
          table.insert(idxs, idx)
        end
      else
        table.insert(idxs, idx)
      end
      if idx == self._specialIdx then
        item:SetGray(self:CanDrawSpecialAward())
      else
        item:SetGray(false)
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
        self._allPrizes[last]:SetGray(false)
      end
      self._allPrizes[idx]:SetGray(true)
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
  self._campaign:LoadCampaignInfo(TT, resC, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY, ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT, ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  self._campaign:ReLoadCampaignInfo_Force(TT, resC)
  self._buyComponet = self._campaign:GetLocalProcess()._buyGiftComponent
  self._buyComponetInfo = self._campaign:GetLocalProcess()._buyGiftComponentInfo
  self._component = self._campaign:GetLocalProcess()._seniorSkinComponent
  self._componentInfo = self._campaign:GetLocalProcess()._seniorSkinComponentInfo
  if self._componentInfo.shake_num == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestUpdate)
  end
  local cfg = Cfg.cfg_component_senior_skin_weight[rewards]
  if not cfg then
    Log.error("###[UIHauteCoutureDraw_Review] cfg is nil ! id --> ", rewards)
    return
  end
  local reawrdList = {}
  local reward = RoleAsset:New()
  local isReplace = false
  for idx, v in ipairs(self._prizes) do
    if v.ID == rewards then
      isReplace = table.icontains(self._replaceIdxs, idx)
      break
    end
  end
  if isReplace then
    reward.assetid = cfg.ReplaceRewardID
    reward.count = cfg.ReplaceRewardCount
  else
    reward.assetid = cfg.RewardID
    reward.count = cfg.RewardCount
  end
  table.insert(reawrdList, reward)
  if cfg.AppendGlow and 0 < cfg.AppendGlow then
    local rewardGp = RoleAsset:New()
    rewardGp.assetid = RoleAssetID.RoleAssetGlow
    rewardGp.count = cfg.AppendGlow
    table.insert(reawrdList, rewardGp)
  end
  if self._specialIdx == targetidx then
    local skin = KLRoleAsset:New()
    skin.assetid = cfg.RewardID - 4000000
    skin.count = cfg.RewardCount
    local unlockCgId
    local skinCfg = Cfg.cfg_pet_skin[skin.assetid]
    if skinCfg then
      unlockCgId = skinCfg.ImmediateCgId
    end
    self:Lock("UIHauteCoutureDrawControllerKLReview2_eff3Obj")
    self._eff3Obj:SetActive(true)
    YIELD(TT, 1000)
    self:UnLock("UIHauteCoutureDrawControllerKLReview2_eff3Obj")
    self:ShowDialog("UIPetSkinObtainController", skin, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
      self:ShowDialog("UIHauteCoutureGetItemController", reawrdList, nil, true, function()
        self._eff3Obj:SetActive(false)
        self:_RefreshReward()
        self:CheckAllPrizeCollected()
        if unlockCgId then
          local cfg_cg = Cfg.cfg_cg_book[unlockCgId]
          if cfg_cg then
            self:ShowDialog("UIPetSkinsGetCgController", cfg_cg.StaticPic, false, skinCfg.CgId, 1)
          end
          ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_new_cg_tips"))
        end
      end)
    end)
  else
    self:ShowDialog("UIHauteCoutureGetItemController", reawrdList, nil, true, function()
      self:_RefreshReward()
      self:CheckAllPrizeCollected()
    end)
  end
  self._eff2Obj:SetActive(false)
  self:UnLock("UIHauteCoutureDrawControllerKLReview2:drawBtnOnClick")
end

function UIHauteCoutureDrawControllerKLReview2:CheckAllPrizeCollected()
  if self._componentInfo.shake_num == 10 then
    local currency = self._topTips:GetItemByTypeId(self._costID)
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawControllerKLReview2:ItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

function UIHauteCoutureDrawControllerKLReview2:CheckFirstVedioPlay()
  self:StartTask(function(TT)
    if self._campaign and self._campaign:CheckCampaignNew() then
      self._campaign:ClearCampaignNew(TT)
      self:Lock("UIHauteCoutureDrawControllerKLReview2_UIHauteCoutureDrawEnterGL")
      self._enterAnimObj:SetActive(true)
      self._enterAnim:Play("UIHauteCoutureDrawEnterGL")
      YIELD(TT, 2800)
      self._enterAnimObj:SetActive(false)
      self:UnLock("UIHauteCoutureDrawControllerKLReview2_UIHauteCoutureDrawEnterGL")
    end
    self:Lock("UIHauteCoutureDrawControllerKLReview2N5_BG_in")
    self._anim:Play("UIHauteCoutureDrawControllerKLReview2N5_BG_in")
    self:_LoadPrize()
    YIELD(TT, 600)
    self:UnLock("UIHauteCoutureDrawControllerKLReview2N5_BG_in")
  end)
end

function UIHauteCoutureDrawControllerKLReview2:DuplicateTipOnClick()
  self:ShowDialog("UIHauteCoutureDrawDuplicateRewardKL", self._prizes, self._replaceIdxs)
end
