local var_0_0 = class("ExtraSystemManager")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_1
	arg_1_0.scene = arg_1_2
	arg_1_0.systems = {}
	arg_1_0.systemOrder = {}

	return
end

function var_0_0.Register(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_1.__cname or tostring(arg_2_1)

	warning("Trying to register Extra System:", var_2_0)

	if arg_2_0.systems[var_2_0] then
		warning("System " .. var_2_0 .. " already registered")

		return arg_2_0.systems[var_2_0]
	end

	if arg_2_1.IsOpen and not arg_2_1.IsOpen(arg_2_0.scene.room, ...) then
		return nil
	end

	local var_2_1 = arg_2_1.New(arg_2_0.event, arg_2_0.scene, ...)

	arg_2_0.systems[var_2_0] = var_2_1

	warning("Register Extra System:", var_2_0)
	table.insert(arg_2_0.systemOrder, var_2_0)
	var_2_1:Init()

	return var_2_1
end

function var_0_0.Get(arg_3_0, arg_3_1)
	local var_3_0 = type(arg_3_1) == "string" and arg_3_1 or arg_3_1.__cname or tostring(arg_3_1)

	return arg_3_0.systems[var_3_0]
end

function var_0_0.Remove(arg_4_0, arg_4_1)
	warning("Trying to remove Extra System:", arg_4_1)

	local var_4_0 = type(arg_4_1) == "string" and arg_4_1 or arg_4_1.__cname or tostring(arg_4_1)

	if not arg_4_0.systems[var_4_0] then
		return
	end

	var_4_1:Dispose()

	arg_4_0.systems[var_4_0] = nil

	table.removebyvalue(arg_4_0.systemOrder, var_4_0)
	warning("Remove Extra System:", var_4_0)

	return
end

function var_0_0.Update(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.systemOrder) do
		if arg_5_0.systems[iter_5_1] then
			arg_5_0.systems[iter_5_1]:Update(arg_5_1)
		end
	end

	return
end

function var_0_0.LateUpdate(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.systemOrder) do
		if arg_6_0.systems[iter_6_1] then
			arg_6_0.systems[iter_6_1]:LateUpdate(arg_6_1)
		end
	end

	return
end

function var_0_0.BroadcastNotification(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.systemOrder) do
		if arg_7_0.systems[iter_7_1] and table.contains(arg_7_0.systems[iter_7_1].GetInterests(), arg_7_1) then
			arg_7_0.systems[iter_7_1]:HandleNotification(arg_7_1, arg_7_2)
		end
	end

	return
end

function var_0_0.GetAllInterests(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.systemOrder) do
		if arg_8_0.systems[iter_8_1] then
			for iter_8_2, iter_8_3 in ipairs((arg_8_0.systems[iter_8_1].GetInterests())) do
				if not table.contains({}, iter_8_3) then
					table.insert({}, iter_8_3)
				end
			end
		end
	end

	return {}
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0 = #arg_9_0.systemOrder, 1, -1 do
		if arg_9_0.systems[arg_9_0.systemOrder[iter_9_0]] then
			arg_9_0.systems[arg_9_0.systemOrder[iter_9_0]]:Dispose()
		end
	end

	arg_9_0.systems = {}
	arg_9_0.systemOrder = {}
	arg_9_0.event = nil
	arg_9_0.scene = nil

	return
end

return var_0_0
