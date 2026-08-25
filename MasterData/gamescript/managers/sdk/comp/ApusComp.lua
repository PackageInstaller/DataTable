local Component = require("Ecs.Component")
local IUpdater = require("Ecs.IUpdater")
local System = require("System.System")
local Logger = require("Utility.Logger")
local PerformanceManager = require("Managers.PerformanceManager")
local Apus = require("ejoysdk_lua.apm-sdk-lua.apus")
local SdkMgr = require("Managers.Sdk.SdkMgr")
local UnityTime = CS.UnityEngine.Time
local ApusComp, Super = System.NewClass("ApusComp", Component, IUpdater)

function ApusComp:ctor()
  Super.ctor(self)
end

function ApusComp:Awake()
  Super.Awake(self)
  Apus.register_module("z1_apus", {
    init = System.fn(self, self.InitApusSDK)
  })
end

function ApusComp:OnDestroy()
  Super.OnDestroy(self)
end

function ApusComp:Update(deltaTime)
  if not SdkMgr.Instance:IsSdkLogin() then
    return
  end
  local isLoading = BattleManager.Instance.isBattleResReady
  if not bg.battleScene or not isLoading then
    Apus.engine_stats_update_delta_time(UnityTime.unscaledDeltaTime)
  end
end

function ApusComp:InitApusSDK()
  Logger.Info("Apus.初始化设置天燕SDK")
  Apus.set_namespace("Z1")
  local buildVersion = CS.FrameWork.Z1Const.GetBuildVerion()
  Logger.Info("Apus.构建版本号：", buildVersion)
  Apus.set_game_version(buildVersion or "no_game_version")
  Apus.set_static_label("custom_static_label_key", "custom_static_label_value")
  Apus.set_login_func(function()
    local quality_level = 1
    Apus.set_quality_level(quality_level)
  end)
  Apus.add_dynamic_label("test_label", function(i)
    return os.time() % 86400 + i
  end, 5)
  Apus.set_scene_func(function()
    local scene = "TestScene"
    return scene
  end)
  Apus.set_position_func(function()
    local pos_x, pos_y, pos_z = 0, 0, 0
    return pos_x, pos_y, pos_z
  end)
  local custom_stats = Apus.new_custom_stats("custom_stats", "Z1")
  custom_stats:set_calc_func(function()
    local s = {}
    return s
  end)
  Apus.set_engine("unity", function()
    local fps
    local isLoadingBattleScene = BattleManager.Instance.isBattleResReady
    if not bg.battleScene or not isLoadingBattleScene then
      fps = PerformanceManager.Instance:GetFPS()
    end
    local engine_data = {fps = fps}
    Logger.Debug("#Apus.刷新Unity引擎性能数据", engine_data.fps)
    return engine_data
  end)
  Logger.Info("Apus.初始化天燕Logger对象")
  local ApusLogger = require("ejoysdk_lua.apm-sdk-lua.log.init")
  ApusLogger.config({use_simple_serialize = true, stack_level = 2})
  Logger.SetApusLogger(ApusLogger)
  Logger.ReportCacheLogs()
end

return ApusComp
