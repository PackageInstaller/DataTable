local module = class("moduleHeroTalent", require("ui.pages.heroPanel.moduleHeroBase"))
local giftPath = "UI/UIEffect/TalentRing/pre_uipage_giftring.prefab"
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local talentRankRewardTpl = L_GameTpl:getTalentRankReward()
local talentRuneComposeTpl = L_GameTpl:getTalentRuneComposeTpl()
local HasRewardImg = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_01.png"
local noRewardImg = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_box_02.png"
local HasRewardStar = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_Star_01.png"
local NoRewardStar = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_bx_Star_02.png"
local runePositions = {
  runePosition_6 = {
    rune1 = C_Vector2(-292, -28),
    rune2 = C_Vector2(-152, 148),
    rune3 = C_Vector2(-42, -114),
    rune4 = C_Vector2(82, 76),
    rune5 = C_Vector2(220, -70),
    rune6 = C_Vector2(344, 152)
  },
  runePosition_5 = {
    rune1 = C_Vector2(-261, 129),
    rune2 = C_Vector2(-127, -24),
    rune3 = C_Vector2(26, 172),
    rune4 = C_Vector2(166, -111),
    rune5 = C_Vector2(287, 81)
  },
  runePosition_4 = {
    rune1 = C_Vector2(-228, 86),
    rune2 = C_Vector2(-60, -24),
    rune3 = C_Vector2(111, 143),
    rune4 = C_Vector2(284, 8)
  },
  runePosition_3 = {
    rune1 = C_Vector2(-153, -71),
    rune2 = C_Vector2(24, 149),
    rune3 = C_Vector2(220, 12)
  }
}
local rankImgPath = "UI/Atlas/HeroTalentRankNum/tex_role_talent_bg_numA%s.png"

function module.bind()
  return {
    breakBtnActive = false,
    equipBtnActive = false,
    talentRuneList = {
      moduleName = "pages/heroPanel/talent/cellTalentRuneItem"
    },
    maxNodeActive = false,
    equipNodeActive = false,
    equipBtn = L_Const.ModuleInfo.ModuleBtn,
    breakBtn = L_Const.ModuleInfo.ModuleBtn,
    txt_title = "",
    curRank = "",
    activeRankMax = false,
    rankMaxBtn = L_Const.ModuleInfo.ModuleBtn,
    rankMaxBtnInteractable = true,
    moduleTalentDetail = {
      moduleName = "pages/heroPanel/talent/moduleTalentDetail"
    },
    talentDetailActive = false,
    rankStatusText = "",
    backCurrentBtn = L_Const.ModuleInfo.ModuleBtn,
    backCurrentBtnActive = false,
    active_nextRankBtn = true,
    active_previousRankBtn = true,
    img_rewardBox = "",
    img_rewardStar = "",
    text_talentRewardPreview = "",
    showHasRewardBg = false,
    showNoRewardBg = false,
    moduleTalentReward = {
      moduleName = "pages/common/modules/moduleRewardTipBtn"
    },
    active_unlockDesBg = false,
    txt_unlockDes = "",
    active_break_redDot = false
  }
end

function module.methods()
  return {
    onClick_detailBtn = function(self)
      self.bind.talentDetailActive = not self.bind.talentDetailActive
    end,
    onClick_nextBtn = function(self)
      local hero = self:getHero(self.heroGuid)
      local maxRank = talentRankTpl:getHeroMaxRankNum(L_HeroStore:getHeroConfigId(hero))
      if maxRank <= self.currentRank then
        return
      end
      self.currentRank = self.currentRank + 1
      self:switchRank(nil, true)
      self.giftRingAnim:SetTrigger("SwitchNext")
      self.bindComponents.heroTalentAnim:SetTrigger("Next")
    end,
    onClick_previousBtn = function(self)
      if self.currentRank <= 1 then
        return
      end
      self.currentRank = self.currentRank - 1
      self:switchRank(nil, true)
      self.giftRingAnim:SetTrigger("SwitchLast")
      self.bindComponents.heroTalentAnim:SetTrigger("Last")
    end,
    onClick_rankLimitBtn = function(self)
      local hero = self:getHero(self.heroGuid)
      L_HeroManager:showHeroSelection(L_Const.heroModuleType.Property, L_HeroStore:getHeroGuid(hero), {openLevelUp = true})
    end,
    onClick_GetAllRankRewards = function(self)
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_stargift_reward_battle_forbidden"))
        return
      end
      local hero = self:getHero(self.heroGuid)
      local data = talentRankRewardTpl:getSortedData()
      local heroRank = L_HeroStore:getHeroRank(hero)
      local hasCanGet = false
      for _, reward in ipairs(data) do
        if not L_HeroStore:IsRankRewardGetted(hero, reward.level) and heroRank >= reward.level then
          hasCanGet = true
          break
        end
      end
      if not hasCanGet then
        self.methods.onClick_previewRankRewards(self)
        return
      end
      self.isGetRankRewards = true
      local resp = {
        hero_id = self.heroGuid,
        rank_id = 0
      }
      L_Net:sendMessage(MsgGenCode.CSProtoHeroRankReward, resp, function(rspData, errorCode)
        if errorCode == L_Const.errorCode.ErrCodeSucc then
          self:refreshTalentReward()
          if not table.isEmpty(rspData.rewards) then
            local rewards = require("ui.manager.reward.rewardData").new()
            rewards.rewardShowType = L_Const.rewardShowType.full
            local data = L_DataUtil.parseRewardConfig(rspData.rewards, true, true)
            rewards:constructList(data)
            L_RewardManager:ShowReward(rewards)
          end
        end
      end)
    end,
    onClick_previewRankRewards = function(self)
      local hero = self:getHero(self.heroGuid)
      local data = talentRankRewardTpl:getSortedData()
      local idx = 1
      for i, reward in ipairs(data) do
        local rank = reward.level
        if not L_HeroStore:IsRankRewardGetted(hero, rank) then
          idx = reward.id
          break
        end
      end
      local list = {}
      for _, reward in ipairs(data) do
        local rank = reward.level
        local get = L_HeroStore:IsRankRewardGetted(hero, rank)
        local tpl = talentRankRewardTpl:getTplById(reward.id)
        local rewardItems = talentRankRewardTpl:getItem(tpl) or {}
        for i = 1, #rewardItems do
          local item = L_ItemTplManager:getItemConfig(rewardItems[i].itemType, rewardItems[i].itemId)
          rewardItems[i].received = get
        end
        table.insert(list, {
          isStar = false,
          number = 0,
          rewardList = rewardItems,
          reward_icon = talentRankRewardTpl:getIcon(tpl),
          isSelect = idx == reward.id,
          txt_content = L_WordsTpl:getValue("ui_common_rewardlist_desc_starflair")
        })
      end
      L_UI:open("pageCommonRewardsTip", {
        title = L_WordsTpl:getValue("ui_common_rewardlist_title_starflair"),
        module_list = list,
        selectIndex = idx,
        notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
      })
    end,
    moduleTalentDetail = {
      onClick_empty = function(self)
        self.bind.talentDetailActive = false
      end
    }
  }
end

function module:open()
  self.timerList = {}
  self.isClose = false
  self.needPlayEnterAni = false
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  self.onEvent_refreshBagHandle = handler(self, self.onEvent_refreshBag)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshBagHandle)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshBag, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.syncAttrInfoComplete, self.onEvent_refreshBag, self)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
end

function module:show()
  self.giftRing = C_LuaUtility.InstantiateAsync(giftPath, function(go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. giftPath)
      return
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_StarGift_Enter")
    self.giftRingAnim = go.transform:GetChild(0):GetComponent(typeof(C_CsAnimator))
    L_UI:open("pageBlank", {timeClose = 0.5})
    if self.needHideRing then
      self.needHideRing = false
      self.giftRingAnim.gameObject:SetActive(false)
    else
      self.giftRingAnim:SetTrigger("In")
      table.insert(self.timerList, Timer.once(0.483, function()
        if not self.params or self.params.forceRefesh then
          self:initPage({isBreak = false, forceRefesh = true})
        end
      end))
    end
  end, C_CameraManager.mainCamera.transform)
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Talent, true)
end

function module:hide()
  if self.giftRing then
    C_LuaUtility.DestroyObject(self.giftRing)
    self.giftRing = nil
  end
  self.lastHeroId = nil
  self.params = nil
  L_HeroManager:curModuleChanged(L_Const.heroModuleType.Talent, false)
end

function module:close()
  self.isClose = true
  if self.giftRing then
    C_LuaUtility.DestroyObject(self.giftRing)
    self.giftRing = nil
  end
  if #self.timerList > 0 then
    for key, value in ipairs(self.timerList) do
      Timer.remove(value)
    end
    table.clear(self.timerList)
  end
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_refreshBag, self)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.syncAttrInfoComplete, self.onEvent_refreshBag, self)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshBagHandle)
end

function module:onEvent_refreshBag()
  self:refreshBtnsStatus(self.hero, self.rankBreakItems)
end

function module:onEvent_refreshHero(enum, varList)
  local hero = varList:GetObject(0)
  if L_HeroStore:getHeroGuid(hero) ~= self.heroGuid then
    self.bind.talentDetailActive = false
    return
  end
  self:initPage({
    isBreak = self.isBreak,
    isHeroRefresh = true
  })
end

function module:refreshTalentReward()
  local hero = self:getHero(self.heroGuid)
  local data = talentRankRewardTpl:getSortedData()
  local heroRank = L_HeroStore:getHeroRank(hero)
  local hasCanGet = false
  for _, reward in ipairs(data) do
    if not L_HeroStore:IsRankRewardGetted(hero, reward.level) and heroRank >= reward.level then
      hasCanGet = true
      break
    end
  end
  if hasCanGet then
    self.modules.moduleTalentReward:refreshNumberState(2, L_GameTpl:getWordsTpl():getTplById("talent_reward_receive"))
    self.modules.moduleTalentReward:setBoxImage(HasRewardImg)
    self.modules.moduleTalentReward:setStarImage(HasRewardStar)
  else
    self.modules.moduleTalentReward:refreshNumberState(2, L_Const.Number2Roma[heroRank])
    self.modules.moduleTalentReward:setBoxImage(noRewardImg)
    self.modules.moduleTalentReward:setStarImage(NoRewardStar)
  end
  self.modules.moduleTalentReward:refreshState(hasCanGet)
  self.bindComponents.rewardBtn.legacyAnimationTriggers.normalTrigger = hasCanGet and "anim_entrust_normal_full" or "anim_entrust_normal"
  self.bindComponents.rewardBtn.legacyAnimationTriggers.highlightedTrigger = hasCanGet and "anim_entrust_hover_full" or "anim_entrust_hover"
  self.bindComponents.rewardBtn.legacyAnimationTriggers.selectedTrigger = hasCanGet and "anim_entrust_Selected_full" or "anim_entrust_Selected"
end

function module:onBreakBtnClicked()
  if self.isBreak then
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.HeroRuneUpgrade))
    return
  end
  if not L_GameUtil.getIsHadItemListNum(self.rankBreakMaterialList, true) then
    return
  end
  self.isBreak = true
  AzurWorld.heroMgr:ReqUpgradeHeroRune(self.heroGuid, function(errCode, rspData)
    if self.isClose then
      return
    end
    if errCode == L_Const.errorCode.ErrCodeSucc then
      local options = {
        isRankUp = true,
        heroGuid = self.heroGuid,
        serverResp = rspData
      }
      table.insert(self.timerList, Timer.once(self.protectTime * 2 + 1.6, function()
        L_UI:open("pageHeroRuneEquipedSuccess", options)
        self.isBreak = false
      end))
      L_AudioUtil.playSound("Play_SFX_System_UI_StarGift_LevelUp")
    end
  end)
  L_UI:close("pageTalentBreakConfirm")
end

function module:autoEquipRune()
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.HeroRuneEquip))
    return
  end
  local needGrantList = {}
  local slotIdList = {}
  for _, rune in ipairs(self.runeData) do
    if not rune.isEquiped then
      local isHadMaterial = L_RuneStore:checkIsCanMaterialByRuneId(rune.runeId, true)
      if isHadMaterial then
        table.insert(needGrantList, rune.runeId)
        table.insert(slotIdList, rune.slotId)
      end
    end
  end
  local isCanOneKey = 0 < #needGrantList
  if not isCanOneKey then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_moduleherotalent_01"))
    return
  end
  local slotList = {}
  local runeList = {}
  local store = C_RuneStore.GetStore()
  local isHadList, canGrantList = store:OnGetCheckAllCanGrantList(needGrantList, true, true)
  if isHadList then
    local hadCount = canGrantList.Count
    for i = 0, hadCount - 1 do
      local talentRuneId = canGrantList[i]
      if 0 < talentRuneId then
        local slotId = slotIdList[i + 1]
        table.insert(runeList, talentRuneId)
        table.insert(slotList, slotId)
      end
    end
  end
  L_UI:open("pageAutoRuneConfirm", {
    confirmCallback = function()
    end,
    cancelCallback = function()
      self.isClickLock = false
    end,
    slotIds = slotList,
    runes = runeList,
    heroGuid = self.heroGuid,
    hideConfirm = true,
    notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
  })
  return
end

function module:switchRank(jumpRuneId, isLocation)
  local hero = self:getHero(self.heroGuid)
  if L_HeroStore:getHeroRank(hero) == self.currentRank and isLocation then
    L_UI:open("pageBlank", {timeClose = 0.5})
    self:initPage({isBreak = false, forceRefesh = true})
    return
  end
  L_UI:open("pageBlank", {timeClose = 0.5})
  self:rankViewChange()
  if self.currentRank > L_HeroStore:getHeroRank(hero) then
    self.bind.rankStatusText = L_WordsTpl:getValue("ui_talent_detail_title_yulan")
  else
    self.bind.rankStatusText = L_WordsTpl:getValue("ui_talent_detail_title_yilinjie")
  end
  self:refreshCurRankImg()
  local rankTpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), self.currentRank)
  local rankBreakItems = talentRankTpl:getRankBreakthroughItem(rankTpl)
  local runeData = {}
  local runePosition = runePositions["runePosition_" .. tostring(#rankBreakItems)]
  for k, id in ipairs(rankBreakItems) do
    local tmp = {
      runeId = id,
      isEquiped = self.currentRank < L_HeroStore:getHeroRank(hero),
      heroGuid = self.heroGuid,
      slotId = k - 1,
      runePosition = runePosition["rune" .. k],
      isPreview = true,
      curRank = self.currentRank
    }
    table.insert(runeData, tmp)
  end
  for _, v in ipairs(runeData) do
    v.isInit = true
  end
  self.bind.talentRuneList:clear()
  self.bind.talentRuneList:insert_array(runeData)
  if L_HeroStore:getHeroRank(hero) == self.currentRank then
    self.runeData = runeData
  end
  for i = 1, #self.bind.talentRuneList do
    self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
  end
  self.bindComponents.heroTalentAnim:Play("anim_talent_show", 0, 0)
  self:refreshBtnsStatus(hero, rankBreakItems)
end

function module:initPage(params, preOpenInit)
  if self.isGetRankRewards then
    self.isGetRankRewards = false
    return
  end
  self.preOpenInit = preOpenInit
  self.params = params
  self.heroGuid = self:getModeController():getSelectGuid()
  self.canClose = true
  self.bind.txt_title = L_WordsTpl:getValue("ui_talent_rank_title")
  local hero = self:getHero(self.heroGuid)
  if params and not math.isEmpty(params.jumpRank) then
    self.currentRank = params.jumpRank
  else
    self.currentRank = L_HeroStore:getHeroRank(hero)
  end
  if self.currentRank > L_HeroStore:getHeroRank(hero) then
    self.bind.rankStatusText = L_WordsTpl:getValue("ui_talent_detail_title_yulan")
  else
    self.bind.rankStatusText = L_WordsTpl:getValue("ui_talent_title_current")
  end
  self:rankViewChange()
  if params and params.forceRefesh then
    self:refreshRuneList(nil, true)
  elseif params and not math.isEmpty(params.jumpRank) then
    self:refreshRuneList(nil, true)
  elseif self.lastHeroId == self.heroGuid and (params == nil or not params.isBreak) then
    self:changeRuneList()
  elseif self.lastHeroId ~= self.heroGuid and self.lastHeroId ~= nil and (params == nil or not params.isHeroRefresh) then
    self:refreshRuneList(nil, nil, true)
  elseif self.lastHeroId == nil then
    self:refreshRuneList()
  end
  if params ~= nil and params.isBreak then
    table.insert(self.timerList, Timer.once(0.1, function()
      self:refreshRuneList(true)
    end, self))
  end
  self.lastHeroId = self.heroGuid
  self.modules.moduleTalentDetail:initModule({
    heroConfigId = L_HeroStore:getHeroConfigId(hero),
    rank = L_HeroStore:getHeroRank(hero),
    runes = L_HeroStore:getHeroRuneIds(hero) or {}
  })
  self:refreshTalentReward()
end

function module:closePage()
  if self.giftRing then
    C_LuaUtility.DestroyObject(self.giftRing)
    self.giftRing = nil
  end
  self.bind.talentDetailActive = false
  self.currentRank = nil
end

function module:refreshRuneList(isBreak, isForceRefresh, isHeroRefresh)
  self.protectTime = 0
  local hero = self:getHero(self.heroGuid)
  local rankTpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), self.currentRank)
  if rankTpl == nil then
    errorf("[moduleHeroTalent] refreshRuneList: rankTpl is nil heroid:" .. L_HeroStore:getHeroConfigId(hero) .. " rank:" .. self.currentRank)
    return
  end
  local rankBreakItems = talentRankTpl:getRankBreakthroughItem(rankTpl)
  local runes = L_HeroStore:getHeroRuneIds(hero)
  self.runeData = {}
  self.slotEquiped = {}
  self.allEquiped = true
  self.slotResults = {}
  self.usedGifts = {}
  self.usedItems = {}
  self.usedCurrency = {}
  local runePosition = runePositions["runePosition_" .. tostring(#rankBreakItems)]
  for k, id in ipairs(rankBreakItems) do
    local tmp = {
      runeId = id,
      isEquiped = self.currentRank <= hero.heroRank and not math.isEmpty(runes[k]),
      heroGuid = self.heroGuid,
      slotId = k - 1,
      runePosition = runePosition["rune" .. k],
      isPreview = self.currentRank > hero.heroRank,
      curRank = self.currentRank
    }
    table.insert(self.runeData, tmp)
    if not tmp.isEquiped then
      self.allEquiped = false
    end
  end
  if isBreak then
    self:setCanClose(true)
    if self.lastTalentRuneNums < #rankBreakItems then
      for i = 1, #self.bind.talentRuneList do
        self.bind.talentRuneList:getItemCls(i):cellPlayAnim(false, "Up", 0, i * 0.066)
        self.protectTime = i * 0.066
      end
      self.protectTime = self.protectTime * 2 + 0.066
      table.insert(self.timerList, Timer.once(0.8, function()
        self.bind.talentRuneList:insert(#rankBreakItems, {})
        for i = 1, #self.bind.talentRuneList do
          self.bind.talentRuneList:change(i, self.runeData[i])
          self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
        end
      end, self))
    elseif self.lastTalentRuneNums == #rankBreakItems then
      for i = 1, #self.bind.talentRuneList do
        self.bind.talentRuneList:getItemCls(i):cellPlayAnim(false, "Up", 0, i * 0.066)
        self.protectTime = i * 0.066
      end
      self.protectTime = self.protectTime * 2
      table.insert(self.timerList, Timer.once(0.8, function()
        for i = 1, #self.bind.talentRuneList do
          self.bind.talentRuneList:change(i, self.runeData[i])
          self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
        end
      end, self))
    else
      for i = 1, #self.bind.talentRuneList do
        self.bind.talentRuneList:getItemCls(i):cellPlayAnim(false, "Up", 0, i * 0.066)
        self.protectTime = i * 0.066
      end
      self.protectTime = self.protectTime * 2 - 0.066
      table.insert(self.timerList, Timer.once(0.8, function()
        for i = #self.bind.talentRuneList, #rankBreakItems, -1 do
          self.bind.talentRuneList:remove(i)
        end
        for i = 1, #self.bind.talentRuneList do
          self.bind.talentRuneList:change(i, self.runeData[i])
          self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
        end
      end, self))
    end
    table.insert(self.timerList, Timer.once(0.43333, function()
      self.giftRingAnim:SetTrigger("Upgrade")
    end, self))
    table.insert(self.timerList, Timer.once(0.5167, function()
      self.bindComponents.heroTalentAnim:SetTrigger("Upgrade")
    end, self))
    table.insert(self.timerList, Timer.once(0.6817, function()
      self:refreshCurRankImg()
    end, self))
    table.insert(self.timerList, Timer.once(self.protectTime + 1.6, function()
      self:setCanClose(false)
    end, self))
  elseif isForceRefresh then
    for _, v in ipairs(self.runeData) do
      v.isInit = true
    end
    self.bind.talentRuneList:clear()
    self.bind.talentRuneList:insert_array(self.runeData)
    for i = 1, #self.bind.talentRuneList do
      self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
    end
    self.bindComponents.heroTalentAnim:Play("anim_talent_show", 0, 0)
    self:refreshCurRankImg()
  elseif isHeroRefresh then
    for _, v in ipairs(self.runeData) do
      v.isInit = true
    end
    self.bind.talentRuneList:clear()
    self.bind.talentRuneList:insert_array(self.runeData)
    for i = 1, #self.bind.talentRuneList do
      self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
    end
    self:refreshCurRankImg()
  else
    for _, v in ipairs(self.runeData) do
      v.isInit = true
    end
    self.bind.talentRuneList:clear()
    self.bind.talentRuneList:insert_array(self.runeData)
    if self.preOpenInit then
      self.needPlayEnterAni = true
    else
      for i = 1, #self.bind.talentRuneList do
        self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
      end
      self.bindComponents.heroTalentAnim:Play("anim_talent_show", 0, 0)
    end
    self:refreshCurRankImg()
  end
  self.lastTalentRuneNums = #rankBreakItems
  self.hero = hero
  self.rankBreakItems = rankBreakItems
  self:refreshBtnsStatus(hero, rankBreakItems)
end

function module:changeRuneList()
  local hero = self:getHero(self.heroGuid)
  local rankTpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), L_HeroStore:getHeroRank(hero))
  local rankBreakItems = talentRankTpl:getRankBreakthroughItem(rankTpl)
  local runes = L_HeroStore:getHeroRuneIds(hero)
  self.runeData = {}
  self.allEquiped = true
  local runePosition = runePositions["runePosition_" .. tostring(#rankBreakItems)]
  self:setCanClose(true)
  for k, id in ipairs(rankBreakItems) do
    local tmp = {
      runeId = id,
      isEquiped = not math.isEmpty(runes[k]),
      heroGuid = self.heroGuid,
      slotId = k - 1,
      runePosition = runePosition["rune" .. k],
      curRank = self.currentRank
    }
    table.insert(self.runeData, tmp)
    if #self.bind.talentRuneList == #rankBreakItems then
      self.bind.talentRuneList:change(k, tmp)
    end
    if not tmp.isEquiped then
      self.allEquiped = false
    end
  end
  if #self.bind.talentRuneList ~= #rankBreakItems then
    self.bind.talentRuneList:clear()
    self.bind.talentRuneList:insert_array(self.runeData)
  end
  self.protectTime = 0
  for i = 1, #rankBreakItems do
    self.protectTime = i * 0.1
  end
  table.insert(self.timerList, Timer.once(1.6 + self.protectTime, function()
    self:setCanClose(false)
  end, self))
  self.hero = hero
  self.rankBreakItems = rankBreakItems
  self:refreshBtnsStatus(hero, rankBreakItems)
end

function module:refreshBtnsStatus(hero, rankBreakItems)
  if hero == nil or rankBreakItems == nil then
    return
  end
  local maxRank = talentRankTpl:getHeroMaxRankNum(L_HeroStore:getHeroConfigId(hero))
  local isMax = maxRank <= L_HeroStore:getHeroRank(hero)
  local isCurrent = self.currentRank == L_HeroStore:getHeroRank(hero)
  self.lastTalentRuneNums = #rankBreakItems
  self.bind.equipBtnActive = not self.allEquiped and isCurrent
  self.bind.breakBtnActive = not isMax and self.allEquiped and isCurrent
  self.bind.maxNodeActive = isMax and table.count(rankBreakItems) == 0 and isCurrent
  self.bind.equipNodeActive = not self.bind.maxNodeActive
  self.bind.backCurrentBtnActive = not isCurrent
  if not isCurrent then
    self.bind.activeRankMax = false
    self.modules.backCurrentBtn:setData({
      txtName = L_WordsTpl:getValue("ui_talent_back_current_rank"),
      callback = function()
        L_UI:open("pageBlank", {timeClose = 0.5})
        self:initPage({isBreak = false, forceRefesh = true})
      end,
      {activeBg = true}
    })
  end
  self:initEquipBtn()
  self:initBreakBtn()
end

function module:initEquipBtn()
  if self.runeData == nil then
    return
  end
  local needCost = 0
  for _, rune in ipairs(self.runeData) do
    if not rune.isEquiped then
      local runeTpl = talentRuneTpl:getTplById(rune.runeId)
      local cost = talentRuneTpl:getEquipRuneThroughCoin(runeTpl)
      needCost = needCost + cost
    end
  end
  local btnName = L_WordsTpl:getValue("ui_hero_rune_quick_equip")
  self.isLackEquipGold = needCost > L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold)
  if self.bind.equipBtnActive then
    self.modules.equipBtn:setData({
      txtName = btnName,
      callback = handler(self, self.autoEquipRune),
      itemType = L_Const.resType.currency,
      itemId = L_Const.currencyType.gold,
      activeBg = true,
      txt_cost = needCost
    })
  end
end

function module:SetBreakBtnDate(name, func)
  self.modules.breakBtn:setData({txtName = name, callback = func})
end

function module:initBreakBtn()
  local hero = self:getHero(self.heroGuid)
  local curRank = L_HeroStore:getHeroRank(hero)
  if curRank ~= self.currentRank then
    self.bind.active_unlockDesBg = false
    return
  end
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local rankTpl = talentRankTpl:getHeroRankTpl(heroConfigId, curRank)
  self.rankBreakMaterialList = talentRankTpl:getRankBreakthroughCoin(rankTpl)
  local isHadThroughNum = L_GameUtil.getIsHadItemListNum(self.rankBreakMaterialList)
  local maxRank = talentRankTpl:getHeroMaxRankNum(heroConfigId)
  if self.bind.breakBtnActive then
    local rankPlus = talentRankTpl:getHeroRankTpl(heroConfigId, curRank + 1)
    local rankLevellimit = talentRankTpl:getRankLevelLimit(rankPlus)
    local level = L_HeroStore:getHeroLevel(hero)
    self.bind.active_break_redDot = isHadThroughNum and curRank < maxRank and rankLevellimit <= level
    if rankLevellimit > level then
      self:SetBreakBtnDate(L_WordsTpl:getValue("ui_text_btn_hero_stargift_level_jump"), function()
        L_GameUtil.showCommonTip({
          txtContent = L_WordsTpl:getValue("notice_stargift_jump"),
          confirmCallback = function()
            L_HeroManager:showHeroSelection(L_Const.heroModuleType.Property, L_HeroStore:getHeroGuid(hero), {openLevelUp = true})
          end
        })
      end)
      self.bind.txt_unlockDes = L_WordsTpl:getValue("ui_text_hero_stargift_rank_up_limit", {
        [0] = L_GameUtil.fillColor(rankLevellimit, "#FFA200")
      })
      self.bind.active_unlockDesBg = true
    else
      self:SetBreakBtnDate(L_WordsTpl:getValue("ui_hero_rune_level_up"), function()
        L_UI:open("pageTalentBreakConfirm", {
          confirmCallback = function()
            self:onBreakBtnClicked()
          end,
          heroGuid = self.heroGuid,
          txtTitle = L_WordsTpl:getValue("ui_talent_rank_up_ui"),
          hideConfirm = true
        })
      end)
      self.bind.active_unlockDesBg = false
    end
  else
    self.bind.active_unlockDesBg = false
  end
  local isShowUnlock = curRank >= maxRank and not self.bind.breakBtnActive and not self.bind.equipBtnActive and not self.bind.backCurrentBtnActive
  self.bind.unlockDes = isShowUnlock and L_WordsTpl:getValue("notice_hero_rankMax") or ""
  self.bind.activeRankMax = isShowUnlock
  self.bind.rankMaxBtnInteractable = true
  if isShowUnlock then
    self.modules.rankMaxBtn:setData({
      txtName = L_WordsTpl:getValue("notice_hero_rankMax"),
      alphaValue = 0.7
    })
    self.bind.rankMaxBtnInteractable = false
  end
  self.bindComponents.rankMaxBtnAnimator:Play("Disabled", 0, 0)
end

function module:setCanClose(canClose)
  self.canClose = not canClose
  self.parent:setMaskActive(canClose)
end

function module:getCanClose()
  return self.canClose
end

function module:getTimelineState()
  return L_Const.heroTimelineState.Skill
end

function module:rankViewChange()
  if not self.heroGuid then
    return
  end
  if not self.currentRank then
    self.currentRank = 1
  end
  local hero = L_HeroStore:getHero(self.heroGuid)
  local maxRank = talentRankTpl:getHeroMaxVisibleRankNum(L_HeroStore:getHeroConfigId(hero))
  self.bind.active_nextRankBtn = maxRank > self.currentRank
  self.bind.active_previousRankBtn = self.currentRank > 1
end

function module:refreshCurRankImg()
  if not self.heroGuid then
    return
  end
  if not self.currentRank then
    self.currentRank = 1
  end
  self.bind.curRank = string.format(rankImgPath, self.currentRank >= 10 and tostring(self.currentRank) or "0" .. tostring(self.currentRank))
end

function module:playEnterAni()
  self.needHideRing = false
  if self.giftRingAnim then
    self.giftRingAnim.gameObject:SetActive(true)
    self.giftRingAnim:SetTrigger("In")
  end
  if self.needPlayEnterAni then
    self.needPlayEnterAni = false
    for i = 1, #self.bind.talentRuneList do
      self.bind.talentRuneList:getItemCls(i):cellPlayAnim(true, "Show", 0, i * 0.066)
    end
    self.bindComponents.heroTalentAnim:Play("anim_talent_show", 0, 0)
  end
end

function module:setNeedHide()
  if self.giftRingAnim then
    self.giftRingAnim.gameObject:SetActive(false)
  else
    self.needHideRing = true
  end
end

return module
