local var_0_0 = {}

var_0_0.STATION = 961103
var_0_0.STRIGHT_RAIL = 961104
var_0_0.TURN_RAIL = 961105
var_0_0.STRIGHT_RAIL_APPROACH_SPAN = 961106
var_0_0.STRIGHT_RAIL_APPROACH_SPAN_2 = 961108
var_0_0.STRIGHT_RAIL_HIGH_BRIDGE = 961107

local var_0_1 = {
	var_0_0.STATION,
	var_0_0.STRIGHT_RAIL,
	var_0_0.TURN_RAIL,
	var_0_0.STRIGHT_RAIL_APPROACH_SPAN,
	var_0_0.STRIGHT_RAIL_APPROACH_SPAN_2,
	var_0_0.STRIGHT_RAIL_HIGH_BRIDGE
}
local var_0_2 = class("RailController")
local var_0_3 = "CharDorm/prop/huochetou"
local var_0_4 = "CharDorm/prop/huochexiang"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0.path = arg_1_1
	arg_1_0.trainMgr = EntityManager.New(EntityManager.CreateModel.New(var_0_2.TrainModelGetter))
end

function var_0_2.TrainModelGetter(arg_2_0)
	if arg_2_0.cartID == 1 then
		return var_0_3
	end

	return var_0_4
end

function var_0_2.HasTrainStarted(arg_3_0)
	return arg_3_0.trainMgr:EntityNum() > 0
end

function var_0_2.GenerateTrain(arg_4_0, arg_4_1)
	for iter_4_0 = 1, arg_4_1 do
		local var_4_0 = arg_4_0.trainMgr:Update(iter_4_0, {
			complex = true,
			cartID = iter_4_0
		}, {
			interactEntities = {}
		})
	end

	return arg_4_0.trainMgr.managed
end

function var_0_2.ClearTrain(arg_5_0)
	arg_5_0.trainMgr:Clear()
end

function var_0_2.GetTrainEID(arg_6_0, arg_6_1)
	return arg_6_0.trainMgr:GetEntityID(arg_6_1)
end

function var_0_2.GetTrainCartNum(arg_7_0)
	return arg_7_0.trainMgr:EntityNum()
end

function var_0_2.FindClosestPointOnRail(arg_8_0, arg_8_1)
	return DormLuaBridge.FindClosestPointOnPath(arg_8_1, arg_8_0.path)
end

function var_0_0.Match(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0(arg_10_0)
		return arg_10_0 == arg_9_0
	end

	local var_9_1 = DormUtils.GetEntityData(arg_9_0)

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_2 = var_0_0.RailMatchSuccess(arg_9_0, iter_9_1, var_9_0, arg_9_2, {})

		if var_9_2 then
			local var_9_3 = DormLuaBridge.MergeConnectFurniturePath(arg_9_0, var_9_2, true, "rail")
			local var_9_4 = var_0_2.New(var_9_3)

			for iter_9_2, iter_9_3 in ipairs(var_9_2) do
				local var_9_5 = DormUtils.GetEntityData(iter_9_3)

				if var_9_5.cfgID == var_0_0.STATION then
					var_9_5.rail = var_9_4
				end
			end

			return var_9_2
		end
	end

	var_9_1.rail = nil
end

function var_0_0.RailMatchSuccess(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_2(arg_11_1) then
		return {
			arg_11_1
		}
	end

	if arg_11_3[arg_11_1] or arg_11_4[arg_11_1] then
		return nil
	end

	local var_11_0 = DormUtils.GetEntityData(arg_11_1).connect

	if var_11_0 then
		arg_11_4[arg_11_1] = true

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			if iter_11_1 ~= arg_11_0 and var_0_0.IsRailNode(iter_11_1) then
				local var_11_1 = var_0_0.RailMatchSuccess(arg_11_1, iter_11_1, arg_11_2, arg_11_3, arg_11_4)

				if var_11_1 then
					table.insert(var_11_1, arg_11_1)

					return var_11_1
				end
			end
		end

		arg_11_4[arg_11_1] = false
	end
end

function var_0_0.IsRailNode(arg_12_0)
	local var_12_0 = nullable(DormUtils.GetEntityData(arg_12_0), "cfgID")

	return table.keyof(var_0_1, var_12_0) ~= nil
end

return var_0_0
