class = var_0_10000

local var_0_0 = "IslandGiftAllocator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandComparableAllocator"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1

	local var_1_0 = arg_1_1:GetIsland()

	arg_1_0.signInAgency = var_2.GetSignInAgency(var_1_0)

	var_0_1.super.Ctor(arg_1_0, arg_1_1)
	arg_1_0:AddTimer()

	return
end

function var_0_1.AddTimer(arg_2_0)
	arg_2_0:RemoveTimer()

	GetZeroTime = var_1

	local var_2_0 = var_1()

	pg = var_1_10002

	local var_2_1 = var_1_10002.TimeMgr.GetInstance()
	local var_2_2 = var_2_0 - var_2.GetServerTime(var_2_1)

	if 0 < var_2_2 then
		Timer = var_4
		arg_2_0.timer = var_4.New(function()
			local var_3_0 = arg_2_0

			var_0.Flush(var_3_0)

			return
		end, var_2_2, 1)

		local var_2_3 = arg_2_0.timer

		var_4.Start(var_2_3)
	end

	return
end

function var_0_1.RemoveTimer(arg_4_0)
	if arg_4_0.timer then
		local var_4_0 = arg_4_0.timer

		var_1.Stop(var_4_0)

		arg_4_0.timer = nil
	end

	return
end

function var_0_1.OnInitFlags(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.controller.sceneData.giftUnits) do
		arg_5_0.flags[iter_5_0] = arg_5_0:IsVisible(iter_5_0)
	end

	return
end

function var_0_1.OnCompareSample(arg_6_0, arg_6_1, arg_6_2)
	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_1) do
		local var_6_0 = iter_6_1
		local var_6_1 = arg_6_2[iter_6_0]

		if var_6_0 ~= nil and var_6_1 ~= nil and var_6_0 ~= var_6_1 then
			if var_6_0 == true and var_6_1 == false then
				if arg_6_0:GetUnitData(iter_6_0) then
					local var_6_2 = arg_6_0
					local var_6_3 = arg_6_0.RemoveUnit

					IslandConst = var_1_10014

					var_6_3(var_6_2, var_1_10014.UNIT_LIST_OBJ, var_10.id)
				end
			elseif var_6_0 == false and var_6_1 == true and arg_6_0:GetUnitData(iter_6_0) then
				arg_6_0:GenUnit(var_10)
			end
		end
	end

	return
end

function var_0_1.IsVisible(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.signInAgency
	local var_7_1 = var_2.Visible(var_7_0, arg_7_1)
	local var_7_2 = arg_7_0.signInAgency

	if var_3.IsOutRange(var_7_2, arg_7_1) then
		return false
	end

	local var_7_3 = arg_7_0.controller

	if var_3.IsSelfIsland(var_7_3) then
		if arg_7_0.signInAgency.signInCnt <= 0 then
			return false
		end

		local var_7_4 = arg_7_0.signInAgency.signInCnt > 0 and arg_7_0.signInAgency.fetchCnt == 0

		return var_7_1 or var_7_4
	else
		local var_7_5 = arg_7_0.controller
		local var_7_6 = var_3.GetIsland(var_7_5)
		local var_7_7 = var_3.GetAccessAgency(var_7_6)
		local var_7_8 = var_4.HasOpenFlag

		IslandConst = var_1_10007

		local var_7_9 = var_7_8(var_7_7, var_1_10007.OPEN_SIGNIN)
		local var_7_10 = var_3:GetSignInAgency()
		local var_7_11 = var_5.InInInviteList

		getProxy = var_1_10008
		PlayerProxy = var_1_10010

		local var_7_12 = var_1_10008(var_1_10010)
		local var_7_13 = var_7_11(var_7_10, var_8.getRawData(var_7_12).id)
		local var_7_14 = var_3:GetSignInAgency()
		local var_7_15 = var_6.IsExpiration(var_7_14)

		return var_7_1 and (var_7_9 or var_7_13) and not var_7_15
	end

	return
end

function var_0_1.GetUnitData(arg_8_0, arg_8_1)
	assert = var_1_10002

	var_1_10002(arg_8_0.controller.sceneData.giftUnits[arg_8_1], "unit data is nil ." .. arg_8_1)

	return arg_8_0.controller.sceneData.giftUnits[arg_8_1]
end

function var_0_1.OnDispose(arg_9_0)
	arg_9_0.signInAgency = nil

	arg_9_0:RemoveTimer()

	return
end

return var_0_1
