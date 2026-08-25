local E = require("ejoysdk_lua.ejoysdk")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Constants = require("ejoysdk_lua.ejoysdk_constants")
local SYNC_IS_PLATFORM_SUPPORT = "SYNC_IS_PLATFORM_SUPPORT"
local ASYNC_SHARE_TO_PLATFORM = "ASYNC_SHARE_TO_PLATFORM"
local ASYNC_SHARE_TO_SYSTEM = "SHARE_TO_SYSTEM"
local ASYNC_SHARE_TO_APP = "SHARE_TO_APP"
local ASYNC_INVITE_TO_PLATFORM = "ASYNC_INVITE_TO_PLATFORM"
local INTERNAL_EVENT = {
  EVT_FACEBOOK_GAMEREQUEST_PULLUP = "EVT_FACEBOOK_GAMEREQUEST_PULLUP"
}
local TAG = EM.MODULE.SOCIAL .. "social"
local FB_VENDOR_NAME = "FB"
local UM_VENDOR_NAME = "UMENG"
local TW_VENDOR_NAME = "TWITTER_LOGIN"
local LINE_VENDOR_NAME = "LINE"
local INSTAGRAM_VENDOR_NAME = "INSTAGRAM"
local WHATSAPP_VENDOR_NAME = "WHATSAPP"
local KAKAOTALK_VENDOR_NAME = "KAKAOTALK"
local ZALO_VENDOR_NAME = "ZALO"
local TAPTAP_VENDOR_NAME = "TAPSHARE"
local OLD_TAPTAP_VENDOR_NAME = "TAP_UPDATE"
local XIAOHONGSHU_VENDOR_NAME = "XIAOHONGSHU"
local WEIXIN_VENDOR_NAME = "WEIXIN"
local DOUYIN_VENDOR_NAME = "DOUYIN"
local SYSTEM_VENDOR_NAME = "SYSTEM"
local local_pullup_listener
local M = {}
M.SHARE_PLATFORM = {
  facebook_share_timeline = "facebook_share_timeline",
  facebook_share_messenger = "facebook_share_messenger",
  wechat_share_messenger = "wechat_share_messenger",
  wechat_share_timeline = "wechat_share_timeline",
  qq_share_messenger = "qq_share_messenger",
  qq_share_qzone = "qq_share_qzone",
  sina_share_weibo = "sina_share_weibo",
  xiaohongshu_share = "xiaohongshu_share",
  twitter_share_timeline = "twitter_share_timeline",
  twitter_share_more = "twitter_share_more",
  system_share = "system_share",
  line_share_messenger = "line_share_messenger",
  instagram_share_story = "instagram_share_story",
  instagram_share_timeline = "instagram_share_timeline",
  whatsapp_share = "whatsapp_share",
  zalo_share = "zalo_share",
  weixin_share = "weixin_share",
  douyin_share = "douyin_share",
  kakaotalk_share_messenger = "kakaotalk_share_messenger",
  wx_mini_program = "wx_mini_program",
  wechat_share_messenger_v2 = "wechat_share_messenger_v2",
  wechat_share_timeline_v2 = "wechat_share_timeline_v2",
  taptap = "taptap"
}
M.INVITE_PLATFORM = {
  facebook_invite_gamerequest = "facebook_invite_gamerequest"
}
M.MINI_PROGRAM_TYPE = {
  release = "release",
  preview = "preview",
  test = "test"
}
M.WHITE_LIST = {
  android_weixin_package_name = "com.tencent.mm",
  android_weixin_share_friend_activity = "com.tencent.mm.ui.tools.ShareImgUI",
  android_weixin_share_timeline_activity = "com.tencent.mm.ui.tools.ShareToTimeLineUI",
  ios_weixin_package_name = "com.tencent.xin.sharetimeline"
}
local platform_vendor = {
  facebook_share_timeline = FB_VENDOR_NAME,
  facebook_share_messenger = FB_VENDOR_NAME,
  facebook_invite_gamerequest = FB_VENDOR_NAME,
  wechat_share_messenger = UM_VENDOR_NAME,
  wechat_share_timeline = UM_VENDOR_NAME,
  qq_share_messenger = UM_VENDOR_NAME,
  qq_share_qzone = UM_VENDOR_NAME,
  sina_share_weibo = UM_VENDOR_NAME,
  xiaohongshu_share = XIAOHONGSHU_VENDOR_NAME,
  taptap = TAPTAP_VENDOR_NAME,
  twitter_share_timeline = TW_VENDOR_NAME,
  twitter_share_more = TW_VENDOR_NAME,
  system_share = SYSTEM_VENDOR_NAME,
  line_share_messenger = LINE_VENDOR_NAME,
  instagram_share_story = INSTAGRAM_VENDOR_NAME,
  instagram_share_timeline = INSTAGRAM_VENDOR_NAME,
  whatsapp_share = WHATSAPP_VENDOR_NAME,
  kakaotalk_share_messenger = KAKAOTALK_VENDOR_NAME,
  zalo_share = ZALO_VENDOR_NAME,
  wx_mini_program = UM_VENDOR_NAME,
  weixin_share = WEIXIN_VENDOR_NAME,
  douyin_share = DOUYIN_VENDOR_NAME,
  wechat_share_messenger_v2 = SYSTEM_VENDOR_NAME,
  wechat_share_timeline_v2 = SYSTEM_VENDOR_NAME
}

local function fill_weixin_system_share_params(platform, params)
  if platform == M.SHARE_PLATFORM.wechat_share_messenger_v2 then
    if _ejoysdk.os() == "android" then
      params.package_name = M.WHITE_LIST.android_weixin_package_name
      params.package_activity_name = M.WHITE_LIST.android_weixin_share_friend_activity
    elseif _ejoysdk.os() == "ios" then
      local white_list = {
        M.WHITE_LIST.ios_weixin_package_name
      }
      params.ios_white_list = white_list
    end
  elseif platform == M.SHARE_PLATFORM.wechat_share_timeline_v2 then
    if _ejoysdk.os() == "android" then
      params.package_name = M.WHITE_LIST.android_weixin_package_name
      params.package_activity_name = M.WHITE_LIST.android_weixin_share_timeline_activity
    elseif _ejoysdk.os() == "ios" then
      local white_list = {
        M.WHITE_LIST.ios_weixin_package_name
      }
      params.ios_white_list = white_list
    end
  end
end

local function is_local_path(url)
  if url then
    local prefix = string.sub(url, 1, 4)
    return string.lower(prefix) ~= "http"
  end
  return false
end

local function is_file_exists(path)
  if not path then
    return false
  end
  local file_exists = true
  if _ejoysdk.os() == "android" then
    local prefix = string.sub(path, 1, 7)
    if "file://" == prefix then
      path = string.sub(path, 8, path.length)
    end
    _ejoysdk.log("check file path >> " .. tostring(path))
    local file = io.open(path, "rb")
    file_exists = nil ~= file
    if file_exists then
      file:close()
    end
  end
  return file_exists
end

local function check_params_if_invalid(params)
  for k, v in pairs(params) do
    if "media" == k then
      for _, media in pairs(v) do
        local type = media.type
        local data = media.data
        if ("image_url" == type or "file_path" == type) and is_local_path(data) then
          local exists = is_file_exists(data)
          if not exists then
            return true, Constants.SHARE_ERROR_CODES.INVALID_PARAMETER, "local path file is not exist"
          end
        end
      end
    end
  end
  return false
end

local function need_request_image_file(platform, params)
  local need_request_image_file_flag = false
  local medias = params.media
  local is_android_sina_share = E.Sysinfo.os() == "android" and platform == M.SHARE_PLATFORM.sina_share_weibo
  E.LOG.debug(TAG, "need_request_image_file is_android_sina_share:" .. tostring(is_android_sina_share))
  if (platform == M.SHARE_PLATFORM.facebook_share_timeline or platform == M.SHARE_PLATFORM.facebook_share_messenger or platform == M.SHARE_PLATFORM.line_share_messenger or platform == M.SHARE_PLATFORM.instagram_share_story or platform == M.SHARE_PLATFORM.instagram_share_timeline or platform == M.SHARE_PLATFORM.whatsapp_share or platform == M.SHARE_PLATFORM.twitter_share_more or platform == M.SHARE_PLATFORM.twitter_share_timeline or platform == M.SHARE_PLATFORM.zalo_share or platform == M.SHARE_PLATFORM.system_share or platform == M.SHARE_PLATFORM.wechat_share_messenger_v2 or platform == M.SHARE_PLATFORM.wechat_share_timeline_v2 or platform == M.SHARE_PLATFORM.taptap or platform == M.SHARE_PLATFORM.xiaohongshu_share or is_android_sina_share) and type(medias) == "table" and #medias >= 1 then
    local media = medias[1] or {}
    local media_type = media.type
    if ("image_url" == media_type or "file_path" == media_type) and type(media.data) == "string" and string.sub(media.data, 1, 4) == "http" then
      need_request_image_file_flag = true
    end
  end
  return need_request_image_file_flag
end

local function try_request_image_file(params, cb)
  local media = params.media[1]
  local url = media.data
  local EMM = require("ejoysdk_lua.res.ejoy_res_model_factory")
  local DM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
  local http_res_model = EMM.get_http_res_model("ejoysdk_social")
  local task, _err_code, _err_msg = http_res_model:create_task(url, {}, {}, function(_state, state_obj)
    if _state == DM.DOWNLOAD_STATE.COMPLETE then
      local img_path = state_obj.file_path
      E.LOG.debug(TAG, "image download succ:" .. tostring(img_path))
      media.data = img_path
      cb(true)
    elseif _state == DM.DOWNLOAD_STATE.FAILED then
      E.LOG.debug(TAG, "image download fail")
      cb(false, Constants.SHARE_ERROR_CODES.DOWNLOAD_FAILED, "download image failed")
    end
  end)
  if nil ~= task then
    task:start_download()
  else
    E.LOG.debug(TAG, "image download fail, task create fail")
    cb(false, Constants.SHARE_ERROR_CODES.DOWNLOAD_CREATE_TASK_FAILED, "download image fail, create task failed")
  end
end

function M.register_pullup_listener(pullup_listener)
  E.LOG.debug(TAG, "social register_pullup_listener")
  local first_init = false
  if pullup_listener then
    if nil == local_pullup_listener then
      first_init = true
    end
    local_pullup_listener = pullup_listener
  end
  if first_init then
    local result = {}
    UNI.register_event_cb(FB_VENDOR_NAME, function(type, body)
      if type == INTERNAL_EVENT.EVT_FACEBOOK_GAMEREQUEST_PULLUP then
        result.pullup_platform = M.INVITE_PLATFORM.facebook_invite_gamerequest
        result.data = body
        E.LOG.debug(TAG, "social receive facebook gamerequest pullup!")
        E.LOG.debug(TAG, body)
        local_pullup_listener(result)
      end
    end)
  end
end

function M.is_support(platform)
  local vendor_name = platform_vendor[platform]
  local vendor = EV.get(vendor_name)
  if vendor and vendor:is_support_ability({
    EV.ABILITY.SHARE
  }) then
    do return end
    return vendor.is_share_support, vendor, {
      EV.ABILITY.SHARE
    }, EV.ABILITY.SHARE, nil, nil, nil, nil
  end
  local param = {platform = platform}
  local ret
  if _ejoysdk.os() ~= "harmonyos" then
    ret = UNI.sync_call(vendor_name, SYNC_IS_PLATFORM_SUPPORT, param, nil)
  end
  local is_support = ret and ret.support or false
  if _ejoysdk.os() == "ios" and (vendor == SYSTEM_VENDOR_NAME or vendor_name == SYSTEM_VENDOR_NAME) then
    if platform == M.SHARE_PLATFORM.wechat_share_messenger_v2 or platform == M.SHARE_PLATFORM.wechat_share_timeline_v2 then
      is_support = E.Sysinfo.is_app_install("weixin://")
    else
      is_support = true
    end
  end
  if _ejoysdk.os() == "android" and (platform == M.SHARE_PLATFORM.wechat_share_messenger_v2 or platform == M.SHARE_PLATFORM.wechat_share_timeline_v2) then
    is_support = E.Sysinfo.is_app_install(M.WHITE_LIST.android_weixin_package_name)
  end
  if _ejoysdk.os() == "harmonyos" and platform == M.SHARE_PLATFORM.system_share then
    is_support = true
  end
  if is_support then
    E.LOG.debug(TAG, "is support: " .. tostring(platform))
  else
    E.LOG.debug(TAG, "is not support: " .. tostring(platform))
  end
  return is_support
end

function M.is_support_v2(platform)
  local support = M.is_support(platform)
  local is_support_share = false
  local support_type = type(support)
  if "boolean" == support_type then
    is_support_share = support
  elseif "table" == support_type then
    local has_installed = support.has_installed or false
    local has_share_infos = support.has_share_infos or false
    is_support_share = has_installed and has_share_infos
  end
  return is_support_share
end

local harmony_share_module_loaded = false

local function load_harmonyos_share_module(cb)
  if true == harmony_share_module_loaded then
    if cb then
      cb(true)
    end
    return
  end
  E.async_load_module("ejoysdk_lua.harmonyos.ejoysdk_vm_func_share", function(succ)
    if succ then
      harmony_share_module_loaded = true
      E.LOG.debug(TAG, "ejoysdk_vm_func_share load succ")
    else
      E.LOG.warn(TAG, "ejoysdk_vm_func_share load failed")
    end
    if cb then
      cb(succ)
    end
  end)
end

local function share_to_system(param, cb)
  if _ejoysdk.os() == "android" then
    local media_url, type
    if param.media and param.media[1] then
      media_url = param.media[1].data
      type = param.media[1].type
    end
    local share_to_app_params = {
      message = param.message,
      package_name = param.package_name,
      package_activity_name = param.package_activity_name,
      type = type
    }
    if "image_url" == type then
      share_to_app_params.image_url = media_url
    elseif "file_path" == type then
      share_to_app_params.file_path = media_url
    end
    E.async_call(ASYNC_SHARE_TO_APP, share_to_app_params, nil, cb)
  elseif _ejoysdk.os() == "ios" then
    E.async_call(ASYNC_SHARE_TO_SYSTEM, function(info)
      cb(JSON.decode(info))
    end, JSON.encode(param))
  elseif _ejoysdk.os() == "windows" then
    local media_url, type
    if param.media and param.media[1] then
      media_url = param.media[1].data
      type = param.media[1].type
    end
    local info = {}
    if _ejoysdk.saveasfile and "file_path" == type then
      local result = _ejoysdk.saveasfile(media_url)
      E.LOG.debug(TAG, "share_to_system window result=" .. result)
      info.succ = 0 == result
      info.code = result
      cb(info)
    else
      E.LOG.debug(TAG, "share_to_system window not support")
      info.succ = false
      cb(info)
    end
  elseif _ejoysdk.os() == "harmonyos" then
    load_harmonyos_share_module(function(succ)
      local info = {}
      if succ then
        E.LOG.debug(TAG, "load harmony share module succ, now begin share")
        E.async_call_once("share", function(succ2, ...)
          local _code, _msg
          if succ2 then
            E.LOG.debug(TAG, "share succ")
          else
            _code, _msg = ...
            E.LOG.debug(TAG, "share failed, code:" .. tostring(_code) .. ", _msg:" .. tostring(_msg))
          end
          info.succ = succ2
          info.code = _code
          info.msg = _msg
          cb(info)
        end, M.SHARE_PLATFORM.system_share, param)
      else
        E.LOG.warn(TAG, "share failed load harmony module failed")
        info.succ = false
        info.code = Constants.EJOYSDK_ERROR_CODES.HARMONY_MODULE_LOAD_FAILED
        cb(info)
      end
    end)
  end
end

local function get_vendor_meta_config(platform)
  local sdk_infos = UNI.get_sdk_infos()
  local vendorname = platform_vendor[platform]
  local sdk_info = sdk_infos[vendorname]
  local config
  if not sdk_info and vendorname == TAPTAP_VENDOR_NAME then
    sdk_info = sdk_infos[OLD_TAPTAP_VENDOR_NAME]
  end
  if sdk_info then
    config = sdk_info.meta
  end
  config = config or {}
  _ejoysdk.log("get_taptap_meta_config >>" .. tostring(platform))
  E.log(config)
  return config
end

function M.share(platform, param, callback)
  E.LOG.tips(TAG, "If you get a share error")
  local is_invalid, code, msg = check_params_if_invalid(param)
  if is_invalid then
    callback(false, code, msg)
    return
  end
  local vendor_name = platform_vendor[platform]
  param.platform = platform
  if platform == M.SHARE_PLATFORM.sina_share_weibo and E.Sysinfo.os() == "android" then
    local temp_save_base_path = E.File.get_ext_file_dir()
    local temp_save_file_path_prefix = E.Path.join(temp_save_base_path, "ejoy/temp_share_img_")
    local media_size = param.media and #param.media or 0
    if media_size > 0 then
      for i = 1, media_size do
        local media_item_type = param.media[i].type
        if "image_data" == media_item_type then
          local temp_save_file_path = temp_save_file_path_prefix .. tostring(i)
          E.File.writefile_fullpath(temp_save_file_path, param.media[i].data)
          param.media[i].type = "image_url"
          param.media[i].data = "file://" .. tostring(temp_save_file_path)
        end
      end
    end
  end
  local index = 0
  local image_datas = {}
  for k, v in pairs(param) do
    if "media" == k then
      for _, media in pairs(v) do
        local type = media.type
        local media_data
        if "image_b64" == type then
          media_data = _ejoysdk_crypt.base64decode(media.data)
        elseif "image_data" == type then
          media_data = media.data
        end
        if media_data then
          table.insert(image_datas, media_data)
          local len = #media_data
          media.type = "image_chunk"
          media.data = {index = index, length = len}
          index = index + len
        end
      end
    end
  end
  local chunk_data
  
  local function share_wrapper(cb)
    if platform == M.SHARE_PLATFORM.taptap then
      param.ext = param.ext or {}
      local taptap_fail_url = param.ext.taptap_fail_url
      E.LOG.debug(TAG, "share wrapper with taptap, fill ext info with fail url:" .. tostring(taptap_fail_url))
      if not taptap_fail_url or "" == taptap_fail_url then
        local taptap_vendor_cfg = get_vendor_meta_config(M.SHARE_PLATFORM.taptap)
        taptap_fail_url = taptap_vendor_cfg.TAPSHARE_ShareFailUrl
        taptap_fail_url = taptap_fail_url or taptap_vendor_cfg.share_fail_url
        param.ext.taptap_fail_url = taptap_fail_url
      end
      E.LOG.debug(TAG, "share_wrapper with taptap_fail_url:" .. tostring(param.ext.taptap_fail_url))
    end
    local need_request_image_file_flag = need_request_image_file(platform, param)
    E.LOG.debug(TAG, "need_request_image_file, platform:" .. tostring(platform) .. ", need_request_image_file_flag:" .. tostring(need_request_image_file_flag))
    if need_request_image_file_flag then
      try_request_image_file(param, function(succ, ...)
        if succ then
          local ios_share_wechat_v1 = E.Sysinfo.os() == "ios" and (platform == M.SHARE_PLATFORM.wechat_share_messenger or platform == M.SHARE_PLATFORM.wechat_share_timeline)
          if ios_share_wechat_v1 then
            local media = param.media[1]
            local img_data = _ejoysdk.read_file(media.data)
            if img_data then
              table.insert(image_datas, img_data)
              local len = #img_data
              media.type = "image_chunk"
              media.data = {index = index, length = len}
              index = index + len
            end
          end
          chunk_data = table.concat(image_datas)
          cb()
        else
          local request_img_code, request_img_msg = ...
          callback(false, request_img_code, request_img_msg)
        end
      end)
    else
      chunk_data = table.concat(image_datas)
      cb()
    end
  end
  
  local function async_share()
    if vendor_name == SYSTEM_VENDOR_NAME then
      fill_weixin_system_share_params(platform, param)
      
      local function cb(info)
        if info.succ then
          callback(true)
        else
          local temp_code = info.code or 0
          local temp_msg = info.msg or info.message or ""
          callback(false, temp_code, temp_msg)
          E.LOG.error(TAG, "share fail, code is " .. tostring(temp_code) .. ", msg is " .. tostring(temp_msg))
        end
      end
      
      share_to_system(param, cb)
    else
      local vendor = EV.get(vendor_name)
      if vendor and vendor:is_support_ability({
        EV.ABILITY.SHARE
      }) then
        vendor.share(param, chunk_data, callback)
      else
        UNI.async_call(vendor_name, ASYNC_SHARE_TO_PLATFORM, param, chunk_data, function(succ, ...)
          if succ then
            local body = (...)
            callback(true, body)
          else
            local _, body = ...
            E.LOG.error(TAG, "share fail, code is " .. tostring(body.error_code) .. ", msg is " .. tostring(body.error_msg))
            callback(false, body.error_code, body.error_msg)
          end
        end)
      end
    end
  end
  
  if E.Sysinfo.os() == "ios" and _ejoysdk.async_task then
    local download_table = {}
    local medias = param.media
    if medias then
      for _, media in pairs(medias) do
        local media_type = media.type
        local media_data = media.data
        local is_type_url = "image_url" == media_type or "file_path" == media_type
        local is_url_http = type(media_data) == "string" and string.sub(media_data, 1, 4) == "http"
        if is_type_url and is_url_http then
          table.insert(download_table, media_data)
        end
      end
    end
    if 0 ~= #download_table then
      E.async_call("async_task", function(body)
        body = body or {}
        body = JSON.decode(body)
        local succ = body.succ
        if 1 == succ then
          local local_paths = body.body
          local _medias = param.media
          if _medias and local_paths then
            local i = 1
            for _, media in pairs(_medias) do
              local media_type = media.type
              local media_data = media.data
              local is_type_url = "image_url" == media_type or "file_path" == media_type
              local is_url_http = type(media_data) == "string" and string.sub(media_data, 1, 4) == "http"
              if is_type_url and is_url_http then
                media.data = local_paths[i]
                i = i + 1
              end
            end
          end
        elseif 0 == succ then
          E.LOG.debug(TAG, body.msg)
        end
        share_wrapper(async_share)
      end, JSON.encode(download_table), "DOWNLOAD_TO_LOCAL")
      return
    end
  end
  share_wrapper(async_share)
end

function M.register_share_event(param, callback)
  if E.Sysinfo.os() == "weixin" then
    local WX = require("ejoysdk_lua.vendors.weixin")
    WX.showShareMenu(param, callback)
  elseif E.Sysinfo.os() == "douyin" then
    local DY = require("ejoysdk_lua.vendors.douyin")
    DY.showShareMenu(param, callback)
  else
    callback(true)
  end
end

function M.invite(platform, param, callback)
  local vendor = platform_vendor[platform]
  param.platform = platform
  
  local function cb(succ, ...)
    if succ then
      local body = (...)
      callback(true, body)
    else
      local _, body = ...
      callback(false, body.error_code, body.error_msg)
    end
  end
  
  UNI.async_call(vendor, ASYNC_INVITE_TO_PLATFORM, param, nil, cb)
end

return M
