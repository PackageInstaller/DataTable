local var_0_0 = class("Dorm3dGift", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_gift
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_0.GetRarity(arg_3_0)
	return arg_3_0:getConfig("rarity")
end

function var_0_0.GetShipGroupId(arg_4_0)
	return arg_4_0:getConfig("ship_group_id")
end

function var_0_0.GetIcon(arg_5_0)
	return arg_5_0:getConfig("icon")
end

function var_0_0.GetDesc(arg_6_0)
	return arg_6_0:getConfig("display")
end

function var_0_0.InTime(arg_7_0)
	return pg.TimeMgr.GetInstance():inTime(arg_7_0:getConfig("time"))
end

function var_0_0.IsSingleGiveGift(arg_8_0)
	return pg.dorm3d_gift[arg_8_0].unlock_dialogue_id ~= 0
end

function var_0_0.IsExpireSoon(arg_9_0)
	if type(pg.dorm3d_gift[arg_9_0].time) ~= "table" or #pg.dorm3d_gift[arg_9_0].time <= 1 then
		return false
	end

	local var_9_0 = pg.TimeMgr.GetInstance()

	return var_9_0:inTime(pg.dorm3d_gift[arg_9_0].time) and var_9_0:parseTimeFromConfig(pg.dorm3d_gift[arg_9_0].time[2]) - var_9_0:GetServerTime() <= 0
end

function var_0_0.GetExpireSoonTipFlag(arg_10_0)
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftExpireSoonTip_" .. arg_10_0, 0)
end

function var_0_0.SetExpireSoonTipFlag(arg_11_0)
	if var_0_0.GetExpireSoonTipFlag(arg_11_0) > 0 then
		return
	end

	local var_11_0 = getProxy(PlayerProxy)

	PlayerPrefs.SetInt(var_11_0:getRawData().id .. "_dorm3dGiftExpireSoonTip_" .. arg_11_0, 1)

	return true
end

function var_0_0.GetShopID(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("shop_id")
	local var_12_1 = getProxy(ApartmentProxy):GetGiftShopCount(arg_12_0.configId)

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

function var_0_0.CheckBuyLimit(arg_13_0)
	local var_13_0 = pg.shop_template[arg_13_0:GetShopID()]
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

function var_0_0.NeedViewTip(arg_14_0)
	return _.any(_.keys(var_0_0.bindConfigTable().get_id_list_by_ship_group_id), function(arg_15_0)
		if arg_15_0 == 0 then
			return
		end

		if arg_14_0 and arg_14_0 > 0 and arg_15_0 ~= arg_14_0 then
			return
		end

		return _.any(var_0.get_id_list_by_ship_group_id[arg_15_0], function(arg_16_0)
			local var_16_0 = Dorm3dGift.New({
				configId = arg_16_0
			})
			local var_16_1 = var_16_0:GetShopID()

			if var_16_1 then
				if type(var_16_0:getConfig("time")) ~= "table" then
					if Dorm3dGift.IsSingleGiveGift(arg_16_0) then
						if not getProxy(ApartmentProxy):isGiveGiftDone(arg_16_0) then
							var_16_1 = Dorm3dGift.GetViewedFlag(arg_16_0) == 0

							return var_16_1
						end
					end
				end
			end
		end)
	end)
end

function var_0_0.NeedViewTipByGiftId(arg_17_0)
	if Dorm3dGift.GetViewedFlag(arg_17_0) == 0 then
		local var_17_0

		if Dorm3dGift.IsSingleGiveGift(arg_17_0) then
			var_17_0 = not getProxy(ApartmentProxy):isGiveGiftDone(arg_17_0)

			if false then
				var_17_0 = false
			end
		else
			var_17_0 = true
		end

		return var_17_0
	end
end

function var_0_0.GetViewedFlag(arg_18_0)
	return PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dGiftViewed_" .. arg_18_0, 0)
end

function var_0_0.SetViewedFlag(arg_19_0)
	if var_0_0.GetViewedFlag(arg_19_0) > 0 then
		return
	end

	local var_19_0 = getProxy(PlayerProxy)

	PlayerPrefs.SetInt(var_19_0:getRawData().id .. "_dorm3dGiftViewed_" .. arg_19_0, 1)

	return true
end

return var_0_0
