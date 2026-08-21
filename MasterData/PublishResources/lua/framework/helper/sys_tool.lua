_enum("PlayerSex", {
  SEX_Error = -1,
  SEX_Male = 0,
  SEX_Female = 1,
  SEX_Both = 2
})
require("h3dmobile_info")
local RuntimePlatform = UnityEngine.RuntimePlatform

function GetPlatformOS()
  if PLATFORM == RuntimePlatform.Android then
    return ClientRuntimeOS.CRO_ANDROID
  elseif PLATFORM == RuntimePlatform.IPhonePlayer or PLATFORM == RuntimePlatform.OSXPlayer then
    return ClientRuntimeOS.CRO_IOS
  elseif PLATFORM == RuntimePlatform.WindowsPlayer then
    return ClientRuntimeOS.CRO_PC
  else
    return ClientRuntimeOS.CRO_EDITOR
  end
end

function IsUnityEditor()
  return PLATFORM == RuntimePlatform.WindowsEditor or PLATFORM == RuntimePlatform.OSXEditor or PLATFORM == RuntimePlatform.LinuxEditor
end

function GetInternetReachability()
  local reach_ability = UnityEngine.Application.internetReachability
  if reach_ability == UnityEngine.NetworkReachability.NotReachable then
    return 0
  elseif reach_ability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
    return 1
  else
    return 2
  end
end

function IsIos()
  return PLATFORM == RuntimePlatform.IPhonePlayer or PLATFORM == RuntimePlatform.OSXPlayer or PLATFORM == RuntimePlatform.OSXEditor
end

function IsAndroid()
  return GetPlatformOS() == ClientRuntimeOS.CRO_ANDROID
end

function IsPc()
  return GetPlatformOS() == ClientRuntimeOS.CRO_PC
end
