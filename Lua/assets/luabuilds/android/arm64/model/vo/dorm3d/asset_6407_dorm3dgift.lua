local Dorm3dGift = class("Dorm3dGift", import("model.vo.BaseVO"))

function Dorm3dGift:bindConfigTable()
	return pg.dorm3d_gift
end

function Dorm3dGift:GetName()
	return self:getConfig("name")
end

function Dorm3dGift:GetRarity()
	return self:getConfig("rarity")
end

function Dorm3dGift:GetShipGroupId()
	return self:getConfig("ship_group_id")
end

function Dorm3dGift:GetIcon()
	return self:getConfig("icon")
end

function Dorm3dGift:GetDesc()
	return self:getConfig("display")
end

function Dorm3dGift:InTime()
	return pg.TimeMgr.GetInstance():inTime(self:getConfig("time"))
end

function Dorm3dGift:IsSingleGiveGift()
	return pg.dorm3d_gift[self].unlock_dialogue_id ~= 0
end

function Dorm3dGift:IsExpireSoon()
	if type(pg.dorm3d_gift[self].time) ~= "table" or #pg.dorm3d_gift[self].time <= 1 then
		return false
	end

	local var_9_0 = pg.TimeMgr.GetInstance()

	return var_9_0:inTime(pg.dorm3d_gift[self].time) and var_9_0:parseTimeFromConfig(pg.dorm3d_gift[self].time[2]) - var_9_0:GetServerTime() <= 0
end

function Dorm3dGift:GetExpireSoonTipFlag()
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftExpireSoonTip_" .. self, 0)
end

function Dorm3dGift:SetExpireSoonTipFlag()
	if Dorm3dGift.GetExpireSoonTipFlag(self) > 0 then
		return
	end

	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftExpireSoonTip_" .. self, 1)

	return true
end

function Dorm3dGift:GetShopID()
	local var_12_0 = self:getConfig("shop_id")
	local var_12_1 = getProxy(ApartmentProxy):GetGiftShopCount(self.configId)

	for iter_12_0 = 1, #var_12_0 - 1 do
		if not pg.shop_template[var_12_0[iter_12_0]].limit_args[1] and pg.shop_template[var_12_0[iter_12_0]].group_type == 0 then
			return var_12_0[iter_12_0]
		elseif pg.shop_template[var_12_0[iter_12_0]].limit_args[1] and (pg.shop_template[var_12_0[iter_12_0]].limit_args[1][1] == "dailycount" or pg.shop_template[var_12_0[iter_12_0]].limit_args[1][1] == "count") then
			if var_12_1 < pg.shop_template[var_12_0[iter_12_0]].limit_args[1][3] then
				return var_12_0[iter_12_0]
			end
		elseif pg.shop_template[var_12_0[iter_12_0]].group_type == 2 then
			if var_12_1 < pg.shop_template[var_12_0[iter_12_0]].group_limit then
				return var_12_0[iter_12_0]
			end
		else
			return var_12_0[iter_12_0]
		end
	end

	return var_12_0[#var_12_0] or 0
end

function Dorm3dGift:CheckBuyLimit()
	local var_13_0 = pg.shop_template[self:GetShopID()]
	local var_13_1 = getProxy(ApartmentProxy):GetGiftShopCount(var_13_0.effect_args[1])

	if var_13_0.limit_args then
		if type(var_13_0.limit_args[1]) == "table" and (var_13_0.limit_args[1][1] == "dailycount" or var_13_0.limit_args[1][1] == "count") and var_13_1 >= var_13_0.limit_args[1][3] then
			return false
		end
	end

	if var_13_0.group_limit > 0 and var_13_1 >= var_13_0.group_limit then
		return false
	end

	return true
end

function Dorm3dGift:NeedViewTip()
	local var_14_0 = Dorm3dGift.bindConfigTable()

	return _.any(_.keys(var_14_0.get_id_list_by_ship_group_id), function(arg_15_0)
		if arg_15_0 == 0 then
			return
		end

		if self and self > 0 and arg_15_0 ~= self then
			return
		end

		return _.any(var_14_0.get_id_list_by_ship_group_id[arg_15_0], function(arg_16_0)
			local var_16_0 = Dorm3dGift.New({
				configId = arg_16_0
			})
			local var_16_1 = var_16_0:GetShopID()

			if var_16_1 then
				if type(var_16_0:getConfig("time")) ~= "table" then
					if Dorm3dGift.IsSingleGiveGift(arg_16_0) then
						if not getProxy(ApartmentProxy):isGiveGiftDone(arg_16_0) then
							if Dorm3dGift.GetViewedFlag(arg_16_0) ~= 0 then
								var_16_1 = false

								goto label_16_0
							end
						end
					end
				end

				var_16_1 = true
			end

			::label_16_0::

			return var_16_1
		end)
	end)
end

function Dorm3dGift:NeedViewTipByGiftId()
	local var_17_0

	if Dorm3dGift.GetViewedFlag(self) == 0 then
		if Dorm3dGift.IsSingleGiveGift(self) then
			var_17_0 = not getProxy(ApartmentProxy):isGiveGiftDone(self)

			goto label_17_0
		end
	end

	::label_17_0::

	return true
end

function Dorm3dGift:GetViewedFlag()
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftViewed_" .. self, 0)
end

function Dorm3dGift:SetViewedFlag()
	if Dorm3dGift.GetViewedFlag(self) > 0 then
		return
	end

	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftViewed_" .. self, 1)

	return true
end

return Dorm3dGift
