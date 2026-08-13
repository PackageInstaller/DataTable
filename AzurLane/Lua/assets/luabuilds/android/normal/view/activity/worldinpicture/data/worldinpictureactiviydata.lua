class = var_0_10000

local var_0_0 = var_0_10000("WorldInPictureActiviyData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activity = arg_1_1
	pg = var_1_10002
	arg_1_0.config = var_1_10002.activity_event_grid[arg_1_1.data1]
	arg_1_0.travelPoint = arg_1_1.data2
	arg_1_0.drawPoint = arg_1_1.data3
	arg_1_0.travelList = arg_1_1.data1_list
	arg_1_0.drawList = arg_1_1.data2_list
	arg_1_0.awardList = arg_1_1.data3_list
	arg_1_0.size = arg_1_0.config.map
	arg_1_0.drawAreaList = {}
	arg_1_0.drawAreaAnimList = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0.config.zone) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.drawAreaAnimList, arg_1_0.config.zone_anim_Pos[iter_1_0])

		table = var_1_10007

		var_1_10007.insert(arg_1_0.drawAreaList, arg_1_0:WarpDrawArea(iter_1_1))
	end

	arg_1_0.boxItems = {}
	ipairs = var_2

	for iter_1_2, iter_1_3 in var_2(arg_1_0.config.box) do
		local var_1_0 = iter_1_3[1]
		local var_1_1 = iter_1_3[2]

		if not arg_1_0.boxItems[var_1_0] then
			arg_1_0.boxItems[var_1_0] = {}
		end

		arg_1_0.boxItems[var_1_0][var_1_1] = true
	end

	return
end

function var_0_0.WarpDrawArea(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[1]
	local var_2_1 = arg_2_1[2]
	local var_2_2 = arg_2_1[3]
	local var_2_3 = arg_2_1[4]
	local var_2_4 = {}

	for iter_2_0 = var_2_0, var_2_2 do
		for iter_2_1 = var_2_1, var_2_3 do
			table = var_1_10015
			var_1_10015 = var_1_10015.insert

			local var_2_5 = var_2_4

			Vector2 = var_1_10017

			var_1_10015(var_2_5, var_1_10017(iter_2_0, iter_2_1))
		end
	end

	return var_2_4
end

function var_0_0.GetMapRowAndColumn(arg_3_0)
	return arg_3_0.size[1], arg_3_0.size[2]
end

function var_0_0.GetTravelPoint(arg_4_0)
	return arg_4_0.travelPoint
end

function var_0_0.GetDrawPoint(arg_5_0)
	return arg_5_0.drawPoint
end

function var_0_0.GetTravelProgress(arg_6_0)
	return #arg_6_0.travelList
end

function var_0_0.GetMaxTravelCnt(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:GetMapRowAndColumn()

	return var_7_0 * var_7_1
end

function var_0_0.IsTravelAll(arg_8_0)
	return arg_8_0:GetTravelProgress() >= arg_8_0:GetMaxTravelCnt()
end

function var_0_0.GetDrawProgress(arg_9_0)
	return #arg_9_0.drawList
end

function var_0_0.GetMaxDrawCnt(arg_10_0)
	return #arg_10_0.drawAreaList
end

function var_0_0.IsDrawAll(arg_11_0)
	return arg_11_0:GetDrawProgress() >= arg_11_0:GetMaxDrawCnt()
end

function var_0_0.GetTravelList(arg_12_0)
	return arg_12_0.travelList
end

function var_0_0.GetDrawList(arg_13_0)
	return arg_13_0.drawList
end

function var_0_0.GetAwardList(arg_14_0)
	return arg_14_0.awardList
end

function var_0_0.IsFirstTravel(arg_15_0)
	return #arg_15_0.travelList == 1
end

function var_0_0.OutSide(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = arg_16_0:GetMapRowAndColumn()

	return arg_16_1 <= 0 or arg_16_2 <= 0 or var_16_0 < arg_16_1 or var_16_1 < arg_16_2
end

function var_0_0.IsOpened(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = arg_17_0:GetMapRowAndColumn()
	local var_17_2 = (arg_17_1 - 1) * var_17_1 + arg_17_2
	local var_17_3

	if not arg_17_0:OutSide(arg_17_1, arg_17_2) then
		table = var_6
		var_17_3 = var_6.contains(arg_17_0.travelList, var_17_2)
	else
		var_17_3 = false
	end

	if false then
		var_17_3 = true
	end

	return var_17_3
end

function var_0_0.CanSelect(arg_18_0, arg_18_1, arg_18_2)
	if #arg_18_0.travelList == 0 then
		return true
	end

	local var_18_0 = arg_18_0

	if arg_18_0.IsOpened(var_18_0, arg_18_1, arg_18_2) then
		return false
	end

	local var_18_1 = {}

	Vector2 = var_18_0
	var_18_1[1] = var_18_0(arg_18_1 + 1, arg_18_2)
	Vector2 = var_4
	var_18_1[2] = var_4(arg_18_1, arg_18_2 + 1)
	Vector2 = var_4
	var_18_1[3] = var_4(arg_18_1 - 1, arg_18_2)
	Vector2 = var_4
	var_18_1[4] = var_4(arg_18_1, arg_18_2 - 1)
	_ = var_4

	return var_4.any(var_18_1, function(arg_19_0)
		local var_19_0 = arg_18_0

		return var_1.IsOpened(var_19_0, arg_19_0.x, arg_19_0.y)
	end)
end

function var_0_0.ExistBox(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if arg_20_0.boxItems[arg_20_1] then
		var_20_0 = arg_20_0.boxItems[arg_20_1][arg_20_2] == true
	end

	return var_20_0
end

function var_0_0.AnyAreaCanDraw(arg_21_0)
	_ = var_1_10001

	return var_1_10001.any(arg_21_0.drawAreaList, function(arg_22_0)
		local var_22_0 = arg_21_0
		local var_22_1

		if not var_1.IsDrawed(var_22_0, arg_22_0[1].x, arg_22_0[1].y) then
			_ = var_1
			var_22_1 = var_1.all(arg_22_0, function(arg_23_0)
				local var_23_0 = arg_21_0

				return var_1.IsOpened(var_23_0, arg_23_0.x, arg_23_0.y)
			end)
		else
			var_22_1 = false
		end

		if false then
			var_22_1 = true
		end

		return var_22_1
	end)
end

function var_0_0.GetDrawableArea(arg_24_0, arg_24_1, arg_24_2)
	_ = var_1_10003

	return var_1_10003.detect(arg_24_0.drawAreaList, function(arg_25_0)
		local var_25_0 = arg_25_0[1]

		Vector2 = var_2_10002

		return var_25_0 == var_2_10002(arg_24_1, arg_24_2)
	end)
end

function var_0_0.GetDrawableAreasState(arg_26_0)
	_ = var_1_10001

	return var_1_10001.map(arg_26_0.drawAreaList, function(arg_27_0)
		local var_27_0 = arg_26_0
		local var_27_1

		if not var_1.IsDrawed(var_27_0, arg_27_0[1].x, arg_27_0[1].y) then
			_ = var_1
			var_27_1 = var_1.all(arg_27_0, function(arg_28_0)
				local var_28_0 = arg_26_0

				return var_1.IsOpened(var_28_0, arg_28_0.x, arg_28_0.y)
			end)
		else
			var_27_1 = false
		end

		if false then
			var_27_1 = true
		end

		return {
			position = arg_27_0[1],
			open = var_27_1
		}
	end)
end

function var_0_0.GetDrawIndex(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = -1

	ipairs = var_1_10004

	for iter_29_0, iter_29_1 in var_1_10004(arg_29_0.drawAreaList) do
		_ = var_1_10009

		if var_1_10009.any(iter_29_1, function(arg_30_0)
			Vector2 = var_2_10001

			return arg_30_0 == var_2_10001(arg_29_1, arg_29_2)
		end) then
			var_29_0 = iter_29_0

			break
		end
	end

	return var_29_0
end

function var_0_0.IsDrawed(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.GetDrawIndex(var_31_0, arg_31_1, arg_31_2)

	table = var_31_0

	return var_31_0.contains(arg_31_0.drawList, var_31_1)
end

function var_0_0.CanDraw(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0

	if arg_32_0.IsDrawed(var_32_0, arg_32_1, arg_32_2) then
		return false
	end

	local var_32_1

	ipairs = var_32_0

	for iter_32_0, iter_32_1 in var_32_0(arg_32_0.drawAreaList) do
		_ = var_1_10009

		if var_1_10009.any(iter_32_1, function(arg_33_0)
			Vector2 = var_2_10001

			return arg_33_0 == var_2_10001(arg_32_1, arg_32_2)
		end) then
			var_32_1 = iter_32_1

			break
		end
	end

	if not var_32_1 then
		return false
	end

	_ = var_4

	return (var_4.all(var_32_1, function(arg_34_0)
		local var_34_0 = arg_32_0

		return var_1.IsOpened(var_34_0, arg_34_0.x, arg_34_0.y)
	end))
end

function var_0_0.Convert2DrawAreaHead(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0
	local var_35_1

	ipairs = var_1_10005

	for iter_35_0, iter_35_1 in var_1_10005(arg_35_0.drawAreaList) do
		_ = var_1_10010

		if var_1_10010.any(iter_35_1, function(arg_36_0)
			Vector2 = var_2_10001

			return arg_36_0 == var_2_10001(arg_35_1, arg_35_2)
		end) then
			var_35_0 = iter_35_1
			var_35_1 = iter_35_0

			break
		end
	end

	assert = var_5

	var_5(var_35_0)

	return var_35_0[1].x, var_35_0[1].y, var_35_1
end

function var_0_0.GetDrawAnimData(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:GetDrawIndex(arg_37_1, arg_37_2)

	return arg_37_0.drawAreaAnimList[var_37_0]
end

function var_0_0.FindNextTravelable(arg_38_0)
	if arg_38_0:GetTravelPoint() <= 0 then
		return nil
	end

	local var_38_0, var_38_1 = arg_38_0:GetMapRowAndColumn()

	for iter_38_0 = 1, var_38_0 do
		for iter_38_1 = 1, var_38_1 do
			local var_38_2 = arg_38_0

			if arg_38_0.CanSelect(var_38_2, iter_38_0, iter_38_1) then
				local var_38_3 = (iter_38_0 - 1) * var_38_1 + iter_38_1

				Vector2 = var_38_2

				return var_38_2(iter_38_0, iter_38_1), var_38_3
			end
		end
	end

	return nil
end

function var_0_0.FindNextDrawableAreaHead(arg_39_0)
	if arg_39_0:GetDrawPoint() <= 0 then
		return nil
	end

	ipairs = var_2

	for iter_39_0, iter_39_1 in var_2(arg_39_0.drawAreaList) do
		if not arg_39_0:IsDrawed(iter_39_1[1].x, iter_39_1[1].y) then
			_ = var_7

			if var_7.all(iter_39_1, function(arg_40_0)
				local var_40_0 = arg_39_0

				return var_1.IsOpened(var_40_0, arg_40_0.x, arg_40_0.y)
			end) then
				return iter_39_1[1], iter_39_0
			end
		end
	end

	return nil
end

return var_0_0
