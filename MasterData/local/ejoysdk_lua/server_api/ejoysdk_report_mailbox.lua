local BASE_API = require("ejoysdk_lua.libs.base_api")
local api = BASE_API:New("report-mailbox")
local OSS_API = require("ejoysdk_lua.ejoysdk_oss")
local OSS_UPLOAD = require("ejoysdk_lua.oss.upload")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
M.CONTENT_TYPE = {TEXT = "text", MEDIA = "media"}
M.MEDIA_TYPE = {IMAGE = "image"}
M.DATA_TYPE = OSS_API.INPUT_TYPE

function M.get_report_types(cb)
  local body = {}
  local opt = {use_moment_token = true}
  api:post("/get_report_types", {}, body, opt, cb)
end

local function parse_contents(contents, cb)
  local parsed_contents = {}
  local media_contents = {}
  for _, content in ipairs(contents) do
    if content.content_type == M.CONTENT_TYPE.MEDIA then
      local media_info = content.media_info
      table.insert(media_contents, {
        name = media_info.name,
        media_type = media_info.type,
        media_input_type = media_info.data_type,
        media = media_info.data
      })
    else
      table.insert(parsed_contents, content)
    end
  end
  if next(media_contents) then
    OSS_UPLOAD.upload_medias("report_mailbox_image_group", media_contents, function(succ, ...)
      if succ then
        local result = (...)
        for _, upload_item in ipairs(result) do
          local media_content = {
            content_type = M.CONTENT_TYPE.MEDIA,
            media_raw = {
              ticket_id = upload_item.data.ticket_id
            },
            extend_data = nil
          }
          table.insert(parsed_contents, media_content)
        end
        cb(true, parsed_contents)
      else
        local code, msg, detail = ...
        cb(false, code, msg, detail or {})
      end
    end)
  else
    cb(true, parsed_contents)
  end
end

function M.report(report_type_id, report_desc, scene, suspect_info, contents, cb)
  parse_contents(contents, function(succ, ...)
    if succ then
      local _content = (...)
      local body = {
        report_type_id = report_type_id,
        report_desc = report_desc,
        scene = scene,
        suspect_info = suspect_info,
        contents = _content
      }
      local opt = {use_moment_token = true}
      api:post("/report", {}, body, opt, cb)
    else
      local _code, _msg = ...
      cb(false, CONSTANTS.REPORT_ERROR.UPLOAD_MEDIA_FAIL, string.format("%d : %s", _code or CONSTANTS.REPORT_ERROR.UNKNOWN_ERROR, _msg or "unknown error"))
    end
  end)
end

return M
