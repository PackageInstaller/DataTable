local base = require("Game.ActivityHeroGrow.UI.UINCharaDungeonBase")
local UINCharDunKuro = class("UINCharDunKuro", base)
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local cs_AudioManager = CS.AudioManager.Instance
local cs_ResLoader = CS.ResLoader
local cs_MovieManager = CS.MovieManager.Instance

function UINCharDunKuro:OnInit()
  base.OnInit(self)
  UIUtil.AddValueChangedListener(self.ui.tog_Player, self, self._OnBtnPlayerChange)
  local settingCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  self.audioSetting = settingCtrl:GetSettingAudioData()
  AudioManager:PlayAudioById(3001)
  self.heroID = 1044
  self:_LoadRes(true)
end

function UINCharDunKuro:_OnBtnPlayerChange(pause)
  local idx = pause and 1 or 0
  self.ui.Img_Player:SetIndex(idx)
  self:_SetPlayerDOTweenPause(pause)
  local setValue = 0
  if not pause then
    setValue = self.audioSetting.volumes[1]
  end
  cs_AudioManager:SetVolume(1, setValue)
end

function UINCharDunKuro:_LoadRes(isMovie)
  self.ui.img_Kuro.gameObject:SetActive(false)
  self.ui.img_Movie.gameObject:SetActive(false)
  self:_SetWaitActive(true)
  self:_SetLiveDOTweenPause(true)
  
  local function resIsDoneFunc(obj, l2dBinding)
    self.l2dBinding = l2dBinding
    self.timeID = TimerManager:StartTimer(1.5, function()
      obj:SetActive(true)
      self:_SetWaitActive(false)
      self:_SetLiveDOTweenPause(false)
    end, true)
  end
  
  if isMovie then
    self:_LoadMovie(resIsDoneFunc)
    return
  end
  self:_LoadLive2D(resIsDoneFunc)
end

function UINCharDunKuro:_LoadMovie(resIsDoneFunc)
  if self.moviePlayer == nil then
    self.moviePlayer = cs_MovieManager:GetMoviePlayer()
  end
  self.moviePlayer:SetVideoRender(self.ui.img_Movie)
  local path = PathConsts:GetCharDunVideoPath(self.heroID)
  self.moviePlayer:PlayVideo(path, nil, 1, true)
  resIsDoneFunc(self.ui.img_Movie.gameObject)
end

function UINCharDunKuro:_LoadLive2D(resIsDoneFunc)
  local heroCfg = ConfigData.hero_data[self.heroID]
  if heroCfg == nil then
    error("Can't Get HeroCfg by ID:" .. "1044")
    return
  end
  local heroData = HeroData.New({
    basic = {
      id = self.heroID,
      level = 1,
      exp = 0,
      star = heroCfg.rank,
      potentialLvl = 0,
      ts = -1,
      career = heroCfg.career,
      company = heroCfg.camp,
      skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, self.heroID)
    }
  })
  DestroyUnityObject(self.liveGo)
  self.resLoader = cs_ResLoader.Create()
  local picName = heroData:GetResPicName()
  local resPath = PathConsts:GetCharacterLive2DPath(picName)
  local showLive2d = PlayerDataCenter.skinData:GetLive2dSwitchState(heroData.dataId, heroData.skinId)
  if not CS.ResManager.Instance:ContainsAsset(resPath) or not showLive2d then
    resIsDoneFunc(self.ui.img_Kuro.gameObject)
    return
  end
  self.resLoader:LoadABAssetAsync(resPath, function(l2dModelAsset)
    self.liveGo = l2dModelAsset:Instantiate(self.ui.resHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    self.liveGo.gameObject:SetActive(false)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = heroData.dataId
      local skinId = heroData.skinId
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self.charDunWin:GetWindowSortingLayer(), self.ui.resHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
    end
    local l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.liveGo, l2dBinding)
    resIsDoneFunc(self.liveGo.gameObject, l2dBinding)
  end)
end

function UINCharDunKuro:_SetPlayerDOTweenPause(pause)
  for _, doTween in ipairs(self.ui.playerDOTweens) do
    if pause then
      doTween:DOPause()
    else
      doTween:DOPlay()
    end
  end
end

function UINCharDunKuro:_SetLiveDOTweenPause(isPause)
  for _, tween in ipairs(self.ui.liveDOTween) do
    if isPause then
      tween:DOPause()
    else
      tween:DOPlay()
    end
  end
end

function UINCharDunKuro:_SetWaitActive(active)
  self.ui.obj_wait:SetActive(active)
end

function UINCharDunKuro:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.timeID ~= nil then
    TimerManager:StopTimer(self.timeID)
    self.timeID = nil
  end
  if self.moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  DestroyUnityObject(self.liveGo)
  cs_AudioManager:SetVolume(1, self.audioSetting.volumes[1])
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Home.name, eAuSelct.Home.sector)
  base.OnDelete(self)
end

return UINCharDunKuro
