local IslandWildGatherData = class("IslandWildGatherData", import("model.vo.BaseVO"))

function IslandWildGatherData:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.id
	self.configId = self.id
	self.pos = arg_1_1.pos
	self.state = arg_1_1.state
	self.mark = arg_1_1.mark
	self.refresh_time = arg_1_1.refresh_time
	self.isSelfIsLand = arg_1_2

	return
end

function IslandWildGatherData:UpdateData(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id

	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3

	if arg_2_1.pos ~= self.pos then
		var_2_0 = true
		var_2_1 = self.pos
		var_2_2 = true
		var_2_3 = arg_2_1.pos
	end

	self.pos = arg_2_1.pos

	if arg_2_1.state ~= self.state then
		if arg_2_1.state == 0 then
			var_2_2 = true
			var_2_3 = self.pos
		else
			var_2_0 = true
			var_2_1 = self.pos
		end
	end

	self.state = arg_2_1.state
	self.mark = arg_2_1.mark

	return var_2_2, var_2_0, var_2_3, var_2_1
end

function IslandWildGatherData:bindConfigTable()
	return pg.island_wild_gather
end

function IslandWildGatherData:CheckCofigShow()
	if self.isSelfIsLand then
		return true
	end

	return self:getConfigTable().show ~= IslandGatherCollectAgency.ShowTpye.OnlySelf
end

function IslandWildGatherData:IsShow()
	return self:CheckCofigShow() and self.state == 0
end

function IslandWildGatherData:StartGaher(arg_6_1, arg_6_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_GATHER, {
		unitId = arg_6_1,
		island_id = arg_6_2,
		gather_id = self.id
	})

	return
end

function IslandWildGatherData:StartGaherSign(arg_7_1, arg_7_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_GATHER_SIGN, {
		unitId = arg_7_1,
		island_id = arg_7_2,
		gather_id = self.id
	})

	return
end

function IslandWildGatherData:CheckGatherCanSign()
	return self:getConfigTable().show == 3
end

return IslandWildGatherData
