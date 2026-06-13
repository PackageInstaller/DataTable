local CSResLoader = CS.ResLoader
local M = {}
local BASE_PATH = "assets/product/"
local Editor_BASE_PATH = "Assets/Product/"
local MATERIAL_BASE_PATH = BASE_PATH .. "material/"
local Application = UnityEngine.Application
local CommonDefine = require("cs_share.common_define")
local file_language_name_list = {}
local sound_folder_list = {
  InitSound = "InitSound",
  BaseSound = "BaseSound",
  OtherSound = "OtherSound"
}

function M.get_res_path(res)
  return CSResLoader.GetFullPath(res)
end

function M.get_full_prefab_path(prefab)
  return BASE_PATH .. prefab
end

function M.get_language_full_prefab_path(prefab)
  if Global.curr_text_language == Config.CommonDefine.LANGUAGE.CN then
    return BASE_PATH .. "ui/" .. prefab
  end
  local result_path = BASE_PATH .. "ui_" .. Global.curr_text_language .. "/" .. prefab
  if not M.is_file_exist(result_path, UnityGameObject) then
    if Global.is_need_check_default then
      result_path = BASE_PATH .. "ui_" .. Global.default_folder_name .. "/" .. prefab
      if not M.is_file_exist(result_path, UnityGameObject) then
        result_path = BASE_PATH .. "ui/" .. prefab
      end
    else
      result_path = BASE_PATH .. "ui/" .. prefab
    end
  end
  return result_path
end

function M.get_full_prefab_path_with_language(path, language)
  local ui_prefix = "ui"
  if language ~= Config.CommonDefine.LANGUAGE.CN then
    ui_prefix = ui_prefix .. "_" .. language
  end
  local result_path = ui_prefix .. "/" .. path
  local full_path = Path.get_full_prefab_path(result_path)
  if not Path.is_file_exist(full_path) then
    return nil
  end
  return result_path
end

function M.get_asset_path(asset)
  return CSResLoader.GetFullPath(asset .. ".asset")
end

function M.get_spine_name(res_name)
  if Global.curr_text_language == Config.CommonDefine.LANGUAGE.CN then
    return res_name
  end
  local result_name = res_name .. "_" .. Global.curr_text_language
  local res_path = Path.get_res_path(result_name)
  if not M.is_file_exist(res_path) then
    if SDKType == Config.SDK_TYPE.HIVE_SDK then
      result_name = res_name .. "_EN"
      res_path = Path.get_res_path(result_name)
    else
      return res_name
    end
    if not M.is_file_exist(res_path) then
      return res_name
    end
  end
  return result_name
end

function M.get_image_icon_path(path)
  if Global.curr_text_language == Config.CommonDefine.LANGUAGE.CN then
    return BASE_PATH .. "ui/images/" .. path .. ".png"
  end
  local result_path = BASE_PATH .. "ui_" .. string.lower(Global.curr_text_language) .. "/images/" .. path .. ".png"
  if not M.is_file_exist(result_path, UnityEngine.Sprite) then
    if Global.is_need_check_default then
      result_path = BASE_PATH .. "ui_" .. string.lower(Global.default_folder_name) .. "/images/" .. path .. ".png"
      if M.is_file_exist(result_path, UnityEngine.Sprite) then
        return result_path
      end
    end
    if SDKType == Config.SDK_TYPE.HIVE_SDK then
      result_path = BASE_PATH .. "ui_en" .. "/images/" .. path .. ".png"
    else
      return BASE_PATH .. "ui/images/" .. path .. ".png"
    end
    if not M.is_file_exist(result_path, UnityEngine.Sprite) then
      return BASE_PATH .. "ui/images/" .. path .. ".png"
    end
  end
  return result_path
end

function M.get_texture_path(path)
  if Global.curr_text_language == Config.CommonDefine.LANGUAGE.CN then
    return BASE_PATH .. "ui/texture/" .. path .. ".png"
  end
  local result_path = BASE_PATH .. "ui_" .. string.lower(Global.curr_text_language) .. "/texture/" .. path .. ".png"
  if not M.is_file_exist(result_path, UnityEngine.Sprite) then
    if Global.is_need_check_default then
      result_path = BASE_PATH .. "ui_" .. string.lower(Global.default_folder_name) .. "/texture/" .. path .. ".png"
      if M.is_file_exist(result_path, UnityEngine.Sprite) then
        return result_path
      end
    end
    if SDKType == Config.SDK_TYPE.HIVE_SDK then
      result_path = BASE_PATH .. "ui_en" .. "/texture/" .. path .. ".png"
    else
      return BASE_PATH .. "ui/texture/" .. path .. ".png"
    end
    if not M.is_file_exist(result_path, UnityEngine.Sprite) then
      return BASE_PATH .. "ui/texture/" .. path .. ".png"
    end
  end
  return result_path
end

function M.get_image_atlas_path(path)
  return BASE_PATH .. "ui/images/atlas/" .. path .. ".spriteatlas"
end

function M.get_ui_font_path(path)
  return CSResLoader.GetFullPath(path)
end

function M.get_mat_path(mat)
  return CSResLoader.GetFullPath(mat .. ".mat")
end

function M.get_editor_sound_path(file, cue_name)
  local split = Util.split_str(file, ".")
  local is_usm = split and 2 == #split and "usm" == split[2]
  local path = M.get_editor_sound_language_path(file, cue_name, is_usm)
  if is_usm and not path then
    local platform = "phone"
    if UNITY_EDITOR or UNITY_STANDALONE_WIN then
      platform = "pc"
    end
    path = M.get_editor_sound_language_path(Util.format_str("{1}_{2}.{3}", split[1], platform, split[2]), cue_name, false)
  end
  return path
end

function M.get_editor_sound_language_path(file_name, cue_name, ignore_log)
  local result_path
  local sound_cfg = ShareRes.get_sound_cfg(cue_name)
  local is_story_voice = false
  if Global and Global.sound_mgr then
    is_story_voice = Global.sound_mgr:is_story_voice(file_name)
  end
  if sound_cfg or is_story_voice then
    if sound_cfg and sound_cfg.BuddyId and 0 ~= sound_cfg.BuddyId then
      local language = CharacterMgr:get_buddy_cv_language(sound_cfg.BuddyId)
      local cv_language_name = M.get_file_language_name(file_name, language)
      result_path = M.try_get_sound_path(cv_language_name, language)
      return result_path
    end
    if is_story_voice then
      local language = Global.curr_story_cv_language
      local cv_language_name = M.get_file_language_name(file_name, language)
      result_path = M.try_get_sound_path(cv_language_name, language)
      return result_path
    end
  end
  local language = Global.curr_language
  local split = Util.split_str(file_name, ".")
  if split and 2 == #split and "usm" == split[2] then
    language = Global.curr_text_language
  end
  local language_file_name = M.get_file_language_name(file_name, language)
  result_path = M.try_get_sound_path(language_file_name, language)
  if result_path then
    return result_path
  end
  result_path = M.try_get_sound_path(file_name)
  if result_path then
    return result_path
  end
  local sound_path = Application.dataPath .. "/../../Sound/" .. file_name
  if CSHelper.IsFileExist(sound_path) then
    return sound_path
  end
  if not ignore_log then
    Log.Error(language, "Sound文件夹下未找到文件：", language_file_name, "也没有找到", file_name, debug.traceback())
  end
  return nil
end

function M.get_file_language_name(file_name, language)
  if not file_language_name_list[file_name] then
    file_language_name_list[file_name] = {}
  end
  local language_file_name = file_language_name_list[file_name][language]
  if not language_file_name then
    local strs = Util.split_str(file_name, ".")
    language_file_name = Util.format_str("{1}_{2}.{3}", strs[1], string.lower(language), strs[2])
    file_language_name_list[file_name][language] = language_file_name
  end
  return language_file_name
end

function M.try_get_sound_path(file_name, language)
  local front_path = Util.format_str("{1}/../../Sound", Application.dataPath)
  local path
  for _, folder_name in pairs(sound_folder_list) do
    if folder_name == sound_folder_list.OtherSound then
      local other_path = Util.format_str("{1}/{2}", front_path, folder_name)
      local paths = CSHelper.GetDirectories(other_path)
      for i = 0, paths.Length - 1 do
        if language then
          path = Util.format_str("{1}/{2}/{3}", paths[i], language, file_name)
        else
          path = Util.format_str("{1}/{2}", paths[i], file_name)
        end
        if CSHelper.IsFileExist(path) then
          return path
        end
      end
    else
      if language then
        path = Util.format_str("{1}/{2}/{3}/{4}", front_path, folder_name, language, file_name)
      else
        path = Util.format_str("{1}/{2}/{3}", front_path, folder_name, file_name)
      end
      if CSHelper.IsFileExist(path) then
        return path
      end
    end
  end
  return nil
end

function M.is_file_exist(path, type)
  if not Game_AssetBundle then
    local obj = CS.ResLoader.LoadRes(path, typeof(type or UnityGameObject))
    if Util.is_nil(obj) then
      return false
    end
  elseif not Global.res_mgr:is_res_exist(path) then
    return false
  end
  return true
end

return M
