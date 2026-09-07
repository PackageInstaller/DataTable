local IslandCharIllustration = class("IslandCharIllustration", import(".IslandIllustration"))

function IslandCharIllustration:GetReachPoints(arg_1_1, arg_1_2)
	return self.basePoint + underscore.reduce(self:getConfig("collect_upgrade"), 0, function(arg_2_0, arg_2_1)
		return arg_2_0 + ((arg_1_1 >= arg_2_1[1] or nil) and (arg_2_1[2] or 0))
	end) + underscore.reduce(self:getConfig("collect_star"), 0, function(arg_3_0, arg_3_1)
		return arg_3_0 + ((arg_1_2 >= arg_3_1[1] or nil) and (arg_3_1[2] or 0))
	end)
end

function IslandCharIllustration:CheckTip()
	if self.status == IslandCharIllustration.STATUS.CAN_UNLOCK then
		self.isTip = true

		return
	end

	local var_4_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById((self:GetLinkConfigID()))
	local var_4_1

	if not var_4_0 then
		self.isTip = false

		do return end

		var_4_1 = var_4_0:GetBreakLevel()
	end

	self.isTip = self:GetReachPoints(var_4_0:GetLevel(), var_4_1) > self:GetPoints()

	return
end

return IslandCharIllustration
