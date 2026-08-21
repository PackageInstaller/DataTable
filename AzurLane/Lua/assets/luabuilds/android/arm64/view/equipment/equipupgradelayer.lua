local var_0_0 = class("EquipUpgradeLayer", import("..base.BaseUI"))

var_0_0.CHAT_DURATION_TIME = 0.3

function var_0_0.getUIName(arg_1_0)
	return "EquipUpgradeUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0.mainPanel = arg_2_0._tf:Find("main")
	arg_2_0.finishPanel = arg_2_0._tf:Find("finish_panel")

	setActive(arg_2_0.mainPanel, true)
	setActive(arg_2_0.finishPanel, false)

	arg_2_0.equipmentList = arg_2_0.mainPanel:Find("panel/equipment_list")
	arg_2_0.equipmentContain = arg_2_0.equipmentList:Find("equipments")
	arg_2_0.equipmentTpl = arg_2_0:getTpl("equiptpl", arg_2_0.equipmentContain)

	setActive(arg_2_0.equipmentList, false)

	arg_2_0.equipmentPanel = arg_2_0.mainPanel:Find("panel/equipment_panel")
	arg_2_0.materialPanel = arg_2_0.mainPanel:Find("panel/material_panel")
	arg_2_0.startBtn = arg_2_0.materialPanel:Find("start_btn")
	arg_2_0.overLimit = arg_2_0.materialPanel:Find("materials/limit")

	setText(arg_2_0.overLimit:Find("text"), i18n("equipment_upgrade_overlimit"))

	arg_2_0.materialsContain = arg_2_0.materialPanel:Find("materials/materials")

	setText(arg_2_0.rtTogglesEmpty:Find("Text"), i18n("equip_enhancement_finish"))
	setText(arg_2_0.rtPanelTitle, i18n("equip_enhancement_required"))
	setText(arg_2_0.rtTitle, i18n("equip_enhancement_title"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.btnCancel, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	arg_3_0:updateAll()

	return
end

function var_0_0.updateAll(arg_6_0)
	setActive(arg_6_0.equipmentList, arg_6_0.contextData.shipVO)

	if arg_6_0.contextData.shipVO then
		arg_6_0:displayEquipments()

		if arg_6_0.contextData.pos then
			triggerButton(arg_6_0.equipmentTFs[arg_6_0.contextData.pos])
		else
			triggerButton(arg_6_0.equipmentContain:GetChild(0))
		end
	else
		arg_6_0:updateEquipment()
		arg_6_0:updateMaterials()
	end

	return
end

function var_0_0.displayEquipments(arg_7_0)
	arg_7_0.equipmentTFs = {}

	removeAllChildren(arg_7_0.equipmentContain)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.contextData.shipVO.equipments) do
		if iter_7_1 then
			local var_7_0 = cloneTplTo(arg_7_0.equipmentTpl, arg_7_0.equipmentContain)

			updateEquipment(var_7_0, iter_7_1)

			local var_7_1 = var_7_0:Find("tip")

			setActive(var_7_1, false)

			if arg_7_0:isMaterialEnough(iter_7_1) and iter_7_1:getConfig("next") ~= 0 then
				setActive(var_7_1, true)
				blinkAni(var_7_1, 0.5)
			end

			onButton(arg_7_0, var_7_0, function()
				if arg_7_0.contextData.pos then
					setActive(arg_7_0.equipmentTFs[arg_7_0.contextData.pos]:Find("selected"), false)

					local var_8_0 = arg_7_0:isMaterialEnough(var_0:getEquip(arg_7_0.contextData.pos))

					if var_8_0 then
						var_8_0 = var_0:getEquip(arg_7_0.contextData.pos):getConfig("next") ~= 0
					end

					setActive(arg_7_0.equipmentTFs[arg_7_0.contextData.pos]:Find("tip"), var_8_0)
				end

				arg_7_0.contextData.pos = iter_7_0
				arg_7_0.contextData.equipmentId = iter_7_1.id
				arg_7_0.contextData.equipmentVO = iter_7_1

				setActive(arg_7_0.equipmentTFs[arg_7_0.contextData.pos]:Find("selected"), true)
				setActive(arg_7_0.equipmentTFs[arg_7_0.contextData.pos]:Find("tip"), false)
				arg_7_0:updateEquipment()
				arg_7_0:updateMaterials()

				return
			end, SFX_PANEL)

			arg_7_0.equipmentTFs[iter_7_0] = var_7_0
		end
	end

	return
end

function var_0_0.isMaterialEnough(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getConfig("trans_use_item")

	if not var_9_0 then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(underscore.map(var_9_0, function(arg_10_0)
		local var_10_0, var_10_1 = unpack(arg_10_0)

		return Drop.New({
			type = DROP_TYPE_ITEM,
			id = var_10_0,
			count = var_10_1
		})
	end)) do
		if iter_9_1.count > iter_9_1:getOwnedCount() then
			return false
		end
	end

	return true
end

function var_0_0.updateEquipment(arg_11_0)
	local var_11_0 = arg_11_0.contextData.equipmentVO

	arg_11_0.contextData.equipmentId = arg_11_0.contextData.equipmentVO.id

	changeToScrollText(arg_11_0.equipmentPanel:Find("name_container"), var_11_0:getConfig("name"))
	setActive(findTF(arg_11_0.equipmentPanel, "unique"), var_11_0:isUnique())
	updateEquipment(arg_11_0.equipmentPanel:Find("equiptpl"), var_11_0)

	arg_11_0.nextEquips = {}

	while var_11_0:getConfig("next") > 0 do
		var_11_0 = var_11_0:MigrateTo(var_11_0:getConfig("next"))

		table.insert(arg_11_0.nextEquips, var_11_0)
	end

	if #arg_11_0.nextEquips == 0 then
		arg_11_0.toggleEquips = nil
	else
		arg_11_0.toggleEquips = {
			arg_11_0.nextEquips[1]
		}

		if #arg_11_0.nextEquips > 0 then
			local var_11_1 = arg_11_0.nextEquips[#arg_11_0.nextEquips]:getConfig("level")

			for iter_11_0, iter_11_1 in ipairs((switch(arg_11_0.nextEquips[#arg_11_0.nextEquips]:getConfig("level") - 1, {
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
			end))) do
				if #arg_11_0.nextEquips > var_11_1 - 1 - iter_11_1 then
					table.insert(arg_11_0.toggleEquips, arg_11_0.nextEquips[#arg_11_0.nextEquips - (var_11_1 - 1 - iter_11_1)])
				end
			end
		end
	end

	arg_11_0:updateToggles()

	return
end

function var_0_0.updateToggles(arg_19_0)
	setActive(arg_19_0.rtToggles, tobool(arg_19_0.toggleEquips))
	setActive(arg_19_0.rtTogglesEmpty, not tobool(arg_19_0.toggleEquips))

	if arg_19_0.toggleEquips then
		UIItemList.StaticAlign(arg_19_0.rtToggles, arg_19_0.rtToggleTpl, #arg_19_0.toggleEquips, function(arg_20_0, arg_20_1, arg_20_2)
			arg_20_1 = arg_20_1 + 1

			if arg_20_0 == UIItemList.EventUpdate then
				local var_20_0 = arg_19_0.toggleEquips[arg_20_1]

				if arg_20_1 == 1 then
					setText(arg_20_2:Find("Text"), i18n("equip_enhancement_lv1"))
				else
					setText(arg_20_2:Find("Text"), i18n("equip_enhancement_lvx", arg_19_0.toggleEquips[arg_20_1]:getConfig("level") - 1))
				end

				onToggle(arg_19_0, arg_20_2, function(arg_21_0)
					if arg_21_0 then
						arg_19_0.targetEquip = var_20_0

						arg_19_0:updateMaterials()
					end

					return
				end, SFX_PANEL)
			end

			return
		end)
		triggerToggle(arg_19_0.rtToggles:GetChild(0), true)
	else
		arg_19_0.targetEquip = nil

		arg_19_0:updateMaterials()
	end

	return
end

local function var_0_1(arg_22_0)
	arg_22_0.sub = {
		(_.detect(arg_22_0.sub, function(arg_23_0)
			return arg_23_0.type == AttributeType.Damage
		end))
	}

	return
end

local function var_0_2(arg_24_0)
	arg_24_0.sub = {
		(_.detect(arg_24_0.sub, function(arg_25_0)
			return arg_25_0.type == AttributeType.Corrected
		end))
	}

	return
end

function var_0_0.updateAttrs(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_2:GetPropertiesInfo()

	for iter_26_0 = 1, #var_26_0.weapon.sub do
		var_0_1(var_26_0.weapon.sub[iter_26_0])
	end

	var_0_2(var_26_0.equipInfo)

	var_26_0.equipInfo.lock_open = true

	if arg_26_3 then
		local var_26_1 = arg_26_3:GetPropertiesInfo()

		Equipment.InsertAttrsUpgrade(var_26_0.attrs, var_26_1.attrs)

		local var_26_2 = arg_26_2:GetSkill()
		local var_26_3 = arg_26_3:GetSkill()

		if checkExist(var_26_2, {
			"name"
		}) ~= checkExist(var_26_3, {
			"name"
		}) then
			local var_26_4 = {
				lock_open = true,
				name = i18n("skill")
			}
			local var_26_5 = checkExist(var_26_2, {
				"name"
			}) or i18n("equip_info_25")

			var_26_4.value = setColorStr(var_26_5, "#FFDE00FF")

			local var_26_6 = {
				name = i18n("equip_info_26")
			}
			local var_26_7 = checkExist(var_26_3, {
				"name"
			}) or i18n("equip_info_25")

			var_26_6.value = setColorStr(var_26_7, "#FFDE00FF")
			;({})[1] = var_26_6
			var_26_4.sub = {}

			table.insert(var_26_0.attrs, var_26_4)
		end

		if #var_26_1.weapon.sub > #var_26_0.weapon.sub then
			for iter_26_1 = #var_26_0.weapon.sub, #var_26_1.weapon.sub do
				table.insert(var_26_0.weapon.sub, {
					name = i18n("equip_info_25"),
					sub = {}
				})
			end
		end

		for iter_26_2 = #var_26_0.weapon.sub, 1, -1 do
			local var_26_8 = var_26_0.weapon.sub[iter_26_2]
			local var_26_9 = var_26_1.weapon.sub[iter_26_2]

			if var_26_1.weapon.sub[iter_26_2] then
				var_0_1(var_26_1.weapon.sub[iter_26_2])
			else
				var_26_9 = {
					name = i18n("equip_info_25"),
					sub = {}
				}
			end

			if var_26_8.name ~= var_26_9.name then
				var_26_8.sub = {
					{
						name = i18n("equip_info_27"),
						value = var_26_9.name
					}
				}
			else
				Equipment.InsertAttrsUpgrade(var_26_8.sub, var_26_9.sub)
			end

			if #var_26_8.sub == 0 then
				table.remove(var_26_0.weapon.sub, iter_26_2)

				if var_26_1.weapon.sub[iter_26_2] then
					table.remove(var_26_1.weapon.sub, iter_26_2)
				end
			end
		end

		var_0_2(var_26_1.equipInfo)
		Equipment.InsertAttrsUpgrade(var_26_0.equipInfo.sub, var_26_1.equipInfo.sub)
	end

	updateEquipUpgradeInfo(arg_26_1, var_26_0, arg_26_0.contextData.shipVO)

	return
end

function var_0_0.updateMaterials(arg_27_0)
	local var_27_0 = tobool(arg_27_0.targetEquip)

	setActive(arg_27_0.materialsContain, var_27_0)
	setActive(arg_27_0.overLimit, not var_27_0)
	setButtonEnabled(arg_27_0.startBtn, var_27_0)
	setTextAlpha(arg_27_0.startBtn:Find("consume"), var_27_0 and 1 or 0.5)
	arg_27_0:updateAttrs(arg_27_0.equipmentPanel:Find("view/content"), arg_27_0.contextData.equipmentVO, arg_27_0.targetEquip)
	setText(arg_27_0.rtLevel:Find("before"), i18n("equip_enhancement_lv"))
	setText(arg_27_0.rtLevel:Find("before/number"), arg_27_0.contextData.equipmentVO:getConfig("level") - 1)
	setText(arg_27_0.rtLevel:Find("after"), i18n("equip_enhancement_lv"))

	local var_27_1 = arg_27_0.targetEquip

	if not arg_27_0.targetEquip then
		var_27_1 = arg_27_0.contextData.equipmentVO

		setText(arg_27_0.rtLevel:Find("after/number"), var_27_1:getConfig("level") - 1)
		setActive(arg_27_0.rtLevel:Find("before"), var_27_0)
		setActive(arg_27_0.rtLevel:Find("Image"), var_27_0)

		local var_27_2

		if not var_27_0 then
			setText(arg_27_0.startBtn:Find("consume"), 0)

			do return end

			var_27_2 = arg_27_0.contextData.equipmentVO:getConfig("trans_use_item") or {}
		end

		local var_27_3 = underscore.to_array(var_27_2)
		local var_27_4 = defaultValue(arg_27_0.contextData.equipmentVO:getConfig("trans_use_gold"), 0)

		for iter_27_0, iter_27_1 in ipairs(arg_27_0.nextEquips) do
			local var_27_5

			if iter_27_1 == arg_27_0.targetEquip then
				do break end
				goto label_27_0

				var_27_5 = iter_27_1:getConfig("trans_use_item") or {}
			end

			table.insertto(var_27_3, var_27_5)

			var_27_4 = var_27_4 + defaultValue(iter_27_1:getConfig("trans_use_gold"), 0)

			::label_27_0::
		end

		local var_27_6 = PlayerConst.MergeSameDrops(underscore.map(var_27_3, function(arg_28_0)
			local var_28_0, var_28_1 = unpack(arg_28_0)

			return Drop.New({
				type = DROP_TYPE_ITEM,
				id = var_28_0,
				count = var_28_1
			})
		end))
		local var_27_7 = true
		local var_27_8
		local var_27_9 = 0

		for iter_27_2 = 1, 5 do
			local var_27_10 = arg_27_0.materialsContain:GetChild(iter_27_2 - 1)
			local var_27_11 = var_27_6[iter_27_2]

			setActive(findTF(var_27_10, "off"), not var_27_6[iter_27_2])
			setActive(findTF(var_27_10, "equiptpl"), var_27_11)

			if var_27_11 then
				local var_27_12 = findTF(var_27_10, "equiptpl")

				updateItem(var_27_12, var_27_11:getSubClass())
				onButton(arg_27_0, var_27_12, function()
					arg_27_0:emit(BaseUI.ON_DROP, var_27_11)

					return
				end, SFX_PANEL)

				local var_27_13 = var_27_11:getOwnedCount()
				local var_27_14 = var_27_12:Find("icon_bg/count")

				if var_27_13 < var_27_11.count then
					setText(var_27_14, setColorStr(var_27_13, COLOR_RED) .. "/" .. var_27_11.count)

					var_27_7 = false
					var_27_8 = var_27_11.id
				else
					setText(var_27_14, var_27_13 .. "/" .. var_27_11.count)
				end

				setActive(var_27_14, true)
				onButton(arg_27_0, var_27_12:Find("click"), function()
					setActive(var_27_12:Find("click"), false)

					var_27_9 = var_27_9 - 1

					return
				end, SFX_PANEL)

				local var_27_15 = var_27_11:getDropRarity() > 3

				setActive(var_27_12:Find("click"), var_27_15)

				var_27_9 = var_27_9 + (var_27_15 and 1 or 0)
			end
		end

		local var_27_16 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResGold,
			count = var_27_4
		})

		if var_27_16:getOwnedCount() < var_27_16.count then
			setText(arg_27_0.startBtn:Find("consume"), setColorStr(var_27_4, COLOR_RED))
		else
			setText(arg_27_0.startBtn:Find("consume"), var_27_4)
		end

		onButton(arg_27_0, arg_27_0.startBtn, function()
			if not var_27_7 then
				if not ItemTipPanel.ShowItemTipbyID(var_27_8) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_shipUpgradeLayer2_noMaterail"))
				end

				return
			end

			if var_27_9 > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_costcheck_error"))

				return
			end

			if var_0 < var_27_4 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						var_27_4 - var_0,
						var_27_4
					}
				})

				return
			end

			arg_27_0:emit(EquipUpgradeMediator.EQUIPMENT_UPGRDE, arg_27_0.targetEquip, var_27_6, var_27_4)

			return
		end, SFX_UI_DOCKYARD_REINFORCE)

		return
	end
end

function var_0_0.upgradeFinish(arg_32_0, arg_32_1, arg_32_2)
	setActive(arg_32_0.mainPanel, false)
	setActive(arg_32_0.finishPanel, true)
	onButton(arg_32_0, arg_32_0.finishPanel:Find("bg"), function()
		setActive(arg_32_0.mainPanel, true)
		setActive(arg_32_0.finishPanel, false)

		return
	end, SFX_CANCEL)
	changeToScrollText(arg_32_0.finishPanel:Find("frame/equipment_panel/name_container"), arg_32_2:getConfig("name"))
	setActive(findTF(arg_32_0.finishPanel, "frame/equipment_panel/unique"), arg_32_2:isUnique())
	updateEquipment(arg_32_0.finishPanel:Find("frame/equipment_panel/equiptpl"), arg_32_2)
	arg_32_0:updateAttrs(arg_32_0.finishPanel:Find("frame/equipment_panel/view/content"), arg_32_1, arg_32_2)

	return
end

function var_0_0.willExit(arg_34_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_34_0._tf)

	return
end

return var_0_0
