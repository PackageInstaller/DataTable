local var_0_0 = {}
local urls = require("controller.filedownloader.urls.urls")
local testurls = require("controller.filedownloader.urls.testurls")
local var_0_3 = cc.UserDefault:getInstance():getIntegerForKey("selecturl", 1)

function var_0_0.getDownloadURLList(arg_1_0)
	return var_0_3, (DeviceManager.platform == "windows" or nil) and (testurls or urls)
end

function var_0_0.selectDownloadURL(arg_2_0, arg_2_1)
	if DeviceManager.platform == "windows" then
		if not (testurls or urls)[arg_2_1] then
			return
		end
	end

	var_0_3 = arg_2_1
end

function var_0_0.getDownloadURL(arg_3_0)
	if DeviceManager.platform == "windows" then
		return testurls[var_0_3][2]
	elseif cc.Native.useAntiHexieResource then
		if cc.Native:useAntiHexieResource() then
			return urls[var_0_3][2]
		else
			return urls[var_0_3][3]
		end
	else
		return urls[var_0_3][2]
	end
end

return var_0_0
