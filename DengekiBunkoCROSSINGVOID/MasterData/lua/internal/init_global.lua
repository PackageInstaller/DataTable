require("Internal/extension")
require("Internal/log")
require("Internal/strict")
require("Internal/secure")
strict(_G)
return function(types, luaManager)
  require("Internal/indexer_patch")(types)
  local GC = require("Internal/gc")
  luaManager.DoChunk = require("Internal/do_chunk")
  
  function luaManager.CollectGarbage()
    GC:collect()
  end
  
  luaManager.CreateSandbox, luaManager.DestroySandbox = unpack(require("Internal/sandbox"))
  luaManager.JsonDecode, luaManager.JsonEncode = unpack(require("Internal/json"))
  luaManager.ProtobufEncode, luaManager.ProtobufDecode = unpack(require("Internal/protobuf"))
  GC:restart()
end
