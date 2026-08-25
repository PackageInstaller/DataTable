local E = require("ejoysdk_lua.ejoysdk")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local M = {}
local TAG = "harmonyos#share"
local jf = lunate.js_functions
local SYS_SHARE = jf.import("@kit.ShareKit")
local FURI = lunate.import("@ohos.file.fileUri")
local image = lunate.import("@ohos.multimedia.image")
local SOCIAL = require("ejoysdk_lua.social.ejoysdk_social")
local CC = require("ejoysdk_lua.ejoysdk_constants")
local SYS_SHARE_THUMBNAIL_MAX_BYTES = 30720
local DEFAULT_INIT_IMAGE_QUALITY = 98

local function scale_thumbnail_if_needed(pixel_map, cb)
  local screen_width = E.Sysinfo.screen_width()
  local screen_height = E.Sysinfo.screen_height()
  local scale_max_width = math.min(screen_width, screen_height)
  pixel_map.getImageInfo(function(err, image_info)
    if not image_info or not image_info.size then
      cb(nil, CC.SHARE_ERROR_CODES.HARMONY_GET_IMAGE_INFO_FAILED, "获取图片信息失败")
      return
    end
    local _size = pixel_map.getPixelBytesNumber()
    local image_width = image_info.size.width or 0
    if image_width <= scale_max_width then
      E.LOG.debug(TAG, "no need scale")
      cb(false)
    else
      local scale_ratio = scale_max_width / image_width
      E.LOG.debug(TAG, "need scale, ratio:" .. tostring(scale_ratio))
      pixel_map.scale(scale_ratio, scale_ratio):Then(function()
        cb(true)
      end):catch(function(error)
        E.LOG.warn(TAG, "scale failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
        cb(nil, error.code, error.message)
      end)
    end
  end)
end

local function check_image_need_compress(source_api, cb)
  local image_packer = image.createImagePacker()
  local pack_options = {format = "image/jpeg", quality = DEFAULT_INIT_IMAGE_QUALITY}
  
  local function packing_finish_handler(succ, data)
    image_packer.release():Then(function()
      cb(succ, data)
    end):catch(function(error)
      E.LOG.warn(TAG, "release image_packer failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
      cb(nil, error.code, error.message)
    end)
  end
  
  E.LOG.debug(TAG, "check_image_need_compress before packing, quality" .. tostring(DEFAULT_INIT_IMAGE_QUALITY))
  image_packer.packing(source_api, pack_options):Then(function(data)
    local bytes_count = #data
    E.LOG.debug(TAG, "check_image_need_compress after packing, bytes_count:" .. tostring(bytes_count) .. ", max:" .. tostring(SYS_SHARE_THUMBNAIL_MAX_BYTES))
    if bytes_count > SYS_SHARE_THUMBNAIL_MAX_BYTES then
      packing_finish_handler(true, data)
    else
      packing_finish_handler(false, data)
    end
  end):catch(function(error)
    E.LOG.warn(TAG, "check_image_need_compress packing failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
    cb(nil, error.code, error.message)
  end)
end

local function recycle_packing(image_packer, cb)
  image_packer.release():Then(function()
    cb(true)
  end):catch(function(error)
    E.LOG.warn(TAG, "recycle_packing release failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end

local function compress_image(pixel_map, required_quality, cb)
  local image_packer = image.createImagePacker()
  local pack_options = {format = "image/jpeg", quality = required_quality}
  E.LOG.debug(TAG, "compress_image begin, required_quality:" .. tostring(pack_options.quality))
  image_packer.packing(pixel_map, pack_options):Then(function(data)
    local bytes_count = #data
    if bytes_count > SYS_SHARE_THUMBNAIL_MAX_BYTES then
      local next_quality = required_quality / 2
      if next_quality < 1 then
        cb(nil, CC.SHARE_ERROR_CODES.COMPRESS_IMAGE_QUALITY_FAILED, "compress with quality too low")
        return
      end
      E.LOG.debug(TAG, "compress_image need compress, bytes_count:" .. tostring(bytes_count) .. ", max:" .. tostring(SYS_SHARE_THUMBNAIL_MAX_BYTES) .. ", required_quality:" .. tostring(required_quality) .. ", next_quality:" .. tostring(next_quality))
      recycle_packing(image_packer, function(rsucc, ...)
        if rsucc then
          compress_image(pixel_map, next_quality, cb)
        else
          local _code, _msg = ...
          cb(nil, _code, _msg)
        end
      end)
    else
      recycle_packing(image_packer, function(_rsucc, ...)
        E.File.writefile("share_image.jpeg", data)
        E.LOG.debug(TAG, "compress_image succ, bytes_count:" .. tostring(bytes_count) .. ", max:" .. tostring(SYS_SHARE_THUMBNAIL_MAX_BYTES) .. ", required_quality:" .. tostring(required_quality))
        cb(data)
      end)
    end
  end)
end

local function get_thumbnail_for_image_uri(image_uri, cb)
  local file_path = image_uri:gsub("file://", "")
  local source_api = image.createImageSource(file_path)
  if not source_api then
    cb(nil, CC.SHARE_ERROR_CODES.FILE_NOT_EXISTS, "share file not exists, source:" .. tostring(source_api))
    return
  end
  
  local function compress_image_handler()
    local _image_size
    local decord_options = {editable = true, pixelFormat = 2}
    source_api.createPixelMap(decord_options):Then(function(pixel_map)
      if not pixel_map then
        cb(nil, CC.SHARE_ERROR_CODES.DECORD_IMAGE_FAILED, "解析图片失败")
        return
      end
      
      local function finish_cb_wrapper(_uint8arr, _code, _msg)
        E.LOG.debug(TAG, "compress_image_handler finish")
        pixel_map.release():Then(function()
          E.LOG.debug(TAG, "compress_image_handler pixelmap release succ")
          cb(_uint8arr, _code, _msg)
        end):catch(function(error)
          E.LOG.warn(TAG, "compress_image_handler pixelmap release failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
          cb(_uint8arr, _code, _msg)
        end)
      end
      
      scale_thumbnail_if_needed(pixel_map, function(scaled, ...)
        if nil == scaled then
          local _code, _msg = ...
          finish_cb_wrapper(nil, _code, _msg)
        else
          local init_quality = scaled and DEFAULT_INIT_IMAGE_QUALITY or DEFAULT_INIT_IMAGE_QUALITY / 2
          compress_image(pixel_map, init_quality, function(data_arr_buffer, ...)
            if data_arr_buffer then
              local uint8arr = lunate.to_typedarray(data_arr_buffer, "napi_uint8_array")
              finish_cb_wrapper(uint8arr)
            else
              local _code, _msg = ...
              E.LOG.warn(TAG, "compress_image failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
              finish_cb_wrapper(nil, _code, _msg)
            end
          end)
        end
      end)
    end):catch(function(error)
      E.LOG.warn(TAG, "get_thumbnail_for_image_uri createPixelMap failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
      cb(nil, error.code, error.message)
    end)
  end
  
  E.LOG.debug(TAG, "get_thumbnail_for_image_uri check_image_need_compress begin")
  check_image_need_compress(source_api, function(need_compress, ...)
    E.LOG.debug(TAG, "get_thumbnail_for_image_uri check_image_need_compress need_compress:" .. tostring(need_compress))
    if nil == need_compress then
      local _code, _msg = ...
      cb(nil, _code, _msg)
    else
      local data = (...)
      if not need_compress then
        E.LOG.debug(TAG, "no need compress, now directly return thumbnail")
        local uint8arr = lunate.to_typedarray(data, "napi_uint8_array")
        cb(uint8arr)
      else
        E.LOG.debug(TAG, "need compress, now begin")
        compress_image_handler()
      end
    end
  end)
end

local function prepare_data_with_platform(_platform, param, cb)
  E.LOG.debug(TAG, "prepare_data_with_platform enter:" .. tostring(_platform))
  local share_data, init_share_record
  if param.message and param.message ~= "" or param.title and "" ~= param.title then
    init_share_record = {}
    init_share_record.utd = "general.plain-text"
    init_share_record.content = param.message
    init_share_record.title = param.title
  end
  E.LOG.debug(TAG, "prepare_data_with_platform enter:" .. tostring(_platform))
  E.log(init_share_record)
  local media_size = param.media and #param.media or 0
  local temp_save_base_path = E.File.get_ext_file_dir()
  local temp_save_file_path_prefix = E.Path.join(temp_save_base_path, "ejoy/temp_share_img_")
  E.LOG.debug(TAG, "temp_save_file_path_prefix:" .. tostring(temp_save_file_path_prefix) .. ", media_size:" .. tostring(media_size))
  local _record_list = {}
  for i = 1, media_size do
    local _item = param.media[i]
    if _item.data then
      local _record
      E.LOG.debug(TAG, "loop media list:" .. tostring(_item.type))
      if _item.type == "image_url" then
        _record = {}
        _record.utd = "general.image"
        local _uri = _item.data
        if E.Utils.start_with(_uri, "file://") then
          _uri = _uri:sub(8)
        end
        local _image_exists = E.File.exists_fullpath(_uri)
        if not _image_exists then
          _record = nil
        else
          local img_path_uri = FURI.getUriFromPath(_uri)
          E.LOG.debug(TAG, "share img uri:" .. tostring(img_path_uri))
          _record.uri = img_path_uri
        end
      elseif _item.type == "file_path" then
        _record = {}
        _record.utd = "general.file"
        local _uri = _item.data
        if E.Utils.start_with(_uri, "file://") then
          _uri = _uri:sub(8)
        end
        local _file_exists = E.File.exists_fullpath(_uri)
        if not _file_exists then
          _record = nil
        else
          local img_path_uri = FURI.getUriFromPath(_uri)
          E.LOG.debug(TAG, "share file uri:" .. tostring(img_path_uri))
          _record.uri = img_path_uri
        end
      elseif _item.type == "image_data" then
        _record = {}
        _record.utd = "general.image"
        local temp_path = temp_save_file_path_prefix .. tostring(i)
        E.File.writefile_fullpath(temp_path, _item.data)
        local img_path_uri = FURI.getUriFromPath(temp_path)
        E.LOG.debug(TAG, "share img uri:" .. tostring(img_path_uri))
        _record.uri = img_path_uri
      end
      if _record then
        table.insert(_record_list, _record)
      end
    else
      E.LOG.warn(TAG, "share item data is nil, skip insert")
    end
  end
  local record_size = #_record_list
  if not init_share_record and 0 == record_size then
    E.LOG.warn(TAG, "prepare_data_with_platform failed, record_size is 0, platform:" .. tostring(_platform))
    cb(nil, false, CC.SHARE_ERROR_CODES.INVALID_PARAMETER, "share data invalid")
    return
  end
  
  local function gen_thumbnails_for_record_list(_cb)
    if record_size > 0 then
      local _idx = 0
      for _, r in ipairs(_record_list) do
        if r.utd == "general.image" then
          get_thumbnail_for_image_uri(r.uri, function(_thumbnail)
            r.thumbnail = _thumbnail
            _idx = _idx + 1
            if _idx >= record_size then
              _cb(true)
            end
          end)
        else
          _idx = _idx + 1
          if _idx >= record_size then
            _cb(true)
          end
        end
      end
    else
      E.LOG.debug(TAG, "remain record list is empty, callback now")
      _cb(true)
    end
  end
  
  gen_thumbnails_for_record_list(function()
    local has_thumbnail = false
    if nil == init_share_record and record_size > 0 then
      init_share_record = table.remove(_record_list, 1)
      E.LOG.debug(TAG, "init record, utd:" .. tostring(init_share_record.utd) .. ", uri:" .. tostring(init_share_record.uri))
    elseif nil == init_share_record then
      E.log(param)
      cb(nil, has_thumbnail, CC.SHARE_ERROR_CODES.INVALID_PARAMETER, "share data invalid")
      return
    end
    share_data = lunate.new_instance(SYS_SHARE.SharedData, init_share_record)
    has_thumbnail = nil ~= init_share_record.thumbnail
    for _, r in ipairs(_record_list) do
      share_data.addRecord(r)
      has_thumbnail = has_thumbnail or nil ~= r.thumbnail
    end
    cb(share_data, has_thumbnail)
  end)
end

local function share_to_system(param, options, cb)
  E.LOG.debug(TAG, "share_to_system begin")
  prepare_data_with_platform(SOCIAL.SHARE_PLATFORM.system_share, param, function(share_data, has_thumbnail, ...)
    if not share_data then
      local _code, _msg = ...
      E.LOG.debug(TAG, "prepare_data_with_platform failed, code:" .. tostring(_code) .. ", _msg:" .. tostring(_msg))
      cb(false, _code, _msg)
    else
      E.LOG.debug(TAG, "prepare_data_with_platform finish, now begin show share pannel")
      local controller = lunate.new_instance(SYS_SHARE.ShareController, share_data)
      options.previewMode = has_thumbnail and 1 or 0
      E.log(options)
      E.LOG.debug(TAG, "prepare_data_with_platform has_thumbnail:" .. tostring(has_thumbnail) .. ", previewMode:" .. tostring(options.previewMode))
      local context = jf.get_context()
      controller.show(context, options)
      controller.on("dismiss", function()
        E.LOG.debug(TAG, "share_to_system finished")
        cb(true)
      end)
    end
  end)
end

local function share_to_platform(_platform, _param, _options, _cb)
end

function M.share(platform, param, callback)
  local show_options = {}
  show_options.previewMode = param.preview_mode or 1
  show_options.selectionMode = param.select_mode or 0
  local _anchor_param = param.anchor or nil
  if _anchor_param then
    show_options.anchor = {
      windowOffset = {
        x = _anchor_param.x,
        y = _anchor_param.y
      },
      size = {
        width = _anchor_param.width,
        height = _anchor_param.height
      }
    }
  end
  if platform == SOCIAL.SHARE_PLATFORM.system_share then
    share_to_system(param, show_options, callback)
  else
    share_to_platform(platform, param, show_options, callback)
  end
end

_ejoysdk.register_ejoysdk_vm_func("share", function(cb, platform, param)
  E.LOG.debug(TAG, "share received:" .. tostring(platform))
  E.log(param)
  compat.xpcall(M.share, function(err)
    E.LOG.warn(TAG, "share failed:" .. tostring(err))
  end, platform, param, cb)
end)
return M
