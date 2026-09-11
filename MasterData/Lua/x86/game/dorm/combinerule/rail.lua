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
local RailController = class("RailController")
local var_0_3 = "CharDorm/prop/huochetou"
local var_0_4 = "CharDorm/prop/huochexiang"

function RailController:Ctor(arg_1_1)
	self.path = arg_1_1
	self.trainMgr = EntityManager.New(EntityManager.CreateModel.New(RailController.TrainModelGetter))
end

function RailController:TrainModelGetter()
	if self.cartID == 1 then
		return var_0_3
	end

	return var_0_4
end

function RailController:HasTrainStarted()
	return self.trainMgr:EntityNum() > 0
end

function RailController:GenerateTrain(arg_4_1)
	for iter_4_0 = 1, arg_4_1 do
		local var_4_0 = self.trainMgr:Update(iter_4_0, {
			complex = true,
			cartID = iter_4_0
		}, {
			interactEntities = {}
		})
	end

	return self.trainMgr.managed
end

function RailController:ClearTrain()
	self.trainMgr:Clear()
end

function RailController:GetTrainEID(arg_6_1)
	return self.trainMgr:GetEntityID(arg_6_1)
end

function RailController:GetTrainCartNum()
	return self.trainMgr:EntityNum()
end

function RailController:FindClosestPointOnRail(arg_8_1)
	return DormLuaBridge.FindClosestPointOnPath(arg_8_1, self.path)
end

function var_0_0.Match(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0(arg_10_0)
		return arg_10_0 == arg_9_0
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_1 = var_0_0.RailMatchSuccess(arg_9_0, iter_9_1, var_9_0, arg_9_2, {})

		if var_9_1 then
			local var_9_2 = RailController.New((DormLuaBridge.MergeConnectFurniturePath(arg_9_0, var_9_1, true, "rail")))

			for iter_9_2, iter_9_3 in ipairs(var_9_1) do
				local var_9_3 = DormUtils.GetEntityData(iter_9_3)

				if var_9_3.cfgID == var_0_0.STATION then
					var_9_3.rail = var_9_2
				end
			end

			return var_9_1
		end
	end

	DormUtils.GetEntityData(arg_9_0).rail = nil
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
	return table.keyof(var_0_1, (nullable(DormUtils.GetEntityData(arg_12_0), "cfgID"))) ~= nil
end

return var_0_0
