class = var_0_10000

local var_0_0 = var_0_10000("UIItemList")

var_0_0.EventInit = 1
var_0_0.EventUpdate = 2
var_0_0.EventExcess = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	assert = var_1_10003
	IsNil = var_1_10005

	var_1_10003(not var_1_10005(arg_1_1))

	assert = var_1_10003
	IsNil = var_5

	var_1_10003(not var_5(arg_1_2))

	arg_1_0.container = arg_1_1
	arg_1_0.item = arg_1_2
	arg_1_0.currentCount = 0

	return
end

function var_0_0.make(arg_2_0, arg_2_1)
	assert = var_1_10002

	local var_2_0

	if arg_2_1 ~= nil then
		type = var_1_10004

		if var_1_10004(arg_2_1) ~= "function" then
			var_2_0 = false

			goto label_2_0
		end
	end

	var_2_0 = true

	::label_2_0::

	var_1_10002(var_2_0)

	arg_2_0.callback = arg_2_1

	return
end

function var_0_0.align(arg_3_0, arg_3_1, arg_3_2)
	assert = var_1_10003

	var_1_10003(arg_3_1 >= 0)

	for iter_3_0 = arg_3_0.container.childCount, arg_3_1 - 1 do
		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(arg_3_0.item, var_3)
	end

	if arg_3_0.callback then
		for iter_3_1 = arg_3_0.currentCount, arg_3_1 - 1 do
			local var_3_0 = var_3:GetChild(iter_3_1)

			arg_3_0.callback(var_0_0.EventInit, iter_3_1, var_3_0)
		end

		for iter_3_2 = arg_3_1, arg_3_0.currentCount - 1 do
			local var_3_1 = var_3:GetChild(iter_3_2)

			arg_3_0.callback(var_0_0.EventExcess, iter_3_2, var_3_1)
		end

		arg_3_0.currentCount = arg_3_1
	end

	arg_3_2 = arg_3_2 or 0

	for iter_3_3 = arg_3_1, var_4 - 1 do
		local var_3_2 = var_3:GetChild(iter_3_3)

		setActive = var_1_10010

		var_1_10010(var_3_2, false)
	end

	if arg_3_2 > 0 then
		for iter_3_4 = 0, arg_3_1 - 1 do
			local var_3_3 = var_3:GetChild(iter_3_4)

			setActive = var_1_10010

			var_1_10010(var_3_3, false)
		end

		local var_3_4 = 0

		arg_3_0:StopTimer()

		Timer = var_6
		arg_3_0.timer = var_6.New(function()
			local var_4_0 = var_0
			local var_4_1 = var_0.GetChild(var_4_0, var_3_4)

			setActive = var_2_10001

			var_2_10001(var_4_1, true)

			if arg_3_0.callback then
				arg_3_0.callback(var_0_0.EventUpdate, var_3_4, var_4_1)
			end

			var_3_4 = var_3_4 + 1

			if var_3_4 >= arg_3_1 then
				local var_4_2 = arg_3_0

				var_1.StopTimer(var_4_2)
			end

			return
		end, arg_3_2, arg_3_1)

		arg_3_0.timer.func()

		local var_3_5 = arg_3_0.timer

		var_6.Start(var_3_5)
	else
		for iter_3_5 = 0, arg_3_1 - 1 do
			local var_3_6 = var_3:GetChild(iter_3_5)

			setActive = var_1_10010

			var_1_10010(var_3_6, true)

			if arg_3_0.callback then
				arg_3_0.callback(var_0_0.EventUpdate, iter_3_5, var_3_6)
			end
		end
	end

	return
end

function var_0_0.each(arg_5_0, arg_5_1)
	for iter_5_0 = arg_5_0.container.childCount - 1, 0, -1 do
		local var_5_0 = arg_5_0.container
		local var_5_1 = var_6.GetChild(var_5_0, iter_5_0)

		arg_5_1(iter_5_0, var_5_1)
	end

	return
end

function var_0_0.eachActive(arg_6_0, arg_6_1)
	for iter_6_0 = 0, arg_6_0.container.childCount - 1 do
		local var_6_0 = arg_6_0.container
		local var_6_1 = var_6.GetChild(var_6_0, iter_6_0)

		isActive = var_1_10007

		if var_1_10007(var_6_1) then
			arg_6_1(iter_6_0, var_6_1)
		end
	end

	return
end

function var_0_0.StaticAlign(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	UIItemList = var_1_10004

	local var_7_0 = var_1_10004.New(arg_7_0, arg_7_1)

	var_4.make(var_7_0, arg_7_3)
	var_4:align(arg_7_2)

	return
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer then
		local var_8_0 = arg_8_0.timer

		var_1.Stop(var_8_0)

		arg_8_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:StopTimer()

	return
end

return var_0_0
