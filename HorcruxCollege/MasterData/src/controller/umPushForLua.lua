return {
	addTags = function(arg_1_0, arg_1_1)
		if DeviceManager.platform == "android" then
			return
		end

		umeng_addTags(arg_1_0, arg_1_1)
	end,
	deleteTags = function(arg_2_0, arg_2_1)
		if DeviceManager.platform == "android" then
			return
		end

		umeng_deleteTags(arg_2_0, arg_2_1)
	end,
	getTags = function(arg_3_0)
		if DeviceManager.platform == "android" then
			return
		end

		umeng_getTags(arg_3_0)
	end,
	addAlias = function(arg_4_0, arg_4_1, arg_4_2)
		if DeviceManager.platform == "android" then
			return
		end

		umeng_addAlias(arg_4_0, arg_4_1, arg_4_2)
	end,
	setAlias = function(arg_5_0, arg_5_1, arg_5_2)
		if DeviceManager.platform == "android" then
			return
		end

		umeng_setAlias(arg_5_0, arg_5_1, arg_5_2)
	end,
	removeAlias = function(arg_6_0, arg_6_1, arg_6_2)
		if DeviceManager.platform == "android" then
			return
		end

		umeng_removeAlias(arg_6_0, arg_6_1, arg_6_2)
	end
}
