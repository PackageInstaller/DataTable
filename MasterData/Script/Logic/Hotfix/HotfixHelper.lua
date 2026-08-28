local HotfixHelper = {}
HotfixHelper.HasCleanIOSHotfixTemp = false

function HotfixHelper.IsIOS()
  return GameSetting ~= nil and GameSetting.platform == "IOS"
end

function HotfixHelper.CleanIOSHotfixTemp()
  if HotfixHelper.HasCleanIOSHotfixTemp then
    return true
  end
  if not HotfixHelper.IsIOS() then
    return false
  end
  HotfixHelper.HasCleanIOSHotfixTemp = true
  local success, err = CommonHelper.SafeCallCsFunc(function()
    CS.DownloadHelper.DeleteTempFolder()
  end)
  if success == true then
    return true
  end
  return false
end

return HotfixHelper
