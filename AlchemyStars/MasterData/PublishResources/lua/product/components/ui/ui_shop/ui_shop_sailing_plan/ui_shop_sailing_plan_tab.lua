_class("UIShopSailingPlanTab", UICustomWidget)
UIShopSailingPlanTab = UIShopSailingPlanTab

function UIShopSailingPlanTab:Constructor()
  self._questModule = GameGlobal.GetModule(QuestModule)
end

function UIShopSailingPlanTab:OnShow(uiParams)
  self:GetComponents()
end

function UIShopSailingPlanTab:Update(dms)
end

function UIShopSailingPlanTab:GetComponents()
  self._normalQuestPool = self:GetUIComponent("UISelectObjectPath", "normalPool")
  self._specialQuestPool = self:GetUIComponent("UISelectObjectPath", "specialPool")
  self._contentRt = self:GetUIComponent("RectTransform", "Content")
  self._priceTex = self:GetUIComponent("UILocalizationText", "priceTex")
  self._skinIcon = self:GetUIComponent("RawImageLoader", "SkinIcon")
  self._viewBtn = self:GetGameObject("ViewBtn")
  self._viewBtn2 = self:GetGameObject("ViewBtn2")
  self._buyBtn = self:GetGameObject("BuyBtn")
  self._allBtn = self:GetGameObject("AllBtn")
  self._anim = self:GetUIComponent("Animation", "UIShopSailingPlanTab")
end

function UIShopSailingPlanTab:ItemOnClick(id, pos)
  if not self._tips then
    local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
    self._tips = s:SpawnObject("UISelectInfo")
  end
  if self._tips then
    self._tips:SetData(id, pos)
  end
end

function UIShopSailingPlanTab:ExcuteHideLogic(cb)
  if cb then
    cb(self)
  end
  self:DetachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnCurrencyBuySuccess)
  self:DetachEvent(GameEventType.OnGiftBuySucc, self.OnGiftBuySucc)
  self:DetachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnGetRewards)
  if self._tips then
    self._tips:closeOnClick()
  end
end

function UIShopSailingPlanTab:ViewBtnOnClick(go)
  local normalAwards = self:GetNormalAwards()
  local allAwards = self:GetAllAwards()
  self:ShowDialog("UIShopSailingAwardsView", normalAwards, allAwards)
end

function UIShopSailingPlanTab:ViewBtn2OnClick(go)
  local normalAwards = self:GetNormalAwards()
  local allAwards = self:GetAllAwards()
  self:ShowDialog("UIShopSailingAwardsView", normalAwards, allAwards)
end

function UIShopSailingPlanTab:CheckNormalQuestCount()
  if self._saveFinishQuestID and next(self._saveFinishQuestID) then
    for index, value in ipairs(self._saveFinishQuestID) do
      if self._popTips and table.icontains(self._popTips, value) then
        self:PopBuyTips()
        break
      end
    end
  end
end

function UIShopSailingPlanTab:PopBuyTips()
  if self._buyState ~= BuyGiftStateType.EBGST_INIT then
    Log.debug("###[UIShopSailingPlanTab] 已经购买不弹出")
    return
  end
  local priceTex = self:GetPrice()
  local specialCompleteAwards = self:GetSpecialCompleteAwards()
  self:ShowDialog("UIShopSailingBuyTips", function()
    self:BuyBtnOnClick()
  end, priceTex, specialCompleteAwards)
end

function UIShopSailingPlanTab:GetNormalAwards()
  local rewardsMap = {}
  for index, value in ipairs(self._normalList) do
    local quest = self._questModule:GetQuest(value)
    local questInfo = quest:QuestInfo()
    local rewards = questInfo.rewards
    for i = 1, #rewards do
      local roleAsset = rewards[i]
      local itemid = roleAsset.assetid
      local count = roleAsset.count
      if rewardsMap[itemid] then
        rewardsMap[itemid] = rewardsMap[itemid] + count
      else
        rewardsMap[itemid] = count
      end
    end
  end
  local awards = self:SortAwards(rewardsMap)
  return awards
end

function UIShopSailingPlanTab:GetSpecialAwards()
  local rewardsMap = {}
  for index, value in ipairs(self._specialList) do
    local quest = self._questModule:GetQuest(value)
    local questInfo = quest:QuestInfo()
    local rewards = questInfo.rewards
    for i = 1, #rewards do
      local roleAsset = rewards[i]
      local itemid = roleAsset.assetid
      local count = roleAsset.count
      if rewardsMap[itemid] then
        rewardsMap[itemid] = rewardsMap[itemid] + count
      else
        rewardsMap[itemid] = count
      end
    end
  end
  local awards = self:SortAwards(rewardsMap)
  return awards
end

function UIShopSailingPlanTab:GetAllAwards()
  local rewardsMap = {}
  local diamondCount = self:GetDiamondCfg()
  if diamondCount then
    rewardsMap[RoleAssetID.RoleAssetDiamond] = diamondCount
  end
  local allList = self._questInfo.m_accept_cam_quest_list
  for index, value in ipairs(allList) do
    local quest = self._questModule:GetQuest(value)
    local questInfo = quest:QuestInfo()
    local rewards = questInfo.rewards
    for i = 1, #rewards do
      local roleAsset = rewards[i]
      local itemid = roleAsset.assetid
      local count = roleAsset.count
      if rewardsMap[itemid] then
        rewardsMap[itemid] = rewardsMap[itemid] + count
      else
        rewardsMap[itemid] = count
      end
    end
  end
  local awards = self:SortAwards(rewardsMap)
  return awards
end

function UIShopSailingPlanTab:GetDiamondCfg()
  local com = self._sailingPlanLocalProcess:GetComponent(ECCampaignInlandSailingComponentID.BUY_GIFT)
  local cfgComID = com:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_buy_gift({ComponentID = cfgComID})
  if cfgs and next(cfgs) then
    local cfg = cfgs[1]
    local extraAward = cfg.ExtraAward
    if extraAward and next(extraAward) then
      local asset = extraAward[1]
      local id = asset[1]
      local count = asset[2]
      local cfg_item = Cfg.cfg_item[id]
      if not cfg_item then
        Log.error("###[UIShopSailingPlanTab] cfg _item is nil ! id --> ", id)
        return
      end
      local converId = cfg_item.ConverId
      if converId then
        local cfg_conver_item = Cfg.cfg_conver_item[converId]
        if not cfg_conver_item then
          Log.error("###[UIShopSailingPlanTab] cfg_conver_item is nil ! id --> ", converId)
          return
        end
        local diamond = cfg_conver_item.Diamond
        local allCount = count * diamond
        return allCount
      end
    end
  end
end

function UIShopSailingPlanTab:GetSpecialCompleteAwards()
  local rewardsMap = {}
  local completeIdxMap = {}
  for index, questid in ipairs(self._normalList) do
    local quest = self._questModule:GetQuest(questid)
    local questinfo = quest:QuestInfo()
    local status = questinfo.status
    if status == QuestStatus.QUEST_Completed or status == QuestStatus.QUEST_Taken then
      completeIdxMap[index] = true
    else
      completeIdxMap[index] = false
    end
  end
  local specialCompleteList = {}
  for index, questid in ipairs(self._specialList) do
    if completeIdxMap[index] then
      table.insert(specialCompleteList, questid)
    end
  end
  for index, value in ipairs(specialCompleteList) do
    local quest = self._questModule:GetQuest(value)
    local questInfo = quest:QuestInfo()
    local rewards = questInfo.rewards
    for i = 1, #rewards do
      local roleAsset = rewards[i]
      local itemid = roleAsset.assetid
      local count = roleAsset.count
      if rewardsMap[itemid] then
        rewardsMap[itemid] = rewardsMap[itemid] + count
      else
        rewardsMap[itemid] = count
      end
    end
  end
  local awards = self:SortAwards(rewardsMap)
  return awards
end

function UIShopSailingPlanTab:SortAwards(tab)
  local list = {}
  for id, count in pairs(tab) do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = id
    roleAsset.count = count
    list[#list + 1] = roleAsset
  end
  if self._awardSort then
    local sortMap = {}
    for i = 1, #self._awardSort do
      local sortitem = self._awardSort[i]
      local itemid = sortitem[1]
      local itemidx = sortitem[2]
      sortMap[itemid] = itemidx
    end
    table.sort(list, function(a, b)
      local a_id = a.assetid
      local a_idx = sortMap[a_id] or 0
      local b_id = b.assetid
      local b_idx = sortMap[b_id] or 0
      return a_idx < b_idx
    end)
  end
  return list
end

function UIShopSailingPlanTab:OnValue()
  self._playAnim = true
  self:GetData()
  self:SetQuestList()
  self:SetBuyBtnState()
  self:SetNew()
end

function UIShopSailingPlanTab:SetNew()
  local helper = UIShopSailingPlanHelper:New()
  helper:SetNew()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
end

function UIShopSailingPlanTab:SetBuyBtnState()
  Log.debug("###[UIShopSailingPlanTab] _buyState:", self._buyState)
  self._viewBtn:SetActive(self._buyState == BuyGiftStateType.EBGST_INIT)
  self._viewBtn2:SetActive(self._buyState ~= BuyGiftStateType.EBGST_INIT)
  self._buyBtn:SetActive(self._buyState == BuyGiftStateType.EBGST_INIT)
  local getList = self:GetAllCompleteQuest()
  self._allBtn:SetActive(0 < #getList)
  local priceTex = self:GetPrice()
  local showTex = GiftPackShopItem:GetPriceWithSymbolSize(priceTex, 51)
  self._priceTex:SetText(RechargeShopItem.RemoveDot00(showTex))
end

function UIShopSailingPlanTab:GetPrice()
  local gift = self._buyInfo.m_campaign_gift_list[1]
  local mdsid = gift.m_midas_id
  local mPay = GameGlobal.GetModule(PayModule)
  local goodPriceList = mPay:GetGoodPriceList()
  local giftInfo = goodPriceList[mdsid]
  if giftInfo then
    return giftInfo.price
  end
  return ""
end

function UIShopSailingPlanTab:SetData()
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnCurrencyBuySuccess)
  self:AttachEvent(GameEventType.BuyGift_DirectAMidas_ERROR, self.OnCurrencyBuyError)
  self:AttachEvent(GameEventType.MidasPayError, self.OnCurrencyBuyError)
  self:AttachEvent(GameEventType.OnGiftBuySucc, self.OnGiftBuySucc)
  self:AttachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnGetRewards)
  self._buying = false
  self._sailingPlanLocalProcess = self.uiOwner:GetSailingPlanLocalProgress()
  self._sailingPlanID = self.uiOwner:GetSailingPlanID()
  self._buyInfo = self._sailingPlanLocalProcess:GetComponentInfo(ECCampaignInlandSailingComponentID.BUY_GIFT)
  self._questInfo = self._sailingPlanLocalProcess:GetComponentInfo(ECCampaignInlandSailingComponentID.QUEST)
  self:OnValue()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.SailingPlan)
end

function UIShopSailingPlanTab:SkinViewBtnOnClick(go)
  self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._skinID)
end

function UIShopSailingPlanTab:SetQuestList()
  self._normalQuestPool:SpawnObjects("UIShopSailingPlanNormalQuest", #self._normalList)
  self._specialQuestPool:SpawnObjects("UIShopSailingPlanSpecialQuest", #self._specialList)
  local normalPools = self._normalQuestPool:GetAllSpawnList()
  local specialPools = self._specialQuestPool:GetAllSpawnList()
  local spIdx = 0
  local normalIdx = 0
  for i = 1, #self._normalList do
    local item = normalPools[i]
    local questid = self._normalList[i]
    local quest = self._questModule:GetQuest(questid)
    local questState = quest:QuestInfo().status
    if questState < QuestStatus.QUEST_Taken then
      if normalIdx == 0 then
        normalIdx = i
      else
        normalIdx = math.min(normalIdx, i)
      end
    end
    local allTaken = false
    local s_questid = self._specialList[i]
    local s_quest = self._questModule:GetQuest(s_questid)
    local s_questState = s_quest:QuestInfo().status
    if questState == QuestStatus.QUEST_Taken and s_questState == QuestStatus.QUEST_Taken then
      allTaken = true
    end
    local yieldTime
    if self._playAnim then
      yieldTime = (i - 1) * 50
    end
    item:SetData(i, quest, function(questid, itemid, pos)
      self:NormalQuestClick(questid, itemid, pos)
    end, yieldTime, allTaken)
  end
  for i = 1, #self._specialList do
    local item = specialPools[i]
    local questid = self._specialList[i]
    local quest = self._questModule:GetQuest(questid)
    local questState = quest:QuestInfo().status
    if questState < QuestStatus.QUEST_Taken then
      if spIdx == 0 then
        spIdx = i
      else
        spIdx = math.min(spIdx, i)
      end
    end
    local yieldTime
    if self._playAnim then
      yieldTime = (i - 1) * 50
    end
    item:SetData(i, quest, function(questid, itemid, pos)
      self:SpecialQuestClick(questid, itemid, pos)
    end, self._buyState, yieldTime)
  end
  self._playAnim = false
  local showIdx = math.min(spIdx, normalIdx)
  if showIdx == 0 then
    showIdx = 1
  end
  self:MoveContent(showIdx)
end

function UIShopSailingPlanTab:MoveContent(showIdx)
  local contentPos = 161 * (showIdx - 1)
  self._contentRt.anchoredPosition = Vector2(0, contentPos)
end

function UIShopSailingPlanTab:NormalQuestClick(questid, itemid, pos)
  local quest = self._questModule:GetQuest(questid)
  local questinfo = quest:QuestInfo()
  local status = questinfo.status
  if status == QuestStatus.QUEST_Completed then
    self:FinishAQuest(questid)
  else
    self:ItemOnClick(itemid, pos)
  end
end

function UIShopSailingPlanTab:SpecialQuestClick(questid, itemid, pos)
  if self._buyState == BuyGiftStateType.EBGST_INIT then
    Log.debug("###[UIShopSailingPlanTab] SpecialQuestClick 未购买")
    self:ItemOnClick(itemid, pos)
    return
  end
  local quest = self._questModule:GetQuest(questid)
  local questinfo = quest:QuestInfo()
  local status = questinfo.status
  if status == QuestStatus.QUEST_Completed then
    self:FinishAQuest(questid)
  else
    self:ItemOnClick(itemid, pos)
  end
end

function UIShopSailingPlanTab:FinishAQuest(questid)
  self:Lock("UIShopSailingPlanTab:OnFinishQuest")
  GameGlobal.TaskManager():StartTask(self.OnFinishQuest, self, false, questid)
end

function UIShopSailingPlanTab:FinishAllQuest()
  self:Lock("UIShopSailingPlanTab:OnFinishQuest")
  GameGlobal.TaskManager():StartTask(self.OnFinishQuest, self, true, -1)
end

function UIShopSailingPlanTab:OnGetRewards()
  self:SetQuestList()
  self:CheckNormalQuestCount()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckMonthCardRedpoint)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange)
end

function UIShopSailingPlanTab:OnFinishQuest(TT, all, questid)
  self:SaveFinishQuestID(all, questid)
  local res = AsyncRequestRes:New()
  local questCom = self._sailingPlanLocalProcess:GetComponent(ECCampaignInlandSailingComponentID.QUEST)
  local ret, rewards
  if all then
    ret, rewards = questCom:HandleOneKeyTakeQuest(TT, res)
  else
    ret, rewards = questCom:HandleQuestTake(TT, res, questid)
  end
  self:UnLock("UIShopSailingPlanTab:OnFinishQuest")
  if res:GetSucc() then
    if self.view == nil then
      return
    end
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    Log.error("###[UIShopSailingPlanTab] OnFinishQuest fail,type:", all, " result:", res:GetResult(), " questid:", questid)
  end
end

function UIShopSailingPlanTab:SaveFinishQuestID(all, id)
  self._saveFinishQuestID = {}
  if all then
    for index, value in ipairs(self._normalList) do
      local quest = self._questModule:GetQuest(value)
      local questInfo = quest:QuestInfo()
      local status = questInfo.status
      if status == QuestStatus.QUEST_Completed then
        table.insert(self._saveFinishQuestID, value)
      end
    end
  else
    table.insert(self._saveFinishQuestID, id)
  end
end

function UIShopSailingPlanTab:AllBtnOnClick(go)
  local getList = self:GetAllCompleteQuest()
  if 0 < #getList then
    self:FinishAllQuest()
  end
end

function UIShopSailingPlanTab:GetAllCompleteQuest()
  local getList = {}
  for index, value in ipairs(self._normalList) do
    local quest = self._questModule:GetQuest(value)
    local questInfo = quest:QuestInfo()
    local status = questInfo.status
    if status == QuestStatus.QUEST_Completed then
      table.insert(getList, value)
    end
  end
  if self._buyState ~= BuyGiftStateType.EBGST_INIT then
    for index, value in ipairs(self._specialList) do
      local quest = self._questModule:GetQuest(value)
      local questInfo = quest:QuestInfo()
      local status = questInfo.status
      if status == QuestStatus.QUEST_Completed then
        table.insert(getList, value)
      end
    end
  end
  return getList
end

function UIShopSailingPlanTab:BuyBtnOnClick(go)
  if self._buyState ~= BuyGiftStateType.EBGST_INIT then
    Log.debug("###[UIShopSailingPlanTab] 已经购买")
    return
  end
  if self._buying then
    Log.debug("###[UIShopSailingPlanTab] 已经开始购买，不可连续点击")
    return
  end
  self._buying = true
  local buyCom = self._sailingPlanLocalProcess:GetComponent(ECCampaignInlandSailingComponentID.BUY_GIFT)
  local gift = self._buyInfo.m_campaign_gift_list[1]
  local giftid = gift.m_gift_id
  local cfg = buyCom:GetGiftCfgById(giftid)
  local giftType = cfg.GiftType
  local giftNum = 1
  buyCom:BuyGift(giftid, giftNum, giftType)
  Log.debug("###[UIShopSailingPlanTab] start buy gift !")
end

function UIShopSailingPlanTab:OnCurrencyBuySuccess(goodsId)
  Log.debug("###[UIShopSailingPlanTab] 购买成功,id:", goodsId)
  self._buying = false
  local gift = self._buyInfo.m_campaign_gift_list[1]
  local giftid = gift.m_gift_id
  if giftid == goodsId then
    Log.debug("###[UIShopSailingPlanTab] 购买成功,刷新!")
    self:RefreshSpecialAwards()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSailingPlanBuySucc)
    GameGlobal.GetModule(PayModule):RequestGetBalanceForCharge()
  end
end

function UIShopSailingPlanTab:OnCurrencyBuyError()
  Log.debug("###[UIShopSailingPlanTab] 购买失败")
  self._buying = false
end

function UIShopSailingPlanTab:OnGiftBuySucc()
  self:RefreshSpecialAwards()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSailingPlanBuySucc)
end

function UIShopSailingPlanTab:QuestUpdate()
  self:RefreshSpecialAwards()
end

function UIShopSailingPlanTab:RefreshSpecialAwards()
  self._sailingPlanLocalProcess = self.uiOwner:GetSailingPlanLocalProgress()
  self._buyInfo = self._sailingPlanLocalProcess:GetComponentInfo(ECCampaignInlandSailingComponentID.BUY_GIFT)
  self._buyState = self._buyInfo.m_buy_state
  self:GetData()
  self:SetQuestList()
  self:SetBuyBtnState()
end

function UIShopSailingPlanTab:GetData()
  local list = self._questInfo.m_accept_cam_quest_list
  self._normalList = {}
  self._specialList = {}
  self._clientCfg = Cfg.cfg_shop_sailing_plan_client[self._sailingPlanID]
  if not self._clientCfg then
    Log.error("###[UIShopSailingPlanTab] 缺少客户端配置，活动id:", self._sailingPlanID, "!")
  end
  self._awardSort = self._clientCfg.Sort
  self._popTips = self._clientCfg.PopBuyTips
  self._questPos = self._clientCfg.QuestPos
  self._skinID = self._clientCfg.SkinID
  self._buyState = self._buyInfo.m_buy_state
  local normalQuestPos = self._questPos[1]
  for index, value in ipairs(list) do
    if table.icontains(normalQuestPos, value) then
      table.insert(self._normalList, value)
    else
      table.insert(self._specialList, value)
    end
  end
end

function UIShopSailingPlanTab:OnHide()
end

function UIShopSailingPlanTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopSailingPlanTab:HideSelf()
end
