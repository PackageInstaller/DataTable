class = var_0_10000

local var_0_0 = "IslandTechDetailPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTechDetailPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.selectedTF = var_1.Find(var_2_0, "selected")

	local var_2_1 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_1, "panel")

	local var_2_2 = arg_2_0.panel

	arg_2_0.iconTF = var_1.Find(var_2_2, "icon_bg/icon")

	local var_2_3 = arg_2_0.panel

	arg_2_0.nameTF = var_1.Find(var_2_3, "title/Text")

	local var_2_4 = arg_2_0.panel

	arg_2_0.descPanel = var_1.Find(var_2_4, "desc")

	local var_2_5 = arg_2_0.descPanel

	arg_2_0.descTF = var_1.Find(var_2_5, "Text")

	local var_2_6 = arg_2_0.panel

	arg_2_0.unlockTF = var_1.Find(var_2_6, "unlock")
	setText = var_1

	local var_2_7 = arg_2_0.unlockTF
	local var_2_8 = var_3.Find(var_2_7, "title")

	i18n = var_4

	var_1(var_2_8, var_4("island_tech_unlock_need"))

	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0.unlockTF
	local var_2_11 = var_3.Find(var_2_10, "list")
	local var_2_12 = arg_2_0.unlockTF

	arg_2_0.unlockUIList = var_2_9(var_2_11, var_4.Find(var_2_12, "list/tpl"))

	local var_2_13 = arg_2_0.panel

	arg_2_0.normalTimeTextTF = var_1.Find(var_2_13, "status/normal/content/time/Text")

	local var_2_14 = arg_2_0.panel

	arg_2_0.timeTextTF = var_1.Find(var_2_14, "status/studying/time/Text")

	local var_2_15 = arg_2_0.panel
	local var_2_16 = var_1.Find(var_2_15, "status")

	setText = var_1_10002

	local var_2_17 = var_2_16:Find("lock/content/Text")

	i18n = var_2_10

	var_1_10002(var_2_17, var_2_10("island_tech_unlock_dev"))

	setText = var_1_10002

	local var_2_18 = var_2_16:Find("unlock/Text")

	i18n = var_5

	var_1_10002(var_2_18, var_5("island_tech_unlock_dev"))

	setText = var_1_10002

	local var_2_19 = var_2_16:Find("normal/content/Text")

	i18n = var_5

	var_1_10002(var_2_19, var_5("island_tech_dev_start"))

	setText = var_1_10002

	local var_2_20 = var_2_16:Find("normal/cost/title")

	i18n = var_5

	var_1_10002(var_2_20, var_5("island_tech_dev_cost"))

	setText = var_1_10002

	local var_2_21 = var_2_16:Find("studying/Text")

	i18n = var_5

	var_1_10002(var_2_21, var_5("island_tech_dev_starting"))

	setText = var_1_10002

	local var_2_22 = var_2_16:Find("receive/Text")

	i18n = var_5

	var_1_10002(var_2_22, var_5("island_tech_dev_success"))

	setText = var_1_10002

	local var_2_23 = var_2_16:Find("finished/normal/Text")

	i18n = var_5

	var_1_10002(var_2_23, var_5("island_tech_dev_finish"))

	arg_2_0.noramlFinsh = var_2_16:Find("finished/normal")
	arg_2_0.mapFinsh = var_2_16:Find("finished/map")

	local var_2_24 = arg_2_0.mapFinsh

	arg_2_0.mapFinshIcon = var_2.Find(var_2_24, "mapicon")

	local var_2_25 = arg_2_0.mapFinsh

	arg_2_0.mapFinshName = var_2.Find(var_2_25, "maptitle/name")

	local var_2_26 = arg_2_0.mapFinsh

	arg_2_0.npcTF = var_2.Find(var_2_26, "npc")

	local var_2_27 = arg_2_0.npcTF

	arg_2_0.npcIcon = var_2.Find(var_2_27, "npcicon")

	local var_2_28 = arg_2_0.npcTF

	arg_2_0.npcName = var_2.Find(var_2_28, "npcName")

	local var_2_29 = {}

	IslandTechnology = var_2_15
	var_2_29[var_2_15.STATUS.LOCK] = var_2_16:Find("lock")
	IslandTechnology = var_3
	var_2_29[var_3.STATUS.UNLOCK] = var_2_16:Find("unlock")
	IslandTechnology = var_3
	var_2_29[var_3.STATUS.NORMAL] = var_2_16:Find("normal")
	IslandTechnology = var_3
	var_2_29[var_3.STATUS.STUDYING] = var_2_16:Find("studying")
	IslandTechnology = var_3
	var_2_29[var_3.STATUS.RECEIVE] = var_2_16:Find("receive")
	IslandTechnology = var_3
	var_2_29[var_3.STATUS.FINISHED] = var_2_16:Find("finished")
	arg_2_0.statusTFs = var_2_29

	local var_2_30 = arg_2_0.panel

	arg_2_0.costTF = var_2.Find(var_2_30, "status/normal/cost")
	UIItemList = var_2

	local var_2_31 = var_2.New
	local var_2_32 = arg_2_0.costTF
	local var_2_33 = var_4.Find(var_2_32, "list")
	local var_2_34 = arg_2_0.costTF

	arg_2_0.costUIList = var_2_31(var_2_33, var_5.Find(var_2_34, "list/tpl"))
	setText = var_2

	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_4.Find(var_2_35, "panel/unlock/title")

	i18n = var_5

	var_2(var_2_36, var_5("island_tech_detail_unlocktitle"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "close")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	local var_3_4 = arg_3_0.unlockUIList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_3_0.unlockCondList[arg_5_1 + 1]

			setText = var_4

			local var_5_1 = arg_5_2:Find("Text")

			IslandTechnology = var_2_10007

			var_4(var_5_1, var_2_10007.GetUnlockText(var_5_0))

			local var_5_2 = arg_3_0.showTechVO
			local var_5_3 = var_4.MatchCondition(var_5_2, var_5_0) and "1E90FF" or "F5F5F5"

			setTextColor = var_5_2

			local var_5_4 = arg_5_2:Find("Text")

			Color = var_9

			var_5_2(var_5_4, var_9.NewHex(var_5_3))

			setImageColor = var_5_2

			local var_5_5 = arg_5_2:Find("dot")

			Color = var_9

			var_5_2(var_5_5, var_9.NewHex(var_5_3))
		end

		return
	end)

	local var_3_5 = arg_3_0.costUIList

	var_1.make(var_3_5, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_3_0.costList[arg_6_1 + 1]
			local var_6_1 = arg_3_0.inventoryAgency
			local var_6_2 = var_4.GetOwnCount(var_6_1, var_6_0.id)

			updateCustomDrop = var_2_10005

			var_2_10005(arg_6_2, var_6_0)

			local var_6_3 = arg_6_2
			local var_6_4 = arg_6_2.Find(var_6_3, "icon_bg/count_bg/count")
			local var_6_5 = var_6_0.id

			IslandItem = var_6_3

			if var_6_5 == var_6_3.GOLD_ID then
				setText = var_6_5

				local var_6_6 = var_6_4
				local var_6_7

				if var_6_2 < var_6_0.count then
					setColorStr = var_9
					var_6_7 = var_9(var_6_0.count, "#FF6767")
				else
					var_6_7 = false
				end

				if false then
					var_6_7 = true
				end

				var_6_5(var_6_6, var_6_7)

				goto label_6_0
			end

			setText = var_6_5

			local var_6_8 = var_6_4

			if var_6_2 < var_6_0.count then
				setColorStr = var_9

				do
					local var_6_9

					if not var_9(var_6_2, "#FF6767") then
						var_6_9 = var_6_2
					end

					var_6_5(var_6_8, var_6_9 .. "/" .. var_6_0.count)
				end

				::label_6_0::

				onButton = var_6_5

				var_6_5(arg_3_0, arg_6_2, function()
					local var_7_0 = arg_3_0.contextData
					local var_7_1 = var_0.ShowMsgBox
					local var_7_2 = {}

					i18n = var_3_10004
					var_7_2.title = var_3_10004("island_word_desc")
					IslandMsgBox = var_4
					var_7_2.type = var_4.TYPE_COMMON_DROP_DESCRIBE
					var_7_2.dropData = var_6_0

					var_7_1(var_7_0, var_7_2)

					return
				end)

				return
			end
		end
	end)

	IslandTechnologyAgency = var_1
	arg_3_0.placeId = var_1.PLACE_ID
	pg = var_1
	arg_3_0.baseEffectSpeed = var_1.island_set.base_efficiency.key_value_int

	return
end

function var_0_1.Flush(arg_8_0)
	local var_8_0 = arg_8_0

	arg_8_0.StopTimer(var_8_0)

	getProxy = var_1
	IslandProxy = var_8_0

	local var_8_1 = var_1(var_8_0)
	local var_8_2 = var_1.GetIsland(var_8_1)

	arg_8_0.buildingAgency = var_1.GetBuildingAgency(var_8_2)
	arg_8_0.techAgency = var_1:GetTechnologyAgency()
	arg_8_0.inventoryAgency = var_1:GetInventoryAgency()

	local var_8_3 = arg_8_0.techAgency

	arg_8_0.showTechVO = var_2.GetTechnology(var_8_3, arg_8_0.configId)
	LoadImageSpriteAsync = var_2

	local var_8_4 = "island/IslandTechnology/"
	local var_8_5 = arg_8_0.showTechVO

	var_2(var_8_4 .. var_5.getConfig(var_8_5, "tech_icon"), arg_8_0.iconTF, true)

	setText = var_2

	local var_8_6 = arg_8_0.nameTF
	local var_8_7 = arg_8_0.showTechVO

	var_2(var_8_6, var_5.getConfig(var_8_7, "tech_name"))

	setText = var_2

	local var_8_8 = arg_8_0.descTF
	local var_8_9 = arg_8_0.showTechVO

	var_2(var_8_8, var_5.getConfig(var_8_9, "tech_desc"))

	local var_8_10 = arg_8_0.showTechVO
	local var_8_11 = var_2.GetFormulaId(var_8_10)

	math = var_8_1

	local var_8_12 = var_8_1.floor

	pg = var_5

	local var_8_13 = var_8_12(var_5.island_formula[var_8_11].workload / arg_8_0.baseEffectSpeed)

	setText = var_8_10

	local var_8_14 = arg_8_0.normalTimeTextTF
	local var_8_15 = arg_8_0.timeMgr

	var_8_10(var_8_14, var_7.DescCDTime(var_8_15, var_8_13))

	Clone = var_8_10

	local var_8_16 = arg_8_0.showTechVO

	arg_8_0.unlockCondList = var_8_10(var_6.getConfig(var_8_16, "sys_unlock"))

	local var_8_17 = arg_8_0.showTechVO

	if var_4.getConfig(var_8_17, "island_level") ~= 0 then
		table = var_5

		var_5.insert(arg_8_0.unlockCondList, 1, {
			0,
			var_4
		})
	end

	local var_8_18 = arg_8_0.unlockUIList

	var_5.align(var_8_18, #arg_8_0.unlockCondList)

	local var_8_19 = arg_8_0.showTechVO
	local var_8_20 = var_5.GetStatus(var_8_19)

	pairs = var_8_17

	for iter_8_0, iter_8_1 in var_8_17(arg_8_0.statusTFs) do
		setActive = var_1_10011

		var_1_10011(iter_8_1, iter_8_0 == var_8_20)
	end

	IslandTechnology = var_6

	local var_8_21

	if var_8_20 ~= var_6.STATUS.LOCK then
		IslandTechnology = var_6

		if var_8_20 ~= var_6.STATUS.UNLOCK then
			var_8_21 = false

			goto label_8_0
		end
	end

	var_8_21 = true

	::label_8_0::

	setActive = var_7

	var_7(arg_8_0.unlockTF, var_8_21)

	setActive = var_7

	var_7(arg_8_0.descPanel, not var_8_21)

	local var_8_22 = arg_8_0.showTechVO

	arg_8_0.costList = var_7.GetCostItems(var_8_22)

	local var_8_23 = arg_8_0.costUIList

	var_7.align(var_8_23, #arg_8_0.costList)

	setText = var_7

	local var_8_24 = arg_8_0._tf
	local var_8_25 = var_9.Find(var_8_24, "panel/desc/name")
	local var_8_26 = arg_8_0.showTechVO

	var_7(var_8_25, var_10.getConfig(var_8_26, "complete_title"))

	switch = var_7

	local var_8_27 = var_8_20
	local var_8_28 = {}

	IslandTechnology = var_8_24
	var_8_28[var_8_24.STATUS.LOCK] = function()
		onButton = var_2_10000

		local var_9_0 = arg_8_0
		local var_9_1 = arg_8_0.statusTFs[var_8_20]

		local function var_9_2()
			pg = var_3_10000

			local var_10_0 = var_3_10000.TipsMgr.GetInstance()
			local var_10_1 = var_0.ShowTips

			i18n = var_3_10003

			var_10_1(var_10_0, var_3_10003("island_tech_unlock_tip"))

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10000(var_9_0, var_9_1, var_9_2, var_2_10005)

		return
	end
	IslandTechnology = var_11
	var_8_28[var_11.STATUS.UNLOCK] = function()
		onButton = var_2_10000

		local var_11_0 = arg_8_0
		local var_11_1 = arg_8_0.statusTFs[var_8_20]

		local function var_11_2()
			local var_12_0 = arg_8_0
			local var_12_1 = var_0.emit

			IslandMediator = var_3_10003

			var_12_1(var_12_0, var_3_10003.ON_UNLOCK_TECH, arg_8_0.showTechVO.id)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10000(var_11_0, var_11_1, var_11_2, var_2_10005)

		return
	end
	IslandTechnology = var_11
	var_8_28[var_11.STATUS.NORMAL] = function()
		setGray = var_2_10000

		local var_13_0 = arg_8_0.statusTFs[var_8_20]
		local var_13_1 = arg_8_0

		var_2_10000(var_13_0, not var_3.CheckCost(var_13_1), false)

		onButton = var_2_10000

		local var_13_2 = arg_8_0
		local var_13_3 = arg_8_0.statusTFs[var_8_20]

		local function var_13_4()
			local var_14_0 = arg_8_0

			if not var_0.CheckCost(var_14_0) then
				pg = var_0

				local var_14_1 = var_0.TipsMgr.GetInstance()
				local var_14_2 = var_0.ShowTips

				i18n = var_3_10003

				var_14_2(var_14_1, var_3_10003("island_production_cost_notenough"))

				return
			end

			local var_14_3 = arg_8_0.techAgency

			if not var_0.GetEmptySlotId(var_14_3) then
				pg = var_3_10001

				local var_14_4 = var_3_10001.TipsMgr.GetInstance()
				local var_14_5 = var_1.ShowTips

				i18n = var_3_10004

				var_14_5(var_14_4, var_3_10004("island_tech_no_slot"))

				return
			end

			local var_14_6 = arg_8_0.showTechVO

			if var_1.IsAutoType(var_14_6) then
				existCall = var_1

				var_1(arg_8_0.contextData.onFinishImmd, arg_8_0.showTechVO.id)
			else
				existCall = var_1

				local var_14_7 = arg_8_0.contextData.onSelecteShip
				local var_14_8 = arg_8_0.showTechVO

				var_1(var_14_7, var_4.GetFormulaId(var_14_8))
			end

			return
		end

		SFX_PANEL = var_13_1

		var_2_10000(var_13_2, var_13_3, var_13_4, var_13_1)

		return
	end
	IslandTechnology = var_11
	var_8_28[var_11.STATUS.STUDYING] = function()
		onButton = var_2_10000

		local var_15_0 = arg_8_0
		local var_15_1 = arg_8_0.statusTFs[var_8_20]
		local var_15_2 = var_3.Find(var_15_1, "ticket")

		local function var_15_3()
			existCall = var_3_10000

			local var_16_0 = arg_8_0.contextData.openTicketPage
			local var_16_1 = arg_8_0.showTechVO

			var_3_10000(var_16_0, var_3.GetSlotId(var_16_1))

			return
		end

		SFX_PANEL = var_15_1

		var_2_10000(var_15_0, var_15_2, var_15_3, var_15_1)

		return
	end
	IslandTechnology = var_11
	var_8_28[var_11.STATUS.RECEIVE] = function()
		onButton = var_2_10000

		local var_17_0 = arg_8_0
		local var_17_1 = arg_8_0.statusTFs[var_8_20]

		local function var_17_2()
			local var_18_0 = arg_8_0
			local var_18_1 = var_0.emit

			IslandMediator = var_3_10003

			local var_18_2 = var_3_10003.GET_DELEGATION_AWARD
			local var_18_3 = arg_8_0.placeId
			local var_18_4 = arg_8_0.showTechVO

			var_18_1(var_18_0, var_18_2, var_18_3, var_5.GetSlotId(var_18_4), 2, function()
				existCall = var_4_10000

				var_4_10000(arg_8_0.contextData.onGetAwardDone, arg_8_0.showTechVO.id)

				return
			end)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10000(var_17_0, var_17_1, var_17_2, var_2_10005)

		return
	end
	IslandTechnology = var_11
	var_8_28[var_11.STATUS.FINISHED] = function()
		local var_20_0 = arg_8_0.showTechVO

		if var_0.getConfig(var_20_0, "complete_map_id") == 0 then
			setActive = var_2_10001

			var_2_10001(arg_8_0.noramlFinsh, true)

			setActive = var_2_10001

			var_2_10001(arg_8_0.mapFinsh, false)

			return
		end

		setActive = var_2_10001

		var_2_10001(arg_8_0.noramlFinsh, false)

		setActive = var_2_10001

		var_2_10001(arg_8_0.mapFinsh, true)

		local var_20_1 = var_0

		LoadImageSpriteAtlasAsync = var_20_0

		var_20_0("island/IslandMapIcon/" .. var_20_1, "", arg_8_0.mapFinshIcon)

		setText = var_20_0

		local var_20_2 = arg_8_0.mapFinshName

		pg = var_5

		var_20_0(var_20_2, var_5.island_map[var_20_1].name)

		local var_20_3 = arg_8_0.showTechVO

		if var_2.getConfig(var_20_3, "complete_character_id") == "" or #var_2 == 0 then
			setActive = var_3

			var_3(arg_8_0.npcTF, false)

			return
		end

		setActive = var_3

		var_3(arg_8_0.npcTF, true)

		pg = var_3

		local var_20_4 = var_3.island_unit_character[var_2[1]]

		GetImageSpriteFromAtlasAsync = var_4

		var_4("island/IslandShipIcon/" .. var_20_4.IslandShipIcon, "", arg_8_0.npcIcon)

		setText = var_4

		var_4(arg_8_0.npcName, var_20_4.name)

		return
	end

	var_7(var_8_27, var_8_28, function()
		return
	end)
	arg_8_0:StartTimer()
	arg_8_0:UpdateTime()

	setActive = var_7

	var_7(arg_8_0.selectedTF, arg_8_0.selectedItemPos)

	if arg_8_0.selectedItemPos then
		arg_8_0:FlushSelectedItem()
	end

	return
end

function var_0_1.CheckCost(arg_22_0)
	underscore = var_1_10001

	local var_22_0 = var_1_10001.all
	local var_22_1

	if not arg_22_0.costList then
		var_22_1 = {}
	end

	return var_22_0(var_22_1, function(arg_23_0)
		local var_23_0 = arg_22_0.inventoryAgency

		return var_1.GetOwnCount(var_23_0, arg_23_0.id) >= arg_23_0.count
	end)
end

function var_0_1.FlushSelectedItem(arg_24_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_24_0.selectedTF, arg_24_0.selectedItemPos)

	setActive = var_1_10001

	local var_24_0 = arg_24_0.selectedTF

	var_1_10001(var_3.Find(var_24_0, "selected"), true)

	arg_24_0.selectedTF.name = arg_24_0.configId

	local var_24_1 = arg_24_0.techAgency
	local var_24_2 = var_1.GetTechnology(var_24_1, arg_24_0.configId)

	IslandTechTreePanel = var_2

	local var_24_3 = var_2.SetTechName
	local var_24_4 = arg_24_0.selectedTF
	local var_24_5 = var_4.Find(var_24_4, "name")
	local var_24_6 = var_24_2

	var_24_3(var_24_5, var_24_2.getConfig(var_24_6, "tech_name"))

	local var_24_7 = var_24_2
	local var_24_8 = var_24_2.GetStatus(var_24_7)

	IslandTechnology = var_24_1

	local var_24_9 = var_24_8 == var_24_1.STATUS.FINISHED

	setTextColor = var_24_7

	local var_24_10 = arg_24_0.selectedTF
	local var_24_11 = var_6.Find(var_24_10, "name/Text")

	Color = var_24_6

	var_24_7(var_24_11, var_24_6.NewHex(var_24_9 and "1b3650" or "ffffff"))

	setTextColor = var_24_7

	local var_24_12 = arg_24_0.selectedTF
	local var_24_13 = var_6.Find(var_24_12, "name/ScrollText")

	Color = var_7

	var_24_7(var_24_13, var_7.NewHex(var_24_9 and "1b3650" or "ffffff"))

	LoadImageSpriteAsync = var_24_7

	local var_24_14 = "island/IslandTechnology/" .. var_24_2:getConfig("tech_icon")
	local var_24_15 = arg_24_0.selectedTF

	var_24_7(var_24_14, var_7.Find(var_24_15, "icon"), true)

	setActive = var_24_7

	local var_24_16 = arg_24_0.selectedTF
	local var_24_17 = var_6.Find(var_24_16, "icon")

	IslandTechnology = var_7

	if var_24_8 ~= var_7.STATUS.STUDYING then
		IslandTechnology = var_7

		local var_24_18

		if var_24_8 == var_7.STATUS.RECEIVE then
			var_24_18 = false
		else
			var_24_18 = true
		end

		var_24_7(var_24_17, var_24_18)

		setImageColor = var_24_7

		local var_24_19 = arg_24_0.selectedTF
		local var_24_20 = var_6.Find(var_24_19, "icon")

		Color = var_24_18

		var_24_7(var_24_20, var_24_18.NewHex(var_24_9 and "455a81" or "ffffff"))

		eachChild = var_24_7

		local var_24_21 = arg_24_0.selectedTF

		var_24_7(var_6.Find(var_24_21, "back"), function(arg_25_0)
			setActive = var_2_10001

			var_2_10001(arg_25_0, arg_25_0.name == var_24_8)

			return
		end)

		setActive = var_24_7

		local var_24_22 = arg_24_0.selectedTF
		local var_24_23 = var_6.Find(var_24_22, "back/normal")

		if not var_24_9 then
			IslandTechnology = var_7

			local var_24_24

			if var_24_8 == var_7.STATUS.STUDYING then
				var_24_24 = false
			else
				var_24_24 = true
			end

			var_24_7(var_24_23, var_24_24)

			eachChild = var_24_7

			local var_24_25 = arg_24_0.selectedTF

			var_24_7(var_6.Find(var_24_25, "front"), function(arg_26_0)
				setActive = var_2_10001

				var_2_10001(arg_26_0, arg_26_0.name == var_24_8)

				return
			end)

			return
		end
	end
end

function var_0_1.Show(arg_27_0, arg_27_1, arg_27_2)
	var_0_1.super.Show(arg_27_0)

	arg_27_0.configId = arg_27_1
	pg = var_3
	arg_27_0.timeMgr = var_3.TimeMgr.GetInstance()
	arg_27_0.selectedItemPos = arg_27_2

	arg_27_0:Flush()
	arg_27_0:OverlayPanel(arg_27_0._tf)

	return
end

function var_0_1.OnShipSelected(arg_28_0, arg_28_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_28_0 = var_1_10002(var_1_10004)
	local var_28_1 = var_2.GetIsland(var_28_0)
	local var_28_2 = var_2.GetCharacterAgency(var_28_1)
	local var_28_3 = var_3.GetShipById(var_28_2, arg_28_1)
	local var_28_4 = arg_28_0.showTechVO
	local var_28_5 = var_5.GetFormulaId(var_28_4)

	pg = var_28_2

	local var_28_6 = var_28_2.island_formula[var_28_5]

	math = var_28_4

	local var_28_7 = var_28_4.floor
	local var_28_8 = var_28_6.stamina_cost

	IslandProductCostHelper = var_1_10010

	local var_28_9 = var_28_7(var_28_8 * (1 - var_1_10010.GetReducePercentInPlace(arg_28_1, arg_28_0.placeId)))

	math = var_1_10008

	local var_28_10 = var_1_10008.max(var_28_9, 1)

	if var_28_3:GetCurrentEnergy() < var_28_10 then
		pg = var_8

		local var_28_11 = var_8.TipsMgr.GetInstance()
		local var_28_12 = var_8.ShowTips

		i18n = var_11

		var_28_12(var_28_11, var_11("island_production_cost_notenough"))

		return
	end

	local var_28_13 = arg_28_0.techAgency
	local var_28_14 = var_8.GetEmptySlotId(var_28_13)
	local var_28_15 = arg_28_0.showTechVO
	local var_28_16 = var_9.GetFormulaId(var_28_15)
	local var_28_17 = arg_28_0
	local var_28_18 = arg_28_0.emit

	IslandMediator = var_13

	var_28_18(var_28_17, var_13.START_DELEGATION, arg_28_0.placeId, var_28_14, arg_28_1, var_28_16, 1)

	return
end

function var_0_1.UpdateTime(arg_29_0)
	local var_29_0 = arg_29_0.showTechVO
	local var_29_1 = var_1.GetStatus(var_29_0)
	local var_29_2 = arg_29_0.buildingAgency

	if var_2.GetDelegationSlotDataByTechId(var_29_2, arg_29_0.showTechVO.id) then
		if var_2:GetSlotRewardData() then
			setText = var_29_2

			var_29_2(arg_29_0.timeTextTF, "00:00:00")

			goto label_29_0
		end

		local var_29_3 = var_2:GetSlotRoleData()
		local var_29_4 = var_4.GetFinishTime(var_29_3)
		local var_29_5 = arg_29_0.timeMgr
		local var_29_6 = var_29_4 - var_6.GetServerTime(var_29_5)

		setText = var_6

		local var_29_7 = arg_29_0.timeTextTF

		if var_29_6 > 0 then
			do
				local var_29_8 = arg_29_0.timeMgr
				local var_29_9

				if not var_9.DescCDTime(var_29_8, var_29_6) then
					var_29_9 = "00:00:00"
				end

				var_6(var_29_7, var_29_9)

				if false then
					setText = var_29_0

					var_29_0(arg_29_0.timeTextTF, "??:??:??")
				end
			end

			::label_29_0::

			return
		end
	end
end

function var_0_1.StartTimer(arg_30_0)
	Timer = var_1_10001
	arg_30_0.timer = var_1_10001.New(function()
		local var_31_0 = arg_30_0

		var_0.UpdateTime(var_31_0)

		return
	end, 1, -1)

	local var_30_0 = arg_30_0.timer

	var_1.Start(var_30_0)

	return
end

function var_0_1.StopTimer(arg_32_0)
	if arg_32_0.timer ~= nil then
		local var_32_0 = arg_32_0.timer

		var_1.Stop(var_32_0)

		arg_32_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_33_0)
	arg_33_0:StopTimer()
	arg_33_0:UnOverlayPanel(arg_33_0._tf, arg_33_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_34_0)
	arg_34_0:StopTimer()
	arg_34_0:UnOverlayPanel(arg_34_0._tf, arg_34_0._parentTf)

	return
end

return var_0_1
