local BASE_API = require("ejoysdk_lua.libs.base_api")
local bbs_api = BASE_API:New("bbs")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.SERVER_API .. "bbs"
local M = {}

function M.get_qrcode(cb)
  bbs_api:post("/api/passport/qrcode/acquire", {}, {}, {}, cb)
end

function M.qrcode_query_status(uuid, cb)
  local body = {u = uuid}
  bbs_api:post("/api/passport/qrcode/query_status", {}, body, {}, cb)
end

function M.qrcode_login(uuid, cb)
  local body = {u = uuid}
  local opt = {use_ejoy_token = true}
  bbs_api:post("/api/passport/qrcode/login", {}, body, opt, cb)
end

function M.get_director_by_scene(scene_ids, cb)
  local body = {scene_ids = scene_ids}
  local opt = {use_moment_token = true}
  bbs_api:post("/api/outer_director/get_director_by_scene", {}, body, opt, cb)
end

function M.get_director_by_key(scene_id, keys, cb)
  local body = {scene_id = scene_id, keys = keys}
  local opt = {use_moment_token = true}
  bbs_api:post("/api/outer_director/get_director_by_key", {}, body, opt, cb)
end

return M
