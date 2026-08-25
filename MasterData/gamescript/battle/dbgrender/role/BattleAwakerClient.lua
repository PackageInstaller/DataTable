local BattleAudioUtils = require("Battle.DbgRender.Util.BattleAudioUtil")
local Pool = require("Utility.Pool")
local PooledGameObject = require("Utility.PooledGameObject")
local AbortController = require("System.AbortController")
local DOTweenUtils = require("Foundation.Animation.DOTweenUtils")
local ConvertSceneToUIWorldPos = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos
local _sfxRemoveBuffer = {}
local BattleAwakerClient, Super = System.NewClass("BattleAwakerClient", BattleEntity)
local Vector3 = CS.UnityEngine.Vector3
local MeshRenderer = CS.UnityEngine.MeshRenderer
local MaterialPropertyBlock = CS.UnityEngine.MaterialPropertyBlock
local DOTween = CS.DG.Tweening.DOTween
local Color = CS.UnityEngine.Color
local Collider2D = CS.UnityEngine.Collider2D
local NoDynamicSortingOrder = CS.Z1Client.NoDynamicSortingOrder
local CameraEffectShake = CS.Thinksquirrel.CShake.CameraEffectShake
BattleAwakerClient.ColliderToAwaker = {}

function BattleAwakerClient:ctor(role, config)
  Super.ctor(self)
  self.awakerDataModel = bg.battleDataCenter:GetRoleDataModel(config.uid)
  self.tid = config.tid
  self.role = role
  self.uid = config.uid
  self.camp = config.camp
  self.battleFieldPos = config.battleFieldPos
  self.orginPoint = config.orginPoint
  self.level = config.level
  self.breakLevel = config.breakLevel
  self.breakSkillLevel = config.breakSkillLevel
  self.potencyLevel = config.potencyLevel
  self.sfxList = {}
  self.spawnPoint = config.spawnPoint
  self.phase = 1
  self.animIdx = self:ConvertAnimIdx(config.animIdx)
  self.timelineEnabled = false
  self.dead = false
  self.skillId = config.skillId
  self.skillLevel = config.skillLevel
  self.skillArgs = config.skillArgs
  self.descArgs = config.descArgs
  self.actionFinish = false
  self.floatFinish = true
  self.bodyWidthPrecent = 100
  self.highlightEnabled = true
  self.movingState = rc.AwakerMovingState.Idle
  self.stayInCenter = false
  self.abortController = AbortController()
  self.followSfxMap = setmetatable({}, {__mode = "kv"})
  local DT = bg.DT
  if self.role.roleType == bc.RoleType.Monster then
    self.isMonster = true
    self.configData = DT.MonsterConfig[self.tid]
  else
    self.isAwaker = true
    self.configData = DT.AwakerConfig[self.tid]
  end
  if self.configData.MonsterClass == bc.MonsterClass.Boss then
    self.isBoss = true
  end
  self.curSkin = self.awakerDataModel:GetSkinId()
  self.allAnimCfgs = AwakerDataUtils.GetAwakerAllAnimationConfigs(self.role.roleType, self.tid, self.curSkin)
  local prefabAwaker = ResLoadMgr.LoadAsset("GameBasePrefab/Actor.prefab", bg.battleScene)
  self.rootNode = CS.UnityEngine.GameObject.Instantiate(prefabAwaker)
  self.curStateAniName = "Idle"
  self.spineComp = self:AddBattleComponent(BattleSpineComp, self.allAnimCfgs, self.rootNode)
  self:ChangeAnimIdx(self.animIdx)
  self:_SetSpinAnimTimeScale(self.spineComp)
  self.matEffectComp = BattleMaterialEffectRoot(self)
  self.cmdParser = BattleCmdParserClient({awaker = self})
  self:SetRootPosAndScale(bg.battleScene.sceneLayer)
  self.timelinePlayer = BattleAwakerTimelinePlayer(self)
  self.shadowTransform = CS.Framework.GameObjectUtil.DeepFindChild(self.rootNode.transform, "Shadow_1")
  self:ChangeFsmState(bc.AwakerFsmState.Idle)
  self:EnableHighlight(false)
  self:PlayMultiSfx(self.animationConfig.idleSfx)
  self.changeDieShow = nil
  self:RegisterEvents()
  if bg.battleRender then
    bg.battleRender:PerformWithDelay(0.1, function()
      self:DelayInit()
    end, self)
  end
end

function BattleAwakerClient:DelayInit()
  local bones = {"body", "root"}
  for _, boneName in ipairs(bones) do
    self.spineComp:GetBoneAttachment(boneName)
  end
end

function BattleAwakerClient:Tick(deltaTime)
  Super.Tick(self, deltaTime)
  local followSfxMap = self.followSfxMap
  if followSfxMap then
    local n = 0
    for sfx in pairs(followSfxMap) do
      if not sfx.isUsing then
        n = n + 1
        _sfxRemoveBuffer[n] = sfx
      end
    end
    for i = 1, n do
      followSfxMap[_sfxRemoveBuffer[i]] = nil
    end
    table.clear(_sfxRemoveBuffer)
  end
end

function BattleAwakerClient:GetManualRootHP()
  do return self.spineComp.GetManualRootHP end
  return self.spineComp.GetManualRootHP, self.spineComp
end

function BattleAwakerClient:GetManualRootIntention(phaseIndex)
  do return self.spineComp.GetManualRootIntention, self.spineComp end
  return self.spineComp.GetManualRootIntention, self.spineComp, phaseIndex
end

function BattleAwakerClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SkillArgsChange, self.OnUpdateSkillArgs, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.TimelineLoop, self.OnTimelineLoop, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeMotion, self.OnChangeMotion, self)
  
  function self.onBattleSpeedChange()
    self:_SetSpinAnimTimeScale(self.spineComp)
    if self.timelinePlayer then
      self.timelinePlayer:SetSpeed(bg.battleRender.gameSpeed or 1)
    end
  end
  
  EventMgr.Instance.UpdateBattleSpeed:RegisterEvent(self.onBattleSpeedChange)
end

function BattleAwakerClient:UnregisterEvents()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleAwakerClient:_SetSpinAnimTimeScale(spineComp)
  local gameSpeed = bg.battleRender.gameSpeed or 1
  spineComp:SetAnimTimeScale(gameSpeed)
end

function BattleAwakerClient:OnTimelineLoop(data)
  local awaker = bg.battleScene.curTimelinePlayer
  if awaker == self then
    self:SetTimelineLooping(data.times)
  end
end

function BattleAwakerClient:GetName()
  do return LT.Text end
  return LT.Text, self.configData.Name
end

function BattleAwakerClient:MoveForward(castAnimation)
  if self.moveTweener then
    self.moveTweener:Kill(true)
  end
  if bg.isPVP then
    self:_CreateSafeMoveBackTimer()
  end
  bg.battleScene:SetActiveAwaker(self)
  self.movingState = rc.AwakerMovingState.StepForward
  local moveDura = bc.AwakerStepForwardDuration
  self.forwardAwaiter = Awaiter.Dispatch("AwakerMoveForward", moveDura, true)
  if bg.isPVP then
    self:SetFollowSfxVisible(false)
  end
  if "ExSkill" == castAnimation then
    self.moveTweener = nil
    self.timelinePlayer:MoveToCenter(moveDura, function()
      self.movingState = rc.AwakerMovingState.Center
    end)
    return
  end
  local pos = self:GetSkillCastPosition()
  self.moveTweener = self.rootNode.transform:DOMove(pos, moveDura):OnComplete(function()
    self.movingState = rc.AwakerMovingState.Center
    self.moveTweener = nil
  end)
  if castAnimation ~= bc.ArriveAnimation and self:IsHaveAnim(bc.BattleSpineAnimEnum.MoveForward) then
    self.spineComp:PlayAnim(bc.BattleSpineAnimEnum.MoveForward, false)
  end
end

function BattleAwakerClient:_CreateSafeMoveBackTimer()
  self:_ClearSafeMoveBackTime()
  self._safeMoveBackTimer = bg.battleRender:PerformWithDelay(5, function()
    self:_MoveBack()
  end, self)
end

function BattleAwakerClient:_ClearSafeMoveBackTime()
  if self._safeMoveBackTimer then
    bg.battleRender:UnperformWithDelay(self._safeMoveBackTimer)
  end
end

function BattleAwakerClient:SetFollowSfxVisible(isVisible)
  for sfx in pairs(self.followSfxMap or {}) do
    if sfx.rootNode then
      sfx.rootNode:SetActive(isVisible)
    end
  end
end

function BattleAwakerClient:GetSkillCastPosition()
  local pos = CS.UnityEngine.Vector3(bg.battleScene.centerPosition.x, bg.battleScene.centerPosition.y, bg.battleScene.centerPosition.z)
  if self:GetFace() == bc.AwakerFaceDir.RIGHT then
    if bg.battleScene.monsterCenterPosition then
      pos = CS.UnityEngine.Vector3(bg.battleScene.monsterCenterPosition.x, bg.battleScene.monsterCenterPosition.y, bg.battleScene.monsterCenterPosition.z)
    else
      pos.x = -pos.x
    end
  end
  return pos
end

function BattleAwakerClient:ActionFinish(castAnimation)
  local isInCenter = self.movingState == rc.AwakerMovingState.Center
  local canStepBack = bg.battleRender.recordMgr:CanAwakerStepBack(self.role, self)
  if isInCenter and canStepBack then
    self:MoveBack(castAnimation)
  else
    self:Change2Idle_WhenNotDie()
    self.attackComplete = true
  end
  if bg.isPVE then
    self.attackComplete = true
  end
end

function BattleAwakerClient:FloatFinish()
end

function BattleAwakerClient:MoveBack(castAnimation)
  if self.stayInCenter or self.forbiddenMoveBack then
    self.forbiddenMoveBack = false
    return
  end
  self:TryResumeShowUIEvent()
  if self.movingState ~= rc.AwakerMovingState.Center then
    return
  end
  if not bg.battleRender.recordMgr:CanAwakerStepBack(self.role, self) then
    return
  end
  self:_MoveBack(castAnimation)
end

function BattleAwakerClient:_MoveBack(castAnimation)
  self.stayInCenter = false
  self.forbiddenMoveBack = false
  self:_ClearSafeMoveBackTime()
  if self.moveTweener then
    self.moveTweener:Kill(true)
  end
  self.movingState = rc.AwakerMovingState.StepBack
  self.idleTime = bg.battleRender.renderTime + bc.AwakerStepBackDuration
  bg.battleScene:CancelActiveAwaker(self)
  local moveBackAwaiter = Awaiter.Dispatch("AwakerMoveBack" .. self.uid, bc.AwakerStepBackDuration)
  self.moveTweener = self.rootNode.transform:DOMove(self:GetSpawnPosition(), bc.AwakerStepBackDuration):OnComplete(function()
    self.movingState = rc.AwakerMovingState.Idle
    self.moveTweener = nil
    self.attackComplete = true
    self:SetFollowSfxVisible(true)
    moveBackAwaiter:SetCompleted()
  end)
  if castAnimation ~= bc.ArriveAnimation and self:IsHaveAnim(bc.BattleSpineAnimEnum.MoveBack) then
    self.spineComp:PlayAnim(bc.BattleSpineAnimEnum.MoveBack, false, function()
      self:ChangeFsmState(bc.AwakerFsmState.Idle)
    end)
  else
    self:ChangeFsmState(bc.AwakerFsmState.Idle)
  end
end

function BattleAwakerClient:MoveToPos(pos, spawnPoint)
  if self.isDynamicSortingOrder then
    self.sortingOrder = bg.battleScene:GetSpawnPointOrder(self.role.camp, spawnPoint, self.role.awakerNum)
    self.spineRenderer.sortingOrder = self.sortingOrder
  end
  self.positionConstraint.constraintActive = false
  self.rootNode.transform:DOMove(self:GetSpawnPosition(), bc.SwapAwakerDuration):OnComplete(function()
    self.battleFieldPos = pos
    self.spawnPoint = spawnPoint
    self.positionConstraint = CS.Framework.UIUtilTool.AddConstraint(self.rootNode, spawnPoint)
  end)
end

function BattleAwakerClient:GetFace()
  local faceScale = bg.battleDataCenter:IsMyCamp(self.camp) and bc.AwakerFaceDir.LEFT or bc.AwakerFaceDir.RIGHT
  local isFaceLeft = self.animationConfig.isFaceLeft
  if isFaceLeft then
    faceScale = faceScale * -1
  end
  if 2 == bg.battleData.pvpDir then
    faceScale = faceScale * -1
  end
  return faceScale
end

function BattleAwakerClient:GetSfxFaceScale()
  local isMyCamp = bg.battleDataCenter:IsMyCamp(self.camp)
  return isMyCamp and bc.AwakerFaceDir.LEFT or bc.AwakerFaceDir.RIGHT
end

function BattleAwakerClient:GetTimelineDir()
  local isMyCamp = bg.battleDataCenter:IsMyCamp(self.camp)
  if 2 == bg.battleData.pvpDir then
    return isMyCamp and bc.TimelineDir.RIGHT or bc.TimelineDir.LEFT
  end
  return isMyCamp and bc.TimelineDir.LEFT or bc.TimelineDir.RIGHT
end

function BattleAwakerClient:ConvertAnimIdx(animIdx)
  return (animIdx or 0) + 1
end

function BattleAwakerClient:OnChangeAnimIdx(animIdx)
  local clientIdx = self:ConvertAnimIdx(animIdx)
  if clientIdx > #self.allAnimCfgs then
    return
  end
  self.awakerDataModel:ResetMotion()
  self:ChangeAnimIdx(clientIdx)
  self.role:RecreateRoleUINode()
end

function BattleAwakerClient:ChangeAnimIdx(animIdx)
  if animIdx > #self.allAnimCfgs then
    return
  end
  self.animIdx = animIdx
  local animCfg = self:GetAnimationConfig()
  self.animationConfig = animCfg
  self.animationId = animCfg.ID
  local baseName = PathUtils.GetBaseName(animCfg.spineName)
  self.prefabName = baseName
  local spineNode = self.spineComp:ChangeAnimIdx(animIdx)
  if self.role.camp == bc.BattleCamp.Camp2 then
    if self.collider ~= nil then
      BattleAwakerClient.ColliderToAwaker[self.collider] = nil
    end
    self.collider = spineNode:GetComponentInChildren(typeof(Collider2D))
    if self.collider then
      BattleAwakerClient.ColliderToAwaker[self.collider] = self
    end
  end
  local faceScale = self:GetFace()
  self:UpdateShadowTransform(faceScale)
  self.spineComp:SetScaleX(faceScale)
  local renderer = spineNode:GetComponent(typeof(MeshRenderer))
  self.spineRenderer = renderer
  self.isDynamicSortingOrder = true
  if nil == spineNode:GetComponent(typeof(NoDynamicSortingOrder)) then
    self.sortingOrder = bg.battleScene:GetSpawnPointOrder(self.role.camp, self.spawnPoint, self.role.awakerNum)
  else
    self.isDynamicSortingOrder = false
    self.sortingOrder = renderer.sortingOrder
  end
  renderer.sortingOrder = self.sortingOrder
  self.lightNode = spineNode.transform:Find("light")
  if nil ~= self.lightNode then
    self.lightNode = self.lightNode.gameObject
    self.lightNode:SetActive(false)
  end
end

function BattleAwakerClient:GetBindings()
  do return self.spineComp.GetBindings end
  return self.spineComp.GetBindings, self.spineComp
end

function BattleAwakerClient:SpineNameMatch(prefabName)
  do return self.spineComp.SpineNameMatch, self.spineComp end
  return self.spineComp.SpineNameMatch, self.spineComp, prefabName
end

function BattleAwakerClient:SetHidingState(state)
  if self.HidingAllState == state then
    return
  end
  self.HidingAllState = state
  self.role.statusUI:SetAllInHiding(state)
end

function BattleAwakerClient:InHidingState()
  return self.HidingAllState or false
end

function BattleAwakerClient:UpdateShadowTransform(faceScale)
  if not self.shadowTransform then
    return
  end
  local spineNode = self.shadowTransform.parent
  local rootScale = self.rootNode.transform.localScale
  local tempScale = CS.UnityEngine.Vector3(faceScale * math.abs(rootScale.x), rootScale.y, rootScale.z)
  self.rootNode.transform.localScale = tempScale
  self.shadowTransform:SetParent(nil)
  self.rootNode.transform.localScale = rootScale
  self.shadowTransform:SetParent(spineNode)
end

function BattleAwakerClient:ClearTimeline()
end

function BattleAwakerClient:Dispose()
  Super.Dispose(self)
  if self.beHitTimelinePlayer then
    self.beHitTimelinePlayer:Dispose()
    self.beHitTimelinePlayer = nil
  end
  if self.deadAnimCheckTimer then
    TimerManager.Instance:StopTimer(self.deadAnimCheckTimer)
    self.deadAnimCheckTimer = nil
  end
  self:ClearexSkillPanelTimer()
  if self._dieSlashTimer then
    TimerManager.Instance:StopTimer(self._dieSlashTimer)
    self._dieSlashTimer = nil
  end
  if self.timelinePlayer then
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
  self.abortController:Abort()
  if self.deadTween then
    self.deadTween:Kill()
  end
  if self.spineComp then
    self.spineComp:Dispose()
    self.spineComp = nil
  end
  self.matEffectComp:Dispose()
  if self.tombstoneComp then
    self.tombstoneComp:Dispose()
  end
  DOTween.Kill(self.rootNode.transform)
  CS.UnityEngine.GameObject.Destroy(self.rootNode)
  self:ClearTimeline()
  if nil ~= self.collider then
    BattleAwakerClient.ColliderToAwaker[self.collider] = nil
    self.collider = nil
  end
  bg.battleRender:UnperformWithAllDelaysByTarget(self)
  DOTweenUtils.KillAllTweensByTarget(self)
  ResLoadMgr.UnloadAssetByTarget(self)
  if BattleAwakerClient.preloadTargets then
    for k, v in pairs(BattleAwakerClient.preloadTargets) do
      ResLoadMgr.UnloadAssetByTarget(k)
    end
  end
  BattleAwakerClient.preloadTargets = nil
  if self.onBattleSpeedChange then
    EventMgr.Instance.UpdateBattleSpeed:RemoveEvent(self.onBattleSpeedChange)
  end
end

function BattleAwakerClient.Preload(target, awakerConfigId, roleType, root)
  BattleAwakerClient.preloadTargets = BattleAwakerClient.preloadTargets or {}
  BattleAwakerClient.preloadTargets[target] = true
  print("preload ======================== ", awakerConfigId, roleType)
  local exAnimCfgs = AwakerDataUtils.GetAwakerAllAnimationConfigs(roleType, awakerConfigId)
  for _, animationConfig in ipairs(exAnimCfgs or {}) do
    Pool.CreateWithTag(PooledGameObject, animationConfig.spineName, 1, root)
  end
end

function BattleAwakerClient.GetAwakerByCollider(colliderObj)
  return BattleAwakerClient.ColliderToAwaker[colliderObj]
end

function BattleAwakerClient:GetBodyPos()
  local bodyPos = self.spineComp:GetBonePos(bc.BattleSpineBoneEnum.Body)
  return bodyPos
end

function BattleAwakerClient:GetTentacleHitPos()
  if self.spineComp then
    do return self.spineComp.GetTentacleHitPos end
    return self.spineComp.GetTentacleHitPos, self.spineComp
  end
  return self.rootNode.transform.position
end

function BattleAwakerClient:GetFootPos()
  if self.spineComp then
    do return self.spineComp.GetFootPosition end
    return self.spineComp.GetFootPosition, self.spineComp
  end
  return self.rootNode.transform.position
end

function BattleAwakerClient:SetRootPosAndScale(parent)
  self.rootNode.transform:SetParent(bg.battleScene.sceneLayer)
  self.rootNode.transform.position = self:GetSpawnPosition()
  local scale = self:GetConfigScale()
  self.rootScale = Vector3(scale or 1, scale or 1, 1)
  if scale then
    self.rootNode.transform.localScale = self.rootScale
  end
end

function BattleAwakerClient:GetSpawnPosition()
  local pos = self.spawnPoint.position
  if self.configData.Offset then
    local offset = self.configData.Offset
    do return Vector3, pos.x + (offset[1] or 0), pos.y + (offset[2] or 0) end
    return Vector3, pos.x + (offset[1] or 0), pos.y + (offset[2] or 0), pos.z + (offset[3] or 0), offset[3] or 0
  end
  return pos
end

function BattleAwakerClient:GetConfigScale()
  return self.configData.Scale
end

function BattleAwakerClient:GetSpineAttackSfx()
  local uniqPrefixMap = {Attack = "attack", Attack2 = "attack2"}
  local skillPerform = self.skillPerform
  local prefix = uniqPrefixMap[skillPerform] or skillPerform
  local sfxKey = string.format("%s%s", prefix, "Sfx")
  return self.animationConfig[sfxKey]
end

function BattleAwakerClient:GetProperty(propertyName)
  do return self.awakerDataModel.GetProperty, self.awakerDataModel end
  return self.awakerDataModel.GetProperty, self.awakerDataModel, propertyName
end

function BattleAwakerClient:GetUltiSkillConfig()
  local ultiSkillId = self:GetUltiSkill()
  if nil == ultiSkillId then
    return
  end
  local DT = bg.DT
  return DT.Skill[ultiSkillId]
end

function BattleAwakerClient:GetUltiSkillName()
  if self.skillId == nil then
    return ""
  end
  local DT = bg.DT
  local skillCfg = DT.Skill[self.skillId]
  error("BattleAwakerClient:GetUltiSkillName，技能配置表信息替换，还没修改，字段=Name")
  do return BattleSkillUtils.GetSkillName, skillCfg, 0 end
  return BattleSkillUtils.GetSkillName, skillCfg, 0, 0
end

function BattleAwakerClient:OnUpdateSkillArgs(argInfo)
  if argInfo.roleUid ~= self.uid then
    return
  end
  self.awakerDataModel:UpdateSkillArgs(argInfo.args, argInfo.descArgs)
end

function BattleAwakerClient:OnChangeMotion(argInfo)
  if argInfo.uid ~= self.uid then
    return
  end
  local idle = bc.BattleSpineAnimEnum.Idle1
  local preIdleAnim = self:GetMotionAniName(idle)
  self.awakerDataModel:SetMotion(table.deepclone(argInfo.motion or {}))
  local newIdleAnim = self:GetMotionAniName(idle)
  if preIdleAnim ~= newIdleAnim and self.fsmState == bc.AwakerFsmState.Idle then
    self:TryPlayIdle()
  end
end

function BattleAwakerClient:PlayArtAction()
  local baseName = PathUtils.GetBaseName(self.animationConfig.spineName)
  local DT = bg.DT
  local spineCfg = DT.SpineEventData[baseName]
  local actionList = {}
  for actName, _ in pairs(spineCfg) do
    table.insert(actionList, actName)
  end
  self.artActionIndex = (self.artActionIndex or 0) + 1
  if self.artActionIndex > #actionList then
    self.artActionIndex = 1
  end
  local actionName = actionList[self.artActionIndex]
  self.spineComp:PlayAnim(actionName, true)
  Alert.ShowStr("播放动作:" .. actionName)
end

function BattleAwakerClient:PlayActionVoice(delay)
  BattleAudioUtils.PlayBattleActionAudio(self.configData.ID, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlayAttackVoice(delay)
  BattleAudioUtils.PlayAttackAudio(self.animationId, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlayAwakerHitVoice(delay)
  local isNoLineVoice
  local trigger = AwakerDataUtils.GetHitNewTrigger(self.role.uid)
  BattleAudioUtils.PlayAwakerHitAudio(self.configData.ID, self.rootNode, self.curSkin, isNoLineVoice, trigger, delay)
end

function BattleAwakerClient:PlayPVPAwakerHitVoice(config)
  local castRole = bg.battleScene:GetRole(config.castRoleUid)
  if castRole.tid ~= self.tid then
    self:PlayAwakerHitVoice()
  else
    local delay
    local isNoLineVoice = true
    local trigger = CommonDefine.AwakerVoiceTrigger.Hit
    BattleAudioUtils.PlayAwakerHitAudio(self.configData.ID, self.rootNode, self.curSkin, isNoLineVoice, trigger, delay)
  end
end

function BattleAwakerClient:PlayMonsterHitVoice(delay)
  if not self.matEffectComp:IsInEffect(MaterialUtils.EffectType.Stone) then
    BattleAudioUtils.PlayMonsterHitAudio(self.animationId, self.rootNode, delay)
  end
  BattleAudioUtils.PlayMonsterHitSound(self.animationId, self.rootNode, delay)
end

function BattleAwakerClient:PlayMonsterArriveAudio(delay)
  BattleAudioUtils.PlayMonsterArriveAudio(self.animationId, self.rootNode, delay)
end

function BattleAwakerClient:PlayBuffVoice(delay)
  BattleAudioUtils.PlayBuffAudio(self.animationId, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlayDeBuffVoice(delay)
  BattleAudioUtils.PlayDebuffAudio(self.animationId, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlayExclusiveVoice(delay)
  BattleAudioUtils.PlayExclusiveAudio(self.animationId, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlayDeadVoice(delay)
  BattleAudioUtils.PlayDeathAudio(self.animationId, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlaySkillVoice(skillNum, delay)
  BattleAudioUtils.PlaySkillAudio(self.animationId, skillNum, self.rootNode, self.curSkin, delay)
end

function BattleAwakerClient:PlayVictoryVoice()
end

function BattleAwakerClient:GetSfxScale(sfxIdOrNil)
  local DT = bg.DT
  local sfxConfig = sfxIdOrNil and DT.BattleSfxConfig[sfxIdOrNil]
  if sfxConfig and not sfxConfig.CanResize then
    return 1
  end
  local sfxScaleId = self.animationConfig.ShieldSfx
  local sfxScaleConfig = DT.ShieldConfig[sfxScaleId]
  return sfxScaleConfig and sfxScaleConfig.Size or 1
end

function BattleAwakerClient:PlayMultiSfx(sfxIds, scale, isFlip, castRoleUid)
  if nil == sfxIds then
    return
  end
  for _, sfxId in ipairs(sfxIds) do
    self:PlaySfx(sfxId, scale, nil, nil, isFlip, castRoleUid)
  end
end

function BattleAwakerClient:PlaySfx(sfxId, scale, onCompleted, parentNode, isFlip, castRoleUid)
  if self:InHidingState() then
    return
  end
  if nil == sfxId then
    return
  end
  local sfxMgr = bg.battleRender.sfxMgr
  local sfx
  local DT = bg.DT
  local sfxConfig = DT.BattleSfxConfig[sfxId]
  assert(sfxConfig, "战斗特效找不到 " .. sfxId)
  local attachment
  local awakerMount = sfxConfig.ActorMount
  parentNode = parentNode or bg.battleScene.sceneLayer
  local isFollow = false
  if nil ~= awakerMount then
    attachment = self.spineComp:GetBoneAttachment(awakerMount)
    assert(attachment, string.format("spine挂载点 %s 找不到 asset=%s, sfxId = %d,", awakerMount, self.prefabName, sfxId))
    if sfxConfig.Follow then
      isFollow = true
      sfx = sfxMgr:CreateSfx(sfxId, attachment, attachment.position, false, onCompleted, self.abortController.signal)
      if sfx then
        self.followSfxMap[sfx] = sfx
      end
    else
      local rectTransform = parentNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
      if rectTransform then
        local uiPos2 = ConvertSceneToUIWorldPos(attachment.position, parentNode.transform, bg.mainCamera, bg.uiCamera)
        local uiPos3 = Vector3(uiPos2.x, uiPos2.y, 0)
        sfx = sfxMgr:CreateSfx(sfxId, parentNode, uiPos3, false, onCompleted, self.abortController.signal, 1, castRoleUid or self.uid)
        if sfx then
          sfx.rootNode.transform.localPosition = uiPos3
          self.followSfxMap[sfx] = sfx
        end
      else
        sfx = sfxMgr:CreateSfx(sfxId, parentNode, attachment.position, false, onCompleted, self.abortController.signal, self.rootScale, castRoleUid or self.uid)
      end
    end
  else
    local sceneMount = sfxConfig.SceneMount
    if sceneMount then
      local attachPoint = bg.battleScene:GetSfxAttachmentPointByName(sceneMount, self.role.camp)
      local position = attachPoint.position
      sfx = sfxMgr:CreateSfx(sfxId, parentNode, position, false, onCompleted, self.abortController.signal, 1, castRoleUid or self.uid)
    else
      local position = bg.battleScene:GetSfxAttachmentPoint(self.role.camp).position
      sfx = sfxMgr:CreateSfx(sfxId, parentNode, position, false, onCompleted, self.abortController.signal, 1, castRoleUid or self.uid)
    end
  end
  scale = scale or self:GetSfxScale(sfxId)
  if not isFollow then
    if bg.isPVP then
      scale = (scale or 1) * self:GetSfxFaceScale() * -1
    end
    if isFlip then
      scale = (scale or 1) * -1
    end
  end
  if nil ~= scale and 1 ~= scale and sfx and sfx.rootNode then
    sfx.rootNode.transform.localScale = CS.UnityEngine.Vector3(scale, math.abs(scale), 1)
  end
  if sfx and sfx.rootNode then
    CS.Framework.UIUtilTool.SetActorSfxOrder(sfx.rootNode, self.sortingOrder)
    if self.fsmState == bc.AwakerFsmState.BeHit then
      self:PlayAttackShake(sfx.rootNode)
    end
  end
  local curSkin = self.curSkin
  if castRoleUid then
    local roleDataModel = bg.battleDataCenter:GetRoleDataModel(castRoleUid)
    if roleDataModel then
      curSkin = roleDataModel:GetSkinId()
    end
  end
  BattleAudioUtils.PlaySfxAudio(sfxId, self.role.camp, nil, curSkin)
  return sfx
end

function BattleAwakerClient:PlayMaterialEffect(effectlist)
  self.matEffectComp:PlayMaterialEffect(effectlist)
end

function BattleAwakerClient:ClearMaterialEffect(effectlist)
  local myCamp = bg.battleDataCenter:GetMyCamp()
  local isFriend = self.camp == myCamp
  self.matEffectComp:ClearMaterialEffect(effectlist, isFriend)
end

function BattleAwakerClient:StopTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
  end
end

function BattleAwakerClient:IsHaveAnim(aniName)
  local dura = self.spineComp:GetSpineAnimDuration(aniName)
  return nil ~= dura
end

function BattleAwakerClient:PlayShowUpAnim(aniName)
  self.spineComp:PlayAnim(aniName or bc.BattleSpineAnimEnum.Showup, false, function()
    self:PlayIdleAnim()
  end)
end

function BattleAwakerClient:ClearAttackShakeState()
  if self.fsmState == bc.AwakerFsmState.Attack then
    local helperCom = bg.battleScene.cameraComp
    helperCom:UnLockAttackShake()
  end
end

function BattleAwakerClient:PlayAttackAnim(aniName, completeCallback)
  local function afterAttack()
    self:ClearAttackShakeState()
    
    self:Change2Idle_WhenNotDie()
    if completeCallback then
      completeCallback()
    end
  end
  
  self.spineComp:PlayAnim(aniName, false, afterAttack)
end

function BattleAwakerClient:PlayBeHitTimeline(callback)
  local hitTimelineData = self.spineComp:GetActTimelineData(bc.BattleSpineAnimEnum.Hit)
  if not self.beHitTimelinePlayer then
    self.beHitTimelinePlayer = BattleAwakerTimelinePlayer(self)
  end
  self.beHitTimelinePlayer:PlayTimeline(hitTimelineData.file, bg.battleRender.gameSpeed or 1, 0, callback)
  self.beHitTimelinePlayer:SetTimeout(hitTimelineData.duration)
end

function BattleAwakerClient:PlayBeHitAnim(callback)
  self.spineComp:PlayHitAnim(bc.BattleSpineAnimEnum.Hit, callback)
end

function BattleAwakerClient:PlayDieAnim(completeCallback)
  local dieAniName = bc.BattleSpineAnimEnum.Death
  if self.spineComp:GetSpineAnimDuration(dieAniName) == nil then
    if nil ~= completeCallback then
      completeCallback()
    end
    return
  end
  self.spineComp:PlayAnim(dieAniName, false, completeCallback)
end

function BattleAwakerClient:Change2Idle_WhenNotDie()
  local isDie = self.fsmState == bc.AwakerFsmState.Dead and self:HasDieAni()
  local playIdle = not isDie
  if playIdle then
    self:EnterFsmState(bc.AwakerFsmState.Idle)
  end
end

function BattleAwakerClient:GetMotionAniName(aniName)
  local motion = self.awakerDataModel:GetMotion()
  if motion then
    local newAniName = motion[aniName] or aniName
    return newAniName
  else
    return aniName
  end
end

function BattleAwakerClient:PlaySummon()
  self.role.statusUI:HideOnSummon()
  self.role.statusUI:SetActive(false)
  
  local function onEndSummon()
    self.role.statusUI:SetActive(true)
    self:PlayIdleAnim(true)
  end
  
  local aniName = bc.BattleSpineAnimEnum.Summon
  local summonTimelineData = self.spineComp:GetActTimelineData(aniName)
  local summonAni = self.spineComp:GetSpineAnimDuration(aniName)
  if summonTimelineData then
    self:SetActive(false)
    self.timelinePlayer:PlayTimeline(summonTimelineData.file, bg.battleRender.gameSpeed or 1, 0, onEndSummon, nil, nil, function()
      self:SetActive(true)
    end)
    self.timelinePlayer:SetTimeout(summonTimelineData.duration)
  elseif summonAni then
    self.spineComp:PlayAnim(aniName, false, onEndSummon)
  else
    self.role.statusUI:SetActive(true)
  end
  self:PlayMultiSfx(self.animationConfig.summonSfx)
end

function BattleAwakerClient:TryPlayIdle()
  local aniName = bc.BattleSpineAnimEnum.Idle1
  if self.spineComp:GetIdleTimelineData(aniName) then
    self:PlayIdleTimeline()
  else
    local skeletonAnimation = self.spineComp.skeletonAnimation
    local curTrack = skeletonAnimation.AnimationState:GetCurrent(0)
    local aniNameEx = bc.BattleSpineAnimEnum.Idle .. "_" .. tostring(self.phase)
    local newAniName = self:GetMotionAniName(aniNameEx)
    if curTrack and curTrack.Animation and curTrack.Animation.Name == newAniName then
      return
    end
    self:PlayIdleAnim(true)
  end
end

function BattleAwakerClient:PlayIdleAnim(disableRandowmTime)
  local aniName = bc.BattleSpineAnimEnum.Idle .. "_" .. tostring(self.phase)
  local track = self.spineComp:PlayAnim(aniName, true)
  if not disableRandowmTime then
    if not track.Animation then
      if self.changeDieShow then
        self:PlayBeHitAnim()
      else
        Logger.Error("%s, newAniName is nil : %s", self.tid, aniName)
      end
    else
      track.TrackTime = track.Animation.Duration * math.random()
    end
  end
end

function BattleAwakerClient:PlayIdleTimeline()
  if self._isPlayingAssignTimeline then
    return
  end
  local newAniName = bc.BattleSpineAnimEnum.Idle1
  local idleTimelineData = self.spineComp:GetIdleTimelineData(newAniName)
  self.timelinePlayer:PlayTimeline(idleTimelineData.file, bg.battleRender.gameSpeed or 1, -1)
  self.timelinePlayer:SetTimeout(idleTimelineData.duration)
end

function BattleAwakerClient:SetIdleState()
  if self.fsmState == bc.AwakerFsmState.Idle then
    self:OnEnterIdleState()
  end
end

function BattleAwakerClient:ChangeFsmState(newState, config)
  self:ExitFsmState(self.fsmState, newState, config)
  self:EnterFsmState(newState, config)
end

function BattleAwakerClient:EnterFsmState(newState, config)
  local oldState = self.fsmState
  self.fsmState = newState
  if newState == bc.AwakerFsmState.Idle then
    self:OnEnterIdleState(config, oldState)
  elseif newState == bc.AwakerFsmState.Attack then
    self:OnEnterAttackState(config)
  elseif newState == bc.AwakerFsmState.BeHit then
    self:OnEnterBeHitState(config)
  elseif newState == bc.AwakerFsmState.Dead then
    if oldState == newState then
      return
    end
    self:OnEnterDeadState(config)
  end
end

function BattleAwakerClient:ExitFsmState(oldState, _, config)
  if oldState == bc.AwakerFsmState.Idle then
    self:OnExitIdleState(config)
  elseif oldState == bc.AwakerFsmState.Attack then
    self:OnExitAttackState(config)
  elseif oldState == bc.AwakerFsmState.BeHit then
    self:OnExitBeHitState(config)
  elseif oldState == bc.AwakerFsmState.Dead then
    self:OnExitDeadState(config)
  end
end

function BattleAwakerClient:Log(str)
  if self.isMonster then
    local monsterName = LT.Text(DT.MonsterConfig[self.tid].MonsterName)
    Logger.Error(monsterName .. " : " .. str)
  end
end

function BattleAwakerClient:OnEnterIdleState(_, oldState)
  local newAniName = bc.BattleSpineAnimEnum.Idle1
  if self.spineComp:GetIdleTimelineData(newAniName) then
    self:PlayIdleTimeline()
  elseif oldState == bc.AwakerFsmState.Attack or oldState == bc.AwakerFsmState.BeHit then
    self:PlayIdleAnim(true)
  else
    self:PlayIdleAnim()
  end
end

function BattleAwakerClient:OnExitIdleState(_)
end

function BattleAwakerClient:IsDieState()
  return self.dead
end

function BattleAwakerClient:SetTimelineLooping(loop)
  if self.timelinePlayer then
    self.timelinePlayer:SetLoopingTimes(loop)
  end
end

function BattleAwakerClient:SetTempArg()
end

function BattleAwakerClient:SetSkillPerform(config)
  local skillId = config.performSkillId or config.skillConfigId
  local performType, perform, sfx, voc = SkillPerformUtils.GetPerformByCondition(self, skillId, config.performIdx)
  self.skillPerformType = performType
  self.skillPerform = perform
  self.skillSfx = sfx
  self.skillVoc = voc
  config.isTimeline = self.skillPerformType == bc.SkillPerformType.Timeline
  config.castAnimation = perform
end

function BattleAwakerClient:OnEnterAttackState(config)
  Logger.Info("释放技能 : " .. config.skillConfigId)
  self.attackComplete = false
  self.role.lastAttackAwaker = self
  if not config.castAnimation then
    self:SetSkillPerform(config)
  end
  local castAnimation = config.castAnimation
  local needStepForward = self:_NeedStepForward(config)
  if needStepForward then
    self:MoveForward(castAnimation)
    self:_WaitMoveForwardThenAttack(config)
  else
    if "ExSkill" == castAnimation then
      bg.battleScene:SetActiveAwaker(self)
    end
    self:_DoAttack(config)
  end
end

function BattleAwakerClient:_NeedStepForward(config)
  local castAnimation = config.castAnimation
  if nil == castAnimation then
    return false
  end
  if castAnimation == bc.ArriveAnimation then
    return false
  end
  if "ExSkill" == castAnimation then
    return false
  end
  if self.movingState == rc.AwakerMovingState.Center then
    return false
  end
  local timelineData = config.isTimeline and TimelineConfig.GetTimelineData(config, false)
  if not timelineData or TimelineConfig.IsMonsterTimeline(timelineData.file) then
    return false
  end
  return true
end

function BattleAwakerClient:_WaitMoveForwardThenAttack(config)
  if self.forwardAwaiter then
    self.forwardAwaiter:OnCompleted(function()
      self:_DoAttack(config)
    end)
  else
    self:_DoAttack(config)
  end
end

function BattleAwakerClient:_DoAttack(config)
  local DT = bg.DT
  local stayInCenter = self.stayInCenter
  local firstTargetUid = config.targetRoleUid
  local nextBeHitUid = bg.battleRender.recordMgr:GetNextBeHitRoleUid()
  self.stayInCenter = false
  if bg.battleScene.activeAwaker == self then
    bg.battleScene:SetActiveAwaker(self)
  end
  local skillConfig = DT.Skill[config.performSkillId or config.skillConfigId]
  self:PlayAttackVoice()
  local isHaveDeadResist, isHaveRespawn = bg.battleRender.recordMgr:GetDeadResistAndRespawn()
  local isExSkill, isAwakeSkill = self:IsUniqSkill(config, skillConfig)
  if isExSkill and self.awakerDataModel and self.awakerDataModel.GetProperty then
    local ultiSkillLevelUp = self.awakerDataModel:GetProperty("ulti_skill_level_up") or 0
    if ultiSkillLevelUp > 0 then
      config.isSuperUtliSkill = true
    end
  end
  local gameSpeed = bg.battleRender.gameSpeed or 1
  local castAnim = config.castAnimation
  if config.isTimeline then
    if self.timelinePlayer:IsPlaying() then
      self.timelinePlayer:Stop()
    end
    config.castAnimation = self:GetMotionAniName(castAnim)
    local skinId = self.awakerDataModel:GetSkinId()
    if skinId and skinId ~= cd.DefaultSkinTid and AwakerSkinUtils.IsReplaceBattleEffect(skinId) then
      local resNum = AwakerSkinUtils.GetSkinResNum(skinId)
      config.animFile = AwakerDataUtils.ReplaceSkinRes(config.animFile, self.tid, resNum)
    end
    local timelineData = TimelineConfig.GetTimelineData(config)
    local monsterIncluded = false
    if isAwakeSkill then
      self:HideOtherAwaker(monsterIncluded)
    elseif isExSkill then
      if bg.isPVP then
        gameSpeed = self:ChangePVPExSkillSpeed()
      end
      UIManager.Instance:CloseByUrl(Urls.MonsterBuffListPanel)
      local keeperSkillController = KeeperSkillController.Instance
      keeperSkillController:CloseBattlePopupKeeperSkillTip()
      UIManager.Instance:CloseByUrl(Urls.AlertToolTipsPanel)
      UIManager.Instance:Show(Urls.UIMaskPanel)
      EventMgr.Instance.BattleAwakerExSkillStart:Dispatch(self.uid)
    end
    bg.battleRender.robotMgr:MinusRobotTime(timelineData.duration)
    bg.battleScene:SetCurTimelinePlayer(self)
    self.isAwakerVisbleTlEnable = true
    local seekTime = stayInCenter and bc.PreWithDrawDuration or 0
    
    local function completeCallback()
      self:OnTLComplete(config, monsterIncluded)
      self:OnFinishAttack(isHaveDeadResist, isHaveRespawn)
    end
    
    local eventCallback = System.bind(self.OnTLEvent, self, config, skillConfig, monsterIncluded)
    if config.castAnimation == bc.SkillPerformName.ExSkill then
      EventMgr.Instance.OnAwakerExSkillAnimStart:Dispatch()
    end
    if self.triggerHideUI and self.lastUIHideConfig then
      self:ForceCenterState()
    end
    self:TryResumeShowUIEvent()
    self.forbiddenMoveBack = true
    if bg.isPVE and self.camp == bc.BattleCamp.Camp2 and not self.pveCamp2AttackAwaiter then
      self.pveCamp2AttackAwaiter = Awaiter.Dispatch("PVECamp2Attack", 15)
    end
    if isExSkill then
      Awaiter.Dispatch("AwakerExSkill", timelineData.duration)
    end
    local timelineFile = timelineData.file
    if config.isSuperUtliSkill then
      timelineFile = string.gsub(timelineFile, "_ExSkill", "_SuperExSkill")
    end
    self.timelinePlayer:Seek(seekTime):PlayTimeline(timelineFile, gameSpeed, 0, completeCallback, eventCallback, self.abortController.signal, nil, firstTargetUid, nextBeHitUid):SetTimeout(timelineData.duration)
    self.timelinePlayer.isBattleSkillTimeline = true
    self.forbiddenMoveBack = false
    self:PlaySkillSfxAndSound(config, skillConfig)
  elseif isExSkill then
    self:PlayMultiSfx(DT.GetOriginalConstant("PVPUltiSkillSfx"), 1.0)
    local delay = DT.GetConstant("PVPUltiSkillSfxWaitingTime", 1)
    local awaiter = Awaiter.Dispatch("PVPExSkillAttack", delay, true)
    awaiter:OnCompleted(function()
      self:PlayAttackAnim(config.castAnimation, function()
        self:OnFinishAttack(isHaveDeadResist, isHaveRespawn)
      end)
      self:PlaySkillSfxAndSound(config, skillConfig)
    end)
  else
    self:PlayAttackAnim(config.castAnimation, function()
      self:OnFinishAttack(isHaveDeadResist, isHaveRespawn)
    end)
    self:PlaySkillSfxAndSound(config, skillConfig)
  end
end

function BattleAwakerClient:OnFinishAttack(isHaveDeadResist, isHaveRespawn)
  if isHaveDeadResist and not isHaveRespawn then
    self:OnDeadResistRecord()
  end
end

function BattleAwakerClient:OnDeadResistRecord()
  local guideName = CommonDefine.GuideBattle.OnDeadResistRecord
  EventMgr.Instance.GuideBattleEvent:Dispatch(guideName)
  if AvgStoryManager.Instance:IsPlaying() then
    local awaiter = Awaiter.Dispatch("OnDeadResistGuide", 9999, true)
    AvgStoryManager.Instance:WaitStoryFinish(nil, function()
      awaiter:SetCompleted()
    end)
  end
end

function BattleAwakerClient:IsUniqSkill(config, skillConfig)
  local castAnim = config.castAnimation
  local isExSkill = castAnim == bc.SkillPerformName.ExSkill
  if bg.isPVP then
    isExSkill = isExSkill or skillConfig.Slot == "Slot_Super"
  end
  local isAwakeSkill = castAnim == bc.SkillPerformName.Exalt
  return isExSkill, isAwakeSkill
end

function BattleAwakerClient:PlaySkillSfxAndSound(config, skillConfig)
  local sfxIds
  if self.isMonster then
    sfxIds = self:GetSpineAttackSfx(config.skillConfigId)
  elseif bg.isPVP then
    sfxIds = self:GetSpineAttackSfx(config.skillConfigId)
  end
  if sfxIds then
    self:PlayMultiSfx(sfxIds, 1.0)
  end
  if self.skillSfx then
    BattleAudioUtils.PostAudio(self:_TryChangeSkillSfxEventName(config, self.skillSfx), self.rootNode, self.curSkin)
  end
  if self.skillVoc then
    BattleAudioUtils.PostTalk(self:_TryChangeSkillSfxEventName(config, self.skillVoc), self.rootNode, self.curSkin)
  elseif skillConfig.VOC and #skillConfig.VOC > 0 then
    local voc = skillConfig.VOC[math.random(1, #skillConfig.VOC)]
    BattleAudioUtils.PostTalk(self:_TryChangeSkillSfxEventName(config, voc), self.rootNode, self.curSkin)
  end
end

function BattleAwakerClient:_TryChangeSkillSfxEventName(config, evtName)
  if not config.isSuperUtliSkill then
    return evtName
  end
  local newEventName = string.gsub(evtName, "_ExSkill", "_SuperExSkill")
  local len = AudioManager.Instance:GetEventLength(newEventName)
  if len > 0 then
    return newEventName
  end
  return evtName
end

function BattleAwakerClient:ChangePVPExSkillSpeed()
  local gameSpeed = bg.DT.GetConstant("PVPUltiSkillPlaybackSpeed")
  bg.battleRender.gameSpeed = gameSpeed
  AudioManager.Instance:PostSoundEvent("BATTLE_DOUBLESPEED_ON")
  return gameSpeed
end

function BattleAwakerClient:ChangePVPExSkillSpeedBack()
  local gameSpeed = bg.DT.GetConstant("PVPPlaybackSpeed")
  bg.battleRender.gameSpeed = gameSpeed
  AudioManager.Instance:PostSoundEvent("Set_State_Ingame_DoubleSpeed_150Percent")
  return gameSpeed
end

function BattleAwakerClient:PlayAttackShake(sfxNode)
  local helperCom = bg.battleScene.cameraComp
  if helperCom:IsLockAttackShake() then
    return
  end
  if helperCom:IsPlayingAttackShake() then
    return
  end
  if not sfxNode then
    return
  end
  local attackShake = sfxNode:GetComponent(typeof(CameraEffectShake))
  if not attackShake then
    return
  end
  attackShake:LoadParam()
  local castAniName = self.skillPerform
  local delayTime = self:GetDelayPlayTime(attackShake, castAniName)
  helperCom:PlayAttackShakeDelay(delayTime)
end

function BattleAwakerClient:PlayEffectShake(sfxNode)
  local helperCom = bg.battleScene.cameraComp
  if helperCom:IsPlayingAttackShake() then
    return
  end
  local attackShake = sfxNode:GetComponent(typeof(CameraEffectShake))
  if not attackShake then
    return
  end
  attackShake:LoadParam()
  local delayTime = self:GetDelayPlayTime(attackShake)
  helperCom:PlayCommonShakeDelay(delayTime)
end

function BattleAwakerClient:GetDelayPlayTime(attackShake, castAniName)
  if nil == castAniName or "" == castAniName then
    castAniName = self.fsmState and bc.BattleSpineEventEnum[self.fsmState] or ""
  end
  local castEventName = attackShake:GetCastName()
  local delayTime = attackShake:GetDelayTime()
  local castTime = self.spineComp:GetCastTimeByAniName(castAniName, castEventName)
  local playTime = castTime + delayTime
  return playTime
end

function BattleAwakerClient:OnExitAttackState(_)
end

function BattleAwakerClient:OnEnterBeHitState(config)
  if self:InHidingState() then
    return
  end
  if self.role.roleType == bc.RoleType.Monster then
    self:PlayMonsterHitVoice()
  elseif self.role.roleType == bc.RoleType.Awaker then
    if bg.isPVE then
      self:PlayAwakerHitVoice()
    else
      self:PlayPVPAwakerHitVoice(config)
    end
  end
  if self.timelinePlayer and self.timelinePlayer.isBattleSkillTimeline and self.timelinePlayer:IsPlaying() then
    return
  end
  if self.beHitTimelinePlayer and self.beHitTimelinePlayer:IsPlaying() then
    return
  end
  
  local function onEndHit()
    self:Change2Idle_WhenNotDie()
  end
  
  local hitAniName = bc.BattleSpineAnimEnum.Hit
  if self.spineComp:GetActTimelineData(hitAniName) then
    self:PlayBeHitTimeline(onEndHit)
  else
    self:PlayBeHitAnim(onEndHit)
  end
end

function BattleAwakerClient:OnExitBeHitState(_)
end

function BattleAwakerClient:OnTLComplete(config, monsterIncluded)
  if not bg.battleRender then
    return
  end
  self:OnEndTimeLine(config)
  if self.pveCamp2AttackAwaiter then
    self.pveCamp2AttackAwaiter:SetCompleted()
    self.pveCamp2AttackAwaiter = nil
  end
  if config.castAnimation == bc.SkillPerformName.Exalt then
    self:ReShowHideAwaker(monsterIncluded)
  elseif config.castAnimation == bc.SkillPerformName.ExSkill then
    UIManager.Instance:CloseByUrl(Urls.UIMaskPanel)
    if bg.isPVP then
      self:ChangePVPExSkillSpeedBack()
    end
  end
  self:ActionFinish(config.castAnimation)
  if bg.battleScene then
    bg.battleScene:SetCurTimelinePlayer(nil)
  end
  EventMgr.Instance.BattleAwakerExSkillEnd:Dispatch(self.uid)
  self:ClearAttackShakeState()
end

function BattleAwakerClient:OnTLEvent(config, skillConfig, monsterIncluded, eventId)
  if not bg.battleRender then
    return
  end
  if eventId == rc.TimeLineEvent.MoveForward then
    if self.movingState == rc.AwakerMovingState.Center then
      return
    end
    self:MoveForward(config.castAnimation, config)
  elseif eventId == rc.TimeLineEvent.MoveBack then
    self:ActionFinish(config.castAnimation)
  elseif eventId == rc.TimeLineEvent.ShowSuperUtlSkillPainting then
    if self.role.camp == bc.BattleCamp.Camp1 then
      self:PlayAwakerSuperUtlSkillPaintingAnmation(skillConfig)
    end
    self:ShowBattleExSkillPanel(config, skillConfig)
  elseif eventId == rc.TimeLineEvent.ShowAwakerPainting then
    if self.role.camp == bc.BattleCamp.Camp1 then
      self:PlayAwakerPaintingAnmation(skillConfig)
    end
    self:ShowBattleExSkillPanel(config, skillConfig)
  elseif eventId == rc.TimeLineEvent.HideUI then
    self.triggerHideUI = true
    self.monsterIncluded = monsterIncluded
    self.lastUIHideConfig = config
    bg.battlePanel:HideUI(true)
    if not self.isAwakerVisbleTlEnable then
      self:HideOtherAwaker(monsterIncluded)
    end
  elseif eventId == rc.TimeLineEvent.ShowUI then
    self:OnShowUIEvent(config, monsterIncluded)
  elseif eventId == rc.TimeLineEvent.ShowFollowEffect then
    self:SetFollowSfxVisible(true)
  elseif eventId == rc.TimeLineEvent.HideFollowEffect then
    self:SetFollowSfxVisible(false)
  end
end

function BattleAwakerClient:ShowBattleExSkillPanel(config, skillConfig, delayTime)
  delayTime = delayTime or 0.5
  self.exSkillPanelTimer = TimerManager.Instance:CreateTimer(delayTime, 0, nil, function()
    if skillConfig.AwakerID then
      local skillTypes = BattleSkillUtils.GetSkillType(skillConfig, self.breakLevel, self.potencyLevel)
      local skillType = skillTypes[1]
      if skillType and skillType ~= bc.SkillType.Card_Awake then
        UIManager.Instance:Reopen(Urls.BattleExSkillPanel, skillConfig.AwakerID, config.isSuperUtliSkill)
      end
    end
  end)
end

function BattleAwakerClient:ClearexSkillPanelTimer()
  if self.exSkillPanelTimer then
    TimerManager.Instance:StopTimer(self.exSkillPanelTimer)
  end
  self.exSkillPanelTimer = nil
end

function BattleAwakerClient:OnShowUIEvent(config, monsterIncluded)
  if not bg.battlePanel then
    return
  end
  self.triggerHideUI = false
  self.lastUIHideConfig = nil
  bg.battlePanel:HideUI(false)
  if not self.isAwakerVisbleTlEnable then
    self:ReShowHideAwaker(monsterIncluded)
  end
  UIManager.Instance:CloseByUrl(Urls.BattleExSkillPanel)
  self:ClearexSkillPanelTimer()
  if config.castAnimation == bc.SkillPerformName.ExSkill then
    EventMgr.Instance.OnAwakerExSkillAnimEnd:Dispatch()
  end
end

function BattleAwakerClient:TryResumeShowUIEvent()
  if self.triggerHideUI and self.lastUIHideConfig then
    self:OnShowUIEvent(self.lastUIHideConfig, self.monsterIncluded)
    self:ClearexSkillPanelTimer()
    bg.battleScene:BattleHideEnemy(false)
    bg.battleScene:BattleHideFriend(false)
    bg.battleScene:CancelActiveAwaker(self)
  end
end

function BattleAwakerClient:ForceCenterState()
end

function BattleAwakerClient:PlayAwakerPaintingAnmation(skillConfig)
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect)
  BattleAwakerUltiSkillPainting.Play(self, skillConfig, function()
    if bg.battleDataCenter then
      bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
    end
  end, self.abortController.abortSignal)
end

function BattleAwakerClient:PlayAwakerSuperUtlSkillPaintingAnmation(skillConfig)
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect)
  BattleAwakerSuperUltiSkillPainting.Play(self, skillConfig, function()
    if bg.battleDataCenter then
      bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
    end
  end, self.abortController.abortSignal)
end

function BattleAwakerClient:OnEndTimeLine(_)
end

function BattleAwakerClient:HideOtherAwaker(monsterIncluded)
  self.hideAwakerList = {}
  local awakerList = bg.battleScene:GetPlayerAwakerList()
  for _, awaker in ipairs(awakerList) do
    if awaker ~= self then
      awaker:SetActive(false)
      table.insert(self.hideAwakerList, awaker)
    end
  end
  local playerRole = bg.battleScene:GetPlayerRole()
  if playerRole then
    playerRole.statusUI:SetActive(false)
  end
  if monsterIncluded then
    local monsters = bg.battleScene:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
    for _, monster in ipairs(monsters) do
      for _, awaker in ipairs(monster.awakerList) do
        awaker:SetActive(false)
      end
      monster.statusUI:SetActive(false)
      monster.statusUI.intentionItem:SetActive(false)
    end
  end
end

function BattleAwakerClient:ReShowHideAwaker(monsterIncluded)
  for _, awaker in ipairs(self.hideAwakerList or {}) do
    awaker:SetActive(true)
  end
  local playerRole = bg.battleScene:GetPlayerRole()
  if playerRole then
    playerRole.statusUI:SetActive(true)
  end
  if monsterIncluded then
    local monsters = bg.battleScene:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
    for _, monster in ipairs(monsters) do
      for _, awaker in ipairs(monster.awakerList) do
        awaker:SetActive(true)
      end
      monster.statusUI:SetActive(true)
      monster.statusUI.intentionItem:SetActive(true)
    end
  end
end

function BattleAwakerClient:SetActive(isActive)
  if not self:IsDieState() then
    self.spineComp.visualNode:SetActive(isActive)
  elseif self.tombstoneComp then
    if isActive then
      self.tombstoneComp:Show()
    else
      self.tombstoneComp:Hide()
    end
  end
end

function BattleAwakerClient:_ForceHideRole()
  if self.spineComp and self.spineComp.visualNode and not IsNil(self.spineComp.visualNode) then
    self.spineComp.visualNode:SetActive(false)
  end
end

function BattleAwakerClient:OnAwaked(_)
  if not self.awaked then
    local awakenSfxList = bg.DT.Constant.BattleAwakenEffect.Data
    for _, sfxId in ipairs(awakenSfxList) do
      self:PlaySfx(sfxId)
    end
    self.awaked = true
    self.awakerDataModel:SetAwaked(true)
    self.role:PushFloatingText(bc.FloatingTextType.UltiEnergy, LT.Text("RoleDetailsSkill_Str_AbilitySkill"))
  end
end

local DissolveProgressId = CS.UnityEngine.Shader.PropertyToID("_DissolveProgress")
local EdgeColorId = CS.UnityEngine.Shader.PropertyToID("_EdgeColor")
local MaxDissolveProgress = 2
local MaxDissolveProgress_2 = 1.3
local EdgeColor2 = Color(0.498, 0.498, 0.498, 0)
local EdgeColor3 = Color(0.1254, 0.1254, 0.1254, 0)

function BattleAwakerClient:_ForceDissolve()
  if not (self.spineComp and self.spineComp.spineNode) or IsNil(self.spineComp.spineNode) then
    return
  end
  local renderer = self.spineComp.spineNode:GetComponent(typeof(MeshRenderer))
  if renderer then
    local mpb = MaterialPropertyBlock()
    renderer:GetPropertyBlock(mpb)
    mpb:SetFloat(DissolveProgressId, MaxDissolveProgress)
    renderer:SetPropertyBlock(mpb)
  end
end

function BattleAwakerClient:OnEnterDeadState()
  if bg.isPVP_TRAIN and not bg.battleDataCenter:IsMyCamp(self.camp) then
    PvpController.Instance:ReqOnTrialDefeatAwaker(self.tid)
  end
  if bg.isPVE and bg.battleDataCenter:IsMyCamp(self.camp) then
    return
  end
  self.dead = true
  if self.pveCamp2AttackAwaiter then
    self.pveCamp2AttackAwaiter:SetCompleted()
    self.pveCamp2AttackAwaiter = nil
  end
  if self.role and self.role.statusUI and self.role.statusUI.bloodUI and self.role.statusUI.bloodUI.PlayBloodDeadAnim then
    self.role.statusUI.bloodUI:PlayBloodDeadAnim()
  end
  local _dieAnimDissolveTimer
  local awaiter = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiter, "AwakerDeadTimeline", 10)
  
  function self.deadAnimCompleteFunc()
    if bg.isPVP then
      self.spineComp:Hide()
      if not self.tombstoneComp then
        self.tombstoneComp = self:AddBattleComponent(BattleTombstoneComp, self.rootNode)
      end
      self.tombstoneComp:Appear()
    else
      self.rootNode:SetActive(false)
    end
    self.role:OnAwakerDead(self)
    awaiter:SetCompleted()
  end
  
  local function awaiterComplete()
    local _hpNow = self.role:GetLogicHp()
    if _dieAnimDissolveTimer then
      bg.battleRender:UnperformWithDelay(_dieAnimDissolveTimer)
      _dieAnimDissolveTimer = nil
    end
    if _hpNow > 0 then
      self.role:Revive()
      return
    end
    if self.deadAnimCompleteFunc then
      self.deadAnimCompleteFunc()
    end
    if bg.isPVE and self.camp == bc.BattleCamp.Camp2 then
      self:_ForceHideRole()
    end
    self.changeDieShow = nil
  end
  
  local dieAniName = bc.BattleSpineAnimEnum.Death
  local dieTl = nil ~= self.spineComp:GetActTimelineData(dieAniName)
  local isHaveDieAni = nil ~= self.spineComp:GetSpineAnimDuration(dieAniName)
  if nil ~= self.changeDieShow then
    local DieConfig = DT.GetOriginalConstant(self.changeDieShow)
    if not DieConfig then
      Logger.Error("BattleAwakerClient:OnEnterDeadState changeDieShow config is nil " .. tostring(self.changeDieShow))
      if awaiterComplete then
        awaiterComplete()
      end
      return
    end
    self:ChangeFsmState(bc.AwakerFsmState.Idle)
    local spineSize = self.animationConfig.spineSize
    local dissolveSize = 0
    local dieDissolveCfgName = spineSize and CommonDefine.SpineDieDissolve[spineSize]
    if dieDissolveCfgName then
      local dieDissolveParams = bg.DT.GetOriginalConstant(dieDissolveCfgName)
      if dieDissolveParams then
        dissolveSize = 0.25 * math.abs(dieDissolveParams[1])
      end
    end
    local isFlip = (self.animationConfig.isFaceLeft or nil == self.animationConfig.isFaceLeft) and 1 or -1
    print("tlslash spineSize 怪物-", DT.MonsterConfig[self.tid].MonsterName, "- 体型大小:", spineSize, " 是否翻转：", -1 == isFlip)
    self:PlayMultiSfx({
      DieConfig[1]
    })
    local slashDistance = DieConfig[2]
    local easeType = DieConfig[3]
    local duration = DieConfig[4]
    local startTime = DieConfig[5]
    local middlePause = DieConfig[6]
    local easeTypeDissolve = DieConfig[7]
    local durationDissolve = DieConfig[8]
    local paramStr = "" .. isFlip .. "," .. slashDistance .. ",0,1," .. easeType .. "," .. duration .. "," .. middlePause .. ",0," .. dissolveSize .. "," .. easeTypeDissolve .. "," .. durationDissolve
    self._dieSlashTimer = TimerManager.Instance:CreateTimer(startTime, 0, nil, function()
      TimelineTargetSlashController.Instance:Start(self, paramStr, awaiterComplete)
    end)
    return
  end
  if dieTl then
    self:PlayDieTimeline(awaiterComplete)
  elseif isHaveDieAni then
    self:PlayDeadVoice()
    self:PlayDieAnim(awaiterComplete)
    self:PlayMultiSfx(self.animationConfig.dieSfx)
    if bg.isPVE and self.camp == bc.BattleCamp.Camp2 then
      _dieAnimDissolveTimer = bg.battleRender:PerformWithDelay(3, function()
        _dieAnimDissolveTimer = nil
        if not self.dead then
          return
        end
        self:_ForceDissolve()
      end, self)
    end
  else
    self:PlayDeadVoice()
    if bg.isPVP then
      self:PlayMonsterDeadEffect(awaiterComplete, true)
      self:PlayMultiSfx(self.animationConfig.dieSfx)
      return
    end
    if self.role.camp == bc.BattleCamp.Camp2 then
      self:PlayMonsterDeadEffect(awaiterComplete)
      self:PlayMultiSfx(self.animationConfig.dieSfx)
    else
      awaiter:SetCompleted()
    end
  end
end

function BattleAwakerClient:HasDieAni()
  local dieAniName = bc.BattleSpineAnimEnum.Death
  local dieTl = self.spineComp:GetActTimelineData(dieAniName) ~= nil
  local dieAni = nil ~= self.spineComp:GetSpineAnimDuration(dieAniName)
  return dieTl or dieAni
end

function BattleAwakerClient:PlayDieTimeline(finishCall)
  if self.beHitTimelinePlayer then
    self.beHitTimelinePlayer:Dispose()
    self.beHitTimelinePlayer = nil
  end
  local dieAniName = bc.BattleSpineAnimEnum.Death
  local dieTimelineData = self.spineComp:GetActTimelineData(dieAniName)
  if string.find(dieTimelineData.file, "BUnit_Monster_B0008_Die") then
    self.deadAnimCheckTimer = TimerManager.Instance:CreateTimer(0, -1, function()
      if not self.spineComp or IsNil(self.spineComp.skeletonAnimation) then
        return
      end
      local spineAnimationState = self.spineComp.skeletonAnimation.AnimationState
      if not spineAnimationState then
        return
      end
      local track = spineAnimationState:GetCurrent(0)
      if not (track and track.Animation) or track.Animation.Name ~= "Die" then
        self.spineComp.skeletonAnimation.AnimationName = nil
        spineAnimationState:SetAnimation(0, "Die", false)
      end
    end)
  end
  self.timelinePlayer:PlayTimeline(dieTimelineData.file, 1, 0, function()
    if self.deadAnimCheckTimer then
      TimerManager.Instance:StopTimer(self.deadAnimCheckTimer)
      self.deadAnimCheckTimer = nil
    end
    if finishCall then
      finishCall()
    end
  end)
  self.timelinePlayer:SetTimeout(dieTimelineData.duration)
end

function BattleAwakerClient:PlayAssignTimeline(assetPath, finishCall)
  self._isPlayingAssignTimeline = true
  self.timelinePlayer:PlayTimeline(assetPath, 1, 0, function()
    self._isPlayingAssignTimeline = false
    if finishCall then
      finishCall()
    end
  end)
end

function BattleAwakerClient:OnExitDeadState(_)
end

function BattleAwakerClient:Revive()
  self.dead = false
  self.fsmState = bc.AwakerFsmState.Idle
  self:OnEnterIdleState()
  self.deadAnimCompleteFunc = nil
  if self.tombstoneComp then
    self.tombstoneComp:Dispose()
    self.tombstoneComp = nil
  end
  self.spineComp:Show()
  self.rootNode:SetActive(true)
  self.spineComp.spineNode:SetActive(true)
  self:ResetSpine()
end

function BattleAwakerClient:ResetSpine()
  if self.deadTween then
    self.deadTween:Kill()
    self.deadTween = nil
  end
  local renderer = self.spineComp.spineNode:GetComponent(typeof(MeshRenderer))
  local material = renderer.sharedMaterial
  local mpb = MaterialPropertyBlock()
  local resetProgress = -6
  local progress = material:GetFloat(DissolveProgressId)
  mpb:SetFloat(DissolveProgressId, -6)
  if (self.__tlslashMatLockCount or 0) > 0 then
    print(string.format("tlslash mpb ResetSpine while locked uid=%s", tostring(self.uid)))
  end
  DOTween.To(function()
    return progress
  end, function(v)
    progress = v
    mpb:Clear()
    mpb:SetFloat(DissolveProgressId, progress)
    renderer:SetPropertyBlock(mpb)
  end, resetProgress, 0.5, self)
end

function BattleAwakerClient:Set24ShaderSwitch(isOpen)
  self.matEffectComp:Set24ShaderSwitch(isOpen)
end

function BattleAwakerClient:PlayMonsterDeadEffect(awaiterComplete, forPVP)
  local renderer = self.spineComp.spineNode:GetComponent(typeof(MeshRenderer))
  local material = renderer.sharedMaterial
  local mpb = MaterialPropertyBlock()
  local color = material:GetColor(EdgeColorId)
  if (self.__tlslashMatLockCount or 0) > 0 then
    print(string.format("tlslash mpb PlayMonsterDeadEffect while locked uid=%s", tostring(self.uid)))
  end
  if self.deadTween then
    self.deadTween:Kill()
  end
  local sequence = DOTween.Sequence(self)
  self.deadTween = sequence
  sequence:AppendInterval(0.35)
  sequence:Append(DOTween.To(function()
    return color
  end, function(v)
    color = v
    mpb:Clear()
    mpb:SetColor(EdgeColorId, color)
    renderer:SetPropertyBlock(mpb)
  end, EdgeColor2, 1, self))
  sequence:Append(DOTween.To(function()
    return color
  end, function(v)
    color = v
    mpb:Clear()
    mpb:SetColor(EdgeColorId, color)
    renderer:SetPropertyBlock(mpb)
  end, EdgeColor3, 0.3, self)):OnComplete(function()
    self.deadTween = nil
  end)
  local spineSize = self.animationConfig.spineSize
  local dieDissolveCfgName = spineSize and CommonDefine.SpineDieDissolve[spineSize]
  local dissolveStart, dissolveEnd, dissoleDura = -6, forPVP and MaxDissolveProgress_2 or MaxDissolveProgress, 1.3
  if dieDissolveCfgName then
    local dieDissolveParams = bg.DT.GetOriginalConstant(dieDissolveCfgName)
    if dieDissolveParams then
      dissolveStart, dissolveEnd, dissoleDura = table.unpack(dieDissolveParams)
    end
  end
  local progress = material:GetFloat(DissolveProgressId)
  sequence = DOTween.Sequence(self)
  sequence:AppendInterval(0.35)
  sequence:Append(DOTween.To(function()
    return dissolveStart
  end, function(v)
    progress = v
    mpb:Clear()
    mpb:SetFloat(DissolveProgressId, progress)
    renderer:SetPropertyBlock(mpb)
  end, dissolveEnd, dissoleDura, self)):OnComplete(function()
    if awaiterComplete then
      awaiterComplete()
    end
  end)
end

function BattleAwakerClient:EnableHighlight(enable)
  if self.highlightEnabled == enable then
    return
  end
  if true == enable then
    AudioManager.Instance:PostSoundEvent("Audio_UI_Poker_Card_Slc")
  end
  self.highlightEnabled = enable
  if self.lightNode ~= nil then
    self.lightNode:SetActive(enable)
  end
end

function BattleAwakerClient:OnPropertyChanged(data)
  if data.uid ~= self.uid then
    return
  end
  self.awakerDataModel:SetProperty(data.propertyType, data.value)
end

function BattleAwakerClient:GetSpineCom()
  return self.spineComp
end

function BattleAwakerClient:GetAnimationConfig()
  return self.allAnimCfgs[self.animIdx] or {}
end

function BattleAwakerClient:SetToDeadState()
  self.dead = true
  self.fsmState = bc.AwakerFsmState.Dead
  self.spineComp.spineNode:SetActive(false)
  self.shadowTransform.gameObject:SetActive(false)
  if bg.isPVP then
    if not self.tombstoneComp then
      self.tombstoneComp = self:AddBattleComponent(BattleTombstoneComp, self.rootNode)
    end
    self.tombstoneComp:Show()
  end
end

return BattleAwakerClient
