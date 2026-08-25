local jf = lunate.js_functions
local EC = require("ejoysdk_lua.ejoysdk_constants")
local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
local BitUtil = COMPAT.bitutil
local M = {}
local TAG = "ejoysdk_vm_func"
local WEB_PAGE_LIFECYCLE = {
  ON_PAGE_START = 0,
  ON_PAGE_FINISH = 1,
  ON_PAGE_ERROR = 2,
  ON_PAGE_CLOSE = 3,
  ON_PAGE_PERFORMANCE = 4,
  ON_PAGE_OPEN_APP = 5
}
_ejoysdk.register_ejoysdk_vm_func("webview_callback_js", function(js_cb_id, message, ext)
  jf.webview():callbackJs(js_cb_id, message, ext)
end)
_ejoysdk.register_ejoysdk_vm_func("webview_is_opened", function(cb)
  local is_opened = jf.webview():isOpened()
  cb(is_opened)
end)
_ejoysdk.register_ejoysdk_vm_func("webview_go_back", function()
  jf.webview():goBack()
end)
_ejoysdk.register_ejoysdk_vm_func("webview_go_forward", function()
  jf.webview():goForward()
end)
_ejoysdk.register_ejoysdk_vm_func("webview_reload", function()
  jf.webview():reloadPage()
end)
_ejoysdk.register_ejoysdk_vm_func("webview_open", function(cb, url, injection, option)
  jf.webview():open(url, injection, option, {
    onJsArgsEvent = function(_value)
      local value = lunate.deepcopy(_value)
      if value and value.args then
        if value.args.type == "oauthUri" then
          cb("logindone", value)
        else
          cb("webview_jsargs", value)
        end
      end
    end,
    onCloseEvent = function(_value)
      local value = lunate.deepcopy(_value)
      cb("webview_close", value)
    end,
    onUrlRedirectEvent = function(_value)
      local value = lunate.deepcopy(_value)
      cb("webview_url_redirect", value)
    end,
    onLifeCycleEvent = function(_value)
      local value = lunate.deepcopy(_value) or {}
      local WE = require("ejoysdk_lua.ejoysdk_webview_event")
      if value.type == WEB_PAGE_LIFECYCLE.ON_PAGE_FINISH then
        WE.on_page_lifecycle(value)
      elseif value.type == WEB_PAGE_LIFECYCLE.ON_PAGE_ERROR then
        WE.on_entry_url_load_error(value)
      elseif value.type == WEB_PAGE_LIFECYCLE.ON_PAGE_OPEN_APP then
        WE.open_app(value)
      end
      cb("webview_life_cycle", value)
    end
  })
end)
_ejoysdk.register_ejoysdk_vm_func("webview_close", function()
  jf.webview():close()
end)
_ejoysdk.register_ejoysdk_vm_func("webview_remove_cache", function(_cb, params)
  jf.webview():destroy(params)
end)

function M.modal_open(title, option, cb)
  _ejoysdk.log("modal_open receive")
  jf.modal():open(title, option, {
    onClick = function(index)
      if cb then
        cb(index)
      end
      jf.modal():close()
    end
  })
end

_ejoysdk.register_ejoysdk_vm_func("modal_open", M.modal_open)
_ejoysdk.register_ejoysdk_vm_func("modal_close", function()
  jf.modal():close()
end)
_ejoysdk.register_ejoysdk_vm_func("sysinfo_get_user_agent", function(cb)
  cb(jf.utils():getDeviceInfoList().useragent)
end)
_ejoysdk.register_ejoysdk_vm_func("unisdk_init", function(cb, params)
  local E = require("ejoysdk_lua.ejoysdk")
  local EVT_LOGIN = E.UNISDK_EVENT_ID.EVT_LOGIN
  local EVT_LOGOUT = E.UNISDK_EVENT_ID.EVT_LOGOUT
  local EVT_PAY = E.UNISDK_EVENT_ID.EVT_PAY
  local EVT_INIT = E.UNISDK_EVENT_ID.EVT_INIT
  local EVT_EXIT = E.UNISDK_EVENT_ID.EVT_EXIT
  local unisdk_init_cb = {
    onInit = function(v)
      local value = lunate.deepcopy(v)
      cb(EVT_INIT, value)
    end,
    onLogin = function(v)
      local value = lunate.deepcopy(v)
      cb(EVT_LOGIN, value)
    end,
    onLogout = function(v)
      local value = lunate.deepcopy(v)
      cb(EVT_LOGOUT, value)
    end,
    onPay = function(v)
      local value = lunate.deepcopy(v)
      cb(EVT_PAY, value)
    end,
    onExit = function(v)
      local value = lunate.deepcopy(v)
      cb(EVT_EXIT, value)
    end
  }
  _ejoysdk.log("register_ejoysdk_vm_func unisdk_init")
  jf.EjoySDK():initUnisdk(params, unisdk_init_cb)
end)
_ejoysdk.register_ejoysdk_vm_func("unisdk_login", function(channel, params)
  jf.EjoySDK():login(channel, params)
end)
_ejoysdk.register_ejoysdk_vm_func("unisdk_logout", function(channel, params)
  jf.EjoySDK():logout(channel, params)
end)
_ejoysdk.register_ejoysdk_vm_func("unisdk_pay", function(channel, order_id, params)
  jf.EjoySDK():pay(channel, order_id, params)
end)
_ejoysdk.register_ejoysdk_vm_func("unisdk_exit", function(channel)
  jf.EjoySDK():exit(channel)
end)
_ejoysdk.register_ejoysdk_vm_func("unisdk_set_player_info", function(channel, type, params)
  jf.EjoySDK():setPlayerInfo(channel, type, params)
end)

local function unisdk_async_call(cb, params, chunk)
  local async_call_cb = {
    onAsyncCallback = function(resp_params, resp_chunk)
      cb(lunate.deepcopy(resp_params), resp_chunk)
    end
  }
  if not chunk then
    jf.EjoySDK():unisdkAsyncCall(params, nil, async_call_cb)
  else
    assert(type(chunk) == "string", "chunk must be string: " .. tostring(chunk))
    jf.EjoySDK():unisdkAsyncCall(params, lunate.to_array_buffer(chunk), async_call_cb)
  end
end

function M.async_call(channel, type, params, chunk, cb)
  params = params or {}
  params.channel = channel
  params.type = type
  unisdk_async_call(function(body, resp_chunk)
    if not cb then
      return
    end
    if 0 == body.code then
      cb(true, body.body, resp_chunk)
    else
      cb(false, body.code, body.body, resp_chunk)
    end
  end, params, chunk)
end

_ejoysdk.register_ejoysdk_vm_func("unisdk_async_call", unisdk_async_call)
_ejoysdk.register_ejoysdk_vm_func("unisdk_cast", function(params, chunk)
  if not chunk then
    jf.EjoySDK():unisdkCast(params)
  else
    assert(type(chunk) == "string", "chunk must be string: " .. tostring(chunk))
    jf.EjoySDK():unisdkCast(params, lunate.to_array_buffer(chunk))
  end
end)
_ejoysdk.register_ejoysdk_vm_func("qrcode_scan", function(cb)
  local QR_ERR_BASE = 2000
  local ERR_SCAN_INTERNAL_EXCEPTION = QR_ERR_BASE + 0
  local ERR_SCAN_CANCELLED = QR_ERR_BASE + 6
  local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
  local scanBarcode = jf.import("@hms.core.scan.scanBarcode")
  local context = jf.get_context()
  
  local function callback(err, result)
    if err then
      _ejoysdk.log("start qrcode scan fail, code is " .. tostring(err.code) .. ", msg is " .. tostring(err.message))
      if err.code == 1000500001 then
        cb(false, ERR_SCAN_INTERNAL_EXCEPTION, "Internal error.")
      elseif err.code == 1000500002 then
        cb(false, ERR_SCAN_CANCELLED, "The user canceled the barcode scanning.")
      else
        cb(false, CONSTANTS.QRCODE_ERROR_CODES.CODE_SCAN_ERROR, "hms qrcode scan error, code is " .. tostring(err.code) .. ", msg is " .. tostring(err.message))
      end
    else
      cb(true, result.originalValue)
    end
  end
  
  local ret = pcall(scanBarcode.startScanForResult, context, callback)
  if not ret then
    cb(false, CONSTANTS.QRCODE_ERROR_CODES.CODE_SCAN_ERROR, "an exception occurred when hms call qrcode scan")
  end
end)
_ejoysdk.register_ejoysdk_vm_func("go_to_app_market", function(package_name)
  local productViewManager = jf.import("@hms.core.appgalleryservice.productViewManager")
  local context = jf.get_context()
  local wantInfo = {
    parameters = {bundleName = package_name}
  }
  productViewManager.loadProduct(context, wantInfo, {
    onError = function(error)
      _ejoysdk.log("loadProduct callback: " .. tostring(error.code))
    end
  })
end)
_ejoysdk.register_ejoysdk_vm_func("load_module", function(cb, module_name)
  _ejoysdk.log("call load_module >> " .. tostring(module_name) .. ", and type is " .. type(module_name))
  if type(module_name) == "string" then
    local ok, _ = pcall(require, module_name)
    _ejoysdk.log("load " .. tostring(module_name) .. ", result >> " .. tostring(ok))
    cb(ok)
  else
    _ejoysdk.log("load module error, module_name is wrong")
    cb(false)
  end
end)
_ejoysdk.register_ejoysdk_vm_func("set_app_orientation", function(orientation)
  if jf.utils().setAppOrientation then
    jf.utils():setAppOrientation(orientation)
  end
end)

function M.get_stage_window_size(cb)
  local window_stage = jf.EjoySDK():getWindowStage()
  if not window_stage then
    _ejoysdk.log("get_stage_window_size failed, stage is nil")
    cb(nil)
    return
  end
  local ok, window = pcall(window_stage.getMainWindowSync)
  if not ok then
    _ejoysdk.log("get_stage_window_size failed, getMainWindowSync failed")
    cb(nil)
    return
  end
  local properties
  ok, properties = pcall(window.getWindowProperties)
  if not ok then
    _ejoysdk.log("get_stage_window_size failed, getWindowProperties failed")
    cb(nil)
    return
  end
  local win_rect = properties.windowRect
  _ejoysdk.log("get_stage_window_size succ x:" .. tostring(win_rect.left) .. ", y:" .. tostring(win_rect.top) .. ", width:" .. tostring(win_rect.width) .. ", height:" .. tostring(win_rect.height))
  cb({
    x = win_rect.left,
    y = win_rect.top,
    width = win_rect.width,
    height = win_rect.height
  })
end

function M.get_wifi_info(cb)
  local wifi_mgr = lunate.import("@ohos.wifiManager")
  local wifi_data = {}
  local E = require("ejoysdk_lua.ejoysdk")
  E.Permission.detect_permission("ohos.permission.GET_WIFI_INFO", function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "detect_permission GET_WIFI_INFO succ")
      wifi_mgr.getLinkedInfo():Then(function(link_info)
        wifi_data.ssid = link_info.ssid
        wifi_data.speed = link_info.rxLinkSpeed
        cb(wifi_data)
      end):catch(function(error)
        E.LOG.warn(TAG, "getLinkedInfo failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
        cb(wifi_data)
      end)
    else
      E.LOG.warn(TAG, "detect_permission GET_WIFI_INFO failed, GET_WIFI_INFO permission not granted")
      cb(wifi_data)
    end
  end)
end

function M.save_to_album(_path, _need_delete, _cb)
  local E = require("ejoysdk_lua.ejoysdk")
  local fs = lunate.import("@ohos.file.fs")
  local SAVE_ALBUM_SUCC = 1
  local SAVE_ALBUM_FAIL = -99
  local SAVE_ALBUM_FILE_NOT_EXIST = -97
  if fs.accessSync(_path) then
    E.LOG.debug(TAG, "save_album##_path=" .. _path)
    local ctx = jf.get_context()
    local PhotoAccessHelper = lunate.import("@ohos.file.photoAccessHelper")
    local photoHelper = PhotoAccessHelper.getPhotoAccessHelper(ctx)
    local BundleManager = lunate.import("@ohos.bundle.bundleManager")
    local formatPath = "file://" .. BundleManager.getBundleInfoForSelfSync(0).name .. _path
    E.LOG.debug(TAG, "save_album##formatPath=" .. formatPath)
    photoHelper.showAssetsCreationDialog({formatPath}, {
      {
        fileNameExtension = "jpg",
        photoType = PhotoAccessHelper.PhotoType.IMAGE
      }
    }).Then(function(desFileUris)
      local savedUri = tostring(desFileUris[1])
      E.LOG.debug(TAG, "save_album##res=" .. savedUri)
      if E.Utils.start_with(savedUri, "file://") then
        local source_file = fs.openSync(_path, fs.OpenMode.READ_WRITE)
        local source_file_stat = fs.statSync(_path)
        local buffer = lunate.create_array_buffer(source_file_stat.size)
        fs.readSync(source_file.fd, buffer)
        local target_file = fs.openSync(savedUri, fs.OpenMode.READ_WRITE)
        fs.writeSync(target_file.fd, buffer)
        fs.closeSync(source_file.fd)
        fs.closeSync(target_file.fd)
        if _need_delete then
          fs.unlinkSync(_path)
        end
        _cb({
          code = SAVE_ALBUM_SUCC,
          msg = "保存成功",
          uri = savedUri
        })
      else
        _cb({
          code = SAVE_ALBUM_FAIL,
          msg = "保存失败, 用户拒绝保存"
        })
      end
    end).catch(function(err)
      E.LOG.debug(TAG, "save_album##err=" .. tostring(err.message))
      _cb({
        code = SAVE_ALBUM_FAIL,
        msg = "保存失败"
      })
    end)
  else
    _cb({
      code = SAVE_ALBUM_FILE_NOT_EXIST,
      msg = "保存失败,文件路径不存在"
    })
  end
end

function M.save_data_album(array_buffer, cb)
  local E = require("ejoysdk_lua.ejoysdk")
  local temp_img_fullpath = E.Path.join(E.File.get_ext_file_dir(), "_save_album_temp", "img_temp")
  local result = E.Path.ensure_parent_dir(temp_img_fullpath)
  result = result and E.File.writefile_fullpath(temp_img_fullpath, array_buffer)
  if result then
    M.save_to_album(temp_img_fullpath, true, function(_data)
      local _uri = _data.uri
      if _uri then
        E.LOG.debug(TAG, "save_data_album succ:" .. tostring(_uri))
        cb(true, _uri)
      else
        local code, msg = _data.code, _data.msg
        E.LOG.warn(TAG, "save_data_album failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, code, msg)
      end
    end)
  else
    E.LOG.warn(TAG, "save_data_album failed, writefile_fullpath failed:" .. tostring(temp_img_fullpath))
    cb(false, EC.MEDIA_ERROR.CODE_FILE_CREATE_FAILED, "create file failed")
  end
end

function M.save_data_to_documents(array_buffer, cb)
  local E = require("ejoysdk_lua.ejoysdk")
  local file_name = os.date("%y%m%d%H%M%S", E.time()) .. ".png"
  local audio_save_options = {
    newFileNames = {file_name}
  }
  _ejoysdk.log("save_data_album filename:" .. tostring(file_name))
  local picker = lunate.import("@ohos.file.picker")
  local picker_instance = lunate.new_instance(picker.PhotoViewPicker)
  picker_instance.save(audio_save_options):Then(function(uri_arr)
    if nil == uri_arr then
      E.LOG.warn(TAG, "picker uri is nil")
      cb(false, EC.BASE_API_COMMON_ERROR.CODE_PICKER_URI_NIL, "picker uri is nil")
      return
    end
    local uri = uri_arr[1]
    E.log("save result: " .. tostring(uri))
    local fs = lunate.import("@ohos.file.fs")
    local err_msg
    local ret, file = COMPAT.xpcall(fs.openSync, function(err)
      E.LOG.warn(TAG, "open failed:" .. tostring(err))
      err_msg = tostring(err)
    end, uri, BitUtil.bor(fs.OpenMode.READ_WRITE, fs.OpenMode.CREATE))
    if not ret or not file then
      cb(false, EC.EJOY_LIB_ERROR.FILE_OPEN_FAILED, err_msg)
      return
    end
    local stream
    ret, stream = COMPAT.xpcall(fs.fdopenStreamSync, function(err)
      E.LOG.warn(TAG, "fdopenStreamSync failed:" .. tostring(err))
      err_msg = tostring(err)
    end, file.fd, "w+")
    if not ret or not stream then
      cb(false, EC.EJOY_LIB_ERROR.FILE_OPEN_FAILED, "file open failed:" .. tostring(err_msg))
      fs.closeSync(file)
      return
    end
    ret = COMPAT.xpcall(stream.writeSync, function(err)
      E.LOG.warn(TAG, "writeSync failed:" .. tostring(err))
      err_msg = tostring(err)
    end, lunate.to_array_buffer(array_buffer), {
      offset = 0,
      length = #array_buffer,
      encoding = "utf-8"
    })
    fs.closeSync(file)
    stream:close()
    if not ret then
      cb(false, EC.EJOY_LIB_ERROR.FILE_WRITE_FILE_FAILED, "write image data failed:" .. tostring(err_msg))
      return
    else
      _ejoysdk.log("save_data_album writeSync succ:" .. tostring(uri))
    end
    cb(true, uri)
  end):catch(function(error)
    _ejoysdk.log(TAG .. " save failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end

local function pixelmap_2_bytearr(readonly_pixel_map, cb)
  local image = lunate.import("@ohos.multimedia.image")
  local E = require("ejoysdk_lua.ejoysdk")
  
  local function to_readable_pixel_map(cb1)
    E.LOG.debug(TAG, "to_readable_pixel_map begin")
    local bytes_count = readonly_pixel_map.getPixelBytesNumber()
    readonly_pixel_map.getImageInfo():Then(function(image_info)
      if not image_info then
        cb(nil, EC.MEDIA_ERROR.CODE_IMAGE_INFO_NIL, "image_info is nil")
        return
      end
      local data_buffer = lunate.create_array_buffer(bytes_count)
      readonly_pixel_map.readPixelsToBuffer(data_buffer):Then(function()
        _ejoysdk.log("capture_webview pixel map to array buffer succ, size:" .. tostring(bytes_count))
        local empty_buffer = lunate.create_array_buffer(bytes_count)
        local pixel_map_opts = {
          editable = true,
          pixelFormat = 3,
          size = {
            width = image_info.size.width,
            height = image_info.size.height
          }
        }
        image.createPixelMap(empty_buffer, pixel_map_opts):Then(function(editable_pixel_map)
          editable_pixel_map.writeBufferToPixels(data_buffer):Then(function()
            _ejoysdk.log("writeBufferToPixels succ:" .. tostring(editable_pixel_map.getPixelBytesNumber()))
            cb1(editable_pixel_map)
          end):catch(function(error)
            _ejoysdk.log(TAG .. " writeBufferToPixels failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
            cb1(nil, error.code, error.message)
          end)
        end):catch(function(error)
          _ejoysdk.log(TAG .. " capture_webview failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
          cb1(nil, error.code, error.message)
        end)
      end)
    end)
  end
  
  local function pack_to_png(editable_pixelmap, cb2)
    E.LOG.debug(TAG, "pack_to_png begin")
    local image_packer = image.createImagePacker()
    local pack_options = {format = "image/png", quality = 100}
    E.LOG.debug(TAG, "compress_image begin, required_quality:" .. tostring(pack_options.quality))
    image_packer.packing(editable_pixelmap, pack_options):Then(function(data)
      _ejoysdk.log("pack_to_png succ, size:" .. tostring(#data))
      editable_pixelmap.release()
      image_packer.release():Then(function()
        cb2(data)
      end):catch(function(error)
        E.LOG.warn(TAG, "image_packer release failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
        cb2(nil, false, error.code, error.message)
      end)
    end):catch(function(error)
      E.LOG.warn(TAG, "check_image_need_compress packing failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
      cb2(nil, error.code, error.message)
    end)
  end
  
  to_readable_pixel_map(function(pixelmap, ...)
    if pixelmap then
      E.LOG.debug(TAG, "to_readable_pixel_map succ, pack_to_png begin")
      pack_to_png(pixelmap, function(data, ...)
        cb(data, ...)
      end)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "to_readable_pixel_map failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(nil, code, msg)
    end
  end)
end

function M.capture_webview(cb)
  local E = require("ejoysdk_lua.ejoysdk")
  _ejoysdk.log("capture_webview received")
  local web_win
  if jf.webview().getWebWin then
    web_win = jf.webview():getWebWin()
  end
  if not web_win then
    _ejoysdk.log(TAG .. " capture_webview failed, webview window not found")
    cb(false, EC.EJOYSDK_ERROR_CODES.WINDOW_NOT_EXISTS, "webview winow not exists")
    return
  end
  _ejoysdk.log("capture_webview snapshot begin")
  web_win.snapshot():Then(function(pixel_map)
    _ejoysdk.log("capture_webview snapshot received pixcel_map")
    pixelmap_2_bytearr(pixel_map, function(data, ...)
      if data then
        E.LOG.debug(TAG, "pixelmap_2_bytearr succ, begin save_data_album, data size:" .. tostring(#data))
        M.save_data_album(data, function(succ, ...)
          pixel_map.release()
          cb(succ, ...)
        end)
      else
        local code, msg = ...
        cb(false, code, msg)
      end
    end)
  end):catch(function(error)
    _ejoysdk.log(TAG .. " capture_webview failed, code:" .. tostring(error.code) .. ", msg:" .. tostring(error.message))
    cb(false, error.code, error.message)
  end)
end

return M
