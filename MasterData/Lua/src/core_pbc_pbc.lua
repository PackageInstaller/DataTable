local pb = require("core.pbc.protobuf")
local tag = "pbc"
local pbc = {}
local c = require("protobuf.c")
local MsgGenCode = require("proto.MsgGenCode")
pbc.PB_FILE_KEYS = {
  "proto/CommonMsg.pb.bytes",
  "proto/Core.pb.bytes",
  "proto/CSCore.pb.bytes",
  "proto/GMMsg.pb.bytes",
  "proto/Shop.pb.bytes"
}

function pbc:initialize(options)
  for i, v in ipairs(options.bytes) do
    if v ~= nil then
      pb.register(v)
    end
  end
end

function pbc:encode(id, data)
  if data == nil then
    return nil
  end
  local protoName = MsgGenCode.req[id]
  if protoName == nil then
    return nil
  end
  return pb.encode(protoName, data)
end

function pbc:decode(id, data)
  if data == nil then
    return nil
  end
  local protoName = MsgGenCode.rsp[id]
  if protoName == nil then
    return nil
  end
  return pb.decode(protoName, data)
end

return pbc
