local var_0_0 = class("ResolveEquipmentLayer", import("..base.BaseUI"))
local var_0_1 = "resolve_equipment_option_all"
local var_0_2 = {
	N = "N",
	SR = "SR",
	SSR = "SSR",
	R = "R"
}
local var_0_3 = {
	[({
		SR = "SR",
		SSR = "SSR",
		ALL = "ALL",
		R = "R",
		N = "N"
	}).N] = {
		1,
		2
	},
	[({
		SR = "SR",
		SSR = "SSR",
		ALL = "ALL",
		R = "R",
		N = "N"
	}).R] = {
		3
	},
	[({
		SR = "SR",
		SSR = "SSR",
		ALL = "ALL",
		R = "R",
		N = "N"
	}).SR] = {
		4
	},
	[({
		SR = "SR",
		SSR = "SSR",
		ALL = "ALL",
		R = "R",
		N = "N"
	}).SSR] = {
		5
	},
	[({
		SR = "SR",
		SSR = "SSR",
		ALL = "ALL",
		R = "R",
		N = "N"
	}).ALL] = {
		1,
		2,
		3,
		4,
		5
	}
}
local var_0_4 = {
	ALL = 3,
	PART = 2,
	NONE = 1,
	GREY = 0
}

function var_0_0.getUIName(arg_1_0)
	return "ResolveEquipmentUI"
end

function var_0_0.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_0.setEquipments(arg_3_0, arg_3_1)
	arg_3_0.equipmentVOs = arg_3_1

	arg_3_0:setEquipmentByIds(arg_3_1)

	return
end

function var_0_0.setEquipmentByIds(arg_4_0, arg_4_1)
	arg_4_0.equipmentVOByIds = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0.equipmentVOByIds[iter_4_1.id] = iter_4_1
	end

	return
end

function var_0_0.init(arg_5_0)
	arg_5_0.mainPanel = arg_5_0._tf:Find("main")

	setActive(arg_5_0.mainPanel, true)
	setText(arg_5_0.mainPanel:Find("top/title_list/infomation/title"), i18n("title_info"))
	setText(arg_5_0.mainPanel:Find("title/Text"), i18n("resolve_equip_tip"))

	arg_5_0.viewRect = arg_5_0._tf:Find("main/frame/view"):GetComponent("LScrollRect")
	arg_5_0.backBtn = arg_5_0._tf:Find("main/top/btnBack")
	arg_5_0.cancelBtn = arg_5_0._tf:Find("main/cancel_btn")

	setText(arg_5_0.cancelBtn:Find("Image"), i18n("text_cancel"))

	arg_5_0.okBtn = arg_5_0._tf:Find("main/ok_btn")

	setText(arg_5_0.okBtn:Find("Image"), i18n("text_confirm"))
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	arg_5_0.selectedIds = {}
	arg_5_0.selectOptions = arg_5_0._tf:Find("main/options")

	setText(arg_5_0.selectOptions:Find("ALL/Label"), i18n("word_equipment_all"))

	arg_5_0.optionStatus = {}
	arg_5_0.destroyConfirm = arg_5_0._tf:Find("destroy_confirm")
	arg_5_0.destroyBonusList = arg_5_0.destroyConfirm:Find("got/scrollview/list")
	arg_5_0.destroyBonusItem = arg_5_0.destroyConfirm:Find("got/scrollview/item")

	setActive(arg_5_0.destroyConfirm, false)
	setActive(arg_5_0.destroyBonusItem, false)
	setText(arg_5_0.destroyConfirm:Find("got/title"), i18n("resolve_equip_title"))
	setText(arg_5_0.destroyConfirm:Find("actions/cancel_button/Image"), i18n("text_cancel"))
	setText(arg_5_0.destroyConfirm:Find("actions/destroy_button/Image"), i18n("text_confirm"))

	arg_5_0.equipDestroyConfirmWindow = EquipDestoryConfirmWindow.New(arg_5_0._tf, arg_5_0.event)

	return
end

function var_0_0.didEnter(arg_6_0)
	arg_6_0:initEquipments()
	onButton(arg_6_0, arg_6_0.backBtn, function()
		arg_6_0:SureExit()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.cancelBtn, function()
		arg_6_0:SureExit()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0.okBtn, function()
		if underscore.any(arg_6_0.selectedIds, function(arg_10_0)
			return arg_6_0.equipmentVOByIds[arg_10_0[1]]:getConfig("rarity") >= 4 or var_10_0:getConfig("level") > 1
		end) then
			table.insert({}, function(arg_11_0)
				arg_6_0.equipDestroyConfirmWindow:Load()
				arg_6_0.equipDestroyConfirmWindow:ActionInvoke("Show", underscore.map(arg_6_0.selectedIds, function(arg_12_0)
					return setmetatable({
						count = arg_12_0[2]
					}, {
						__index = arg_6_0.equipmentVOByIds[arg_12_0[1]]
					})
				end), arg_11_0)

				return
			end)
		end

		seriesAsync({}, function()
			if #arg_6_0.selectedIds <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("err_resloveequip_nochoice"))

				return
			end

			setActive(arg_6_0.mainPanel, false)
			setActive(arg_6_0.destroyConfirm, true)
			arg_6_0:displayDestroyBonus()

			return
		end)

		return
	end, SFX_CONFIRM)
	onButton(arg_6_0, findTF(arg_6_0.destroyConfirm, "actions/cancel_button"), function()
		setActive(arg_6_0.destroyConfirm, false)
		setActive(arg_6_0.mainPanel, true)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0.destroyConfirm, arg_6_0._tf)

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, findTF(arg_6_0.destroyConfirm, "actions/destroy_button"), function()
		seriesAsync({}, function()
			arg_6_0:emit(ResolveEquipmentMediator.ON_RESOLVE, arg_6_0.selectedIds)

			return
		end)

		return
	end, SFX_UI_EQUIPMENT_RESOLVE)
	eachChild(arg_6_0.selectOptions, function(arg_17_0)
		onButton(arg_6_0, arg_17_0, function()
			local var_18_0 = var_0_3[arg_17_0.name]

			switch(arg_6_0.optionStatus[arg_17_0.name], {
				[var_0_4.GREY] = function()
					return
				end,
				[var_0_4.NONE] = function()
					arg_6_0:selAllEquipsByRaritys(var_18_0)

					return
				end,
				[var_0_4.PART] = function()
					arg_6_0:unselAllEquipsByRaritys(var_18_0)

					return
				end,
				[var_0_4.ALL] = function()
					arg_6_0:unselAllEquipsByRaritys(var_18_0)

					return
				end
			})

			return
		end, SFX_CANCEL)

		return
	end)

	return
end

function var_0_0.HideDestroyCondirm(arg_23_0)
	setActive(arg_23_0.destroyConfirm, false)

	return
end

function var_0_0.OnResolveEquipDone(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(var_0_2) do
		if arg_24_0.optionStatus[iter_24_1] == var_0_4.ALL then
			arg_24_0:SetLocalDataByOption(iter_24_1, 1)
		elseif arg_24_0.optionStatus[iter_24_1] == var_0_4.NONE then
			arg_24_0:SetLocalDataByOption(iter_24_1, 0)
		end
	end

	if arg_24_0.optionStatus[var_0.ALL] == var_0_4.ALL then
		arg_24_0:emit(var_0_0.ON_CLOSE)
	else
		setActive(arg_24_0.mainPanel, true)

		for iter_24_2, iter_24_3 in ipairs(arg_24_0.equipmentVOs) do
			local var_24_0 = Clone(iter_24_3)
			local var_24_1 = iter_24_3.count - (function(arg_25_0)
				for iter_25_0, iter_25_1 in ipairs(arg_24_0.selectedIds) do
					if iter_25_1[1] == arg_25_0 then
						return iter_25_1[2]
					end
				end

				return 0
			end)(iter_24_3.id)

			if var_24_1 > 0 then
				var_24_0.count = var_24_1

				table.insert({}, var_24_0)
			end
		end

		arg_24_0:setEquipments({})
		arg_24_0.viewRect:SetTotalCount(#arg_24_0.equipmentVOs, -1)
		arg_24_0:selectedLocalRecordEquipment()
	end

	return
end

function var_0_0.onBackPressed(arg_26_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(arg_26_0.destroyConfirm) then
		triggerButton(findTF(arg_26_0.destroyConfirm, "actions/cancel_button"))
	elseif arg_26_0.equipDestroyConfirmWindow:isShowing() then
		arg_26_0.equipDestroyConfirmWindow:Hide()
	else
		triggerButton(arg_26_0.cancelBtn)
	end

	return
end

function var_0_0.selectedLocalRecordEquipment(arg_27_0)
	arg_27_0.selectedIds = {}

	for iter_27_0, iter_27_1 in pairs(var_0_2) do
		if arg_27_0:GetLocalDataByOption(iter_27_1) == 1 then
			arg_27_0:selAllEquipsByRaritys(var_0_3[iter_27_1])
		end
	end

	arg_27_0:updateSelected()

	return
end

function var_0_0.GetLocalDataByOption(arg_28_0, arg_28_1)
	if (arg_28_1 == var_0.N or arg_28_1 == var_0.R) and not PlayerPrefs.HasKey(arg_28_0.player.id .. var_0_1 .. arg_28_1) then
		arg_28_0:SetLocalDataByOption(arg_28_1, 1)
	end

	return PlayerPrefs.GetInt(arg_28_0.player.id .. var_0_1 .. arg_28_1, 0)
end

function var_0_0.SetLocalDataByOption(arg_29_0, arg_29_1, arg_29_2)
	PlayerPrefs.SetInt(arg_29_0.player.id .. var_0_1 .. arg_29_1, arg_29_2)
	PlayerPrefs.Save()

	return
end

function var_0_0.selAllEquipsByRaritys(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.equipmentVOs) do
		if table.contains(arg_30_1, (iter_30_1:getConfig("rarity"))) then
			arg_30_0:selectEquip(iter_30_1, iter_30_1.count)
		end
	end

	arg_30_0:updateSelected()

	return
end

function var_0_0.unselAllEquipsByRaritys(arg_31_0, arg_31_1)
	arg_31_0.selectedIds = underscore.select(arg_31_0.selectedIds, function(arg_32_0)
		return not table.contains(arg_31_1, (arg_31_0.equipmentVOByIds[arg_32_0[1]]:getConfig("rarity")))
	end)

	arg_31_0:updateSelected()

	return
end

function var_0_0.displayDestroyBonus(arg_33_0)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.selectedIds) do
		if Equipment.CanInBag(iter_33_1[1]) then
			local var_33_1 = Equipment.getConfigData(iter_33_1[1])
			local var_33_2 = var_33_1.destory_item or {}
			local var_33_3 = var_33_1.destory_gold or 0

			var_33_0 = var_33_0 + var_33_3 * iter_33_1[2]

			for iter_33_2, iter_33_3 in ipairs(var_33_2) do
				local var_33_4 = false

				for iter_33_4, iter_33_5 in ipairs({}) do
					if iter_33_3[1] == ({})[iter_33_4].id then
						({})[iter_33_4].count = ({})[iter_33_4].count + iter_33_3[2] * iter_33_1[2]
						var_33_4 = true

						break
					end
				end

				if not var_33_4 then
					table.insert({}, {
						type = DROP_TYPE_ITEM,
						id = iter_33_3[1],
						count = iter_33_3[2] * iter_33_1[2]
					})
				end
			end
		end
	end

	if var_33_0 > 0 then
		table.insert({}, {
			id = 1,
			type = DROP_TYPE_RESOURCE,
			count = var_33_0
		})
	end

	for iter_33_6 = #{}, arg_33_0.destroyBonusList.childCount - 1 do
		Destroy(arg_33_0.destroyBonusList:GetChild(iter_33_6))
	end

	for iter_33_7 = arg_33_0.destroyBonusList.childCount, #{} - 1 do
		cloneTplTo(arg_33_0.destroyBonusItem, arg_33_0.destroyBonusList)
	end

	for iter_33_8 = 1, #{} do
		local var_33_5 = arg_33_0.destroyBonusList:GetChild(iter_33_8 - 1)
		local var_33_6 = ({})[iter_33_8]

		if ({})[iter_33_8].type == DROP_TYPE_SHIP then
			arg_33_0.hasShip = true
		end

		local var_33_7 = var_33_5:Find("icon_bg/icon/icon")

		GetComponent(var_33_5:Find("icon_bg/icon"), typeof(Image)).enabled = true

		if not IsNil(var_33_7) then
			setActive(var_33_7, false)
		end

		updateDrop(var_33_5, ({})[iter_33_8])

		local var_33_8, var_33_9 = contentWrap(({})[iter_33_8]:getConfig("name"), 10, 2)

		if var_33_8 then
			var_33_9 = var_33_9 .. "..."
		end

		setText(var_33_5:Find("name"), var_33_9)
		onButton(arg_33_0, var_33_5, function()
			if var_33_6.type == DROP_TYPE_RESOURCE or var_33_6.type == DROP_TYPE_ITEM then
				arg_33_0:emit(var_0_0.ON_ITEM, var_33_6:getConfig("id"))
			elseif var_33_6.type == DROP_TYPE_EQUIP then
				arg_33_0:emit(var_0_0.ON_EQUIPMENT, {
					equipmentId = var_33_6:getConfig("id"),
					type = EquipmentInfoMediator.TYPE_DISPLAY
				})
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.initEquipments(arg_35_0)
	function arg_35_0.viewRect.onInitItem(arg_36_0)
		arg_35_0:onInitItem(arg_36_0)

		return
	end

	function arg_35_0.viewRect.onUpdateItem(arg_37_0, arg_37_1)
		arg_35_0:onUpdateItem(arg_37_0, arg_37_1)

		return
	end

	function arg_35_0.viewRect.onStart()
		arg_35_0:selectedLocalRecordEquipment()

		return
	end

	arg_35_0.cards = {}

	arg_35_0:filterEquipments()

	return
end

function var_0_0.filterEquipments(arg_39_0)
	arg_39_0:setEquipments((underscore.select(arg_39_0.equipmentVOs, function(arg_40_0)
		return not arg_40_0:isImportance()
	end)))
	table.sort(arg_39_0.equipmentVOs, CompareFuncs({
		function(arg_41_0)
			return -arg_41_0:getConfig("rarity")
		end,
		function(arg_42_0)
			return arg_42_0.id
		end
	}))
	arg_39_0.viewRect:SetTotalCount(#arg_39_0.equipmentVOs, -1)

	return
end

function var_0_0.onInitItem(arg_43_0, arg_43_1)
	local var_43_0 = EquipmentItem.New(arg_43_1)

	onButton(arg_43_0, var_43_0.go, function()
		arg_43_0:selectEquip(var_43_0.equipmentVO, var_43_0.equipmentVO.count)

		return
	end, SFX_PANEL)
	onButton(arg_43_0, var_43_0.reduceBtn, function()
		arg_43_0:selectEquip(var_43_0.equipmentVO, 1)

		return
	end, SFX_PANEL)

	arg_43_0.cards[arg_43_1] = var_43_0

	return
end

function var_0_0.onUpdateItem(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0.cards[arg_46_2]

	if not arg_46_0.cards[arg_46_2] then
		arg_46_0:onInitItem(arg_46_2)

		var_46_0 = arg_46_0.cards[arg_46_2]
	end

	var_46_0:update(arg_46_0.equipmentVOs[arg_46_1 + 1], true)

	local var_46_1 = false
	local var_46_2 = 0

	for iter_46_0, iter_46_1 in pairs(arg_46_0.selectedIds) do
		if var_46_0.equipmentVO.id == iter_46_1[1] then
			var_46_1 = true
			var_46_2 = iter_46_1[2]

			break
		end
	end

	var_46_0:updateSelected(var_46_1, var_46_2)

	return
end

function var_0_0.isSelectedAll(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.equipmentVOByIds) do
		local var_47_0 = false

		for iter_47_2, iter_47_3 in pairs(arg_47_0.selectedIds) do
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

function var_0_0.selectEquip(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_0:checkDestroyGold(arg_48_1, arg_48_2) then
		return
	end

	if arg_48_1:isImportance() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("retire_importantequipment_tips"))

		return
	end

	local var_48_0 = false
	local var_48_1
	local var_48_2 = 0

	for iter_48_0, iter_48_1 in pairs(arg_48_0.selectedIds) do
		if iter_48_1[1] == arg_48_1.id then
			var_48_0 = true
			var_48_1 = iter_48_0
			var_48_2 = iter_48_1[2]

			break
		end
	end

	if not var_48_0 then
		table.insert(arg_48_0.selectedIds, {
			arg_48_1.id,
			arg_48_2
		})
	elseif var_48_2 - arg_48_2 > 0 then
		arg_48_0.selectedIds[var_48_1][2] = var_48_2 - arg_48_2
	else
		table.remove(arg_48_0.selectedIds, var_48_1)
	end

	arg_48_0:updateSelected()

	return
end

function var_0_0.updateSelected(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.cards) do
		if iter_49_1.equipmentVO then
			local var_49_0 = false
			local var_49_1 = 0

			for iter_49_2, iter_49_3 in pairs(arg_49_0.selectedIds) do
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

function var_0_0.updateOptionsStatus(arg_50_0)
	arg_50_0.optionStatus = {}

	for iter_50_0, iter_50_1 in pairs(var_0) do
		local var_50_0 = arg_50_0.selectOptions:Find(iter_50_1)
		local var_50_1 = arg_50_0:GetOptionStatus(iter_50_1)

		arg_50_0.optionStatus[iter_50_1] = var_50_1

		setGray(var_50_0, var_50_1 == var_0_4.GREY, true)

		GetOrAddComponent(var_50_0, "CanvasGroup").alpha = var_50_1 == var_0_4.GREY and 0.4 or 1

		setActive(var_50_0:Find("Background/Checkmark"), var_50_1 == var_0_4.ALL)
		setActive(var_50_0:Find("Background/Part"), var_50_1 == var_0_4.PART)
	end

	return
end

function var_0_0.GetOptionStatus(arg_51_0, arg_51_1)
	local var_51_0 = var_0_3[arg_51_1]
	local var_51_1 = underscore.any(arg_51_0.selectedIds, function(arg_53_0)
		return table.contains(var_51_0, (arg_51_0.equipmentVOByIds[arg_53_0[1]]:getConfig("rarity")))
	end)

	if arg_51_1 == var_0.ALL then
		if #arg_51_0.selectedIds == 0 then
			return var_0_4.NONE
		elseif arg_51_0:isSelectedAll() then
			return var_0_4.ALL
		else
			return var_0_4.PART
		end

		goto label_51_0
	end

	if not underscore.any(arg_51_0.equipmentVOs, function(arg_52_0)
		return table.contains(var_51_0, (arg_52_0:getConfig("rarity")))
	end) then
		return var_0_4.GREY
	end

	::label_51_0::

	if arg_51_0:isSelectedAllRaritys(var_51_0) then
		if not var_0_4.ALL then
			if var_51_1 then
				do return var_0_4.PART or var_0_4.NONE end
				return
			end
		end
	end
end

function var_0_0.isSelectedAllRaritys(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.equipmentVOByIds) do
		if table.contains(arg_54_1, (iter_54_1:getConfig("rarity"))) then
			local var_54_0 = false

			for iter_54_2, iter_54_3 in pairs(arg_54_0.selectedIds) do
				if iter_54_3[1] == iter_54_1.id and iter_54_1.count == iter_54_3[2] then
					var_54_0 = true
				end
			end

			if var_54_0 == false then
				return false
			end
		end
	end

	return true
end

function var_0_0.checkDestroyGold(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = 0
	local var_55_1 = false

	for iter_55_0, iter_55_1 in pairs(arg_55_0.selectedIds) do
		if Equipment.CanInBag(iter_55_1[1]) then
			local var_55_2 = Equipment.getConfigData(iter_55_1[1]).destory_gold or 0

			var_55_0 = var_55_0 + var_55_2 * iter_55_1[2]
		end

		if arg_55_1 and iter_55_1[1] == arg_55_1.configId then
			var_55_1 = true
		end
	end

	if not var_55_1 and arg_55_1 and arg_55_2 > 0 then
		local var_55_3 = arg_55_1:getConfig("destory_gold") or 0

		var_55_0 = var_55_0 + var_55_3 * arg_55_2
	end

	if arg_55_0.player:GoldMax(var_55_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_destroy"))

		return false
	end

	return true
end

function var_0_0.SureExit(arg_56_0)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("sure_exit_resolve_equip"),
		onYes = function()
			arg_56_0:emit(var_0_0.ON_CLOSE)

			return
		end
	})

	return
end

function var_0_0.willExit(arg_58_0)
	arg_58_0.equipDestroyConfirmWindow:Destroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_58_0._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

return var_0_0
