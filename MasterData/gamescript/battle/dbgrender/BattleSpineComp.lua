local SpineReflect = typeof(CS.Z1Client.SpineReflect)
local PositionShift = CS.Z1Client.PositionShift
local Vector3 = CS.UnityEngine.Vector3
local Vector3_Zero = Vector3.zero
local BattleSpineComp, Super = System.NewClass("BattleSpineComp", BattleComponent)
local T_SkeletonAnimation = typeof(CS.Spine.Unity.SkeletonAnimation)
local T_MeshRenderer = typeof(CS.UnityEngine.MeshRenderer)
local MaterialPropertyBlock = CS.UnityEngine.MaterialPropertyBlock
local DissolveProgressId = CS.UnityEngine.Shader.PropertyToID("_DissolveProgress")

function BattleSpineComp:ctor(entity, allAnimConfigs, parentNode)
  Super.ctor(self, entity)
  self.parentNode = parentNode
  self.allAnimConfigs = allAnimConfigs
  self.pooledGameObjectMap = {}
  self.spineNodeMap = {}
  self.subSpineNodes = {}
  self.allSpineNodes = {}
  self.animIdx = 1
  self.bindings = {}
  self:InitAllSpine()
end

function BattleSpineComp:InitAllSpine()
  for index, animationConfig in ipairs(self.allAnimConfigs) do
    local spineAssetPath = animationConfig.spineName
    local pooledGameObject = Pool.GetWithTag(PooledGameObject, spineAssetPath, bg.battleScene.factoryLayer)
    self.pooledGameObjectMap[index] = pooledGameObject
    local rootNode = pooledGameObject.rootNode
    if not rootNode then
      error("未找到资源，请确保资源存在，或者检查《h唤醒体和怪物动画_AnimationConfig》是否配置了不存在的资源， 资源路径==" .. spineAssetPath)
    end
    rootNode.transform:SetParent(self.parentNode.transform)
    rootNode:SetActive(false)
    local spineName = PathStrUtils.GetBaseName(animationConfig.spineName or "")
    self.bindings[spineName] = rootNode
    local skeletonAnimationList = rootNode:GetComponentsInChildren(T_SkeletonAnimation, true)
    for i = 0, skeletonAnimationList.Length - 1 do
      local skeletonAnimation = skeletonAnimationList[i]
      local spineNode = skeletonAnimation.gameObject
      local gameObjName = spineNode.name
      if string.find(gameObjName, "Phase_", 0, true) then
        self.spineNodeMap[index] = self.spineNodeMap[index] or spineNode
      else
        table.insert(self.subSpineNodes, spineNode)
      end
      table.insert(self.allSpineNodes, spineNode)
    end
    assert(self.spineNodeMap[index], string.format("%s 不存在 spine动画", spineAssetPath))
  end
end

function BattleSpineComp:SpineNameMatch(prefabName)
  local temp = self.SpineMatchTemp
  if not temp then
    temp = {}
    self.SpineMatchTemp = temp
  end
  local bindings = self:GetBindings()
  for _, go in pairs(bindings) do
    local monsterName = temp[go.name]
    if not monsterName then
      monsterName = go.name:replace("(Clone)", "", true)
      temp[go.name] = monsterName
    end
    if monsterName == prefabName then
      return true
    end
  end
  return false
end

function BattleSpineComp:UnloadAssetFunc()
  for index, animCfg in ipairs(self.allAnimConfigs) do
    local pooledGameObject = self.pooledGameObjectMap[index]
    if self.entity.role.camp == bc.BattleCamp.Camp1 then
      local spineAssetPath = animCfg.spineName
      self:ResetDissolveProgress()
      Pool.FreeWithTag(PooledGameObject, spineAssetPath, pooledGameObject)
    else
      pooledGameObject:Dispose()
    end
  end
end

function BattleSpineComp:ResetDissolveProgress()
  if IsNil(self.spineNode) then
    return
  end
  local renderer = self.spineNode:GetComponent(T_MeshRenderer)
  local mpb = MaterialPropertyBlock()
  renderer:GetPropertyBlock(mpb)
  mpb:SetFloat(DissolveProgressId, -28)
  renderer:SetPropertyBlock(mpb)
  mpb:Clear()
end

function BattleSpineComp:SetPosition(positionIndex)
  positionIndex = positionIndex or 0
  self.visualNode.transform.localPosition = Vector3_Zero
  local positionShift = self.visualNode:GetComponent(typeof(PositionShift))
  if positionShift then
    positionShift:ResetShift()
    if not bg.isPVP then
      positionShift:UsePosition(positionIndex)
    end
  end
end

function BattleSpineComp:GetTentacleHitPos()
  local tentacleHitGo = self.visualNode.transform:Find("Tentacle_Hit")
  if tentacleHitGo then
    return tentacleHitGo.transform.position
  end
  local root = self:GetBoneAttachment("root")
  if root then
    return root.transform.position
  end
  do return self.GetFootPosition end
  return self.GetFootPosition, self
end

function BattleSpineComp:GetFootPosition()
  return self.visualNode.transform.position
end

function BattleSpineComp:GetManualRootHP()
  return self.rootHP
end

function BattleSpineComp:GetManualRootIntention(phaseIndex)
  if not phaseIndex then
    return self.rootIntention
  end
  local phaseIntention = self.visualNode.transform:Find("Root_Intention" .. phaseIndex)
  return phaseIntention or self.rootIntention
end

function BattleSpineComp:GetSpineNode()
  return self.spineNode
end

function BattleSpineComp:GetAllSpineNodes()
  return self.allSpineNodes
end

function BattleSpineComp:Show()
  if self.visualNode then
    self.visualNode:SetActive(true)
  end
end

function BattleSpineComp:Hide()
  if self.visualNode then
    self.visualNode:SetActive(false)
  end
end

function BattleSpineComp:GetSpineName()
  return self.spineFileName
end

function BattleSpineComp:GetSpineEventData()
  local DT = bg.DT
  local spineName = self:GetSpineName()
  return DT.SpineEventData[spineName]
end

function BattleSpineComp:GetCastTimeByAniName(castAniName, assingEventName)
  if nil == castAniName or "" == castAniName then
    return 0
  end
  if nil == assingEventName or "" == assingEventName then
    return 0
  end
  local spineCfg = self:GetSpineEventData()
  if not spineCfg then
    return 0
  end
  local animEventData = spineCfg[castAniName]
  if not animEventData then
    return 0
  end
  if not animEventData.eventList then
    return 0
  end
  for _, eventData in ipairs(animEventData.eventList) do
    local eventName = eventData.name
    local eventTime = eventData.time
    if eventName:upper() == assingEventName:upper() then
      return eventTime or 0
    end
  end
  return 0
end

function BattleSpineComp:GetActTimelineData(actName)
  local DT = bg.DT
  local timelineData = DT.TimelineEventData[self.spineFileName] or {}
  actName = self:GetMotionAniName(actName)
  return timelineData[actName]
end

function BattleSpineComp:GetIdleTimelineData(animName)
  local newAniName = animName or "Idle_1"
  do return self.GetActTimelineData, self end
  return self.GetActTimelineData, self, newAniName
end

function BattleSpineComp:GetSpineAnimDuration(animName)
  animName = self:GetMotionAniName(animName)
  local spineCfg = self:GetSpineEventData()
  local spineAnimCfg = spineCfg and spineCfg[animName]
  return spineAnimCfg and spineAnimCfg.duration
end

function BattleSpineComp:Init(animationConfig, timelineEnabled)
end

function BattleSpineComp:ChangeAnimIdx(animIdx)
  self.animIdx = animIdx
  if self.visualNode then
    self.visualNode:SetActive(false)
  end
  local animCfg = self.allAnimConfigs[animIdx]
  self.spineFileName = PathStrUtils.GetBaseName(animCfg.spineName or "")
  local pooledGameObject = self.pooledGameObjectMap[animIdx]
  self.visualNode = pooledGameObject.rootNode
  self.visualNode:SetActive(true)
  self:EnableReflect()
  self.spineNode = self.spineNodeMap[animIdx]
  self:EnableSpine()
  self:SetPosition()
  self.rootHP = self.visualNode.transform:Find("Root_HP")
  self.rootIntention = self.visualNode.transform:Find("Root_Intention")
  return self.spineNode
end

function BattleSpineComp:GetBindings()
  return self.bindings
end

function BattleSpineComp:EnableSpine()
  self.spineNode:SetActive(true)
  self.skeletonAnimation = self.spineNode:GetComponent(T_SkeletonAnimation)
  self.skeletonAnimation:Initialize(false)
  if self.animTimeScale then
    self.skeletonAnimation.AnimationState.TimeScale = self.animTimeScale
  end
  local hitAnimName = bc.BattleSpineAnimEnum.Hit
  self.hitAnimation = self.skeletonAnimation.Skeleton.Data:FindAnimation(hitAnimName)
  self.boneAttachments = {}
  self:ResetDissolveProgress()
end

function BattleSpineComp:EnableReflect()
  local reflect = self.visualNode.transform:GetComponentInChildren(SpineReflect, true)
  if reflect then
    reflect.gameObject:SetActive(bg.battleScene.needReflect ~= nil)
  end
end

function BattleSpineComp:EnableApplyDepthFog(enable)
  local comps = self.visualNode:GetComponentsInChildren(T_SkeletonAnimation)
  for i = 0, comps.Length - 1 do
    local comp = comps[i]
    local renderer = comp.gameObject:GetComponent(T_MeshRenderer)
    if renderer and renderer.sharedMaterial then
      if enable then
        renderer.sharedMaterial:EnableKeyword("_ENABLEULTISKILLSHADOW_ON")
      else
        renderer.sharedMaterial:DisableKeyword("_ENABLEULTISKILLSHADOW_ON")
      end
    end
  end
end

function BattleSpineComp:GetBonePos(boneName)
  local bone = self.skeletonAnimation.Skeleton:FindBone(boneName)
  local localPos = Vector3(bone.WorldX, bone.WorldY, 0)
  local worldPos = self.skeletonAnimation.transform:TransformPoint(localPos)
  return worldPos
end

function BattleSpineComp:GetBoneAttachment(boneName)
  if self.boneAttachments[boneName] ~= nil then
    return self.boneAttachments[boneName]
  end
  local attachment = self.spineNode.transform:Find(boneName)
  if nil ~= attachment then
    local boneFollower = attachment:GetComponent(typeof(CS.Spine.Unity.BoneFollower))
    boneFollower.SkeletonRenderer = self.skeletonAnimation
    self.boneAttachments[boneName] = attachment
  end
  return attachment
end

function BattleSpineComp:SetScaleX(scaleX)
  local tf = self.visualNode.transform
  local preScale = tf.localScale
  tf.localScale = Vector3(scaleX, preScale.y, preScale.z)
end

function BattleSpineComp:GetMotionAniName(animName)
  if self.entity.GetMotionAniName then
    animName = self.entity:GetMotionAniName(animName)
  end
  return animName
end

function BattleSpineComp:PlayAnim(animName, isLoop, completeCallback)
  if IsNil(self.skeletonAnimation) then
    if completeCallback then
      completeCallback()
    end
    return
  end
  animName = self:GetMotionAniName(animName)
  local spineAnimationState = self.skeletonAnimation.AnimationState
  local track
  if nil ~= completeCallback then
    local hasInvoke = false
    
    local function onAnimCompeleteOrInterrupt()
      if not hasInvoke and not self.hasDispose then
        hasInvoke = true
        completeCallback()
      end
    end
    
    local spineCfg = self:GetSpineEventData()
    if not spineCfg or not spineCfg[animName] then
      onAnimCompeleteOrInterrupt()
      return
    end
    track = spineAnimationState:SetAnimation(0, animName, isLoop)
    if not track.Animation then
      onAnimCompeleteOrInterrupt()
      return
    end
    track:Complete("+", onAnimCompeleteOrInterrupt)
    track:Interrupt("+", onAnimCompeleteOrInterrupt)
  else
    track = spineAnimationState:SetAnimation(0, animName, isLoop)
  end
  self.skeletonAnimation:Update(0)
  self.skeletonAnimation:LateUpdate()
  return track
end

function BattleSpineComp:PlayHitAnim(animName, completeCallback)
  animName = self:GetMotionAniName(animName)
  local spineAnimationState = self.skeletonAnimation.AnimationState
  local track = spineAnimationState:GetCurrent(0)
  if nil ~= track and track.Animation == self.hitAnimation then
    local duration = track.Animation.Duration
    track.TrackTime = duration * 0.2
  elseif nil ~= completeCallback then
    local hasInvoke = false
    
    local function onHitCompeleteOrInterrupt()
      if not hasInvoke and not self.hasDispose then
        hasInvoke = true
        completeCallback()
      end
    end
    
    track = spineAnimationState:SetAnimation(0, animName, false)
    track:Complete("+", onHitCompeleteOrInterrupt)
    track:Interrupt("+", onHitCompeleteOrInterrupt)
  else
    track = spineAnimationState:SetAnimation(0, animName, false)
  end
  return track
end

function BattleSpineComp:SetAnimTimeScale(timeScale)
  self.animTimeScale = timeScale
  if self.skeletonAnimation then
    self.skeletonAnimation.AnimationState.TimeScale = self.animTimeScale
  end
end

function BattleSpineComp:GetSpeed()
  local gameSpeed = bg.battleRender.gameSpeed or 1
  return gameSpeed
end

function BattleSpineComp:Pause()
  if self.pause == true then
    return
  end
  self.pause = true
  local comps = self.visualNode:GetComponentsInChildren(T_SkeletonAnimation)
  for j = 0, comps.Length - 1 do
    local comp = comps[j]
    comp.enabled = false
  end
end

function BattleSpineComp:UnPause()
  if self.pause == false then
    return
  end
  self.pause = false
  local comps = self.visualNode:GetComponentsInChildren(T_SkeletonAnimation)
  for j = 0, comps.Length - 1 do
    local comp = comps[j]
    comp.enabled = true
  end
end

function BattleSpineComp:Dispose()
  if self.hasDispose then
    return
  end
  self.hasDispose = true
  if not IsNil(self.skeletonAnimation) then
    local animState = self.skeletonAnimation.AnimationState
    if animState then
      animState:ClearTracks()
    end
  end
  self:UnloadAssetFunc()
  self.skeletonAnimation = nil
  self.hitAnimation = nil
  self.boneAttachments = nil
  self.spineNode = nil
  self.visualNode = nil
  self.allSpineNodes = nil
  self.subSpineNodes = nil
  self.spineNodeMap = nil
  self.pooledGameObjectMap = nil
  self.parentNode = nil
  self.rootHP = nil
  self.rootIntention = nil
  self.bindings = nil
end

return BattleSpineComp
