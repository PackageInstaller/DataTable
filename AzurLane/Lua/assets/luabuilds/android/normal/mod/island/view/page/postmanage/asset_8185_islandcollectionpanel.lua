class = var_0_10000

local var_0_0 = "IslandCollectionPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 3
local var_0_3 = "#ff7d36"
local var_0_4 = "#39BFFF"

function var_0_1.getUIName(arg_1_0)
	return "IslandAutomaticCollectionPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001
	arg_2_0.uiShipList = var_1_10001.New(arg_2_0.uiShipContent, arg_2_0.uiShipTpl)
	UIItemList = var_1
	arg_2_0.uiTipList = var_1.New(arg_2_0.uiTipContent, arg_2_0.uiTipTpl)

	return
end

function var_0_1.ExistHandCollection(arg_3_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.GetIsland(var_3_0)
	local var_3_2 = var_1.GetBuildingAgency(var_3_1)
	local var_3_3 = {}

	IslandProductConst = var_1_10004
	var_3_3[1] = var_1_10004.MinePlaceId
	IslandProductConst = var_4
	var_3_3[2] = var_4.FellingPlaceId
	ipairs = var_4

	for iter_3_0, iter_3_1 in var_4(var_3_3) do
		local var_3_4

		if not var_3_2:GetBuilding(iter_3_1) or not var_9:GetBuildingCollectData() then
			var_3_4 = nil
		end

		if var_3_4 then
			local var_3_5 = var_3_4
			local var_3_6 = var_3_4.GetCollectSlotDatasDic(var_3_5)

			pairs = var_3_5

			for iter_3_2, iter_3_3 in var_3_5(var_3_6) do
				if iter_3_3:GetCanCollectTimeStamps() == 0 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_1.ExistGather(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()
	local var_4_1 = var_1.GetServerTime(var_4_0)

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(arg_4_0.gatherDataList) do
		if iter_4_1.state == 0 or iter_4_1.state == 1 and var_4_1 > iter_4_1.refresh_time then
			return true
		end
	end

	return false
end

function var_0_1.CheckHasCollectData(arg_5_0, arg_5_1)
	IslandAutoCollectHelper = var_1_10002

	if arg_5_1 == var_1_10002.SelectType.HandCollection then
		return arg_5_0:ExistHandCollection()
	else
		IslandAutoCollectHelper = var_2

		if arg_5_1 == var_2.SelectType.Gather then
			return arg_5_0:ExistGather()
		else
			IslandAutoCollectHelper = var_2

			if arg_5_1 == var_2.SelectType.Both then
				local var_5_0

				if not arg_5_0:ExistHandCollection() then
					var_5_0 = arg_5_0:ExistGather()
				end

				return var_5_0
			end
		end
	end

	return false
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.uiSelectConfirm, function()
		local var_7_0 = arg_6_0.contextData
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		i18n = var_2_10003
		var_7_2.content = var_2_10003("collect_chapter_is_activation")

		function var_7_2.onYes(arg_8_0, arg_8_1)
			local var_8_0 = arg_6_0

			if var_2.CheckHasCollectData(var_8_0, arg_8_0) == false then
				pg = var_2

				local var_8_1 = var_2.TipsMgr.GetInstance()
				local var_8_2 = var_2.ShowTips

				i18n = var_4

				var_8_2(var_8_1, var_4("island_chara_gather_no_target"))

				return
			end

			local var_8_3 = arg_6_0

			var_2.AfterSelectType(var_8_3, arg_8_0)
			arg_8_1()

			return
		end

		IslandMsgBox = var_3
		var_7_2.type = var_3.TYPE_COMMON_AUTO_CONFIRM

		var_7_1(var_7_0, var_7_2)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.uiBackBtn, function()
		local var_9_0 = arg_6_0

		IslandAutoCollectHelper = var_2_10001
		var_9_0.curType = var_2_10001.SelectType.None

		local var_9_1 = arg_6_0

		var_0.Flush(var_9_1)

		return
	end)

	local var_6_0 = arg_6_0.uiShipList

	var_1.make(var_6_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventInit then
			local var_10_0 = arg_6_0

			var_3.InitShipItem(var_10_0, arg_10_1, arg_10_2)
		else
			UIItemList = var_3

			if arg_10_0 == var_3.EventUpdate then
				local var_10_1 = arg_6_0

				var_3.UpdateShipItem(var_10_1, arg_10_1, arg_10_2)
			end
		end

		return
	end)

	local var_6_1 = arg_6_0.uiTipList

	var_1.make(var_6_1, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventInit then
			local var_11_0 = arg_6_0

			var_3.InitItem(var_11_0, arg_11_1, arg_11_2)
		else
			UIItemList = var_3

			if arg_11_0 == var_3.EventUpdate then
				local var_11_1 = arg_6_0

				var_3.UpdateItem(var_11_1, arg_11_1, arg_11_2)
			end
		end

		return
	end)

	setText = var_1

	local var_6_2 = arg_6_0.uiSelectConfirmText

	i18n = var_3

	var_1(var_6_2, var_3("island_chara_gather_range"))

	setText = var_1

	local var_6_3 = arg_6_0.uiConfirmText

	i18n = var_3

	var_1(var_6_3, var_3("island_chara_gather_start"))

	setText = var_1

	local var_6_4 = arg_6_0.uiBackText

	i18n = var_3

	var_1(var_6_4, var_3("word_back"))

	return
end

function var_0_1.InitShipItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 + 1

	onButton = var_1_10004

	var_1_10004(arg_12_0, arg_12_2:Find("unlock/btn"), function()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		IslandMediator = var_2_10002

		local var_13_2 = var_2_10002.OPEN_PAGE
		local var_13_3 = "IslandShipSelectPage"
		local var_13_4 = {}
		local var_13_5 = {}

		IslandShipAttr = var_2_10006
		var_13_5.attrType = var_2_10006.COLLECT_KEY

		function var_13_5.confirmFunc(arg_14_0)
			local var_14_0 = arg_12_0

			var_1.AfterShipSelect(var_14_0, var_12_0, arg_14_0[1])

			return
		end

		var_13_5.autoCollectionSelectShip = arg_12_0.selectShips
		var_13_4[1] = var_13_5

		var_13_1(var_13_0, var_13_2, var_13_3, var_13_4)

		return
	end)

	onButton = var_1_10004

	var_1_10004(arg_12_0, arg_12_2:Find("unlock/ship/delete"), function()
		arg_12_0.selectShips[var_12_0] = nil

		local var_15_0 = arg_12_0

		var_0.Flush(var_15_0)

		return
	end)

	return
end

function var_0_1.UpdateShipItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.curType

	IslandAutoCollectHelper = var_1_10004

	local var_16_1 = var_16_0 == var_1_10004.SelectType.None

	setActive = var_4

	var_4(arg_16_2:Find("lock"), var_16_1)

	setActive = var_4

	var_4(arg_16_2:Find("unlock"), not var_16_1)

	if var_16_1 then
		return
	end

	local var_16_2 = arg_16_1 + 1
	local var_16_3 = arg_16_0.selectShips[var_16_2] ~= nil and true or false

	setActive = var_7

	var_7(arg_16_2:Find("unlock/ship"), var_16_3)

	setActive = var_7

	var_7(arg_16_2:Find("unlock/add"), not var_16_3)

	setActive = var_7

	var_7(arg_16_2:Find("unlock/add"), not var_16_3)

	if not var_5 then
		return
	end

	IslandShip = var_7

	local var_16_4 = var_7.StaticGetPrefab(var_5)

	LoadImageSpriteAsync = var_8

	var_8("squareicon/" .. var_16_4, arg_16_2:Find("unlock/ship/mask/icon"))

	if not arg_16_0.expAddlist[var_16_2] then
		setActive = var_9

		var_9(arg_16_2:Find("unlock/ship/exp"), false)

		return
	end

	setActive = var_9

	var_9(arg_16_2:Find("unlock/ship/exp"), true)

	setText = var_9

	local var_16_5 = arg_16_2
	local var_16_6 = arg_16_2.Find(var_16_5, "unlock/ship/exp/addExp")

	string = var_16_5

	var_9(var_16_6, var_16_5.format("EXP+%d", var_8))

	return
end

function var_0_1.AfterShipSelect(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.selectShips[arg_17_1] = arg_17_2

	arg_17_0:Flush()

	return
end

function var_0_1.InitItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1 + 1

	IslandAutoCollectHelper = var_1_10004

	local var_18_1 = var_1_10004.CostTipList[var_18_0]

	setText = var_1_10005

	var_1_10005(arg_18_2:Find("name"), var_18_1)

	return
end

function var_0_1.UpdateItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 + 1
	local var_19_1 = arg_19_0.costTipList[var_19_0]

	setText = var_1_10005

	var_1_10005(arg_19_2:Find("num"), var_19_1)

	return
end

function var_0_1.Flush(arg_20_0)
	setActive = var_1_10001

	local var_20_0 = arg_20_0.uiSelectConfirm
	local var_20_1 = arg_20_0.curType

	IslandAutoCollectHelper = var_1_10004

	var_1_10001(var_20_0, var_20_1 == var_1_10004.SelectType.None)

	setActive = var_1_10001

	local var_20_2 = arg_20_0.uiConfirmBtn
	local var_20_3 = arg_20_0.curType

	IslandAutoCollectHelper = var_4

	var_1_10001(var_20_2, var_20_3 ~= var_4.SelectType.None)

	setActive = var_1_10001

	local var_20_4 = arg_20_0.uiBackBtn
	local var_20_5 = arg_20_0.curType

	IslandAutoCollectHelper = var_4

	var_1_10001(var_20_4, var_20_5 ~= var_4.SelectType.None)

	local var_20_6 = arg_20_0

	arg_20_0.RefreshData(var_20_6)

	local var_20_7 = arg_20_0.curType

	IslandAutoCollectHelper = var_20_6

	if var_20_7 ~= var_20_6.SelectType.None then
		setActive = var_20_7

		local var_20_8 = arg_20_0.uiConfirmBtn.transform

		var_20_7(var_2.Find(var_20_8, "blue"), arg_20_0.cheackEnough)

		setActive = var_20_7

		local var_20_9 = arg_20_0.uiConfirmBtn.transform

		var_20_7(var_2.Find(var_20_9, "gray"), not arg_20_0.cheackEnough)

		if arg_20_0.cheackEnough then
			onButton = var_1

			var_1(arg_20_0, arg_20_0.uiConfirmBtn, function()
				local var_21_0 = {}

				pairs = var_2_10001

				for iter_21_0, iter_21_1 in var_2_10001(arg_20_0.selectShips) do
					table = var_2_10006

					var_2_10006.insert(var_21_0, iter_21_1)
				end

				pg = var_1

				local var_21_1 = var_1.m02
				local var_21_2 = var_1.sendNotification

				GAME = var_3

				var_21_2(var_21_1, var_3.ISLAND_TAKE_AUTO_COLLECTION, {
					type = arg_20_0.curType,
					ship_list = var_21_0,
					gatherData = arg_20_0.gatherDataList
				})

				return
			end)
		else
			removeOnButton = var_1

			var_1(arg_20_0.uiConfirmBtn)
		end
	end

	local var_20_10 = arg_20_0.uiShipList

	var_1.align(var_20_10, var_0_2)

	local var_20_11 = arg_20_0.uiTipList
	local var_20_12 = var_1.align

	IslandAutoCollectHelper = var_3

	var_20_12(var_20_11, #var_3.CostTipList)

	return
end

function var_0_1.GetCostData(arg_22_0)
	local var_22_0 = 0
	local var_22_1 = 0
	local var_22_2 = 0

	arg_22_0.autoCostList = {}

	local var_22_3 = arg_22_0.curType

	IslandAutoCollectHelper = var_1_10005

	if var_22_3 ~= var_1_10005.SelectType.HandCollection then
		local var_22_4 = arg_22_0.curType

		IslandAutoCollectHelper = var_5

		if var_22_4 == var_5.SelectType.Both then
			local var_22_5 = {}

			IslandProductConst = var_5
			var_22_5[1] = var_5.MinePlaceId
			IslandProductConst = var_5
			var_22_5[2] = var_5.FellingPlaceId
			getProxy = var_5
			IslandProxy = var_1_10006

			local var_22_6 = var_5(var_1_10006)
			local var_22_7 = var_5.GetIsland(var_22_6)
			local var_22_8 = var_5.GetBuildingAgency(var_22_7)

			ipairs = var_22_7

			for iter_22_0, iter_22_1 in var_22_7(var_22_5) do
				local var_22_9

				if not var_22_8:GetBuilding(iter_22_1) or not var_12:GetBuildingCollectData() then
					var_22_9 = nil
				end

				local var_22_10 = arg_22_0.buildCostDic[iter_22_1]

				if var_22_9 then
					local var_22_11 = var_22_9
					local var_22_12 = var_22_9.GetCollectSlotDatasDic(var_22_11)

					pairs = var_22_11

					for iter_22_2, iter_22_3 in var_22_11(var_22_12) do
						local var_22_13 = iter_22_3
						local var_22_14

						if iter_22_3.GetCanCollectTimeStamps(var_22_13) == 0 then
							var_22_13 = arg_22_0
							var_22_14 = arg_22_0.CheckIsDefauotSlot(var_22_13, iter_22_1, iter_22_3.id)
						else
							var_22_14 = false
						end

						if false then
							var_22_14 = true
						end

						if var_22_14 then
							table = var_22_13

							var_22_13.insert(arg_22_0.autoCostList, {
								energyCost = var_22_10.energyCost,
								coinCost = var_22_10.coinCost,
								expAdd = var_22_10.expCost
							})
						end
					end
				end
			end
		end

		local var_22_15 = arg_22_0.curType

		IslandAutoCollectHelper = var_5

		if var_22_15 ~= var_5.SelectType.Gather then
			var_22_15 = arg_22_0.curType
			IslandAutoCollectHelper = var_5

			if var_22_15 == var_5.SelectType.Both then
				pg = var_22_15

				local var_22_16 = var_22_15.TimeMgr.GetInstance()

				var_22_15 = var_22_15.GetServerTime(var_22_16)
				ipairs = var_22_16

				for iter_22_4, iter_22_5 in var_22_16(arg_22_0.gatherDataList) do
					if iter_22_5.state == 0 or iter_22_5.state == 1 and iter_22_5.refresh_time < var_22_15 then
						pg = var_10

						local var_22_17 = var_10.island_wild_gather[iter_22_5.id]

						table = var_11

						var_11.insert(arg_22_0.autoCostList, {
							energyCost = var_22_17.auto_parameters[2],
							coinCost = var_22_17.auto_parameters[1],
							expAdd = var_22_17.auto_parameters[3]
						})
					end
				end
			end

			ipairs = var_22_15

			for iter_22_6, iter_22_7 in var_22_15(arg_22_0.autoCostList) do
				var_22_0 = var_22_0 + iter_22_7.energyCost
				var_22_1 = var_22_1 + iter_22_7.coinCost
				var_22_2 = var_22_2 + iter_22_7.expAdd
			end

			return var_22_0, var_22_1, var_22_2
		end
	end
end

function var_0_1.GetGatherReducePercent(arg_23_0)
	local var_23_0 = 0

	pairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_0.selectShips) do
		IslandAutoCollectHelper = var_1_10007
		var_23_0 = var_23_0 + var_1_10007.GetAttributeReducePercent(iter_23_1)
	end

	return var_23_0
end

function var_0_1.GetShipCount(arg_24_0)
	local var_24_0 = 0

	pairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.selectShips) do
		var_24_0 = var_24_0 + 1
	end

	return var_24_0
end

function var_0_1.RefreshData(arg_25_0)
	arg_25_0.costTipList = {}
	arg_25_0.expAddlist = {}
	arg_25_0.cheackEnough = false

	local var_25_0, var_25_1, var_25_2 = arg_25_0:GetCostData()
	local var_25_3
	local var_25_4
	local var_25_5 = arg_25_0.curType

	IslandAutoCollectHelper = var_1_10007

	if var_25_5 == var_1_10007.SelectType.None then
		var_25_3 = "/"
		var_25_4 = "/"
	elseif arg_25_0:GetShipCount() == 0 then
		var_25_3 = var_25_0
		var_25_4 = var_25_1
	else
		local var_25_6 = arg_25_0

		var_25_5 = arg_25_0.GetGatherReducePercent(var_25_6)
		math = var_25_6

		local var_25_7 = var_25_6.floor(var_25_0 * (1 - var_25_5 * 0.01))
		local var_25_8 = 0

		for iter_25_0 = 1, 3 do
			if arg_25_0.selectShips[iter_25_0] then
				getProxy = var_1_10014
				IslandProxy = var_1_10015
				var_1_10015 = var_1_10014(var_1_10015)

				local var_25_9 = var_1_10014.GetIsland(var_1_10015)
				local var_25_10 = var_1_10014.GetCharacterAgency(var_25_9)
				local var_25_11 = var_1_10015.GetShipById(var_25_10, var_13)
				local var_25_12 = var_16.GetCurrentEnergy(var_25_11)
				local var_25_13 = 0

				if var_25_12 <= var_25_7 then
					var_25_13 = var_25_12
				else
					var_25_13 = var_25_7
				end

				var_25_7 = var_25_7 - var_25_13
				var_25_8 = var_25_8 + var_25_12

				local var_25_14 = var_25_13 / var_1 * var_25_2
				local var_25_15 = arg_25_0.expAddlist

				math = var_1_10021
				var_25_15[iter_25_0] = var_1_10021.floor(var_25_14)
			end
		end

		local var_25_16

		if not (var_1 <= var_25_8) or not var_0_4 then
			var_25_16 = var_0_3
		end

		string = var_11
		var_25_3 = var_11.format("<color=%s>%d</color>/%d(-%d%%)", var_25_16, var_25_8, var_1, var_25_5)
		getProxy = var_11
		IslandProxy = var_12

		local var_25_17 = var_11(var_12)
		local var_25_18 = var_11.GetIsland(var_25_17)
		local var_25_19 = var_11.GetInventoryAgency(var_25_18)
		local var_25_20

		if not var_11.GetItemById(var_25_19, 1) or not var_12:GetCount() then
			var_25_20 = 0
		end

		local var_25_21

		if not (var_25_1 <= var_25_20) or not var_0_4 then
			var_25_21 = var_0_3
		end

		string = var_16
		var_25_4 = var_16.format("<color=%s>%d</color>/%d", var_25_21, var_25_1, var_25_20)
		arg_25_0.cheackEnough = var_9 and var_14
	end

	table = var_25_5

	var_25_5.insert(arg_25_0.costTipList, var_25_3)

	table = var_6

	var_6.insert(arg_25_0.costTipList, var_25_4)

	return
end

function var_0_1.OnGetCollctionDone(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.selectType

	IslandAutoCollectHelper = var_1_10003

	if var_26_0 ~= var_1_10003.SelectType.Gather then
		IslandAutoCollectHelper = var_3

		if var_26_0 == var_3.SelectType.Both then
			arg_26_0.gatherDataList = {}
		end

		IslandAutoCollectHelper = var_3
		arg_26_0.curType = var_3.SelectType.None

		arg_26_0:Flush()

		return
	end
end

function var_0_1.AfterSelectType(arg_27_0, arg_27_1)
	arg_27_0.curType = arg_27_1

	arg_27_0:Flush()

	return
end

function var_0_1.OnDestroy(arg_28_0)
	return
end

function var_0_1.ConfigDataHandle(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.island_set.mining_auto_parameters.key_value_varchar

	arg_29_0.buildCostDic = {}
	ipairs = var_2

	for iter_29_0, iter_29_1 in var_2(var_29_0) do
		local var_29_1 = iter_29_1[1]

		arg_29_0.buildCostDic[var_29_1] = {}
		arg_29_0.buildCostDic[var_29_1].coinCost = iter_29_1[2]
		arg_29_0.buildCostDic[var_29_1].energyCost = iter_29_1[3]
		arg_29_0.buildCostDic[var_29_1].expCost = iter_29_1[4]
	end

	arg_29_0.buildDefaultList = {}
	pg = var_2

	local var_29_2 = var_2.island_set.mining_default_slot.key_value_varchar

	ipairs = var_3

	for iter_29_2, iter_29_3 in var_3(var_29_2) do
		local var_29_3 = iter_29_3[1]
		local var_29_4 = arg_29_0.buildDefaultList

		var_29_4[var_29_3] = {}
		ipairs = var_29_4

		for iter_29_4, iter_29_5 in var_29_4(iter_29_3[2]) do
			table = var_1_10014

			var_1_10014.insert(arg_29_0.buildDefaultList[var_29_3], iter_29_5)
		end
	end

	return
end

function var_0_1.CheckIsDefauotSlot(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0

	if not arg_30_0.buildDefaultList[arg_30_1] then
		var_30_0 = {}
	end

	ipairs = var_1_10004

	for iter_30_0, iter_30_1 in var_1_10004(var_30_0) do
		if iter_30_1 == arg_30_2 then
			return true
		end
	end

	return false
end

function var_0_1.Show(arg_31_0, arg_31_1)
	var_0_1.super.Show(arg_31_0)
	arg_31_0:ConfigDataHandle()

	arg_31_0.gatherDataList = {}
	ipairs = var_2

	for iter_31_0, iter_31_1 in var_2(arg_31_1.gather_list) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_31_0 = arg_31_0.gatherDataList

		IslandWildGatherData = var_1_10009

		var_1_10007(var_31_0, var_1_10009.New(iter_31_1))
	end

	IslandAutoCollectHelper = var_2
	arg_31_0.curType = var_2.SelectType.None
	arg_31_0.selectShips = {}
	arg_31_0.uiItemTipList = {}

	arg_31_0:Flush()

	return
end

return var_0_1
