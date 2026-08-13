class = var_0_10000

local var_0_0 = "ServerNoticeProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.SERVER_NOTICES_UPDATE = "server notices update"
var_0_1.KEY_NEWLY_ID = "server_notice.newly_id"
var_0_1.KEY_STOP_REMIND = "server_notice.dont_remind"

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:on(11300, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.notice_list) do
			local var_2_0 = false

			for iter_2_2 = 1, #arg_1_0.data do
				if arg_1_0.data[iter_2_2].id == iter_2_1.id then
					var_2_10011 = arg_1_0.data
					ServerNotice = var_12
					var_2_10011[iter_2_2] = var_12.New(iter_2_1)
					var_2_0 = true

					break
				end
			end

			if not var_2_0 then
				local var_2_1

				if #arg_2_0.notice_list == 1 then
					table = var_2_1
					var_2_1 = var_2_1.insert

					local var_2_2 = arg_1_0.data

					iter_2_2 = 1
					ServerNotice = var_2_10011

					var_2_1(var_2_2, iter_2_2, var_2_10011.New(iter_2_1))
				else
					table = var_2_1

					local var_2_3 = var_2_1.insert
					local var_2_4 = arg_1_0.data

					ServerNotice = iter_2_2

					var_2_3(var_2_4, iter_2_2.New(iter_2_1))
				end
			end
		end

		local var_2_5 = arg_1_0

		var_1.sendNotification(var_2_5, var_0_1.SERVER_NOTICES_UPDATE)

		return
	end)

	return
end

function var_0_1.testData(arg_3_0, arg_3_1)
	table = var_1_10002

	local var_3_0 = var_1_10002.insert
	local var_3_1 = arg_3_1

	ServerNotice = var_1_10005

	local var_3_2 = var_1_10005.New
	local var_3_3 = {
		time_des = "2018/08/23",
		title_image = "<config type = 2 param = {'OTHERWORLD_MAP', {openTerminal = true,terminalPage = 2, testData = asddws}} />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "DEWENJUN layer test",
		id = 1301,
		icon = 4,
		tag_type = 1
	}

	tostring = var_1_10008
	var_3_3.version = var_1_10008(1)

	var_3_0(var_3_1, var_3_2(var_3_3))

	table = var_3_0

	local var_3_4 = var_3_0.insert
	local var_3_5 = arg_3_1

	ServerNotice = var_5

	local var_3_6 = var_5.New
	local var_3_7 = {
		time_des = "2018/08/23",
		title_image = "<config type = 2 param = {'OTHERWORLD_MAP'} />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "DEWENJUN test",
		id = 1302,
		icon = 4,
		tag_type = 1
	}

	tostring = var_8
	var_3_7.version = var_8(2)

	var_3_4(var_3_5, var_3_6(var_3_7))

	table = var_3_4

	local var_3_8 = var_3_4.insert
	local var_3_9 = arg_3_1

	ServerNotice = var_5

	local var_3_10 = var_5.New
	local var_3_11 = {
		time_des = "2018/08/23",
		title_image = "<config type = 1 param = 'https://www.google.com' />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "URL test",
		id = 1303,
		icon = 4,
		tag_type = 1
	}

	tostring = var_8
	var_3_11.version = var_8(3)

	var_3_8(var_3_9, var_3_10(var_3_11))

	table = var_3_8

	local var_3_12 = var_3_8.insert
	local var_3_13 = arg_3_1

	ServerNotice = var_5

	local var_3_14 = var_5.New
	local var_3_15 = {
		time_des = "2018/08/23",
		title_image = "<config type = 2 param = {'scene court yard', {OpenShop = true}} />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "URL test",
		id = 1304,
		icon = 4,
		tag_type = 1
	}

	tostring = var_8
	var_3_15.version = var_8(4)

	var_3_12(var_3_13, var_3_14(var_3_15))

	table = var_3_12

	local var_3_16 = var_3_12.insert
	local var_3_17 = arg_3_1

	ServerNotice = var_5

	local var_3_18 = var_5.New
	local var_3_19 = {
		time_des = "2018/08/23",
		title_image = "<config type = 3 param = 5292 />https://blhxusstatic.oss-us-east-1.aliyuncs.com/bulletinboard_test.png",
		title = "test",
		content = "",
		btn_title = "URL test",
		id = 1305,
		icon = 4,
		tag_type = 1
	}

	tostring = var_8
	var_3_19.version = var_8(4)

	var_3_16(var_3_17, var_3_18(var_3_19))

	return
end

function var_0_1.getServerNotices(arg_4_0, arg_4_1)
	local var_4_0 = {}

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.data) do
		if iter_4_1:ShouldShow() and (not arg_4_1 or not iter_4_1.isRead) then
			table = var_8

			var_8.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_1.needAutoOpen(arg_5_0)
	local var_5_0 = true

	PlayerPrefs = var_1_10002

	if var_1_10002.HasKey(var_0_1.KEY_STOP_REMIND) then
		PlayerPrefs = var_2

		local var_5_1 = var_2.GetInt(var_0_1.KEY_STOP_REMIND)

		pg = var_1_10003

		local var_5_2 = var_1_10003.TimeMgr.GetInstance()

		if not arg_5_0:hasNewNotice() and var_5_2:IsSameDay(var_5_1, var_5_2:GetServerTime()) then
			var_5_0 = false
		end
	elseif arg_5_0.runtimeUniqueCode and arg_5_0.runtimeUniqueCode == arg_5_0:getUniqueCode() then
		var_5_0 = false
	end

	arg_5_0.runtimeUniqueCode = arg_5_0:getUniqueCode()

	return var_5_0
end

function var_0_1.setStopRemind(arg_6_0, arg_6_1)
	if arg_6_1 then
		PlayerPrefs = var_1_10002
		var_1_10002 = var_1_10002.SetInt

		local var_6_0 = var_0_1.KEY_STOP_REMIND

		pg = var_1_10005

		local var_6_1 = var_1_10005.TimeMgr.GetInstance()

		var_1_10002(var_6_0, var_5.GetServerTime(var_6_1))
	else
		PlayerPrefs = var_1_10002

		var_1_10002.DeleteKey(var_0_1.KEY_STOP_REMIND)
	end

	PlayerPrefs = var_1_10002

	var_1_10002.Save()

	return
end

function var_0_1.getStopRemind(arg_7_0)
	PlayerPrefs = var_1_10001

	return var_1_10001.HasKey(var_0_1.KEY_STOP_REMIND)
end

function var_0_1.setStopNewTip(arg_8_0)
	PlayerPrefs = var_1_10001

	var_1_10001.SetInt(var_0_1.KEY_NEWLY_ID, arg_8_0:getUniqueCode())

	PlayerPrefs = var_1

	var_1.Save()
	arg_8_0:sendNotification(var_0_1.SERVER_NOTICES_UPDATE)

	return
end

function var_0_1.hasNewNotice(arg_9_0)
	PlayerPrefs = var_1_10001

	if var_1_10001.HasKey(var_0_1.KEY_NEWLY_ID) then
		PlayerPrefs = var_1

		if var_1.GetInt(var_0_1.KEY_NEWLY_ID) == arg_9_0:getUniqueCode() then
			return false
		end
	end

	return true
end

function var_0_1.getUniqueCode(arg_10_0)
	_ = var_1_10001

	return var_1_10001.reduce(arg_10_0.data, 0, function(arg_11_0, arg_11_1)
		return arg_11_0 + arg_11_1:getUniqueCode()
	end)
end

return var_0_1
