_class("MazeActorManager", Object)
MazeActorManager = MazeActorManager

function MazeActorManager:Constructor()
end

function MazeActorManager:Init(petData, origin)
  self._petData = petData
  local go, reqs = HelperProxy:GetInstance():LoadPet(petData:GetPetPrefab(PetSkinEffectPath.MODEL_MAZE), true)
  self._eftReq = ResourceManager:GetInstance():SyncLoadAsset("eff_ingame_ludian_juesechuxian.prefab", LoadType.GameObject)
  self._actorReqs = reqs
  self._actor = go
  origin.y = 0.3
  self._actor.transform.position = origin
  self._actor.transform.localScale = Vector3(1.5, 1.5, 1.5)
  self._eftReq.Obj.transform.position = origin
  self._eftReq.Obj:SetActive(true)
  GameGlobal.UIStateManager():Lock("PlayMazeShowAnim")
  self.delayEvent = GameGlobal.Timer():AddEvent(500, function()
    self._actor:SetActive(true)
    GameGlobal.UIStateManager():UnLock("PlayMazeShowAnim")
    self.delayEvent = nil
  end)
  self._animator = self._actor:GetComponentInChildren(typeof(UnityEngine.Animator))
  self._moveSpeed = 6
  self._arriveCB = nil
end

function MazeActorManager:FefreshActor(petData, origin)
  local petChanged = self._petData:GetTemplateID() ~= petData:GetTemplateID()
  self._petData = petData
  if petChanged then
    for _, req in ipairs(self._actorReqs) do
      req:Dispose()
    end
    local go, reqs = HelperProxy:GetInstance():LoadPet(petData:GetPetPrefab(PetSkinEffectPath.MODEL_MAZE), true)
    self._actorReqs = reqs
    self._actor = go
    origin.y = 0.3
    self._actor.transform.position = origin
    self._actor.transform.localScale = Vector3(1.5, 1.5, 1.5)
    self._actor:SetActive(true)
    self._animator = self._actor:GetComponentInChildren(typeof(UnityEngine.Animator))
  end
end

function MazeActorManager:MoveToTarget(target, onArrive, MoveTime)
  local actorPos = self:ActorPosition()
  target.y = actorPos.y
  local moveTime
  if MoveTime then
    moveTime = MoveTime
  else
    moveTime = (target - actorPos):Magnitude() / self._moveSpeed
  end
  self._actor.transform:LookAt(target)
  self._animator:SetBool("Move", true)
  self._actor.transform:DOMove(target, moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self._animator:SetBool("Move", false)
    onArrive()
  end)
end

function MazeActorManager:Dispose()
  for _, req in ipairs(self._actorReqs) do
    req:Dispose()
  end
  self._eftReq:Dispose()
  if self.delayEvent then
    GameGlobal.Timer():CancelEvent(self.delayEvent)
    GameGlobal.UIStateManager():UnLock("PlayMazeShowAnim")
    self.delayEvent = nil
  end
end

function MazeActorManager:Update(deltaTime)
end

function MazeActorManager:ActorPosition()
  return self._actor.transform.position
end
