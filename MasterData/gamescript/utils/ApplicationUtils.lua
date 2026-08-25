local WindowsEditor = CS.UnityEngine.RuntimePlatform.WindowsEditor
local WindowsPlayer = CS.UnityEngine.RuntimePlatform.WindowsPlayer
local Platform = CS.UnityEngine.Application.platform
local EnableRenderFeature = CS.Z1Client.LuaCSharpUtil.EnableRenderFeature
local OnWriteGameFile = CS.Framework.AssetLoadUtil.OnWriteGameFile
local WriteFile = CS.Framework.AssetLoadUtil.WriteFile
local ApplicationUtils = {
  __GamePlatformCode = string.upper(Utils.GetGamePlatform() or ""),
  __IsEditor = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor,
  __LoginWay = nil,
  __PublishRegion = nil,
  __IsOpenGm = nil
}
local LOCAL_PLATFORM = {
  P11258 = true,
  P11104 = true,
  P11439 = true
}
local PUBLISH_PLATFORM = {
  P11441 = true,
  P11222 = true,
  P11103 = true
}
local Tishen_PLATFORM = {P11223 = true, P11440 = true}
local OverSea_PLATFORM = {
  "P11221",
  "P11222",
  "P11223",
  "P11439",
  "P11440",
  "P11441"
}

function ApplicationUtils.get_oversea_platform_code()
  return OverSea_PLATFORM
end

function ApplicationUtils.is_debug_mode()
  if ApplicationUtils.__IsDebugMode == nil then
    ApplicationUtils.__IsDebugMode = ApplicationUtils.__IsEditor or CS.FrameWork.Z1Const.IsDebugMode()
  end
  return ApplicationUtils.__IsDebugMode
end

function ApplicationUtils.is_editor_mode()
  return ApplicationUtils.__IsEditor
end

function ApplicationUtils.OpenURL(url)
  if CS.Z1Client.LuaBehaviour.supportOpenUrl then
    CS.Z1Client.LuaBehaviour.OpenUrl(url)
  else
    CS.UnityEngine.Application.OpenURL(url)
  end
end

function ApplicationUtils.is_open_gm()
  if ApplicationUtils.__IsOpenGm == nil then
    local isOpenGm = CS.FrameWork.Z1Const.IsOpenGm and CS.FrameWork.Z1Const.IsOpenGm() or false
    if ApplicationUtils.is_publish_pcode() then
      isOpenGm = false
    end
    if ApplicationUtils.is_editor_mode() then
      isOpenGm = true
    end
    ApplicationUtils.__IsOpenGm = isOpenGm
  end
  return ApplicationUtils.__IsOpenGm
end

function ApplicationUtils.ExitGame()
  Main.DisableNextTick()
  CS.Z1Client.LuaCSharpUtil.QuitApplication()
end

function ApplicationUtils.is_innet_pcode()
  local platform_code = ApplicationUtils.__GamePlatformCode
  if platform_code then
    return LOCAL_PLATFORM[platform_code]
  end
end

function ApplicationUtils.is_publish_pcode()
  local platform_code = ApplicationUtils.__GamePlatformCode
  if platform_code then
    return PUBLISH_PLATFORM[platform_code]
  end
end

function ApplicationUtils.is_tishen_pcode()
  local platform_code = ApplicationUtils.__GamePlatformCode
  if platform_code then
    return Tishen_PLATFORM[platform_code]
  end
end

function ApplicationUtils.get_login_way()
  if ApplicationUtils.__LoginWay == nil then
    if CS.FrameWork.Z1Const.GetLoginWay then
      ApplicationUtils.__LoginWay = CS.FrameWork.Z1Const.GetLoginWay()
    else
      ApplicationUtils.__LoginWay = "None"
    end
  end
  return ApplicationUtils.__LoginWay
end

function ApplicationUtils.get_publish_region()
  if ApplicationUtils.__PublishRegion == nil and CS.FrameWork.Z1Const.GetPublishRegion then
    ApplicationUtils.__PublishRegion = CS.FrameWork.Z1Const.GetPublishRegion()
  end
  return ApplicationUtils.__PublishRegion
end

function ApplicationUtils.IsWindowsOrEditor()
  return Platform == WindowsEditor or Platform == WindowsPlayer
end

function ApplicationUtils.IsWindows()
  return Platform == WindowsPlayer
end

function ApplicationUtils.IsEditor()
  return Platform == WindowsEditor
end

function ApplicationUtils.IsIOS()
  return CS.Z1Client.General.OSDef.RunOS == CS.Z1Client.General.OSDef.IOS
end

function ApplicationUtils.IsAndroid()
  return CS.Z1Client.General.OSDef.RunOS == CS.Z1Client.General.OSDef.Android
end

function ApplicationUtils.CopyFile(src, dst)
  local srcInfo = CS.System.IO.FileInfo(src)
  if not srcInfo.Exists then
    return
  end
  local src_file = io.open(src, "rb")
  if not src_file then
    return
  end
  local dst_file = io.open(dst, "wb")
  if not dst_file then
    src_file:close()
    return
  end
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
end

function ApplicationUtils.SetFPS(fps)
  fps = tonumber(fps) or 30
  Logger.ForcePrint("ApplicationUtils.SetFPS", fps)
  if fps > 0 then
    CS.UnityEngine.Application.targetFrameRate = fps
    CS.UnityEngine.QualitySettings.vSyncCount = 0
  else
    Logger.ForcePrint("ApplicationUtils.SetFPS")
    CS.UnityEngine.Application.targetFrameRate = -1
    CS.UnityEngine.QualitySettings.vSyncCount = 1
  end
end

function ApplicationUtils.SupportEnableRenderFeature()
  return nil ~= EnableRenderFeature
end

function ApplicationUtils.EnableRenderFeature(name, enabled)
  if not EnableRenderFeature then
    return
  end
  EnableRenderFeature(0, name, enabled)
end

function ApplicationUtils.SetOutlineEnable(enabled)
  ApplicationUtils.EnableRenderFeature("OutLine", enabled)
end

function ApplicationUtils.OnWriteGameFile(file, content)
  local ret, _ = pcall(OnWriteGameFile, file, content)
  if not ret then
    Alert.Show("DiskIsFullOrViolation")
  end
end

function ApplicationUtils.WriteFile(content, file)
  local ret, _ = pcall(WriteFile, content, file)
  if not ret then
    Alert.Show("DiskIsFullOrViolation")
  end
end

return ApplicationUtils
