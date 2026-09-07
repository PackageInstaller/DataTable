local IslandCollectFragmentData = class("IslandCollectFragmentData", import("model.vo.BaseVO"))

function IslandCollectFragmentData:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.pos = arg_1_1.pos
	self.mark = arg_1_1.mark
	self.isSelfIsLand = arg_1_2

	return
end

function IslandCollectFragmentData:UpdateData(arg_2_1)
	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3

	self.id = arg_2_1.id

	if arg_2_1.pos ~= self.pos then
		var_2_0 = true
		var_2_2 = self.pos
		var_2_1 = true
		var_2_3 = arg_2_1.pos
	end

	self.pos = arg_2_1.pos
	self.mark = arg_2_1.mark

	return var_2_1, var_2_0, var_2_3, var_2_2
end

function IslandCollectFragmentData:bindConfigTable()
	return pg.island_collect_fragment
end

function IslandCollectFragmentData:IsShow()
	if self.isSelfIsLand then
		return true
	end

	return self:getConfigTable().show ~= IslandGatherCollectAgency.ShowTpye.OnlySelf
end

function IslandCollectFragmentData:StartCollect(arg_5_1, arg_5_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_COLLECT, {
		unitId = arg_5_1,
		island_id = arg_5_2,
		fragment_id = self.id
	})

	return
end

function IslandCollectFragmentData:StartCollectSign(arg_6_1, arg_6_2)
	pg.m02:sendNotification(GAME.ISLAND_START_WILD_COLLECT_SIGN, {
		unitId = arg_6_1,
		island_id = arg_6_2,
		gather_id = self.id
	})

	return
end

function IslandCollectFragmentData:CheckCollectCanSign()
	return self:getConfigTable().show == 3
end

return IslandCollectFragmentData
