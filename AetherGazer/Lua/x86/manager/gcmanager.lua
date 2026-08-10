local var_0_0 = class("GCManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gctick = 0
	arg_1_0.gccost = 0
	arg_1_0.running = false
end

function var_0_0.Collect(arg_2_0, arg_2_1)
	arg_2_0:InAdvance()

	if not arg_2_1 then
		collectgarbage("collect")
	elseif not arg_2_0.running then
		arg_2_0.running = true

		arg_2_0:CalcStep()

		arg_2_0.gctick = 0
		arg_2_0.gccost = 0

		if not arg_2_0.handle then
			arg_2_0.handle = UpdateBeat:CreateListener(arg_2_0.Update, arg_2_0)
		end

		UpdateBeat:AddListener(arg_2_0.handle)
	end
end

function var_0_0.InAdvance(arg_3_0)
	return
end

function var_0_0.Afterward(arg_4_0)
	LuaHelper.UnityGC()
end

function var_0_0.CollectStep(arg_5_0)
	local var_5_0 = os.clock()

	if collectgarbage("step", arg_5_0.step) then
		arg_5_0.running = false

		if arg_5_0.handle then
			UpdateBeat:RemoveListener(arg_5_0.handle)

			arg_5_0.handle = nil
		end

		arg_5_0:Afterward()
	else
		local var_5_1 = os.clock() * 1000 - var_5_0 * 1000

		arg_5_0.gccost = arg_5_0.gccost > 0 and (arg_5_0.gccost + var_5_1) * 0.5 or var_5_1
		arg_5_0.gctick = arg_5_0.gctick + 1

		if arg_5_0.gctick > 300 and arg_5_0.gctick % 30 == 0 then
			arg_5_0:CalcStep()
		end
	end
end

function var_0_0.CalcStep(arg_6_0)
	arg_6_0.step = math.max(arg_6_0.gctick - 60, 30) / 30 * 150 * math.max(1 - math.max(arg_6_0.gccost - 3, 0) * 0.1, 0.1)
end

return var_0_0
