local IslandItemIllustration = class("IslandItemIllustration", import(".IslandIllustration"))

function IslandItemIllustration:GetReachPoints()
	return self.basePoint + underscore.reduce(self:getConfig("collect_star"), 0, function(arg_2_0, arg_2_1)
		return arg_2_0 + ((self.historyCount >= arg_2_1[1] or nil) and (arg_2_1[2] or 0))
	end)
end

function IslandItemIllustration:CheckTip()
	if self.status == IslandItemIllustration.STATUS.CAN_UNLOCK then
		self.isTip = true

		return
	end

	self.isTip = self:GetReachPoints() > self:GetPoints()

	return
end

function IslandItemIllustration:SetHistoryCnt(arg_4_1)
	self.historyCount = arg_4_1

	self:CheckTip()

	return
end

function IslandItemIllustration:GetHistoryCnt()
	return self.historyCount
end

function IslandItemIllustration:AddHistoryCnt(arg_6_1)
	self.historyCount = self.historyCount + arg_6_1

	return
end

function IslandItemIllustration:GetCurPhase()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs((self:getConfig("collect_star"))) do
		if self.starPointGotData[iter_7_1[1]] then
			var_7_0 = iter_7_0
		end
	end

	return var_7_0
end

function IslandItemIllustration:GetCurTarget()
	for iter_8_0, iter_8_1 in ipairs((self:getConfig("collect_star"))) do
		if not self.starPointGotData[iter_8_1[1]] then
			return iter_8_1[1]
		end
	end

	return nil
end

return IslandItemIllustration
