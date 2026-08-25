local Recorder = require("ejoysdk_lua.harmonyos.media.audio")
local Player = require("ejoysdk_lua.harmonyos.media.player")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local TAG = "harmonyos#media"

function M.start_record(cb, opts)
  E.LOG.debug(TAG, "start_record received")
  Recorder.start_record(opts, cb)
end

function M.stop_record(cb)
  E.LOG.debug(TAG, "stop_record received")
  Recorder.stop_record(cb)
end

function M.start_play(opts, cb)
  E.LOG.debug(TAG, "start_play received")
  Player.start_play(opts, cb)
end

function M.stop_play(opts, cb)
  E.LOG.debug(TAG, "stop_play received")
  Player.stop_play(opts, cb)
end

function M.delete(params, cb)
  E.LOG.debug(TAG, "delete received")
  Recorder.delete(params, cb)
end

return M
