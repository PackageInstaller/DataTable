local ChallengeShareMediator = class("ChallengeShareMediator", import("..base.ContextMediator"))

function ChallengeShareMediator:register()
	local var_1_0 = getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode)

	self.viewComponent:setLevel(var_1_0:getLevel())

	local var_1_1 = {
		regularFleet = var_1_0:getRegularFleet(),
		submarineFleet = var_1_0:getSubmarineFleet()
	}
	local var_1_2 = var_1_1.regularFleet:getShipsByTeam(TeamType.Main, true)[1]

	self.viewComponent:setFlagShipPaint(var_1_2:getPainting())

	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1.regularFleet:getShips(true)) do
		if iter_1_1.id ~= var_1_2.id then
			table.insert(var_1_3, iter_1_1:getPainting())
		end
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_1.submarineFleet:getShips(true)) do
		if iter_1_3.id ~= var_1_2.id then
			table.insert(var_1_3, iter_1_3:getPainting())
		end
	end

	self.viewComponent:setShipPaintList(var_1_3)

	return
end

return ChallengeShareMediator
