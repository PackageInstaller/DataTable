local var_0_0 = class("ServerNoticeProxy", import(".NetProxy"))

var_0_0.SERVER_NOTICES_UPDATE = "server notices update"
var_0_0.KEY_NEWLY_ID = "server_notice.newly_id"
var_0_0.KEY_STOP_REMIND = "server_notice.dont_remind"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:on(11300, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.notice_list) do
			local var_2_0 = false

			for iter_2_2 = 1, #arg_1_0.data do
				if arg_1_0.data[iter_2_2].id == iter_2_1.id then
					arg_1_0.data[iter_2_2] = ServerNotice.New(iter_2_1)
					var_2_0 = true

					break
				end
			end

			if not var_2_0 then
				if #arg_2_0.notice_list == 1 then
					table.insert(arg_1_0.data, 1, ServerNotice.New(iter_2_1))
				else
					table.insert(arg_1_0.data, ServerNotice.New(iter_2_1))
				end
			end
		end

		arg_1_0:sendNotification(var_0_0.SERVER_NOTICES_UPDATE)

		return
	end)

	return
end

function var_0_0.testData(arg_3_0, arg_3_1)
	table.insert(arg_3_1, ServerNotice.New({
		time_des = "2018/08/23",
		title_image = "<config type = 2 param = {'OTHERWORLD_MAP', {openTerminal = true,terminalPage = 2, testData = asddws}} />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "DEWENJUN layer test",
		id = 1301,
		icon = 4,
		tag_type = 1,
		version = tostring(1)
	}))
	table.insert(arg_3_1, ServerNotice.New({
		time_des = "2018/08/23",
		title_image = "<config type = 2 param = {'OTHERWORLD_MAP'} />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "DEWENJUN test",
		id = 1302,
		icon = 4,
		tag_type = 1,
		version = tostring(2)
	}))
	table.insert(arg_3_1, ServerNotice.New({
		time_des = "2018/08/23",
		title_image = "<config type = 1 param = 'https://www.google.com' />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "URL test",
		id = 1303,
		icon = 4,
		tag_type = 1,
		version = tostring(3)
	}))
	table.insert(arg_3_1, ServerNotice.New({
		time_des = "2018/08/23",
		title_image = "<config type = 2 param = {'scene court yard', {OpenShop = true}} />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "URL test",
		id = 1304,
		icon = 4,
		tag_type = 1,
		version = tostring(4)
	}))
	table.insert(arg_3_1, ServerNotice.New({
		time_des = "2018/08/23",
		title_image = "<config type = 3 param = 5292 />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "URL test",
		id = 1305,
		icon = 4,
		tag_type = 1,
		version = tostring(4)
	}))

	return
end

function var_0_0.getServerNotices(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.data) do
		if iter_4_1:ShouldShow() and (not arg_4_1 or not iter_4_1.isRead) then
			table.insert({}, iter_4_1)
		end
	end

	return {}
end

function var_0_0.needAutoOpen(arg_5_0)
	local var_5_0 = true

	if PlayerPrefs.HasKey(var_0_0.KEY_STOP_REMIND) then
		local var_5_1 = pg.TimeMgr.GetInstance()

		if not arg_5_0:hasNewNotice() and var_5_1:IsSameDay(PlayerPrefs.GetInt(var_0_0.KEY_STOP_REMIND), var_5_1:GetServerTime()) then
			var_5_0 = false
		end
	elseif arg_5_0.runtimeUniqueCode and arg_5_0.runtimeUniqueCode == arg_5_0:getUniqueCode() then
		var_5_0 = false
	end

	arg_5_0.runtimeUniqueCode = arg_5_0:getUniqueCode()

	return var_5_0
end

function var_0_0.setStopRemind(arg_6_0, arg_6_1)
	if arg_6_1 then
		PlayerPrefs.SetInt(var_0_0.KEY_STOP_REMIND, pg.TimeMgr.GetInstance():GetServerTime())
	else
		PlayerPrefs.DeleteKey(var_0_0.KEY_STOP_REMIND)
	end

	PlayerPrefs.Save()

	return
end

function var_0_0.getStopRemind(arg_7_0)
	return PlayerPrefs.HasKey(var_0_0.KEY_STOP_REMIND)
end

function var_0_0.setStopNewTip(arg_8_0)
	PlayerPrefs.SetInt(var_0_0.KEY_NEWLY_ID, arg_8_0:getUniqueCode())
	PlayerPrefs.Save()
	arg_8_0:sendNotification(var_0_0.SERVER_NOTICES_UPDATE)

	return
end

function var_0_0.hasNewNotice(arg_9_0)
	if PlayerPrefs.HasKey(var_0_0.KEY_NEWLY_ID) and PlayerPrefs.GetInt(var_0_0.KEY_NEWLY_ID) == arg_9_0:getUniqueCode() then
		return false
	end

	return true
end

function var_0_0.getUniqueCode(arg_10_0)
	return _.reduce(arg_10_0.data, 0, function(arg_11_0, arg_11_1)
		return arg_11_0 + arg_11_1:getUniqueCode()
	end)
end

return var_0_0
