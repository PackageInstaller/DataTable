local FirstAsyncLoader = {}
local xlua_util = require("XLua.Common.xlua_util")

function FirstAsyncLoader.LoadFunc()
  local cs_DownloadWindow = CS.UI_Downloading.Instance
  require("Consts.Consts")
  CRH = require("Game.Res.CommonResHelper")
  CRH:Init()
  CRH:LoadCommonAtlas(cs_DownloadWindow, 0.2)
  CRH:LoadBaseItemFx()
  coroutine.yield()
  local progress = 0.31
  cs_DownloadWindow:UpdateProgress(progress)
  local ConfigDataLoader = require("Game.ConfigData.ConfigDataLoader")
  local configNameList = ConfigDataLoader.GetConfigNameList()
  local configDataCount = #configNameList
  local OneConfigProgress = 0.6 / configDataCount
  local frameLoadConfigCount = 15
  local loadedConfigCount = 0
  for _, tdata in pairs(configNameList) do
    ConfigData[tdata[1]] = require(ConfigDataLoader.LoadConfigHead .. tdata[2])
    loadedConfigCount = loadedConfigCount + 1
    if frameLoadConfigCount <= loadedConfigCount then
      loadedConfigCount = 0
      coroutine.yield()
      progress = math.min(1, progress + OneConfigProgress * frameLoadConfigCount)
      cs_DownloadWindow:UpdateProgress(progress)
    end
  end
  ConfigData.LoadLocalText()
  ConfigDataLoader.AfterLoadConfigComplete()
  package.loaded["Game.ConfigData.ConfigDataLoader"] = nil
  coroutine.yield()
  progress = math.min(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Global")
  if isGameDev then
    local msgDic = {}
    for name, id in pairs(eMsgEventId) do
      if msgDic[id] then
        error("find duplicated msgId:" .. tostring(id))
      end
      msgDic[id] = true
    end
  end
  coroutine.yield()
  progress = math.min(1, progress + 0.02)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Game.GlobalConfig.UIGlobalConfig")
  coroutine.yield()
  progress = math.min(1, progress + 0.02)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Game.GlobalConfig.NetworkGlobalConfig")
  coroutine.yield()
  progress = math.min(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Game.GlobalConfig.ControllerGlobalConfig")
  coroutine.yield()
  progress = math.min(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  ControllerManager:GetController(ControllerTypeId.Pay, true):TryReqPnSdkPrice()
  PersistentManager:InitManager()
  coroutine.yield()
  progress = math.min(1, progress + 0.02)
  cs_DownloadWindow:UpdateProgress(progress)
  NotifyOfflineManager:InitManager()
  GameSystemInfo.InitDefaultPerformance()
  ControllerManager:GetController(ControllerTypeId.Setting, true):InitSettingData()
  coroutine.yield()
  progress = math.min(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  UIManager:ShowWindowAsync(UIWindowTypeID.Loading, function(window)
    if window ~= nil then
      window:Hide()
    end
  end)
  while UIManager:GetWindow(UIWindowTypeID.Loading) == nil do
    coroutine.yield(nil)
  end
  coroutine.yield()
  progress = 1
  cs_DownloadWindow:UpdateProgress(progress)
  print("first load complete,start game...")
  TimerManager:Start()
  UpdateManager:Start()
  NetworkManager:InitNetwork()
  ControllerManager:GetController(ControllerTypeId.Login, true):FirstGameStart(function()
    cs_DownloadWindow:Dispose()
    cs_DownloadWindow = nil
    package.loaded.FirstAsyncLoader = nil
  end)
end

function FirstAsyncLoader.StartFirstLoad()
  CS.GlobalRegister.StartCoroutine(xlua_util.cs_generator(FirstAsyncLoader.LoadFunc))
end

return FirstAsyncLoader
