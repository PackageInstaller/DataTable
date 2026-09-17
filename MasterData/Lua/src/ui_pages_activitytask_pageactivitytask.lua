local this = class("pageActivityTask", G_UIPageBase)
local _unitTpl = L_GameTpl:getUnitTpl()
local PETSCENEPATH = "Program/UIScene/pre_activtityScene_ui_01.prefab"
local PageContentType = {DAILY_TASK = 1, NOVICE_TASK = 2}

function this:created(...)
  this.super.created(self, ...)
  self:initSceneGo()
end

function this:initSceneGo()
  if self.csharpPage ~= nil then
    self.wait = self.csharpPage:AddWaitComponent()
    self:initCharactorSceneAsync()
  end
end

function this:initCharactorSceneCb()
  self.wait:WaitOver(true)
  self.isInitScene = true
  C_UIMgr.CloseCutin()
end

function this:initCharactorSceneAsync()
  self.sceneInstanceId = C_UIMgr.uiLoader:SpawnAsync(PETSCENEPATH, function(instanceId, go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. PETSCENEPATH)
      return
    end
    self.sceneGo = go
    local sceneTrans = self.sceneGo.transform
    self.sceneCameraTrans = sceneTrans:Find("camera")
    self.bgDay = sceneTrans:Find("bg_day").gameObject
    self.bgWeek = sceneTrans:Find("bg_week").gameObject
    self.bgDay:ActiveTrans(self.titleType == nil or self.titleType == 1)
    self.bgWeek:ActiveTrans(self.titleType == 2)
    if L_CommonUtil.isValid(self.sceneGo) then
      L_Vector3.setLocalPos(self.sceneCameraTrans, L_Vector3.new(0.75, 4.5, 28))
      L_Vector3.setLocalRot(self.sceneCameraTrans, L_Vector3.new(7, 180, 0))
      C_UISceneManager.SetSceneVisible()
      self.sceneCameraTrans.gameObject:SetActive(true)
      self.sceneGo:SetActive(true)
    end
    local controlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    if controlEntity then
      local pos = L_PlayerManager:getMainControlEntityPos()
      L_Vector3.setPos(sceneTrans, L_Vector3.new(pos.x, pos.y - 400, pos.z))
    else
      L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
    end
    local charactorUnitId = 101001
    local charactorModelPath = _unitTpl:getModel(_unitTpl:getTplById(charactorUnitId), L_Const.avatarModelIndex.UnitModel)
    self.heroModelInstanceId = C_UIMgr.uiLoader:SpawnAsync(charactorModelPath, function(instanceId, go)
      if not L_CommonUtil.isValid(go) then
        errorf("cant load asset from " .. charactorModelPath)
        return
      end
      local charactorGo = go
      self.charactorGo = charactorGo
      charactorGo.name = "charactor"
      if L_CommonUtil.isValid(self.sceneGo) then
        L_Vector3.setLocalPos(charactorGo.transform, L_Vector3.new(1.18, 3.51, 26.49))
        L_Vector3.setLocalPos(charactorGo.transform:GetChild(0).gameObject.transform, L_Vector3.new(0.05, 0, -0.26))
        local quaternion = Unity.Quaternion.Euler(0, -2.25, 0)
        charactorGo.transform.localRotation = quaternion
        local charactorEntity = require(L_EcsConst.aliveType.previewNpc).new(L_EcsConst.aliveType.previewNpc)
        local needAnimaList = {
          "Activity_DayEntry",
          "Activity_Praise",
          "Activity_Prase_2"
        }
        charactorEntity:initPreview(charactorUnitId, charactorGo, nil, nil, needAnimaList, C_EEntityEntranceType.ActivityTask)
        self.charactorEntity = charactorEntity
        if self.charactorEntity then
          self.charactorEntity.gameObject:ActiveTrans(true)
          self.charactorEntity.playableAnimator:Play("Activity_DayEntry")
        end
        local uISceneModelToolScript = self.charactorEntity.gameObject:AddComponent(typeof(CS.Azur.Gameplay.UI.UISceneModelTool))
        uISceneModelToolScript:SetCharacterBounds()
        self.sceneCameraTrans.gameObject:SetActive(true)
        self.canShowUiAndCamera = true
        self.canInitUiAndCamera = true
        self:initCharactorSceneCb()
      end
    end, self.sceneGo.transform:Find("point_charactor"), true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  end, C_LuaUtility.GetRootNode(), true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function this.bind()
  return {
    activityRewardList = {
      moduleName = "pages/activityTask/cellActivityRewardItem"
    },
    module_tabList = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    activityTaskList = {},
    activityCount = "",
    totalActivity = "",
    timeTxt = "",
    activityType = "",
    activityRewardList_week = {
      moduleName = "pages/activityTask/cellActivityRewardItem"
    },
    activityTaskList_week = {},
    activityCount_week = "",
    totalActivity_week = "",
    timeTxt_week = "",
    activityType_week = "",
    go_contentToggle = true,
    go_contentDailyTask = true
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    activityRewardList = {
      onClick_getReward = function(self, data)
        self:onClickRewardList()
      end,
      onClick_rewardPreview = function(self, bool)
        self:onClickPreviewReward(bool)
      end,
      onOpen_rewardPreview = function(self, rect)
        self:onOpenPreviewReward(rect)
      end
    },
    activityTaskList = {
      onClick_receive = function(self, data)
        self:onClickActivityList(data)
      end
    },
    activityRewardList_week = {
      onClick_getReward = function(self, data)
        self:onClickRewardList()
      end,
      onClick_rewardPreview = function(self, bool)
        self:onClickPreviewReward(bool)
      end,
      onOpen_rewardPreview = function(self, rect)
        self:onOpenPreviewReward(rect)
      end
    },
    activityTaskList_week = {
      onClick_receive = function(self, data)
        self:onClickActivityList(data)
      end
    }
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    activityDotQueue = L_Struct.getQueue()
  }
end

function this:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    callback(false)
    return
  end
  if C_BattleManager.IsInBossBattle() then
    callback(false)
    return
  end
  local result = self:checkIfCanOpen()
  callback(result)
end

function this:checkIfCanOpen()
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.activation) then
    return false
  end
  return true
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
  local brain = C_CameraManager.GetMainCameraBrain()
  brain.m_CustomBlends = nil
  L_ActivityTaskStore:listenCallFunc(L_ActivityTaskStore.event.refreshActivityTask, self.onEvent_refresh, self)
  L_ActivityTaskStore:listenCallFunc(L_ActivityTaskStore.event.refreshActivityReward, self.onEvent_refreshReward, self)
  self.activtyTaskData = nil
  self.activityRewardData = nil
  self.bind.activityType = L_WordsTpl:getValue("ui_pageActivityTask_03")
  self.bind.activityType_week = L_WordsTpl:getValue("ui_pageActivityTask_02")
  if options and options.jumpParams then
    self.titleType = tonumber(options.jumpParams[1])
  else
    self.titleType = 1
  end
  self:initToggle(self.titleType)
  self:initTaskPage(self.titleType)
  self.isDuringOpenAnim = true
  self.bindComponents.mainPanelAni:Stop()
  if options and options.noOpenAnim then
    self.bindComponents.mainPanelAni:Play("anim_AT_content_init")
  else
    self.bindComponents.mainPanelAni:Play("anim_AT_content_showD")
  end
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.ActivityTask)
end

function this:open(options)
  self:initTabList(true)
end

function this:show()
  self:initTitleType()
  if self.isDuringOpenAnim then
    self.isDuringOpenAnim = nil
  end
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.ActivityTask)
end

function this:refreshPageView(options)
  options = options or {}
  if options.jumpParams then
    if self.titleType ~= tonumber(options.jumpParams[1]) then
    end
    self:switchTaskPage(tonumber(options.jumpParams[1]))
  end
  self:initTabList()
end

function this:hide()
  self.bindComponents.FX.gameObject:SetActive(false)
  self:disposeSceneGo()
end

function this:close()
  self:disposeSceneGo()
  self:disposeTimer()
  C_UISceneManager.SetSceneVisible()
  self.titleType = nil
  self.activtyTaskData = nil
  self.activityRewardData = nil
  L_ActivityTaskStore:unListenCallFunc(L_ActivityTaskStore.event.refreshActivityTask, self.onEvent_refresh)
  L_ActivityTaskStore:unListenCallFunc(L_ActivityTaskStore.event.refreshActivityReward, self.onEvent_refreshReward)
end

function this:onTopChange(options)
  if self.cacheLv == nil then
    self.cacheLv = L_Const.topChangeHideLv.lowMemory
  end
  if options.topLv == 0 and 0 < options.lastTopLv and self.topStateDirty then
    if self.isInitScene ~= true then
      self:initSceneGo()
    end
    self.topStateDirty = false
  elseif options.topLv == self.cacheLv and options.lastTopLv < self.cacheLv then
    self.topStateDirty = true
    if self.csharpPage then
      self.csharpPage.needCutback = true
    end
  end
end

function this:disposeSceneGo()
  if self.sceneInstanceId ~= 0 then
    C_PrefabManager:RecycleByLoader(self.sceneInstanceId)
    C_UISceneManager.SetSceneVisible()
  else
    C_PrefabManager:RecycleByLoader(self.sceneInstanceId)
  end
  self.sceneInstanceId = 0
  if self.charactorEntity then
    self.charactorEntity:onDestroy()
    self.charactorEntity = nil
    C_PrefabManager:RecycleByLoader(self.heroModelInstanceId)
  elseif self.heroModelInstanceId then
    C_PrefabManager:RecycleByLoader(self.heroModelInstanceId)
  end
  self.isInitScene = false
end

function this:initTitleType()
  if math.isEmpty(self.titleType) then
    self.titleType = 1
  end
  self:refreshActivityData(self.titleType)
end

function this:onHideTitleType()
  self.titleType = nil
end

function this:onEvent_refreshReward()
  if math.isEmpty(self.titleType) then
    self.titleType = 1
  end
  self:refreshActivityRewardState(self.titleType)
  local targetActivity = self.titleType == 1 and L_ActivityTaskStore:getTodayActivityValue() or L_ActivityTaskStore:getWeekActivityValue()
  if self.beginActivity ~= targetActivity and self.beginActivity < self.maxActivity then
    if targetActivity >= self.maxActivity then
      targetActivity = self.maxActivity
    end
    if self.titleType == 1 then
      self.bind.activityCount = tostring(self.beginActivity)
    else
      self.bind.activityCount_week = tostring(self.beginActivity)
    end
    
    local function getter()
      return self.beginActivity
    end
    
    local function setter(v)
      if self.titleType == 1 then
        self.bind.activityCount = tostring(math.floor(v))
      else
        self.bind.activityCount_week = tostring(math.floor(v))
      end
    end
    
    if self.activityTween then
      self.activityTween:Kill()
      self.beginActivity = self.nextActivity or self.beginActivity
    end
    self.nextActivity = targetActivity
    self.activityTween = DOTween.To(getter, setter, targetActivity, 0.6):SetEase(Tweening.Ease.Linear):OnComplete(function()
      self.beginActivity = targetActivity
      self.nextActivity = nil
    end)
    self.activityTween:SetAutoKill(true)
    self.activityTween:Play()
  end
end

function this:onEvent_refresh()
  if math.isEmpty(self.titleType) then
    self.titleType = 1
  end
  self:refreshActivityData(self.titleType)
  self:refreshList()
end

function this:initTaskPage(titleType)
  self:refreshTaskPage(titleType == 1 and 2 or 1)
  self:refreshTaskPage(titleType)
  self.beginActivity = titleType == 1 and L_ActivityTaskStore:getTodayActivityValue() or L_ActivityTaskStore:getWeekActivityValue()
end

function this:switchTaskPage(titleType, forceRefresh)
  if self.titleType == titleType and not forceRefresh then
    return
  end
  self:disposeTimer()
  self:refreshTaskPage(titleType)
  if (self.titleType == 1 or forceRefresh) and titleType == 2 then
    self.bindComponents.mainPanelAni:Play("anim_AT_content_D2W")
    C_AudioManager.Play("Play_SFX_System_UI_Activity_Type_Select")
  elseif (self.titleType == 2 or forceRefresh) and titleType == 1 then
    self.bindComponents.mainPanelAni:Play("anim_AT_content_W2D")
    C_AudioManager.Play("Play_SFX_System_UI_Activity_Type_Select")
  end
  self.titleType = titleType
  self.bgDay:ActiveTrans(titleType == 1)
  self.bgWeek:ActiveTrans(titleType == 2)
  self.beginActivity = titleType == 1 and L_ActivityTaskStore:getTodayActivityValue() or L_ActivityTaskStore:getWeekActivityValue()
end

function this:refreshTaskPage(index)
  self:refreshActivityData(index)
  self:startDateTimer(index)
  self:refreshActivityTaskList(index)
  self:refreshActivityRewardList(index)
end

function this:onClickGetAll()
  if self:isExsistCanRewardData() == true then
    local ids = {}
    local taskList = self.titleType == 1 and self.bind.activityTaskList or self.bind.activityTaskList_week
    local data = L_ActivityTaskStore:getActivityTaskGroupByIndex(self.titleType)
    for i, v in ipairs(data) do
      if v.finishState == 1 then
        table.insert(ids, v.id)
      end
    end
    for i = 1, #taskList do
      local curActivityId = taskList:getValue(i, "curActivityId")
      if not math.isEmpty(curActivityId) then
        local isFinish = taskList:getValue(i, "finishState") == 1
        local canClick = taskList:getValue(i, "show_receiveBtn")
        if isFinish and canClick then
          taskList:getItemCls(i):onClick()
        end
      end
    end
    L_ActivityTaskStore:req_getActivityItemReward(ids, function()
      self:refreshList()
      self:playAnim()
    end)
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_challenge_11"))
  end
end

function this:setTipActive()
  if self.bind.go_rewardTip then
    self.bind.go_rewardTip = false
  else
    self.bind.go_rewardTip = true
  end
end

function this:isExsistCanRewardData()
  local canReward = false
  for i, v in pairs(self.activtyTaskData) do
    if v.finishState == 1 then
      canReward = true
      break
    end
  end
  return canReward
end

function this:refreshOneClickButton(index)
  local moduleButton = self.modules.moduleButton
  local allReceived = true
  for i, v in ipairs(self.activtyTaskData) do
    if v.finishState ~= 2 then
      allReceived = false
    end
  end
  if index == 1 then
    self.bind.show_allReceived = false
    self.bind.show_receiveButton = false
  else
    self.bind.show_allReceived_week = false
    self.bind.show_receiveButton_week = false
  end
  if self:isExsistCanRewardData() == true then
    moduleButton:setData(L_Const.ButtonType.BLUE, L_WordsTpl:getValue("ui_cellNoviceTaskItem_05"), handler(self, self.onClickGetAll))
  else
    moduleButton:setData(L_Const.ButtonType.GREY, L_WordsTpl:getValue("ui_cellNoviceTaskItem_05"), handler(self, self.onClickGetAll))
  end
end

function this:refreshActivityData(index)
  self.activtyTaskData = L_ActivityTaskStore:getActivityTaskGroupByIndex(index)
  self.activityRewardData = L_ActivityTaskStore:getActivityRewardListByIndex(index)
  local curActivity = index == 1 and L_ActivityTaskStore:getTodayActivityValue() or L_ActivityTaskStore:getWeekActivityValue()
  self.maxActivity = self.activityRewardData[#self.activityRewardData].requireActivity
  if curActivity >= self.maxActivity then
    if index == 1 then
      self.bind.activityCount = tostring(self.maxActivity)
    else
      self.bind.activityCount_week = tostring(self.maxActivity)
    end
  elseif index == 1 then
    self.bind.activityCount = tostring(curActivity)
  else
    self.bind.activityCount_week = tostring(curActivity)
  end
end

function this:refreshActivityTaskList(index)
  local activityTaskList = index == 1 and self.bind.activityTaskList or self.bind.activityTaskList_week
  activityTaskList:clear()
  local taskData = {}
  local canReceived = false
  local receiveCount = 0
  for i, v in ipairs(self.activtyTaskData) do
    if math.isEmpty(v.unlockSystemId) or C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(v.unlockSystemId) then
      if v.finishState == 1 then
        receiveCount = receiveCount + 1
        canReceived = 1 < receiveCount
      end
      table.insert(taskData, {
        describe = v.describe,
        txt_rewardNum = v.reward,
        itemReward = v.itemReward,
        count = v.count >= v.targetCount and v.targetCount or v.count,
        targetCount = v.targetCount,
        groupId = v.groupId,
        curActivityId = v.id,
        finishState = v.finishState,
        systemId = v.systemId,
        index = index,
        identify = "cellTaskItem",
        moduleName = "pages/ActivityTask/cellActivityTaskItem"
      })
    end
  end
  activityTaskList:insert_array(taskData)
end

function this:refreshActivityRewardList(index)
  local activityRewardList = index == 1 and self.bind.activityRewardList or self.bind.activityRewardList_week
  self.activityRewardData = L_ActivityTaskStore:getActivityRewardListByIndex(index)
  activityRewardList:clear()
  local rewardData = {}
  for i, v in ipairs(self.activityRewardData) do
    table.insert(rewardData, {
      activityReward = tostring(v.requireActivity),
      canReward = v.canReward == 1 and v.isFinish == false and true or false,
      activityRewardId = v.id,
      isActive = v.canReward == 1 and true or false,
      reward = v.reward,
      isFinish = v.isFinish == true and true or false,
      curTotalActivity = v.curTotalActivity,
      requireActivity = v.requireActivity,
      lastActivity = self.activityRewardData[i - 1] and self.activityRewardData[i - 1].requireActivity or 0,
      isEndIndex = #self.activityRewardData == i
    })
    if #self.activityRewardData == i then
      if index == 1 then
        self.bind.totalActivity = string.format("/%d", v.requireActivity)
      else
        self.bind.totalActivity_week = string.format("/%d", v.requireActivity)
      end
    end
  end
  activityRewardList:insert_array(rewardData)
end

function this:refreshActivityRewardState(index)
  local activityRewardList = index == 1 and self.bind.activityRewardList or self.bind.activityRewardList_week
  self.activityRewardData = L_ActivityTaskStore:getActivityRewardListByIndex(self.titleType)
  for i = 1, #self.activityRewardData do
    local v = self.activityRewardData[i]
    activityRewardList:change(i, {
      curTotalActivity = v.curTotalActivity
    })
  end
  
  local function refreshSingleReward(data, index)
    local v = data
    activityRewardList:change(index, {
      canReward = v.canReward == 1 and v.isFinish == false and true or false,
      isActive = v.canReward == 1 and true or false,
      isFinish = v.isFinish == true and true or false,
      curTotalActivity = v.curTotalActivity,
      requireActivity = v.requireActivity,
      lastActivity = self.activityRewardData[index - 1] and self.activityRewardData[index - 1].requireActivity or 0
    })
  end
  
  local hasRefreshed = false
  if self.dotLineTimer then
    Timer.remove(self.dotLineTimer)
    self.dotLineTimer = nil
    self:refreshActivityRewardQuickly(activityRewardList)
    hasRefreshed = true
  end
  self.data.activityDotQueue:clean()
  for i, v in ipairs(activityRewardList) do
    local canTween = activityRewardList:getItemCls(i):isVisibleTween()
    if canTween then
      self.data.activityDotQueue:enQueue({
        item = activityRewardList:getItemCls(i),
        new_data = self.activityRewardData[i],
        index = i
      })
    end
  end
  if self.data.activityDotQueue:getLength() > 0 then
    self:activityQueueDealFirst(refreshSingleReward)
    self.dotLineTimer = Timer.repeated(0.16, function()
      if self.data.activityDotQueue:getLength() > 0 then
        self:activityQueueDealFirst(refreshSingleReward)
      else
        self.data.activityDotQueue:clean()
        if self.dotLineTimer then
          Timer.remove(self.dotLineTimer)
          self.dotLineTimer = nil
          self:refreshActivityRewardQuickly(activityRewardList)
        end
      end
    end, self, self.gameObject)
  elseif not hasRefreshed then
    self:refreshActivityRewardQuickly(activityRewardList)
  end
end

function this:activityQueueDealFirst(func)
  local first = self.data.activityDotQueue:getFirst()
  func(first.new_data, first.index)
  first.item:dotLineTween()
  self.data.activityDotQueue:deQueue()
end

function this:refreshActivityRewardQuickly(activityRewardList)
  self.activityRewardData = L_ActivityTaskStore:getActivityRewardListByIndex(self.titleType)
  for i = 1, #self.activityRewardData do
    local v = self.activityRewardData[i]
    activityRewardList:change(i, {
      activityReward = tostring(v.requireActivity),
      canReward = v.canReward == 1 and v.isFinish == false and true or false,
      activityRewardId = v.id,
      isActive = v.canReward == 1 and true or false,
      reward = v.reward,
      isFinish = v.isFinish == true and true or false,
      curTotalActivity = v.curTotalActivity,
      requireActivity = v.requireActivity,
      lastActivity = self.activityRewardData[i - 1] and self.activityRewardData[i - 1].requireActivity or 0,
      isEndIndex = #self.activityRewardData == i
    })
  end
end

function this:playAnim()
  if self.charactorEntity == nil then
    return
  end
  local animName = self.titleType == 1 and "Activity_Praise" or "Activity_Prase_2"
  self.charactorEntity.playableAnimator:CrossFade(animName)
end

function this:onClickRewardList()
  L_ActivityTaskStore:req_getActivityTaskReward(self.titleType, function()
    self:playAnim()
  end)
end

function this:onClickPreviewReward(bool)
  if bool then
    local activityRewardList = self.titleType == 1 and self.bind.activityRewardList or self.bind.activityRewardList_week
    for i = 1, #activityRewardList do
      activityRewardList:change(i, {show_rewardPreview = false})
    end
  end
end

function this:onClickActivityList(data)
  local receiveCount = 0
  local canReceiveAll = false
  for _, v in ipairs(self.activtyTaskData) do
    if (math.isEmpty(v.unlockSystemId) or C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(v.unlockSystemId)) and v.finishState == 1 then
      receiveCount = receiveCount + 1
      canReceiveAll = 1 < receiveCount
    end
  end
  if canReceiveAll then
    self:onClickGetAll()
  else
    local ids = {}
    table.insert(ids, data.curActivityId)
    L_ActivityTaskStore:req_getActivityItemReward(ids, function()
      self.bindComponents.boardAni:Stop()
      self.bindComponents.boardAni:Play("anim_AT_content_gain")
      self:playAnim()
    end)
  end
end

function this:refreshList()
  L_TimerManager:newOrResetTimer(self, "refreshActivityList", function()
    self.bindComponents.boardAni:Stop()
    self.bindComponents.boardAni:Play("anim_AT_content_hide")
    self:refreshActivityTaskList(self.titleType)
    self.bindComponents.boardAni:Play("anim_AT_content_fresh")
  end, 1)
end

function this:startDateTimer(index)
  self:disposeTimer()
  local freshFunc
  if index == 1 then
    function freshFunc()
      return L_TimeUtil.getLeftDayRefreshTime()
    end
    
    self.bind.timeTxt = freshFunc()
  elseif index == 2 then
    function freshFunc()
      return L_TimeUtil.getLeftWeekRefreshTime()
    end
    
    self.bind.timeTxt_week = freshFunc()
  end
  self.timer = Timer.repeated(1, function()
    if index == 1 then
      self.bind.timeTxt = freshFunc()
    elseif index == 2 then
      self.bind.timeTxt_week = freshFunc()
    end
  end, self, self.gameObject)
end

function this:disposeTimer()
  if self.timer ~= nil then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.activityTween ~= nil then
    self.activityTween:Kill()
    self.activityTween = nil
  end
  L_TimerManager:clearTimer(self)
end

function this:initToggle(selectType)
  self.bind.go_contentToggle = true
  self:switchPageContent(selectType)
end

function this:switchPageContent(pageContentType)
  self.bind.go_contentDailyTask = true
end

function this:closeRewardTips()
  local activityRewardList = self.titleType == 1 and self.bind.activityRewardList or self.bind.activityRewardList_week
  for i = 1, #activityRewardList do
    activityRewardList:change(i, {show_rewardPreview = false})
  end
end

function this:onOpenPreviewReward(rect)
  self.rewardPreviewRect = rect
end

function this:update()
  if self.rewardPreviewRect ~= nil and self.rewardPreviewRect.gameObject.activeInHierarchy and Unity.Input.GetMouseButtonDown(0) then
    local rect = self.rewardPreviewRect
    local mousePositionV2 = C_Vector2(Unity.Input.mousePosition.x, Unity.Input.mousePosition.y)
    local isUI = Unity.RectTransformUtility.RectangleContainsScreenPoint(rect, mousePositionV2, C_CameraManager.uiCamera)
    if not isUI then
      self:closeRewardTips()
      return
    end
  end
end

function this:initTabList(firstOpen)
  local tabList = {
    [1] = {
      id = 1,
      name = L_WordsTpl:getValue("residual_code_pageactivitytask_02"),
      reddotKey = L_ReddotManager.DotDef.DairyActivity
    },
    [2] = {
      id = 2,
      name = L_WordsTpl:getValue("residual_code_pageactivitytask_03"),
      reddotKey = L_ReddotManager.DotDef.WeeklyActivity
    }
  }
  local defaultIndex = self.titleType or 1
  self.modules.module_tabList:initData(tabList, function(tabId)
    if tabId == -1 then
      return
    end
    if tabId == 1 then
      self:switchTaskPage(1)
    elseif tabId == 2 then
      self:switchTaskPage(2)
    end
  end, defaultIndex)
  local forceRefresh = firstOpen == true
  self:switchTaskPage(defaultIndex, forceRefresh)
end

return this
