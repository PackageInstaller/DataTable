return {
	setLogEnabled = function(arg_1_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_setLogEnabled(arg_1_0)
	end,
	setCheckDevice = function(arg_2_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_setCheckDevice(arg_2_0)
	end,
	setSessionIdleLimit = function(arg_3_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_setSessionIdleLimit(arg_3_0)
	end,
	setEncryptEnabled = function(arg_4_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_setEncryptEnabled(arg_4_0)
	end,
	event = function(arg_5_0, ...)
		if DeviceManager.platform ~= "android" then
			return
		end
	end,
	beginLogPageView = function(arg_6_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_beginLogPageView(arg_6_0)
	end,
	endLogPageView = function(arg_7_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_endLogPageView(arg_7_0)
	end,
	profileSignIn = function(arg_8_0, ...)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_profileSignIn(arg_8_0, ...)
	end,
	profileSignOff = function()
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_profileSignOff()
	end,
	setUserLevel = function(arg_10_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_setUserLevel(arg_10_0)
	end,
	startLevel = function(arg_11_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_startLevel(arg_11_0)
	end,
	finishLevel = function(arg_12_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_finishLevel(arg_12_0)
	end,
	failLevel = function(arg_13_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_failLevel(arg_13_0)
	end,
	pay = function(arg_14_0, arg_14_1, ...)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_pay(arg_14_0, arg_14_1, ...)
	end,
	buy = function(arg_15_0, arg_15_1, arg_15_2)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_buy(arg_15_0, arg_15_1, arg_15_2)
	end,
	use = function(arg_16_0, arg_16_1, arg_16_2)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_use(arg_16_0, arg_16_1, arg_16_2)
	end,
	bonus = function(...)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_bonus(...)
	end,
	exchange = function(...)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_exchange(...)
	end,
	setLatency = function(arg_19_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_setLatency(arg_19_0)
	end,
	track = function(arg_20_0, ...)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_dplus_track(arg_20_0, ...)
	end,
	registerSuperProperty = function(arg_21_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_dplus_registerSuperProperty(arg_21_0)
	end,
	unregisterSuperProperty = function(arg_22_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_dplus_unregisterSuperProperty(arg_22_0)
	end,
	getSuperProperty = function(arg_23_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		return umeng_dplus_getSuperProperty(arg_23_0)
	end,
	getSuperProperties = function()
		if DeviceManager.platform ~= "android" then
			return
		end

		return umeng_dplus_getSuperProperties()
	end,
	clearSuperProperties = function()
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_dplus_clearSuperProperties()
	end,
	setFirstLaunchEvent = function(arg_26_0)
		if DeviceManager.platform ~= "android" then
			return
		end

		umeng_dplus_setFirstLaunchEvent(arg_26_0)
	end
}
