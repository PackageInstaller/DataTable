local function modelState(awakerId)
  local state = {}
  
  state.maxLv = 0
  state.minLv = 0
  state.awakerId = awakerId
  state.selectLv = 0
  state.rewardList = {}
  state.breakthroughLevel = 0
  return state
end

local function modelView(data)
  local view = {}
  
  function view:GetMaxLv()
    return data.maxLv
  end
  
  function view:GetMinLv()
    return data.minLv
  end
  
  function view:GetSelectAwakerId()
    return data.awakerId
  end
  
  function view:GetSelectLv()
    return data.selectLv
  end
  
  function view:HasReward()
    do return self._HasReward, self end
    return self._HasReward, self, self.selectLv
  end
  
  function view:_HasReward(lv)
    local awakerId = self.awakerId
    local awaker = AwakerDataUtils.GetAwakerData(awakerId)
    if not awaker then
      return 0
    end
    local favorabilityCfg = DT.AwakerFavorability[awakerId]
    local lvCfg = favorabilityCfg.data_list[lv]
    return lvCfg.Reward and #lvCfg.Reward > 0
  end
  
  function view:GetRewardList()
    return self.rewardList
  end
  
  function view:RewardCanGet()
    local lv = self:GetSelectLv()
    do return self._RewardCanGet, self end
    return self._RewardCanGet, self, lv
  end
  
  function view:_RewardCanGet(lv)
    local awaker = AwakerDataUtils.GetAwakerData(self.awakerId)
    if not awaker then
      return 0
    end
    local state = awaker.likeReward[lv]
    if not state then
      return false
    end
    return state == CommonDefine.AffectionRewardState.CanGain
  end
  
  function view:UnlockReward()
    return self:GetAwakerLikeLv() >= self:GetSelectLv()
  end
  
  function view:GetAwakerLike()
    local total = self:GetTotalNeedExp(self:GetAwakerLikeLv())
    return total + AwakerAffectDataUtils.GetAwakerLike(self.awakerId)
  end
  
  function view:GetAwakerLv()
    do return AwakerAffectDataUtils.GetAwakerLv end
    return AwakerAffectDataUtils.GetAwakerLv, self.awakerId
  end
  
  function view:GetAwakerLikeLv()
    do return AwakerAffectDataUtils.GetAwakerLikeLv end
    return AwakerAffectDataUtils.GetAwakerLikeLv, self.awakerId
  end
  
  function view:GetAwakerPotencyLv()
    AwakerAffectDataUtils.GetAwakerPotencyLv(self.awakerId)
  end
  
  function view:GetTotalNeedExp(level)
    local awakerId = self.awakerId
    local cfg = DT.AwakerFavorability[awakerId]
    local datalist = cfg.data_list
    local totalNeed = 0
    for _, v in ipairs(datalist) do
      if level >= v.AwakerFavorabilityLevel then
        totalNeed = totalNeed + v.AwakerFavorabilityRequire
      end
    end
    return totalNeed
  end
  
  function view:GetBreakthroughLevel()
    return data.breakthroughLevel
  end
  
  function view:IsBreakthroughAvailable()
    do return AwakerFavorabilityCfgUtils.CanBreakthrough, self.awakerId, self:GetSelectLv() end
    return AwakerFavorabilityCfgUtils.CanBreakthrough, self.awakerId, self:GetSelectLv()
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:UpdateMaxAndMinLv()
    local minLv = 0
    local maxLv = 0
    local awakerId = self.awakerId
    local cfg = DT.AwakerFavorability[awakerId]
    local datalist = cfg.data_list
    for _, v in ipairs(datalist) do
      if 0 == minLv and v.AwakerFavorabilityLevel > 1 then
        minLv = v.AwakerFavorabilityLevel
      end
      maxLv = v.AwakerFavorabilityLevel
    end
    self:SetMinLv(minLv)
    self:SetMaxLv(maxLv)
  end
  
  function action:SetMaxLv(maxLv)
    data.maxLv = maxLv
  end
  
  function action:SetMinLv(minLv)
    data.minLv = minLv
  end
  
  function action:SetSelectAwakerId(awakerId)
    data.awakerId = awakerId
  end
  
  function action:UpdateAwakerlikeReward(state)
    AwakerDataUtils.UpdateAwakerlikeReward(self.awakerId, self.selectLv, state)
  end
  
  function action:SetSelectLv(selectLv)
    data.selectLv = selectLv
    self:UpdateRewardList()
    if AwakerFavorabilityCfgUtils.HasBreakoutCost(self.awakerId, selectLv) and AwakerFavorabilityCfgUtils.CanBreakthrough(self.awakerId, selectLv) and AwakerFavorabilityCfgUtils.HasEnoughBreakoutItems(self.awakerId, selectLv) then
      RedPointDataUtils.MarkAwakerAffectionBreakthroughSeen(self.awakerId)
      EventMgr.Instance.AwakerAffecttionEvent:Dispatch()
    end
  end
  
  function action:UpdateBreakthroughLevel()
    data.breakthroughLevel = AwakerFavorabilityCfgUtils.GetBreakthroughLevel(self.awakerId)
  end
  
  function action:UpdateRewardList()
    local rewardList = {}
    local awaker = AwakerDataUtils.GetAwakerData(self.awakerId)
    if not awaker then
      self.rewardList = rewardList
      return
    end
    local awakerId = self.awakerId
    local favorabilityCfg = DT.AwakerFavorability[awakerId]
    local lvCfg = favorabilityCfg.data_list[self.selectLv]
    if lvCfg.Reward then
      for i = 1, #lvCfg.Reward, 2 do
        local itemId = lvCfg.Reward[i]
        local itemNum = lvCfg.Reward[i + 1]
        table.insert(rewardList, {itemId, itemNum})
      end
    end
    self.rewardList = rewardList
  end
  
  return action
end

local function onSetup(binder, model)
  model:UpdateMaxAndMinLv()
  model:UpdateBreakthroughLevel()
  local awakerId = model.awakerId
  local cfg = DT.AwakerFavorability[awakerId]
  local datalist = cfg.data_list
  for _, v in ipairs(datalist) do
    local lv = v.AwakerFavorabilityLevel
    local hasReward = model:_HasReward(lv)
    local canGet = model:_RewardCanGet(lv)
    if hasReward and canGet then
      model:SetSelectLv(lv)
      return
    end
  end
  local curLv = model:GetAwakerLikeLv()
  local maxLv = model:GetMaxLv()
  local showLv = curLv + 1
  if maxLv < showLv then
    showLv = maxLv
  end
  model:SetSelectLv(showLv)
end

do return Vue.model("AwakerAffectionModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("AwakerAffectionModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("AwakerAffectionModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("AwakerAffectionModel", modelState):views(modelView):actions(modelAction), onSetup
