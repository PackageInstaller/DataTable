local ReversePacmanDormProxy = class("ReversePacmanDormProxy", import("model.proxy.NetProxy"))

function ReversePacmanDormProxy:register()
	return
end

function ReversePacmanDormProxy:RequestData(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_REVERSE_PACMAN)

	if not var_2_0 or var_2_0:isEnd() then
		self:RequestDormData()
		arg_2_1()

		return
	end

	seriesAsync({
		function(arg_3_0)
			self:RequestDormData(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:RandomShipData(var_2_0, arg_4_0)

			return
		end
	}, arg_2_1)

	return
end

function ReversePacmanDormProxy:RequestDormData(arg_5_1)
	self:SetData((ReversePacmanDorm.New({
		id = 6
	})))
	existCall(arg_5_1)

	return
end

function ReversePacmanDormProxy:RandomShipData(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs((arg_6_1:GetFavorabilityList())) do
		self:AddShip(iter_6_0)
	end

	existCall(arg_6_2)

	return
end

function ReversePacmanDormProxy:AddShip(arg_7_1)
	local var_7_0 = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[pg.activity_chasing_character[arg_7_1].skin_id].ship_group).id

	self.data:AddShip((ReversePacmanDormShip.New({
		id = var_7_0,
		configId = var_7_0,
		skin_id = pg.activity_chasing_character[arg_7_1].skin_id,
		roleID = arg_7_1
	})))

	return
end

function ReversePacmanDormProxy:SetData(arg_8_1)
	self.data = arg_8_1

	self:AddRefreshTimer()

	return
end

function ReversePacmanDormProxy:AddRefreshTimer()
	self:RemoveRefreshTimer()

	self.timer = Timer.New(function()
		self:RemoveRefreshTimer()

		local var_10_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

		if var_10_0 and not var_10_0:isEnd() then
			self:RandomShipData()
		end

		return
	end, GetZeroTime() - pg.TimeMgr.GetInstance():GetServerTime() + 1, 1)

	self.timer:Start()

	return
end

function ReversePacmanDormProxy:RemoveRefreshTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ReversePacmanDormProxy:remove()
	self:RemoveRefreshTimer()

	return
end

return ReversePacmanDormProxy
