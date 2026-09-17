package.path = "./examples/?.lua;" .. package.path

local sprotoparser = require("sprotoparser")
local sprotoloader = require("sprotoloader")
local proto = require("proto")

require("skynet").start(function()
	sprotoloader.save(proto.c2s, 1)
	sprotoloader.save(proto.s2c, 2)
end)
