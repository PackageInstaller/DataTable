local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local qabot_api = BASE_API:New("qabot")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = "EJOYSDK_QABOT"
local M = {}
local ERR_CODE_XIAO_MI_ERROR = 75002001
local last_session_id
local inited = false
local _enable_timer = false
local _last_questions_version = ""
local _cache_hot_questions = {}
local DEFAULT_QUS_INTERVAL = 600
local _elements_cache
local LAST_QUESTIONS_MODEL = E.LazyKeyStore:New("LAST_QUESTIONS_MODEL", false, true, false)
local search_result_cache = {}

function M.gen_category_sub_key(_category_tags, results)
  if _category_tags and type(_category_tags) == "table" and next(_category_tags) then
    for ctk, ctv in pairs(_category_tags) do
      results["category_tags." .. tostring(ctk)] = ctv
    end
  end
  return results
end

function M.gen_cache_concat_sorted_kv(category_tags)
  local keys = {}
  for k in pairs(category_tags) do
    table.insert(keys, k)
  end
  table.sort(keys)
  local result = {}
  for _, key in ipairs(keys) do
    table.insert(result, key .. "=" .. tostring(category_tags[key]))
  end
  do return table.concat, result end
  return table.concat, result, "&", ipairs(keys)
end

function M.ask_question(params, cb)
  local opt = {use_moment_token = true}
  local lang = E.CONFIG.get_config("lang")
  local param = {
    content = params.content,
    session_id = last_session_id,
    input_type = params.input_type or "text",
    language = lang or "zh-hans"
  }
  param = M.gen_category_sub_key(params.category_tags, param)
  qabot_api:get("/chat", {
    acceptable = E.HTTP.CT_JSON
  }, param, opt, function(succ, ...)
    if succ then
      local resp = (...)
      E.LOG.debug(TAG, "ask question succ, resp >>")
      E.LOG.debug(TAG, resp)
      local response = resp.response
      if response then
        if response.state == "fail" then
          E.LOG.debug(TAG, "云小蜜错误")
          cb(false, ERR_CODE_XIAO_MI_ERROR, "云小蜜错误")
          return
        end
        if response.session_id then
          last_session_id = response.session_id
        end
      end
      cb(true, resp)
    else
      E.LOG.debug(TAG, "ask question fail")
      cb(false, ...)
    end
  end)
end

function M.ask_recommend_question(params, cb)
  local opt = {use_moment_token = true}
  local lang = E.CONFIG.get_config("lang")
  local param = {
    content = params.content,
    session_id = last_session_id,
    knowledge_id = params.knowledge_id,
    language = lang or "zh-hans"
  }
  param = M.gen_category_sub_key(params.category_tags, param)
  qabot_api:get("/chat", {
    acceptable = E.HTTP.CT_JSON
  }, param, opt, function(succ, ...)
    if succ then
      local resp = (...)
      E.LOG.debug(TAG, "choose_recommend_question succ, resp >>")
      E.LOG.debug(TAG, resp)
      local response = resp.response
      if response and response.state == "fail" then
        E.LOG.debug(TAG, "云小蜜错误")
        cb(false, ERR_CODE_XIAO_MI_ERROR, "云小蜜错误")
        return
      end
      cb(true, resp)
    else
      E.LOG.debug(TAG, "choose_recommend_question fail")
      cb(false, ...)
    end
  end)
end

function M.hyper_link(params, cb)
  local opt = {use_moment_token = true}
  local lang = E.CONFIG.get_config("lang")
  local param = {
    hyper_link_id = params.hyper_link_id,
    from_page = params.from_page,
    from_id = params.from_id,
    language = lang or "zh-hans"
  }
  param = M.gen_category_sub_key(params.category_tags, param)
  qabot_api:get("/chat", {
    acceptable = E.HTTP.CT_JSON
  }, param, opt, function(succ, ...)
    if succ then
      local resp = (...)
      E.LOG.debug(TAG, "hyper_link succ, resp >>")
      E.LOG.debug(TAG, resp)
      local response = resp.response
      if response and response.state == "fail" then
        E.LOG.debug(TAG, "云小蜜错误")
        cb(false, ERR_CODE_XIAO_MI_ERROR, "云小蜜错误")
        return
      end
      cb(true, resp)
    else
      E.LOG.debug(TAG, "hyper_link fail")
      cb(false, ...)
    end
  end)
end

function M.comment(params, cb)
  local url = E.CONFIG.get_config("qabot") .. "/chat/comment"
  local param = {
    msg_id = params.msg_id,
    satisfy = params.satisfy,
    chat_uid = params.chat_uid
  }
  local HOLO = require("ejoysdk_lua.ejoysdk_holo")
  local headers = {}
  headers["moment-Token"] = HOLO.get_player_token()
  E.HTTP.post(url, {raw_body = true, headers = headers}, E.HTTP.CT_JSON, param, function(resp)
    if resp.status == 200 then
      if resp.body and resp.body == "success" then
        cb(true, resp.body)
      else
        cb(false, resp.body)
      end
    else
      cb(false, resp.status, "http error")
    end
  end)
end

function M.popular(params, cb)
  local opt = {use_moment_token = true}
  local param = {
    group = params.group
  }
  qabot_api:post("/chat/popular", {
    acceptable = E.HTTP.CT_JSON
  }, param, opt, function(succ, ...)
    if succ then
      local resp = (...)
      E.LOG.debug(TAG, "get popular succ, resp >>")
      E.LOG.debug(TAG, resp)
      cb(true, resp)
    else
      E.LOG.debug(TAG, "get popular fail")
      cb(false, ...)
    end
  end)
end

local function handle_questions(questions)
  if not questions then
    return
  end
  _elements_cache = questions
  search_result_cache = {}
end

function M.questions(params, cb)
  local opt = {use_moment_token = true}
  local lang = E.CONFIG.get_config("lang")
  local param = params or {}
  param.language = param.language or lang or "zh-hans"
  param.last_version = _last_questions_version
  local current_product_code = E.CONFIG.get_config("product")
  current_product_code = current_product_code and current_product_code:lower() or ""
  local fn = string.format("%s_qabot_questions", tostring(current_product_code))
  qabot_api:post("/chat/questions", {
    acceptable = E.HTTP.CT_JSON
  }, param, opt, function(succ, ...)
    if succ then
      local resp = (...) or {}
      E.LOG.debug(TAG, "get questions succ, resp >>")
      E.LOG.debug(TAG, resp)
      local encrypt_cache = JSON.encode(resp and resp.data)
      local succ2, error = pcall(E.File.writefile, fn, encrypt_cache)
      if not succ2 then
        E.LOG.error(TAG, "failed to write local file: " .. tostring(error))
      else
        E.LOG.debug(TAG, "save local file succ")
        _last_questions_version = resp and resp.version or ""
        local q_model = LAST_QUESTIONS_MODEL:get()
        if nil == q_model then
          q_model = {
            [current_product_code] = _last_questions_version
          }
        else
          q_model[current_product_code] = _last_questions_version
        end
        LAST_QUESTIONS_MODEL:set(q_model)
      end
      handle_questions(resp and resp.data)
      cb(true, resp and resp.data)
    else
      local code = (...)
      if 84021102 == code then
        E.LOG.debug(TAG, "questions use local cache")
        if nil == _elements_cache then
          local cache_questions = E.File.readfile(fn)
          if nil ~= cache_questions and #cache_questions > 0 then
            E.LOG.debug(TAG, "get questions succ file cache")
            local json_body = JSON.decode(cache_questions)
            handle_questions(json_body)
            cb(true, json_body)
            return
          else
            E.LOG.debug(TAG, "local cache is nil")
            _last_questions_version = ""
            local q_model = LAST_QUESTIONS_MODEL:get()
            q_model = q_model or {}
            q_model[current_product_code] = nil
            LAST_QUESTIONS_MODEL:set(q_model)
            cb(false, -1, "local cache is nil")
          end
        else
          cb(true, _elements_cache)
        end
        return
      end
      E.LOG.debug(TAG, "get questions fail")
      cb(false, ...)
    end
  end)
end

function M.hot_questions(params, cb)
  local lang = E.CONFIG.get_config("lang")
  params = params or {}
  params.language = params.language or lang or "zh-hans"
  local cache_key = tostring(params.language) .. "_" .. tostring(params.limit)
  if params.category_tags and type(params.category_tags) == "table" and next(params.category_tags) then
    cache_key = cache_key .. M.gen_cache_concat_sorted_kv(params.category_tags)
  end
  if _cache_hot_questions and _cache_hot_questions[cache_key] and _cache_hot_questions[cache_key].timestamp > E.time() - 300 and cache_key and not params.ignore_cache then
    E.LOG.debug(TAG, "hot_questions hit cache and return")
    cb(true, _cache_hot_questions[cache_key].resp)
    return
  end
  M.get_hot_questions(params, cache_key, cb)
end

function M.get_hot_questions(params, cache_key, cb)
  local opt = {use_moment_token = true}
  local _params = params or {}
  E.log(_params)
  qabot_api:post("/chat/hot_questions", {
    acceptable = E.HTTP.CT_JSON
  }, _params, opt, function(succ, ...)
    if succ then
      local resp = (...) or {}
      E.LOG.debug(TAG, "get hot_questions succ, resp >>")
      if resp and resp.data then
        _cache_hot_questions[cache_key] = {
          timestamp = E.time(),
          resp = resp,
          language = _params.language,
          limit = _params.limit
        }
      end
      cb(true, resp)
    else
      E.LOG.debug(TAG, "get hot_questions fail")
      cb(false, ...)
    end
  end)
end

function M.completion(params, cb)
  params = params or {}
  if not params.content or params.content and 0 == #params.content then
    E.LOG.debug(TAG, "content is nil or empty")
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "content is nil or empty")
    return
  end
  local lang = E.CONFIG.get_config("lang")
  params.language = params.language or lang or "zh-hans"
  local cache_key = params.content .. "_" .. tostring(params.language) .. "_" .. tostring(params.size)
  if params.category_tags and type(params.category_tags) == "table" and next(params.category_tags) then
    cache_key = cache_key .. M.gen_cache_concat_sorted_kv(params.category_tags)
  end
  if search_result_cache[cache_key] and search_result_cache[cache_key].timestamp > E.time() - 60 and search_result_cache[cache_key].data then
    E.LOG.debug(TAG, "hit search_result_cache :" .. tostring(cache_key))
    cb(true, search_result_cache[cache_key].data)
    return
  end
  E.log(params)
  qabot_api:post("/chat/completion", {
    acceptable = E.HTTP.CT_JSON
  }, params, {use_moment_token = true}, function(succ, ...)
    if succ then
      local resp = (...) or {}
      E.LOG.debug(TAG, "get completion succ, resp >>")
      cb(true, resp)
      search_result_cache[cache_key] = {
        timestamp = E.time(),
        data = resp
      }
    else
      E.LOG.debug(TAG, "get completion fail")
      cb(false, ...)
    end
  end)
end

function M.local_completion(parmas, cb)
  parmas = parmas or {}
  if not parmas.content or parmas.content and 0 == #parmas.content then
    E.LOG.debug(TAG, "content is nil or empty")
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "content is nil or empty")
    return
  end
  if nil == _elements_cache then
    E.LOG.debug(TAG, "questions is empty")
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_DATA, "questions is empty")
    return
  end
  local results = {}
  local exit_limit = parmas and parmas.size or 10
  local content = parmas.content
  local cache_key = content .. "_" .. tostring(exit_limit)
  if search_result_cache[cache_key] and search_result_cache[cache_key].timestamp > E.time() - 60 and search_result_cache[cache_key].data then
    E.LOG.debug(TAG, "hit search_result_cache :" .. tostring(cache_key))
    cb(true, search_result_cache[cache_key].data)
    return
  end
  for _, item in ipairs(_elements_cache) do
    local found = false
    if item.title and string.find(item.title, content, 1, true) then
      found = true
    elseif item.similar_titles then
      for _, st in ipairs(item.similar_titles) do
        if string.find(st, content, 1, true) then
          found = true
          break
        end
      end
    end
    if found then
      table.insert(results, item)
    end
    if exit_limit <= #results then
      break
    end
  end
  search_result_cache[cache_key] = {
    timestamp = E.time(),
    data = results
  }
  cb(true, results)
end

function M.set_default_interval(_interval)
  DEFAULT_QUS_INTERVAL = _interval or 600
end

function M.get_cache_questions()
  return _elements_cache
end

function M.set_cache_questions(r_data)
  _elements_cache = r_data
end

local function start_questions_timer()
  if _enable_timer then
    return
  end
  _enable_timer = true
  E.LOG.debug(TAG, "start_questions_timer")
  local cb
  
  function cb()
    if _enable_timer then
      M.questions({}, function(succ, ...)
        if not succ then
          local code, msg = ...
          E.LOG.debug(TAG, "sync questions fail, code: " .. tostring(code) .. ", msg:" .. tostring(msg))
        end
      end)
      E.Timer.once(DEFAULT_QUS_INTERVAL, cb)
    end
  end
  
  cb()
end

local function stop_questions_timer()
  if not _enable_timer then
    return
  end
  _enable_timer = false
end

local function player_offline_handler(_user_info)
  stop_questions_timer()
end

local function logout_handler(_user_info)
  stop_questions_timer()
end

local function exit_handler(_user_info)
  stop_questions_timer()
end

local function player_online_handler(_player_token)
  start_questions_timer()
end

function M.init(_options)
  if inited then
    E.LOG.debug(TAG, "already init and return")
    return
  end
  inited = true
  if _options and _options.enable_local_questions then
    local q_model = LAST_QUESTIONS_MODEL:get()
    local current_product_code = E.CONFIG.get_config("product")
    current_product_code = current_product_code and current_product_code:lower() or ""
    if q_model and q_model[current_product_code] then
      _last_questions_version = q_model[current_product_code]
    end
    ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_online_handler)
    ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
    ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
    ET.subscribe(ET.gangplank.EXIT, exit_handler)
  end
end

return M
