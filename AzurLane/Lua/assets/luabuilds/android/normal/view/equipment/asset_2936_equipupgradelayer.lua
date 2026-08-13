class = var_0_10000

local var_0_0 = "EquipUpgradeLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.CHAT_DURATION_TIME = 0.3

function var_0_1.getUIName(arg_1_0)
	return "EquipUpgradeUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = arg_2_0._tf

	arg_2_0.mainPanel = var_1.Find(var_2_1, "main")

	local var_2_2 = arg_2_0._tf

	arg_2_0.finishPanel = var_1.Find(var_2_2, "finish_panel")
	setActive = var_1

	var_1(arg_2_0.mainPanel, true)

	setActive = var_1

	var_1(arg_2_0.finishPanel, false)

	local var_2_3 = arg_2_0.mainPanel

	arg_2_0.equipmentList = var_1.Find(var_2_3, "panel/equipment_list")

	local var_2_4 = arg_2_0.equipmentList

	arg_2_0.equipmentContain = var_1.Find(var_2_4, "equipments")
	arg_2_0.equipmentTpl = arg_2_0:getTpl("equiptpl", arg_2_0.equipmentContain)
	setActive = var_1

	var_1(arg_2_0.equipmentList, false)

	local var_2_5 = arg_2_0.mainPanel

	arg_2_0.equipmentPanel = var_1.Find(var_2_5, "panel/equipment_panel")

	local var_2_6 = arg_2_0.mainPanel

	arg_2_0.materialPanel = var_1.Find(var_2_6, "panel/material_panel")

	local var_2_7 = arg_2_0.materialPanel

	arg_2_0.startBtn = var_1.Find(var_2_7, "start_btn")

	local var_2_8 = arg_2_0.materialPanel

	arg_2_0.overLimit = var_1.Find(var_2_8, "materials/limit")
	setText = var_1

	local var_2_9 = arg_2_0.overLimit
	local var_2_10 = var_2.Find(var_2_9, "text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("equipment_upgrade_overlimit"))

	local var_2_11 = arg_2_0.materialPanel

	arg_2_0.materialsContain = var_1.Find(var_2_11, "materials/materials")
	setText = var_1

	local var_2_12 = arg_2_0.rtTogglesEmpty
	local var_2_13 = var_2.Find(var_2_12, "Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("equip_enhancement_finish"))

	setText = var_1

	local var_2_14 = arg_2_0.rtPanelTitle

	i18n = var_3

	var_1(var_2_14, var_3("equip_enhancement_required"))

	setText = var_1

	local var_2_15 = arg_2_0.rtTitle

	i18n = var_3

	var_1(var_2_15, var_3("equip_enhancement_title"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "bg")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.btnCancel

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_4, var_3_5, var_3_6, var_5)
	arg_3_0:updateAll()

	return
end

function var_0_1.updateAll(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.equipmentList, arg_6_0.contextData.shipVO)

	if arg_6_0.contextData.shipVO then
		arg_6_0:displayEquipments()

		if arg_6_0.contextData.pos then
			triggerButton = var_1

			var_1(arg_6_0.equipmentTFs[arg_6_0.contextData.pos])
		else
			triggerButton = var_1

			local var_6_0 = arg_6_0.equipmentContain

			var_1(var_2.GetChild(var_6_0, 0))
		end
	else
		arg_6_0:updateEquipment()
		arg_6_0:updateMaterials()
	end

	return
end

function var_0_1.displayEquipments(arg_7_0)
	arg_7_0.equipmentTFs = {}
	removeAllChildren = var_1

	var_1(arg_7_0.equipmentContain)

	local var_7_0 = arg_7_0.contextData.shipVO

	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(var_7_0.equipments) do
		if iter_7_1 then
			cloneTplTo = var_1_10007
			var_1_10007 = var_1_10007(arg_7_0.equipmentTpl, arg_7_0.equipmentContain)
			updateEquipment = var_8

			var_8(var_1_10007, iter_7_1)

			local var_7_1 = var_1_10007
			local var_7_2 = var_1_10007.Find(var_7_1, "tip")

			setActive = var_7_1

			var_7_1(var_7_2, false)

			if arg_7_0:isMaterialEnough(iter_7_1) and iter_7_1:getConfig("next") ~= 0 then
				setActive = var_9

				var_9(var_7_2, true)

				blinkAni = var_9

				var_9(var_7_2, 0.5)
			end

			onButton = var_9

			local var_7_3 = arg_7_0
			local var_7_4 = var_1_10007

			local function var_7_5()
				if arg_7_0.contextData.pos then
					setActive = var_2_10001

					local var_8_0 = arg_7_0.equipmentTFs[var_0]

					var_2_10001(var_2.Find(var_8_0, "selected"), false)

					setActive = var_2_10001

					local var_8_1 = arg_7_0.equipmentTFs[var_0]
					local var_8_2 = var_2.Find(var_8_1, "tip")
					local var_8_3 = arg_7_0
					local var_8_4 = var_3.isMaterialEnough
					local var_8_5 = var_7_0
					local var_8_8

					if var_8_4(var_8_3, var_5.getEquip(var_8_5, var_0)) then
						local var_8_6 = var_7_0
						local var_8_7 = var_3.getEquip(var_8_6, var_0)

						var_8_8 = var_3.getConfig(var_8_7, "next") ~= 0
					end

					var_2_10001(var_8_2, var_8_8)
				end

				arg_7_0.contextData.pos = iter_7_0
				arg_7_0.contextData.equipmentId = iter_7_1.id
				arg_7_0.contextData.equipmentVO = iter_7_1

				local var_8_9 = arg_7_0.contextData.pos

				setActive = var_1

				local var_8_10 = arg_7_0.equipmentTFs[var_8_9]

				var_1(var_2.Find(var_8_10, "selected"), true)

				setActive = var_1

				local var_8_11 = arg_7_0.equipmentTFs[var_8_9]

				var_1(var_2.Find(var_8_11, "tip"), false)

				local var_8_12 = arg_7_0

				var_1.updateEquipment(var_8_12)

				local var_8_13 = arg_7_0

				var_1.updateMaterials(var_8_13)

				return
			end

			SFX_PANEL = var_1_10013

			var_9(var_7_3, var_7_4, var_7_5, var_1_10013)

			arg_7_0.equipmentTFs[iter_7_0] = var_1_10007
		end
	end

	return
end

function var_0_1.isMaterialEnough(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1

	if not arg_9_1.getConfig(var_9_0, "trans_use_item") then
		return false
	end

	ipairs = var_9_0
	underscore = var_4

	for iter_9_0, iter_9_1 in var_9_0(var_4.map(var_2, function(arg_10_0)
		unpack = var_2_10001

		local var_10_0, var_10_1 = var_2_10001(arg_10_0)

		Drop = var_2_10003

		local var_10_2 = var_2_10003.New
		local var_10_3 = {}

		DROP_TYPE_ITEM = var_2_10005
		var_10_3.type = var_2_10005
		var_10_3.id = var_10_0
		var_10_3.count = var_10_1

		return var_10_2(var_10_3)
	end)) do
		if iter_9_1.count > iter_9_1:getOwnedCount() then
			return false
		end
	end

	return true
end

function var_0_1.updateEquipment(arg_11_0)
	local var_11_0 = arg_11_0.contextData.equipmentVO
	local var_11_1 = arg_11_0.contextData

	var_11_1.equipmentId = var_11_0.id
	changeToScrollText = var_11_1

	local var_11_2 = arg_11_0.equipmentPanel

	var_11_1(var_3.Find(var_11_2, "name_container"), var_11_0:getConfig("name"))

	setActive = var_11_1
	findTF = var_3

	var_11_1(var_3(arg_11_0.equipmentPanel, "unique"), var_11_0:isUnique())

	updateEquipment = var_11_1

	local var_11_3 = arg_11_0.equipmentPanel

	var_11_1(var_3.Find(var_11_3, "equiptpl"), var_11_0)

	arg_11_0.nextEquips = {}

	while var_11_0:getConfig("next") > 0 do
		var_11_0 = var_11_0:MigrateTo(var_11_0:getConfig("next"))
		table = var_2

		var_2.insert(arg_11_0.nextEquips, var_11_0)
	end

	if #arg_11_0.nextEquips == 0 then
		arg_11_0.toggleEquips = nil
	else
		arg_11_0.toggleEquips = {
			arg_11_0.nextEquips[1]
		}

		if #arg_11_0.nextEquips > 0 then
			local var_11_4 = arg_11_0.nextEquips[#arg_11_0.nextEquips]
			local var_11_5 = var_2.getConfig(var_11_4, "level")

			switch = var_11_4

			local var_11_6 = var_11_4(var_2:getConfig("level") - 1, {
				[13] = function()
					return {
						10,
						13
					}
				end,
				[11] = function()
					return {
						10,
						11
					}
				end,
				[10] = function()
					return {
						10
					}
				end,
				[7] = function()
					return {
						6,
						7
					}
				end,
				[6] = function()
					return {
						6
					}
				end,
				[3] = function()
					return {
						3
					}
				end
			}, function()
				return {}
			end)

			ipairs = var_5

			for iter_11_0, iter_11_1 in var_5(var_11_6) do
				if #arg_11_0.nextEquips > var_11_5 - 1 - iter_11_1 then
					table = var_10

					var_10.insert(arg_11_0.toggleEquips, arg_11_0.nextEquips[#arg_11_0.nextEquips - (var_11_5 - 1 - iter_11_1)])
				end
			end
		end
	end

	arg_11_0:updateToggles()

	return
end

function var_0_1.updateToggles(arg_19_0)
	setActive = var_1_10001

	local var_19_0 = arg_19_0.rtToggles

	tobool = var_1_10003

	var_1_10001(var_19_0, var_1_10003(arg_19_0.toggleEquips))

	setActive = var_1_10001

	local var_19_1 = arg_19_0.rtTogglesEmpty

	tobool = var_3

	var_1_10001(var_19_1, not var_3(arg_19_0.toggleEquips))

	if arg_19_0.toggleEquips then
		UIItemList = var_1

		var_1.StaticAlign(arg_19_0.rtToggles, arg_19_0.rtToggleTpl, #arg_19_0.toggleEquips, function(arg_20_0, arg_20_1, arg_20_2)
			arg_20_1 = arg_20_1 + 1
			UIItemList = var_2_10003

			if arg_20_0 == var_2_10003.EventUpdate then
				local var_20_0 = arg_19_0.toggleEquips[arg_20_1]

				if arg_20_1 == 1 then
					setText = var_2_10004

					local var_20_1 = arg_20_2
					local var_20_2 = arg_20_2.Find(var_20_1, "Text")

					i18n = var_20_1

					var_2_10004(var_20_2, var_20_1("equip_enhancement_lv1"))
				else
					setText = var_2_10004

					local var_20_3 = arg_20_2
					local var_20_4 = arg_20_2.Find(var_20_3, "Text")

					i18n = var_20_3

					var_2_10004(var_20_4, var_20_3("equip_enhancement_lvx", var_20_0:getConfig("level") - 1))
				end

				onToggle = var_2_10004

				local var_20_5 = arg_19_0
				local var_20_6 = arg_20_2

				local function var_20_7(arg_21_0)
					if arg_21_0 then
						arg_19_0.targetEquip = var_20_0

						local var_21_0 = arg_19_0

						var_1.updateMaterials(var_21_0)
					end

					return
				end

				SFX_PANEL = var_2_10008

				var_2_10004(var_20_5, var_20_6, var_20_7, var_2_10008)
			end

			return
		end)

		triggerToggle = var_1

		local var_19_2 = arg_19_0.rtToggles

		var_1(var_2.GetChild(var_19_2, 0), true)
	else
		arg_19_0.targetEquip = nil

		arg_19_0:updateMaterials()
	end

	return
end

local function var_0_2(arg_22_0)
	_ = var_1_10001

	local var_22_0 = var_1_10001.detect(arg_22_0.sub, function(arg_23_0)
		local var_23_0 = arg_23_0.type

		AttributeType = var_2_10002

		return var_23_0 == var_2_10002.Damage
	end)

	arg_22_0.sub = {
		var_22_0
	}

	return
end

local function var_0_3(arg_24_0)
	_ = var_1_10001

	local var_24_0 = var_1_10001.detect(arg_24_0.sub, function(arg_25_0)
		local var_25_0 = arg_25_0.type

		AttributeType = var_2_10002

		return var_25_0 == var_2_10002.Corrected
	end)

	arg_24_0.sub = {
		var_24_0
	}

	return
end

function var_0_1.updateAttrs(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_2:GetPropertiesInfo()

	for iter_26_0 = 1, #var_26_0.weapon.sub do
		var_0_2(var_26_0.weapon.sub[iter_26_0])
	end

	var_0_3(var_26_0.equipInfo)

	local var_26_1 = var_26_0.equipInfo

	var_26_1.lock_open = true

	if arg_26_3 then
		local var_26_2 = arg_26_3

		var_26_1 = arg_26_3.GetPropertiesInfo(var_26_2)
		Equipment = var_26_2

		var_26_2.InsertAttrsUpgrade(var_26_0.attrs, var_26_1.attrs)

		local var_26_3 = arg_26_2:GetSkill()
		local var_26_4 = arg_26_3
		local var_26_5 = arg_26_3.GetSkill(var_26_4)

		checkExist = var_26_4

		local var_26_6 = var_26_4(var_26_3, {
			"name"
		})

		checkExist = var_9

		if var_26_6 ~= var_9(var_26_5, {
			"name"
		}) then
			local var_26_7 = {
				lock_open = true
			}

			i18n = var_9
			var_26_7.name = var_9("skill")
			setColorStr = var_9
			checkExist = var_10

			local var_26_8

			if not var_10(var_26_3, {
				"name"
			}) then
				i18n = var_26_8
				var_26_8 = var_26_8("equip_info_25")
			end

			var_26_7.value = var_9(var_26_8, "#FFDE00FF")

			local var_26_9 = {}
			local var_26_10 = {}

			i18n = var_11
			var_26_10.name = var_11("equip_info_26")
			setColorStr = var_11
			checkExist = var_1_10012

			if not var_1_10012(var_26_5, {
				"name"
			}) then
				i18n = var_1_10012
				var_1_10012 = var_1_10012("equip_info_25")
			end

			var_26_10.value = var_11(var_1_10012, "#FFDE00FF")
			var_26_9[1] = var_26_10
			var_26_7.sub = var_26_9
			table = var_26_9

			var_26_9.insert(var_26_0.attrs, var_26_7)
		end

		if #var_26_1.weapon.sub > #var_26_0.weapon.sub then
			for iter_26_1 = #var_26_0.weapon.sub, #var_26_1.weapon.sub do
				table = var_1_10012
				var_1_10012 = var_1_10012.insert

				local var_26_11 = var_26_0.weapon.sub
				local var_26_12 = {}

				i18n = var_1_10015
				var_26_12.name = var_1_10015("equip_info_25")
				var_26_12.sub = {}

				var_1_10012(var_26_11, var_26_12)
			end
		end

		for iter_26_2 = #var_26_0.weapon.sub, 1, -1 do
			local var_26_13 = var_26_0.weapon.sub[iter_26_2]
			local var_26_15

			if var_26_1.weapon.sub[iter_26_2] then
				var_0_2(var_26_1.weapon.sub[iter_26_2])
			else
				local var_26_14 = {}

				i18n = var_1_10015
				var_26_14.name = var_1_10015("equip_info_25")
				var_26_14.sub = {}
				var_26_15 = var_26_14
			end

			local var_26_16

			if var_26_13.name ~= var_26_15.name then
				var_26_16 = {}
				var_1_10015 = {}
				i18n = var_1_10016
				var_1_10015.name = var_1_10016("equip_info_27")
				var_1_10015.value = var_26_15.name
				var_26_16[1] = var_1_10015
				var_26_13.sub = var_26_16
			else
				Equipment = var_26_16

				var_26_16.InsertAttrsUpgrade(var_26_13.sub, var_26_15.sub)
			end

			if #var_26_13.sub == 0 then
				table = var_14

				var_14.remove(var_26_0.weapon.sub, iter_26_2)

				if var_26_1.weapon.sub[iter_26_2] then
					table = var_14

					var_14.remove(var_26_1.weapon.sub, iter_26_2)
				end
			end
		end

		var_0_3(var_26_1.equipInfo)

		Equipment = var_8

		var_8.InsertAttrsUpgrade(var_26_0.equipInfo.sub, var_26_1.equipInfo.sub)
	end

	updateEquipUpgradeInfo = var_26_1

	var_26_1(arg_26_1, var_26_0, arg_26_0.contextData.shipVO)

	return
end

function var_0_1.updateMaterials(arg_27_0)
	tobool = var_1_10001

	local var_27_0 = var_1_10001(arg_27_0.targetEquip)

	setActive = var_2

	var_2(arg_27_0.materialsContain, var_27_0)

	setActive = var_2

	var_2(arg_27_0.overLimit, not var_27_0)

	setButtonEnabled = var_2

	var_2(arg_27_0.startBtn, var_27_0)

	setTextAlpha = var_2

	local var_27_1 = arg_27_0.startBtn

	var_2(var_3.Find(var_27_1, "consume"), var_27_0 and 1 or 0.5)

	local var_27_2 = arg_27_0.contextData.equipmentVO
	local var_27_3 = arg_27_0
	local var_27_4 = arg_27_0.updateAttrs
	local var_27_5 = arg_27_0.equipmentPanel

	var_27_4(var_27_3, var_5.Find(var_27_5, "view/content"), var_27_2, arg_27_0.targetEquip)

	setText = var_27_4

	local var_27_6 = arg_27_0.rtLevel
	local var_27_7 = var_4.Find(var_27_6, "before")

	i18n = var_27_6

	var_27_4(var_27_7, var_27_6("equip_enhancement_lv"))

	setText = var_27_4

	local var_27_8 = arg_27_0.rtLevel

	var_27_4(var_4.Find(var_27_8, "before/number"), var_27_2:getConfig("level") - 1)

	setText = var_27_4

	local var_27_9 = arg_27_0.rtLevel
	local var_27_10 = var_4.Find(var_27_9, "after")

	i18n = var_27_9

	var_27_4(var_27_10, var_27_9("equip_enhancement_lv"))

	setText = var_27_4

	local var_27_11 = arg_27_0.rtLevel
	local var_27_12 = var_4.Find(var_27_11, "after/number")
	local var_27_13

	if not arg_27_0.targetEquip then
		var_27_13 = var_27_2
	end

	var_27_4(var_27_12, var_27_13:getConfig("level") - 1)

	setActive = var_27_4

	local var_27_14 = arg_27_0.rtLevel

	var_27_4(var_4.Find(var_27_14, "before"), var_27_0)

	setActive = var_27_4

	local var_27_15 = arg_27_0.rtLevel

	var_27_4(var_4.Find(var_27_15, "Image"), var_27_0)

	if not var_27_0 then
		setText = var_27_4

		local var_27_16 = arg_27_0.startBtn

		var_27_4(var_4.Find(var_27_16, "consume"), 0)

		return
	end

	underscore = var_27_4

	local var_27_17 = var_27_4.to_array
	local var_27_18

	if not var_27_2:getConfig("trans_use_item") then
		var_27_18 = {}
	end

	local var_27_19 = var_27_17(var_27_18)

	defaultValue = var_27_18

	local var_27_20 = var_27_18(var_27_2:getConfig("trans_use_gold"), 0)

	ipairs = var_5

	for iter_27_0, iter_27_1 in var_5(arg_27_0.nextEquips) do
		if iter_27_1 == arg_27_0.targetEquip then
			break
		else
			table = var_10

			local var_27_21 = var_10.insertto
			local var_27_22 = var_27_19
			local var_27_23

			if not iter_27_1:getConfig("trans_use_item") then
				var_27_23 = {}
			end

			var_27_21(var_27_22, var_27_23)

			defaultValue = var_27_21
			var_27_20 = var_27_20 + var_27_21(iter_27_1:getConfig("trans_use_gold"), 0)
		end
	end

	PlayerConst = var_5

	local var_27_24 = var_5.MergeSameDrops

	underscore = var_6

	local var_27_25 = var_27_24(var_6.map(var_27_19, function(arg_28_0)
		unpack = var_2_10001

		local var_28_0, var_28_1 = var_2_10001(arg_28_0)

		Drop = var_2_10003

		local var_28_2 = var_2_10003.New
		local var_28_3 = {}

		DROP_TYPE_ITEM = var_2_10005
		var_28_3.type = var_2_10005
		var_28_3.id = var_28_0
		var_28_3.count = var_28_1

		return var_28_2(var_28_3)
	end))
	local var_27_26 = true
	local var_27_27
	local var_27_28 = 0

	for iter_27_2 = 1, 5 do
		local var_27_29 = arg_27_0.materialsContain
		local var_27_30 = var_12.GetChild(var_27_29, iter_27_2 - 1)
		local var_27_31 = var_27_25[iter_27_2]

		setActive = var_1_10014
		findTF = var_1_10015

		var_1_10014(var_1_10015(var_27_30, "off"), not var_27_31)

		setActive = var_1_10014
		findTF = var_1_10015

		var_1_10014(var_1_10015(var_27_30, "equiptpl"), var_27_31)

		if var_27_31 then
			findTF = var_1_10014
			var_1_10014 = var_1_10014(var_27_30, "equiptpl")
			updateItem = var_1_10015

			var_1_10015(var_1_10014, var_27_31:getSubClass())

			onButton = var_1_10015

			local var_27_32 = arg_27_0
			local var_27_33 = var_1_10014

			local function var_27_34()
				local var_29_0 = arg_27_0
				local var_29_1 = var_0.emit

				BaseUI = var_2_10002

				var_29_1(var_29_0, var_2_10002.ON_DROP, var_27_31)

				return
			end

			SFX_PANEL = var_1_10019

			var_1_10015(var_27_32, var_27_33, var_27_34, var_1_10019)

			var_1_10015 = var_27_31:getOwnedCount()

			local var_27_35 = var_1_10014:Find("icon_bg/count")

			if var_1_10015 < var_27_31.count then
				setText = var_17

				local var_27_36 = var_27_35

				setColorStr = var_1_10019

				local var_27_37 = var_1_10015

				COLOR_RED = var_1_10021

				var_17(var_27_36, var_1_10019(var_27_37, var_1_10021) .. "/" .. var_27_31.count)

				var_27_26 = false
				var_27_27 = var_27_31.id
			else
				setText = var_17

				var_17(var_27_35, var_1_10015 .. "/" .. var_27_31.count)
			end

			setActive = var_17

			var_17(var_27_35, true)

			onButton = var_17

			local var_27_38 = arg_27_0

			var_1_10019 = var_1_10014:Find("click")

			local function var_27_39()
				setActive = var_2_10000

				local var_30_0 = var_1_10014

				var_2_10000(var_1.Find(var_30_0, "click"), false)

				var_27_28 = var_27_28 - 1

				return
			end

			SFX_PANEL = var_1_10021

			var_17(var_27_38, var_1_10019, var_27_39, var_1_10021)

			local var_27_40 = var_27_31:getDropRarity()
			local var_27_41 = 3 < var_27_40

			setActive = var_18

			var_18(var_1_10014:Find("click"), var_27_41)

			var_27_28 = var_27_28 + (var_27_41 and 1 or 0)
		end
	end

	Drop = var_8

	local var_27_42 = var_8.New
	local var_27_43 = {}

	DROP_TYPE_RESOURCE = var_10
	var_27_43.type = var_10
	PlayerConst = var_10
	var_27_43.id = var_10.ResGold
	var_27_43.count = var_27_20

	local var_27_44 = var_27_42(var_27_43)

	if var_8.getOwnedCount(var_27_44) < var_8.count then
		setText = var_10

		local var_27_45 = arg_27_0.startBtn
		local var_27_46 = var_11.Find(var_27_45, "consume")

		setColorStr = var_27_45

		local var_27_47 = var_27_20

		COLOR_RED = var_1_10014

		var_10(var_27_46, var_27_45(var_27_47, var_1_10014))
	else
		setText = var_10

		local var_27_48 = arg_27_0.startBtn

		var_10(var_11.Find(var_27_48, "consume"), var_27_20)
	end

	onButton = var_10

	local var_27_49 = arg_27_0
	local var_27_50 = arg_27_0.startBtn

	local function var_27_51()
		if not var_27_26 then
			ItemTipPanel = var_0

			if not var_0.ShowItemTipbyID(var_27_27) then
				pg = var_0

				local var_31_0 = var_0.TipsMgr.GetInstance()
				local var_31_1 = var_0.ShowTips

				i18n = var_2_10002

				var_31_1(var_31_0, var_2_10002("ship_shipUpgradeLayer2_noMaterail"))
			end

			return
		end

		if var_27_28 > 0 then
			pg = var_0

			local var_31_2 = var_0.TipsMgr.GetInstance()
			local var_31_3 = var_0.ShowTips

			i18n = var_2_10002

			var_31_3(var_31_2, var_2_10002("equipment_upgrade_costcheck_error"))

			return
		end

		if var_0 < var_27_20 then
			GoShoppingMsgBox = var_0
			i18n = var_1
			var_2_10002 = "switch_to_shop_tip_2"
			i18n = var_2_10003

			local var_31_4 = var_1(var_2_10002, var_2_10003("word_gold"))

			ChargeScene = var_2_10002

			var_0(var_31_4, var_2_10002.TYPE_ITEM, {
				{
					59001,
					var_27_20 - var_0,
					var_27_20
				}
			})

			return
		end

		local var_31_5 = arg_27_0
		local var_31_6 = var_0.emit

		EquipUpgradeMediator = var_2_10002

		var_31_6(var_31_5, var_2_10002.EQUIPMENT_UPGRDE, arg_27_0.targetEquip, var_27_25, var_27_20)

		return
	end

	SFX_UI_DOCKYARD_REINFORCE = var_1_10014

	var_10(var_27_49, var_27_50, var_27_51, var_1_10014)

	return
end

function var_0_1.upgradeFinish(arg_32_0, arg_32_1, arg_32_2)
	setActive = var_1_10003

	var_1_10003(arg_32_0.mainPanel, false)

	setActive = var_1_10003

	var_1_10003(arg_32_0.finishPanel, true)

	onButton = var_1_10003

	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.finishPanel
	local var_32_2 = var_5.Find(var_32_1, "bg")

	local function var_32_3()
		setActive = var_2_10000

		var_2_10000(arg_32_0.mainPanel, true)

		setActive = var_2_10000

		var_2_10000(arg_32_0.finishPanel, false)

		return
	end

	SFX_CANCEL = var_7

	var_1_10003(var_32_0, var_32_2, var_32_3, var_7)

	changeToScrollText = var_1_10003

	local var_32_4 = arg_32_0.finishPanel

	var_1_10003(var_4.Find(var_32_4, "frame/equipment_panel/name_container"), arg_32_2:getConfig("name"))

	setActive = var_1_10003
	findTF = var_4

	var_1_10003(var_4(arg_32_0.finishPanel, "frame/equipment_panel/unique"), arg_32_2:isUnique())

	local var_32_5 = arg_32_0.finishPanel
	local var_32_6 = var_3.Find(var_32_5, "frame/equipment_panel/equiptpl")

	updateEquipment = var_32_5

	var_32_5(var_32_6, arg_32_2)

	local var_32_7 = arg_32_0
	local var_32_8 = arg_32_0.updateAttrs
	local var_32_9 = arg_32_0.finishPanel

	var_32_8(var_32_7, var_6.Find(var_32_9, "frame/equipment_panel/view/content"), arg_32_1, arg_32_2)

	return
end

function var_0_1.willExit(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_34_0, arg_34_0._tf)

	return
end

return var_0_1
