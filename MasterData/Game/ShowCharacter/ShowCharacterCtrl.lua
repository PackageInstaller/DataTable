local ShowCharacterCtrl = class("ShowCharacterCtrl", ControllerBase)
local base = ControllerBase
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local ShowCharacterUtil = require("Game.ShowCharacter.ShowCharacterUtil")
local util = require("XLua.Common.xlua_util")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Physics = CS.PhysicsUtility
local CS_Animator = CS.UnityEngine.Animator
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance

function ShowCharacterCtrl:EnterShowCharacterScene(heroId, fromPoolId)
  UIManager:DeleteAllWindow()
  self.next = 0
  self.winLoopTimerIdList = {}
  self.fromPoolId = fromPoolId
  self.heroId = heroId
  if self.heroData == nil then
    self.heroData = HeroInfoData:New()
  end
  self.heroData:InitData(heroId)
  if self.characterLoader == nil then
    self.characterLoader = CS.ResLoader.Create()
  end
  
  local function preLoadFunc()
    local modelPath = PathConsts:GetCharacterModelPathEx(self.heroData.heroData:GetResModelName())
    local showCharacterWait = self.characterLoader:LoadABAssetAsyncAwait(modelPath)
    coroutine.yield(showCharacterWait)
    self.showCharacterPrefab = showCharacterWait.Result
    UIManager:ShowWindowAsync(UIWindowTypeID.ShowCharacterSkin)
    repeat
      coroutine.yield(nil)
      self.showCharacterWindow = UIManager:GetWindow(UIWindowTypeID.ShowCharacterSkin)
    until self.showCharacterWindow
    self.showCharacterWindow:InitShowCharacterSkin(self)
  end
  
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.ShowCharacter, function(ok)
    self:OnLoadCompeleted()
  end, util.cs_generator(preLoadFunc))
  if self.AnimationIdList == nil then
    local function commonStartFunc()
      self.characterAnimator:SetTrigger("BattleDie")
      
      self.characterAnimator:SetBool("DeployFloat", self.float)
      self.characterAnimator:SetBool("BattleRun", self.run)
      self.autoAnimation = false
    end
    
    local heroCfg = ConfigData.resource_model[self.heroId]
    self.AnimationIdList = {
      {
        animationName = CS_Animator.StringToHash("Deploy_Leap"),
        effectIdList = {},
        aniStartFunc = function()
          self.float = false
          self.run = false
          commonStartFunc()
        end,
        isPlay = true,
        tipId = 651,
        isDeploy = true
      },
      {
        animationName = CS_Animator.StringToHash("Deploy_Idle"),
        effectIdList = {},
        aniStartFunc = function()
          self.float = false
          self.run = false
          commonStartFunc()
        end,
        isPlay = true,
        tipId = 652
      },
      {
        animationName = CS_Animator.StringToHash("Battle_Win"),
        effectIdList = heroCfg.win_effect_id,
        aniStartFunc = function()
          self.float = false
          self.run = false
          commonStartFunc()
        end,
        isPlay = true,
        tipId = 653
      },
      {
        animationName = CS_Animator.StringToHash("Battle_Run"),
        effectIdList = {},
        aniStartFunc = function()
          self.float = false
          self.run = true
          commonStartFunc()
        end,
        isPlay = true,
        tipId = 654
      },
      {
        animationName = CS_Animator.StringToHash("Deploy_Float"),
        effectIdList = {},
        aniStartFunc = function()
          self.float = true
          self.run = false
          commonStartFunc()
        end,
        isPlay = true,
        tipId = 655
      }
    }
  end
end

function ShowCharacterCtrl:OnLoadCompeleted()
  if self.showCharacterPrefab ~= nil then
    self.characterGo = self.showCharacterPrefab:Instantiate()
    self.characterGo.transform.localEulerAngles = Vector3.New(0, 90, 0)
    self.characterAnimator = self.characterGo:GetComponent(typeof(CS_Animator))
  end
  self.cameraController = CS.CameraController.Instance
  if self.cameraController ~= nil then
    self.cameraController:SetControlState(ExplorationEnum.eEpCamControlState.Battle)
    self.__trackedDolly = self.cameraController.trackedDolly
  end
  self.onFingerTap = BindCallback(self, self.__onFingerTap)
  self.OnGesture = BindCallback(self, self.__onGesture)
  CS_LeanTouch.OnFingerTap("+", self.onFingerTap)
  CS_LeanTouch.OnGesture("+", self.OnGesture)
  self:PlayAnimationByIndex(1)
end

function ShowCharacterCtrl:__onFingerTap()
  if self.cameraController == nil then
    return
  end
  local mainCamera = self.cameraController.MainCamera
  if IsNull(mainCamera) then
    return
  end
  local hits = CS_Physics.Raycast(mainCamera, 1 << LayerMask.Character)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      CS_AnimationEffectController_Ins:KillAllEffects()
      CS_AnimationEffectController_Ins:RecycleEffects()
      self:PlayAnimation()
    end
  end
end

function ShowCharacterCtrl:GetAnimationIdList()
  return self.AnimationIdList
end

function ShowCharacterCtrl:PlayAnimation(isCrossfade)
  self:__StopwinLoopTimer()
  if self.characterAnimator ~= nil then
    local animationInfo, index = self:__GetNextAnimationInfo()
    if animationInfo.isPlay then
      if isCrossfade then
        self.characterAnimator:CrossFade(animationInfo.animationName, 0.1)
      else
        self.characterAnimator:Play(animationInfo.animationName)
      end
    else
      self:PlayAnimation()
      return
    end
    animationInfo.aniStartFunc()
    self:PlayAnimationEnd(animationInfo, index)
  end
end

function ShowCharacterCtrl:PlayAnimationByIndex(index)
  self:__StopwinLoopTimer()
  CS_AnimationEffectController_Ins:KillAllEffects()
  CS_AnimationEffectController_Ins:RecycleEffects()
  local hitPos
  if self.characterAnimator ~= nil then
    local animationInfo = self.AnimationIdList[index]
    self.next = index
    self.characterAnimator:Play(animationInfo.animationName)
    animationInfo.aniStartFunc()
    self:PlayAnimationEnd(animationInfo, index)
  end
end

function ShowCharacterCtrl:PlayAnimationEnd(animationInfo, index)
  local battleWinClipLength = 0
  local deployClipLength = 0
  local animator = self.characterGo:GetComponent(typeof(CS_Animator))
  for i = 0, animator.runtimeAnimatorController.animationClips.Length - 1 do
    local animationClip = animator.runtimeAnimatorController.animationClips[i]
    if animationClip.name == "battle_win" then
      battleWinClipLength = animationClip.length
    elseif animationClip.name == "deploy_leap" then
      deployClipLength = animationClip.length
    end
  end
  if self.deployTimerId ~= nil then
    TimerManager:StopTimer(self.deployTimerId)
    self.deployTimerId = nil
  end
  local resName = self.heroData.resCfg.src_id_model
  if animationInfo.isDeploy then
    self.autoAnimation = true
    self.deployTimerId = TimerManager:StartTimer(deployClipLength + 1, function()
      if self.autoAnimation then
        self:PlayAnimation(true)
      end
    end, self, true, false, false)
  end
  for _, effectId in ipairs(animationInfo.effectIdList) do
    local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(effectId, self.characterGo, resName)
    effect.effectCfg.Layer = LayerMask.Character
    if string.find(effect.Code, "win_loop") == nil then
      effect:Play()
    else
      local winLoopTimerId = TimerManager:StartTimer(battleWinClipLength, effect.Play, effect, true, false, false)
      table.insert(self.winLoopTimerIdList, winLoopTimerId)
    end
  end
  local win = UIManager:GetWindow(UIWindowTypeID.ShowCharacterSkin)
  if win then
    win:SetTopText(index)
  end
end

function ShowCharacterCtrl:__StopwinLoopTimer()
  if self.winLoopTimerIdList ~= nil then
    for i = 1, #self.winLoopTimerIdList do
      TimerManager:StopTimer(self.winLoopTimerIdList[i])
    end
  end
  self.winLoopTimerIdList = {}
end

function ShowCharacterCtrl:__onGesture(fingerList)
  ShowCharacterUtil.DoGestureFunc(self.__trackedDolly, fingerList)
end

function ShowCharacterCtrl:ExitShowCharacter()
  UIManager:DeleteWindow(UIWindowTypeID.ShowCharacterSkin)
  JumpManager:Jump(JumpManager.eJumpTarget.DynLottery, function(jumpCallback)
    if jumpCallback ~= nil then
      jumpCallback()
    end
    self:Delete()
    CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(win)
        if win then
          win:SetFrom2Home(nil, false)
        end
      end)
    end)
  end, function()
    local win = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if win then
      win:SetFromWhichUI(eBaseWinFromWhere.home)
    end
  end, {
    self.fromPoolId
  })
end

function ShowCharacterCtrl:__GetNextAnimationInfo()
  if self.next == nil then
    self.next = 0
  end
  if self.next >= #self.AnimationIdList then
    self.next = 0
  end
  self.next = self.next + 1
  return self.AnimationIdList[self.next], self.next
end

function ShowCharacterCtrl:OnDelete()
  CS_LeanTouch.OnFingerTap("-", self.onFingerTap)
  CS_LeanTouch.OnGesture("-", self.OnGesture)
  if self.characterLoader ~= nil then
    self.characterLoader:Put2Pool()
    self.characterLoader = nil
  end
  if self.deployTimerId ~= nil then
    TimerManager:StopTimer(self.deployTimerId)
    self.deployTimerId = nil
  end
  self.cameraController = nil
  self.showCharacterPrefab = nil
  self.characterGo = nil
  self.characterAnimator = nil
  self:__StopwinLoopTimer()
  CS_AnimationEffectController_Ins:DisposeAllEffects()
  base.OnDelete(self)
end

return ShowCharacterCtrl
