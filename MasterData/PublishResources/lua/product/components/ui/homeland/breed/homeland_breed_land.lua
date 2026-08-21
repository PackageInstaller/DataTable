_class("HomelandBreedLand", HomeBuilding)
HomelandBreedLand = HomelandBreedLand

function HomelandBreedLand:Constructor(insID, architecture, cfg)
  self._isInited = false
end

function HomelandBreedLand:InitBreedLand(architecture)
  if self._isInited then
    return
  end
  self._uiModule = GameGlobal.GetUIModule(HomelandModule)
  self._isVisit = self._uiModule:GetClient():IsVisit()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._pstid = architecture.pstid
  self._breedTask = nil
  self._curPhases = 0
  self._finalPhases = 3
  self._phasesArray = nil
  self._endTime = 0
  self._totalTime = 0
  self._tree = nil
  self._breedCfg = Cfg.cfg_homeland_breed_const[1]
  self._landEffectReqs = {}
  self._landEffectObjs = {}
  self:_InitLandEffect()
  self._sprite = HomelandBreedLandSprite:New(self:Transform(), self._breedCfg)
  self:_InitTree()
  self:_InitVisitEft()
  self._isInited = true
  if not self._friendSpeedCallBack then
    self._friendSpeedCallBack = GameHelper:GetInstance():CreateCallback(self._OnFriendSpeed, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandFriendSpeed, self._friendSpeedCallBack)
  end
end

function HomelandBreedLand:Dispose()
  HomelandBreedLand.super.Dispose(self)
  self._curPhases = 0
  self._finalPhases = 3
  self._phasesArray = nil
  self._endTime = 0
  self._totalTime = 0
  self:_DestroyTree()
  if self._phasesCheckTimer then
    GameGlobal.Timer():CancelEvent(self._phasesCheckTimer)
    self._phasesCheckTimer = nil
  end
  if self._sprite then
    self._sprite:Dispose()
    self._sprite = nil
  end
  for _, req in pairs(self._landEffectReqs) do
    req:Dispose()
  end
  self._landEffectReqs = nil
  for _, obj in pairs(self._landEffectObjs) do
    obj:Destroy()
  end
  self._landEffectObjs = nil
  if self._breedTask then
    GameGlobal.TaskManager():KillTask(self._breedTask)
    self._breedTask = nil
  end
  if self._waterEffReq then
    self._waterEft = nil
    self._waterEffReq:Dispose()
    self._waterEffReq = nil
  end
  if self._friendSpeedCallBack then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandFriendSpeed, self._friendSpeedCallBack)
    self._friendSpeedCallBack = nil
  end
end

function HomelandBreedLand:PlantTree()
  self._curPhases = 0
  self._finalPhases = 3
  self._phasesArray = nil
  self._endTime = 0
  self._totalTime = 0
  self:_DestroyTree()
  if self._breedTask then
    GameGlobal.TaskManager():KillTask(self._breedTask)
    self._breedTask = nil
  end
  self._breedTask = GameGlobal.TaskManager():StartTask(function(TT)
    self._cultivationInfo = nil
    if self._isVisit then
      self._cultivationInfo = self._uiModule:GetVisitInfo().cultivation_info
    else
      self._cultivationInfo = self._homelandModule:GetHomelandInfo().cultivation_info
    end
    self._landCultivationInfo = self._cultivationInfo.land_cultivation_infos[self._pstid]
    if self._landCultivationInfo then
      local seedId, treeId
      if #self._landCultivationInfo.client_info.mutation_cultivation > 0 then
        seedId = self._landCultivationInfo.client_info.mutation_cultivation[1].main_seed_id
      elseif 0 < #self._landCultivationInfo.client_info.directional_cultivation then
        seedId = self._landCultivationInfo.client_info.directional_cultivation[1].seed_id
      elseif 0 < #self._landCultivationInfo.client_info.state_change_cultivation then
        treeId = self._landCultivationInfo.client_info.state_change_cultivation[1].tree_id
      end
      if seedId or treeId then
        local roleAsset = self._landCultivationInfo.cultivation_result
        if 0 < #roleAsset then
          self._cfgResultTree = Cfg.cfg_item_tree_attribute[roleAsset[1].assetid]
        end
      end
      if seedId then
        local cfg_seed = Cfg.cfg_item_tree_seed[seedId]
        self._cfgSeedTree = Cfg.cfg_item_tree_attribute[cfg_seed.TreeId]
        self._finalPhases = #self._cfgResultTree.PhasesModel
        local phases, nextTime = self:_CalcPhases()
        self._curPhases = phases
        self:OnPhaseChange(TT, self._curPhases, self._cfgResultTree.PhasesModel[self._curPhases])
        local startLoopTime = self._breedCfg.LoopInterval + math.random(self._breedCfg.RandomValue[1], self._breedCfg.RandomValue[2])
        YIELD(TT, startLoopTime)
        self:_AutoLoop()
        if 0 < nextTime then
          self._phasesCheckTimer = GameGlobal.Timer():AddEvent(nextTime * 1000, self._PhasesCheck, self)
        end
      end
      if treeId and self._cfgResultTree then
        self:SimulateTreeStateChg(TT)
      end
    end
  end)
end

function HomelandBreedLand:RefreshPhases()
  self._cultivationInfo = nil
  if self._isVisit then
    self._cultivationInfo = self._uiModule:GetVisitInfo().cultivation_info
  else
    self._cultivationInfo = self._homelandModule:GetHomelandInfo().cultivation_info
  end
  self._landCultivationInfo = self._cultivationInfo.land_cultivation_infos[self._pstid]
  self._endTime = self._homelandModule:GetLandEndTime(self._landCultivationInfo)
  self:_PhasesCheck()
end

function HomelandBreedLand:Clear()
  if self._waterEffReq then
    self._waterEft = nil
    self._waterEffReq:Dispose()
    self._waterEffReq = nil
  end
  for key, _ in pairs(HomelandBreedLandEffect) do
    self._landEffectObjs[key]:SetActive(false)
  end
  if self._breedTask then
    GameGlobal.TaskManager():KillTask(self._breedTask)
    self._breedTask = nil
  end
  if self._loopTask then
    GameGlobal.TaskManager():KillTask(self._loopTask)
    self._loopTask = nil
  end
  self._sprite:ShowSprite(false)
  self:_DestroyTree()
  self._cfgSeedTree = nil
  self._cfgResultTree = nil
  self._curPhases = 0
  self._landCultivationInfo = nil
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBreedPhasesChange)
end

function HomelandBreedLand:_InitTree()
  self._cultivationInfo = nil
  if self._isVisit then
    self._cultivationInfo = self._uiModule:GetVisitInfo().cultivation_info
  else
    self._cultivationInfo = self._homelandModule:GetHomelandInfo().cultivation_info
  end
  self._landCultivationInfo = self._cultivationInfo.land_cultivation_infos[self._pstid]
  if self._landCultivationInfo then
    local seedId, treeId
    if #self._landCultivationInfo.client_info.mutation_cultivation > 0 then
      seedId = self._landCultivationInfo.client_info.mutation_cultivation[1].main_seed_id
    elseif 0 < #self._landCultivationInfo.client_info.directional_cultivation then
      seedId = self._landCultivationInfo.client_info.directional_cultivation[1].seed_id
    elseif 0 < #self._landCultivationInfo.client_info.state_change_cultivation then
      treeId = self._landCultivationInfo.client_info.state_change_cultivation[1].tree_id
    end
    if seedId or treeId then
      local roleAsset = self._landCultivationInfo.cultivation_result
      if 0 < #roleAsset then
        self._cfgResultTree = Cfg.cfg_item_tree_attribute[roleAsset[1].assetid]
      end
    end
    if seedId then
      local cfg_seed = Cfg.cfg_item_tree_seed[seedId]
      self._cfgSeedTree = Cfg.cfg_item_tree_attribute[cfg_seed.TreeId]
      self._finalPhases = #self._cfgResultTree.PhasesModel
      local phases, nextTime = self:_CalcPhases()
      self._curPhases = phases
      self:_LoadTree(self._cfgResultTree.PhasesModel[self._curPhases])
      self:_AutoLoop()
      if 0 < nextTime then
        self._phasesCheckTimer = GameGlobal.Timer():AddEvent(nextTime * 1000, self._PhasesCheck, self)
      end
    end
    if treeId then
      if self._cfgResultTree then
        self._finalPhases = #self._cfgResultTree.PhasesModel
        self._curPhases = self._finalPhases
        self:_LoadTree(self._cfgResultTree.PhasesModel[self._finalPhases])
      else
        Log.error("stateChange cultiviation error, result is nil")
      end
    end
  end
end

function HomelandBreedLand:_LoadTree(name)
  if not name then
    Log.error("HomelandBreedLand Error. CurPhases " .. self._curPhases)
    return
  end
  self._treeReq = ResourceManager:GetInstance():SyncLoadAsset(name .. ".prefab", LoadType.GameObject)
  if self._treeReq and self._treeReq.Obj then
    self._tree = self._treeReq.Obj
    self._tree:SetActive(true)
    self._tree.transform:SetParent(self:Transform())
    self._tree.transform.localPosition = Vector3.zero
    self._tree.transform.localRotation = Quaternion.Euler(0, 0, 0)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBreedPhasesChange)
end

function HomelandBreedLand:_DestroyTree()
  if self._tree then
    self._tree:Destroy()
    self._tree = nil
  end
  if self._treeReq then
    self._treeReq:Dispose()
    self._treeReq = nil
  end
  if self._phasesCheckTimer then
    GameGlobal.Timer():CancelEvent(self._phasesCheckTimer)
    self._phasesCheckTimer = nil
  end
end

function HomelandBreedLand:_CalcPhases()
  local curPhases = self._curPhases
  local nextTime = 0
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  if not self._phasesArray then
    local cfg = Cfg.cfg_homeland_rarity({
      Species = self._cfgSeedTree.Species,
      Rarity = self._cfgSeedTree.Rarity
    })
    self._phasesArray = {}
    local n = 0
    for key, _phases in pairs(cfg[1].Phases) do
      self._phasesArray[key] = {n, _phases}
      n = _phases
    end
    self._endTime = self._homelandModule:GetLandEndTime(self._landCultivationInfo)
    self._totalTime = 0
    if 0 < #self._landCultivationInfo.client_info.mutation_cultivation then
      self._totalTime = cfg[1].MutationTime
    end
    if 0 < #self._landCultivationInfo.client_info.directional_cultivation then
      self._totalTime = cfg[1].DirectionalTime
    end
  end
  local remainTime = self._endTime - curTime
  if 0 <= remainTime then
    local percent = math.abs(1 - remainTime / self._totalTime) * 100
    if 100 < percent then
      percent = 100
    end
    for _phases, value in pairs(self._phasesArray) do
      if percent > value[1] and percent <= value[2] then
        curPhases = _phases
      end
    end
    if curPhases < #self._phasesArray then
      local p = curPhases + 1
      local time = self._phasesArray[p][1] * 0.01 * self._totalTime
      nextTime = time - percent * 0.01 * self._totalTime
    end
  else
    curPhases = self._finalPhases
  end
  Log.info("HomelandBreedLand CalcPhases " .. curPhases .. ", " .. nextTime)
  return curPhases, nextTime
end

function HomelandBreedLand:_PhasesCheck()
  if self._curPhases >= self._finalPhases then
    return
  end
  local phases, nextTime = self:_CalcPhases()
  if phases ~= self._curPhases then
    self._curPhases = phases
    if self._breedTask then
      GameGlobal.TaskManager():KillTask(self._breedTask)
      self._breedTask = nil
    end
    self._breedTask = GameGlobal.TaskManager():StartTask(function(TT)
      self:OnPhaseChange(TT, self._curPhases, self._cfgResultTree.PhasesModel[self._curPhases])
      if 0 < nextTime then
        self._phasesCheckTimer = GameGlobal.Timer():AddEvent(nextTime * 1000, self._PhasesCheck, self)
      end
    end)
  elseif self._phasesCheckTimer and 0 < nextTime then
    GameGlobal.Timer():CancelEvent(self._phasesCheckTimer)
    self._phasesCheckTimer = GameGlobal.Timer():AddEvent(nextTime * 1000, self._PhasesCheck, self)
  end
end

function HomelandBreedLand:GetCurPhases()
  return self._curPhases
end

function HomelandBreedLand:GetCurTree()
  return self._cfgResultTree
end

function HomelandBreedLand:GetRemainTime()
  return self._endTime - self._svrTimeModule:GetServerTime() * 0.001
end

function HomelandBreedLand:InBreeding()
  return self._curPhases > 0
end

function HomelandBreedLand:IsMature()
  return self._curPhases >= self._finalPhases
end

function HomelandBreedLand:_InitVisitEft()
  local uiModule = GameGlobal.GetUIModule(HomelandModule)
  if uiModule:GetClient():IsVisit() then
    local info = uiModule:GetVisitInfo().cultivation_info
    local landInfo = info.land_cultivation_infos[self:PstID()]
    if landInfo and not self:IsMature() and not self:Visit_IsWatered() then
      local offset
      if self._curPhases == 0 then
        offset = Vector3(0, 0, 0)
      elseif self._curPhases == 1 then
        offset = Vector3(0, 0.2, 0)
      elseif self._curPhases == 2 then
        offset = Vector3(0, 0.5, 0)
      else
        offset = Vector3(0, 0, 0)
      end
      self._waterEffReq = ResourceManager:GetInstance():SyncLoadAsset("eff_jy_meme_jiaoshui.prefab", LoadType.GameObject)
      self._waterEft = self._waterEffReq.Obj
      self._waterEft:SetActive(true)
      local t = self._waterEft.transform
      t.position = self._pos + offset
      local anim = self._waterEft:GetComponent(typeof(UnityEngine.Animation))
      anim:PlayQueued("effanim_hl_meme_jiaoshui_in", UnityEngine.QueueMode.PlayNow)
      anim:PlayQueued("effanim_hl_meme_jiaoshui_loop", UnityEngine.QueueMode.CompleteOthers)
    end
  end
end

function HomelandBreedLand:HideWaterEft(TT)
  if not self._waterEft then
    return
  end
  local anim = self._waterEft:GetComponent(typeof(UnityEngine.Animation))
  anim:Play("effanim_hl_meme_jiaoshui_out")
  YIELD(TT, 300)
  if not self._active then
    return
  end
  if self._waterEffReq then
    self._waterEft = nil
    self._waterEffReq:Dispose()
    self._waterEffReq = nil
  end
end

function HomelandBreedLand:OnPhaseChange(TT, phases, name)
  if phases == 3 and self._loopTask then
    GameGlobal.TaskManager():KillTask(self._loopTask)
    self._loopTask = nil
  end
  if self._sprite then
    self._sprite:ShowSprite(false)
  end
  if self._sprite and not self._isVisit then
    self._sprite:ShowSprite(true)
    self._sprite:PlayAnimation("zhaohuan")
    self._sprite:PlayEffect("zhaohuan")
  end
  YIELD(TT, 2000)
  if self._sprite and not self._isVisit then
    self._sprite:PlayAnimation("shifei")
    self._sprite:PlayEffect("shifei")
  end
  YIELD(TT, 2100)
  if phases == 1 then
    if not self._isVisit then
      self._landEffectObjs.p1:SetActive(true)
    end
    YIELD(TT, 200)
    self:_DestroyTree()
    self:_LoadTree(name)
    YIELD(TT, 1000)
    self._landEffectObjs.p1:SetActive(false)
    YIELD(TT, 1000)
    if self._sprite and not self._isVisit then
      self._sprite:ShowSprite(false)
      self._sprite:PlayEffect("xiaoshi")
    end
  elseif phases == 2 then
    if not self._isVisit then
      self._landEffectObjs.p2:SetActive(true)
    end
    local animation = self._landEffectObjs.p2:GetComponent(typeof(UnityEngine.Animation))
    if animation then
      animation:Play("effanim_jy_pt_bianhuan")
    end
    self:_DestroyTree()
    self:_LoadTree(name)
    YIELD(TT, 2500)
    self._landEffectObjs.p2:SetActive(false)
    if self._sprite and not self._isVisit then
      self._sprite:ShowSprite(false)
      self._sprite:PlayEffect("xiaoshi")
    end
  elseif phases == 3 then
    if self._sprite and not self._isVisit then
      self._sprite:ShowSprite(false)
      self._sprite:PlayEffect("xiaoshi")
    end
    YIELD(TT, 500)
    if not self._isVisit then
      self._landEffectObjs.p3:SetActive(true)
    end
    local animation = self._landEffectObjs.p3:GetComponent(typeof(UnityEngine.Animation))
    if animation then
      animation:Play("effanim_jy_pt_bianhuan")
    end
    YIELD(TT, 100)
    self:_DestroyTree()
    self:_LoadTree(name)
    YIELD(TT, 2700)
    self._landEffectObjs.p3:SetActive(false)
  end
end

function HomelandBreedLand:_AutoLoop()
  if self._isVisit then
    return
  end
  if self._curPhases == 3 then
    if self._loopTask then
      GameGlobal.TaskManager():KillTask(self._loopTask)
      self._loopTask = nil
    end
    return
  end
  if self._breedCfg then
    self._loopTask = GameGlobal.TaskManager():StartTask(function(TT)
      local nextTime = self._breedCfg.LoopInterval + math.random(self._breedCfg.RandomValue[1], self._breedCfg.RandomValue[2])
      YIELD(TT, nextTime * 1000)
      if self._sprite then
        self._sprite:ShowSprite(true)
        self._sprite:PlayAnimation("zhaohuan")
        self._sprite:PlayEffect("zhaohuan")
      end
      YIELD(TT, 2000)
      if self._sprite then
        self._sprite:ShowSprite(true)
        self._sprite:PlayAnimation("jiaoshui")
        self._sprite:PlayEffect("jiaoshui")
      end
      YIELD(TT, 6000)
      if self._sprite then
        self._sprite:ShowSprite(false)
        self._sprite:PlayEffect("xiaoshi")
      end
      self:_AutoLoop()
    end)
  end
end

function HomelandBreedLand:_InitLandEffect()
  for key, value in pairs(HomelandBreedLandEffect) do
    local req = ResourceManager:GetInstance():SyncLoadAsset(value, LoadType.GameObject)
    local obj
    if req and req.Obj then
      obj = req.Obj
      obj.transform:SetParent(self:Transform())
      obj.transform.localPosition = Vector3.zero
      obj.transform.localRotation = Quaternion.Euler(0, 0, 0)
      obj:SetActive(false)
    end
    self._landEffectReqs[key] = req
    self._landEffectObjs[key] = obj
  end
end

function HomelandBreedLand:Visit_IsWatered()
  local list = self._homelandModule:GetHomelandInfo().visit_info.cultivation_list
  return table.icontains(list, self:PstID())
end

function HomelandBreedLand:_OnFriendSpeed(pstId)
  if self._pstid == pstId then
    self:RefreshPhases()
  end
end

function HomelandBreedLand:SimulateTreeStateChg(TT)
  if not self._cfgResultTree then
    return
  end
  self._finalPhases = #self._cfgResultTree.PhasesModel
  self._curPhases = self._finalPhases - 1
  if self._isVisit then
    self._curPhases = self._finalPhases
    self:_LoadTree(self._cfgResultTree.PhasesModel[self._finalPhases])
    return
  end
  self:ResetInteractPoint()
  self:_LoadTree(self._cfgResultTree.PhasesModel[self._curPhases])
  self._curPhases = self._finalPhases
  self:OnPhaseChange(TT, self._curPhases, self._cfgResultTree.PhasesModel[self._curPhases])
  self:RefreshInteractPoint()
end
