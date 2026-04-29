require("ui_haute_couture_draw_base")
_class("UIHauteCoutureDraw_QT_Main_Review", UIHauteCoutureDrawBase)
UIHauteCoutureDraw_QT_Main_Review = UIHauteCoutureDraw_QT_Main_Review

function UIHauteCoutureDraw_QT_Main_Review:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
end

function UIHauteCoutureDraw_QT_Main_Review:CloseSelf()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  self.controller:CloseDialog()
end

function UIHauteCoutureDraw_QT_Main_Review:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AttachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  self:StartTask(self.CheckAndDoEnterAni, self)
end

function UIHauteCoutureDraw_QT_Main_Review:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.ItemCountChanged)
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
end

function UIHauteCoutureDraw_QT_Main_Review:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "LashShowCoutureEnter"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDraw_QT_Main_Review:InitWidgets()
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
  local spineBgPool = self:GetUIComponent("UISelectObjectPath", "spineBg")
  self._spineBg = spineBgPool:SpawnObject("UISpineBg")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectinfo")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self._selectInfo:SetType(3)
  local detailObj = self._selectInfo:GetG3CustomPool()
  detailObj.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDraw_QT_GetItemCellDetail.prefab")
  self._selectDetail = detailObj:SpawnObject("UIHauteCoutureDraw_QT_GetItemCellDetail")
  self._prizeStartEffGo = self:GetGameObject("PrizeStartEff")
end

function UIHauteCoutureDraw_QT_Main_Review:GetCoinId()
  return self.controller.CtxData:CostItemID()
end

function UIHauteCoutureDraw_QT_Main_Review:_OnValue()
  self.drawTitle:RefreshText(StringTable.Get("str_senior_skin_draw_des_gl"))
  local skinId = self:GetSkinId()
  if skinId then
    self._spineBg:SetData(self:GetSkinId())
  end
end

function UIHauteCoutureDraw_QT_Main_Review:GetSkinId()
  return 91484
end

function UIHauteCoutureDraw_QT_Main_Review:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.MiniVideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
  self._playing = true
  self._pause:SetActive(not self._playing)
end

function UIHauteCoutureDraw_QT_Main_Review:LoadVideo(url)
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

function UIHauteCoutureDraw_QT_Main_Review:_LoadPrize()
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
  self._prizeTop:SpawnObjects("UIHauteCoutureDraw_QT_PrizeItem_Review", topItemNum)
  self._prizeBottom:SpawnObjects("UIHauteCoutureDraw_QT_PrizeItem_Review", #idList - topItemNum)
  local topPools = self._prizeTop:GetAllSpawnList()
  for i = 1, #topPools do
    local item = topPools[i]
    local sortOrder = idList[i]
    local idx = 10 - sortOrder + 1
    item:SetData(sortOrder, self.controller._componentId, false, ctx, table.icontains(self._replaceIdxs, idx))
    item:SetClickCb(function(itemId, pos)
      self:ShowItemInfo(itemId, pos)
    end)
    table.insert(self._allPrizes, item)
  end
  local bottomPoos = self._prizeBottom:GetAllSpawnList()
  for i = 1, #bottomPoos do
    local item = bottomPoos[i]
    local sortOrder = idList[i + topItemNum]
    local idx = 10 - sortOrder + 1
    item:SetData(sortOrder, self.controller._componentId, false, ctx, table.icontains(self._replaceIdxs, idx))
    item:SetClickCb(function(itemId, pos)
      self:ShowItemInfo(itemId, pos)
    end)
    table.insert(self._allPrizes, item)
  end
  if specialIndex then
    local item = self._specialItem:SpawnObject("UIHauteCoutureDraw_QT_PrizeItem_Review")
    local sortOrder = 10
    local replace = table.icontains(self._replaceIdxs, specialIndex)
    item:SetData(sortOrder, self.controller._componentId, true, ctx, replace)
    item:SetClickCb(function(itemId, pos)
      self:ShowItemInfo(itemId, pos)
    end)
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
  self.hasDuplicate = #self._replaceIdxs > 0
  self:GetGameObject("duplicateTip"):SetActive(self.hasDuplicate)
end

function UIHauteCoutureDraw_QT_Main_Review:_RefreshReward()
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

function UIHauteCoutureDraw_QT_Main_Review:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDraw_QT_Main_Review:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDraw_QT_Main_Review:HandleDrawBtnClick()
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

function UIHauteCoutureDraw_QT_Main_Review:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDraw_QT_Main_Review:DrawAnim(TT)
  self:Lock("UIHauteCoutureDraw_QT_Main_Review:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDraw_QT_Main_Review:drawBtnOnClick")
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
    else
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
  local specailEffGo
  if self.controller._specialIdx == targetidx then
    specailEffGo = self._allPrizes[self.controller._specialIdx]:GetGameObject("prizeEff_spec")
    specailEffGo:SetActive(true)
  else
    self._prizeEff.position = self._allPrizes[targetidx]:GetGameObject().transform.position
    self._prizeEff.gameObject:SetActive(true)
  end
  YIELD(TT, 1200)
  if self.controller._specialIdx == targetidx then
    YIELD(TT, 1000)
    specailEffGo:SetActive(false)
  else
    self._prizeEff.gameObject:SetActive(false)
  end
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
        if unlockCgId then
          local cfg_cg = Cfg.cfg_cg_book[unlockCgId]
          if cfg_cg then
            self:ShowDialog("UIPetSkinsGetCgController", cfg_cg.StaticPic, false)
          end
          ToastManager.ShowToast(StringTable.Get("str_senior_skin_draw_new_cg_tips"))
        end
      end, self.controller.CtxData)
    end)
  else
    self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", reawrdList, nil, true, function()
      self:_RefreshReward()
      self:CheckAllPrizeCollected()
    end, self.controller.CtxData)
  end
  self:UnLock("UIHauteCoutureDraw_QT_Main_Review:drawBtnOnClick")
end

function UIHauteCoutureDraw_QT_Main_Review:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDraw_QT_Main_Review:VideoMaskOnClick(go)
  self:HandleFgBtnClick()
end

function UIHauteCoutureDraw_QT_Main_Review:VideoMaskOnClick1(go)
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

function UIHauteCoutureDraw_QT_Main_Review:CheckEndTime()
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

function UIHauteCoutureDraw_QT_Main_Review:CheckAndDoEnterAni(TT)
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
  local t = 900
  YIELD(TT, clipLength * 1000 - t)
  self:_EnterRoot()
  YIELD(TT, t)
  self._enterAniGo:SetActive(false)
end

function UIHauteCoutureDraw_QT_Main_Review:_EnterRoot()
  self._rootGo:SetActive(true)
  self._rootAni:Play("UIHauteCoutureDraw_QT_Main_Review_in")
  self:_LoadVideo()
  self:_LoadPrize()
  self:CheckAllPrizeCollected()
  self:_CheckDuplicateAutoTip()
end

function UIHauteCoutureDraw_QT_Main_Review:_CheckDuplicateAutoTip()
  if self.hasDuplicate then
    local key = self:GetAutoDuplicateTipsKey()
    if not UnityEngine.PlayerPrefs.HasKey(key) then
      UnityEngine.PlayerPrefs.SetInt(key, 1)
      self:Lock("UIHauteCoutureDraw_QT_Main_Review_duplicateTips")
      self:StartTask(function(TT)
        YIELD(TT, 1000)
        self:UnLock("UIHauteCoutureDraw_QT_Main_Review_duplicateTips")
        self:DuplicateTipOnClick()
      end)
    end
  end
end

function UIHauteCoutureDraw_QT_Main_Review:GetAutoDuplicateTipsKey()
  if not self._duplicateTipsKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._duplicateTipsKey = pstId .. "duplicate_tips_qt_r"
  end
  return self._duplicateTipsKey
end

function UIHauteCoutureDraw_QT_Main_Review:ShowItemInfo(item, pos)
  if self._selectInfo then
    local itemId = item.assetid
    local cfg = Cfg.cfg_item[itemId]
    local info = {
      item_id = itemId,
      item_count = item.count,
      icon = cfg.Icon,
      item_name = cfg.Name,
      simple_desc = cfg.RpIntro,
      color = cfg.Color
    }
    self._selectDetail:SetData(info)
    self._selectInfo:OnlyShow(pos)
  end
end

function UIHauteCoutureDraw_QT_Main_Review:DuplicateTipOnClick()
  self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
end

function UIHauteCoutureDraw_QT_Main_Review:SpineAreaOnClick(go)
  self._spineBg:PlayClickAni()
end
