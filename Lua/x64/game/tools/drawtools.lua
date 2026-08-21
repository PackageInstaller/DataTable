local var_0_0 = {}
local var_0_1 = 15

function var_0_0.GetRechargeDrawGiftList(arg_1_0)
	local var_1_0 = DrawPoolCfg[arg_1_0]

	if not var_1_0 or var_1_0.recharge_shop_list == "" then
		return {}
	else
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in pairs(var_1_0.recharge_shop_list) do
			local var_1_2 = ShopCfg[iter_1_1]

			if var_1_2 and ShopTools.IsGoodCanDisplay(var_1_2.shop_id, iter_1_1) then
				table.insert(var_1_1, iter_1_1)
			end
		end

		table.sort(var_1_1, function(arg_2_0, arg_2_1)
			local var_2_0 = getShopCfg(arg_2_0)
			local var_2_1 = getShopCfg(arg_2_1)
			local var_2_2 = var_0_0.GetGoodStatus(arg_2_0)
			local var_2_3 = var_0_0.GetGoodStatus(arg_2_1)

			if var_2_2 ~= var_2_3 then
				return var_2_2 < var_2_3
			end

			if var_2_0.shop_sort ~= var_2_1.shop_sort then
				return var_2_0.shop_sort > var_2_1.shop_sort
			end

			return var_2_0.goods_id > var_2_1.goods_id
		end)

		return var_1_1
	end
end

function var_0_0.GetGoodStatus(arg_3_0)
	local var_3_0 = false
	local var_3_1 = getShopCfg(arg_3_0)
	local var_3_2 = ShopData.GetShop(var_3_1.shop_id)[arg_3_0]

	if ShopData.IsGoodOutOfDate(arg_3_0) then
		return 2
	end

	if var_3_2 ~= nil and var_3_1.limit_num ~= nil and var_3_1.limit_num ~= -1 and var_3_1.limit_num - var_3_2.buy_times <= 0 then
		var_3_0 = true
	end

	if var_3_0 then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_3_0) == 0 then
		return 1
	end

	return 0
end

function var_0_0.GetCostTicket(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.GetCostTicketList(arg_4_0)

	arg_4_1 = arg_4_1 or 1

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if arg_4_1 <= ItemTools.getItemNum(iter_4_1) then
			return iter_4_1
		end
	end

	return var_4_0[#var_4_0]
end

function var_0_0.GetCostTicketList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {
		DrawPoolCfg[arg_5_0].cost_once[1]
	}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if ItemTools.getItemNum(iter_5_1) > 0 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	local var_5_2 = var_5_1[#var_5_1]

	if not table.keyof(var_5_0, var_5_2) then
		table.insert(var_5_0, var_5_2)
	end

	return var_5_0
end

function var_0_0.GetActivityCostTicket(arg_6_0)
	return DrawPoolCfg[arg_6_0].cost_once_activity_material[1] or 0
end

function var_0_0.GetActivityPoolIdByTicketId(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(DrawPoolCfg) do
		local var_7_0 = DrawPoolCfg[iter_7_0]

		if var_7_0.cost_once_activity_material and var_7_0.cost_once_activity_material[1] == arg_7_0 then
			return iter_7_0
		end
	end

	return nil
end

function var_0_0.LoadDrawLevel(arg_8_0)
	local var_8_0 = SceneManager.GetSceneByName("X102")

	if var_8_0 and var_8_0.isLoaded == true then
		return
	end

	if arg_8_0.operation_ then
		return
	end

	arg_8_0.operation_ = Asset.LoadLevelAsync("Levels/X102", true)

	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end

	arg_8_0.timer_ = FrameTimer.New(handler(arg_8_0, arg_8_0.Process), 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.Process(arg_9_0)
	if arg_9_0.operation_:IsDone() then
		if not gameContext:GetOpenPageHandler("draw") then
			local var_9_0 = SceneManager.GetSceneByName("X102")

			if var_9_0 and var_9_0.isLoaded == true then
				SceneManager.UnloadSceneAsync("X102")
			end
		end

		if arg_9_0.timer_ then
			arg_9_0.timer_:Stop()

			arg_9_0.timer_ = nil
		end

		arg_9_0.operation_ = nil
	end
end

function var_0_0.UnLoadDrawLevel(arg_10_0)
	if arg_10_0.operation_ then
		return
	end

	local var_10_0 = SceneManager.GetSceneByName("X102")

	if var_10_0 and var_10_0.isLoaded == true then
		arg_10_0.exoperation_ = SceneManager.UnloadSceneAsync("X102")

		if arg_10_0.extimer_ then
			arg_10_0.extimer_:Stop()

			arg_10_0.extimer_ = nil
		end

		arg_10_0.extimer_ = FrameTimer.New(handler(arg_10_0, arg_10_0.exProcess), 1, -1)

		arg_10_0.extimer_:Start()
	end
end

function var_0_0.exProcess(arg_11_0)
	if not arg_11_0.exoperation_ or arg_11_0.exoperation_.isDone then
		Asset.Unload("Levels/X102")
		manager.gc:Collect()
		Resources.UnloadUnusedAssets()

		if arg_11_0.extimer_ then
			arg_11_0.extimer_:Stop()

			arg_11_0.extimer_ = nil
		end
	end
end

function var_0_0.LevelIsDone(arg_12_0)
	if arg_12_0.operation_ then
		return arg_12_0.operation_:IsDone()
	end

	return true
end

local function var_0_2(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = DrawPoolCfg[arg_13_0]

	if var_13_1.pool_type == 3 then
		if #var_13_1.unoption_up_items[1] == 0 then
			for iter_13_0, iter_13_1 in ipairs(var_13_1.optional_detail) do
				table.insert(var_13_0, iter_13_1)
			end
		else
			for iter_13_2, iter_13_3 in ipairs(var_13_1.unoption_up_items[1]) do
				table.insert(var_13_0, iter_13_3)
			end
		end

		for iter_13_4, iter_13_5 in ipairs(var_13_1.unoption_up_items[2]) do
			table.insert(var_13_0, iter_13_5)
		end
	elseif var_13_1.pool_type == 1 then
		for iter_13_6, iter_13_7 in ipairs(var_13_1.optional_lists or {}) do
			table.insert(var_13_0, iter_13_7)
		end
	end

	return var_13_0
end

function var_0_0.GetNowAllPool(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if ActivityData:GetActivityIsOpen(iter_14_1) then
			local var_14_2 = ActivityDrawPoolCfg[iter_14_1]

			if var_14_2 then
				for iter_14_2, iter_14_3 in ipairs(var_14_2.config_list) do
					table.insert(var_14_0, iter_14_3)
				end
			end
		end
	end

	return var_14_0
end

function var_0_0.GetNowAllRolePool(arg_15_0)
	local var_15_0 = DrawData:GetPoolList()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if DrawPoolCfg[iter_15_1].pool_type ~= 2 then
			table.insert(var_15_1, iter_15_1)
		end
	end

	return var_15_1
end

function var_0_0.GetNowAllServantPool(arg_16_0)
	local var_16_0 = var_0_0:GetNowAllPool()
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if DrawPoolCfg[iter_16_1].pool_type == 2 then
			table.insert(var_16_1, iter_16_1)
		end
	end

	return var_16_1
end

function var_0_0.GetRoleUpPoolID(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0:GetNowAllPool()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		for iter_17_2, iter_17_3 in ipairs(var_0_2(iter_17_1)) do
			if iter_17_3 == arg_17_1 then
				return iter_17_1
			end
		end
	end

	return false
end

function var_0_0.GoToSelectUpHeroView(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = DrawPoolCfg[arg_18_1]

	if var_18_0.is_grid_select == 1 then
		gameContext:Go("/drawAllHeroSelect", {
			poolId = arg_18_1,
			heroIdList = var_18_0.optional_detail,
			isFirst = arg_18_3
		})

		return
	end

	if var_18_0.pool_selected_type == 2 then
		if var_18_0.pool_type == 1 then
			gameContext:Go("/newbieDrawHeroSelect", {
				poolId = arg_18_1,
				heroIdList = var_18_0.optional_detail
			})
		else
			gameContext:Go("/drawAllHeroSelect", {
				poolId = arg_18_1,
				heroIdList = var_18_0.optional_detail,
				isFirst = arg_18_3
			})
		end
	elseif var_18_0.pool_selected_type == 8 then
		gameContext:Go("/newbieDrawHeroSelect", {
			poolId = arg_18_1,
			heroIdList = var_18_0.optional_detail
		})
	elseif var_18_0.pool_selected_type == 9 and arg_18_1 == DrawConst.WEAPON_SERVANT_POOL_ID then
		gameContext:Go("/drawSelect", {
			poolID = arg_18_1
		})
	elseif var_18_0.pool_selected_type == 9 and arg_18_1 ~= DrawConst.WEAPON_SERVANT_POOL_ID then
		gameContext:Go("/drawGodEaterSelect", {
			poolID = arg_18_1
		})
	elseif var_18_0.pool_selected_type == 1 then
		if table.indexof(var_18_0.optional_lists_poolId, arg_18_0.showId) == false then
			return
		end

		gameContext:Go("/newbieDrawHeroSelect", {
			poolId = arg_18_1,
			heroIdList = var_18_0.optional_detail
		})
	end
end

function var_0_0.GetDrawBonusActivityIDList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(ActivityDrawBonusCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_19_1) then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.GetDrawPieceActivityIDList()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(ActivityDrawPieceCfg.all) do
		if ActivityData:GetActivityIsOpen(iter_20_1) then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function var_0_0.HasDrawBonusPoolList(arg_21_0)
	local var_21_0 = var_0_0.GetDrawBonusActivityIDList()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
		local var_21_1 = var_0_0.HasDrawBonusPoolID(var_21_0, iter_21_1)

		if var_21_1 then
			return var_21_1
		end
	end
end

function var_0_0.HasDrawBonusPoolID(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		local var_22_0 = ActivityDrawBonusCfg[iter_22_1]

		if table.keyof(var_22_0.draw_pool_id, arg_22_1) then
			return iter_22_1
		end
	end

	return nil
end

function var_0_0.HasDrawPiecePoolID(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0) do
		local var_23_0 = ActivityDrawPieceCfg[iter_23_1]

		if table.keyof(var_23_0.draw_pool_id, arg_23_1) then
			return iter_23_1
		end
	end

	return nil
end

function var_0_0.GetBonusCnt(arg_24_0)
	local var_24_0 = ActivityDrawBonusCfg[arg_24_0]
	local var_24_1 = var_24_0.reward
	local var_24_2 = var_24_0.need
	local var_24_3 = DrawData:GetPoolBonus(arg_24_0)

	return math.floor(var_24_3 / var_24_2) * var_24_1[1][2]
end

return var_0_0
