if CS.UnityEngine.SystemLanguage and CS.UnityEngine.Application.systemLanguage == CS.UnityEngine.SystemLanguage.Turkish then
  local dlPath = CS.ResourceManager.DownloadHelper.GetDownloadPathDefault()
  if CS.Z1Client.LuaCSharpUtil.EnableRenderFeature ~= nil then
    local targetPath = dlPath .. "/text_enaı.ab"
    local textInfo = CS.System.IO.FileInfo(targetPath)
    if textInfo.Exists then
      CS.ResourceManager.FileHelper.FileSafeDelete(targetPath)
    end
  else
    local textENdownLoadPath = dlPath .. "/text_enai.ab"
    local textENInfo = CS.System.IO.FileInfo(textENdownLoadPath)
    if textENInfo.Exists then
      local targetDir = dlPath .. "/text_enaı.ab"
      local src_file = io.open(textENdownLoadPath, "rb")
      if src_file then
        local dst_file = io.open(targetDir, "wb")
        if dst_file then
          local block_size = 8192
          while true do
            local block = src_file:read(block_size)
            if not block then
              break
            end
            dst_file:write(block)
          end
          src_file:close()
          dst_file:close()
        else
          src_file:close()
        end
      end
    end
  end
end
local uiresourceName2Assets = require("GameScript.UI.UIPackages.UIPackagesImporter")
local UIPackagePrefix = "UI.UIPackages."

local function NewUIBaseResource(name)
  local cls, super = System.NewClass(name, UIBaseResource)
  cls.name = name
  return cls, super
end

local redirectRequire = false
local is_debug_mode = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor or CS.FrameWork.Z1Const.IsDebugMode()
local modulepath2longpath = {}
local uiAssetsNameCls = {}
local uiAssetsPath2Cls = {}

function RegisterLuaModule(modulepath, longmodulepath)
  modulepath2longpath[modulepath] = longmodulepath
end

function GetLuaModulePath(modulepath)
  local longPath = modulepath2longpath[modulepath]
  return longPath and longPath or modulepath
end

function CreateUIResObj(name)
  if not uiresourceName2Assets[name] then
    return
  end
  local uiResCls = NewUIBaseResource(name)
  uiAssetsNameCls[name] = uiResCls
  uiResCls.assetPath = uiresourceName2Assets[name]
  SetGlobal(name, uiResCls)
  return uiResCls
end

function GetUIResObj(name)
  if uiAssetsNameCls[name] then
    return uiAssetsNameCls[name]
  end
  do return CreateUIResObj end
  return CreateUIResObj, name
end

local function _RedirectRequire()
  if redirectRequire then
    return
  end
  redirectRequire = true
  local old_require = require
  
  local function new_require(name)
    local longPath = modulepath2longpath[name]
    if longPath then
      do return old_require end
      return old_require, longPath, nil, nil
    end
    if string.sub(name, 1, #UIPackagePrefix) == UIPackagePrefix then
      if uiAssetsPath2Cls[name] then
        return uiAssetsPath2Cls[name]
      end
      local uiResClsName = name:match("UI%.UIPackages%.([%w_]+)")
      if uiResClsName then
        local uiRes = GetUIResObj(uiResClsName)
        uiAssetsPath2Cls[name] = uiRes
        return uiRes
      end
    end
    do return old_require end
    return old_require, name, uiAssetsPath2Cls, #UIPackagePrefix
  end
  
  require = new_require
end

if is_debug_mode then
  local ret, hardreload = pcall(require, "Foundation.Utility.HardReload")
  if ret and hardreload.is_valid() then
    _G.raw_require = require
    _G.require = hardreload.require
  end
end
CS.ResourceManager.VersionTools.ClearVersionInfo()
_RedirectRequire()
require("Foundation.System.String")
require("Foundation.System.Table")
require("GameScript.Managers.CodeManager").Instance():Enable()
require("GameScript.Redirect_Logic_Modules")
UsingNow("Foundation.Import_Framework_Modules")
UsingNow("GameScript.ModulePath_GameScript")
UsingNow("GameScript.Import_ModulePath_GameScript")
local Main, Super = System.NewClass("Main", Manager)
local isAppDestroyed = false
local enableLuaboomer = CS.Z1Client.LuaBehaviour.enableLuaboomer or not ApplicationUtils.is_editor_mode()

local function InitCoreComponenets(coreContainer)
  LoginStepTracker.Instance:TrackStep(1)
  GlobalDispatcher.Init()
  LoginStepTracker.Instance:TrackStep(2)
  UIRootMgr.Init()
  LoginStepTracker.Instance:TrackStep(3)
  DOTweenUtils.Init()
  LoginStepTracker.Instance:TrackStep(4)
  Logger.Init()
  LoginStepTracker.Instance:TrackStep(5)
  Logger.ReportApusInfo("[enter_game_step] {step}:{msg}", "Main.InitCoreComponenets", "-")
  Logger.Debug("Main:InitCoreComponenets")
  if ApplicationUtils.IsWindows() or ApplicationUtils.IsEditor() then
    coreContainer:AddComponent(WindowsResolutionManager)
  end
  coreContainer:AddComponent(PoolManager)
  LoginStepTracker.Instance:TrackStep(6)
  coreContainer:AddComponent(UIImageCache)
  LoginStepTracker.Instance:TrackStep(7)
  coreContainer:AddComponent(UITMPAssetsMgr)
  LoginStepTracker.Instance:TrackStep(8)
  coreContainer:AddComponent(EventMgr)
  LoginStepTracker.Instance:TrackStep(9)
  coreContainer:AddComponent(Z1QueueMgr)
  LoginStepTracker.Instance:TrackStep(10)
  coreContainer:AddComponent(ShortCutKeyManager)
  LoginStepTracker.Instance:TrackStep(10.1)
  coreContainer:AddComponent(MobileFileDataManager)
  LoginStepTracker.Instance:TrackStep(11)
  coreContainer:AddComponent(PerformanceManager)
  LoginStepTracker.Instance:TrackStep(12)
  coreContainer:AddComponent(TimerManager)
  LoginStepTracker.Instance:TrackStep(13)
  coreContainer:AddComponent(UIManager)
  LoginStepTracker.Instance:TrackStep(14)
  coreContainer:AddComponent(SteamSdk)
  coreContainer:AddComponent(SdkMgr)
  LoginStepTracker.Instance:TrackStep(15)
  coreContainer:AddComponent(SettingManager)
  LoginStepTracker.Instance:TrackStep(16)
  coreContainer:AddComponent(LangManager)
  LoginStepTracker.Instance:TrackStep(17)
  LT.Init()
  LoginStepTracker.Instance:TrackStep(18)
  CardTable.Init()
  LoginStepTracker.Instance:TrackStep(19)
  coreContainer:AddComponent(FuncJumpManager)
  LoginStepTracker.Instance:TrackStep(20)
  coreContainer:AddComponent(ProtoManager)
  LoginStepTracker.Instance:TrackStep(21)
  coreContainer:AddComponent(MathManager)
  LoginStepTracker.Instance:TrackStep(22)
  coreContainer:AddComponent(RpcMgr)
  LoginStepTracker.Instance:TrackStep(23)
  coreContainer:AddComponent(NetworkMgr, ErrorMsg.ShowErrCodeTips)
  LoginStepTracker.Instance:TrackStep(24)
  coreContainer:AddComponent(ItemDispatchManager)
  LoginStepTracker.Instance:TrackStep(25)
  coreContainer:AddComponent(TaskMgr)
  LoginStepTracker.Instance:TrackStep(26)
  coreContainer:AddComponent(UIAudioManager)
  LoginStepTracker.Instance:TrackStep(27)
  coreContainer:AddComponent(AVProManager)
  LoginStepTracker.Instance:TrackStep(28)
  coreContainer:AddComponent(AudioManager)
  LoginStepTracker.Instance:TrackStep(29)
  coreContainer:AddComponent(AwakerAudioManager)
  LoginStepTracker.Instance:TrackStep(30)
  coreContainer:AddComponent(PopTipsManager)
  LoginStepTracker.Instance:TrackStep(31)
  coreContainer:AddComponent(RedPointManager)
  LoginStepTracker.Instance:TrackStep(32)
  coreContainer:AddComponent(GuideManager)
  coreContainer:AddComponent(NewbieGuideManager)
  LoginStepTracker.Instance:TrackStep(33)
  coreContainer:AddComponent(ReconnectMgr)
  LoginStepTracker.Instance:TrackStep(34)
  coreContainer:AddComponent(WorldStageManager)
  coreContainer:AddComponent(StageExitPanelManager)
  LoginStepTracker.Instance:TrackStep(35)
  coreContainer:AddComponent(WorldRecoveryManager)
  LoginStepTracker.Instance:TrackStep(36)
  coreContainer:AddComponent(ResGcMgr)
  LoginStepTracker.Instance:TrackStep(37)
  coreContainer:AddComponent(LoginMgr)
  LoginStepTracker.Instance:TrackStep(38)
  coreContainer:AddComponent(SceneMgr)
  LoginStepTracker.Instance:TrackStep(39)
  coreContainer:AddComponent(InputManager)
  LoginStepTracker.Instance:TrackStep(40)
  coreContainer:AddComponent(CursorManager)
  coreContainer:AddComponent(EffectManager)
  LoginStepTracker.Instance:TrackStep(41)
  coreContainer:AddComponent(ClickEffectComponent)
  LoginStepTracker.Instance:TrackStep(42)
  coreContainer:AddComponent(AvgStoryManager)
  LoginStepTracker.Instance:TrackStep(43)
  coreContainer:AddComponent(BattleManager)
  LoginStepTracker.Instance:TrackStep(44)
  coreContainer:AddComponent(BattleGuardManager)
  LoginStepTracker.Instance:TrackStep(45)
  coreContainer:AddComponent(ActivityManager)
  coreContainer:AddComponent(FriendMatchMgr)
  LoginStepTracker.Instance:TrackStep(46)
  coreContainer:AddComponent(AwakerFaceManager)
  LoginStepTracker.Instance:TrackStep(47)
  coreContainer:AddComponent(PopupQueManager)
  LoginStepTracker.Instance:TrackStep(48)
  coreContainer:AddComponent(MaterialIconMgr)
  LoginStepTracker.Instance:TrackStep(49)
  coreContainer:AddComponent(GyroscopeManager)
  LoginStepTracker.Instance:TrackStep(50)
  coreContainer:AddComponent(PortraitManager)
  LoginStepTracker.Instance:TrackStep(51)
  coreContainer:AddComponent(GameTimeEventManager)
  LoginStepTracker.Instance:TrackStep(52)
  Manager.Print()
  print("######################## Develp ########################")
  LoginStepTracker.Instance:TrackStep(53)
  if ApplicationUtils.is_debug_mode() and enableLuaboomer then
    require("Debugger.LuaPanda").start("127.0.0.1", 8818)
    coreContainer:AddComponent(LuaboomerMgr)
  end
  LoginStepTracker.Instance:TrackStep(54)
  if ApplicationUtils.is_open_gm() then
    coreContainer:AddComponent(GmManager)
  end
  LoginStepTracker.Instance:TrackStep(55)
  CS.SoftMaskCtrl.AreaLimit = 480000
  LoginStepTracker.Instance:TrackStep(56)
  WaitingView.Instance:Init()
  LoginStepTracker.Instance:TrackStep(57)
  UIBlackScreenMgr.Instance:Init()
  LoginStepTracker.Instance:TrackStep(58)
  ExtensionMgr.Instance:Init(SettingExtension)
  LoginStepTracker.Instance:TrackStep(59)
  coreContainer:AddComponent(UITouchEndManager)
  LoginStepTracker.Instance:TrackStep(60)
  coreContainer:AddComponent(LoadingMusicManager)
  LoginStepTracker.Instance:TrackStep(61)
  coreContainer:AddComponent(AvgTutorialManager)
  LoginStepTracker.Instance:TrackStep(62)
  coreContainer:AddComponent(AdaptiveManager)
  LoginStepTracker.Instance:TrackStep(63)
  coreContainer:AddComponent(LuaComponentManager)
  LoginStepTracker.Instance:TrackStep(64)
  coreContainer:AddComponent(ClientRandomManager)
  coreContainer:AddComponent(GroupDownloadMgr)
  coreContainer:AddComponent(ClearCameraMgr)
  coreContainer:AddComponent(SteamArchievesMgr)
  Logger.Debug("Main:InitCoreComponenets Done")
end

function Main:ctor()
  Super.ctor(self)
  if CS.Z1Client.LuaCSharpUtil.CheckDefaultForParticleQuality ~= nil then
    CS.Z1Client.LuaCSharpUtil.CheckDefaultForParticleQuality = false
  end
  ApplicationUtils.EnableRenderFeature("Empty", false)
  ApplicationUtils.SetOutlineEnable(false)
  CS.SoftMaskCtrl.EnableSoftMask(false)
  if ApplicationUtils.IsIOS() then
    GameVideoPlayer.forceUseBakMediaPlayer = true
  end
  ResLoadMgr.Init()
  RedGameObjectMgr.Init()
  LoginStepTracker.Instance:TrackStep(-100)
  getmetatable(self).Instance = self
  LoginStepTracker.Instance:TrackStep(-99)
  CS.Framework.TimeUtil.Init()
  LoginStepTracker.Instance:TrackStep(-98)
  SleepTimeOutUtils.SetNeverSleep()
  LoginStepTracker.Instance:TrackStep(-97)
  self.nextTick = nextTick
  LoginStepTracker.Instance:TrackStep(-96)
  Logger.RedirectLog()
  LoginStepTracker.Instance:TrackStep(-95)
  local gameApp = CS.UnityEngine.GameObject.Find("GameApp")
  CS.GameObjectInsQueue.Init(gameApp.gameObject)
  LoginStepTracker.Instance:TrackStep(-94)
  self.coreContainer = Entity()
  LoginStepTracker.Instance:TrackStep(-93)
  InitCoreComponenets(self.coreContainer)
  self:_RedirectTipsType()
  LoginStepTracker.Instance:TrackStep(200)
  SceneMgr.Instance:EnterGame()
  LoginStepTracker.Instance:TrackStep(201)
  AcceleratorChecker.Init()
  LoginStepTracker.Instance:TrackStep(202)
  ConvertTypes.Exec()
  LoginStepTracker.Instance:TrackStep(203)
  self.isInited = true
  self.isPlaying = true
end

function Main:_RedirectTipsType()
  local tipsType = DT.TipsType
  if not tipsType then
    return
  end
  local mt = getmetatable(tipsType) or {}
  local oldIndex = mt.__index
  
  function mt.__index(t, k)
    k = tostring(k)
    if oldIndex then
      do return oldIndex, t end
      return oldIndex, t, k
    end
    do return rawget, t end
    return rawget, t, k
  end
  
  setmetatable(tipsType, mt)
end

function Main.DisableNextTick()
  if not Main.Instance or not Main.Instance.nextTick then
    return
  end
  if not Main.Instance.nextTick.setDisable then
    return
  end
  Main.Instance.nextTick.setDisable()
end

function Main:LateUpdate()
  if not self.isInited or isAppDestroyed then
    return
  end
  self.nextTick.flushCallbacks()
  UIEffectMgr.Instance:LateUpdate()
  MaterialIconMgr.Instance:LateUpdate()
  LateUpdateBeat.Instance:LateUpdate()
  CommandBufferMgr.Instance:ExecuteCommandBuffer()
  ResUpdateUtil.Instance:TryPopResUpdateDialog()
  RedDotController.Instance:LateUpdate()
end

function Main:Update()
  if not self.isInited or isAppDestroyed then
    return
  end
  local deltaTime = CS.UnityEngine.Time.deltaTime
  TimerManager.deltaTime = deltaTime
  TimerManager.totalTime = TimerManager.totalTime + deltaTime
  if nil ~= Main.Instance.coreContainer then
    Main.Instance.coreContainer:Update(deltaTime)
  end
  FrameWaiter.Update()
  AcceleratorChecker.Update()
  UIEffectMgr.Instance:Update(deltaTime)
  GameEssentialDataRequestor.Instance:Update()
  PlayerDataRequestor.Instance:Update()
  UpdateBeat.Instance:Update(deltaTime)
end

function Main:OnResume()
  self.isPlaying = true
  if AVProManager.Instance then
    AVProManager.Instance:OnApplicationResume()
  end
  if ApplicationUtils.is_editor_mode() or bg.battleScene or isAppDestroyed then
    return
  end
  local inGameGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  if inGameGroup and inGameGroup:GetDelagate() then
    GroupDownloadMgr.Instance:CancelDownloadMaxBandWidth()
    return
  end
  if inGameGroup then
    GroupDownloadMgr.Instance:EnableDownloadMaxBandWidth()
  end
  ResUpdateUtil.Instance:CheckResUpdate(true)
  Logger.Debug("Main:OnResume()")
end

function Main:OnPause()
  self.isPlaying = false
  if AVProManager.Instance then
    AVProManager.Instance:OnApplicationPause()
  end
  if ApplicationUtils.is_editor_mode() or isAppDestroyed then
    return
  end
  Logger.Debug("Main:OnPause()")
  local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
  if ingameDownloadGroup then
    GroupDownloadMgr.Instance:CancelDownloadMaxBandWidth()
  end
end

function Main.Destroy()
  if Main.isAppDestroyed then
    return
  end
  Main.isAppDestroyed = true
  isAppDestroyed = true
  
  local function _doDestroy()
    Main.DisableNextTick()
    Main.RunShutdown()
    local SceneMgr = require("Managers.Scene.SceneMgr")
    Logger.isDestroying = true
    SceneMgr.isDestroying = true
    if Main.Instance ~= nil then
      Main.Instance.coreContainer:Destroy()
      Main.Instance = nil
    end
    DOTweenUtils.Release()
    Main.DestroyScenes()
  end
  
  pcall(_doDestroy)
end

function Main.DestroyScenes()
  local sceneList = {}
  local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
  local sceneCount = SceneManager.sceneCount - 1
  for i = 0, sceneCount do
    table.insert(sceneList, SceneManager.GetSceneAt(i))
  end
  for i = 1, #sceneList do
    local scene = sceneList[i]
    if scene:IsValid() and scene.isLoaded then
      local rootObjects = scene:GetRootGameObjects()
      for j = 0, rootObjects.Length - 1 do
        local name = rootObjects[j].name
        if "GameApp" ~= name and "Main Camera" ~= name and "UICamera" ~= name and "Plugins" ~= name then
          rootObjects[j]:SetActive(false)
          DestroyImmediate(rootObjects[j])
        end
      end
    end
  end
end

function Main.RestartGame()
  if Main.isRestartGame then
    return
  end
  CS.ResourceManager.VersionTools.ClearVersionInfo()
  Main.isRestartGame = true
  Main.Destroy()
  CS.Z1Client.LuaCSharpUtil.RestartGame()
end

function Main.RunStartup()
  if Main.Instance ~= nil then
    print("Main 被多次启动！！！！")
    return
  end
  print("Main 启动游戏啦！！！！")
  local game = Main()
  LoginPanel.ReShowUpdateUI()
  return game
end

function Main.RunShutdown()
  print("Main.关闭游戏")
  if RpcMgr.Instance then
    RpcMgr.Instance:Close()
  end
  if ApplicationUtils.is_debug_mode() and enableLuaboomer then
    require("Debugger.LuaPanda").disconnect()
  end
end

return Main
