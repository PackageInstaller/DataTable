_class("UIN13BuildMapPet", UICustomWidget)
UIN13BuildMapPet = UIN13BuildMapPet
local EUIN13BuildMapPetState = {
  Idle = 1,
  Plan = 2,
  Action = 3,
  Picnic = 4,
  Story = 5,
  Leave = 6
}
_enum("EUIN13BuildMapPetState", EUIN13BuildMapPetState)
local EUIN13BuildMapPetPlanType = {
  Move = 1,
  Act1 = 2,
  Act2 = 3
}
_enum("EUIN13BuildMapPetPlanType", EUIN13BuildMapPetPlanType)

function UIN13BuildMapPet:OnShow(uiParams)
  self._open = true
  self._player = self:GetGameObject():GetComponent("RectTransform")
  self._playerTweener = nil
  self:SetShowDebug(false)
end

function UIN13BuildMapPet:OnHide()
  self._open = false
  if self._playerTweener then
    self._playerTweener:Kill()
  end
end

function UIN13BuildMapPet:Init(nodeData, petId, petSpine, nodeId, nodeStartPointList, moveCallback, stopCallback, btnCallback)
  self._nodeData = nodeData
  self._petId = petId
  self._nodeId = nodeId
  self._nodeStartPointList = nodeStartPointList
  self._moveCallback = moveCallback
  self._stopCallback = stopCallback
  self._btnCallback = btnCallback
  self._state = EUIN13BuildMapPetState.Idle
  self._flagLeave = false
  self:_SetPos(nodeId)
  self:_SetDebugName()
  self:_SetDebugHead(petId)
  self:_SetSpine(petSpine)
end

function UIN13BuildMapPet:Start()
  Log.info("UIN13BuildMapPet:Start()")
  if self._state == EUIN13BuildMapPetState.Idle then
    self:_Do_Plan()
  end
end

function UIN13BuildMapPet:Leave()
  Log.info("UIN13BuildMapPet:Leave()")
  self._flagLeave = true
end

function UIN13BuildMapPet:GetNodeId()
  return self._nodeId
end

function UIN13BuildMapPet:SetPetPicnic(nodeId, story, callback)
  Log.debug("UIN13BuildMapPet:SetPetPicnic(), petId = ", self._petId)
  self._state = EUIN13BuildMapPetState.Picnic
  self:_KillAllTask()
  self._nodeId = nodeId
  self:_SetPos(nodeId)
  self:_ActEating(story, callback)
end

function UIN13BuildMapPet:SetBtnShow(show)
  if self._state == EUIN13BuildMapPetState.Story and not show then
    self:_Do_Plan()
  end
  if show then
    self:_Do_Story()
  end
  local obj = self:GetGameObject("Btn")
  obj:SetActive(show)
end

function UIN13BuildMapPet:_SetPos(nodeId)
  local pos = self._nodeData:GetNodePos(nodeId)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end

function UIN13BuildMapPet:_IsTaskRun()
  return self._task ~= nil
end

function UIN13BuildMapPet:_KillAllTask()
  if self._task then
    GameGlobal.TaskManager():KillTask(self._task)
    self._task = nil
  end
  if self._playerTweener then
    self._playerTweener:Kill()
    self._playerTweener = nil
  end
end

function UIN13BuildMapPet:_Do_Idle()
  self._state = EUIN13BuildMapPetState.Idle
  self:_SetSpineAnimation_Idle()
end

function UIN13BuildMapPet:_Do_Plan()
  self._state = EUIN13BuildMapPetState.Plan
  if self:_IsTaskRun() then
    Log.debug("UIN13BuildMapPet:_Do_Plan() IsTaskRun == true petId = ", self._petId)
    return
  end
  self._task = self:StartTask(function(TT)
    local cfg = Cfg.cfg_n13_map_pet_setting[1]
    local petPlanDuration = cfg.PetPlanDuration or 1
    self:_SetSpineAnimation_Idle()
    self:_SetDebugText("Plan")
    YIELD(TT, petPlanDuration)
    self._task = nil
    if not self._open then
      return
    end
    if self._flagLeave then
      self:_Do_Leave()
      return
    end
    local plans = {
      EUIN13BuildMapPetPlanType.Move,
      EUIN13BuildMapPetPlanType.Act1,
      EUIN13BuildMapPetPlanType.Act2
    }
    local flagStart = table.icontains(self._nodeStartPointList, self._nodeId)
    if not flagStart then
      table.shuffle(plans)
    end
    local plan = plans[1]
    local path
    if plan == EUIN13BuildMapPetPlanType.Move then
      path = self._moveCallback(self._petId)
      plan = #path == 0 and plans[2] or plan
    end
    self:_Do_Action(plan, path)
  end, self)
end

function UIN13BuildMapPet:_Do_Action(plan, path)
  self._state = EUIN13BuildMapPetState.Action
  if plan == EUIN13BuildMapPetPlanType.Move and path then
    if #path ~= 0 then
      self:_SetDebugText("M: " .. path[#path])
      self:WalkAlong(path)
    else
      self:WalkOver(self._nodeId)
    end
  elseif plan == EUIN13BuildMapPetPlanType.Act1 then
    self:_Act1()
  elseif plan == EUIN13BuildMapPetPlanType.Act2 then
    self:_Act2()
  end
end

function UIN13BuildMapPet:_Do_Leave()
  self._state = EUIN13BuildMapPetState.Leave
  local path = self._moveCallback(self._petId, true)
  if #path ~= 0 then
    self:_SetDebugText("L: " .. path[#path])
    self:WalkAlong(path)
  else
    self:WalkOver(self._nodeId)
  end
end

function UIN13BuildMapPet:_Do_Story()
  Log.debug("UIN13BuildMapPet:_Do_Story() petId = ", self._petId)
  self:_SetDebugText("Story")
  self._state = EUIN13BuildMapPetState.Story
  self:_KillAllTask()
  self:_SetSpineAnimation_Idle()
end

function UIN13BuildMapPet:WalkAlong(pathData)
  if not pathData or table.count(pathData) == 0 then
    return
  end
  local cfg = Cfg.cfg_n13_map_pet_setting[1]
  local petSpeed = cfg.PetSpeed / 1000
  local duration = table.count(pathData) * petSpeed
  local waypoints = {}
  for i, v in ipairs(pathData) do
    table.insert(waypoints, self._nodeData:GetNodePos(v, true))
  end
  local waypointsLen = table.count(waypoints)
  self._playerTweener = self._player:DOLocalPath(waypoints, duration):SetEase(DG.Tweening.Ease.Linear):OnWaypointChange(function(waypointIndex)
    waypointIndex = waypointIndex + 1
    if waypointIndex < waypointsLen then
      local nextwaypointIndex = waypointIndex + 1
      self:Turn(waypoints[waypointIndex], waypoints[nextwaypointIndex])
    end
  end)
  local curPos = self._nodeData:GetNodePos(self._nodeId)
  local targetId = pathData[#pathData]
  local targetPos = self._nodeData:GetNodePos(targetId)
  self._playerTweener:OnStart(function()
  end):OnUpdate(function()
  end):OnComplete(function()
    self:WalkOver(targetId)
  end)
end

function UIN13BuildMapPet:WalkOver(targetNodeId)
  if not self._open then
    return
  end
  self:_SetSpineAnimation_Idle()
  self._nodeId = targetNodeId
  if self._state == EUIN13BuildMapPetState.Action then
    self:_Do_Plan()
  elseif self._state == EUIN13BuildMapPetState.Leave then
    self._flagLeave = false
    if self._stopCallback(self._petId) then
      self:_Do_Idle()
    else
      self:_Do_Plan()
    end
  end
end

function UIN13BuildMapPet:Turn(curPos, targetPos)
  if curPos and targetPos then
    local h = curPos.x < targetPos.x and 1 or curPos.x > targetPos.x and -1 or 0
    local v = curPos.y < targetPos.y and 1 or curPos.y > targetPos.y and -1 or 0
    self:_SetSpineAnimation_Walk(h, v)
  end
end

function UIN13BuildMapPet:_Act1()
  local cfg = Cfg.cfg_n13_map_pet_setting[1]
  local name = "Act_1"
  local lockName = ""
  local duration = cfg.PetAct1Duration / 1000
  self:_Act_Process(name, lockName, duration, function()
    self:_SetSpineAnimation_Act1()
  end, function()
    self:_Do_Plan()
  end)
end

function UIN13BuildMapPet:_Act2()
  local cfg = Cfg.cfg_n13_map_pet_setting[1]
  local name = "Act_2"
  local lockName = ""
  local duration = cfg.PetAct2Duration / 1000
  self:_Act_Process(name, lockName, duration, function()
    self:_SetSpineAnimation_Act2()
  end, function()
    self:_Do_Plan()
  end)
end

function UIN13BuildMapPet:_ActEating(story, callback)
  local cfg = Cfg.cfg_n13_map_pet_setting[1]
  local name = "Act_Eating"
  local lockName = "UIN13BuildMapPet:_ActEating"
  local duration = cfg.PetActEatingDuration / 1000
  self:_Act_Process(name, lockName, duration, function()
    self:_SetSpineAnimation_Picnic()
  end, function()
    if story ~= nil then
      self:_Do_Story()
    else
      self:_Do_Plan()
    end
    if callback then
      callback()
    end
  end)
end

function UIN13BuildMapPet:_Act_Process(name, lockName, duration, startCallback, stopCallback)
  if self:_IsTaskRun() then
    Log.debug("UIN13BuildMapPet:_Act_Process() IsTaskRun == true petId = ", self._petId)
    return
  end
  if not string.isnullorempty(lockName) then
    GameGlobal.UIStateManager():Lock(lockName)
  end
  self._task = self:StartTask(function(TT)
    if startCallback then
      startCallback()
    end
    for i = 1, duration do
      self:_SetDebugText(name .. ": " .. i)
      YIELD(TT, 1000)
    end
    if not string.isnullorempty(lockName) then
      GameGlobal.UIStateManager():UnLock(lockName)
    end
    self._task = nil
    if not self._open then
      return
    end
    if stopCallback then
      stopCallback()
    end
  end, self)
end

function UIN13BuildMapPet:_SetSpine(petSpine)
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self._spine:LoadSpine(petSpine)
  local cfg = Cfg.cfg_n13_map_pet_setting[1]
  local scale = cfg.PetSpineScale / 100
  local trans = self:GetGameObject("Spine").transform
  if trans then
    trans.localScale = Vector3(scale, scale, scale)
  end
end

function UIN13BuildMapPet:_SetSpineAnimation(idx)
  self._spineAnimationName = {
    [1] = "back_idle",
    [2] = "back_walk",
    [3] = "front_idle",
    [4] = "front_walk",
    [5] = "sit_eat",
    [6] = "sit_idle",
    [7] = "special"
  }
  local spineSke = self._spine.CurrentSkeleton
  spineSke = spineSke or self._spine.CurrentMultiSkeleton
  if spineSke then
    spineSke.AnimationState:SetAnimation(0, self._spineAnimationName[idx], true)
  end
end

function UIN13BuildMapPet:_SetSpineAnimation_Idle()
  self:_SetSpineAnimation(3)
end

function UIN13BuildMapPet:_SetSpineAnimation_Walk(h, v)
  if self._spine then
    if h ~= 0 then
      self._spine.CurrentSkeleton.Skeleton.ScaleX = h
    end
    local idx = 0 < v and 2 or 4
    self:_SetSpineAnimation(idx)
  end
end

function UIN13BuildMapPet:_SetSpineAnimation_Picnic()
  self:_SetSpineAnimation(5)
end

function UIN13BuildMapPet:_SetSpineAnimation_Act1()
  self:_SetSpineAnimation(7)
end

function UIN13BuildMapPet:_SetSpineAnimation_Act2()
  self:_SetSpineAnimation(7)
end

function UIN13BuildMapPet:BtnOnClick(go)
  if self._btnCallback then
    self._btnCallback(self._petId)
  end
end

function UIN13BuildMapPet:TestBtnOnClick(go)
end

function UIN13BuildMapPet:_TestSpineAnimation()
  self._testSpineAniIdx = self._testSpineAniIdx or 0
  self._testSpineAniIdx = (self._testSpineAniIdx + 1) % 7
  self:_SetSpineAnimation(self._testSpineAniIdx + 1)
  ToastManager.ShowToast(self._spineAnimationName[self._testSpineAniIdx + 1])
end

function UIN13BuildMapPet:_TestWalk()
  local tb = {
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 0},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  }
  local tb2 = {
    "左下",
    "左中",
    "左上",
    "中下",
    "中中",
    "中上",
    "右下",
    "右中",
    "右上"
  }
  self._testDir = self._testDir or -1
  self._testDir = (self._testDir + 1) % table.count(tb)
  local dir = self._testDir + 1
  local h = tb[dir][1]
  local v = tb[dir][2]
  self:_SetSpineAnimation_Walk(h, v)
  ToastManager.ShowToast(tb2[dir])
end

function UIN13BuildMapPet:_SetDebugHead(petId)
  local url = "head1_" .. petId
  local obj = self:GetUIComponent("RawImageLoader", "head")
  obj:LoadImage(url)
end

function UIN13BuildMapPet:SetShowDebug(show)
  self._flagShowDebug = show
  local obj = self:GetGameObject("debug")
  obj:SetActive(show)
end

function UIN13BuildMapPet:_SetDebugName()
  if not self._open then
    return
  end
  local obj = self:GetUIComponent("UILocalizationText", "debugName")
  obj:SetText(self._petId)
end

function UIN13BuildMapPet:_SetDebugText(str)
  if not self._open then
    return
  end
  local obj = self:GetUIComponent("UILocalizationText", "debugTxt")
  obj:SetText(str)
end

function UIN13BuildMapPet:SetDebugState(state)
  if not self._open then
    return
  end
  if not self._debugState then
    self._debugState = UIWidgetHelper.GetObjGroupByWidgetName(self, {
      {"fixed"},
      {"unfixed"},
      {"leave"},
      {"spare"}
    })
  end
  UIWidgetHelper.SetObjGroupShow(self._debugState, state)
end
