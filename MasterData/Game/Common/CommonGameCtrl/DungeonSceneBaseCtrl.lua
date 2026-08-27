local DungeonSceneBaseCtrl = class("DungeonSceneBaseCtrl")
local util = require("XLua.Common.xlua_util")
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
local ExclusiveWeaponEffectUtil = require("Game.ExclusiveWeaponEffect.ExclusiveWeaponEffectUtil")
local cs_ResLoader = CS.ResLoader
local cs_BattlePosData = CS.BattlePosData
local CS_CameraController = CS.CameraController

function DungeonSceneBaseCtrl:ctor()
  self.heroResLoaderDic = {}
  self.fairyResLoader = nil
  self.fairyResStr = nil
  self.fairyGo = nil
  self.fairyAnimator = nil
  self.__inRoleChanging = false
  self.__OnEpFouceBattleBossStart = BindCallback(self, self.OnEpStartFouceBattleBoss, true)
  MsgCenter:AddListener(eMsgEventId.OnStartFocusBossTimeLine, self.__OnEpFouceBattleBossStart)
  self.__OnEpFouceBattleBossEnd = BindCallback(self, self.OnEpStartFouceBattleBoss, false)
  MsgCenter:AddListener(eMsgEventId.OnEndFocusBossTimeLine, self.__OnEpFouceBattleBossEnd)
end

function DungeonSceneBaseCtrl:SaveReuseHeroResloader(heroResDic)
  self.__reuseHeroResDic = heroResDic
end

function DungeonSceneBaseCtrl:__PreLoadCharacterAndSkill(dynPlayer, heroPrefabs, heroObjectDic, noshow)
  local waitList = {}
  local perfectModelLevel = -1
  if BattleUtil.IsInTDBattle() then
    perfectModelLevel = ConfigData.buildinConfig.TowerModelLevel
  end
  for heroId, dynHero in pairs(dynPlayer.heroDic) do
    if dynHero ~= nil then
      local modelPath = PathConsts:GetCharacterModelPathEx(dynHero:GetResModelName(), dynHero.modelSpecSign, perfectModelLevel)
      local resloader = self.heroResLoaderDic[heroId]
      if resloader == nil then
        resloader = cs_ResLoader.Create()
        self.heroResLoaderDic[heroId] = resloader
      end
      local wait = resloader:LoadABAssetAsyncAwait(modelPath)
      waitList[heroId] = wait
    end
  end
  for heroId, wait in pairs(waitList) do
    coroutine.yield(wait)
    heroPrefabs[heroId] = wait.Result
  end
  if self.__reuseHeroResDic ~= nil then
    for heroId, resloader in pairs(self.__reuseHeroResDic) do
      resloader:Put2Pool()
    end
    self.__reuseHeroResDic = nil
  end
  self.heroModelHolder = CS.UnityEngine.GameObject("HeroModelHolder").transform
  local size_row, size_col, delopyRow, gridScaleFactor = self:GetBattleFieldSizeBySceneId()
  local battlePos = CS.BattlePosData(size_row, size_col, ConfigData.game_config.battleMap_bench_count, gridScaleFactor)
  for heroId, heroPrefab in pairs(heroPrefabs) do
    local heroGo = heroPrefab:Instantiate(self.heroModelHolder)
    local dynHero = dynPlayer.heroDic[heroId]
    local logicPos
    if dynHero.onBench then
      logicPos = battlePos.benchLogicPosMap[dynHero.y]:ToVector3()
    else
      logicPos = battlePos.boardLogicPosMap:GetValue(dynHero.x, dynHero.y):ToVector3()
    end
    heroGo.transform.position = logicPos
    self.heroObjectDic[dynHero.dataId] = heroGo
    if noshow then
      heroGo:SetActive(false)
    end
    coroutine.yield()
    ExclusiveWeaponEffectUtil:PlayEWEffectByHeroData(dynHero.heroData, heroGo, ExclusiveWeaponEffectUtil.EEwEffectType.Battle)
  end
  for heroId, dynHero in pairs(dynPlayer.heroDic) do
    local originSkillList = dynHero:GetOriginSkillList()
    for _, skill in pairs(originSkillList) do
      skill:PreloadSkill(self.effectPoolCtrl, dynHero)
    end
    coroutine.yield()
  end
  self.fairyHolder = CS.UnityEngine.GameObject("FairyHolder").transform
  local dynFairyData = dynPlayer:GetDynFairyData()
  self:LoadFairyGo(dynFairyData)
end

function DungeonSceneBaseCtrl:__InitDungeonSceneEffect()
  self.effectPoolCtrl = CS.EffectPoolController()
  self.effectPoolCtrl:OnInit()
  local resloader = self.effectPoolCtrl.resloader
  local leapBackEffectPath = "FX/Common/FX_Transition/FXP_Transition_Back" .. PathConsts.PrefabExtension
  local effectWaitBack = resloader:LoadABAssetAsyncAwait(leapBackEffectPath)
  local leapEffectPath = "FX/Common/FX_Transition/FXP_Transition" .. PathConsts.PrefabExtension
  local effectWait = resloader:LoadABAssetAsyncAwait(leapEffectPath)
  local lightWait = resloader:LoadABAssetAsyncAwait("FX/Common/FX_Lightpoles/FXP_Lightpoles" .. PathConsts.PrefabExtension)
  coroutine.yield(effectWaitBack)
  local roleDisappearEffectPrefab = effectWaitBack.Result
  self.__roleDisappearEffectCode = roleDisappearEffectPrefab.name
  self.effectPoolCtrl:AddCommonPrefab(roleDisappearEffectPrefab)
  coroutine.yield(effectWait)
  local roleAppearEffectPrefab = effectWait.Result
  self.__roleAppearEffectCode = roleAppearEffectPrefab.name
  self.effectPoolCtrl:AddCommonPrefab(roleAppearEffectPrefab)
  coroutine.yield(lightWait)
  if BattleUtil.IsInTDBattle() then
    CS.BattleConsts.DeployPlayerGrid = "FX/Common/FX_UI/FXP_pickHexagonPlayer/FXUI_pickHexagonPlayer_tower"
  else
    CS.BattleConsts.DeployPlayerGrid = ConfigData.game_config.deployPlayerGridSrc
  end
end

function DungeonSceneBaseCtrl:__InitDungeonCameraEffect(resloader)
  if not ExplorationManager:IsInExploration() then
    return
  end
  local floorId = ExplorationManager.floorId
  if floorId == nil then
    return
  end
  local explorationConfig = ConfigData.exploration[floorId]
  if explorationConfig == nil then
    error("explorationConfig is nil !! check ExplorationManager.floorId" .. tostring(ExplorationManager.floorId))
    return
  end
  local sceen_camera_effect_id = explorationConfig.sceen_camera_effect_id
  if sceen_camera_effect_id == 0 then
    return
  end
  if explorationConfig.effective_range ~= 1 then
    return
  end
  if CameraEffectUtil.CameraEffectFunction[sceen_camera_effect_id] == nil then
    return
  end
  self.sceen_camera_effect_id = sceen_camera_effect_id
  CameraEffectUtil.CameraEffectFunction[sceen_camera_effect_id]()
end

function DungeonSceneBaseCtrl:GetRoleAppearEffect()
  return self.effectPoolCtrl:GetCommonEffect(self.__roleAppearEffectCode)
end

function DungeonSceneBaseCtrl:GetRoleDisappearEffect()
  return self.effectPoolCtrl:GetCommonEffect(self.__roleDisappearEffectCode)
end

function DungeonSceneBaseCtrl:GetDungeonCrazyTime()
end

function DungeonSceneBaseCtrl:GetBattleFieldSizeBySceneId()
end

function DungeonSceneBaseCtrl:CheckAndOpenSepcialMode(sceneCfg)
  if sceneCfg.depth_support then
    local mainCam = CS_CameraController.Instance.MainCamera
    if not IsNull(mainCam) then
      mainCam.depthTextureMode = CS.UnityEngine.DepthTextureMode.Depth
    end
  end
end

function DungeonSceneBaseCtrl:SwithCameraCtrlState(cameraState)
  CS_CameraController.Instance:SetControlState(cameraState)
end

function DungeonSceneBaseCtrl:SceneResetBattleCamera()
  CS_CameraController.Instance:BattleCameraReset()
end

function DungeonSceneBaseCtrl:SetEpMapCameraCullMask(LayerMaskEnum)
  local epMapCamera = CS_CameraController.Instance.EpMapCamera
  if epMapCamera then
    epMapCamera.cullingMask = 1 << LayerMaskEnum
  end
end

function DungeonSceneBaseCtrl:EnterBattleDeployFormation(callBack)
  if IsNull(self.bind.tl_BtDeployFormation) then
    error("tl_BtDeployFormation is nil")
    return
  end
  self._enterFmtCallBack = callBack
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(self.__onSkipTimeline, false, nil, Color.clear, false)
  self.bind.vcam_BattleDeployFormation.enabled = true
  self._OnEnterFmtFunc = self._OnEnterFmtFunc or BindCallback(self, self._OnEnd_EnterBattleDeployFormation)
  return TimelineUtil.Play(self.bind.tl_BtDeployFormation, self._OnEnterFmtFunc)
end

function DungeonSceneBaseCtrl:_OnEnd_EnterBattleDeployFormation()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  if self._enterFmtCallBack ~= nil then
    self._enterFmtCallBack()
  end
end

function DungeonSceneBaseCtrl:ExitBattleDeployFormation(callBack)
  if IsNull(self.bind.tl_BtDeployFormation) then
    error("tl_BtDeployFormation is nil")
    return
  end
  self._exitFmtCallBack = callBack
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(self.__onSkipTimeline, false, nil, Color.clear, false)
  self.bind.vcam_BattleDeployFormation.enabled = false
  self._OnExitFmtFunc = self._OnExitFmtFunc or BindCallback(self, self._OnEnd_ExitBattleDeployFormation)
  return TimelineUtil.Rewind(self.bind.tl_BtDeployFormation, self._OnExitFmtFunc)
end

function DungeonSceneBaseCtrl:_OnEnd_ExitBattleDeployFormation()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  if self._exitFmtCallBack ~= nil then
    self._exitFmtCallBack()
  end
end

function DungeonSceneBaseCtrl:IsRoleChangingState()
  return self.__inRoleChanging
end

function DungeonSceneBaseCtrl:ChangeEpHeroModel(srcDynHeroList, tarDynHeroList, onFinish, immediateDeleteOldHero)
  if self.__inRoleChanging then
    error("当前已经在助战更换角色中...")
    return
  end
  self.__inRoleChanging = true
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  for k, dynHero in ipairs(srcDynHeroList) do
    local srcHeroId = dynHero.dataId
    local srcResLoader = self.heroResLoaderDic[srcHeroId]
    if srcResLoader ~= nil then
      local srcObj = self.heroObjectDic[srcHeroId]
      if immediateDeleteOldHero then
        DestroyUnityObject(srcObj)
        srcResLoader:Put2Pool()
      else
        self._waitDeleteHero = self._waitDeleteHero or {
          resloaderList = {},
          gameObjectList = {}
        }
        table.insert(self._waitDeleteHero.gameObjectList, srcObj)
        table.insert(self._waitDeleteHero.resloaderList, srcResLoader)
      end
      self.heroObjectDic[srcHeroId] = nil
      self.heroPrefabs[srcHeroId] = nil
      self.heroResLoaderDic[srcHeroId] = nil
    end
  end
  
  local function loadFunc()
    local size_row, size_col, delopyRow, gridScalFactor = BattleUtil.GetCurSceneBattleFieldSize()
    local battlePos = cs_BattlePosData(size_row, size_col, ConfigData.game_config.battleMap_bench_count, gridScalFactor)
    local waitList = {}
    for k, dynHero in ipairs(tarDynHeroList) do
      local heroId = dynHero.dataId
      local modelPath = PathConsts:GetCharacterModelPathEx(dynHero:GetResModelName(), dynHero.modelSpecSign)
      local resLoader = cs_ResLoader.Create()
      self.heroResLoaderDic[heroId] = resLoader
      local wait = resLoader:LoadABAssetAsyncAwait(modelPath)
      waitList[k] = wait
    end
    for k, dynHero in ipairs(tarDynHeroList) do
      local heroId = dynHero.dataId
      local wait = waitList[k]
      coroutine.yield(wait)
      local heroPrefab = wait.Result
      self.heroPrefabs[heroId] = heroPrefab
      local heroGo = heroPrefab:Instantiate(self.heroModelHolder)
      local logicPos
      if dynHero.onBench then
        logicPos = battlePos.benchLogicPosMap[dynHero.y]:ToVector3()
      else
        logicPos = battlePos.boardLogicPosMap:GetValue(dynHero.x, dynHero.y):ToVector3()
      end
      heroGo.transform.position = logicPos
      self.heroObjectDic[dynHero.dataId] = heroGo
      coroutine.yield(nil)
    end
    self.__inRoleChanging = false
    self.__changeEpHeroModelCo = nil
    onFinish()
  end
  
  self:_ClearChangeEpHeroModelCo()
  self.__changeEpHeroModelCo = GR.StartCoroutine(util.cs_generator(loadFunc))
end

function DungeonSceneBaseCtrl:DeleteChangeEpHeroOldModel()
  if self._waitDeleteHero == nil then
    return
  end
  while #self._waitDeleteHero.resloaderList > 0 do
    local resloader = table.remove(self._waitDeleteHero.resloaderList)
    resloader:Put2Pool()
  end
  while 0 < #self._waitDeleteHero.gameObjectList do
    local go = table.remove(self._waitDeleteHero.gameObjectList)
    DestroyUnityObject(go)
  end
end

function DungeonSceneBaseCtrl:_ClearChangeEpHeroModelCo()
  if self.__changeEpHeroModelCo ~= nil then
    GR.StopCoroutine(self.__changeEpHeroModelCo)
    self.__changeEpHeroModelCo = nil
  end
end

function DungeonSceneBaseCtrl:ChangeFiary(dynPlayer)
  local dynFairyData = dynPlayer:GetDynFairyData()
  self:LoadFairyGo(dynFairyData, true)
  if dynFairyData ~= nil then
    self:TryPlayFairyEnterAni(true)
  end
end

function DungeonSceneBaseCtrl:OnEpStartFouceBattleBoss(isHide)
  if not isHide then
    self.__bossCulling = false
    if self.__alreadyHiddenRole ~= nil then
      for role, _ in pairs(self.__alreadyHiddenRole) do
        role.lsObject.transform.localScale = Vector3.one
      end
    end
    if self.__bossCullCoroutine ~= nil then
      GR.StopCoroutine(self.__bossCullCoroutine)
      self.__bossCullCoroutine = nil
    end
    return
  end
  self.__alreadyHiddenRole = {}
  self.__bossCulling = true
  
  local function continueCulling(cameraInstance, curBattleController)
    if cameraInstance == nil or cameraInstance.GeneralCullingFocusPos == Vector3.down then
      if isGameDev then
        error("没有设置具体聚焦的单位，但是执行了TimeLine的剔除事件")
      end
      return
    end
    while self.__bossCulling do
      local battleCtrl = curBattleController
      local camDir = cameraInstance.GeneralCullingFocusPos - cameraInstance.transform.position
      local radius = Vector3.SqrMagnitude(camDir) + cameraInstance.cullingRangeOffset
      if battleCtrl ~= nil then
        self:DetectedHideRoleList(cameraInstance, cameraInstance.transform.position, camDir, radius, battleCtrl.EnemyTeamController.battleOriginRoleList)
        self:DetectedHideRoleList(cameraInstance, cameraInstance.transform.position, camDir, radius, battleCtrl.NeutralTeamController.dungeonRoleList)
        self:DetectedHideRoleList(cameraInstance, cameraInstance.transform.position, camDir, radius, battleCtrl.PlayerTeamController.battleOriginRoleList)
        self:DetectedHideRoleList(cameraInstance, cameraInstance.transform.position, camDir, radius, battleCtrl.PlayerTeamController.dungeonRoleList)
      end
      coroutine.yield(nil)
    end
  end
  
  self.__bossCullCoroutine = GR.StartCoroutine(util.cs_generator(continueCulling, CS_CameraController.Instance, CS.BattleManager.Instance.CurBattleController))
end

function DungeonSceneBaseCtrl:DetectedHideRoleList(cameraInstance, camPos, camDir, powRadius, roles)
  if cameraInstance == nil or cameraInstance.GeneralCullingFocusPos == Vector3.down then
    return
  end
  for i = 0, roles.Count - 1 do
    local role = roles[i]
    if not self.__alreadyHiddenRole[role] and role.lsObject ~= nil and not role.isDead then
      local roleTrans = role.lsObject.transform
      if not IsNull(roleTrans) and roleTrans.localPosition ~= cameraInstance.GeneralCullingFocusPos then
        local tempDir = roleTrans.localPosition - camPos
        local angle = Vector3.Angle(camDir, tempDir)
        if angle <= 90 then
          local dist = Vector3.SqrMagnitude(tempDir)
          if powRadius >= dist then
            roleTrans.localScale = Vector3.zero
            self.__alreadyHiddenRole[role] = true
          end
        end
      end
    end
  end
end

function DungeonSceneBaseCtrl:LoadFairyGo(dynFairyData, isSync)
  if dynFairyData == nil then
    if not IsNull(IsNull) then
      DestroyUnityObject(self.fairyGo)
      self.fairyGo = nil
      self.fairyAnimator = nil
      self.fairyPerformAudioId = nil
    end
    return
  end
  self.fairyPerformAudioId = dynFairyData:GetFairyPerformAudioId()
  local fairyResStr = dynFairyData:GetFairyPrefabResStr()
  if self.fairyResStr ~= fairyResStr then
    self.fairyResStr = fairyResStr
    if self.fairyResLoader ~= nil then
      self.fairyResLoader:Put2Pool()
    end
    self.fairyResLoader = cs_ResLoader.Create()
  end
  if self.fairyResLoader == nil then
    self.fairyResLoader = cs_ResLoader.Create()
  end
  if not IsNull(self.fairyGo) then
    DestroyUnityObject(self.fairyGo)
  end
  if string.IsNullOrEmpty(self.fairyResStr) then
    return
  end
  local prefab
  if isSync then
    prefab = self.fairyResLoader:LoadABAsset(self.fairyResStr)
  else
    local wait = self.fairyResLoader:LoadABAssetAsyncAwait(self.fairyResStr)
    coroutine.yield(wait)
    prefab = wait.Result
  end
  if prefab == nil then
    warn("can't get fairy model!")
    return
  end
  self.fairyGo = prefab:Instantiate(self.fairyHolder)
  self.fairyGo:SetActive(false)
  self.fairyAnimator = self.fairyGo:FindComponent(eUnityComponentID.Animator)
end

function DungeonSceneBaseCtrl:TryPlayFairyEnterAni(skipStep1)
  if IsNull(self.fairyAnimator) then
    return
  end
  self.fairyGo:SetActive(true)
  local performLength = 0
  local drop2SceneLength = 1
  for i = 0, self.fairyAnimator.runtimeAnimatorController.animationClips.Length - 1 do
    local animationClip = self.fairyAnimator.runtimeAnimatorController.animationClips[i]
    if animationClip.name == "battle_perform" then
      performLength = animationClip.length
    elseif animationClip.name == "battle_leap" then
      drop2SceneLength = animationClip.length
    end
  end
  
  local function PlayLeap()
    self.fairyAnimator:Play("Battle_leap")
    self.fairyGo.transform.localRotation = Quaternion.LookRotation(Vector3.right, Vector3.up)
    self.fairyGo.transform.position = self:GetFairyFinalStayPlace()
  end
  
  if not skipStep1 and CommonUtil.IsOpenFairyBattlePerform() then
    local mainCam = CS_CameraController.Instance.MainCamera
    local offset = Vector3.New(3.6, 4.76, 0.1)
    local fov = mainCam.fieldOfView
    local fairyScreenRate = 0.5
    local fairyHeight = 0.6
    local y = fairyHeight / 2 / fairyScreenRate
    local x = y / math.tan(math.rad(fov / 2))
    local fairyPos = mainCam.transform.position + mainCam.transform.forward * x - offset
    self.fairyGo.transform:SetLayer(LayerMask.UI3D)
    self.fairyCloseHpTimerId = TimerManager:StartTimer(1, function()
      if 1 < performLength then
        TimerManager:AddLateCommand(function()
          UIManager.csUIManager:HideWindow(typeof(CS.UI_CharacterInfoWindow))
        end)
      end
      self.fairyCloseHpTimerId = nil
    end, self, true, true, nil)
    local SkipFairyFunc
    
    local function OnTimeUp()
      if IsNull(self.fairyGo) then
        return
      end
      if self.fairyAudioPlayback then
        AudioManager:StopAudioByBack(self.fairyAudioPlayback)
        self.fairyAudioPlayback = nil
      end
      self.fairyGo.transform:SetLayer(LayerMask.Character)
      PlayLeap()
      UIManager.csUIManager:ShowWindow(typeof(CS.UI_CharacterInfoWindow))
      UIUtil.CloseOneCover("SkipFairy")
      MsgCenter:RemoveListener(eMsgEventId.AVGPlayStart, SkipFairyFunc)
      self.__SkipFairyFunc = nil
    end
    
    self.fairyGo.transform.position = fairyPos
    self.fairyGo.transform.localRotation = Quaternion.LookRotation(Vector3.forward, Vector3.up)
    self.fairyAnimator:Play("Battle_perform")
    if self.fairyPerformAudioId then
      self.fairyAudioPlayback = AudioManager:PlayAudioById(self.fairyPerformAudioId)
    end
    self.fairyTimerId = TimerManager:StartTimer(performLength, function()
      OnTimeUp()
      self.fairyTimerId = nil
    end, self, true, nil, nil)
    
    function SkipFairyFunc()
      OnTimeUp()
      if self.fairyTimerId ~= nil then
        TimerManager:StopTimer(self.fairyTimerId)
        self.fairyTimerId = nil
      end
      if self.fairyCloseHpTimerId ~= nil then
        TimerManager:StopTimer(self.fairyCloseHpTimerId)
        self.fairyCloseHpTimerId = nil
      end
    end
    
    if self.__SkipFairyFunc ~= nil then
      MsgCenter:RemoveListener(eMsgEventId.AVGPlayStart, self.__SkipFairyFunc)
      self.__SkipFairyFunc = nil
    end
    UIUtil.AddOneCover("SkipFairy", SafePack(SkipFairyFunc, nil, nil, Color.clear, false))
    MsgCenter:AddListener(eMsgEventId.AVGPlayStart, SkipFairyFunc)
    self.__SkipFairyFunc = SkipFairyFunc
  else
    PlayLeap()
  end
end

function DungeonSceneBaseCtrl:GetFairyFinalStayPlace()
  local rootGo = CS.UnityEngine.GameObject.Find("FairyStayPoint")
  if IsNull(rootGo) then
    return Vector3.New(-3.5, 0, -4)
  end
  return rootGo.transform.position
end

function DungeonSceneBaseCtrl:BattleSceneDisposeMember()
  self:_ClearChangeEpHeroModelCo()
  self:DeleteChangeEpHeroOldModel()
  if self.effectPoolCtrl ~= nil then
    self.effectPoolCtrl:Dispose()
    self.effectPoolCtrl = nil
  end
  if self.heroResLoaderDic ~= nil then
    for k, resLoader in pairs(self.heroResLoaderDic) do
      resLoader:Put2Pool()
    end
    self.heroResLoaderDic = nil
  end
  if self.__reuseHeroResDic ~= nil then
    for k, resLoader in pairs(self.__reuseHeroResDic) do
      resLoader:Put2Pool()
    end
    self.__reuseHeroResDic = nil
  end
  self.fairyResStr = nil
  if self.fairyGo ~= nil then
    DestroyUnityObject(self.fairyGo)
    self.fairyGo = nil
  end
  if self.fairyResLoader ~= nil then
    self.fairyResLoader:Put2Pool()
    self.fairyResLoader = nil
  end
  if self.fairyTimerId ~= nil then
    TimerManager:StopTimer(self.fairyTimerId)
    if self.fairyAudioPlayback then
      AudioManager:StopAudioByBack(self.fairyAudioPlayback)
      self.fairyAudioPlayback = nil
    end
    UIUtil.CloseOneCover("SkipFairy")
    self.fairyTimerId = nil
  end
  if self.fairyCloseHpTimerId ~= nil then
    TimerManager:StopTimer(self.fairyCloseHpTimerId)
    self.fairyCloseHpTimerId = nil
  end
  if self.__bossCullCoroutine ~= nil then
    GR.StopCoroutine(self.__bossCullCoroutine)
    self.__bossCullCoroutine = nil
  end
end

function DungeonSceneBaseCtrl:OnDelete()
  self:BattleSceneDisposeMember()
  MsgCenter:RemoveListener(eMsgEventId.OnStartFocusBossTimeLine, self.__OnEpFouceBattleBossStart)
  MsgCenter:RemoveListener(eMsgEventId.OnEndFocusBossTimeLine, self.__OnEpFouceBattleBossEnd)
  if self.__SkipFairyFunc ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.AVGPlayStart, self.__SkipFairyFunc)
    self.__SkipFairyFunc = nil
  end
end

return DungeonSceneBaseCtrl
