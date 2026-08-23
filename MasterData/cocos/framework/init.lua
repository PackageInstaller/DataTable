if type(DEBUG) ~= "number" then
	DEBUG = 0
end

printInfo("")
printInfo("# DEBUG                        = " .. DEBUG)
printInfo("#")

device = require("cocos.framework.device")
display = require("cocos.framework.display")
audio = require("cocos.framework.audio")
transition = require("cocos.framework.transition")

require("cocos.framework.extends.NodeEx")
require("cocos.framework.extends.LayerEx")
require("cocos.framework.extends.UtilsEx")

if ccui then
	require("cocos.framework.extends.UIScrollView")
	require("cocos.framework.extends.UITextField")
end

require("cocos.framework.package_support")
cc.register("event", require("cocos.framework.components.event"))

local var_0_0 = _G

cc.exports = {}

setmetatable(cc.exports, {
	__newindex = function(arg_1_0, arg_1_1, arg_1_2)
		rawset(var_0_0, arg_1_1, arg_1_2)
	end,
	__index = function(arg_2_0, arg_2_1)
		return rawget(var_0_0, arg_2_1)
	end
})

function cc.disable_global()
	setmetatable(var_0_0, {
		__newindex = function(arg_4_0, arg_4_1, arg_4_2)
			error(string.format("USE \" cc.exports.%s = value \" INSTEAD OF SET GLOBAL VARIABLE", arg_4_1), 0)
		end
	})
end
