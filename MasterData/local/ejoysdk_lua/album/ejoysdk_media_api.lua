local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local OSS_API = require("ejoysdk_lua.ejoysdk_oss")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local holo_api = BASE_API:New("holo")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local TAG = "album#ejoysdk_media_api"
local M = {}
M.INPUT_TYPE = OSS_API.INPUT_TYPE

function M.get_oss_policy(media_group, cb)
  local headers = {}
  local body = {
    media_group = media_group,
    support_sign_version = OSS_API.SUPPORT_SIGN_VERSION
  }
  local opt = {use_moment_token = true}
  holo_api:post("/media/apply_oss_policy", headers, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "get_oss_policy request http fail")
      cb(false, ...)
    end
  end)
end

function M.upload_file(input_file, input_type, media_type, oss_params, cb)
  OSS_API.upload_file(input_file, input_type, media_type, oss_params, cb)
end

function M.commit_media(media_list, cb)
  local body = {media_list = media_list}
  local opt = {use_moment_token = true}
  holo_api:post("/media/commit_media", {}, body, opt, function(succ, ...)
    if succ then
      if cb then
        local resp = (...)
        cb(true, resp and resp.result_list)
      end
    elseif cb then
      cb(false, ...)
    end
  end)
end

function M.upload_oss_with_group(media_name, media_group, input_file, input_type, media_type, cb)
  if nil == media_name or nil == media_group then
    cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, "upload fail, media_name or media_group should not be nil")
    return
  end
  M.get_oss_policy(media_group, function(succ, ...)
    if not succ then
      cb(false, ...)
      return
    end
    local oss_params = (...)
    local ticket_id = oss_params and oss_params.ticket_id
    if not ticket_id then
      cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, "upload fail, oss_policy return nil or ticket_id is nil")
      return
    end
    OSS_API.upload_file(input_file, input_type, media_type, oss_params, function(oss_succ, ...)
      if not oss_succ then
        cb(false, ...)
        return
      end
      local resp = (...)
      if resp then
        local u_media_list = {}
        local media_item_upload_result = {
          media_name = media_name,
          ticket_id = oss_params.ticket_id,
          media_group = media_group
        }
        table.insert(u_media_list, media_item_upload_result)
        M.commit_media(u_media_list, function(commit_suc, ...)
          if commit_suc then
            local result_list = (...)
            if result_list and #result_list > 0 then
              local first_result = result_list[1]
              if first_result and 0 == first_result.code then
                cb(true, first_result)
              else
                cb(false, first_result and first_result.code or -1, first_result and first_result.message or "")
              end
            else
              cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, "upload fail, result_list is nil")
            end
          else
            cb(false, ...)
          end
        end)
      else
        cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, "upload fail, oss_result is nil")
      end
    end)
  end)
end

function M.get_media_base_url()
  local base_url = EGC.get_base_url_for_service("media-cdn")
  return base_url
end

function M.get_image_full_url(media_key, suffix)
  if not media_key then
    return nil
  end
  local base_url = M.get_media_base_url()
  if not base_url then
    return nil
  end
  if suffix then
    return base_url .. "/" .. media_key .. suffix
  else
    return base_url .. "/" .. media_key
  end
end

function M.find_media(media_ids, cb)
  if not media_ids or media_ids and 0 == #media_ids then
    if cb then
      cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "media_ids is nil or invalid")
    end
    return
  end
  local body = {media_ids = media_ids}
  local opt = {use_moment_token = true}
  local base_url = tostring(M.get_media_base_url()) .. "/"
  holo_api:post("/media/find_media", {}, body, opt, function(succ, ...)
    if succ then
      if cb then
        local resp = (...)
        if resp and resp.result_list and next(resp.result_list) then
          for _, media_item in pairs(resp.result_list) do
            if media_item.media_data then
              media_item.media_data._sdk_ori_key = media_item.media_data.key
              local key = base_url .. tostring(media_item.media_data.key)
              media_item.media_data.key = key
            end
          end
        end
        cb(true, resp.result_list)
      end
    elseif cb then
      cb(false, ...)
    end
  end)
end

return M
