local var_0_0 = class("IslandCollectionPanel", import("view.base.BaseSubView"))
local var_0_1 = 3
local var_0_2 = "#ff7d36"
local var_0_3 = "#39BFFF"

function var_0_0.getUIName(arg_1_0)
	return "IslandAutomaticCollectionPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uiShipList = UIItemList.New(arg_2_0.uiShipContent, arg_2_0.uiShipTpl)
	arg_2_0.uiTipList = UIItemList.New(arg_2_0.uiTipContent, arg_2_0.uiTipTpl)

	return
end

function var_0_0.ExistHandCollection(arg_3_0)
	local var_3_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

	for iter_3_0, iter_3_1 in ipairs({
		IslandProductConst.MinePlaceId,
		IslandProductConst.FellingPlaceId
	}) do
		local var_3_1 = var_3_0:GetBuilding(iter_3_1)
		local var_3_2 = var_3_1 and var_3_1:GetBuildingCollectData() or nil

		if var_3_2 then
			for iter_3_2, iter_3_3 in pairs((var_3_2:GetCollectSlotDatasDic())) do
				if iter_3_3:GetCanCollectTimeStamps() == 0 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.ExistGather(arg_4_0)
	local var_4_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.gatherDataList) do
		if iter_4_1.state == 0 or iter_4_1.state == 1 and var_4_0 > iter_4_1.refresh_time then
			return true
		end
	end

	return false
end

function var_0_0.CheckHasCollectData(arg_5_0, arg_5_1)
	if arg_5_1 == IslandAutoCollectHelper.SelectType.HandCollection then
		return arg_5_0:ExistHandCollection()
	elseif arg_5_1 == IslandAutoCollectHelper.SelectType.Gather then
		return arg_5_0:ExistGather()
	elseif arg_5_1 == IslandAutoCollectHelper.SelectType.Both then
		return arg_5_0:ExistHandCollection() or arg_5_0:ExistGather()
	end

	return false
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.uiSelectConfirm, function()
		arg_6_0.contextData:ShowMsgBox({
			content = i18n("collect_chapter_is_activation"),
			onYes = function(arg_8_0, arg_8_1)
				if arg_6_0:CheckHasCollectData(arg_8_0) == false then
					pg.TipsMgr.GetInstance():ShowTips(i18n("island_chara_gather_no_target"))

					return
				end

				arg_6_0:AfterSelectType(arg_8_0)
				arg_8_1()

				return
			end,
			type = IslandMsgBox.TYPE_COMMON_AUTO_CONFIRM
		})

		return
	end)
	onButton(arg_6_0, arg_6_0.uiBackBtn, function()
		arg_6_0.curType = IslandAutoCollectHelper.SelectType.None

		arg_6_0:Flush()

		return
	end)
	arg_6_0.uiShipList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventInit then
			arg_6_0:InitShipItem(arg_10_1, arg_10_2)
		elseif arg_10_0 == UIItemList.EventUpdate then
			arg_6_0:UpdateShipItem(arg_10_1, arg_10_2)
		end

		return
	end)
	arg_6_0.uiTipList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventInit then
			arg_6_0:InitItem(arg_11_1, arg_11_2)
		elseif arg_11_0 == UIItemList.EventUpdate then
			arg_6_0:UpdateItem(arg_11_1, arg_11_2)
		end

		return
	end)
	setText(arg_6_0.uiSelectConfirmText, i18n("island_chara_gather_range"))
	setText(arg_6_0.uiConfirmText, i18n("island_chara_gather_start"))
	setText(arg_6_0.uiBackText, i18n("word_back"))

	return
end

function var_0_0.InitShipItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 + 1

	onButton(arg_12_0, arg_12_2:Find("unlock/btn"), function()
		arg_12_0:emit(IslandMediator.OPEN_PAGE, "IslandShipSelectPage", {
			{
				attrType = IslandShipAttr.COLLECT_KEY,
				confirmFunc = function(arg_14_0)
					arg_12_0:AfterShipSelect(var_12_0, arg_14_0[1])

					return
				end,
				autoCollectionSelectShip = arg_12_0.selectShips
			}
		})

		return
	end)
	onButton(arg_12_0, arg_12_2:Find("unlock/ship/delete"), function()
		arg_12_0.selectShips[var_12_0] = nil

		arg_12_0:Flush()

		return
	end)

	return
end

function var_0_0.UpdateShipItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.curType == IslandAutoCollectHelper.SelectType.None

	setActive(arg_16_2:Find("lock"), arg_16_0.curType == IslandAutoCollectHelper.SelectType.None)
	setActive(arg_16_2:Find("unlock"), not var_16_0)

	if var_16_0 then
		return
	end

	local var_16_1 = arg_16_1 + 1
	local var_16_2 = arg_16_0.selectShips[arg_16_1 + 1]
	local var_16_3 = arg_16_0.selectShips[arg_16_1 + 1] ~= nil

	setActive(arg_16_2:Find("unlock/ship"), arg_16_0.selectShips[arg_16_1 + 1] ~= nil and true or false)
	setActive(arg_16_2:Find("unlock/add"), not var_16_3)
	setActive(arg_16_2:Find("unlock/add"), not var_16_3)

	if not var_16_2 then
		return
	end

	LoadImageSpriteAsync("squareicon/" .. IslandShip.StaticGetPrefab(var_16_2), arg_16_2:Find("unlock/ship/mask/icon"))

	if not arg_16_0.expAddlist[var_16_1] then
		setActive(arg_16_2:Find("unlock/ship/exp"), false)

		return
	end

	setActive(arg_16_2:Find("unlock/ship/exp"), true)
	setText(arg_16_2:Find("unlock/ship/exp/addExp"), string.format("EXP+%d", arg_16_0.expAddlist[var_16_1]))

	return
end

function var_0_0.AfterShipSelect(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.selectShips[arg_17_1] = arg_17_2

	arg_17_0:Flush()

	return
end

function var_0_0.InitItem(arg_18_0, arg_18_1, arg_18_2)
	setText(arg_18_2:Find("name"), IslandAutoCollectHelper.CostTipList[arg_18_1 + 1])

	return
end

function var_0_0.UpdateItem(arg_19_0, arg_19_1, arg_19_2)
	setText(arg_19_2:Find("num"), arg_19_0.costTipList[arg_19_1 + 1])

	return
end

function var_0_0.Flush(arg_20_0)
	setActive(arg_20_0.uiSelectConfirm, arg_20_0.curType == IslandAutoCollectHelper.SelectType.None)
	setActive(arg_20_0.uiConfirmBtn, arg_20_0.curType ~= IslandAutoCollectHelper.SelectType.None)
	setActive(arg_20_0.uiBackBtn, arg_20_0.curType ~= IslandAutoCollectHelper.SelectType.None)
	arg_20_0:RefreshData()

	if arg_20_0.curType ~= IslandAutoCollectHelper.SelectType.None then
		setActive(arg_20_0.uiConfirmBtn.transform:Find("blue"), arg_20_0.cheackEnough)
		setActive(arg_20_0.uiConfirmBtn.transform:Find("gray"), not arg_20_0.cheackEnough)

		if arg_20_0.cheackEnough then
			onButton(arg_20_0, arg_20_0.uiConfirmBtn, function()
				for iter_21_0, iter_21_1 in pairs(arg_20_0.selectShips) do
					table.insert({}, iter_21_1)
				end

				pg.m02:sendNotification(GAME.ISLAND_TAKE_AUTO_COLLECTION, {
					type = arg_20_0.curType,
					ship_list = {},
					gatherData = arg_20_0.gatherDataList
				})

				return
			end)
		else
			removeOnButton(arg_20_0.uiConfirmBtn)
		end
	end

	arg_20_0.uiShipList:align(var_0_1)
	arg_20_0.uiTipList:align(#IslandAutoCollectHelper.CostTipList)

	return
end

function var_0_0.GetCostData(arg_22_0)
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = 0

	arg_22_0.autoCostList = {}

	if arg_22_0.curType ~= IslandAutoCollectHelper.SelectType.HandCollection then
		if arg_22_0.curType == IslandAutoCollectHelper.SelectType.Both then
			local var_22_3 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

			for iter_22_0, iter_22_1 in ipairs({
				IslandProductConst.MinePlaceId,
				IslandProductConst.FellingPlaceId
			}) do
				local var_22_4 = var_22_3:GetBuilding(iter_22_1)
				local var_22_5 = var_22_4 and var_22_4:GetBuildingCollectData() or nil
				local var_22_6 = arg_22_0.buildCostDic[iter_22_1]

				if var_22_5 then
					for iter_22_2, iter_22_3 in pairs((var_22_5:GetCollectSlotDatasDic())) do
						if iter_22_3:GetCanCollectTimeStamps() == 0 and arg_22_0:CheckIsDefauotSlot(iter_22_1, iter_22_3.id) then
							table.insert(arg_22_0.autoCostList, {
								energyCost = var_22_6.energyCost,
								coinCost = var_22_6.coinCost,
								expAdd = var_22_6.expCost
							})
						end
					end
				end
			end
		end

		if arg_22_0.curType == IslandAutoCollectHelper.SelectType.Gather or arg_22_0.curType == IslandAutoCollectHelper.SelectType.Both then
			local var_22_7 = pg.TimeMgr.GetInstance():GetServerTime()

			for iter_22_4, iter_22_5 in ipairs(arg_22_0.gatherDataList) do
				if iter_22_5.state ~= 0 then
					if iter_22_5.state == 1 and var_22_7 > iter_22_5.refresh_time then
						({
							energyCost = pg.island_wild_gather[iter_22_5.id].auto_parameters[2],
							coinCost = pg.island_wild_gather[iter_22_5.id].auto_parameters[1]
						}).expAdd = pg.island_wild_gather[iter_22_5.id].auto_parameters[3]

						table.insert(arg_22_0.autoCostList, {
							energyCost = pg.island_wild_gather[iter_22_5.id].auto_parameters[2],
							coinCost = pg.island_wild_gather[iter_22_5.id].auto_parameters[1]
						})
					end
				end
			end
		end

		for iter_22_6, iter_22_7 in ipairs(arg_22_0.autoCostList) do
			var_22_0 = var_22_0 + iter_22_7.energyCost
			var_22_1 = var_22_1 + iter_22_7.coinCost
			var_22_2 = var_22_2 + iter_22_7.expAdd
		end

		return var_22_0, var_22_1, var_22_2
	end
end

function var_0_0.GetGatherReducePercent(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0.selectShips) do
		var_23_0 = var_23_0 + IslandAutoCollectHelper.GetAttributeReducePercent(iter_23_1)
	end

	return var_23_0
end

function var_0_0.GetShipCount(arg_24_0)
	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(arg_24_0.selectShips) do
		var_24_0 = var_24_0 + 1
	end

	return var_24_0
end

function var_0_0.RefreshData(arg_25_0)
	local var_25_9001
	local var_25_9000

	arg_25_0.costTipList = {}
	arg_25_0.expAddlist = {}
	arg_25_0.cheackEnough = false

	local var_25_0, var_25_1, var_25_2 = arg_25_0:GetCostData()
	local var_25_3
	local var_25_4
	local var_25_5 = arg_25_0:GetGatherReducePercent()
	local var_25_6 = math.floor(var_25_0 * (1 - var_25_5 * 0.01))
	local var_25_7 = var_25_6
	local var_25_8 = 0
	local var_25_13 = var_25_6 <= var_25_8

	if arg_25_0.curType == IslandAutoCollectHelper.SelectType.None then
		var_25_3 = "/"
		var_25_4 = "/"

		goto label_25_0
	end

	if arg_25_0:GetShipCount() == 0 then
		var_25_3 = var_25_0
		var_25_4 = var_25_1

		goto label_25_0
	end

	for iter_25_0 = 1, 3 do
		if arg_25_0.selectShips[iter_25_0] then
			local var_25_9 = getProxy(IslandProxy)
			local var_25_10 = var_25_9.GetIsland(var_25_9001):GetCharacterAgency()
			local var_25_11 = var_25_10:GetShipById(arg_25_0.selectShips[iter_25_0]).GetCurrentEnergy(var_25_9)
			local var_25_12 = 0

			var_25_12 = var_25_11 <= var_25_7 and var_25_11 or var_25_7
			var_25_7 = var_25_7 - var_25_12
			var_25_8 = var_25_8 + var_25_11
			arg_25_0.expAddlist[iter_25_0] = math.floor(var_25_12 / var_25_6 * var_25_2)
		end
	end

	::label_25_0::

	if var_25_6 <= var_25_8 then
		local var_25_14 = var_0_3 or var_0_2

		var_25_3 = string.format("<color=%s>%d</color>/%d(-%d%%)", var_25_14, var_25_8, var_25_6, var_25_5)

		local var_25_15 = getProxy(IslandProxy):GetIsland()
		local var_25_16 = var_25_15.GetInventoryAgency(var_25_9000):GetItemById(1)
		local var_25_17 = var_25_16 and var_25_16:GetCount() or 0
		local var_25_18 = var_25_1 <= var_25_15

		if var_25_1 <= var_25_15 then
			do
				local var_25_19 = var_0_3 or var_0_2

				var_25_4 = string.format("<color=%s>%d</color>/%d", var_25_19, var_25_1, var_25_17)
				arg_25_0.cheackEnough = var_25_13 and var_25_18
			end

			table.insert(arg_25_0.costTipList, var_25_3)
			table.insert(arg_25_0.costTipList, var_25_4)

			return
		end
	end
end

function var_0_0.OnGetCollctionDone(arg_26_0, arg_26_1)
	if arg_26_1.selectType == IslandAutoCollectHelper.SelectType.Gather or arg_26_1.selectType == IslandAutoCollectHelper.SelectType.Both then
		arg_26_0.gatherDataList = {}
	end

	arg_26_0.curType = IslandAutoCollectHelper.SelectType.None

	arg_26_0:Flush()

	return
end

function var_0_0.AfterSelectType(arg_27_0, arg_27_1)
	arg_27_0.curType = arg_27_1

	arg_27_0:Flush()

	return
end

function var_0_0.OnDestroy(arg_28_0)
	return
end

function var_0_0.ConfigDataHandle(arg_29_0)
	arg_29_0.buildCostDic = {}

	for iter_29_0, iter_29_1 in ipairs(pg.island_set.mining_auto_parameters.key_value_varchar) do
		arg_29_0.buildCostDic[iter_29_1[1]] = {}
		arg_29_0.buildCostDic[iter_29_1[1]].coinCost = iter_29_1[2]
		arg_29_0.buildCostDic[iter_29_1[1]].energyCost = iter_29_1[3]
		arg_29_0.buildCostDic[iter_29_1[1]].expCost = iter_29_1[4]
	end

	arg_29_0.buildDefaultList = {}

	for iter_29_2, iter_29_3 in ipairs(pg.island_set.mining_default_slot.key_value_varchar) do
		arg_29_0.buildDefaultList[iter_29_3[1]] = {}

		for iter_29_4, iter_29_5 in ipairs(iter_29_3[2]) do
			table.insert(arg_29_0.buildDefaultList[iter_29_3[1]], iter_29_5)
		end
	end

	return
end

function var_0_0.CheckIsDefauotSlot(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.buildDefaultList[arg_30_1] or {}

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		if iter_30_1 == arg_30_2 then
			return true
		end
	end

	return false
end

function var_0_0.Show(arg_31_0, arg_31_1)
	var_0_0.super.Show(arg_31_0)
	arg_31_0:ConfigDataHandle()

	arg_31_0.gatherDataList = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1.gather_list) do
		table.insert(arg_31_0.gatherDataList, IslandWildGatherData.New(iter_31_1))
	end

	arg_31_0.curType = IslandAutoCollectHelper.SelectType.None
	arg_31_0.selectShips = {}
	arg_31_0.uiItemTipList = {}

	arg_31_0:Flush()

	return
end

return var_0_0
