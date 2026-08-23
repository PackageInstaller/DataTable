local var_0_0 = {}
local var_0_1 = {
	Info = 2,
	Debug = 1,
	Verbose = 0,
	Error = 4,
	Warning = 3
}

function var_0_0.reset(arg_1_0)
	arg_1_0._info = {}
end

function var_0_0.setUserId(arg_2_0, arg_2_1)
	if buglySetUserId then
		buglySetUserId(arg_2_1)
	end
end

function var_0_0.setTag(arg_3_0, arg_3_1)
	if buglySetTag then
		buglySetTag(arg_3_1)
	end
end

function var_0_0.addUserValue(arg_4_0, arg_4_1, arg_4_2)
	if buglyAddUserValue then
		buglyAddUserValue(arg_4_1, arg_4_2)
	end
end

function var_0_0.removeUserValue(arg_5_0, arg_5_1)
	if buglyRemoveUserValue then
		buglyRemoveUserValue(arg_5_1)
	end
end

function var_0_0:setUserValue(arg_6_1, arg_6_2)
	self._info = self._info or {}

	if type(arg_6_1) == "table" then
		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			self._info[iter_6_0] = iter_6_1
		end
	else
		self._info[arg_6_1] = arg_6_2
	end
end

function var_0_0:uploadUserInfo()
	if self._info and next(self._info) then
		self:removeUserValue("user_info")
		self:addUserValue("user_info", (json.encode(self._info)))
	end
end

function var_0_0.log(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if buglyLog then
		buglyLog(arg_8_1, arg_8_2, arg_8_3)
	end
end

function var_0_0:trace(arg_9_1, arg_9_2)
	self:log(var_0_1.Verbose, arg_9_1, arg_9_2)
end

function var_0_0.error(arg_10_0, arg_10_1)
	if buglyReportLuaException then
		arg_10_1 = arg_10_1 or ""
		arg_10_1 = tostring(arg_10_1) .. " curModule: " .. g.core.utils.Tools.getCurModuleName()

		buglyReportLuaException(arg_10_1, debug.traceback())
	end
end

return var_0_0
