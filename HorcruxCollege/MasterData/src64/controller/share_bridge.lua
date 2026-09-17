local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_1_0)
		arg_1_0()
	end, arg_1_1, false)

	return nil
end

local var_0_2 = {}

if DeviceManager.getPackageChannel() == "FY" then
	function var_0_2.canShare()
		if config.packagechannel ~= "feiyu" then
			return false
		else
			return FySDK and FySDK.getShareChannelArr ~= nil
		end
	end

	function var_0_2.registerShareHandler(arg_4_0)
		if config.packagechannel ~= "feiyu" then
			return
		end

		if FySDK.EventType.CLICKTOAST then
			FySDK.registerEventHandler(FySDK.EventType.CLICKTOAST, arg_4_0)
		else
			var_0_2.sharecallback = arg_4_0
		end
	end

	function var_0_2.doShare(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		if config.packagechannel ~= "feiyu" then
			return
		end

		if arg_5_3 then
			FySDK.shareWeb("-1", arg_5_0, "", arg_5_2, arg_5_3)
		elseif arg_5_1 then
			FySDK.shareImageFilePath("-1", arg_5_0, cc.FileUtils:getInstance():fullPathForFilename(arg_5_1), arg_5_2)
		else
			FySDK.shareText("-1", arg_5_2)
		end

		if not FySDK.EventType.CLICKTOAST then
			var_0_1(function()
				if var_0_2.sharecallback then
					var_0_2.sharecallback(0)
				end
			end, 2)
		end
	end

	function var_0_2.getShareChannelArr()
		if config.packagechannel ~= "feiyu" then
			return {}
		else
			return FySDK.getShareChannelArr()
		end
	end

	function var_0_2.doChannelShare(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		if config.packagechannel ~= "feiyu" then
			return
		end

		if arg_8_4 then
			FySDK.shareWeb(tostring(arg_8_0), arg_8_1, "", arg_8_3, arg_8_4)
		elseif arg_8_2 then
			FySDK.shareImageFilePath(tostring(arg_8_0), arg_8_1, cc.FileUtils:getInstance():fullPathForFilename(arg_8_2), arg_8_3)
		else
			FySDK.shareText(tostring(arg_8_0), arg_8_3)
		end

		var_0_1(function()
			if var_0_2.sharecallback then
				var_0_2.sharecallback(0)
			end
		end, 2)
	end
else
	function var_0_2.canShare()
		if config.packagechannel ~= "feiyu" then
			return false
		else
			return ShareSDK and ShareSDK.getShareChannelArr ~= nil
		end
	end

	function var_0_2.registerShareHandler(arg_11_0)
		if config.packagechannel ~= "feiyu" then
			return
		end

		if ShareSDK and ShareSDK.EventType.CLICKTOAST then
			var_0_2.sharecallback = arg_11_0

			ShareSDK.registerEventHandler(ShareSDK.EventType.CLICKTOAST, arg_11_0)
		else
			var_0_2.sharecallback = arg_11_0
		end
	end

	function var_0_2.doShare(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		if config.packagechannel ~= "feiyu" then
			return
		end

		if not ShareSDK or not ShareSDK.EventType.CLICKTOAST then
			var_0_1(function()
				if var_0_2.sharecallback then
					var_0_2.sharecallback(0)
				end
			end, 0)

			return
		end

		if arg_12_3 then
			ShareSDK.shareWeb("-1", arg_12_0, "", arg_12_2, arg_12_3)
		elseif arg_12_1 then
			ShareSDK.shareImageFilePath("-1", arg_12_0, cc.FileUtils:getInstance():fullPathForFilename(arg_12_1), arg_12_2)
		else
			ShareSDK.shareText("-1", arg_12_2)
		end

		var_0_1(function()
			if var_0_2.sharecallback then
				var_0_2.sharecallback(0)
			end
		end, 2)
	end

	function var_0_2.getShareChannelArr()
		if config.packagechannel ~= "feiyu" then
			return {}
		else
			return ShareSDK and ShareSDK.getShareChannelArr()
		end
	end

	function var_0_2.doChannelShare(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		if config.packagechannel ~= "feiyu" then
			return
		end

		var_0_1(function()
			if var_0_2.sharecallback then
				var_0_2.sharecallback(0)
			end
		end, 2)

		if arg_16_4 then
			ShareSDK.shareWeb(tostring(arg_16_0), arg_16_1, "", arg_16_3, arg_16_4)
		elseif arg_16_2 then
			ShareSDK.shareImageFilePath(tostring(arg_16_0), arg_16_1, cc.FileUtils:getInstance():fullPathForFilename(arg_16_2), arg_16_3)
		else
			ShareSDK.shareText(tostring(arg_16_0), arg_16_3)
		end
	end
end

local var_0_3 = {
	canShare = function()
		return AOKIShare ~= nil
	end
}

function var_0_3.registerShareHandler(arg_19_0)
	if AOKIShare.EventType.CLICKTOAST then
		AOKIShare.registerEventHandler(AOKIShare.EventType.CLICKTOAST, arg_19_0)
	else
		var_0_3.sharecallback = arg_19_0
	end
end

function var_0_3.registerClickToastHandler(arg_20_0)
	var_0_3.clickToastCallback = arg_20_0
end

function var_0_3.doShare(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_3 then
		AOKIShare.showShareViewWithWeb(arg_21_0, arg_21_1 or "", arg_21_2, arg_21_3)
	elseif arg_21_1 then
		AOKIShare.showShareViewWithImageFilePath(arg_21_0, arg_21_1, arg_21_2)
	else
		AOKIShare.showShareViewWithText(arg_21_2)
	end

	if not AOKIShare.EventType.CLICKTOAST then
		var_0_1(function()
			if var_0_3.sharecallback then
				var_0_3.sharecallback(0)
			end
		end, 2)
	end
end

function var_0_3.getShareChannelArr()
	return AOKIShare.getShareChannelArr()
end

function var_0_3.doChannelShare(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_4 then
		AOKIShare.shareWeb(arg_24_0, arg_24_1, arg_24_2 or "", arg_24_3, arg_24_4)
	elseif arg_24_2 then
		AOKIShare.shareImageFilePath(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	else
		AOKIShare.shareText(arg_24_0, arg_24_3)
	end

	var_0_1(function()
		if var_0_3.sharecallback then
			var_0_3.sharecallback(0)
		end
	end, 2)
end

local var_0_4 = {
	canShare = function()
		return true
	end
}

function var_0_4.registerShareHandler(arg_27_0)
	var_0_4.sharecallback = arg_27_0
end

function var_0_4.doShare()
	var_0_1(function()
		if var_0_4.sharecallback then
			var_0_4.sharecallback(0)
		end
	end, 2)
end

function var_0_4.getShareChannelArr()
	return {}
end

function var_0_4.doChannelShare()
	var_0_1(function()
		if var_0_4.sharecallback then
			var_0_4.sharecallback(0)
		end
	end, 2)
end

if DeviceManager.platform == "android" then
	setmetatable(var_0_0, {
		__index = var_0_2
	})
elseif DeviceManager.platform == "ios" then
	setmetatable(var_0_0, {
		__index = var_0_3
	})
else
	setmetatable(var_0_0, {
		__index = var_0_4
	})
end

return var_0_0
