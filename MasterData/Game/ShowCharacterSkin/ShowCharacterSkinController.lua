local ShowCharacterSkinController = class("ShowCharacterSkinController", ControllerBase)
local base = ControllerBase
local ShowCharacterSkinSceneCtrl = require("Game.ShowCharacterSkin.Ctrl.ShowCharacterSkinSceneCtrl")
local util = require("XLua.Common.xlua_util")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ShowCharacterUtil = require("Game.ShowCharacter.ShowCharacterUtil")
local CS_ResLoader = CS.ResLoader
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Physics = CS.PhysicsUtility
local CS_GameObject = CS.UnityEngine.GameObject
local CS_Animator = CS.UnityEngine.Animator
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
xlua.private_accessible(CS.CameraController)

function ShowCharacterSkinController:ctor()
  self.ctrls = {}
  self.winLoopTimerIdList = {}
  self.sceneCtrl = ShowCharacterSkinSceneCtrl.New(self)
  self.__camMain = UIManager:GetMainCamera()
  self.__lightMain = CS_GameObject.FindWithTag(TagConsts.MainLight)
  self.onFingerTap = BindCallback(self, self.__onFingerTap)
  self.OnGesture = BindCallback(self, self.__onGesture)
end

function ShowCharacterSkinController:OnInit()
  self.resloader = CS_ResLoader.Create()
end

function ShowCharacterSkinController:InitShowCharacterSkinCtrl(heroId, skinId, enterFunc, exitFunc)
  self:__InitHeroData(heroId, skinId)
  self.__initSceneCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.LoadScene)))
  self.enterFunc = enterFunc
  self.exitFunc = exitFunc
end

function ShowCharacterSkinController:__InitHeroData(heroId, skinId)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(heroId, skinId)
  self.modelPath = PathConsts:GetCharacterModelPathEx(resCfg.src_id_model)
  self.resName = resCfg.src_id_model
  local origresCfg = skinCtr:GetResModel(heroId)
  self.originName = origresCfg.src_id_model
  self.heroId = heroId
  self.skinId = skinId
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

function ShowCharacterSkinController:LoadScene()
  UIUtil.AddOneCover("showCharacter", SafePack(nil, nil, nil, Color.clear, false))
  local path = PathConsts:GetShowCharacterSkinPrefabPath("ShowCharacterScene")
  local sceneWait = self.resloader:LoadABAssetAsyncAwait(path)
  coroutine.yield(sceneWait)
  local scenePrefab = sceneWait.Result
  if scenePrefab ~= nil then
    self.sceneObj = scenePrefab:Instantiate()
    self.bind = {}
    UIUtil.LuaUIBindingTable(self.sceneObj, self.bind)
  end
  local currentScene = LuaSceneManager:GetCurrentScene()
  local sceneName
  if currentScene ~= nil then
    sceneName = currentScene.name
  end
  if sceneName == Consts.SceneName.Main then
    local skyGameObject = CS.UnityEngine.GameObject.Find("WeatherSystem")
    skyGameObject:SetActive(false)
    local beforeExitFunc = self.exitFunc
    
    function self.exitFunc()
      skyGameObject:SetActive(true)
      if beforeExitFunc ~= nil then
        beforeExitFunc()
      end
    end
  end
  self:EnableMainCamAndLight(false)
  if self.enterFunc ~= nil then
    self.enterFunc()
    self.enterFunc = nil
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ShowCharacterSkin, function(window)
    local hideWinList = UIManager:HideAllWindow({
      [UIWindowTypeID.TopStatus] = true,
      [UIWindowTypeID.ShowCharacterSkin] = true
    })
    local jumpCorverArgs = {hideWinList = hideWinList}
    window:SetFromWhichUI(eBaseWinFromWhere.jumpCorver)
    window.jumpCorverArgs = jumpCorverArgs
    window:InitShowCharacterSkin(self)
    self.__UIWindow = window
    UIUtil.CloseOneCover("showCharacter")
  end)
  self.__initCharacterCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.LoadCharacter)))
end

function ShowCharacterSkinController:LoadCharacter()
  local showCharacterWait = self.resloader:LoadABAssetAsyncAwait(self.modelPath)
  coroutine.yield(showCharacterWait)
  local showCharacterPrefab = showCharacterWait.Result
  if showCharacterPrefab ~= nil then
    self.characterObj = showCharacterPrefab:Instantiate()
    local characterTrans = self.bind.characterPos.transform
    self.characterObj.transform:SetParent(characterTrans)
    self.characterObj.transform:SetPositionAndRotation(characterTrans.position, characterTrans.rotation)
    self.characterAnimator = self.characterObj:GetComponent(typeof(CS_Animator))
  end
  self:OnLoadCompeleted()
end

function ShowCharacterSkinController:OnLoadCompeleted()
  self.cameraController = self.bind.cameraController
  if self.cameraController ~= nil then
    self.cameraController:SetControlState(ExplorationEnum.eEpCamControlState.Battle)
    self.__trackedDolly = self.cameraController.trackedDolly
  end
  CS_LeanTouch.OnFingerTap("+", self.onFingerTap)
  CS_LeanTouch.OnGesture("+", self.OnGesture)
  self:PlayAnimationByIndex(1)
end

function ShowCharacterSkinController:__onFingerTap()
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

function ShowCharacterSkinController:GetAnimationIdList()
  return self.AnimationIdList
end

function ShowCharacterSkinController:PlayAnimation(isCrossfade)
  self:__StopwinLoopTimer()
  local hitPos
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

function ShowCharacterSkinController:PlayAnimationByIndex(index)
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

function ShowCharacterSkinController:PlayAnimationEnd(animationInfo, index)
  local battleWinClipLength = 0
  local deployClipLength = 0
  local animator = self.characterObj:GetComponent(typeof(CS_Animator))
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
  if animationInfo.isDeploy then
    self.autoAnimation = true
    self.deployTimerId = TimerManager:StartTimer(deployClipLength + 1, function()
      if self.autoAnimation then
        self:PlayAnimation(true)
      end
    end, self, true, false, false)
  end
  for _, effectId in ipairs(animationInfo.effectIdList) do
    local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(effectId, self.characterObj, self.resName, self.originName)
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

function ShowCharacterSkinController:__StopwinLoopTimer()
  if self.winLoopTimerIdList ~= nil then
    for i = 1, #self.winLoopTimerIdList do
      TimerManager:StopTimer(self.winLoopTimerIdList[i])
    end
  end
  self.winLoopTimerIdList = {}
end

function ShowCharacterSkinController:__onGesture(fingerList)
  ShowCharacterUtil.DoGestureFunc(self.__trackedDolly, fingerList)
end

function ShowCharacterSkinController:__GetNextAnimationInfo()
  if self.next == nil then
    self.next = 0
  end
  if self.next >= #self.AnimationIdList then
    self.next = 0
  end
  self.next = self.next + 1
  return self.AnimationIdList[self.next], self.next
end

function ShowCharacterSkinController:EnableMainCamAndLight(enable)
  if not IsNull(self.__camMain) then
    self.__camMain.gameObject:SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    self.__lightMain:SetActive(enable)
  end
end

function ShowCharacterSkinController:ExitShowCharacter()
  self:EnableMainCamAndLight(true)
  self:Delete()
end

function ShowCharacterSkinController:OnDelete()
  CS_LeanTouch.OnFingerTap("-", self.onFingerTap)
  CS_LeanTouch.OnGesture("-", self.OnGesture)
  if self.deployTimerId ~= nil then
    TimerManager:StopTimer(self.deployTimerId)
    self.deployTimerId = nil
  end
  if self.__initSceneCoroutine ~= nil then
    GR.StopCoroutine(self.__initSceneCoroutine)
  end
  if self.__initCharacterCoroutine ~= nil then
    GR.StopCoroutine(self.__initCharacterCoroutine)
  end
  UIManager:DeleteWindow(UIWindowTypeID.ShowCharacterSkin)
  if self.exitFunc ~= nil then
    self.exitFunc()
    self.exitFunc = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.heroId = nil
  self.skinId = nil
  self:__StopwinLoopTimer()
  CS_AnimationEffectController_Ins:DisposeAllEffects()
  DestroyUnityObject(self.sceneObj)
  DestroyUnityObject(self.characterObj)
  base.OnDelete(self)
end

return ShowCharacterSkinController
