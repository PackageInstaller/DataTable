local var_0_0 = class("ProxyRegister")

var_0_0.SecondCall = "sec"
var_0_0.MinuteCall = "min"
var_0_0.HourCall = "hour"
var_0_0.DayCall = "day"

function var_0_0.Ctor(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.callDic = {
		[var_0_0.SecondCall] = {},
		[var_0_0.MinuteCall] = {},
		[var_0_0.HourCall] = {},
		[var_0_0.DayCall] = {}
	}
	arg_1_0.timer = CoTimer.New(function()
		arg_1_0:Dispatcher()

		return
	end, 1, -1)
	arg_1_0.loginMark = nil

	return
end

function var_0_0.AddProxy(arg_3_0, arg_3_1, arg_3_2, ...)
	if not arg_3_2 then
		return
	end

	local var_3_0 = arg_3_1.New(...)

	table.insert(arg_3_0.data, var_3_0)

	for iter_3_0, iter_3_1 in pairs(var_3_0:timeCall()) do
		table.insert(arg_3_0.callDic[iter_3_0], iter_3_1)
	end

	return
end

function var_0_0.RgisterProxy(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		arg_4_0:AddProxy(unpack(iter_4_1))
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.data) do
		arg_4_1:registerProxy(iter_4_3)
	end

	arg_4_0.loginMark = {}

	return
end

function var_0_0.RemoveProxy(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.data) do
		arg_5_1:removeProxy(iter_5_1.__cname)
	end

	arg_5_0.loginMark = nil

	return
end

function var_0_0.Start(arg_6_0)
	arg_6_0.dateMark = pg.TimeMgr.GetInstance():CurrentSTimeDesc("*t", true)

	arg_6_0.timer:Start()

	return
end

function var_0_0.Stop(arg_7_0)
	arg_7_0.timer:Stop()

	return
end

function var_0_0.Dispatcher(arg_8_0)
	local var_8_0 = pg.TimeMgr.GetInstance():CurrentSTimeDesc("*t", true)

	for iter_8_0, iter_8_1 in ipairs({
		var_0_0.SecondCall,
		var_0_0.MinuteCall,
		var_0_0.HourCall,
		var_0_0.DayCall
	}) do
		if iter_8_1 == var_0_0.DayCall then
			if arg_8_0.dateMark[iter_8_1] ~= var_8_0[iter_8_1] then
				if arg_8_0.dayProto or arg_8_0.dayCount and arg_8_0.dayCount <= 0 then
					({})[iter_8_1] = var_8_0[iter_8_1]
					arg_8_0.dateMark[iter_8_1] = var_8_0[iter_8_1]
				else
					arg_8_0.dayCount = arg_8_0.dayCount and arg_8_0.dayCount - 1 or 30
				end
			else
				arg_8_0.dayProto = nil
				arg_8_0.dayCount = nil
			end
		elseif arg_8_0.dateMark[iter_8_1] ~= var_8_0[iter_8_1] then
			({})[iter_8_1] = var_8_0[iter_8_1]
			arg_8_0.dateMark[iter_8_1] = var_8_0[iter_8_1]
		end
	end

	for iter_8_2, iter_8_3 in pairs({}) do
		for iter_8_4, iter_8_5 in ipairs(arg_8_0.callDic[iter_8_2]) do
			iter_8_5(iter_8_3, var_8_0)
		end
	end

	return
end

return var_0_0
