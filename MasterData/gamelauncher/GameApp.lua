local Main = require("GameScript.Main")
local delayMuteAudioFrame = -1
local delayUnmuteAudioFrame = -1

function Awake()
  print("lua Awake...")
  Main.RunStartup()
end

function Start()
end

function Update()
  if Main.Instance then
    Main.Instance:Update()
  end
end

function LateUpdate()
  if Main.Instance then
    Main.Instance:LateUpdate()
  end
  if -1 ~= delayMuteAudioFrame then
    delayMuteAudioFrame = delayMuteAudioFrame - 1
    if -1 == delayMuteAudioFrame then
      CS.AkSoundEngine.Suspend(true)
    end
  end
  if -1 ~= delayUnmuteAudioFrame then
    delayUnmuteAudioFrame = delayUnmuteAudioFrame - 1
    if -1 == delayUnmuteAudioFrame then
      CS.AkUnitySoundEngine.WakeupFromSuspend()
      CS.AkUnitySoundEngine.RenderAudio()
    end
  end
end

function CSSendEvent(eventName, eventValue)
  if not EventMgr.Instance then
    return
  end
  EventMgr.Instance.CSSendEvent:Dispatch(eventName, eventValue)
end

function CSSendEventStr(eventName, eventValue1, eventValue2)
  if not EventMgr.Instance then
    return
  end
  EventMgr.Instance.CSSendEventStr:Dispatch(eventName, eventValue1, eventValue2)
end

function CSAudioEvent(eventName)
  if not EventMgr.Instance then
    return
  end
  EventMgr.Instance.CSAudioEvent:Dispatch(eventName)
end

function OnLowMemory()
  if not Main.Instance then
    return
  end
  Logger.ReportApusInfo("OnLowMemory")
  UIAsyncLoadMgr.Instance:ClearUnusedPanels()
  EventMgr.Instance.OnLowMemory:Dispatch()
  ResGcMgr.Instance:TryGc()
end

function OnTrimMemory(level)
  if level >= 40 then
    OnLowMemory()
  end
end

function OnResume()
  Logger.ReportApusInfo("GameAppOnResume")
  delayMuteAudioFrame = -1
  delayUnmuteAudioFrame = -1
  if not ApplicationUtils.IsWindows() and Main.Instance then
    Main.Instance:OnResume()
  end
  if (ApplicationUtils.IsEditor() or ApplicationUtils.IsWindows()) and AudioManager.Instance and CS.AkUnitySoundEngine.IsInitialized() then
    CS.AkUnitySoundEngine.WakeupFromSuspend()
    CS.AkUnitySoundEngine.RenderAudio()
  end
end

function OnPause()
  Logger.ReportApusInfo("GameAppOnPause")
  if not ApplicationUtils.IsWindows() and Main.Instance then
    Main.Instance:OnPause()
  end
  if AudioManager.Instance and ApplicationUtils.IsIOS() and ApplicationUtils.is_tishen_pcode() then
    print("Wakeup from suspend In BackGround")
    if CS.AkUnitySoundEngine.IsInitialized() then
      CS.AkUnitySoundEngine.WakeupFromSuspend()
      CS.AkUnitySoundEngine.RenderAudio()
    end
  elseif ApplicationUtils.IsEditor() or ApplicationUtils.IsWindows() then
    if AudioManager.Instance and CS.AkUnitySoundEngine.IsInitialized() then
      if _IsMuteInBackGround() then
        delayMuteAudioFrame = 1
        delayUnmuteAudioFrame = -1
      else
        delayMuteAudioFrame = -1
        delayUnmuteAudioFrame = 1
      end
    else
      delayMuteAudioFrame = -1
      delayUnmuteAudioFrame = -1
    end
  end
end

function _IsMuteInBackGround()
  if not SettingManager or not SettingManager.Instance then
    return
  end
  local windowNotFocusVoice = SettingManager.Instance:GetSettingData(CommonDefine.SettingUniqueName.WindowNotFocusVoice)
  return "Mute" == windowNotFocusVoice
end

function OnDestroy()
  Main.Destroy()
end

function OnApplicationQuit()
  OnDestroy()
end
