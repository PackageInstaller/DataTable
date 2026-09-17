function __G_ERROR_TRACK(err)
  C_LuaUtility.ErrorTrack(debug.traceback(err, 2))
end

__G_UNITY_EDITOR = false
__G_LANGUAGE_LIST = {
  "SC",
  "TC",
  "EN",
  "JP"
}
IS_EDITOR = CS.UnityEngine.Application.isEditor
IS_DEV_BUILD = CS.UnityEngine.Debug.isDebugBuild
