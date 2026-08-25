local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local AD = require("ejoysdk_lua.harmonyos.media.audio")
local M = {}
local TAG = "harmony_player"
local DEFAULT_FILE_NAME = "noname"
local jf = lunate.js_functions
local playing_player

local function setPlayerFdSrc(player, params, cb)
  local fs = jf.import("@ohos.file.fs")
  local record_dir = AD.get_record_dir()
  local media_path = E.Path.join(record_dir, params.filename)
  media_path = media_path .. "." .. params.format
  local ret, file = pcall(fs.openSync, media_path, fs.OpenMode.READ_ONLY)
  if not (ret and file) or not file.fd then
    E.LOG.warn(TAG, "play failed file open failed, path:" .. tostring(media_path))
    cb(false, EC.MEDIA_ERROR.CODE_MEDIA_FILE_NOT_EXISTS, "media file not exists")
    return
  end
  E.LOG.debug(TAG, "play set fdsrc:" .. tostring(media_path))
  player.fdSrc = {
    fd = file.fd
  }
end

local function release_player(cb)
  if not playing_player then
    E.LOG.warn(TAG, "playing player is nil")
    cb(true)
    return
  end
  playing_player.release(function(_err)
    local succ, code, msg
    if not _err then
      succ = true
      E.LOG.debug(TAG, "release succ")
    else
      succ = false
      code = _err.code
      msg = _err.message
      E.LOG.warn("release error, code >> " .. tostring(code) .. ", message >> " .. tostring(msg))
    end
    playing_player = nil
    cb(succ, code, msg)
  end)
end

function M.start_play(opts, cb)
  opts = opts or {}
  local start_info = {succ = true, message = nil}
  local format = "amr"
  if opts.format and opts.format ~= "auto" then
    format = opts.format
  end
  local params = {
    filename = opts.filename or DEFAULT_FILE_NAME,
    format = format,
    volume = opts.volume or 1.0,
    finish_cb = opts.finish_cb or function()
      E.LOG.debug(TAG, "play finished")
    end
  }
  E.log("start_play params >>")
  E.log(params)
  local media_kit = lunate.import("@ohos.multimedia.media")
  media_kit.createAVPlayer():Then(function(player)
    if player then
      E.LOG.debug(TAG, "create player succ, set volume:" .. tostring(params.volume))
      player.on("stateChange", function(state, reason)
        E.LOG.debug(TAG, "stateChange received, state:" .. tostring(state) .. ", reason:" .. tostring(reason))
        if "initialized" == state then
          playing_player = player
          player.prepare():Then(function()
            E.LOG.debug(TAG, "play begin:" .. tostring(params.volume))
            player.setVolume(params.volume)
            player.play()
            start_info.succ = true
            start_info.message = nil
            if cb then
              cb(start_info)
            end
          end):catch(function(error)
            local _code = error.code
            local _msg = error.message
            E.LOG.warn("player prepare error, code >> " .. tostring(_code) .. ", message >> " .. tostring(_msg))
            start_info.succ = false
            start_info.message = _msg
            if cb then
              cb(start_info)
            end
          end)
        elseif "error" == state then
          E.LOG.warn(TAG, "player received error")
        elseif "completed" == state then
          E.LOG.debug(TAG, "player completed")
          params.finish_cb()
        end
      end)
      setPlayerFdSrc(player, params, function(succ, ...)
        if succ then
          E.LOG.debug(TAG, "play succ")
        else
          local _code, _msg = ...
          E.LOG.warn(TAG, "play failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
          if cb then
            start_info.succ = false
            start_info.message = _msg
            cb(start_info)
          end
        end
      end)
    else
      E.LOG.warn(TAG, "create player failed, player is nil")
      if cb then
        start_info.succ = false
        start_info.message = "player is nil"
        cb(start_info)
      end
    end
  end):catch(function(error)
    local _code = error.code
    local _msg = error.message
    E.LOG.warn("createAVPlayer error, code >> " .. tostring(error.code) .. ", message >> " .. tostring(error.message))
    if cb then
      start_info.succ = false
      start_info.message = _msg
      cb(start_info)
    end
  end)
end

function M.stop_play(_opts, cb)
  local resp = {was_playing = false}
  if not playing_player then
    E.LOG.warn(TAG, "not playing, skip stop")
    if cb then
      cb(resp)
    end
    return
  end
  resp.was_playing = true
  playing_player.stop(function(err)
    if not err then
      E.LOG.debug(TAG, "stop succ")
    else
      local _code = err.code
      local _msg = err.message
      E.LOG.warn("stop error, code >> " .. tostring(_code) .. ", message >> " .. tostring(_code))
    end
    release_player(function(_succ, ...)
      if cb then
        cb(resp)
      end
    end)
  end)
end

return M
