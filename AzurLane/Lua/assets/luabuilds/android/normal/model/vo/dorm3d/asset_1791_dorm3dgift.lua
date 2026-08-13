class = var_0_10000

local var_0_0 = "Dorm3dGift"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_gift
end

function var_0_1.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_1.GetRarity(arg_3_0)
	return arg_3_0:getConfig("rarity")
end

function var_0_1.GetShipGroupId(arg_4_0)
	return arg_4_0:getConfig("ship_group_id")
end

function var_0_1.GetIcon(arg_5_0)
	return arg_5_0:getConfig("icon")
end

function var_0_1.GetDesc(arg_6_0)
	return arg_6_0:getConfig("display")
end

function var_0_1.InTime(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.inTime(var_7_0, arg_7_0:getConfig("time"))
end

function var_0_1.IsSingleGiveGift(arg_8_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_gift[arg_8_0].unlock_dialogue_id ~= 0
end

function var_0_1.IsExpireSoon(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.dorm3d_gift[arg_9_0].time

	type = var_1_10002

	if var_1_10002(var_9_0) ~= "table" or #var_9_0 <= 1 then
		return false
	end

	pg = var_2

	local var_9_1 = var_2.TimeMgr.GetInstance()
	local var_9_2 = var_2.GetServerTime(var_9_1)
	local var_9_3 = var_2:parseTimeFromConfig(var_9_0[2])
	local var_9_4

	if var_2:inTime(var_9_0) then
		var_9_4 = var_9_3 - var_9_2 <= 0
	end

	return var_9_4
end

function var_0_1.GetExpireSoonTipFlag(arg_10_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getRawData(var_10_0).id

	PlayerPrefs = var_10_0

	return var_10_0.GetInt(var_10_1 .. "_dorm3dGiftExpireSoonTip_" .. arg_10_0, 0)
end

function var_0_1.SetExpireSoonTipFlag(arg_11_0)
	local var_11_0 = var_0_1.GetExpireSoonTipFlag(arg_11_0)

	if 0 < var_11_0 then
		return
	end

	getProxy = var_11_0
	PlayerProxy = var_2

	local var_11_1 = var_11_0(var_2)
	local var_11_2 = var_1.getRawData(var_11_1).id

	PlayerPrefs = var_11_1

	var_11_1.SetInt(var_11_2 .. "_dorm3dGiftExpireSoonTip_" .. arg_11_0, 1)

	return true
end

function var_0_1.GetShopID(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.getConfig(var_12_0, "shop_id")

	getProxy = var_12_0
	ApartmentProxy = var_3

	local var_12_2 = var_12_0(var_3)
	local var_12_3 = var_2.GetGiftShopCount(var_12_2, arg_12_0.configId)

	for iter_12_0 = 1, #var_12_1 - 1 do
		local var_12_4 = var_12_1[iter_12_0]

		pg = var_1_10008

		if not var_1_10008.shop_template[var_12_4].limit_args[1] and var_1_10008.group_type == 0 then
			return var_12_4
		elseif var_9 and (var_9[1] == "dailycount" or var_9[1] == "count") then
			if var_12_3 < var_9[3] then
				return var_12_4
			end
		elseif var_1_10008.group_type == 2 then
			if var_12_3 < var_1_10008.group_limit then
				return var_12_4
			end
		else
			return var_12_4
		end
	end

	local var_12_5

	if not var_12_1[#var_12_1] then
		var_12_5 = 0
	end

	return var_12_5
end

function var_0_1.CheckBuyLimit(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetShopID(var_13_0)

	pg = var_13_0

	local var_13_2 = var_13_0.shop_template[var_13_1]

	getProxy = var_1_10003
	ApartmentProxy = var_1_10004

	local var_13_3 = var_1_10003(var_1_10004)
	local var_13_4 = var_3.GetGiftShopCount(var_13_3, var_13_2.effect_args[1])

	if var_13_2.limit_args then
		local var_13_5 = var_13_2.limit_args[1]

		type = var_5

		if var_5(var_13_5) == "table" and (var_13_5[1] == "dailycount" or var_13_5[1] == "count") and var_13_4 >= var_13_5[3] then
			return false
		end
	end

	if var_13_2.group_limit > 0 and var_13_4 >= var_13_2.group_limit then
		return false
	end

	return true
end

function var_0_1.NeedViewTip(arg_14_0)
	local var_14_0 = var_0_1.bindConfigTable()

	_ = var_1_10002

	local var_14_1 = var_1_10002.keys(var_14_0.get_id_list_by_ship_group_id)

	_ = var_3

	return var_3.any(var_14_1, function(arg_15_0)
		if arg_15_0 == 0 then
			return
		end

		if arg_14_0 then
			local var_15_0 = arg_14_0

			if 0 < var_15_0 and arg_15_0 ~= arg_14_0 then
				return
			end
		end

		local var_15_1 = var_14_0.get_id_list_by_ship_group_id[arg_15_0]

		_ = var_2_10002

		return var_2_10002.any(var_15_1, function(arg_16_0)
			Dorm3dGift = var_3_10001

			local var_16_0 = var_3_10001.New({
				configId = arg_16_0
			})

			if var_1.GetShopID(var_16_0) then
				type = var_16_2

				if var_16_2(var_1:getConfig("time")) ~= "table" then
					Dorm3dGift = var_16_2

					if var_16_2.IsSingleGiveGift(arg_16_0) then
						getProxy = var_16_2
						ApartmentProxy = var_3

						local var_16_1 = var_16_2(var_3)

						if not var_16_2.isGiveGiftDone(var_16_1, arg_16_0) then
							Dorm3dGift = var_16_2

							local var_16_2

							if var_16_2.GetViewedFlag(arg_16_0) ~= 0 then
								var_16_2 = false
							else
								var_16_2 = true
							end

							return var_16_2
						end
					end
				end
			end
		end)
	end)
end

function var_0_1.NeedViewTipByGiftId(arg_17_0)
	Dorm3dGift = var_1_10001

	if var_1_10001.GetViewedFlag(arg_17_0) == 0 then
		Dorm3dGift = var_1

		local var_17_1

		if var_1.IsSingleGiveGift(arg_17_0) then
			getProxy = var_1
			ApartmentProxy = var_2

			local var_17_0 = var_1(var_2)

			var_17_1 = not var_1.isGiveGiftDone(var_17_0, arg_17_0)

			if false then
				var_17_1 = false
			end
		else
			var_17_1 = true
		end

		return var_17_1
	end
end

function var_0_1.GetViewedFlag(arg_18_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.getRawData(var_18_0).id

	PlayerPrefs = var_18_0

	return var_18_0.GetInt(var_18_1 .. "_dorm3dGiftViewed_" .. arg_18_0, 0)
end

function var_0_1.SetViewedFlag(arg_19_0)
	local var_19_0 = var_0_1.GetViewedFlag(arg_19_0)

	if 0 < var_19_0 then
		return
	end

	getProxy = var_19_0
	PlayerProxy = var_2

	local var_19_1 = var_19_0(var_2)
	local var_19_2 = var_1.getRawData(var_19_1).id

	PlayerPrefs = var_19_1

	var_19_1.SetInt(var_19_2 .. "_dorm3dGiftViewed_" .. arg_19_0, 1)

	return true
end

return var_0_1
