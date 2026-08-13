class = var_0_10000

local var_0_0 = "ResolveEquipmentLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2 = "resolve_equipment_option_all"
local var_0_3 = {
	SR = "SR",
	SSR = "SSR",
	ALL = "ALL",
	R = "R",
	N = "N"
}
local var_0_4 = {
	N = "N",
	SR = "SR",
	SSR = "SSR",
	R = "R"
}
local var_0_5 = {
	[var_0_3.N] = {
		1,
		2
	},
	[var_0_3.R] = {
		3
	},
	[var_0_3.SR] = {
		4
	},
	[var_0_3.SSR] = {
		5
	},
	[var_0_3.ALL] = {
		1,
		2,
		3,
		4,
		5
	}
}
local var_0_6 = {
	ALL = 3,
	PART = 2,
	NONE = 1,
	GREY = 0
}

function var_0_1.getUIName(arg_1_0)
	return "ResolveEquipmentUI"
end

function var_0_1.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_1.setEquipments(arg_3_0, arg_3_1)
	arg_3_0.equipmentVOs = arg_3_1

	arg_3_0:setEquipmentByIds(arg_3_1)

	return
end

function var_0_1.setEquipmentByIds(arg_4_0, arg_4_1)
	arg_4_0.equipmentVOByIds = {}
	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_1) do
		arg_4_0.equipmentVOByIds[iter_4_1.id] = iter_4_1
	end

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.mainPanel = var_1.Find(var_5_0, "main")
	setActive = var_1

	var_1(arg_5_0.mainPanel, true)

	setText = var_1

	local var_5_1 = arg_5_0.mainPanel
	local var_5_2 = var_3.Find(var_5_1, "top/title_list/infomation/title")

	i18n = var_4

	var_1(var_5_2, var_4("title_info"))

	setText = var_1

	local var_5_3 = arg_5_0.mainPanel
	local var_5_4 = var_3.Find(var_5_3, "title/Text")

	i18n = var_4

	var_1(var_5_4, var_4("resolve_equip_tip"))

	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_1.Find(var_5_5, "main/frame/view")

	arg_5_0.viewRect = var_1.GetComponent(var_5_6, "LScrollRect")

	local var_5_7 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_7, "main/top/btnBack")

	local var_5_8 = arg_5_0._tf

	arg_5_0.cancelBtn = var_1.Find(var_5_8, "main/cancel_btn")
	setText = var_1

	local var_5_9 = arg_5_0.cancelBtn
	local var_5_10 = var_3.Find(var_5_9, "Image")

	i18n = var_4

	var_1(var_5_10, var_4("text_cancel"))

	local var_5_11 = arg_5_0._tf

	arg_5_0.okBtn = var_1.Find(var_5_11, "main/ok_btn")
	setText = var_1

	local var_5_12 = arg_5_0.okBtn
	local var_5_13 = var_3.Find(var_5_12, "Image")

	i18n = var_4

	var_1(var_5_13, var_4("text_confirm"))

	pg = var_1

	local var_5_14 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_14, arg_5_0._tf)

	arg_5_0.selectedIds = {}

	local var_5_15 = arg_5_0._tf

	arg_5_0.selectOptions = var_1.Find(var_5_15, "main/options")
	setText = var_1

	local var_5_16 = arg_5_0.selectOptions
	local var_5_17 = var_3.Find(var_5_16, "ALL/Label")

	i18n = var_4

	var_1(var_5_17, var_4("word_equipment_all"))

	arg_5_0.optionStatus = {}

	local var_5_18 = arg_5_0._tf

	arg_5_0.destroyConfirm = var_1.Find(var_5_18, "destroy_confirm")

	local var_5_19 = arg_5_0.destroyConfirm

	arg_5_0.destroyBonusList = var_1.Find(var_5_19, "got/scrollview/list")

	local var_5_20 = arg_5_0.destroyConfirm

	arg_5_0.destroyBonusItem = var_1.Find(var_5_20, "got/scrollview/item")
	setActive = var_1

	var_1(arg_5_0.destroyConfirm, false)

	setActive = var_1

	var_1(arg_5_0.destroyBonusItem, false)

	setText = var_1

	local var_5_21 = arg_5_0.destroyConfirm
	local var_5_22 = var_3.Find(var_5_21, "got/title")

	i18n = var_4

	var_1(var_5_22, var_4("resolve_equip_title"))

	setText = var_1

	local var_5_23 = arg_5_0.destroyConfirm
	local var_5_24 = var_3.Find(var_5_23, "actions/cancel_button/Image")

	i18n = var_4

	var_1(var_5_24, var_4("text_cancel"))

	setText = var_1

	local var_5_25 = arg_5_0.destroyConfirm
	local var_5_26 = var_3.Find(var_5_25, "actions/destroy_button/Image")

	i18n = var_4

	var_1(var_5_26, var_4("text_confirm"))

	EquipDestoryConfirmWindow = var_1
	arg_5_0.equipDestroyConfirmWindow = var_1.New(arg_5_0._tf, arg_5_0.event)

	return
end

function var_0_1.didEnter(arg_6_0)
	arg_6_0:initEquipments()

	onButton = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.backBtn

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.SureExit(var_7_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.cancelBtn

	local function var_6_5()
		local var_8_0 = arg_6_0

		var_0.SureExit(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.okBtn

	local function var_6_8()
		local var_9_0 = {}

		underscore = var_2_10001

		if var_2_10001.any(arg_6_0.selectedIds, function(arg_10_0)
			local var_10_0 = arg_6_0.equipmentVOByIds[arg_10_0[1]]

			return var_1.getConfig(var_10_0, "rarity") >= 4 or var_1:getConfig("level") > 1
		end) then
			table = var_1

			var_1.insert(var_9_0, function(arg_11_0)
				local var_11_0 = arg_6_0.equipDestroyConfirmWindow

				var_1.Load(var_11_0)

				local var_11_1 = arg_6_0.equipDestroyConfirmWindow
				local var_11_2 = var_1.ActionInvoke
				local var_11_3 = "Show"

				underscore = var_3_10005

				var_11_2(var_11_1, var_11_3, var_3_10005.map(arg_6_0.selectedIds, function(arg_12_0)
					setmetatable = var_4_10001

					return var_4_10001({
						count = arg_12_0[2]
					}, {
						__index = arg_6_0.equipmentVOByIds[arg_12_0[1]]
					})
				end), arg_11_0)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_9_0, function()
			local var_13_1

			if #arg_6_0.selectedIds <= 0 then
				pg = var_13_1

				local var_13_0 = var_13_1.TipsMgr.GetInstance()

				var_13_1 = var_13_1.ShowTips
				i18n = var_3_10003

				var_13_1(var_13_0, var_3_10003("err_resloveequip_nochoice"))

				return
			end

			setActive = var_13_1

			var_13_1(arg_6_0.mainPanel, false)

			setActive = var_13_1

			var_13_1(arg_6_0.destroyConfirm, true)

			local var_13_2 = arg_6_0

			var_0.displayDestroyBonus(var_13_2)

			return
		end)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1

	local var_6_9 = arg_6_0

	findTF = var_6_7

	local var_6_10 = var_6_7(arg_6_0.destroyConfirm, "actions/cancel_button")

	local function var_6_11()
		setActive = var_2_10000

		var_2_10000(arg_6_0.destroyConfirm, false)

		setActive = var_2_10000

		var_2_10000(arg_6_0.mainPanel, true)

		pg = var_2_10000

		local var_14_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_14_0, arg_6_0.destroyConfirm, arg_6_0._tf)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_6_9, var_6_10, var_6_11, var_6)

	onButton = var_1

	local var_6_12 = arg_6_0

	findTF = var_6_10

	local var_6_13 = var_6_10(arg_6_0.destroyConfirm, "actions/destroy_button")

	local function var_6_14()
		local var_15_0 = {}

		seriesAsync = var_2_10001

		var_2_10001(var_15_0, function()
			local var_16_0 = arg_6_0
			local var_16_1 = var_0.emit

			ResolveEquipmentMediator = var_3_10003

			var_16_1(var_16_0, var_3_10003.ON_RESOLVE, arg_6_0.selectedIds)

			return
		end)

		return
	end

	SFX_UI_EQUIPMENT_RESOLVE = var_6

	var_1(var_6_12, var_6_13, var_6_14, var_6)

	eachChild = var_1

	var_1(arg_6_0.selectOptions, function(arg_17_0)
		onButton = var_2_10001

		local var_17_0 = arg_6_0
		local var_17_1 = arg_17_0

		local function var_17_2()
			local var_18_0 = arg_17_0.name
			local var_18_1 = arg_6_0.optionStatus[var_18_0]
			local var_18_2 = var_0_5[var_18_0]

			switch = var_3_10003

			var_3_10003(var_18_1, {
				[var_0_6.GREY] = function()
					return
				end,
				[var_0_6.NONE] = function()
					local var_20_0 = arg_6_0

					var_0.selAllEquipsByRaritys(var_20_0, var_18_2)

					return
				end,
				[var_0_6.PART] = function()
					local var_21_0 = arg_6_0

					var_0.unselAllEquipsByRaritys(var_21_0, var_18_2)

					return
				end,
				[var_0_6.ALL] = function()
					local var_22_0 = arg_6_0

					var_0.unselAllEquipsByRaritys(var_22_0, var_18_2)

					return
				end
			})

			return
		end

		SFX_CANCEL = var_2_10006

		var_2_10001(var_17_0, var_17_1, var_17_2, var_2_10006)

		return
	end)

	return
end

function var_0_1.HideDestroyCondirm(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.destroyConfirm, false)

	return
end

function var_0_1.OnResolveEquipDone(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(var_0_4) do
		if arg_24_0.optionStatus[iter_24_1] == var_0_6.ALL then
			arg_24_0:SetLocalDataByOption(iter_24_1, 1)
		elseif var_6 == var_0_6.NONE then
			arg_24_0:SetLocalDataByOption(iter_24_1, 0)
		end
	end

	if arg_24_0.optionStatus[var_0_3.ALL] == var_0_6.ALL then
		arg_24_0:emit(var_0_1.ON_CLOSE)
	else
		setActive = var_1

		var_1(arg_24_0.mainPanel, true)

		local function var_24_0(arg_25_0)
			ipairs = var_2_10001

			for iter_25_0, iter_25_1 in var_2_10001(arg_24_0.selectedIds) do
				if iter_25_1[1] == arg_25_0 then
					return iter_25_1[2]
				end
			end

			return 0
		end

		local var_24_1 = {}

		ipairs = var_3

		for iter_24_2, iter_24_3 in var_3(arg_24_0.equipmentVOs) do
			Clone = var_1_10008
			var_1_10008 = var_1_10008(iter_24_3)

			local var_24_2 = iter_24_3.count - var_24_0(iter_24_3.id)

			if 0 < var_24_2 then
				var_1_10008.count = var_24_2
				table = var_10

				var_10.insert(var_24_1, var_1_10008)
			end
		end

		arg_24_0:setEquipments(var_24_1)

		local var_24_3 = arg_24_0.viewRect

		var_3.SetTotalCount(var_24_3, #arg_24_0.equipmentVOs, -1)
		arg_24_0:selectedLocalRecordEquipment()
	end

	return
end

function var_0_1.onBackPressed(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.CriMgr.GetInstance()
	local var_26_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_26_1(var_26_0, var_1_10004)

	isActive = var_26_1

	if var_26_1(arg_26_0.destroyConfirm) then
		triggerButton = var_1
		findTF = var_3

		var_1(var_3(arg_26_0.destroyConfirm, "actions/cancel_button"))
	else
		local var_26_2 = arg_26_0.equipDestroyConfirmWindow

		if var_1.isShowing(var_26_2) then
			local var_26_3 = arg_26_0.equipDestroyConfirmWindow

			var_1.Hide(var_26_3)
		else
			triggerButton = var_1

			var_1(arg_26_0.cancelBtn)
		end
	end

	return
end

function var_0_1.selectedLocalRecordEquipment(arg_27_0)
	arg_27_0.selectedIds = {}
	pairs = var_1

	for iter_27_0, iter_27_1 in var_1(var_0_4) do
		if arg_27_0:GetLocalDataByOption(iter_27_1) == 1 then
			local var_27_0 = var_0_5[iter_27_1]

			arg_27_0:selAllEquipsByRaritys(var_27_0)
		end
	end

	arg_27_0:updateSelected()

	return
end

function var_0_1.GetLocalDataByOption(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.player.id .. var_0_2 .. arg_28_1

	if arg_28_1 == var_0_3.N or arg_28_1 == var_0_3.R then
		PlayerPrefs = var_3

		if not var_3.HasKey(var_28_0) then
			arg_28_0:SetLocalDataByOption(arg_28_1, 1)
		end
	end

	PlayerPrefs = var_3

	return var_3.GetInt(arg_28_0.player.id .. var_0_2 .. arg_28_1, 0)
end

function var_0_1.SetLocalDataByOption(arg_29_0, arg_29_1, arg_29_2)
	PlayerPrefs = var_1_10003

	var_1_10003.SetInt(arg_29_0.player.id .. var_0_2 .. arg_29_1, arg_29_2)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.selAllEquipsByRaritys(arg_30_0, arg_30_1)
	ipairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0.equipmentVOs) do
		local var_30_0 = iter_30_1:getConfig("rarity")

		table = var_1_10008

		if var_1_10008.contains(arg_30_1, var_30_0) then
			arg_30_0:selectEquip(iter_30_1, iter_30_1.count)
		end
	end

	arg_30_0:updateSelected()

	return
end

function var_0_1.unselAllEquipsByRaritys(arg_31_0, arg_31_1)
	underscore = var_1_10002
	arg_31_0.selectedIds = var_1_10002.select(arg_31_0.selectedIds, function(arg_32_0)
		local var_32_0 = arg_31_0.equipmentVOByIds[arg_32_0[1]]
		local var_32_1 = var_1.getConfig(var_32_0, "rarity")

		table = var_2

		return not var_2.contains(arg_31_1, var_32_1)
	end)

	arg_31_0:updateSelected()

	return
end

function var_0_1.displayDestroyBonus(arg_33_0)
	local var_33_0 = {}
	local var_33_1 = 0

	ipairs = var_1_10003

	for iter_33_0, iter_33_1 in var_1_10003(arg_33_0.selectedIds) do
		Equipment = var_1_10008

		if var_1_10008.CanInBag(iter_33_1[1]) then
			Equipment = var_1_10008

			local var_33_2

			if not var_1_10008.getConfigData(iter_33_1[1]).destory_item then
				var_33_2 = {}
			end

			local var_33_3

			if not var_1_10008.destory_gold then
				var_33_3 = 0
			end

			var_33_1 = var_33_1 + var_33_3 * iter_33_1[2]
			ipairs = var_11

			for iter_33_2, iter_33_3 in var_11(var_33_2) do
				local var_33_4 = false

				ipairs = var_1_10017

				for iter_33_4, iter_33_5 in var_1_10017(var_33_0) do
					if iter_33_3[1] == var_33_0[iter_33_4].id then
						var_33_0[iter_33_4].count = var_33_0[iter_33_4].count + iter_33_3[2] * iter_33_1[2]
						var_33_4 = true

						break
					end
				end

				if not var_33_4 then
					table = var_1_10017
					var_1_10017 = var_1_10017.insert

					local var_33_5 = var_33_0
					local var_33_6 = {}

					DROP_TYPE_ITEM = iter_33_5
					var_33_6.type = iter_33_5
					var_33_6.id = iter_33_3[1]
					var_33_6.count = iter_33_3[2] * iter_33_1[2]

					var_1_10017(var_33_5, var_33_6)
				end
			end
		end
	end

	if 0 < var_33_1 then
		table = var_3

		local var_33_7 = var_3.insert
		local var_33_8 = var_33_0
		local var_33_9 = {
			id = 1
		}

		DROP_TYPE_RESOURCE = iter_33_1
		var_33_9.type = iter_33_1
		var_33_9.count = var_33_1

		var_33_7(var_33_8, var_33_9)
	end

	for iter_33_6 = #var_33_0, arg_33_0.destroyBonusList.childCount - 1 do
		Destroy = iter_33_1

		local var_33_10 = arg_33_0.destroyBonusList

		iter_33_1(var_9.GetChild(var_33_10, iter_33_6))
	end

	for iter_33_7 = arg_33_0.destroyBonusList.childCount, #var_33_0 - 1 do
		cloneTplTo = iter_33_1

		iter_33_1(arg_33_0.destroyBonusItem, arg_33_0.destroyBonusList)
	end

	for iter_33_8 = 1, #var_33_0 do
		local var_33_11 = arg_33_0.destroyBonusList
		local var_33_12 = var_7.GetChild(var_33_11, iter_33_8 - 1)
		local var_33_13 = var_33_0[iter_33_8].type

		DROP_TYPE_SHIP = var_10

		if var_33_13 == var_10 then
			arg_33_0.hasShip = true
		end

		local var_33_14 = var_33_12:Find("icon_bg/icon/icon")

		GetComponent = var_10

		local var_33_15 = var_33_12:Find("icon_bg/icon")

		typeof = var_1_10013
		Image = var_15
		var_10(var_33_15, var_1_10013(var_15)).enabled = true
		IsNil = var_11

		if not var_11(var_33_14) then
			setActive = var_11

			var_11(var_33_14, false)
		end

		updateDrop = var_11

		var_11(var_33_12, var_8)

		contentWrap = var_11

		local var_33_16, var_33_17 = var_11(var_8:getConfig("name"), 10, 2)

		if var_33_16 then
			var_33_17 = var_33_17 .. "..."
		end

		setText = var_1_10013

		var_1_10013(var_33_12:Find("name"), var_33_17)

		onButton = var_1_10013

		local var_33_18 = arg_33_0
		local var_33_19 = var_33_12

		local function var_33_20()
			local var_34_0 = var_0.type

			DROP_TYPE_RESOURCE = var_2_10001

			if var_34_0 ~= var_2_10001 then
				local var_34_1 = var_0.type

				DROP_TYPE_ITEM = var_2_10001

				if var_34_1 == var_2_10001 then
					local var_34_2 = arg_33_0
					local var_34_3 = var_0.emit
					local var_34_4 = var_0_1.ON_ITEM
					local var_34_5 = var_0

					var_34_3(var_34_2, var_34_4, var_4.getConfig(var_34_5, "id"))
				else
					local var_34_6 = var_0.type

					DROP_TYPE_EQUIP = var_2_10001

					if var_34_6 == var_2_10001 then
						local var_34_7 = arg_33_0
						local var_34_8 = var_0.emit
						local var_34_9 = var_0_1.ON_EQUIPMENT
						local var_34_10 = {}
						local var_34_11 = var_0

						var_34_10.equipmentId = var_5.getConfig(var_34_11, "id")
						EquipmentInfoMediator = var_5
						var_34_10.type = var_5.TYPE_DISPLAY

						var_34_8(var_34_7, var_34_9, var_34_10)
					end
				end

				return
			end
		end

		SFX_PANEL = var_18

		var_1_10013(var_33_18, var_33_19, var_33_20, var_18)
	end

	return
end

function var_0_1.initEquipments(arg_35_0)
	function arg_35_0.viewRect.onInitItem(arg_36_0)
		local var_36_0 = arg_35_0

		var_1.onInitItem(var_36_0, arg_36_0)

		return
	end

	function arg_35_0.viewRect.onUpdateItem(arg_37_0, arg_37_1)
		local var_37_0 = arg_35_0

		var_2.onUpdateItem(var_37_0, arg_37_0, arg_37_1)

		return
	end

	function arg_35_0.viewRect.onStart()
		local var_38_0 = arg_35_0

		var_0.selectedLocalRecordEquipment(var_38_0)

		return
	end

	arg_35_0.cards = {}

	arg_35_0:filterEquipments()

	return
end

function var_0_1.filterEquipments(arg_39_0)
	underscore = var_1_10001

	local var_39_0 = var_1_10001.select(arg_39_0.equipmentVOs, function(arg_40_0)
		return not arg_40_0:isImportance()
	end)

	arg_39_0:setEquipments(var_39_0)

	table = var_2

	local var_39_1 = var_2.sort
	local var_39_2 = arg_39_0.equipmentVOs

	CompareFuncs = var_5

	var_39_1(var_39_2, var_5({
		function(arg_41_0)
			return -arg_41_0:getConfig("rarity")
		end,
		function(arg_42_0)
			return arg_42_0.id
		end
	}))

	local var_39_3 = arg_39_0.viewRect

	var_2.SetTotalCount(var_39_3, #arg_39_0.equipmentVOs, -1)

	return
end

function var_0_1.onInitItem(arg_43_0, arg_43_1)
	EquipmentItem = var_1_10002

	local var_43_0 = var_1_10002.New(arg_43_1)

	onButton = var_1_10003

	local var_43_1 = arg_43_0
	local var_43_2 = var_43_0.go

	local function var_43_3()
		local var_44_0 = arg_43_0

		var_0.selectEquip(var_44_0, var_43_0.equipmentVO, var_43_0.equipmentVO.count)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_43_1, var_43_2, var_43_3, var_1_10008)

	onButton = var_1_10003

	local var_43_4 = arg_43_0
	local var_43_5 = var_43_0.reduceBtn

	local function var_43_6()
		local var_45_0 = arg_43_0

		var_0.selectEquip(var_45_0, var_43_0.equipmentVO, 1)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_43_4, var_43_5, var_43_6, var_1_10008)

	arg_43_0.cards[arg_43_1] = var_43_0

	return
end

function var_0_1.onUpdateItem(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0

	if not arg_46_0.cards[arg_46_2] then
		arg_46_0:onInitItem(arg_46_2)

		var_46_0 = arg_46_0.cards[arg_46_2]
	end

	local var_46_1 = arg_46_0.equipmentVOs[arg_46_1 + 1]
	local var_46_2 = var_46_0

	var_46_0.update(var_46_2, var_46_1, true)

	local var_46_3 = false
	local var_46_4 = 0

	pairs = var_46_2

	for iter_46_0, iter_46_1 in var_46_2(arg_46_0.selectedIds) do
		if var_46_0.equipmentVO.id == iter_46_1[1] then
			var_46_3 = true
			var_46_4 = iter_46_1[2]

			break
		end
	end

	var_46_0:updateSelected(var_46_3, var_46_4)

	return
end

function var_0_1.isSelectedAll(arg_47_0)
	pairs = var_1_10001

	for iter_47_0, iter_47_1 in var_1_10001(arg_47_0.equipmentVOByIds) do
		local var_47_0 = false

		pairs = var_1_10007

		for iter_47_2, iter_47_3 in var_1_10007(arg_47_0.selectedIds) do
			if iter_47_3[1] == iter_47_1.id and iter_47_1.count == iter_47_3[2] then
				var_47_0 = true
			end
		end

		if var_47_0 == false then
			return false
		end
	end

	return true
end

function var_0_1.selectEquip(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_0:checkDestroyGold(arg_48_1, arg_48_2) then
		return
	end

	if arg_48_1:isImportance() then
		pg = var_3

		local var_48_0 = var_3.TipsMgr.GetInstance()
		local var_48_1 = var_3.ShowTips

		i18n = var_6

		var_48_1(var_48_0, var_6("retire_importantequipment_tips"))

		return
	end

	local var_48_2 = false
	local var_48_3
	local var_48_4 = 0

	pairs = var_6

	for iter_48_0, iter_48_1 in var_6(arg_48_0.selectedIds) do
		if iter_48_1[1] == arg_48_1.id then
			var_48_2 = true
			var_48_3 = iter_48_0
			var_48_4 = iter_48_1[2]

			break
		end
	end

	if not var_48_2 then
		table = var_6

		var_6.insert(arg_48_0.selectedIds, {
			arg_48_1.id,
			arg_48_2
		})
	else
		local var_48_5

		if var_48_4 - arg_48_2 > 0 then
			var_48_5 = arg_48_0.selectedIds[var_48_3]
			var_48_5[2] = var_48_4 - arg_48_2
		else
			table = var_48_5

			var_48_5.remove(arg_48_0.selectedIds, var_48_3)
		end
	end

	arg_48_0:updateSelected()

	return
end

function var_0_1.updateSelected(arg_49_0)
	pairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.cards) do
		if iter_49_1.equipmentVO then
			local var_49_0 = false
			local var_49_1 = 0

			pairs = var_1_10008

			for iter_49_2, iter_49_3 in var_1_10008(arg_49_0.selectedIds) do
				if iter_49_1.equipmentVO.id == iter_49_3[1] then
					var_49_0 = true
					var_49_1 = iter_49_3[2]

					break
				end
			end

			iter_49_1:updateSelected(var_49_0, var_49_1)
		end
	end

	arg_49_0:updateOptionsStatus()

	return
end

function var_0_1.updateOptionsStatus(arg_50_0)
	arg_50_0.optionStatus = {}
	pairs = var_1

	for iter_50_0, iter_50_1 in var_1(var_0_3) do
		local var_50_0 = arg_50_0.selectOptions
		local var_50_1 = var_6.Find(var_50_0, iter_50_1)
		local var_50_2 = arg_50_0:GetOptionStatus(iter_50_1)
		local var_50_3 = arg_50_0.optionStatus

		var_50_3[iter_50_1] = var_50_2
		setGray = var_50_3

		var_50_3(var_50_1, var_50_2 == var_0_6.GREY, true)

		GetOrAddComponent = var_50_3

		local var_50_4 = var_50_3(var_50_1, "CanvasGroup")

		var_50_4.alpha = var_50_2 == var_0_6.GREY and 0.4 or 1
		setActive = var_50_4

		var_50_4(var_50_1:Find("Background/Checkmark"), var_50_2 == var_0_6.ALL)

		setActive = var_50_4

		var_50_4(var_50_1:Find("Background/Part"), var_50_2 == var_0_6.PART)
	end

	return
end

function var_0_1.GetOptionStatus(arg_51_0, arg_51_1)
	if arg_51_1 == var_0_3.ALL then
		if #arg_51_0.selectedIds == 0 then
			return var_0_6.NONE
		else
			var_1_10004 = arg_51_0

			if arg_51_0.isSelectedAll(var_1_10004) then
				return var_0_6.ALL
			else
				return var_0_6.PART
			end
		end
	else
		local var_51_0 = var_0_5[arg_51_1]

		underscore = var_1_10003

		if not var_1_10003.any(arg_51_0.equipmentVOs, function(arg_52_0)
			local var_52_0 = arg_52_0:getConfig("rarity")

			table = var_2_10002

			return var_2_10002.contains(var_51_0, var_52_0)
		end) then
			return var_0_6.GREY
		end

		underscore = var_1_10004

		local var_51_1 = var_1_10004.any(arg_51_0.selectedIds, function(arg_53_0)
			local var_53_0 = arg_51_0.equipmentVOByIds[arg_53_0[1]]
			local var_53_1 = var_1.getConfig(var_53_0, "rarity")

			table = var_2

			return var_2.contains(var_51_0, var_53_1)
		end)
		local var_51_2

		if (not arg_51_0:isSelectedAllRaritys(var_51_0) or not var_0_6.ALL) and (not var_51_1 or not var_0_6.PART) then
			var_51_2 = var_0_6.NONE
		end

		return var_51_2
	end

	return
end

function var_0_1.isSelectedAllRaritys(arg_54_0, arg_54_1)
	pairs = var_1_10002

	for iter_54_0, iter_54_1 in var_1_10002(arg_54_0.equipmentVOByIds) do
		local var_54_0 = iter_54_1
		local var_54_1 = iter_54_1.getConfig(var_54_0, "rarity")

		table = var_1_10008

		if var_1_10008.contains(arg_54_1, var_54_1) then
			var_1_10008 = false
			pairs = var_54_0

			for iter_54_2, iter_54_3 in var_54_0(arg_54_0.selectedIds) do
				if iter_54_3[1] == iter_54_1.id and iter_54_1.count == iter_54_3[2] then
					var_1_10008 = true
				end
			end

			if var_1_10008 == false then
				return false
			end
		end
	end

	return true
end

function var_0_1.checkDestroyGold(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = 0
	local var_55_1 = false

	pairs = var_1_10005

	for iter_55_0, iter_55_1 in var_1_10005(arg_55_0.selectedIds) do
		local var_55_2 = iter_55_1[2]

		Equipment = var_1_10011

		if var_1_10011.CanInBag(iter_55_1[1]) then
			Equipment = var_1_10011

			local var_55_3

			if not var_1_10011.getConfigData(iter_55_1[1]).destory_gold then
				var_55_3 = 0
			end

			var_55_0 = var_55_0 + var_55_3 * var_55_2
		end

		if arg_55_1 and iter_55_1[1] == arg_55_1.configId then
			var_55_1 = true
		end
	end

	if not var_55_1 and arg_55_1 and arg_55_2 > 0 then
		local var_55_4

		if not arg_55_1:getConfig("destory_gold") then
			var_55_4 = 0
		end

		var_55_0 = var_55_0 + var_55_4 * arg_55_2
	end

	local var_55_5 = arg_55_0.player

	if var_5.GoldMax(var_55_5, var_55_0) then
		pg = var_5

		local var_55_6 = var_5.TipsMgr.GetInstance()
		local var_55_7 = var_5.ShowTips

		i18n = var_8

		local var_55_8 = var_8("gold_max_tip_title")

		i18n = iter_55_1

		var_55_7(var_55_6, var_55_8 .. iter_55_1("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_1.SureExit(arg_56_0)
	pg = var_1_10001

	local var_56_0 = var_1_10001.MsgboxMgr.GetInstance()
	local var_56_1 = var_1.ShowMsgBox
	local var_56_2 = {}

	i18n = var_1_10005
	var_56_2.content = var_1_10005("sure_exit_resolve_equip")

	function var_56_2.onYes()
		local var_57_0 = arg_56_0

		var_0.emit(var_57_0, var_0_1.ON_CLOSE)

		return
	end

	var_56_1(var_56_0, var_56_2)

	return
end

function var_0_1.willExit(arg_58_0)
	local var_58_0 = arg_58_0.equipDestroyConfirmWindow

	var_1.Destroy(var_58_0)

	pg = var_1

	local var_58_1 = var_1.UIMgr.GetInstance()
	local var_58_2 = var_1.UnOverlayPanel
	local var_58_3 = arg_58_0._tf

	pg = var_1_10005

	var_58_2(var_58_1, var_58_3, var_1_10005.UIMgr.GetInstance().UIMain)

	return
end

return var_0_1
