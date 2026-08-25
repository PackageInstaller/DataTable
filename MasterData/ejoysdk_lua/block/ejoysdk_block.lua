local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local holo = require("ejoysdk_lua.ejoysdk_holo")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.BLOCK .. "block"
local M = {}
local keyword
local sensitive_words_id = ""
local start_word_list_timer = false
local has_block_keywords = false
local inited = false

function M.sensitive_keywords()
  return keyword
end

function M.has_block_keywords()
  return has_block_keywords
end

local function require_params()
  local token = EG.user_info().token
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
end

local function handle_swords(s_words_lists_id, words)
  keyword:clean()
  string.gsub(words, [[
([^
]+)]], function(c)
    keyword:insert(c)
  end)
  if not has_block_keywords then
    has_block_keywords = true
    ET.publish(ET.block.INITED, true)
  end
  sensitive_words_id = s_words_lists_id
end

local function get_s_word_list(cb)
  cb = cb or function(...)
  end
  E.HTTP.post(holo.holo_url("get_s_word_list_id"), require_params(), E.HTTP.CT_JSON, {mod = "client"}, function(resp)
    local status = resp.status
    local body = resp.body
    if 200 == status then
      local s_words_lists_id = body.s_words_lists_id
      if sensitive_words_id == s_words_lists_id then
        E.LOG.debug(TAG, "get_s_word_list memory cache")
        cb(true)
        return
      end
      local fn = string.format("%s_swc", tostring(s_words_lists_id))
      local cache = E.File.readfile(fn)
      if nil ~= cache and #cache > 0 then
        local origin_cache = _ejoysdk_crypt.base64decode(cache)
        E.LOG.debug(TAG, "get_s_word_list file cache")
        handle_swords(s_words_lists_id, origin_cache)
        cb(true)
        return
      end
      local url = E.HTTP.url_query(holo.holo_url("get_s_word_list"), {list_id = s_words_lists_id})
      E.HTTP.get(url, {}, function(s_word_resp)
        if s_word_resp.status == 200 then
          E.LOG.debug(TAG, "get_s_word_list remote")
          local words = s_word_resp.body or ""
          handle_swords(s_words_lists_id, words)
          local encrypt_cache = _ejoysdk_crypt.base64encode(words)
          local succ, error = pcall(E.File.writefile, fn, encrypt_cache)
          if not succ then
            E.LOG.error(TAG, "failed to write local file: " .. tostring(error))
          end
          cb(true)
        else
          E.LOG.error(TAG, "holo 获取 get_s_word_list 失败 status = " .. tostring(s_word_resp.status))
          cb(false)
        end
      end)
    else
      E.LOG.warn(TAG, "holo 获取 get_s_word_list_id 失败 status = " .. tostring(status))
      cb(false)
    end
  end)
end

local function start_s_word_list_timer(interval)
  if start_word_list_timer then
    return
  end
  interval = interval or 480
  start_word_list_timer = true
  local cb
  
  function cb()
    if start_word_list_timer then
      E.LOG.debug(TAG, "start_word_list_timer")
      get_s_word_list()
      E.Timer.once(interval, cb)
    end
  end
  
  cb()
end

local function stop_s_word_list_timer()
  if not start_word_list_timer then
    return
  end
  start_word_list_timer = false
end

local function login_handler(_user_info)
  start_s_word_list_timer()
end

local function logout_handler(_user_info)
  stop_s_word_list_timer()
end

local function exit_handler(_user_info)
  stop_s_word_list_timer()
end

function M.init()
  if inited then
    E.LOG.debug(TAG, "already init and return")
    return
  end
  if _ejoysdk.sensitive_words then
    keyword = require("ejoysdk_lua.block.keyword_block_c")
  else
    keyword = require("ejoysdk_lua.block.keyword_block")
  end
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.gangplank.EXIT, exit_handler)
  inited = true
end

return M
