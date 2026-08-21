_class("HomelandFishMatch", Object)
HomelandFishMatch = HomelandFishMatch
local FishMatchEndType = {
  MATCHEND_CLOSE = 1,
  MATCHEND_WIN = 2,
  MATCHEND_LOSE = 3,
  MATCHEND_COMPLETE = 4
}
_enum("FishMatchEndType", FishMatchEndType)

function HomelandFishMatch:Constructor(mainCfg, pet, istask)
  self._mainCfg = mainCfg
  self._matchID = mainCfg.MatchID
  self._matchcfg = Cfg.cfg_homeland_fishmatch_match[mainCfg.MatchID]
  self._pet = pet
  self._petID = self._mainCfg.PetID
  self._posIndex = 1
  self._isTempPet = false
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  if self._cbFishMatchEnd == nil then
    self._cbFishMatchEnd = GameHelper:GetInstance():CreateCallback(self.FishMatchEnd, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchEnd, self._cbFishMatchEnd)
  end
  self.istask = istask
  self:_CreatePet(self._pet)
end

function HomelandFishMatch:Dispose()
  if self._cbFishMatchEnd then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishMatchEnd, self._cbFishMatchEnd)
    self._cbFishMatchEnd = nil
  end
end

function HomelandFishMatch:GetMainID()
  return self._mainCfg.ID
end

function HomelandFishMatch:GetMatchID()
  return self._matchID
end

function HomelandFishMatch:GetMatchCfg()
  return self._matchcfg
end

function HomelandFishMatch:GetCancelChatID()
  return self._matchcfg.CancelChatID
end

function HomelandFishMatch:GetChatID()
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  local isWin = times and 0 < times
  if isWin then
    return self._matchcfg.WinChatID
  else
    return self._matchcfg.NormalChatID
  end
end

function HomelandFishMatch:GetSecChatID()
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  local isWin = times and 0 < times
  if isWin then
    return self._matchcfg.SecWinChatID
  else
    return self._matchcfg.SecChatID
  end
end

function HomelandFishMatch:GetFishMatchInteractTitle()
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  local isWin = times and 0 < times
  if isWin then
    return self._matchcfg.WinInteractTxt
  else
    return self._matchcfg.NormalInteractTxt
  end
end

function HomelandFishMatch:GetFishMatchPlayInteractTitle()
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  local isWin = times and 0 < times
  if isWin then
    return self._matchcfg.SecWinInteractTxt
  else
    return self._matchcfg.SecInteractTxt
  end
end

function HomelandFishMatch:GetCancelFishMatchInteractTitle()
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  local isWin = times and 0 < times
  if isWin then
    return self._matchcfg.SecWinCancelTxt
  else
    return self._matchcfg.SecCancelTxt
  end
end

function HomelandFishMatch:GetByeFishMatchInteractTitle()
  return self._matchcfg.SecByeTxt
end

function HomelandFishMatch:GetWinTimes()
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  return times
end

function HomelandFishMatch:PetMatchCancel()
  local behaviour = self._pet:GetPetBehavior()
  if behaviour:GetHasBehaviors() then
    self._pet:SetOccupied(HomelandPetOccupiedType.None)
    self._pet:BreakUpMatch()
    behaviour:ChangeBehavior(HomelandPetBehaviorType.Roam)
    self:Dispose()
  end
end

function HomelandFishMatch:PetSetBornPos()
  local behaviour = self._pet:GetPetBehavior()
  if behaviour:GetHasBehaviors() then
    self._pet:SetPosition(Vector3(0, 0, 0))
  end
end

function HomelandFishMatch:EndTalkCallback()
  GameGlobal.TaskManager():CoreGameStartTask(self._ChangeBothPos, self)
end

function HomelandFishMatch:_ChangeBothPos(TT)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController .. "DirectIn")
  YIELD(TT, 1000)
  CutsceneManager.ExcuteCutsceneOut()
  local petPos, playerPos = self:_GetCloesestPos()
  local tmpPetRot = self._mainCfg.PetRotList[self._posIndex]
  local petRot = Quaternion.Euler(Vector3(tmpPetRot[1], tmpPetRot[2], tmpPetRot[3]))
  local tmpPlayerRot = self._mainCfg.RotList[self._posIndex]
  local playerRot = Quaternion.Euler(Vector3(tmpPlayerRot[1], tmpPlayerRot[2], tmpPlayerRot[3]))
  self._pet:SetPosition(petPos)
  self._pet:SetRotation(petRot)
  local homelandInfo = self._homelandModule:GetHomelandInfo()
  local times = homelandInfo.fishing_data.challenge_pet_times[self._mainCfg.PetID]
  local isWin = times and 0 < times
  if self.istask then
  elseif isWin then
    self._pet:SetMatchChatID(self._matchcfg.SecWinChatID)
  else
    self._pet:SetMatchChatID(self._matchcfg.SecChatID)
  end
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local character = homelandClient:CharacterManager():MainCharacterController()
  character:SetLocation(playerPos, playerRot)
end

function HomelandFishMatch:_GetCloesestPos()
  local posList = self._mainCfg.PetPosList
  local minDis = math.maxinteger
  for i, v in pairs(posList) do
    local cal = v[1] ^ 2 + v[2] ^ 2 + v[3] ^ 2
    if minDis > cal then
      self._posIndex = i
      minDis = cal
    end
  end
  local tmpPetRot = posList[self._posIndex]
  local tmpPlayerRot = self._mainCfg.PosList[self._posIndex]
  local petPos = Vector3(tmpPetRot[1] / 1000, tmpPetRot[2] / 1000, tmpPetRot[3] / 1000)
  local playerPos = Vector3(tmpPlayerRot[1] / 1000, tmpPlayerRot[2] / 1000, tmpPlayerRot[3] / 1000)
  return petPos, playerPos
end

function HomelandFishMatch:StartMatchTalkCallBack()
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local character = homelandClient:CharacterManager():MainCharacterController()
  character:SetForbiddenMove(true, HomelandActorStateType.Idle)
  character:SetIsFishMach(true)
  GameGlobal.TaskManager():CoreGameStartTask(self._StartMatch, self)
end

function HomelandFishMatch:_StartMatch(TT)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController .. "DirectIn")
  YIELD(TT, 500)
  self:OnStart()
  local petPos, playerPos = self:_GetCloesestPos()
  local tmpPlayerRot = self._mainCfg.RotList[self._posIndex]
  local playerRot = Quaternion.Euler(Vector3(tmpPlayerRot[1], tmpPlayerRot[2], tmpPlayerRot[3]))
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local character = homelandClient:CharacterManager():MainCharacterController()
  character:SetLocation(playerPos, playerRot)
  character:SetCameraForward()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FishMatchReady, self._mainCfg.ID, self)
  YIELD(TT, 500)
  CutsceneManager.ExcuteCutsceneOut()
end

function HomelandFishMatch:FishMatchEnd(resType)
  local endScale = -5
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local character = homelandClient:CharacterManager():MainCharacterController()
  character:SetIsFishMach(false)
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local cameraCtl = homelandClient:CameraManager():FollowCameraController()
  self._curScale = cameraCtl:CurrentScale()
  self._curXAngle = cameraCtl:NowXAngle()
  self._curRot = cameraCtl:Rotation()
  local cameraPos = self._mainCfg.EndCameraPosList[self._posIndex]
  local cameraRot = self._mainCfg.EndCameraRotList[self._posIndex]
  cameraCtl:UpdatePos(Vector3(cameraPos[1] / 1000, cameraPos[2] / 1000, cameraPos[3] / 1000))
  cameraCtl:SetCamLocation(cameraRot[1] / 100, cameraRot[2] / 100, cameraRot[3])
  cameraCtl:StopCameraScale(true)
  cameraCtl:HandleScaleForStory(endScale)
end

function HomelandFishMatch:FishMatchEndReset()
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local character = homelandClient:CharacterManager():MainCharacterController()
  if self._curScale then
    local charaTr = character:Transform()
    local cameraCtl = homelandClient:CameraManager():FollowCameraController()
    cameraCtl:UpdatePos(charaTr.position)
    cameraCtl:SetXRotation(self._curXAngle)
    cameraCtl:SetRotation(self._curRot)
    cameraCtl:StopCameraScale(false)
    cameraCtl:HandleScaleForStory(self._curScale)
  end
  if not self._isTempPet then
    self._pet:GetPetBehavior():ChangeBehavior(HomelandPetBehaviorType.FishingPrepare)
  end
  if self._isNpcPet then
    HomelandFishMatchManager:GetInstance():ChangeMatch(nil)
  end
  character:SetForbiddenMove(false, HomelandActorStateType.Idle)
  self:OnEnd()
end

function HomelandFishMatch:_CreatePet(pet)
  if HomelandPet:IsInstanceOfType(pet) then
  elseif HomelandTaskNPC:IsInstanceOfType(pet) then
    self._isNpcPet = true
    local homelandClient = self._homelandModule:GetUIModule():GetClient()
    local petMgr = homelandClient:PetManager()
    local petId = pet:PetID()
    local pet, isTemp = petMgr:GetTempPet(petId)
    self._isTempPet = isTemp
    self._pet = pet
  end
end

function HomelandFishMatch:_GetRunningTask()
  local homelandClient = self._homelandModule:GetUIModule():GetClient()
  local task = homelandClient:GetHomelandTaskManager():GetRuningTask()
  task = task or homelandClient:GetHomelandTaskManager():GetHomelandStoryTaskManager():GetRuningTaskItem()
  return task
end

function HomelandFishMatch:OnStart()
  if self._isNpcPet then
    self._task = self:_GetRunningTask()
    if self._task then
      self._pet._fadeCpt.Alpha = 1
      self._pet._finalVisible = true
      self._pet:_EnableSkinnedMeshRender(true)
      self._pet:SetOccupied(HomelandPetOccupiedType.FishingMatch)
      self._pet:GetPetBehavior():StartBehavior(HomelandPetBehaviorType.FishingMatch)
      self._task:DisposeTrace()
      self._task:DestroyNpcs()
    end
  end
end

function HomelandFishMatch:OnEnd()
  if self._isNpcPet then
    if self._isTempPet then
      local homelandClient = self._homelandModule:GetUIModule():GetClient()
      local petMgr = homelandClient:PetManager()
      petMgr:DeleteTempPet(self._pet:TemplateID())
    else
    end
    if not self._task then
      return
    end
    local task = self:_GetRunningTask()
    if task then
      task:CreateTaskNpc()
    end
    self._task = nil
  end
end

function HomelandFishMatch:IsTask()
  return self.istask
end
