local Animator = CS.UnityEngine.Animator
local LuaCSharpUtil = CS.Z1Client.LuaCSharpUtil
local CommonUniversalCycle = "TimelineRoot/InScenes/UniversalCycle/UniversalCycle.prefab"
local BattleCameraComponent, Super = System.NewClass("BattleRolePropertyClient", BattleComponent)

function BattleCameraComponent:ctor(mainCamera, mainCameraVM)
  Super.ctor(self)
  self.isFirstToPlayer = true
  self.camera = mainCamera
  self.mainCameraVM = mainCameraVM
  local sceneCfg = bg.battleScene.battleSceneCfg
  self.startTimeline = sceneCfg.CameraController
  if SettingManager.Instance:IsCloseBattleBgMovement() then
    self.startTimeline = nil
  end
  if not self.startTimeline then
    self.startTimeline = CommonUniversalCycle
  end
  self.timelinePlayer = TimelinePlayer(mainCameraVM)
  self.cameraShake = mainCamera:GetComponent(typeof(CS.Thinksquirrel.CShake.CameraShake))
  LuaCSharpUtil.AddonEndShaking(self.cameraShake, System.fn(self, self.EndShaking))
  self.isInAttackShake = false
  self.lockToAttackShake = false
end

function BattleCameraComponent:EndShaking()
  if self.isInAttackShake then
    self.isInAttackShake = false
  end
end

function BattleCameraComponent:InitCamera(sceneCamera)
  if sceneCamera then
    self.camera.transform.position = sceneCamera.transform.position
    self.camera.transform.rotation = sceneCamera.transform.rotation
    self.camera.orthographic = sceneCamera.orthographic
    self.camera.orthographicSize = sceneCamera.orthographicSize
    self.camera.fieldOfView = sceneCamera.fieldOfView
    sceneCamera.gameObject:SetActive(false)
  else
    self.camera.transform.localPosition = CS.UnityEngine.Vector3(0, 0, -12)
    self.camera.transform.localRotation = CS.UnityEngine.Quaternion.identity
    self.camera.fieldOfView = 45
    self.camera.farClipPlane = 3500
  end
end

function BattleCameraComponent:SetBossPhase()
end

function BattleComponent:Tick()
end

function BattleCameraComponent:GetCycleTimelinePath()
  if not self.startTimeline then
    return
  end
  return self.startTimeline
end

function BattleCameraComponent:Dispose()
  if self.camera then
    self.camera.orthographic = false
    self.camera = nil
  end
  if self.timelinePlayer then
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
  if self.cameraShake then
    self.cameraShake = nil
  end
  self:UnLockAttackShake()
  self.mainCameraVM = nil
end

function BattleCameraComponent:StopTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
  end
end

function BattleCameraComponent:OnBattleStart()
  self:PlayUniversalCycle()
end

function BattleCameraComponent:PauseUniversalCycle()
  if self.timelinePlayer then
    self.timelinePlayer:Pause()
  end
end

function BattleCameraComponent:ResumeUniversalCycle()
  if self.timelinePlayer then
    self.timelinePlayer:Resume()
  end
end

function BattleCameraComponent:PlayUniversalCycle()
  local startTimeline = self:GetCycleTimelinePath()
  if startTimeline then
    local timelineConfig = TimelineConfig()
    timelineConfig.assetPath = startTimeline
    timelineConfig.looping = -1
    self.timelinePlayer:Play(timelineConfig)
    EventMgr.Instance.BattleCameraChange:Dispatch()
  end
end

function BattleCameraComponent:PlayCameraTimeLine(timePath, finishCallback)
  if finishCallback then
    finishCallback()
  end
end

function BattleCameraComponent:OnChangeBoutCamp()
  if self:IsPlayerBout() then
    if self.isFirstToPlayer then
      self.isFirstToPlayer = false
      self:SetTrigger(bc.CameraAnimator.StartToPlayer)
      self:ResetTrigger(bc.CameraAnimator.PlayerToMonster)
    else
      self:SetTrigger(bc.CameraAnimator.MonsterToPlayer)
      self:ResetTrigger(bc.CameraAnimator.PlayerToMonster)
    end
  else
    self:SetTrigger(bc.CameraAnimator.PlayerToMonster)
    self:ResetTrigger(bc.CameraAnimator.StartToPlayer)
  end
end

function BattleCameraComponent:CardGiveUp()
  if not self:IsPlayerBout() then
    return
  end
end

function BattleCameraComponent:UseCSShakePlugin()
  if not self.cameraShake then
    return
  end
  if not self.cameraShake:IsShaking() then
    self.cameraShake:Shake()
  end
end

function BattleCameraComponent:IsPlayingAttackShake()
  return self.isInAttackShake
end

function BattleCameraComponent:PlayAttackShakeDelay(delayTime)
  if self.isInAttackShake then
    return
  end
  self:LockAttackShake()
  self.isInAttackShake = true
  if delayTime > 0 then
    self.attackShakeTimer = TimerManager.Instance:CreateTimer(delayTime, 0, nil, function()
      self.attackShakeTimer = nil
      self:UseCSShakePlugin()
    end)
  else
    self:UseCSShakePlugin()
  end
end

function BattleCameraComponent:PlayCommonShakeDelay(delayTime)
  if delayTime > 0 then
    TimerManager.Instance:CreateTimer(delayTime, 0, nil, function()
      self:UseCSShakePlugin()
    end)
  else
    self:UseCSShakePlugin()
  end
end

function BattleCameraComponent:IsLockAttackShake()
  return self.lockToAttackShake
end

function BattleCameraComponent:LockAttackShake()
  self.lockToAttackShake = true
end

function BattleCameraComponent:UnLockAttackShake()
  self.lockToAttackShake = false
end

function BattleCameraComponent:IsPlayerBout()
  local boutMgr = bg.battleRender.boutMgr
  local camp = boutMgr:GetCamp()
  return camp == bc.BattleCamp.Camp1
end

function BattleCameraComponent:GetTriggerHash(triggerName)
  self.triggerHash[triggerName] = self.triggerHash[triggerName] or Animator.StringToHash(triggerName)
  return self.triggerHash[triggerName]
end

function BattleCameraComponent:SetTrigger()
end

function BattleCameraComponent:ResetTrigger()
end

return BattleCameraComponent
