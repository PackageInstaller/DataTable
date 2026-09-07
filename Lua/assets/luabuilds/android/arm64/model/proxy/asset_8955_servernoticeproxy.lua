local ServerNoticeProxy = class("ServerNoticeProxy", import(".NetProxy"))

ServerNoticeProxy.SERVER_NOTICES_UPDATE = "server notices update"
ServerNoticeProxy.KEY_NEWLY_ID = "server_notice.newly_id"
ServerNoticeProxy.KEY_STOP_REMIND = "server_notice.dont_remind"

function ServerNoticeProxy:register()
	self.data = {}

	self:on(11300, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.notice_list) do
			local var_2_0 = false

			for iter_2_2 = 1, #self.data do
				if self.data[iter_2_2].id == iter_2_1.id then
					self.data[iter_2_2] = ServerNotice.New(iter_2_1)
					var_2_0 = true

					break
				end
			end

			if not var_2_0 then
				if #arg_2_0.notice_list == 1 then
					table.insert(self.data, 1, ServerNotice.New(iter_2_1))
				else
					table.insert(self.data, ServerNotice.New(iter_2_1))
				end
			end
		end

		self:sendNotification(ServerNoticeProxy.SERVER_NOTICES_UPDATE)

		return
	end)

	return
end

function ServerNoticeProxy:testData(arg_3_1)
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

function ServerNoticeProxy:getServerNotices(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.data) do
		if iter_4_1:ShouldShow() and (not arg_4_1 or not iter_4_1.isRead) then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function ServerNoticeProxy:needAutoOpen()
	local var_5_0 = true

	if PlayerPrefs.HasKey(ServerNoticeProxy.KEY_STOP_REMIND) then
		local var_5_1 = pg.TimeMgr.GetInstance()

		if not self:hasNewNotice() and var_5_1:IsSameDay(PlayerPrefs.GetInt(ServerNoticeProxy.KEY_STOP_REMIND), var_5_1:GetServerTime()) then
			var_5_0 = false
		end
	elseif self.runtimeUniqueCode and self.runtimeUniqueCode == self:getUniqueCode() then
		var_5_0 = false
	end

	self.runtimeUniqueCode = self:getUniqueCode()

	return var_5_0
end

function ServerNoticeProxy:setStopRemind(arg_6_1)
	if arg_6_1 then
		PlayerPrefs.SetInt(ServerNoticeProxy.KEY_STOP_REMIND, pg.TimeMgr.GetInstance():GetServerTime())
	else
		PlayerPrefs.DeleteKey(ServerNoticeProxy.KEY_STOP_REMIND)
	end

	PlayerPrefs.Save()

	return
end

function ServerNoticeProxy:getStopRemind()
	return PlayerPrefs.HasKey(ServerNoticeProxy.KEY_STOP_REMIND)
end

function ServerNoticeProxy:setStopNewTip()
	PlayerPrefs.SetInt(ServerNoticeProxy.KEY_NEWLY_ID, self:getUniqueCode())
	PlayerPrefs.Save()
	self:sendNotification(ServerNoticeProxy.SERVER_NOTICES_UPDATE)

	return
end

function ServerNoticeProxy:hasNewNotice()
	if PlayerPrefs.HasKey(ServerNoticeProxy.KEY_NEWLY_ID) and PlayerPrefs.GetInt(ServerNoticeProxy.KEY_NEWLY_ID) == self:getUniqueCode() then
		return false
	end

	return true
end

function ServerNoticeProxy:getUniqueCode()
	return _.reduce(self.data, 0, function(arg_11_0, arg_11_1)
		return arg_11_0 + arg_11_1:getUniqueCode()
	end)
end

return ServerNoticeProxy
