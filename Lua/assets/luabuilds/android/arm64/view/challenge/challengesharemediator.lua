local var_0_0 = class("ChallengeShareMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_1_0.contextData.mode)

	arg_1_0.viewComponent:setLevel(var_1_0:getLevel())

	local var_1_1 = {
		regularFleet = var_1_0:getRegularFleet(),
		submarineFleet = var_1_0:getSubmarineFleet()
	}
	local var_1_2 = var_1_1.regularFleet:getShipsByTeam(TeamType.Main, true)[1]

	arg_1_0.viewComponent:setFlagShipPaint(var_1_2:getPainting())

	for iter_1_0, iter_1_1 in ipairs(var_1_1.regularFleet:getShips(true)) do
		if iter_1_1.id ~= var_1_2.id then
			table.insert({}, iter_1_1:getPainting())
		end
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_1.submarineFleet:getShips(true)) do
		if iter_1_3.id ~= var_1_2.id then
			table.insert({}, iter_1_3:getPainting())
		end
	end

	arg_1_0.viewComponent:setShipPaintList({})

	return
end

return var_0_0
