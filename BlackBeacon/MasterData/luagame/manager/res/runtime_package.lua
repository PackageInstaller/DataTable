local Json = require("utils.json")
local PathDefine = require("utils.path_define")
local CommonDefine = require("cs_share.common_define")
local M = {}

function M.init()
  M.v_version_tbl = {}
  M.v_files = {}
end

function M.reset()
  if CSHelper.IsFileExist(PathDefine.local_version_file) then
    local version_info = Json.decode(CSHelper.ReadFileText(PathDefine.local_version_file))
    M.v_version_tbl = version_info.Versions or {}
  else
    M.v_version_tbl = {}
    if not UNITY_EDITOR then
      Log.Error("本地没有update_version_md5文件！")
    end
  end
  M.v_files = {}
  local bundle_version_tbl = UnityEngine.Resources.Load(PathDefine.bundle_version_file, typeof(UnityEngine.TextAsset))
  if bundle_version_tbl and bundle_version_tbl.text then
    local decrypt_bytes = CS.Game.CryptoHelper.DESDecrypt(bundle_version_tbl.text)
    local bundle_version_info = Json.decode(decrypt_bytes)
    M.v_bundle_version_tbl = bundle_version_info.Versions or {}
  else
    M.v_bundle_version_tbl = {}
  end
end

function M.get_bundle_path(bundle)
  local update_dir_bundle = PathDefine.update_dir .. bundle
  local package_dir_bundle = PathDefine.package_dir .. bundle
  if M.v_version_tbl[bundle] then
    if M.v_files[bundle] then
      return update_dir_bundle
    elseif M.v_files[bundle] == false then
      return package_dir_bundle
    else
      local exist = CSHelper.IsFileExist(update_dir_bundle)
      M.v_files[bundle] = exist
      if exist then
        return update_dir_bundle
      else
        return package_dir_bundle
      end
    end
  else
    return package_dir_bundle
  end
end

function M.get_bundle_exist(bundle)
  if M.v_version_tbl[bundle] then
    return true
  end
  if M.v_bundle_version_tbl[bundle] then
    return true
  end
  return false
end

function M.get_video_path(file)
  local result_file
  local str_array = Util.split_str(file, ".")
  local language = string.lower(Global.curr_text_language)
  local platform = "phone"
  if not str_array or 2 ~= #str_array then
  else
    result_file = Util.format_str("{1}_{2}.{3}", str_array[1], language, str_array[2])
    if M.get_bundle_exist(result_file) then
    else
      if UNITY_EDITOR or UNITY_STANDALONE_WIN then
        platform = "pc"
      end
      result_file = Util.format_str("{1}_{2}.{3}", str_array[1], platform, str_array[2])
      if M.get_bundle_exist(result_file) then
      else
        result_file = Util.format_str("{1}_{2}_{3}.{4}", str_array[1], platform, language, str_array[2])
        if not M.get_bundle_exist(result_file) then
          result_file = nil
        end
      end
    end
  end
  result_file = result_file or file
  return M.get_bundle_path(result_file)
end

function M.get_sound_path(bundle, cue_name)
  local update_dir_bundle = PathDefine.update_dir .. bundle
  local package_dir_bundle = PathDefine.package_sound_dir .. bundle
  local cn_bundle = bundle
  local language = Global.curr_language
  local is_story_voice = false
  if Global and Global.sound_mgr then
    is_story_voice = Global.sound_mgr:is_story_voice(bundle)
  end
  if cue_name then
    local sound_cfg = ShareRes.get_sound_cfg(cue_name)
    if sound_cfg and sound_cfg.BuddyId and 0 ~= sound_cfg.BuddyId then
      language = CharacterMgr:get_buddy_cv_language(sound_cfg.BuddyId)
    elseif is_story_voice then
      language = Global.curr_story_cv_language
    end
  elseif is_story_voice then
    language = Global.curr_story_cv_language
  end
  bundle = string.lower(Path.get_file_language_name(bundle, language))
  update_dir_bundle = PathDefine.update_dir .. bundle
  package_dir_bundle = PathDefine.package_sound_dir .. bundle
  if not CSHelper.IsFileExist(update_dir_bundle) and not CSHelper.IsFileExist(package_dir_bundle) then
    bundle = cn_bundle
    update_dir_bundle = PathDefine.update_dir .. cn_bundle
    package_dir_bundle = PathDefine.package_sound_dir .. cn_bundle
  end
  if M.v_version_tbl[bundle] then
    if M.v_files[bundle] then
      return update_dir_bundle
    elseif M.v_files[bundle] == false then
      return package_dir_bundle
    else
      local exist = CSHelper.IsFileExist(update_dir_bundle)
      M.v_files[bundle] = exist
      if exist then
        return update_dir_bundle
      else
        return package_dir_bundle
      end
    end
  else
    return package_dir_bundle
  end
end

return M
