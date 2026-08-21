_class("UIHomelandModule", UIModule)
UIHomelandModule = UIHomelandModule

function UIHomelandModule:Constructor()
  self._running = false
  self._homelandClient = nil
  self._visitInfo = nil
  self._uiVisitInfo = nil
  self._levelUpCache = 0
  self._enterCallback = nil
end

function UIHomelandModule:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function UIHomelandModule:CloseDialog(name)
  GameGlobal.UIStateManager():CloseDialog(name)
end

function UIHomelandModule:IsRunning()
  return self._running
end

function UIHomelandModule:Update(curTick)
  self._homelandClient:Update(curTick)
end

function UIHomelandModule:LoadHomeland()
  HomeLoading.Self()
end

function UIHomelandModule:LoadHomelandScene()
  HomeLoading.Self_Art()
end

function UIHomelandModule:EnterHomeland(TT, isVisit)
  Log.debug("[homeland loading] UIHomelandModule EnterHomeland start")
  self:AttachEvent(GameEventType.BeforeRelogin, self.LeaveHomeland)
  if isVisit then
    self._homelandClient = HomelandVisitClient:New()
  else
    self._homelandClient = HomelandClient:New()
  end
  self._homelandClient:Init(TT)
  self._homelandClient:OnEnterHomeland()
  self._running = true
  self:AttachEvent(GameEventType.HomelandLevelOnLevelInfoChange, self._OnLevelInfoChanged)
  Log.debug("[homeland loading] UIHomelandModule EnterHomeland end")
end

function UIHomelandModule:SetEnterCallback(callback)
  self._enterCallback = callback
end

function UIHomelandModule:GetEnterCallback()
  return self._enterCallback
end

function UIHomelandModule:LeaveHomeland()
  self:ClearLevelupTip()
  self:DetachEvent(GameEventType.HomelandLevelOnLevelInfoChange, self._OnLevelInfoChanged)
  self:DetachEvent(GameEventType.BeforeRelogin, self.LeaveHomeland)
  MovieFatherSon:Dispose()
  self._homelandClient:Dispose()
  self._homelandClient = nil
  self._visitInfo = nil
  self._uiVisitInfo = nil
  self._running = false
end

function UIHomelandModule:GetClient()
  return self._homelandClient
end

function UIHomelandModule:SetEventInfo(list, num)
  self._eventList = list
  self._eventNum = num
end

function UIHomelandModule:GetEventInfo()
  return self._eventList, self._eventNum
end

function UIHomelandModule:SetVisitInfo(info)
  self._visitInfo = info
  if info then
    self._uiVisitInfo = UIHomeVisitInfo:New(info)
  end
  HomelandVisitHelper.RefreshVistAquariumFish()
end

function UIHomelandModule:GetVisitInfo()
  return self._visitInfo
end

function UIHomelandModule:GetVisitPoolInfo()
  if self._visitInfo then
    return self._visitInfo.wishing_pool_info
  end
  return nil
end

function UIHomelandModule:GetVisitUIInfo()
  return self._uiVisitInfo
end

function UIHomelandModule:ReqFriendList(TT)
  local needReq = false
  local now = GetSvrTimeNow()
  if self._reqFriendTime then
    if now - self._reqFriendTime > 60 then
      needReq = true
    end
  else
    needReq = true
  end
  if needReq then
    local allFriends = GameGlobal.GetModule(SocialModule):GetFriendList(TT)
    if not allFriends then
      Log.fatal("获取所有好友列表失败")
      return nil
    end
    local module = GameGlobal.GetModule(HomelandModule)
    local fres, fdata = module:HomelandVisitListReq(TT)
    if not fres:GetSucc() then
      Log.fatal("获取家园好友列表失败：", fres:GetResult())
      ToastManager.ShowHomeToast(module:GetVisitErrorMsg(fres:GetResult()))
      return nil
    end
    local lres, ldata
    lres, ldata = module:HomelandVisitLogReq(TT)
    if not lres:GetSucc() then
      Log.fatal("获取日志列表失败：", lres:GetResult())
      ToastManager.ShowHomeToast(module:GetVisitErrorMsg(lres:GetResult()))
      return nil
    end
    self._friendList = {}
    for _, value in pairs(fdata.visit_list) do
      local visit_info = value
      local social_info = allFriends[visit_info.pstid]
      local friend = UIHomeFriendData:New(social_info, visit_info)
      table.insert(self._friendList, friend)
    end
    self._logList = {}
    for _, value in pairs(ldata.log_list.curday_list) do
      local log_info = value
      local log = UIHomeVisitLog:New(log_info)
      table.insert(self._logList, log)
    end
    for _, value in pairs(ldata.log_list.log_list) do
      local log_info = value
      local log = UIHomeVisitLog:New(log_info)
      table.insert(self._logList, log)
    end
    self._reqFriendTime = now
  end
  return self._friendList, self._logList
end

function UIHomelandModule:GetCurrentToolCfg(toolType)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local axeCfgs = Cfg.cfg_item_tool_upgrade({ToolType = toolType})
  for _, cfg in pairs(axeCfgs) do
    local items = itemModule:GetItemByTempId(cfg.ID)
    if table.count(items) > 0 then
      return cfg
    end
  end
end

function UIHomelandModule:Visit_Water(breed, point, interactBtn)
  if breed:Visit_IsWatered() then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_visit_has_watered"))
    return
  end
  local host = self._visitInfo.pstid
  GameGlobal.TaskManager():StartTask(self._Water, self, host, breed, point, interactBtn)
end

function UIHomelandModule:_Water(TT, host, breed, point, interactBtn)
  local pstID = breed:PstID()
  local module = GameGlobal.GetModule(HomelandModule)
  GameGlobal.UIStateManager():Lock("UIHomeVisitReqWater")
  local res, data = module:HomelandAccCultivateReq(TT, host, pstID)
  GameGlobal.UIStateManager():UnLock("UIHomeVisitReqWater")
  self._visitInfo.cultivation_info = data.newInfo
  if not res:GetSucc() then
    ToastManager.ShowHomeToast(module:GetVisitErrorMsg(res:GetResult()))
    return
  end
  GameGlobal.UIStateManager():Lock("PlayWaterAction")
  interactBtn:GetGameObject():SetActive(false)
  self._homelandClient:CharacterManager():MainCharacterController():Action_Water(TT, point)
  breed:HideWaterEft(TT)
  interactBtn:GetGameObject():SetActive(true)
  ToastManager.ShowHomeToast(StringTable.Get("str_homeland_visit_water_success"))
  GameGlobal.UIStateManager():UnLock("PlayWaterAction")
end

function UIHomelandModule:_OnLevelInfoChanged(deltaLevel, curLevel)
  self._levelUpCache = deltaLevel
  self._curLevel = curLevel
  Log.notice("等级和经验消息推送:", deltaLevel)
end

function UIHomelandModule:TryPopLevelUpTip()
  if self._levelUpCache > 0 then
    ToastManager.ShowHomeToast(StringTable.Get("str_homeland_level_up", self._curLevel))
    self._levelUpCache = 0
    return true
  end
  return false
end

function UIHomelandModule:ClearLevelupTip()
  self._levelUpCache = 0
end

function UIHomelandModule:OnBreedInteract(breedBuild)
  local homelandModule = self:GetModule(HomelandModule)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local defaultType = HomelandBreedUIType.Mutation
  local breedState = HomelandBreedState.None
  local buildingPstId = breedBuild:GetArchitecture().pstid
  local cultivationInfo = homelandModule:GetHomelandInfo().cultivation_info
  local landCultivationInfo = cultivationInfo.land_cultivation_infos[buildingPstId]
  if landCultivationInfo then
    local remainTime = homelandModule:GetLandEndTime(landCultivationInfo) - svrTimeModule:GetServerTime() * 0.001
    if #landCultivationInfo.client_info.mutation_cultivation > 0 then
      defaultType = HomelandBreedUIType.Mutation
      if remainTime <= 0 then
        breedState = HomelandBreedState.MutationReap
      else
        breedState = HomelandBreedState.Mutationing
      end
    end
    if 0 < #landCultivationInfo.client_info.directional_cultivation then
      defaultType = HomelandBreedUIType.Clone
      if remainTime <= 0 then
        breedState = HomelandBreedState.CloneReap
      else
        breedState = HomelandBreedState.Cloning
      end
    end
    if 0 < #landCultivationInfo.client_info.state_change_cultivation then
      defaultType = HomelandBreedUIType.StateChg
      breedState = HomelandBreedState.StateChgReap
    end
  end
  local mainSeedData, mutationSeedData
  
  local function cbFunc()
  end
  
  if breedState == HomelandBreedState.MutationReap then
    local mutationData
    if landCultivationInfo then
      mutationData = landCultivationInfo.client_info.mutation_cultivation[1]
    end
    if mutationData then
      mainSeedData = Cfg.cfg_item[mutationData.main_seed_id]
      mutationSeedData = Cfg.cfg_item[mutationData.second_seed_id]
    end
  elseif breedState == HomelandBreedState.CloneReap then
    local directionalCultivation
    if landCultivationInfo then
      directionalCultivation = landCultivationInfo.client_info.directional_cultivation[1]
    end
    if directionalCultivation then
      mainSeedData = Cfg.cfg_item[directionalCultivation.seed_id]
      mutationSeedData = mainSeedData
    end
  elseif breedState == HomelandBreedState.StateChgReap then
    local chgStateData
    if landCultivationInfo then
      chgStateData = landCultivationInfo.client_info.state_change_cultivation[1]
    end
    if chgStateData then
      mainSeedData = Cfg.cfg_item[chgStateData.tree_id]
    end
  end
  if breedState == HomelandBreedState.MutationReap or breedState == HomelandBreedState.CloneReap or breedState == HomelandBreedState.StateChgReap then
    GameGlobal.TaskManager():StartTask(function(TT)
      local res, items, exp, first = homelandModule:HandlePickupCultivation(TT, buildingPstId)
      if res:GetSucc() then
        if 0 < exp then
          local roleAsset = {}
          roleAsset.exp = true
          roleAsset.first = first
          roleAsset.assetid = -1
          roleAsset.count = exp
        end
        self:ShowDialog("UIHomelandBreedResult", mainSeedData, mutationSeedData, items, cbFunc, defaultType)
        breedBuild:Clear()
        if 0 < exp then
          ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_add_exp", exp))
        end
        YIELD(TT, 1000)
        self:TryPopLevelUpTip()
      end
    end, self)
  else
    breedBuild:ShowDialog("UIHomelandBreed", breedBuild)
  end
  Log.info("BuildBase Show Breed UI", breedState)
end

function UIHomelandModule:ShowStartDialog()
  if self._dialog then
    local name = self._dialog.name
    local param = self._dialog.param
    GameGlobal.UIStateManager():ShowDialog(name, param)
    self._dialog = nil
  end
end

function UIHomelandModule:SetDialog(dialogName, dialogParam)
  self._dialog = {}
  self._dialog.name = dialogName
  self._dialog.param = dialogParam
end

function UIHomelandModule:SaveStoryList(saveList)
  if saveList then
    self._saveStoryList_test = saveList
  else
    return self._saveStoryList_test
  end
end

function UIHomelandModule:EnterMoviePrepare(TT)
  local fatehrBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomelandMoviePrepareMainController)
  while GameGlobal.UIStateManager():IsLocked() do
    YIELD(TT)
  end
  self._homelandClient:StartBuild()
  self._homelandClient:BuildManager():SetBuildEditorMode(BuildEditorMode.MakeMovieOther)
  self._homelandClient:BuildManager():SetFatherBuildingForMakeMovie(fatehrBuilding)
  self._homelandClient:BuildManager():ShowArea(false)
  self:ClearWallAndFloorInScene(fatehrBuilding)
end

function UIHomelandModule:EnterMovieMaker(TT)
  self._homelandClient:SetLockGlobalCamera(nil)
  self._homelandClient:FinishBuild(TT)
  MoviePrepareData:GetInstance():EnsurePrepareArchList()
  HomelandMoviePrepareManager:GetInstance():ShowAll(false)
  local movieID = MoviePrepareData:GetInstance():GetMovieId()
  local petList = {}
  local endList = HomelandMoviePrepareManager:GetInstance():GetSelectedData(MoviePrepareType.PT_Actor)
  for _, v in pairs(endList) do
    table.insert(petList, v:GetItemId())
  end
  local storyID = MovieDataManager:GetInstance():GetMovieStoryID(movieID, petList)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeMovieStoryController .. "DirectIn", function()
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeMovieStoryController, storyID, false, false, false, true, false)
    self._homelandClient:BuildManager():ShowArea(false)
  end)
end

function UIHomelandModule:EnterMovieResult(TT, isRecord)
  local fatehrBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  local scoreList = {}
  local movieID = MoviePrepareData:GetInstance():GetMovieId()
  if isRecord then
    local playBackData = MoviePrepareData:GetInstance():GetPlayBackData()
    scoreList.actorScore = playBackData.pet_score / 2
    scoreList.itemScore = playBackData.item_score / 2
    scoreList.optionScore = playBackData.option_score / 2
    scoreList.totalScore = MovieDataManager:GetInstance():CaculateTotalScore(playBackData)
  else
    MovieDataManager:GetInstance():SendDataToServer(TT)
    local replyData = MovieDataManager:GetInstance():GetReplyClosingData()
    scoreList.actorScore = replyData.pet_score / 2
    scoreList.itemScore = replyData.item_score / 2
    scoreList.optionScore = replyData.option_score / 2
    scoreList.totalScore = MovieDataManager:GetInstance():CaculateTotalScore(replyData)
  end
  local cfgClosingList = Cfg.cfg_homeland_movice_closing({MovieID = movieID})
  local closingItem
  for _, v in pairs(cfgClosingList) do
    local l, r = MovieDataManager:GetInstance():GetClosingCondition(v.Condition)
    local score = MovieDataManager:GetInstance():TransferToStarScore(scoreList.totalScore)
    if l <= score and score < r + 0.01 then
      closingItem = v
      break
    end
  end
  self._homelandMovieClosingManager = HomelandMovieClosingManager:New()
  self._homelandMovieClosingManager:ShowPetClosing(isRecord, closingItem)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomelandMovieClosingController, isRecord, closingItem, scoreList, self._homelandMovieClosingManager)
  while GameGlobal.UIStateManager():IsLocked() do
    YIELD(TT)
  end
  if not isRecord then
    local replyData = MovieDataManager:GetInstance():GetReplyClosingData()
    if table.count(replyData.rewards) ~= 0 then
      GameGlobal.UIStateManager():ShowDialog("UIHomeShowAwards", replyData.rewards, nil, false, nil)
    end
  end
  self._homelandClient:StartBuild()
  self._homelandClient:BuildManager():SetBuildEditorMode(BuildEditorMode.MakeMovieClosing)
  self._homelandClient:BuildManager():SetFatherBuildingForMakeMovie(fatehrBuilding)
  self:FocusPreparePointDirect(fatehrBuilding, MoviePrepareType.PT_Result)
  self._homelandClient:SetLockGlobalCamera(true)
  self._homelandClient:BuildManager():ShowArea(false)
  CutsceneManager.ExcuteCutsceneOut()
end

function UIHomelandModule:EnterHomelandAfterMovieMaker(TT, isRecord, cutSceneOut)
  self._homelandClient:SetLockGlobalCamera(nil)
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMEnterHomeland, AudioConstValue.BGMCrossFadeTime)
  if cutSceneOut then
    CutsceneManager.ExcuteCutsceneOut()
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeland)
  else
    if self._homelandMovieClosingManager then
      self._homelandMovieClosingManager:StopAnim()
    end
    CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeMovieStoryController .. "DirectIn", function()
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeland)
      CutsceneManager.ExcuteCutsceneOut()
    end)
  end
  local fatehrBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  self:RestoreFreeChildrenInScene(fatehrBuilding)
  if not isRecord then
    HomelandMoviePrepareManager:GetInstance():Dispose()
  end
  self._homelandClient:FinishBuild(TT)
end

function UIHomelandModule:EnterRepalyMovie(TT)
  local fatehrBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  self:ClearWallAndFloorInScene(fatehrBuilding)
  local archlist = MoviePrepareData:GetInstance():GetPrepareArchList()
  self:SetFreeChildren(fatehrBuilding, archlist)
  local movieID = MoviePrepareData:GetInstance():GetMovieId()
  local playBackData = MoviePrepareData:GetInstance():GetPlayBackData()
  local petList = {}
  for _, v in pairs(playBackData.chose_pets) do
    table.insert(petList, v)
  end
  local storyID = MovieDataManager:GetInstance():GetMovieStoryID(movieID, petList)
  local openTease = MoviePrepareData:GetInstance():GetOpenTease()
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeMovieStoryController .. "DirectIn", function()
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIHomeMovieStoryController, storyID, false, false, false, openTease, true)
    self._homelandClient:BuildManager():ShowArea(false)
  end)
end

function UIHomelandModule:GetFreeChildren(fatherBuilding)
  return MovieFatherSon:OnSavePlayback(fatherBuilding)
end

function UIHomelandModule:ClearFreeChildrenInScene(fatherBuilding)
  return MovieFatherSon:OnClearFreeArea(fatherBuilding)
end

function UIHomelandModule:ClearWallAndFloorInScene(fatherBuilding)
  return MovieFatherSon:OnClearMovie(fatherBuilding)
end

function UIHomelandModule:RestoreFreeChildrenInScene(fatherBuilding)
  return MovieFatherSon:OnRestoreHomeBuilding(fatherBuilding)
end

function UIHomelandModule:SetFreeChildren(fatherBuilding, children)
  return MovieFatherSon:OnEnterPlayback(fatherBuilding, children)
end

function UIHomelandModule:ShowHightLightFreeArea(fatherBuilding, bShow)
  fatherBuilding:ShowMovieFreeAreaEffect(bShow)
end

function UIHomelandModule:FocusPreparePoint(fatherBuilding, prepareType, callback)
  local point = self:GetPreparePoint(fatherBuilding, prepareType)
  if not point then
    if callback then
      callback()
    end
    return
  end
  self._homelandClient:BuildManager():FocusPoint(point, callback)
end

function UIHomelandModule:FocusPreparePointDirect(fatherBuilding, prepareType, callback)
  local point = self:GetPreparePoint(fatherBuilding, prepareType)
  if not point then
    if callback then
      callback()
    end
    return
  end
  self._homelandClient:BuildManager():FocusPointDirect(point)
  if callback then
    callback()
  end
end

function UIHomelandModule:GetPreparePoint(fatherBuilding, prepareType)
  local point
  if prepareType == MoviePrepareType.PT_Scene then
    point = fatherBuilding:GetPrepareMovieSceneFocusPoint()
  elseif prepareType == MoviePrepareType.PT_Prop then
    point = fatherBuilding:GetPrepareMoviePropFocusPoint()
  elseif prepareType == MoviePrepareType.PT_Furniture then
    point = fatherBuilding:ChangeSkinFocusPoint()
  elseif prepareType == MoviePrepareType.PT_Actor then
    point = fatherBuilding:GetPrepareMovieActorFocusPoint()
  elseif prepareType == MoviePrepareType.PT_Result then
    point = fatherBuilding:GetPrepareMovieResultFocusPoint()
  else
    Log.error("ERR:UIHomelandModule:GetPreparePoint Can't Support " .. "prepareType")
  end
  return point
end
