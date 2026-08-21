local var_0_0 = class("AgoraBaseTheme")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.name = arg_1_1.name
	arg_1_0.placedlist = {}
	arg_1_0.floorData = {}
	arg_1_0.tileData = {}

	return
end

function var_0_0.GetPlacedData(arg_2_0)
	return arg_2_0.placedlist
end

function var_0_0.GetSeparatedPlacedData(arg_3_0)
	local var_3_0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.placedlist) do
		local var_3_1

		if iter_3_1:IsFoundationType() then
			var_3_0 = iter_3_1
		elseif iter_3_1:IsBuildingType() then
			var_3_1 = iter_3_1
		else
			table.insert({}, iter_3_1)
		end
	end

	return {}, var_3_0, nil
end

function var_0_0.GetFloorData(arg_4_0)
	return arg_4_0.floorData
end

function var_0_0.GetTileData(arg_5_0)
	return arg_5_0.tileData
end

return var_0_0
