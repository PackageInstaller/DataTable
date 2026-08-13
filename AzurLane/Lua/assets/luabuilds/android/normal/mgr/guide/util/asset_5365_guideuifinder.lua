class = var_0_10000

local var_0_0 = var_0_10000("GuideUIFinder")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.queue = {}

	return
end

function var_0_0.Search(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0.queue, arg_2_1)

	if #arg_2_0.queue == 1 then
		arg_2_0:Start()
	end

	return
end

function var_0_0.Start(arg_3_0)
	if #arg_3_0.queue <= 0 then
		return
	end

	local var_3_0 = arg_3_0.queue[1]

	arg_3_0:Clear()

	local function var_3_1()
		table = var_2_10000

		var_2_10000.remove(arg_3_0.queue, 1)

		local var_4_0 = arg_3_0

		var_0.Start(var_4_0)

		return
	end

	local var_3_2

	if not var_3_0.delay then
		var_3_2 = 0
	end

	if var_3_2 > 0 then
		Timer = var_3_2
		arg_3_0.delayTimer = var_3_2.New(function()
			local var_5_0 = arg_3_0

			var_0.AddSearchTimer(var_5_0, var_3_0, var_3_1)

			return
		end, var_3_0.delay)

		local var_3_3 = arg_3_0.delayTimer

		var_3.Start(var_3_3)
	else
		arg_3_0:AddSearchTimer(var_3_0, var_3_1)
	end

	return
end

local function var_0_1(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 0, arg_6_0.childCount - 1 do
		local var_6_1 = arg_6_0:GetChild(iter_6_0)
		local var_6_2 = var_7.GetComponent

		typeof = var_1_10010
		LayoutElement = var_1_10011

		local var_6_3 = var_6_2(var_6_1, var_1_10010(var_1_10011))

		IsNil = var_6_1

		if not var_6_1(var_7) then
			go = var_9

			if var_9(var_7).activeInHierarchy and (not var_6_3 or not var_6_3.ignoreLayout) then
				table = var_9

				var_9.insert(var_6_0, var_7)
			end
		end
	end

	local var_6_4

	if not arg_6_1 or not var_6_0[arg_6_1 + 1] then
		var_6_4 = var_6_0[#var_6_0]
	end

	return var_6_4
end

local function var_0_2(arg_7_0)
	local var_7_0 = arg_7_0.path

	string = var_1_10002

	local var_7_1

	if var_1_10002.match(var_7_0, "/CombatUI%(Clone%)/") then
		var_7_1 = var_7_0
		ys = var_3

		local var_7_2 = var_3.Battle.BattleState.GetCombatSkinKey()

		string = var_4
		var_7_0 = var_4.gsub(var_7_0, "CombatUI%(Clone%)", "CombatUI" .. var_7_2 .. "(Clone)")
	end

	GameObject = var_7_1

	if var_7_1.Find(var_7_0) and arg_7_0.childIndex and arg_7_0.childIndex == "#" then
		return var_0_1(var_2.transform)
	elseif var_2 and arg_7_0.childIndex and arg_7_0.childIndex == 25 then
		return var_0_1(var_2.transform, 0)
	elseif var_2 and arg_7_0.childIndex and arg_7_0.childIndex >= 0 then
		return var_0_1(var_2.transform, arg_7_0.childIndex)
	elseif var_2 then
		return var_2.transform
	end

	return nil
end

local function var_0_3(arg_8_0)
	if var_0_2(arg_8_0) ~= nil then
		ipairs = var_2

		for iter_8_0, iter_8_1 in var_2(arg_8_0.conditionData) do
			if var_1:Find(iter_8_1) then
				return var_7
			end
		end
	end

	return nil
end

local function var_0_4(arg_9_0)
	local var_9_0

	if arg_9_0.conditionData then
		var_9_0 = var_0_3(arg_9_0)
	else
		var_9_0 = var_0_2(arg_9_0)
	end

	if var_9_0 then
		return var_9_0
	end

	return nil
end

function var_0_0.AddSearchTimer(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 20

	Timer = var_1_10004
	arg_10_0.timer = var_1_10004.New(function()
		var_10_0 = var_10_0 - 1

		if var_10_0 <= 0 then
			local var_11_0 = arg_10_0

			var_0.Clear(var_11_0)
			arg_10_2()

			print = var_0

			var_0("should exist ui node : " .. arg_10_1.path)
			arg_10_1.callback(nil)

			return
		end

		if var_0_4(arg_10_1) then
			local var_11_1 = arg_10_0

			var_1.Clear(var_11_1)
			arg_10_2()
			arg_10_1.callback(var_0)
		end

		return
	end, 0.5, -1)

	local var_10_1 = arg_10_0.timer

	var_4.Start(var_10_1)
	arg_10_0.timer.func()

	return
end

function var_0_0.SearchWithoutDelay(arg_12_0, arg_12_1)
	local var_12_0 = var_0_2(arg_12_1)

	arg_12_0:Clear()
	arg_12_1.callback(var_12_0)

	return
end

function var_0_0.Clear(arg_13_0)
	if arg_13_0.delayTimer then
		local var_13_0 = arg_13_0.delayTimer

		var_1.Stop(var_13_0)

		arg_13_0.delayTimer = nil
	end

	if arg_13_0.timer then
		local var_13_1 = arg_13_0.timer

		var_1.Stop(var_13_1)

		arg_13_0.timer = nil
	end

	return
end

return var_0_0
