_class("UIHauteCoutureDrawMainGL", UIHauteCoutureDrawBase)
UIHauteCoutureDrawMainGL = UIHauteCoutureDrawMainGL

function UIHauteCoutureDrawMainGL:Constructor()
  self._allPrizes = {}
  self._EnterAniKey = nil
end

function UIHauteCoutureDrawMainGL:OnShow(uiParams)
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

function UIHauteCoutureDrawMainGL:GetEnterAniKey()
  if not self._EnterAniKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._EnterAniKey = pstId .. "senior_enter_gl_review2"
  end
  return self._EnterAniKey
end

function UIHauteCoutureDrawMainGL:GetAutoDuplicateTipsKey()
  if not self._duplicateTipsKey then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    self._duplicateTipsKey = pstId .. "duplicate_tips_gl2"
  end
  return self._duplicateTipsKey
end

function UIHauteCoutureDrawMainGL:InitWidgets()
  self:InitWidgetsBase()
  self._prizeTop = self:GetUIComponent("UISelectObjectPath", "PrizeListTop")
  self._prizeBottom = self:GetUIComponent("UISelectObjectPath", "PrizeListBottom")
  self._specialItem = self:GetUIComponent("UISelectObjectPath", "SpecialItem")
  self._rootGo = self:GetGameObject("Root")
  self._rootAni = self:GetUIComponent("Animation", "RootAni")
  self._enterAniPool = self:GetUIComponent("UISelectObjectPath", "EnterAnimation")
  self._enterAniGo = self:GetGameObject("EnterAnimation")
  self._moneyNumBg = self:GetUIComponent("UILocalizationText", "moneyNumBg")
  local spineBgPool = self:GetUIComponent("UISelectObjectPath", "spineBg")
  self._spineBg = spineBgPool:SpawnObject("UISpineBg")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectinfo")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self._selectInfo:SetType(3)
  local detailObj = self._selectInfo:GetG3CustomPool()
  detailObj.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawGetItemCellDetailGL.prefab")
  self._selectDetail = detailObj:SpawnObject("UIHauteCoutureDrawGetItemCellDetailGL")
  self._eff2Go = self:GetGameObject("eff2")
  self._eff3Go = self:GetGameObject("eff3")
  self._eff2Trans = self:GetUIComponent("RectTranform", "eff2")
  self._eff3Trans = self:GetUIComponent("RectTranform", "eff3")
  self._eff2Ani = self:GetUIComponent("Animation", "eff2")
end

function UIHauteCoutureDrawMainGL:GetCoinId()
  return 3000342
end

function UIHauteCoutureDrawMainGL:_OnValue()
  self._spineBg:SetData(self:GetSkinId())
end

function UIHauteCoutureDrawMainGL:GetSkinId()
  return 90384
end

function UIHauteCoutureDrawMainGL:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self.controller._cfg.VideoName .. ".mp4", LoadType.VideoClip)
  self:LoadVideo(url)
end

function UIHauteCoutureDrawMainGL:_LoadPrize()
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
    local item = self._specialItem:SpawnObject("UIHauteCoutureDrawPrizeItemGL")
    local sortOrder = 10
    item:SetData(sortOrder, self.controller._componentId, true, ctx, table.icontains(self._replaceIdxs, specialIndex))
    item:SetClickCb(function(itemId, pos)
      self:ShowItemInfo(itemId, pos)
    end)
    table.insert(self._allPrizes, item)
  end
  self:_RefreshReward()
  self.hasDuplicate = #self._replaceIdxs > 0
  self:GetGameObject("duplicateTip"):SetActive(self.hasDuplicate)
end

function UIHauteCoutureDrawMainGL:_CheckDuplicateAutoTip()
  if self.hasDuplicate then
    local key = self:GetAutoDuplicateTipsKey()
    if not UnityEngine.PlayerPrefs.HasKey(key) then
      UnityEngine.PlayerPrefs.SetInt(key, 1)
      self:DuplicateTipOnClick()
    end
  end
end

function UIHauteCoutureDrawMainGL:_RefreshReward()
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
    self._redGo:SetActive(false)
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
      self._moneyNum:SetText("<color=#cf1c29>" .. curDrawCost.CostItemCount .. "</color>")
      self._moneyNumBg:SetText("<color=#cf1c29>" .. curDrawCost.CostItemCount .. "</color>")
    else
      self._moneyNum:SetText(curDrawCost.CostItemCount)
      self._moneyNumBg:SetText(curDrawCost.CostItemCount)
    end
    self._freeGo:SetActive(curDrawCost.CostItemCount <= 0)
    self._redGo:SetActive(count >= curDrawCost.CostItemCount)
    self._countParent:SetActive(curDrawCost.CostItemCount > 0)
  end
end

function UIHauteCoutureDrawMainGL:ItemCountChanged()
  self:_RefreshReward()
end

function UIHauteCoutureDrawMainGL:IsAllAwardCollected()
  return #self.controller._componentInfo.shake_win_ids == #self._allPrizes
end

function UIHauteCoutureDrawMainGL:HandleDrawBtnClick()
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

function UIHauteCoutureDrawMainGL:CanDrawSpecialAward()
  return self.controller._componentInfo.shake_num >= 5
end

function UIHauteCoutureDrawMainGL:DrawAnim(TT)
  self:Lock("UIHauteCoutureDrawMainGL:drawBtnOnClick")
  local res = AsyncRequestRes:New()
  local result, rewards = self.controller._component:HandleApplySeniorSkin(TT, res)
  if not result or not result:GetSucc() then
    self:UnLock("UIHauteCoutureDrawMainGL:drawBtnOnClick")
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
      item:SetGray(false)
    else
      item:SetGray(false)
    end
  end
  self._eff2Go:SetActive(true)
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
  local isTargetReward = self.controller._specialIdx == targetidx
  if isTargetReward then
    self._eff3Go:SetActive(true)
  else
    self._prizeEff.position = self._allPrizes[targetidx]:GetGameObject().transform.position
    self._prizeEff.gameObject:SetActive(true)
  end
  YIELD(TT, 700)
  self._eff2Ani:Play("uieff_UIHauteCoutureDrawMainGL_eff2out")
  YIELD(TT, 900)
  if isTargetReward then
    self._eff3Go:SetActive(false)
  else
    self._prizeEff.gameObject:SetActive(false)
  end
  self._eff2Go:SetActive(false)
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
  self:UnLock("UIHauteCoutureDrawMainGL:drawBtnOnClick")
end

function UIHauteCoutureDrawMainGL:CheckAllPrizeCollected()
  if self:IsAllAwardCollected() then
    local currency = self._topTips:GetItemByTypeId(self:GetCoinId())
    currency:CloseAddBtn()
    self._drawBtnOj:SetActive(false)
    self._probalityBtn:SetActive(false)
    self._buyBtn:SetActive(false)
  end
end

function UIHauteCoutureDrawMainGL:CheckAndDoEnterAni(TT)
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
  YIELD(TT, clipLength * 1000 - 400)
  self:_EnterRoot()
  YIELD(400)
  self._enterAniGo:SetActive(false)
end

function UIHauteCoutureDrawMainGL:_EnterRoot()
  self._rootGo:SetActive(true)
  self._rootAni:Play("UIHauteCoutureDrawMainGL_new")
  self:_LoadVideo()
  self:_CheckDuplicateAutoTip()
end

function UIHauteCoutureDrawMainGL:GetEndTimeColor()
  return "#f2c60e"
end

function UIHauteCoutureDrawMainGL:ShowItemInfo(item, pos)
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

function UIHauteCoutureDrawMainGL:SpineAreaOnClick(go)
  self._spineBg:PlayClickAni()
end

function UIHauteCoutureDrawMainGL:DuplicateTipOnClick()
  self:ShowDialog("UIHauteCoutureDuplicateReward", self._prizes, self._replaceIdxs)
end
