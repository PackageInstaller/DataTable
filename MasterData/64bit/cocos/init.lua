if jit then
	jit.off()
	jit.flush()
end

require("cocos.cocos2d.Cocos2d")
require("cocos.cocos2d.Cocos2dConstants")
require("cocos.cocos2d.functions")
require("cocos.cocos2d.Opengl")
require("cocos.cocos2d.OpenglConstants")
require("cocos.network.NetworkConstants")

if sp ~= nil then
	require("cocos.spine.SpineConstants")
end

require("cocos.cocos2d.bitExtend")
require("cocos.cocos2d.bit64Extend")

if CC_USE_FRAMEWORK then
	require("cocos.framework.init")
end

local cjson = require("cocos.cocos2d.cjson")

json = cjson and cjson or require("cocos.cocos2d.json")
