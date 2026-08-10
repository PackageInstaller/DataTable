local var_0_0 = singletonClass("OathCollectionContentData")

function var_0_0.Init(arg_1_0)
	arg_1_0.oathData = nil
	arg_1_0.oathPlot = nil
	arg_1_0.oathLevelUpdate = nil
	arg_1_0.finishCheckRingExipreRedpoint = false

	print("OathCollectionContentData::Init", arg_1_0.finishCheckRingExipreRedpoint)
end

local var_0_1

local function var_0_2()
	local var_2_0 = 86400

	return 30 * var_2_0
end

local function var_0_3(arg_3_0, arg_3_1)
	if arg_3_0 then
		local var_3_0 = {}
		local var_3_1 = manager.time:GetServerTime()

		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			local var_3_2 = iter_3_1 + var_0_2()

			if var_3_1 < var_3_2 then
				table.insert(var_3_0, var_3_2)
			end
		end

		if #var_3_0 > 0 then
			table.sort(var_3_0, function(arg_4_0, arg_4_1)
				return arg_4_1 < arg_4_0
			end)

			return var_3_0[math.min(#var_3_0, arg_3_1)]
		end
	end

	return 0
end

function var_0_0.InitFromServerData(arg_5_0, arg_5_1)
	arg_5_0.oathData = arg_5_0.oathData or {}
	arg_5_0.oathPlot = arg_5_0.oathPlot or {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if not nullable(arg_5_0.oathData, iter_5_1.hero_id, "oath_level") then
			local var_5_0 = iter_5_1.oath_level
		end

		arg_5_0.oathData[iter_5_1.hero_id] = {
			hero_id = iter_5_1.hero_id,
			oath = iter_5_1.oath,
			oath_level = iter_5_1.oath_level,
			nick = iter_5_1.nick,
			picture_link = iter_5_1.picture_link,
			oath_time = iter_5_1.oath_time,
			oath_rename_next_time = var_0_3(iter_5_1.time_list, 1)
		}

		local var_5_1 = iter_5_1.oath_plot.text_list

		for iter_5_2, iter_5_3 in ipairs(var_5_1) do
			arg_5_0.oathPlot[iter_5_3] = true
		end

		for iter_5_4, iter_5_5 in pairs(OathConst.OATH_CONTENT_TAG_KEY) do
			OathSupportData:UpdateOathContentRed(iter_5_1.hero_id, iter_5_5)
		end

		OathSupportData:UpdateOathCanCompleteNotice(iter_5_1.hero_id)
	end
end

function var_0_0.HasNewLevelUpdateMsg(arg_6_0, arg_6_1)
	if arg_6_0.oathLevelUpdate == nil then
		return false
	end

	if arg_6_1 then
		local var_6_0 = arg_6_0.oathLevelUpdate[arg_6_1]

		if var_6_0 then
			return arg_6_1, var_6_0
		else
			return nil, nil
		end
	else
		return next(arg_6_0.oathLevelUpdate)
	end
end

function var_0_0.AddNewLevelUpdateMsg(arg_7_0, arg_7_1)
	if arg_7_0.oathLevelUpdate == nil then
		arg_7_0.oathLevelUpdate = {}
	end

	arg_7_0.oathLevelUpdate[arg_7_1] = arg_7_0:GetOathLevel(arg_7_1)
end

function var_0_0.OnLevelUpdateMsgRead(arg_8_0, arg_8_1)
	if arg_8_0.oathLevelUpdate ~= nil then
		arg_8_0.oathLevelUpdate[arg_8_1] = nil
	end
end

local function var_0_4(arg_9_0)
	return {
		oath_level = 0,
		oath = false,
		hero_id = arg_9_0
	}
end

local function var_0_5(arg_10_0, arg_10_1)
	if arg_10_0.oathData == nil then
		arg_10_0.oathData = {}
	end

	local var_10_0 = arg_10_0.oathData[arg_10_1]

	if var_10_0 == nil then
		var_10_0 = var_0_4(arg_10_1)
		var_10_0.oath = true
		arg_10_0.oathData[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.UpdateOathTime(arg_11_0, arg_11_1, arg_11_2)
	var_0_5(arg_11_0, arg_11_1).oath_time = arg_11_2
end

function var_0_0.UpdateWeddingPhoto(arg_12_0, arg_12_1, arg_12_2)
	var_0_5(arg_12_0, arg_12_1).picture_link = arg_12_2
end

function var_0_0.UpdateHeroNickName(arg_13_0, arg_13_1, arg_13_2)
	var_0_5(arg_13_0, arg_13_1).nick = arg_13_2

	manager.notify:Invoke(OATH_CHANGE_NAME, arg_13_1)
end

function var_0_0.GetNextRenameAvailableTime(arg_14_0, arg_14_1)
	return nullable(arg_14_0.oathData, arg_14_1, "oath_rename_next_time") or 0
end

function var_0_0.GetWeddingPhotoUrl(arg_15_0, arg_15_1)
	return nullable(arg_15_0.oathData, arg_15_1, "picture_link")
end

function var_0_0.GetOathLevel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetOathState() and 1 or 0

	return nullable(arg_16_0.oathData, arg_16_1, "oath_level") or var_16_0
end

function var_0_0.GetOathState(arg_17_0, arg_17_1)
	return nullable(arg_17_0.oathData, arg_17_1, "oath") or false
end

function var_0_0.GetOathCustomNickName(arg_18_0, arg_18_1)
	local var_18_0 = nullable(arg_18_0.oathData, arg_18_1, "nick")

	if var_18_0 == "" then
		var_18_0 = nil
	end

	return var_18_0
end

function var_0_0.GetOathTime(arg_19_0, arg_19_1)
	return nullable(arg_19_0.oathData, arg_19_1, "oath_time")
end

function var_0_0.ReadPlotStory(arg_20_0, arg_20_1)
	arg_20_0.oathPlot[arg_20_1] = true

	manager.notify:Invoke("OATH_READ_PLOT", arg_20_1)
end

function var_0_0.IsPlotStoryRead(arg_21_0, arg_21_1)
	return arg_21_0.oathPlot[arg_21_1]
end

function var_0_0.IsPlotStoryUnlocked(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = WeddingCfg[arg_22_1]
	local var_22_1 = table.indexof(var_22_0.wedding_plot, arg_22_2)

	if var_22_1 then
		local var_22_2 = var_22_0.plot_condition[var_22_1]

		return IsConditionAchieved(var_22_2)
	else
		return false
	end
end

function var_0_0.UpdateAnyOathRingWillExpireRedpoint(arg_23_0)
	local var_23_0 = nullable(GameSetting, "item_expire_hint", "value", 1) or 7

	if not arg_23_0.finishCheckRingExipreRedpoint then
		arg_23_0.finishCheckRingExipreRedpoint = true

		for iter_23_0, iter_23_1 in pairs(MaterialData:GetMaterialListById(ItemConst.OATH_RING_COUPON)) do
			if iter_23_0 ~= 0 and iter_23_0 < manager.time:GetServerTime() + var_23_0 * manager.time.DaySecs then
				manager.redPoint:setTip(RedPointConst.OATH_RING_COUPON_WILL_EXPIRE, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.OATH_RING_COUPON_WILL_EXPIRE, 0)
	end
end

return var_0_0
