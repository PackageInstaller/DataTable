local base = require("Game.Fairy.SubSystemCtrl.FairyCtrlBase")
local FairyCultivateShowCtrl = class("FairyCultivateShowCtrl", base)
local CS_ResLoader = CS.ResLoader
local CS_GameObject = CS.UnityEngine.GameObject
local CS_Animator = CS.UnityEngine.Animator
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
local CS_Physics = CS.PhysicsUtility
local util = require("XLua.Common.xlua_util")
local normalStateAniName = "Idle"
local crossFadeTime = 0.25

function FairyCultivateShowCtrl:ctor(fairyCtrl)
  base.ctor(self, fairyCtrl)
end

function FairyCultivateShowCtrl:InitFairyCultivateShowCtrl(enterFunc, exitFunc, defaultUid)
  self.enterFunc = enterFunc
  self.exitFunc = exitFunc
  self.__camMain = UIManager:GetMainCamera()
  self.__lightMain = CS_GameObject.FindWithTag(TagConsts.MainLight)
  self.resloader = CS_ResLoader.Create()
  self.__initSceneCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.LoadShowScene, defaultUid)))
  self._LoadFairyModelFunc = BindCallback(self, self.LoadFairyModel)
  self.onFingerTap = BindCallback(self, self.__onFingerTap)
  MsgCenter:AddListener(eMsgEventId.OnShowFairyChange, self._LoadFairyModelFunc)
  self.__PlayFairyLevelUpAnimation = BindCallback(self, self.PlayFairyLevelUpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowFairyLevelUp, self.__PlayFairyLevelUpAnimation)
  self.__PlayFairyNormalLevelUpEffect = BindCallback(self, self.PlayFairyNormalLevelUpEffect)
  MsgCenter:AddListener(eMsgEventId.OnShowFairyNormalLevelUp, self.__PlayFairyNormalLevelUpEffect)
end

function FairyCultivateShowCtrl:LoadShowScene(defaultUid)
  local path = PathConsts:GetShowFairyPrefabPath("ShowFairyScene")
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
  CS_LeanTouch.OnFingerTap("+", self.onFingerTap)
end

function FairyCultivateShowCtrl:LoadFairyModel(fairyData)
  if not IsNull(self.fairyObj) then
    DestroyUnityObject(self.fairyObj)
    self.fairyObj = nil
    self.fairyAnimator = nil
  end
  if fairyData == nil then
    return
  end
  self.modelPath = fairyData:GetFairyPrefabResStr()
  if self.__loadFairyCoroutine ~= nil then
    GR.StopCoroutine(self.__loadFairyCoroutine)
  end
  self.__loadFairyCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.LoadFairyModelCo)))
end

function FairyCultivateShowCtrl:LoadFairyModelCo()
  local showFairyWait = self.resloader:LoadABAssetAsyncAwait(self.modelPath)
  coroutine.yield(showFairyWait)
  local showFairyPrefab = showFairyWait.Result
  if showFairyPrefab ~= nil then
    while self.bind == nil do
      coroutine.yield()
    end
    self.fairyObj = showFairyPrefab:Instantiate()
    local characterTrans = self.bind.characterPos.transform
    self.fairyObj.transform:SetParent(characterTrans)
    self.fairyObj.transform:SetPositionAndRotation(characterTrans.position, characterTrans.rotation)
    self.fairyAnimator = self.fairyObj:GetComponent(typeof(CS_Animator))
  end
  if not string.IsNullOrEmpty(self.__playAnimationName) then
    self:PlayFairyAnimation(self.__playAnimationName)
  end
end

function FairyCultivateShowCtrl:__onFingerTap()
  if IsNull(self.fairyObj) then
    return
  end
  local mainCamera = UIManager:GetMainCamera()
  if IsNull(mainCamera) then
    return
  end
  local hits = CS_Physics.Raycast(mainCamera, 1 << LayerMask.Character)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      CS_AnimationEffectController_Ins:KillAllEffects()
      CS_AnimationEffectController_Ins:RecycleEffects()
      self:PlayNormalAnimation()
    end
  end
end

function FairyCultivateShowCtrl:PlayNormalAnimation()
  local isPlaying = self.fairyAnimator:GetCurrentAnimatorStateInfo(0):IsName(normalStateAniName) or self.fairyAnimator:IsInTransition(0)
  if not isPlaying then
    self:PlayFairyAnimation(normalStateAniName, true)
  end
end

function FairyCultivateShowCtrl:PlayFairyLevelUpAnimation()
  if not self.fairyAnimator then
    self.__playAnimationName = "LevelUp"
    return
  end
  self:PlayFairyAnimation("LevelUp")
end

function FairyCultivateShowCtrl:PlayFairyNormalLevelUpEffect()
  if self.bind and self.bind.fXP_QuickLevelUp_sj.activeSelf == false then
    self.bind.fXP_QuickLevelUp_sj:SetActive(true)
  end
end

function FairyCultivateShowCtrl:PlayFairyAnimation(aniName, isCrossFade)
  if self.fairyAnimator then
    if not isCrossFade then
      self.fairyAnimator:Play(aniName)
    else
      self.fairyAnimator:CrossFade(aniName, crossFadeTime)
    end
    self.__playAnimationName = nil
  end
end

function FairyCultivateShowCtrl:EnableMainCamAndLight(enable)
  if not IsNull(self.__camMain) then
    self.__camMain.gameObject:SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    self.__lightMain:SetActive(enable)
  end
end

function FairyCultivateShowCtrl:ExitFairyCultivateShow()
  self:EnableMainCamAndLight(true)
  self:Delete()
end

function FairyCultivateShowCtrl:Delete()
  if self.exitFunc ~= nil then
    self.exitFunc()
    self.exitFunc = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.bind = nil
  if self.onFingerTap then
    CS_LeanTouch.OnFingerTap("-", self.onFingerTap)
    self.onFingerTap = nil
  end
  if self._LoadFairyModelFunc ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnShowFairyChange, self._LoadFairyModelFunc)
  end
  if self.__PlayFairyLevelUpAnimation ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnShowFairyLevelUp, self.__PlayFairyLevelUpAnimation)
  end
  if self.__PlayFairyNormalLevelUpEffect then
    MsgCenter:RemoveListener(eMsgEventId.OnShowFairyNormalLevelUp, self.__PlayFairyNormalLevelUpEffect)
    self.__PlayFairyNormalLevelUpEffect = nil
  end
  if self.__loadFairyCoroutine ~= nil then
    GR.StopCoroutine(self.__loadFairyCoroutine)
  end
  if self.__initSceneCoroutine ~= nil then
    GR.StopCoroutine(self.__initSceneCoroutine)
  end
  CS_AnimationEffectController_Ins:DisposeAllEffects()
  DestroyUnityObject(self.sceneObj)
  self.sceneObj = nil
  DestroyUnityObject(self.fairyObj)
  self.fairyObj = nil
  base.Delete(self)
end

return FairyCultivateShowCtrl
