local ResolveEquipmentLayer = class("ResolveEquipmentLayer", import("..base.BaseUI"))
local var_0_1 = "resolve_equipment_option_all"
local var_0_2 = {
	SR = "SR",
	SSR = "SSR",
	ALL = "ALL",
	R = "R",
	N = "N"
}
local var_0_3 = {
	N = "N",
	SR = "SR",
	SSR = "SSR",
	R = "R"
}
local var_0_4 = {
	[var_0_2.N] = {
		1,
		2
	},
	[var_0_2.R] = {
		3
	},
	[var_0_2.SR] = {
		4
	},
	[var_0_2.SSR] = {
		5
	},
	[var_0_2.ALL] = {
		1,
		2,
		3,
		4,
		5
	}
}
local var_0_5 = {
	ALL = 3,
	PART = 2,
	NONE = 1,
	GREY = 0
}

function ResolveEquipmentLayer:getUIName()
	return "ResolveEquipmentUI"
end

function ResolveEquipmentLayer:setPlayer(arg_2_1)
	self.player = arg_2_1

	return
end

function ResolveEquipmentLayer:setEquipments(arg_3_1)
	self.equipmentVOs = arg_3_1

	self:setEquipmentByIds(arg_3_1)

	return
end

function ResolveEquipmentLayer:setEquipmentByIds(arg_4_1)
	self.equipmentVOByIds = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		self.equipmentVOByIds[iter_4_1.id] = iter_4_1
	end

	return
end

function ResolveEquipmentLayer:init()
	self.mainPanel = self._tf:Find("main")

	setActive(self.mainPanel, true)
	setText(self.mainPanel:Find("top/title_list/infomation/title"), i18n("title_info"))
	setText(self.mainPanel:Find("title/Text"), i18n("resolve_equip_tip"))

	self.viewRect = self._tf:Find("main/frame/view"):GetComponent("LScrollRect")
	self.backBtn = self._tf:Find("main/top/btnBack")
	self.cancelBtn = self._tf:Find("main/cancel_btn")

	setText(self.cancelBtn:Find("Image"), i18n("text_cancel"))

	self.okBtn = self._tf:Find("main/ok_btn")

	setText(self.okBtn:Find("Image"), i18n("text_confirm"))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.selectedIds = {}
	self.selectOptions = self._tf:Find("main/options")

	setText(self.selectOptions:Find("ALL/Label"), i18n("word_equipment_all"))

	self.optionStatus = {}
	self.destroyConfirm = self._tf:Find("destroy_confirm")
	self.destroyBonusList = self.destroyConfirm:Find("got/scrollview/list")
	self.destroyBonusItem = self.destroyConfirm:Find("got/scrollview/item")

	setActive(self.destroyConfirm, false)
	setActive(self.destroyBonusItem, false)
	setText(self.destroyConfirm:Find("got/title"), i18n("resolve_equip_title"))
	setText(self.destroyConfirm:Find("actions/cancel_button/Image"), i18n("text_cancel"))
	setText(self.destroyConfirm:Find("actions/destroy_button/Image"), i18n("text_confirm"))

	self.equipDestroyConfirmWindow = EquipDestoryConfirmWindow.New(self._tf, self.event)

	return
end

function ResolveEquipmentLayer:didEnter()
	self:initEquipments()
	onButton(self, self.backBtn, function()
		self:SureExit()

		return
	end, SFX_CANCEL)
	onButton(self, self.cancelBtn, function()
		self:SureExit()

		return
	end, SFX_CANCEL)
	onButton(self, self.okBtn, function()
		local var_9_0 = {}

		if underscore.any(self.selectedIds, function(arg_10_0)
			return self.equipmentVOByIds[arg_10_0[1]]:getConfig("rarity") >= 4 or self.equipmentVOByIds[arg_10_0[1]]:getConfig("level") > 1
		end) then
			table.insert(var_9_0, function(arg_11_0)
				self.equipDestroyConfirmWindow:Load()
				self.equipDestroyConfirmWindow:ActionInvoke("Show", underscore.map(self.selectedIds, function(arg_12_0)
					return setmetatable({
						count = arg_12_0[2]
					}, {
						__index = self.equipmentVOByIds[arg_12_0[1]]
					})
				end), arg_11_0)

				return
			end)
		end

		seriesAsync(var_9_0, function()
			if #self.selectedIds <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("err_resloveequip_nochoice"))

				return
			end

			setActive(self.mainPanel, false)
			setActive(self.destroyConfirm, true)
			self:displayDestroyBonus()

			return
		end)

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.destroyConfirm, "actions/cancel_button"), function()
		setActive(self.destroyConfirm, false)
		setActive(self.mainPanel, true)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.destroyConfirm, self._tf)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.destroyConfirm, "actions/destroy_button"), function()
		seriesAsync({}, function()
			self:emit(ResolveEquipmentMediator.ON_RESOLVE, self.selectedIds)

			return
		end)

		return
	end, SFX_UI_EQUIPMENT_RESOLVE)
	eachChild(self.selectOptions, function(arg_17_0)
		onButton(self, arg_17_0, function()
			local var_18_0 = var_0_4[arg_17_0.name]

			switch(self.optionStatus[arg_17_0.name], {
				[var_0_5.GREY] = function()
					return
				end,
				[var_0_5.NONE] = function()
					self:selAllEquipsByRaritys(var_18_0)

					return
				end,
				[var_0_5.PART] = function()
					self:unselAllEquipsByRaritys(var_18_0)

					return
				end,
				[var_0_5.ALL] = function()
					self:unselAllEquipsByRaritys(var_18_0)

					return
				end
			})

			return
		end, SFX_CANCEL)

		return
	end)

	return
end

function ResolveEquipmentLayer:HideDestroyCondirm()
	setActive(self.destroyConfirm, false)

	return
end

function ResolveEquipmentLayer:OnResolveEquipDone()
	for iter_24_0, iter_24_1 in pairs(var_0_3) do
		if self.optionStatus[iter_24_1] == var_0_5.ALL then
			self:SetLocalDataByOption(iter_24_1, 1)
		elseif self.optionStatus[iter_24_1] == var_0_5.NONE then
			self:SetLocalDataByOption(iter_24_1, 0)
		end
	end

	if self.optionStatus[var_0_2.ALL] == var_0_5.ALL then
		self:emit(ResolveEquipmentLayer.ON_CLOSE)
	else
		setActive(self.mainPanel, true)

		local function var_24_0(arg_25_0)
			for iter_25_0, iter_25_1 in ipairs(self.selectedIds) do
				if iter_25_1[1] == arg_25_0 then
					return iter_25_1[2]
				end
			end

			return 0
		end

		local var_24_1 = {}

		for iter_24_2, iter_24_3 in ipairs(self.equipmentVOs) do
			local var_24_2 = Clone(iter_24_3)
			local var_24_3 = iter_24_3.count - var_24_0(iter_24_3.id)

			if var_24_3 > 0 then
				var_24_2.count = var_24_3

				table.insert(var_24_1, var_24_2)
			end
		end

		self:setEquipments(var_24_1)
		self.viewRect:SetTotalCount(#self.equipmentVOs, -1)
		self:selectedLocalRecordEquipment()
	end

	return
end

function ResolveEquipmentLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if isActive(self.destroyConfirm) then
		triggerButton(findTF(self.destroyConfirm, "actions/cancel_button"))
	elseif self.equipDestroyConfirmWindow:isShowing() then
		self.equipDestroyConfirmWindow:Hide()
	else
		triggerButton(self.cancelBtn)
	end

	return
end

function ResolveEquipmentLayer:selectedLocalRecordEquipment()
	self.selectedIds = {}

	for iter_27_0, iter_27_1 in pairs(var_0_3) do
		if self:GetLocalDataByOption(iter_27_1) == 1 then
			self:selAllEquipsByRaritys(var_0_4[iter_27_1])
		end
	end

	self:updateSelected()

	return
end

function ResolveEquipmentLayer:GetLocalDataByOption(arg_28_1)
	if (arg_28_1 == var_0_2.N or arg_28_1 == var_0_2.R) and not PlayerPrefs.HasKey(self.player.id .. var_0_1 .. arg_28_1) then
		self:SetLocalDataByOption(arg_28_1, 1)
	end

	return PlayerPrefs.GetInt(self.player.id .. var_0_1 .. arg_28_1, 0)
end

function ResolveEquipmentLayer:SetLocalDataByOption(arg_29_1, arg_29_2)
	PlayerPrefs.SetInt(self.player.id .. var_0_1 .. arg_29_1, arg_29_2)
	PlayerPrefs.Save()

	return
end

function ResolveEquipmentLayer:selAllEquipsByRaritys(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(self.equipmentVOs) do
		if table.contains(arg_30_1, (iter_30_1:getConfig("rarity"))) then
			self:selectEquip(iter_30_1, iter_30_1.count)
		end
	end

	self:updateSelected()

	return
end

function ResolveEquipmentLayer:unselAllEquipsByRaritys(arg_31_1)
	self.selectedIds = underscore.select(self.selectedIds, function(arg_32_0)
		return not table.contains(arg_31_1, (self.equipmentVOByIds[arg_32_0[1]]:getConfig("rarity")))
	end)

	self:updateSelected()

	return
end

function ResolveEquipmentLayer:displayDestroyBonus()
	local var_33_0 = {}
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in ipairs(self.selectedIds) do
		if Equipment.CanInBag(iter_33_1[1]) then
			local var_33_2 = Equipment.getConfigData(iter_33_1[1])

			var_33_1 = var_33_1 + (var_33_2.destory_gold or 0) * iter_33_1[2]

			for iter_33_2, iter_33_3 in ipairs(var_33_2.destory_item or {}) do
				local var_33_3 = false

				for iter_33_4, iter_33_5 in ipairs(var_33_0) do
					if iter_33_3[1] == var_33_0[iter_33_4].id then
						var_33_0[iter_33_4].count = var_33_0[iter_33_4].count + iter_33_3[2] * iter_33_1[2]
						var_33_3 = true

						break
					end
				end

				if not var_33_3 then
					table.insert(var_33_0, {
						type = DROP_TYPE_ITEM,
						id = iter_33_3[1],
						count = iter_33_3[2] * iter_33_1[2]
					})
				end
			end
		end
	end

	if var_33_1 > 0 then
		table.insert(var_33_0, {
			id = 1,
			type = DROP_TYPE_RESOURCE,
			count = var_33_1
		})
	end

	for iter_33_6 = #var_33_0, self.destroyBonusList.childCount - 1 do
		Destroy(self.destroyBonusList:GetChild(iter_33_6))
	end

	for iter_33_7 = self.destroyBonusList.childCount, #var_33_0 - 1 do
		cloneTplTo(self.destroyBonusItem, self.destroyBonusList)
	end

	for iter_33_8 = 1, #var_33_0 do
		local var_33_4 = self.destroyBonusList:GetChild(iter_33_8 - 1)
		local var_33_5 = var_33_0[iter_33_8]

		if var_33_0[iter_33_8].type == DROP_TYPE_SHIP then
			self.hasShip = true
		end

		local var_33_6 = var_33_4:Find("icon_bg/icon/icon")

		GetComponent(var_33_4:Find("icon_bg/icon"), typeof(Image)).enabled = true

		if not IsNil(var_33_6) then
			setActive(var_33_6, false)
		end

		updateDrop(var_33_4, var_33_0[iter_33_8])

		local var_33_7, var_33_8 = contentWrap(var_33_0[iter_33_8]:getConfig("name"), 10, 2)

		if var_33_7 then
			var_33_8 = var_33_8 .. "..."
		end

		setText(var_33_4:Find("name"), var_33_8)
		onButton(self, var_33_4, function()
			if var_33_5.type == DROP_TYPE_RESOURCE or var_33_5.type == DROP_TYPE_ITEM then
				self:emit(ResolveEquipmentLayer.ON_ITEM, var_33_5:getConfig("id"))
			elseif var_33_5.type == DROP_TYPE_EQUIP then
				self:emit(ResolveEquipmentLayer.ON_EQUIPMENT, {
					equipmentId = var_33_5:getConfig("id"),
					type = EquipmentInfoMediator.TYPE_DISPLAY
				})
			end

			return
		end, SFX_PANEL)
	end

	return
end

function ResolveEquipmentLayer:initEquipments()
	function self.viewRect.onInitItem(arg_36_0)
		self:onInitItem(arg_36_0)

		return
	end

	function self.viewRect.onUpdateItem(arg_37_0, arg_37_1)
		self:onUpdateItem(arg_37_0, arg_37_1)

		return
	end

	function self.viewRect.onStart()
		self:selectedLocalRecordEquipment()

		return
	end

	self.cards = {}

	self:filterEquipments()

	return
end

function ResolveEquipmentLayer:filterEquipments()
	self:setEquipments((underscore.select(self.equipmentVOs, function(arg_40_0)
		return not arg_40_0:isImportance()
	end)))
	table.sort(self.equipmentVOs, CompareFuncs({
		function(arg_41_0)
			return -arg_41_0:getConfig("rarity")
		end,
		function(arg_42_0)
			return arg_42_0.id
		end
	}))
	self.viewRect:SetTotalCount(#self.equipmentVOs, -1)

	return
end

function ResolveEquipmentLayer:onInitItem(arg_43_1)
	local var_43_0 = EquipmentItem.New(arg_43_1)

	onButton(self, var_43_0.go, function()
		self:selectEquip(var_43_0.equipmentVO, var_43_0.equipmentVO.count)

		return
	end, SFX_PANEL)
	onButton(self, var_43_0.reduceBtn, function()
		self:selectEquip(var_43_0.equipmentVO, 1)

		return
	end, SFX_PANEL)

	self.cards[arg_43_1] = var_43_0

	return
end

function ResolveEquipmentLayer:onUpdateItem(arg_46_1, arg_46_2)
	local var_46_0 = self.cards[arg_46_2]

	if not self.cards[arg_46_2] then
		self:onInitItem(arg_46_2)

		var_46_0 = self.cards[arg_46_2]
	end

	var_46_0:update(self.equipmentVOs[arg_46_1 + 1], true)

	local var_46_1 = false
	local var_46_2 = 0

	for iter_46_0, iter_46_1 in pairs(self.selectedIds) do
		if var_46_0.equipmentVO.id == iter_46_1[1] then
			var_46_1 = true
			var_46_2 = iter_46_1[2]

			break
		end
	end

	var_46_0:updateSelected(var_46_1, var_46_2)

	return
end

function ResolveEquipmentLayer:isSelectedAll()
	for iter_47_0, iter_47_1 in pairs(self.equipmentVOByIds) do
		local var_47_0 = false

		for iter_47_2, iter_47_3 in pairs(self.selectedIds) do
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

function ResolveEquipmentLayer:selectEquip(arg_48_1, arg_48_2)
	if not self:checkDestroyGold(arg_48_1, arg_48_2) then
		return
	end

	if arg_48_1:isImportance() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("retire_importantequipment_tips"))

		return
	end

	local var_48_0 = false
	local var_48_1
	local var_48_2 = 0

	for iter_48_0, iter_48_1 in pairs(self.selectedIds) do
		if iter_48_1[1] == arg_48_1.id then
			var_48_0 = true
			var_48_1 = iter_48_0
			var_48_2 = iter_48_1[2]

			break
		end
	end

	if not var_48_0 then
		table.insert(self.selectedIds, {
			arg_48_1.id,
			arg_48_2
		})
	elseif var_48_2 - arg_48_2 > 0 then
		self.selectedIds[var_48_1][2] = var_48_2 - arg_48_2
	else
		table.remove(self.selectedIds, var_48_1)
	end

	self:updateSelected()

	return
end

function ResolveEquipmentLayer:updateSelected()
	for iter_49_0, iter_49_1 in pairs(self.cards) do
		if iter_49_1.equipmentVO then
			local var_49_0 = false
			local var_49_1 = 0

			for iter_49_2, iter_49_3 in pairs(self.selectedIds) do
				if iter_49_1.equipmentVO.id == iter_49_3[1] then
					var_49_0 = true
					var_49_1 = iter_49_3[2]

					break
				end
			end

			iter_49_1:updateSelected(var_49_0, var_49_1)
		end
	end

	self:updateOptionsStatus()

	return
end

function ResolveEquipmentLayer:updateOptionsStatus()
	self.optionStatus = {}

	for iter_50_0, iter_50_1 in pairs(var_0_2) do
		local var_50_0 = self.selectOptions:Find(iter_50_1)
		local var_50_1 = self:GetOptionStatus(iter_50_1)

		self.optionStatus[iter_50_1] = var_50_1

		setGray(var_50_0, var_50_1 == var_0_5.GREY, true)

		GetOrAddComponent(var_50_0, "CanvasGroup").alpha = var_50_1 == var_0_5.GREY and 0.4 or 1

		setActive(var_50_0:Find("Background/Checkmark"), var_50_1 == var_0_5.ALL)
		setActive(var_50_0:Find("Background/Part"), var_50_1 == var_0_5.PART)
	end

	return
end

function ResolveEquipmentLayer:GetOptionStatus(arg_51_1)
	if arg_51_1 == var_0_2.ALL then
		if #self.selectedIds == 0 then
			return var_0_5.NONE
		elseif self:isSelectedAll() then
			return var_0_5.ALL
		else
			return var_0_5.PART
		end
	else
		local var_51_0 = var_0_4[arg_51_1]

		if not underscore.any(self.equipmentVOs, function(arg_52_0)
			return table.contains(var_51_0, (arg_52_0:getConfig("rarity")))
		end) then
			return var_0_5.GREY
		end

		local var_51_1

		if self:isSelectedAllRaritys(var_51_0) then
			var_51_1 = var_0_5.ALL

			if not var_0_5.ALL then
				if underscore.any(self.selectedIds, function(arg_53_0)
					return table.contains(var_51_0, (self.equipmentVOByIds[arg_53_0[1]]:getConfig("rarity")))
				end) then
					var_51_1 = var_0_5.PART or var_0_5.NONE
				end
			end
		end

		return var_51_1
	end

	return
end

function ResolveEquipmentLayer:isSelectedAllRaritys(arg_54_1)
	for iter_54_0, iter_54_1 in pairs(self.equipmentVOByIds) do
		if table.contains(arg_54_1, (iter_54_1:getConfig("rarity"))) then
			local var_54_0 = false

			for iter_54_2, iter_54_3 in pairs(self.selectedIds) do
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

function ResolveEquipmentLayer:checkDestroyGold(arg_55_1, arg_55_2)
	local var_55_0 = 0
	local var_55_1 = false

	for iter_55_0, iter_55_1 in pairs(self.selectedIds) do
		if Equipment.CanInBag(iter_55_1[1]) then
			var_55_0 = var_55_0 + (Equipment.getConfigData(iter_55_1[1]).destory_gold or 0) * iter_55_1[2]
		end

		if arg_55_1 and iter_55_1[1] == arg_55_1.configId then
			var_55_1 = true
		end
	end

	if not var_55_1 and arg_55_1 and arg_55_2 > 0 then
		var_55_0 = var_55_0 + (arg_55_1:getConfig("destory_gold") or 0) * arg_55_2
	end

	if self.player:GoldMax(var_55_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_destroy"))

		return false
	end

	return true
end

function ResolveEquipmentLayer:SureExit()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("sure_exit_resolve_equip"),
		onYes = function()
			self:emit(ResolveEquipmentLayer.ON_CLOSE)

			return
		end
	})

	return
end

function ResolveEquipmentLayer:willExit()
	self.equipDestroyConfirmWindow:Destroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

return ResolveEquipmentLayer
