local HomeAdjutant = class("HomeAdjutant")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local cs_ResLoader = CS.ResLoader
local SkinEnum = require("Game.Skin.SkinEnum")

function HomeAdjutant:ctor()
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self._resDic = {}
  self.__OnListenerAdjChangeCallback = BindCallback(self, self.OnListenerAdjChange)
  MsgCenter:AddListener(eMsgEventId.AdjCustomModify, self.__OnListenerAdjChangeCallback)
  MsgCenter:AddListener(eMsgEventId.AdjCustomChange, self.__OnListenerAdjChangeCallback)
end

function HomeAdjutant:InitHomeAdjutant(bind, emptyHolder, loadOverCallback)
  self.bind = bind
  self.isInit = true
  self.emptyHolder = emptyHolder
  self.loadOverCallback = loadOverCallback
  self.__interationOpenWait = true
  self.__interationOpenRayCast = true
  self:__ClearRes()
  if math.random(100000) == 666 then
    if self._surpriseLoader ~= nil then
      self._surpriseLoader:Put2Pool()
      self._surpriseLoader = nil
    end
    self._surpriseLoader = cs_ResLoader.Create()
    self:LoadHeroPic("miemiezi", self._surpriseLoader, function(obj)
      self._surpriseObj = obj
      self.__randTimerId = TimerManager:StartTimer(0.6, function()
        self.__randTimerId = nil
        self:LoadBoardHero()
      end, nil, true)
    end)
    return
  end
  self:LoadBoardHero()
  self:RecordPosOnBorn()
end

function HomeAdjutant:LoadBoardHero(callback)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset1) then
    return
  end
  local adjPresetData = PlayerDataCenter.allAdjCustomData:GetUsingCustomPreset()
  if adjPresetData == nil then
    return
  end
  local heroList = adjPresetData:GetAdjPresetHeroList()
  local limitCount = #heroList
  local successCount = 0
  self.homeController.homeCurrAdjutantLoaded = false
  
  local function finishCallback()
    successCount = successCount + 1
    if self._isHideBordGirl then
      self:HideBordGirl()
    end
    if successCount == limitCount then
      self.homeController.homeCurrAdjutantLoaded = true
      if self._waitGreeting then
        self:PlayAdjutantLoginGreeting()
      end
      if self.loadOverCallback ~= nil then
        self.loadOverCallback()
      end
      if callback ~= nil then
        callback()
      end
    end
  end
  
  if self.__randTimerId ~= nil then
    TimerManager:StopTimer(self.__randTimerId)
    self.__randTimerId = nil
  end
  if self._surpriseLoader ~= nil then
    self._surpriseLoader:Put2Pool()
    self._surpriseLoader = nil
  end
  if not IsNull(self._surpriseObj) then
    DestroyUnityObject(self._surpriseObj)
    self._surpriseObj = nil
  end
  self.isInit = false
  self.homeController.homeCurrAdjutantLoaded = false
  self:RecoverLastL2DRenderData()
  self:__ClearRes()
  for index, heroId in ipairs(heroList) do
    local adjInfo = adjPresetData:GetAdjPresetElemData(heroId)
    local resSingle = {}
    self:__ResetResInfo(resSingle, adjInfo)
    self:LoadAjutant(resSingle, finishCallback)
    self._resDic[resSingle.dataId] = resSingle
  end
  if self.homeController ~= nil then
    self.homeController:ResetHomeVoice()
  end
end

function HomeAdjutant:__ResetResInfo(resInfo, adjInfo)
  if not IsNull(resInfo.obj) then
    DestroyUnityObject(resInfo.obj)
    resInfo.obj = nil
  end
  if resInfo.resloader ~= nil then
    resInfo.resloader:Put2Pool()
    resInfo.resloader = nil
  end
  resInfo.resloader = cs_ResLoader.Create()
  resInfo.dataId = adjInfo.dataId
  resInfo.skinId = adjInfo.skinId
  resInfo.isMain = adjInfo.isMain
  resInfo.isL2d = adjInfo.isL2d
  resInfo.pos = adjInfo.pos
  resInfo.size = adjInfo.size
  local isHideBg = PlayerDataCenter.skinData:IsHideL2dBg(adjInfo.skinId)
  resInfo.isHideBg = isHideBg
  local isCloseL2dSfx = PlayerDataCenter.skinData:IsCloseLive2dSfx(adjInfo.skinId)
  resInfo.isCloseL2dSfx = isCloseL2dSfx
end

function HomeAdjutant:__ActiveL2dBg(resInfo, currentLive2dIsHideBg)
  if IsNull(resInfo.obj) then
    return
  end
  if resInfo.l2dBinding == nil then
    return
  end
  if IsNull(resInfo.l2dBinding.renderController) then
    return
  end
  resInfo.isHideBg = currentLive2dIsHideBg
  HeroL2dInterationController.ActiveLive2dBg(resInfo.l2dBinding.renderController, not currentLive2dIsHideBg)
end

function HomeAdjutant:HideBordGirl()
  self:OpenAdjutantWait(false)
  self._isHideBordGirl = true
  for k, resInfo in pairs(self._resDic) do
    if resInfo.obj ~= nil then
      resInfo.obj.transform:SetParent(self.emptyHolder.transform, false)
    end
  end
end

function HomeAdjutant:ShowBordGirl()
  self:OpenAdjutantWait(true)
  self._isHideBordGirl = false
  for i, resInfo in pairs(self._resDic) do
    if not IsNull(resInfo.obj) then
      if resInfo.l2dBinding ~= nil then
        resInfo.obj.transform:SetParent(self.bind.live2DRoot.transform, false)
      else
        resInfo.obj.transform:SetParent(self.bind.heroHolder.transform, false)
      end
      self:__SetPosAndSize(resInfo)
    end
  end
end

function HomeAdjutant:OpenAdjutantWait(flag)
  self.__interationOpenWait = flag
  self.__interationOpenRayCast = flag
  if not flag then
    self._waitGreeting = false
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:SetInterationOpenWait(flag)
    self.heroCubismInteration:SetInterationOpenRayCast(flag)
    if flag == true then
      self.heroCubismInteration:RestartBodyAnimation()
    end
  end
end

function HomeAdjutant:__SetHeroCubismInteration(resInfo)
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if resInfo.isL2d then
    local cs_CubismInterationController = resInfo.obj.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, resInfo.dataId, resInfo.skinId, UIManager:GetMainCamera(), true, self.homeController:GetLastCVId(), true)
      self.heroCubismInteration:SetInterationOpenWait(self.__interationOpenWait)
      self.heroCubismInteration:SetInterationOpenRayCast(self.__interationOpenRayCast)
    end
  else
    self.heroCubismInteration = HeroCubismInteration.New()
    self.heroCubismInteration:InitHeroPicCubism(resInfo.obj, resInfo.dataId, resInfo.skinId, self.homeController:GetLastCVId())
    self.heroCubismInteration:SetInterationOpenWait(self.__interationOpenWait)
    self.heroCubismInteration:SetInterationOpenRayCast(self.__interationOpenRayCast)
  end
end

function HomeAdjutant:__SetPosAndSize(resInfo)
  if resInfo.isMain then
    resInfo.obj.transform:SetAsLastSibling()
  else
    resInfo.obj.transform:SetAsFirstSibling()
  end
  if resInfo.pos ~= nil then
    local vec = resInfo.obj.transform.localPosition
    vec.x = resInfo.pos[1]
    vec.y = resInfo.pos[2]
    resInfo.obj.transform.localPosition = vec
  else
    resInfo.obj.transform.localPosition = resInfo.oriPos
  end
  if resInfo.size ~= nil then
    local size = resInfo.oriSize * resInfo.size
    resInfo.obj.transform.localScale = Vector3.New(size, size, size)
  else
    resInfo.obj.transform.localScale = Vector3.New(resInfo.oriSize, resInfo.oriSize, resInfo.oriSize)
  end
end

function HomeAdjutant:LoadAjutant(resInfo, finishCallback)
  if resInfo.isMain and self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  
  local function Local_SetAdjustAttribute(obj, l2dBinding)
    resInfo.obj = obj
    resInfo.l2dBinding = l2dBinding
    resInfo.oriSize = obj.transform.localScale.x
    resInfo.oriPos = obj.transform.localPosition
    self:__SetPosAndSize(resInfo)
    if resInfo.isL2d then
      local cubismCriwareAudioMouthInput = resInfo.obj.gameObject:GetComponent(typeof(CS.CubismCriwareAudioMouthInput))
      if not IsNull(cubismCriwareAudioMouthInput) then
        cubismCriwareAudioMouthInput.enabled = skinCtrl:CheckMouseOpen(resInfo.dataId, resInfo.skinId)
      end
    end
    if resInfo.isMain then
      self:__SetHeroCubismInteration(resInfo)
    end
    if finishCallback ~= nil then
      finishCallback()
    end
  end
  
  local modelCfg = skinCtrl:GetResModel(resInfo.dataId, resInfo.skinId)
  local resName = modelCfg.src_id_pic
  if resInfo.isL2d then
    self:LoadLive2D(resName, resInfo.resloader, Local_SetAdjustAttribute)
  else
    self:LoadHeroPic(resName, resInfo.resloader, Local_SetAdjustAttribute)
  end
end

function HomeAdjutant:LoadHeroPic(resName, resloader, finishCallback)
  resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName, SkinEnum.fromWhere.adjutant), function(prefab)
    local obj = prefab:Instantiate(self.bind.heroHolder.transform)
    local comPerspHandle = obj:FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetL2DPicPosType("Home", true)
    if finishCallback ~= nil then
      finishCallback(obj)
    end
  end)
end

function HomeAdjutant:LoadLive2D(resName, resloader, finishCallback)
  resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName, SkinEnum.fromWhere.adjutant), function(l2dModelAsset)
    local obj = l2dModelAsset:Instantiate()
    obj.transform:SetParent(self.bind.live2DRoot.transform)
    obj.gameObject.layer = self.bind.live2DRoot.gameObject.layer
    local l2dBinding = {}
    UIUtil.LuaUIBindingTable(obj, l2dBinding)
    local canvasGroup = self.bind.canvas_canvasGroup
    if canvasGroup ~= nil then
      l2dBinding.renderController.uiCanvasGroup = canvasGroup
      l2dBinding.renderController.SortingLayer = "UI3D"
      l2dBinding.renderController.SortingOrder = -900
    end
    local cubismLookController = obj.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Framework.LookAt.CubismLookController))
    HeroLookTargetController.OpenLookTarget(cubismLookController, l2dBinding.lookTarget.gameObject, UIManager:GetMainCamera())
    l2dBinding.renderController.InfluencedByUICanvas = true
    l2dBinding.commonPerpectiveHandle:SetRenderCamera(self.bind.live2DRoot)
    l2dBinding.commonPerpectiveHandle:SetL2DPosType("Home", true)
    if finishCallback ~= nil then
      finishCallback(obj, l2dBinding)
    end
  end)
end

function HomeAdjutant:RecoverLastL2DRenderData()
  for i, resSingle in pairs(self._resDic) do
    if resSingle.l2dBinding ~= nil and resSingle.l2dBinding.commonPerpectiveHandle ~= nil then
      resSingle.l2dBinding.commonPerpectiveHandle:RecoverRenderCameraData()
    end
  end
end

function HomeAdjutant:RecordPosOnBorn()
  if self.bind.heroHolder ~= nil then
    self.picHolderPosOnBornX = self.bind.heroHolder.transform.localPosition.x
  end
  if self.bind.live2DRoot.transform ~= nil then
    self.live2DHolderPosOnBornX = self.bind.live2DRoot.transform.localPosition.x
  end
end

function HomeAdjutant:HomeRightUnfoldRate(rate)
  rate = rate or 0
  local xValue = self.picHolderPosOnBornX or 0
  local offsXValue = self.bind.picHolderSliderRatio * rate + xValue
  self.bind.heroHolder.transform:SetLocalX(offsXValue)
  xValue = self.live2DHolderPosOnBornX or 0
  offsXValue = self.bind.live2dHolderSliderRatio * rate + xValue
  self.bind.live2DRoot.transform:SetLocalX(offsXValue)
end

function HomeAdjutant:PlayAdjutantLoginGreeting()
  if self.heroCubismInteration == nil then
    self._waitGreeting = true
    return
  end
  self._waitGreeting = false
  local voiceId = self:GetLoginType()
  self.heroCubismInteration:PlayLoginAnimation(voiceId)
end

function HomeAdjutant:PlayAdjutantHeroEnterHomeAnimation()
  if self.heroCubismInteration == nil then
    return
  end
  local voiceId = self:GetLoginType()
  self.heroCubismInteration:PlayHeroEnterHomeAnimation(voiceId)
end

function HomeAdjutant:GetLoginType()
  local loginType
  local curAdjPreset = PlayerDataCenter.allAdjCustomData:GetUsingCustomPreset()
  if curAdjPreset == nil then
    return 0
  end
  local mainAdj = curAdjPreset:GetAdjPresetElemMain()
  local heroId = mainAdj.dataId
  local skinId = mainAdj.skinId
  if skinId == 0 then
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg ~= nil then
      skinId = heroCfg.default_skin
    end
  end
  local curHour = TimeUtil:TimestampToDate(os.time(), nil, true).hour
  local live2dConfig
  if skinId ~= 0 then
    live2dConfig = ConfigData.skin_live2d[skinId]
  else
    live2dConfig = ConfigData.skin_live2d[heroId]
    warn("has heroId l2d!!!")
  end
  if live2dConfig ~= nil and live2dConfig.login_time_range ~= nil and live2dConfig.login_time_range[curHour + 1] ~= nil and #live2dConfig.login_time_range == 24 then
    loginType = live2dConfig.login_time_range[curHour + 1]
    return loginType
  else
    local loginRange = {
      0,
      6,
      12,
      18
    }
    if curHour >= loginRange[1] and curHour < loginRange[2] then
      loginType = eVoiceType.MIDNIGHT
    elseif curHour >= loginRange[2] and curHour < loginRange[3] then
      loginType = eVoiceType.MORNING
    elseif curHour >= loginRange[3] and curHour < loginRange[4] then
      loginType = eVoiceType.AFTERNOON
    else
      loginType = eVoiceType.EVENING
    end
    return loginType
  end
end

function HomeAdjutant:IsPlayLoginAnimationOnAutoShowOver()
  if self.heroCubismInteration ~= nil then
    local loginType = self.GetLoginType()
    return self.heroCubismInteration:IsPlayLoginAnimationOnAutoShowOver(loginType)
  end
  return true
end

function HomeAdjutant:OnListenerAdjChange()
  local adjPresetData = PlayerDataCenter.allAdjCustomData:GetUsingCustomPreset()
  if adjPresetData == nil then
    return
  end
  local oriMainHeorId
  if self.heroCubismInteration ~= nil then
    oriMainHeorId = self.heroCubismInteration:GetCubismHeroId()
  end
  
  local function ChangeFinishFunc()
    if self._recordCubismHeroId ~= nil then
      return
    end
    if self.heroCubismInteration == nil then
      return
    end
    local curMainHeroId = self.heroCubismInteration:GetCubismHeroId()
    if oriMainHeorId ~= nil and curMainHeroId ~= oriMainHeorId then
      local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
      if homeCtrl ~= nil and not GuideManager.inGuide then
        homeCtrl:PlayLoginHeroGreeting()
      end
    end
  end
  
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:ResetShowHeroVoiceImme()
  end
  local heroList = adjPresetData:GetAdjPresetHeroList()
  if #heroList ~= table.count(self._resDic) then
    self:LoadBoardHero(ChangeFinishFunc)
    return
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  local resetResIdDic = {}
  local needLoadDic = {}
  for index, heroId in ipairs(heroList) do
    resetResIdDic[heroId] = true
    local resInfo = self._resDic[heroId]
    local adjInfo = adjPresetData:GetAdjPresetElemData(heroId)
    if resInfo == nil then
      resInfo = {}
      self:__ResetResInfo(resInfo, adjInfo)
      self._resDic[resInfo.dataId] = resInfo
      needLoadDic[resInfo.dataId] = resInfo
    elseif resInfo.obj then
      if adjInfo.skinId ~= resInfo.skinId or adjInfo.isL2d ~= resInfo.isL2d then
        self:__ResetResInfo(resInfo, adjInfo)
        needLoadDic[resInfo.dataId] = resInfo
      else
        resInfo.isMain = adjInfo.isMain
        resInfo.pos = adjInfo.pos
        resInfo.size = adjInfo.size
        if resInfo.isMain then
          self:__SetHeroCubismInteration(resInfo)
        end
        self:__SetPosAndSize(resInfo)
      end
      local currentLive2dIsHideBg = PlayerDataCenter.skinData:IsHideL2dBg(adjInfo.skinId)
      if currentLive2dIsHideBg ~= resInfo.isHideBg then
        self:__ActiveL2dBg(resInfo, currentLive2dIsHideBg)
      end
    end
  end
  local waitLoadCount = table.count(needLoadDic)
  local hasLoadCount = 0
  if 0 < waitLoadCount then
    self.homeController.homeCurrAdjutantLoaded = false
  else
    ChangeFinishFunc()
  end
  for k, resInfo in pairs(needLoadDic) do
    self:LoadAjutant(resInfo, function()
      hasLoadCount = hasLoadCount + 1
      if self._isHideBordGirl then
        self:HideBordGirl()
      end
      if hasLoadCount == waitLoadCount then
        self.homeController.homeCurrAdjutantLoaded = true
        ChangeFinishFunc()
      end
    end)
  end
  for heroId, resInfo in pairs(self._resDic) do
    if resetResIdDic[heroId] == nil then
      if not IsNull(resInfo.obj) then
        DestroyUnityObject(resInfo.obj)
        resInfo.obj = nil
      end
      if resInfo.l2dBinding ~= nil then
        resInfo.l2dBinding = nil
      end
      resInfo.resloader:Put2Pool()
      resInfo.resloader = nil
      self._resDic[heroId] = nil
    end
  end
end

function HomeAdjutant:RecordCurCubismHeroId()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset1) then
    return
  end
  local preset = PlayerDataCenter.allAdjCustomData:GetUsingCustomPreset()
  if preset ~= nil then
    local mainInfo = preset:GetAdjPresetElemMain()
    self._recordCubismHeroId = mainInfo.dataId
  end
end

function HomeAdjutant:IsChangeCubismHero()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MainPreset1) then
    return false
  end
  if self._recordCubismHeroId == nil then
    return false
  end
  local nowCubismHeroId
  if self.heroCubismInteration ~= nil then
    nowCubismHeroId = self.heroCubismInteration:GetCubismHeroId()
  end
  return (nowCubismHeroId or 0) ~= self._recordCubismHeroId
end

function HomeAdjutant:ClearCurCubismHeroRecord()
  self._recordCubismHeroId = nil
end

function HomeAdjutant:__ClearRes()
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  for k, resSingle in pairs(self._resDic) do
    resSingle.resloader:Put2Pool()
    resSingle.resloader = nil
    if not IsNull(resSingle.obj) then
      DestroyUnityObject(resSingle.obj)
      resSingle.obj = nil
    end
    if resSingle.l2dBinding ~= nil then
      resSingle.l2dBinding = nil
    end
    self._resDic[k] = nil
  end
end

function HomeAdjutant:Delete()
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomModify, self.__OnListenerAdjChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.AdjCustomChange, self.__OnListenerAdjChangeCallback)
  if self.__randTimerId ~= nil then
    TimerManager:StopTimer(self.__randTimerId)
    self.__randTimerId = nil
  end
  if self._surpriseLoader ~= nil then
    self._surpriseLoader:Put2Pool()
    self._surpriseLoader = nil
  end
  self:__ClearRes()
end

return HomeAdjutant
