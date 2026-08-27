local pathMd5 = ""
if isEditorMode then
  pathMd5 = CS.CommonUtility.GetStrMd5(CS.UnityEngine.Application.dataPath)
end
local PlayerPrefsConsts = {
  ServerId = pathMd5 .. "ServerId",
  UserName = pathMd5 .. "UserName",
  UserPassword = pathMd5 .. "UserPassword",
  CustomServerMode = pathMd5 .. "CustomServerMode",
  CustomServerStr = pathMd5 .. "CustomServerStr",
  DefaultPerformanceId = "DefaultPerformanceId",
  PreGuideDefaultPerformanceId = "PreGuideDefaultPerformanceId"
}
return PlayerPrefsConsts
