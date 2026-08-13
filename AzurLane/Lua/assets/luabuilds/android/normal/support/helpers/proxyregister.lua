class = var_0_10000

local var_0_0 = var_0_10000("ProxyRegister")

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
	CoTimer = var_1
	arg_1_0.timer = var_1.New(function()
		local var_2_0 = arg_1_0

		var_0.Dispatcher(var_2_0)

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

	table = var_4

	var_4.insert(arg_3_0.data, var_3_0)

	pairs = var_4

	for iter_3_0, iter_3_1 in var_4(var_3_0:timeCall()) do
		table = var_1_10009

		var_1_10009.insert(arg_3_0.callDic[iter_3_0], iter_3_1)
	end

	return
end

function var_0_0.RgisterProxy(arg_4_0, arg_4_1, arg_4_2)
	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_2) do
		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.AddProxy

		unpack = var_1_10010

		var_4_1(var_4_0, var_1_10010(iter_4_1))
	end

	ipairs = var_3

	for iter_4_2, iter_4_3 in var_3(arg_4_0.data) do
		arg_4_1:registerProxy(iter_4_3)
	end

	arg_4_0.loginMark = {}

	return
end

function var_0_0.RemoveProxy(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.data) do
		arg_5_1:removeProxy(iter_5_1.__cname)
	end

	arg_5_0.loginMark = nil

	return
end

function var_0_0.Start(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()

	arg_6_0.dateMark = var_1.CurrentSTimeDesc(var_6_0, "*t", true)

	local var_6_1 = arg_6_0.timer

	var_1.Start(var_6_1)

	return
end

function var_0_0.Stop(arg_7_0)
	local var_7_0 = arg_7_0.timer

	var_1.Stop(var_7_0)

	return
end

function var_0_0.Dispatcher(arg_8_0)
	local var_8_0 = {}

	pg = var_1_10002

	local var_8_1 = var_1_10002.TimeMgr.GetInstance()
	local var_8_2 = var_2.CurrentSTimeDesc(var_8_1, "*t", true)

	ipairs = var_8_1

	for iter_8_0, iter_8_1 in var_8_1({
		var_0_0.SecondCall,
		var_0_0.MinuteCall,
		var_0_0.HourCall,
		var_0_0.DayCall
	}) do
		if iter_8_1 == var_0_0.DayCall then
			if arg_8_0.dateMark[iter_8_1] ~= var_8_2[iter_8_1] then
				if arg_8_0.dayProto or arg_8_0.dayCount and arg_8_0.dayCount <= 0 then
					var_8_0[iter_8_1] = var_8_2[iter_8_1]
					var_1_10008 = arg_8_0.dateMark
					var_1_10008[iter_8_1] = var_8_2[iter_8_1]
				elseif arg_8_0.dayCount then
					arg_8_0.dayCount = arg_8_0.dayCount - 1
				else
					arg_8_0.dayCount = 30
				end
			else
				arg_8_0.dayProto = nil
				arg_8_0.dayCount = nil
			end
		elseif arg_8_0.dateMark[iter_8_1] ~= var_8_2[iter_8_1] then
			var_8_0[iter_8_1] = var_8_2[iter_8_1]
			var_1_10008 = arg_8_0.dateMark
			var_1_10008[iter_8_1] = var_8_2[iter_8_1]
		end
	end

	pairs = var_3

	for iter_8_2, iter_8_3 in var_3(var_8_0) do
		ipairs = var_1_10008

		for iter_8_4, iter_8_5 in var_1_10008(arg_8_0.callDic[iter_8_2]) do
			iter_8_5(iter_8_3, var_8_2)
		end
	end

	return
end

return var_0_0
