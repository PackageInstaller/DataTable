local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local OSS_API = require("ejoysdk_lua.ejoysdk_oss")
local holo_api = BASE_API:New("holo")
local TAG = "oss#upload"
local M = {}
M.ERR_TYPE = {UPLOAD = "upload", COMMIT = "commit"}
M.ERR_CODE = {
  SUCC = 0,
  TICKET_NOT_ENOUGH = 20001,
  UPLOAD_ERROR = 20002
}

local function get_policy(api, params, cb)
  local opt = {use_moment_token = true}
  holo_api:post(api, {}, params, opt, cb)
end

local function get_batch_oss_policy(media_group, ticket_count, cb)
  get_policy("/media/batch_apply_oss_policy", {
    media_group = media_group,
    ticket_count = ticket_count,
    support_sign_version = OSS_API.SUPPORT_SIGN_VERSION
  }, function(succ, ...)
    if succ then
      local result = (...)
      cb(true, result.fail_list or {}, result.ticket_list or {})
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

local function upload_oss(media_content_arr, ticket_list, cb)
  if type(media_content_arr) ~= "table" and type(ticket_list) ~= "table" and #media_content_arr ~= #ticket_list then
    cb(false, {all_succ = false})
    return
  end
  local size = #media_content_arr
  local upload_over_count = 0
  local upload_result = {
    result_list = {},
    all_succ = true
  }
  for index, media in pairs(media_content_arr) do
    local oss_params = ticket_list[index]
    local media_item_upload_result = {
      data = {
        name = media.name,
        media_type = media.media_type,
        ticket_id = oss_params.ticket_id,
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
        E.LOG.debug(TAG, "all files upload succ")
        cb(upload_result)
      end
    end
    
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
  end
end

function M.upload_medias(media_group, media_list, cb)
  E.LOG.debug(TAG, "start upload medias to oss")
  get_batch_oss_policy(media_group, #media_list, function(succ, ...)
    E.LOG.debug(TAG, "get batch oss policy back")
    if succ then
      E.LOG.debug(TAG, "get batch oss policy succ")
      local _fail_list, ticket_list = ...
      if type(ticket_list) == "table" and #ticket_list == #media_list then
        upload_oss(media_list or {}, ticket_list, function(result)
          if result.all_succ then
            cb(true, result.result_list)
          else
            cb(false, M.ERR_CODE.UPLOAD_ERROR, "parts of medias upload failed", result.result_list)
          end
        end)
      else
        cb(false, M.ERR_CODE.TICKET_NOT_ENOUGH, "not obtain enough tickets")
      end
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

return M
