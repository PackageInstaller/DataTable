require("OOP")
CS.UnityEngine.Screen.sleepTimeout = CS.UnityEngine.SleepTimeout.NeverSleep
local UpdateUtils = require("UpdateUtils")
local isDebug = CS.FrameWork.Z1Const.IsDebugMode() or UpdateUtils.__GetIsDebugModeFromDebugFile()
CS.UnityEngine.Debug.unityLogger.logEnabled = isDebug
local ApusUpdateComp = require("ApusUpdateComp")
local Apus_Error_Event_Name = "[enter_game_step][update_error] {step}"
local UpdateManager = require("UpdateManager")
local Language = require("Lang.Language")
local UILangPanel = require("UI.UILangPanel")

function RecordCSharpError(content, stackTrace)
  if not content or ApusUpdateComp.errorFilterMap and ApusUpdateComp.errorFilterMap[content] then
    return
  end
  local errMsg = content .. [[

[StackTrace]:
]] .. stackTrace
  print(errMsg)
  if ApusUpdateComp.Inited then
    ApusUpdateComp.errorFilterMap = ApusUpdateComp.errorFilterMap or {}
    ApusUpdateComp.errorFilterMap[content] = true
    ApusUpdateComp.UploadApusError(Apus_Error_Event_Name, "HotUpdateError", {errMsg = errMsg})
  end
end

local isInitUpdateMgr

function Awake()
  print("lua Awake...")
  Language.Init()
  
  local function _InitUpdateManager()
    if isInitUpdateMgr then
      return
    end
    UpdateManager:OnInit()
    isInitUpdateMgr = true
  end
  
  if Language.HasClientCacheLang then
    _InitUpdateManager()
  elseif not UILangPanel:Create(function()
    _InitUpdateManager()
    UILangPanel:Destroy()
  end) or not UILangPanel:Open() then
    _InitUpdateManager()
  end
end

function Update()
  if isInitUpdateMgr then
    UpdateManager:OnUpdate()
  end
end

function OnDestroy()
  print("lua OnDestroy...")
  if isInitUpdateMgr then
    UpdateManager:OnDestroy()
  end
end
