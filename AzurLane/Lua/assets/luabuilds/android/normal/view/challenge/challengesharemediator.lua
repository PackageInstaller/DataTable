class = var_0_10000

local var_0_0 = "ChallengeShareMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.mode

	getProxy = var_1_10002
	ChallengeProxy = var_1_10003

	local var_1_1 = var_1_10002(var_1_10003)
	local var_1_2 = var_2.getUserChallengeInfo(var_1_1, var_1_0)
	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_3.setLevel
	local var_1_5 = var_1_2

	var_1_4(var_1_3, var_1_2.getLevel(var_1_5))

	local var_1_6 = ({
		regularFleet = var_1_2:getRegularFleet(),
		submarineFleet = var_1_2:getSubmarineFleet()
	}).regularFleet
	local var_1_7 = var_4.getShipsByTeam

	TeamType = var_1_5

	local var_1_8 = var_1_7(var_1_6, var_1_5.Main, true)[1]
	local var_1_9 = arg_1_0.viewComponent

	var_5.setFlagShipPaint(var_1_9, var_1_8:getPainting())

	local var_1_10 = {}

	ipairs = var_1_9

	local var_1_11 = var_3.regularFleet

	for iter_1_0, iter_1_1 in var_1_9(var_7.getShips(var_1_11, true)) do
		if iter_1_1.id ~= var_1_8.id then
			table = var_11

			var_11.insert(var_1_10, iter_1_1:getPainting())
		end
	end

	ipairs = var_6

	local var_1_12 = var_3.submarineFleet

	for iter_1_2, iter_1_3 in var_6(var_7.getShips(var_1_12, true)) do
		if iter_1_3.id ~= var_1_8.id then
			table = var_11

			var_11.insert(var_1_10, iter_1_3:getPainting())
		end
	end

	local var_1_13 = arg_1_0.viewComponent

	var_6.setShipPaintList(var_1_13, var_1_10)

	return
end

return var_0_1
