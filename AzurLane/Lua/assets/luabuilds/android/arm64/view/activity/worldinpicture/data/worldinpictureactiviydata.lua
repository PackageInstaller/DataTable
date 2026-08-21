local var_0_0 = class("WorldInPictureActiviyData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activity = arg_1_1
	arg_1_0.config = pg.activity_event_grid[arg_1_1.data1]
	arg_1_0.travelPoint = arg_1_1.data2
	arg_1_0.drawPoint = arg_1_1.data3
	arg_1_0.travelList = arg_1_1.data1_list
	arg_1_0.drawList = arg_1_1.data2_list
	arg_1_0.awardList = arg_1_1.data3_list
	arg_1_0.size = arg_1_0.config.map
	arg_1_0.drawAreaList = {}
	arg_1_0.drawAreaAnimList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.config.zone) do
		table.insert(arg_1_0.drawAreaAnimList, arg_1_0.config.zone_anim_Pos[iter_1_0])
		table.insert(arg_1_0.drawAreaList, arg_1_0:WarpDrawArea(iter_1_1))
	end

	arg_1_0.boxItems = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.config.box) do
		arg_1_0.boxItems[iter_1_3[1]] = arg_1_0.boxItems[iter_1_3[1]] or {}
		arg_1_0.boxItems[iter_1_3[1]][iter_1_3[2]] = true
	end

	return
end

function var_0_0.WarpDrawArea(arg_2_0, arg_2_1)
	for iter_2_0 = arg_2_1[1], arg_2_1[3] do
		for iter_2_1 = arg_2_1[2], arg_2_1[4] do
			table.insert({}, Vector2(iter_2_0, iter_2_1))
		end
	end

	return {}
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

	return not arg_17_0:OutSide(arg_17_1, arg_17_2) and table.contains(arg_17_0.travelList, var_17_2)
end

function var_0_0.CanSelect(arg_18_0, arg_18_1, arg_18_2)
	if #arg_18_0.travelList == 0 then
		return true
	end

	if arg_18_0:IsOpened(arg_18_1, arg_18_2) then
		return false
	end

	return _.any({
		Vector2(arg_18_1 + 1, arg_18_2),
		Vector2(arg_18_1, arg_18_2 + 1),
		Vector2(arg_18_1 - 1, arg_18_2),
		Vector2(arg_18_1, arg_18_2 - 1)
	}, function(arg_19_0)
		return arg_18_0:IsOpened(arg_19_0.x, arg_19_0.y)
	end)
end

function var_0_0.ExistBox(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0.boxItems[arg_20_1] and arg_20_0.boxItems[arg_20_1][arg_20_2] == true
end

function var_0_0.AnyAreaCanDraw(arg_21_0)
	return _.any(arg_21_0.drawAreaList, function(arg_22_0)
		return not arg_21_0:IsDrawed(arg_22_0[1].x, arg_22_0[1].y) and _.all(arg_22_0, function(arg_23_0)
			return arg_21_0:IsOpened(arg_23_0.x, arg_23_0.y)
		end)
	end)
end

function var_0_0.GetDrawableArea(arg_24_0, arg_24_1, arg_24_2)
	return _.detect(arg_24_0.drawAreaList, function(arg_25_0)
		return arg_25_0[1] == Vector2(arg_24_1, arg_24_2)
	end)
end

function var_0_0.GetDrawableAreasState(arg_26_0)
	return _.map(arg_26_0.drawAreaList, function(arg_27_0)
		return {
			position = arg_27_0[1],
			open = not arg_26_0:IsDrawed(arg_27_0[1].x, arg_27_0[1].y) and _.all(arg_27_0, function(arg_28_0)
				return arg_26_0:IsOpened(arg_28_0.x, arg_28_0.y)
			end)
		}
	end)
end

function var_0_0.GetDrawIndex(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = -1

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.drawAreaList) do
		if _.any(iter_29_1, function(arg_30_0)
			return arg_30_0 == Vector2(arg_29_1, arg_29_2)
		end) then
			var_29_0 = iter_29_0

			break
		end
	end

	return var_29_0
end

function var_0_0.IsDrawed(arg_31_0, arg_31_1, arg_31_2)
	return table.contains(arg_31_0.drawList, (arg_31_0:GetDrawIndex(arg_31_1, arg_31_2)))
end

function var_0_0.CanDraw(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0:IsDrawed(arg_32_1, arg_32_2) then
		return false
	end

	local var_32_0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.drawAreaList) do
		if _.any(iter_32_1, function(arg_33_0)
			return arg_33_0 == Vector2(arg_32_1, arg_32_2)
		end) then
			var_32_0 = iter_32_1

			break
		end
	end

	if not var_32_0 then
		return false
	end

	return (_.all(var_32_0, function(arg_34_0)
		return arg_32_0:IsOpened(arg_34_0.x, arg_34_0.y)
	end))
end

function var_0_0.Convert2DrawAreaHead(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0
	local var_35_1

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.drawAreaList) do
		if _.any(iter_35_1, function(arg_36_0)
			return arg_36_0 == Vector2(arg_35_1, arg_35_2)
		end) then
			var_35_0 = iter_35_1
			var_35_1 = iter_35_0

			break
		end
	end

	assert(var_35_0)

	return var_35_0[1].x, var_35_0[1].y, var_35_1
end

function var_0_0.GetDrawAnimData(arg_37_0, arg_37_1, arg_37_2)
	return arg_37_0.drawAreaAnimList[arg_37_0:GetDrawIndex(arg_37_1, arg_37_2)]
end

function var_0_0.FindNextTravelable(arg_38_0)
	if arg_38_0:GetTravelPoint() <= 0 then
		return nil
	end

	local var_38_0, var_38_1 = arg_38_0:GetMapRowAndColumn()

	for iter_38_0 = 1, var_38_0 do
		for iter_38_1 = 1, var_38_1 do
			if arg_38_0:CanSelect(iter_38_0, iter_38_1) then
				return Vector2(iter_38_0, iter_38_1), (iter_38_0 - 1) * var_38_1 + iter_38_1
			end
		end
	end

	return nil
end

function var_0_0.FindNextDrawableAreaHead(arg_39_0)
	if arg_39_0:GetDrawPoint() <= 0 then
		return nil
	end

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.drawAreaList) do
		if not arg_39_0:IsDrawed(iter_39_1[1].x, iter_39_1[1].y) and _.all(iter_39_1, function(arg_40_0)
			return arg_39_0:IsOpened(arg_40_0.x, arg_40_0.y)
		end) then
			return iter_39_1[1], iter_39_0
		end
	end

	return nil
end

return var_0_0
