class = var_0_10000

local var_0_0 = var_0_10000("ExtraSystemManager")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_1
	arg_1_0.scene = arg_1_2
	arg_1_0.systems = {}
	arg_1_0.systemOrder = {}

	return
end

function var_0_0.Register(arg_2_0, arg_2_1, ...)
	local var_2_0

	if not arg_2_1.__cname then
		tostring = var_2_0
		var_2_0 = var_2_0(arg_2_1)
	end

	warning = var_1_10003

	var_1_10003("Trying to register Extra System:", var_2_0)

	if arg_2_0.systems[var_2_0] then
		warning = var_3

		var_3("System " .. var_2_0 .. " already registered")

		return arg_2_0.systems[var_2_0]
	end

	if arg_2_1.IsOpen then
		local var_2_1 = arg_2_0.scene.room

		if not arg_2_1.IsOpen(var_2_1, ...) then
			return nil
		end
	end

	local var_2_2 = arg_2_1.New(arg_2_0.event, arg_2_0.scene, ...)
	local var_2_3 = arg_2_0.systems

	var_2_3[var_2_0] = var_2_2
	warning = var_2_3

	var_2_3("Register Extra System:", var_2_0)

	table = var_2_3

	var_2_3.insert(arg_2_0.systemOrder, var_2_0)
	var_2_2:Init()

	return var_2_2
end

function var_0_0.Get(arg_3_0, arg_3_1)
	local var_3_0

	type = var_1_10003

	if var_1_10003(arg_3_1) == "string" then
		var_3_0 = arg_3_1
	elseif not arg_3_1.__cname then
		::label_3_0::

		tostring = var_3
		var_3_0 = var_3(arg_3_1)
	end

	return arg_3_0.systems[var_3_0]
end

function var_0_0.Remove(arg_4_0, arg_4_1)
	warning = var_1_10002

	var_1_10002("Trying to remove Extra System:", arg_4_1)

	local var_4_0

	type = var_3

	if var_3(arg_4_1) == "string" then
		var_4_0 = arg_4_1
	elseif not arg_4_1.__cname then
		::label_4_0::

		tostring = var_3
		var_4_0 = var_3(arg_4_1)
	end

	if not arg_4_0.systems[var_4_0] then
		return
	end

	var_3:Dispose()

	local var_4_1 = arg_4_0.systems

	var_4_1[var_4_0] = nil
	table = var_4_1

	var_4_1.removebyvalue(arg_4_0.systemOrder, var_4_0)

	warning = var_4

	var_4("Remove Extra System:", var_4_0)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.systemOrder) do
		if arg_5_0.systems[iter_5_1] then
			var_7:Update(arg_5_1)
		end
	end

	return
end

function var_0_0.LateUpdate(arg_6_0, arg_6_1)
	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.systemOrder) do
		if arg_6_0.systems[iter_6_1] then
			var_7:LateUpdate(arg_6_1)
		end
	end

	return
end

function var_0_0.BroadcastNotification(arg_7_0, arg_7_1, arg_7_2)
	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.systemOrder) do
		if arg_7_0.systems[iter_7_1] then
			local var_7_0 = var_8.GetInterests()

			table = var_1_10010

			if var_1_10010.contains(var_7_0, arg_7_1) then
				var_8:HandleNotification(arg_7_1, arg_7_2)
			end
		end
	end

	return
end

function var_0_0.GetAllInterests(arg_8_0)
	local var_8_0 = {}

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.systemOrder) do
		if arg_8_0.systems[iter_8_1] then
			local var_8_1 = var_7.GetInterests()

			ipairs = var_1_10009

			for iter_8_2, iter_8_3 in var_1_10009(var_8_1) do
				table = var_1_10014

				if not var_1_10014.contains(var_8_0, iter_8_3) then
					table = var_1_10014

					var_1_10014.insert(var_8_0, iter_8_3)
				end
			end
		end
	end

	return var_8_0
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0 = #arg_9_0.systemOrder, 1, -1 do
		local var_9_0 = arg_9_0.systemOrder[iter_9_0]

		if arg_9_0.systems[var_9_0] then
			var_6:Dispose()
		end
	end

	arg_9_0.systems = {}
	arg_9_0.systemOrder = {}
	arg_9_0.event = nil
	arg_9_0.scene = nil

	return
end

return var_0_0
