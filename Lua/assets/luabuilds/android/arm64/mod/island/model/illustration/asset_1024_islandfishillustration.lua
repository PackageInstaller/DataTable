local IslandFishIllustration = class("IslandFishIllustration", import(".IslandIllustration"))

IslandFishIllustration.MIN_CUP_KEY = 1
IslandFishIllustration.MAX_CUP_KEY = 2

function IslandFishIllustration:InitConfigData()
	self.minCupPoint, self.maxCupPoint = 0, 0

	for iter_1_0, iter_1_1 in ipairs(self:getConfig("collect_star")) do
		switch(iter_1_1[1], {
			[IslandFishIllustration.MIN_CUP_KEY] = function()
				self.minCupPoint = iter_1_1[2]

				return
			end,
			[IslandFishIllustration.MAX_CUP_KEY] = function()
				self.maxCupPoint = iter_1_1[2]

				return
			end
		})
	end

	return
end

function IslandFishIllustration:GetReachPoints(arg_4_1, arg_4_2)
	local var_4_0 = 0

	if arg_4_1 then
		var_4_0 = var_4_0 + self.minCupPoint
	end

	if arg_4_2 then
		var_4_0 = var_4_0 + self.maxCupPoint
	end

	return self.basePoint + var_4_0
end

function IslandFishIllustration:CheckTip()
	if self.status == IslandFishIllustration.STATUS.CAN_UNLOCK then
		self.isTip = true

		return
	end

	local var_5_0 = getProxy(IslandProxy):GetIsland():GetFishingAgency():GetFish((self:GetLinkConfigID()))

	if not var_5_0 then
		self.isTip = false

		return
	end

	self.isTip = self:GetReachPoints(var_5_0:ReachMinCup(), var_5_0:ReachMaxCup()) > self:GetPoints()

	return
end

function IslandFishIllustration:IsGotMinCup()
	return self.starPointGotData[IslandFishIllustration.MIN_CUP_KEY]
end

function IslandFishIllustration:IsGotMaxCup()
	return self.starPointGotData[IslandFishIllustration.MAX_CUP_KEY]
end

return IslandFishIllustration
