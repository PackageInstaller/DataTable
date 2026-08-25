local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local OSS_API = require("ejoysdk_lua.ejoysdk_oss")
local holo_api = BASE_API:New("holo")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local TAG = "album#ejoysdk_album_api"
local M = {}
M.INPUT_TYPE = OSS_API.INPUT_TYPE
M.ERR_TYPE = {UPLOAD = "upload", COMMIT = "commit"}

local function get_oss_policy(group_id, media_type, cb)
  E.LOG.debug(TAG, "start get_oss_policy")
  local opt = {use_moment_token = true}
  local body = {
    group_id = group_id,
    media_type = media_type,
    support_sign_version = OSS_API.SUPPORT_SIGN_VERSION
  }
  holo_api:post("/photo_album/apply_upload_policy", {}, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "get_oss_policy request http fail")
      cb(false, ...)
    end
  end)
end

function M.upload_oss(media_content_arr, cb)
  local size = #media_content_arr
  local upload_over_count = 0
  local upload_result = {
    result_list = {},
    all_succ = true
  }
  for index, media in pairs(media_content_arr) do
    local media_item_upload_result = {
      data = {
        name = media.name,
        media_type = media.media_type,
        group_id = media.group_id,
        info = media.info
      }
    }
    table.insert(upload_result.result_list, index, media_item_upload_result)
    
    local function item_upload_callback(upload_media_result)
      upload_over_count = upload_over_count + 1
      if 0 ~= upload_media_result.code then
        upload_media_result.err_type = M.ERR_TYPE.UPLOAD
        upload_result.all_succ = false
      end
      if upload_over_count == size then
        E.LOG.debug(TAG, "all photo upload succ")
        E.log(upload_result)
        cb(upload_result)
      end
    end
    
    get_oss_policy(media.group_id, media.media_type, function(succ, ...)
      if succ then
        local oss_params = (...)
        media_item_upload_result.data.ticket_id = oss_params.ticket_id
        OSS_API.upload_file(media.media, media.media_input_type, OSS_API.FILE_TYPE[media.media_type], oss_params, function(upload_succ, ...)
          if upload_succ then
            media_item_upload_result.code = 0
          else
            local code, msg = ...
            media_item_upload_result.code = code
            media_item_upload_result.message = msg
          end
          item_upload_callback(media_item_upload_result)
        end)
      else
        local code, msg = ...
        media_item_upload_result.code = code
        media_item_upload_result.message = msg
        item_upload_callback(media_item_upload_result)
      end
    end)
  end
end

function M.commit_media_infos(upload_result, cb)
  local result_list = upload_result.result_list
  local upload_succ_list = {}
  local ticket_index_map = {}
  for index, item_upload_result in pairs(result_list) do
    local ticket_id = item_upload_result.data.ticket_id
    if ticket_id then
      ticket_index_map[ticket_id] = index
    end
    if 0 == item_upload_result.code then
      table.insert(upload_succ_list, item_upload_result.data)
    end
  end
  if next(upload_succ_list) then
    local body = {photos = upload_succ_list}
    local opt = {use_moment_token = true}
    holo_api:post("/photo_album/commit", {}, body, opt, function(succ, ...)
      if succ then
        local commit_result = (...)
        local commit_result_list = commit_result.result_list
        if nil ~= commit_result_list then
          for _, commit_item_result in pairs(commit_result_list) do
            local code = commit_item_result.code
            local commit_photo = commit_item_result.data
            local commit_ticket = commit_photo.ticket_id
            local origin_index = ticket_index_map[commit_ticket]
            result_list[origin_index] = commit_item_result
            if 0 ~= code then
              commit_item_result.err_type = M.ERR_TYPE.COMMIT
              upload_result.all_succ = false
            end
          end
        end
        cb(upload_result)
      else
        local code, msg = ...
        upload_result.all_succ = false
        for _, item_upload_result in pairs(upload_succ_list) do
          item_upload_result.code = code
          item_upload_result.message = msg
          item_upload_result.err_type = M.ERR_TYPE.COMMIT
        end
        cb(upload_result)
      end
    end)
  else
    cb(upload_result)
  end
end

function M.upload_medias(media_content_arr, cb)
  E.LOG.debug(TAG, "start upload_and_commit_media")
  M.upload_oss(media_content_arr, function(upload_result)
    M.commit_media_infos(upload_result, cb)
  end)
end

function M.upload_single_media(media, cb)
  local media_arr = {media}
  M.upload_medias(media_arr, function(upload_result)
    if upload_result and upload_result.result_list and next(upload_result.result_list) then
      local upload_item_result = upload_result.result_list[1]
      if 0 == upload_item_result.code then
        cb(true, upload_item_result.data)
      else
        local code = upload_item_result.code
        local msg = upload_item_result.message
        cb(false, code, msg)
      end
    else
      cb(false, -1, "upload error")
    end
  end)
end

function M.delete_media_infos(media_ids, cb)
  local body = {photo_ids = media_ids}
  local opt = {use_moment_token = true}
  holo_api:post("/photo_album/delete", {}, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "delete album request fail")
      cb(false, ...)
    end
  end)
end

function M.get_album_group(cb)
  local opt = {use_moment_token = true}
  holo_api:post("/photo_album/get_photo_group", {}, {}, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "get photo group request fail")
      cb(false, ...)
    end
  end)
end

local function get_media_base_url()
  local base_url = EGC.get_base_url_for_service("media-cdn")
  return base_url
end

function M.get_media_infos(group_id, size, cursor, thumb_config, cb)
  local base_url = get_media_base_url() .. "/"
  local body = {
    size = size,
    group_id = group_id,
    cursor = cursor
  }
  local opt = {use_moment_token = true}
  holo_api:post("/photo_album/get_photo_list", {}, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      if thumb_config and resp.data and resp.data.list and next(resp.data.list) then
        for _, media_item in pairs(resp.data.list) do
          if media_item.media_data then
            local key = base_url .. media_item.media_data.key
            media_item.media_data.key = key
            if E.Utils.start_with(media_item.media_data.mimeType, "image") then
              local thumb_key = OSS_API.get_thumb_url(key, thumb_config)
              media_item.media_data.thumb_key = thumb_key
            end
          end
        end
      end
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "delete album request fail")
      cb(false, ...)
    end
  end)
end

function M.update_media_info(media_info, cb)
  local opt = {use_moment_token = true}
  local body = {
    name = media_info.name,
    info = media_info.info,
    id = media_info.id
  }
  holo_api:post("/photo_album/update", {}, body, opt, function(succ, ...)
    if succ then
      cb(true)
    else
      cb(false, ...)
    end
  end)
end

function M.get_media_status(photo_ids, cb)
  local opt = {use_moment_token = true}
  local body = {photo_ids = photo_ids}
  holo_api:post("/photo_album/get_photos_status", {}, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp)
    else
      E.LOG.debug(TAG, "get album status request fail")
      cb(false, ...)
    end
  end)
end

return M
