local newdecoder = require("ejoysdk_lua.libs.lunajson.decoder")
local newencoder = require("ejoysdk_lua.libs.lunajson.encoder")
local sax = require("ejoysdk_lua.libs.lunajson.sax")
return {
  decode = newdecoder(),
  encode = newencoder(),
  newparser = sax.newparser,
  newfileparser = sax.newfileparser
}
