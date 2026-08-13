ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.BossPhaseSwitchType
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleUnitPhaseSwitcher = var_0_10004("BattleUnitPhaseSwitcher")
var_0.Battle.BattleUnitPhaseSwitcher.__name = "BattleUnitPhaseSwitcher"

local var_0_4 = var_0.Battle.BattleUnitPhaseSwitcher

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	local var_1_0 = arg_1_0._client

	var_2.AddPhaseSwitcher(var_1_0, arg_1_0)

	arg_1_0._randomWeaponList = {}

	return
end

function var_0_4.Update(arg_2_0)
	local var_2_0 = true
	local var_2_1

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0._currentPhaseSwitchParam) do
		local var_2_2 = iter_2_1.type
		local var_2_3 = iter_2_1.param
		local var_2_4 = iter_2_1.to

		if var_2_2 == var_0_1.DURATION then
			pg = var_11

			local var_2_5 = var_11.TimeMgr.GetInstance()

			if var_2_3 < var_11.GetCombatTime(var_2_5) - arg_2_0._phaseStartTime then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		elseif var_2_2 == var_0_1.POSITION_X_GREATER then
			local var_2_6 = arg_2_0._client

			if var_2_3 < var_11.GetPosition(var_2_6).x then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		elseif var_2_2 == var_0_1.POSITION_X_LESS then
			local var_2_7 = arg_2_0._client

			if var_2_3 > var_11.GetPosition(var_2_7).x then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		elseif var_2_2 == var_0_1.OXYGEN then
			local var_2_8 = arg_2_0._client

			if var_2_3 >= var_11.GetCuurentOxygen(var_2_8) then
				var_2_1 = iter_2_1.to
				iter_2_1.andFlag = false
			end
		end

		var_2_0 = var_2_0 and not iter_2_1.andFlag
	end

	if var_2_1 and var_2_0 then
		arg_2_0:switch(var_2_1)
	end

	return
end

function var_0_4.UpdateHP(arg_3_0, arg_3_1)
	local var_3_0 = true
	local var_3_1

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_0._currentPhaseSwitchParam) do
		local var_3_2 = iter_3_1.type
		local var_3_3 = iter_3_1.param
		local var_3_4 = iter_3_1.to

		if var_3_2 == var_0_1.HP and arg_3_1 < var_3_3 then
			var_3_1 = var_3_4
			iter_3_1.andFlag = false
		end

		var_3_0 = var_3_0 and not iter_3_1.andFlag
	end

	if var_3_1 and var_3_0 then
		arg_3_0:switch(var_3_1)
	end

	return
end

function var_0_4.SetTemplateData(arg_4_0, arg_4_1)
	arg_4_0._phaseList = {}
	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_1) do
		arg_4_0._phaseList[iter_4_1.index] = iter_4_1
	end

	arg_4_0:switch(0)

	return
end

function var_0_4.ForceSwitch(arg_5_0, arg_5_1)
	arg_5_0:switch(arg_5_1)

	return
end

function var_0_4.switch(arg_6_0, arg_6_1)
	if arg_6_1 == -1 or arg_6_0._phaseList[arg_6_1] == nil then
		return
	end

	local var_6_0 = arg_6_0._phaseList[arg_6_1]
	local var_6_1 = {}

	if var_6_0.removeWeapon then
		Clone = var_4
		var_6_1 = var_4(var_6_0.removeWeapon)
	end

	if var_6_0.removeRandomWeapon then
		ipairs = var_4

		for iter_6_0, iter_6_1 in var_4(arg_6_0._randomWeaponList) do
			table = var_1_10009

			var_1_10009.insert(var_6_1, iter_6_1)
		end

		arg_6_0._randomWeaponList = {}
	end

	local var_6_2 = {}

	if var_6_0.addWeapon then
		Clone = var_5
		var_6_2 = var_5(var_6_0.addWeapon)
	end

	if var_6_0.addRandomWeapon then
		local var_6_3 = var_6_0.addRandomWeapon

		math = var_1_10006

		local var_6_4 = var_6_3[var_1_10006.random(#var_6_0.addRandomWeapon)]

		ipairs = var_6

		for iter_6_2, iter_6_3 in var_6(var_6_4) do
			table = var_1_10011

			var_1_10011.insert(var_6_2, iter_6_3)

			table = var_1_10011

			var_1_10011.insert(arg_6_0._randomWeaponList, iter_6_3)
		end
	end

	arg_6_0._currentPhase = var_6_0

	arg_6_0:packagePhaseSwitchParam(var_6_0)

	local var_6_5 = arg_6_0._client

	var_5.ShiftWeapon(var_6_5, var_6_1, var_6_2)

	if var_6_0.removeBuff then
		ipairs = var_5

		for iter_6_4, iter_6_5 in var_5(var_6_0.removeBuff) do
			local var_6_6 = arg_6_0._client

			var_10.RemoveBuff(var_6_6, iter_6_5)
		end
	end

	if var_6_0.addBuff then
		ipairs = var_5

		for iter_6_6, iter_6_7 in var_5(var_6_0.addBuff) do
			local var_6_7 = var_0.Battle.BattleBuffUnit.New(iter_6_7, 1, arg_6_0._client)
			local var_6_8 = arg_6_0._client

			var_11.AddBuff(var_6_8, var_6_7)
		end
	end

	if var_6_0.dive then
		local var_6_9 = arg_6_0._client

		var_5.ChangeOxygenState(var_6_9, var_6_0.dive)
	end

	if var_6_0.setAI then
		local var_6_10 = arg_6_0._client

		var_5.SetAI(var_6_10, var_6_0.setAI)
	end

	if var_6_0.story then
		pg = var_5

		local var_6_11 = var_5.NewStoryMgr.GetInstance()

		var_5.Play(var_6_11, var_6_0.story)
	end

	if var_6_0.guide then
		if var_6_0.guide.type == 1 then
			pg = var_5

			local var_6_12 = var_5.SeriesGuideMgr.GetInstance()

			if var_5.isEnd(var_6_12) then
				goto label_6_0
			end
		end

		if var_6_0.guide.event == nil then
			pg = var_5

			local var_6_13 = var_5.NewGuideMgr.GetInstance()

			var_5.Play(var_6_13, var_6_0.guide.step)
		else
			pg = var_5

			local var_6_14 = var_5.NewGuideMgr.GetInstance()

			var_5.Play(var_6_14, var_6_0.guide.step, {
				var_6_0.guide.event
			})
		end
	end

	::label_6_0::

	pg = var_5

	local var_6_15 = var_5.TimeMgr.GetInstance()

	arg_6_0._phaseStartTime = var_5.GetCombatTime(var_6_15)

	if var_6_0.retreat == true then
		local var_6_16 = arg_6_0._client

		var_5.Retreat(var_6_16)
	end

	return
end

function var_0_4.packagePhaseSwitchParam(arg_7_0, arg_7_1)
	arg_7_0._currentPhaseSwitchParam = {}
	type = var_2

	if var_2(arg_7_1.switchType) == "table" then
		local var_7_0 = arg_7_1.switchType
		local var_7_1 = arg_7_1.switchParam
		local var_7_2 = arg_7_1.switchTo

		type = var_1_10006

		local var_7_3 = var_1_10006(var_7_2) == "number"
		local var_7_4 = 1
		local var_7_5 = #arg_7_1.switchType

		while var_7_4 <= var_7_5 do
			local var_7_6 = {
				type = var_7_0[var_7_4],
				param = var_7_1[var_7_4]
			}

			if var_7_3 then
				var_7_6.to = var_7_2
				var_7_6.andFlag = true
			else
				var_7_6.to = var_7_2[var_7_4]
			end

			table = var_10

			var_10.insert(arg_7_0._currentPhaseSwitchParam, var_7_6)

			var_7_4 = var_7_4 + 1
		end
	elseif var_2 == "number" then
		local var_7_7 = {
			type = arg_7_1.switchType
		}

		if arg_7_1.switchParamFunc then
			var_7_7.param = arg_7_1.switchParamFunc()
		else
			var_7_7.param = arg_7_1.switchParam
		end

		var_7_7.to = arg_7_1.switchTo
		table = var_4

		var_4.insert(arg_7_0._currentPhaseSwitchParam, var_7_7)
	end

	return
end

return
