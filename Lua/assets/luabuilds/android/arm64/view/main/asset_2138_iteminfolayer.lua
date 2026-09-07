local ItemInfoLayer = class("ItemInfoLayer", import("..base.BaseUI"))
local var_0_3 = 100
local var_0_4 = 53996
local var_0_5 = {
	USE = 3,
	USE_RE_MAP = 4,
	RESOLVE = 2,
	COMPOSE = 1
}

function ItemInfoLayer:getUIName()
	return "ItemInfoUI"
end

function ItemInfoLayer:init()
	self:BlurPanel(self._tf)

	self.window = self._tf:Find("window")

	setText(self.window:Find("top/bg/infomation/title"), i18n("words_information"))

	self.btnContent = self.window:Find("actions")

	eachChild(self.btnContent, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	for iter_2_0, iter_2_1 in pairs({
		okBtn = {
			"ok_button",
			i18n("msgbox_text_confirm")
		},
		useBtn = {
			"use_button"
		},
		batchUseBtn = {
			"batch_use_button"
		},
		useOneBtn = {
			"use_one_button"
		},
		composeBtn = {
			"compose_button"
		},
		reMapUseBtn = {
			"re_map_use_button",
			i18n("msgbox_text_use")
		},
		resolveBtn = {
			"resolve_button",
			i18n("msgbox_text_analyse")
		},
		loveRepairBtn = {
			"love_lettle_repair_button",
			i18n("loveletter_exchange_button")
		},
		metaskillBtn = {
			"metaskill_use_btn",
			i18n("msgbox_text_use")
		},
		blueBtn = {
			"blue_btn"
		},
		yellowBtn = {
			"yellow_btn"
		},
		recycleBtn = {
			"recycle_btn",
			i18n("recycle_btn_label")
		},
		skinShopBtn = {
			"skin_shop_btn",
			i18n("go_skinshop_btn_label")
		},
		skinExperienceShopBtn = {
			"skin_experience_shop_btn",
			i18n("go_skinexperienceshop_btn_label")
		}
	}) do
		local var_2_0, var_2_1 = unpack(iter_2_1)

		self[iter_2_0] = self.btnContent:Find(var_2_0)

		if var_2_1 then
			setText(self[iter_2_0]:Find("pic"), var_2_1)
		end
	end

	self.itemTF = self.window:Find("item")
	self.operatePanel = self._tf:Find("operate")
	self.countTF = self.operatePanel:Find("item/left/own/Text"):GetComponent(typeof(Text))
	self.keepFateTog = self.operatePanel:Find("got/keep_tog")

	setText(self.keepFateTog:Find("label"), i18n("keep_fate_tip"))

	self.operateBtns = {}
	self.operateBtns.Confirm = self.operatePanel:Find("actions/confirm_button")
	self.operateBtns.Cancel = self.operatePanel:Find("actions/cancel_button")
	self.operateBtns.Resolve = self.operatePanel:Find("actions/resolve_button")

	setText(self.operateBtns.Confirm:Find("label"), i18n("msgbox_text_confirm"))
	setText(self.operateBtns.Cancel:Find("label"), i18n("msgbox_text_cancel"))
	setText(self.operateBtns.Resolve:Find("label"), i18n("msgbox_text_analyse"))
	SetActive(self.operatePanel, false)
	SetActive(self.window, true)

	self.operateMode = nil
	self.operateBonusList = self.operatePanel:Find("got/panel_bg/list")
	self.operateBonusTpl = self.operatePanel:Find("got/panel_bg/list/item")
	self.operateCountdesc = self.operatePanel:Find("count/image_text")
	self.operateValue = self.operatePanel:Find("count/number_panel/value")
	self.operateValueInput = self.operatePanel:Find("count/number_panel/InputField")
	self.operateLeftButton = self.operatePanel:Find("count/number_panel/left")
	self.operateRightButton = self.operatePanel:Find("count/number_panel/right")
	self.operateMaxButton = self.operatePanel:Find("count/max")
	self.recycleConfirmationPage = ItemRecycleConfirmationPage.New(pg.UIMgr.GetInstance().OverlayMain)

	self.recycleConfirmationPage:SetCallback(function()
		setActive(self._tf, false)

		return
	end, function()
		setActive(self._tf, true)

		return
	end)

	return
end

function ItemInfoLayer:getButton(arg_6_1, arg_6_2)
	self[arg_6_1] = self[arg_6_1] or cloneTplTo(arg_6_2, self.btnContent)

	setActive(self[arg_6_1], true)

	return self[arg_6_1]
end

function ItemInfoLayer:setDrop(arg_7_1)
	if arg_7_1.type == DROP_TYPE_SHIP then
		self:setItemInfo(arg_7_1, self.itemTF)
	elseif arg_7_1.type == DROP_TYPE_ITEM then
		arg_7_1.count = getProxy(BagProxy):getItemCountById(arg_7_1.id)

		self:setItem(arg_7_1)
	else
		assert(false, "do not support current kind of type: " .. arg_7_1.type)
	end

	return
end

function ItemInfoLayer:setItemInfo(arg_8_1, arg_8_2)
	updateDrop(arg_8_2:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = arg_8_1
	}))
	UpdateOwnDisplay(arg_8_2:Find("left/own"), arg_8_1)
	RegisterDetailButton(self, arg_8_2:Find("left/detail"), arg_8_1)
	setText(arg_8_2:Find("display_panel/name_container/name/Text"), arg_8_1:getConfig("name"))
	setText(arg_8_2:Find("display_panel/desc/Text"), arg_8_1.desc)

	local var_8_0 = arg_8_2:Find("display_panel/name_container/shiptype")

	setActive(var_8_0, arg_8_1.type == DROP_TYPE_SHIP)

	if arg_8_1.type == DROP_TYPE_SHIP then
		GetImageSpriteFromAtlasAsync("shiptype", shipType2print(arg_8_1:getConfig("type")), var_8_0, false)
	end

	return
end

function ItemInfoLayer:updateItemCount(arg_9_1)
	self.countTF.text = arg_9_1

	return
end

function ItemInfoLayer:setItem(arg_10_1)
	self:setItemInfo(arg_10_1, self.itemTF)

	self.itemVO = arg_10_1:getSubClass()

	if not Item.CanInBag(self.itemVO.id) then
		return
	end

	local var_10_0 = self.itemVO:getConfig("compose_number")

	if var_10_0 > 0 and var_10_0 <= self.itemVO.count then
		self:setItemInfo(arg_10_1, self.operatePanel:Find("item"))

		self.operateMax = self.itemVO.count / var_10_0

		setActive(self.composeBtn, true)
	end

	if self.itemVO:getConfig("usage") == ItemUsage.SOS then
		setText(self.useBtn:Find("text"), 1)
		setActive(self.useBtn, true)
	end

	if self.itemVO:getConfig("usage") == ItemUsage.EX_RE_MAP then
		self:setItemInfo(arg_10_1, self.operatePanel:Find("item"))

		self.operateMax = self.itemVO.count
	end

	local var_10_1 = self.itemVO:getConfig("type")

	if self.itemVO:IsRepairLoveLetterItem() then
		onButton(self, self.loveRepairBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("loveletter2018_ui_1"),
				onYes = function()
					self:emit(ItemInfoMediator.REPAIR_LOVE_LETTER_ITEM, self.itemVO)

					return
				end
			})

			return
		end, SFX_PANEL)
		setActive(self.loveRepairBtn, true)
		setActive(self.okBtn, false)
	elseif Item.IsLoveLetterCheckItem(self.itemVO.id) then
		local var_10_2 = self.itemVO.extra or pg.loveletter_2018_2021[self.itemVO.id].ship_group_id
		local var_10_3 = self:getButton("checkMail", self.blueBtn)

		setText(var_10_3:Find("pic"), i18n("loveletter_recover_bottom1"))
		onButton(self, var_10_3, function()
			self:emit(ItemInfoMediator.CHECK_LOVE_LETTER_MAIL, self.itemVO.id, var_10_2)

			return
		end, SFX_CONFIRM)

		local var_10_4 = self:getButton("repairMail", self.yellowBtn)

		setText(var_10_4:Find("pic"), i18n("loveletter_recover_bottom2"))

		local var_10_5 = getProxy(BagProxy):GetLoveLetterRepairInfo(self.itemVO.id .. "_" .. var_10_2)

		onButton(self, var_10_4, function()
			if not var_10_5 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip1"))
			elseif #var_10_5 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip3"))
			elseif #var_10_5 == 1 then
				local var_14_0 = var_10_5[1]
				local var_14_1 = {
					delayConfirm = 3
				}

				var_14_1.content = i18n("loveletter_recover_text1", var_10_5[1], ShipGroup.New({
					id = var_10_2
				}):getName())

				function var_14_1.onYes()
					self:emit(ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL, self.itemVO.id, var_14_0, var_10_2)

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox(var_14_1)
			else
				table.sort(var_10_5)

				local var_14_2 = {
					hideYes = true
				}

				var_14_2.content = i18n("loveletter_recover_text2", ShipGroup.New({
					id = var_10_2
				}):getName())
				var_14_2.custom = underscore.map(var_10_5, function(arg_16_0)
					return {
						delayButton = 3,
						text = i18n("loveletter_recover_bottom3", arg_16_0),
						sound = SFX_CONFIRM,
						onCallback = function()
							self:emit(ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL, self.itemVO.id, arg_16_0, var_10_2)

							return
						end,
						btnType = pg.MsgboxMgr.BUTTON_YELLOW
					}
				end)

				pg.MsgboxMgr.GetInstance():ShowMsgBox(var_14_2)
			end

			return
		end, SFX_PANEL)
		setGray(var_10_4, not var_10_5 or #var_10_5 == 0)
	elseif self.itemVO:getConfig("type") == Item.EQUIPMENT_BOX_TYPE_5 then
		self:setItemInfo(arg_10_1, self.operatePanel:Find("item"))
		setActive(self.useOneBtn, true)
		onButton(self, self.useOneBtn, function()
			SetActive(self.operatePanel, true)
			SetActive(self.window, false)

			self.operateMode = var_0_5.USE

			self:SetOperateCount(1)

			return
		end, SFX_PANEL)
	elseif self.itemVO:CanOpen() then
		setText(self.useBtn:Find("text"), 1)
		setActive(self.useBtn, true)

		if self.itemVO.count > 1 then
			setText(self.batchUseBtn:Find("text"), math.min(self.itemVO.count, 10))
			setActive(self.batchUseBtn, true)
		end
	elseif var_10_1 == Item.BLUEPRINT_TYPE then
		local var_10_6 = getProxy(TechnologyProxy)
		local var_10_7 = var_10_6:GetBlueprint4Item(self.itemVO.id)

		if not LOCK_FRAGMENT_SHOP and var_10_7 then
			if var_10_6:getBluePrintById(var_10_7):isMaxLevel() then
				setActive(self.resolveBtn, true)
				self:UpdateBlueprintResolveNum()
			end
		end

		self:setItemInfo(arg_10_1, self.operatePanel:Find("item"))
		setActive(self.okBtn, true)
	elseif var_10_1 == Item.TEC_SPEEDUP_TYPE then
		setActive(self.resolveBtn, true)
		self:UpdateSpeedUpResolveNum()
		self:setItemInfo(arg_10_1, self.operatePanel:Find("item"))
		setActive(self.okBtn, true)
	elseif var_10_1 == Item.LOVE_LETTER_TYPE then
		setActive(self.loveRepairBtn, false)
		setActive(self.okBtn, true)
	elseif var_10_1 == Item.METALESSON_TYPE then
		setActive(self.metaskillBtn, true)
		onButton(self, self.metaskillBtn, function()
			self:closeView()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER)

			return
		end, SFX_PANEL)
		setActive(self.okBtn, true)
	elseif var_10_1 == Item.SKIN_ASSIGNED_TYPE then
		setActive(self.useOneBtn, self.contextData.confirmCall)
		onButton(self, self.useOneBtn, function()
			self.contextData.confirmCall()
			self:closeView()

			return
		end, SFX_PANEL)
		setActive(self.okBtn, true)
	elseif self.itemVO:IsExclusiveDiscountType() then
		setActive(self.recycleBtn, true)
		setActive(self.skinShopBtn, true)
	elseif self.itemVO:IsSkinExperienceType() then
		setActive(self.skinExperienceShopBtn, true)
	elseif self.itemVO:getConfig("usage") == ItemUsage.EX_RE_MAP then
		setActive(self.resolveBtn, true)
		setActive(self.reMapUseBtn, true)
		onButton(self, self.reMapUseBtn, function()
			self:UpdateUseReMapPanel()

			return
		end, SFX_PANEL)
	else
		setActive(self.okBtn, true)
	end

	return
end

function ItemInfoLayer:closeView()
	if self.playing then
		return
	end

	ItemInfoLayer.super.closeView(self)

	return
end

function ItemInfoLayer:didEnter()
	local var_23_0 = self._tf:Find("OpenBox(Clone)")

	if var_23_0 then
		SetActive(var_23_0, false)
	end

	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.okBtn, function()
		self:closeView()

		return
	end, SFX_CONFIRM)
	onButton(self, self.useBtn, function()
		self:emit(ItemInfoMediator.USE_ITEM, self.itemVO.id, 1)

		return
	end, SFX_CONFIRM)
	onButton(self, self.batchUseBtn, function()
		self:emit(ItemInfoMediator.USE_ITEM, self.itemVO.id, math.min(self.itemVO.count, 10))

		return
	end, SFX_CONFIRM)
	onButton(self, self.composeBtn, function()
		SetActive(self.operatePanel, true)
		SetActive(self.window, false)

		self.operateMode = var_0_5.COMPOSE

		self:SetOperateCount(1)

		return
	end, SFX_CONFIRM)
	onButton(self, self.resolveBtn, function()
		SetActive(self.operatePanel, true)
		SetActive(self.window, false)

		self.operateMode = var_0_5.RESOLVE

		self:SetOperateCount(1)

		return
	end, SFX_PANEL)
	pressPersistTrigger(self.operateLeftButton, 0.5, function(arg_31_0)
		if not self:UpdateCount(self.operateCount - 1) then
			arg_31_0()

			return
		end

		self:SetOperateCount(self.operateCount - 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.operateRightButton, 0.5, function(arg_32_0)
		if not self:UpdateCount(self.operateCount + 1) then
			arg_32_0()

			return
		end

		self:SetOperateCount(self.operateCount + 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.operateMaxButton, function()
		self:SetOperateCount(self.operateMax)

		return
	end, SFX_PANEL)
	onInputEndEdit(self, self.operateValueInput, function(arg_34_0)
		local var_34_0 = math.max(1, (math.min(var_0_3, math.min(tonumber(arg_34_0) or 1, self.operateMax))))

		self:SetOperateCount(var_34_0)

		if arg_34_0 ~= tostring(var_34_0) then
			setInputText(self.operateValueInput, var_34_0)
		end

		return
	end)

	local var_23_1 = self.itemVO:getConfig("type") == Item.EQUIPMENT_BOX_TYPE_5

	setActive(self.operateValueInput, var_23_1)
	setActive(self.operateValue, not var_23_1)
	onButton(self, self.operateBtns.Cancel, function()
		SetActive(self.operatePanel, false)
		SetActive(self.window, true)

		self.operateCount = 0
		self.operateMode = nil

		return
	end, SFX_CANCEL)
	onButton(self, self.operateBtns.Confirm, function()
		if self.operateMode == var_0_5.COMPOSE then
			self:emit(ItemInfoMediator.COMPOSE_ITEM, self.itemVO.id, self.operateCount)

			local var_36_0 = self.itemVO:getConfig("compose_number")

			if var_36_0 > self.itemVO.count - self.operateCount * var_36_0 then
				triggerButton(self.operateBtns.Cancel)
			else
				self:SetOperateCount(1)
			end
		elseif self.operateMode == var_0_5.USE then
			self:emit(ItemInfoMediator.USE_ITEM, self.itemVO.id, self.operateCount)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.recycleBtn, function()
		local var_37_0 = self.itemVO:GetPrice() or {
			0,
			0
		}

		self.recycleConfirmationPage:ExecuteAction("Show", {
			content = i18n("skin_discount_item_recycle_tip", self.itemVO:getName(), var_37_0[2]),
			itemId = self.itemVO.id
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self.skinShopBtn, function()
		self:closeView()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_CONFIRM)
	onButton(self, self.skinExperienceShopBtn, function()
		self:closeView()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP, {
			mode = NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM
		})

		return
	end, SFX_CONFIRM)
	onButton(self, self.operateBtns.Resolve, function()
		self:emit(ItemInfoMediator.SELL_BLUEPRINT, Drop.New({
			type = DROP_TYPE_ITEM,
			id = self.itemVO.id,
			count = self.operateCount
		}))

		return
	end, SFX_CONFIRM)

	self.keepFateState = not getProxy(PlayerProxy):getData():GetCommonFlag(SHOW_DONT_KEEP_FATE_ITEM)
	GetComponent(self.keepFateTog, typeof(Toggle)).isOn = self.keepFateState

	local function var_23_2()
		self:UpdateBlueprintResolveNum()
		self:SetOperateCount(1)

		return
	end

	onToggle(self, self.keepFateTog, function(arg_42_0)
		self.keepFateState = arg_42_0

		if arg_42_0 then
			pg.m02:sendNotification(GAME.CANCEL_COMMON_FLAG, {
				flagID = SHOW_DONT_KEEP_FATE_ITEM
			})
		else
			pg.m02:sendNotification(GAME.COMMON_FLAG, {
				flagID = SHOW_DONT_KEEP_FATE_ITEM
			})
		end

		var_23_2()

		return
	end)
	var_23_2()

	return
end

function ItemInfoLayer:UpdateCount(arg_43_1)
	if self.operateMode == var_0_5.COMPOSE then
		local var_43_0 = self.itemVO:getConfig("target_id")

		if not var_43_0 or var_43_0 <= 0 then
			return false
		end

		arg_43_1 = math.clamp(arg_43_1, 1, math.floor(self.itemVO.count / self.itemVO:getConfig("compose_number")))

		return self.operateCount ~= arg_43_1
	elseif self.operateMode == var_0_5.RESOLVE then
		arg_43_1 = math.clamp(arg_43_1, 1, self.itemVO.count)

		return self.operateCount ~= arg_43_1
	elseif self.operateMode == var_0_5.USE then
		arg_43_1 = math.clamp(arg_43_1, 1, self.itemVO.count)

		return self.operateCount ~= arg_43_1
	end

	return
end

function ItemInfoLayer:SetOperateCount(arg_44_1)
	if self.operateMode == var_0_5.COMPOSE then
		local var_44_0 = self.itemVO:getConfig("target_id")

		if not var_44_0 or var_44_0 <= 0 then
			return
		end

		local var_44_1 = self.itemVO:getConfig("compose_number")

		arg_44_1 = math.clamp(arg_44_1, 1, math.floor(self.itemVO.count / var_44_1))

		if self.operateCount ~= arg_44_1 then
			self.operateCount = arg_44_1

			self:UpdateComposeCount()
		end

		self:updateItemCount(self.itemVO.count - self.operateCount * var_44_1)
	elseif self.operateMode == var_0_5.RESOLVE then
		arg_44_1 = math.clamp(arg_44_1, 0, self.operateMax)

		if self.operateCount ~= arg_44_1 then
			self.operateCount = arg_44_1

			self:UpdateResolvePanel()
			self:updateItemCount(self.itemVO.count - self.operateCount)
		end
	elseif self.operateMode == var_0_5.USE then
		arg_44_1 = math.clamp(arg_44_1, 0, math.min(self.operateMax, var_0_3))

		if self.operateCount ~= arg_44_1 then
			self.operateCount = arg_44_1

			self:UpdateUsePanel()
			self:updateItemCount(self.itemVO.count - self.operateCount)
		end
	end

	return
end

function ItemInfoLayer:UpdateComposeCount()
	setText(self.operateValue, self.operateCount)
	setInputText(self.operateValueInput, self.operateCount)

	local var_45_0 = {}

	table.insert(var_45_0, {
		type = DROP_TYPE_ITEM,
		id = self.itemVO:getConfig("target_id"),
		count = self.operateCount
	})
	UIItemList.StaticAlign(self.operateBonusList, self.operateBonusTpl, #var_45_0, function(arg_46_0, arg_46_1, arg_46_2)
		arg_46_1 = arg_46_1 + 1

		if arg_46_0 == UIItemList.EventUpdate then
			local var_46_0 = var_45_0[arg_46_1]

			updateDrop(arg_46_2:Find("IconTpl"), var_45_0[arg_46_1])
			onButton(self, arg_46_2:Find("IconTpl"), function()
				self:emit(ItemInfoLayer.ON_DROP, var_46_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	for iter_45_0, iter_45_1 in pairs(self.operateBtns) do
		setActive(iter_45_1, iter_45_0 == "Confirm" or iter_45_0 == "Cancel")
	end

	setText(self.operateCountdesc, i18n("compose_amount_prefix"))
	setActive(self.keepFateTog, false)

	return
end

function ItemInfoLayer:UpdateResolvePanel()
	setText(self.operateValue, self.operateCount)
	setInputText(self.operateValueInput, self.operateCount)

	local var_48_0 = self.itemVO:getConfig("price")
	local var_48_1 = {}

	table.insert(var_48_1, {
		type = DROP_TYPE_RESOURCE,
		id = var_48_0[1],
		count = var_48_0[2] * self.operateCount
	})
	UIItemList.StaticAlign(self.operateBonusList, self.operateBonusTpl, #var_48_1, function(arg_49_0, arg_49_1, arg_49_2)
		arg_49_1 = arg_49_1 + 1

		if arg_49_0 == UIItemList.EventUpdate then
			local var_49_0 = var_48_1[arg_49_1]

			updateDrop(arg_49_2:Find("IconTpl"), var_48_1[arg_49_1])
			onButton(self, arg_49_2:Find("IconTpl"), function()
				self:emit(ItemInfoLayer.ON_DROP, var_49_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	for iter_48_0, iter_48_1 in pairs(self.operateBtns) do
		setActive(iter_48_1, iter_48_0 == "Resolve" or iter_48_0 == "Cancel")
	end

	setText(self.operateCountdesc, i18n("resolve_amount_prefix"))

	if self.itemVO:getConfig("type") == Item.TEC_SPEEDUP_TYPE or self.itemVO:getConfig("usage") == ItemUsage.EX_RE_MAP then
		setActive(self.keepFateTog, false)
	else
		setActive(self.keepFateTog, true)
	end

	setButtonEnabled(self.operateBtns.Resolve, self.operateCount > 0)

	return
end

function ItemInfoLayer:UpdateBlueprintResolveNum()
	local var_51_0 = self.itemVO.count

	if self.itemVO:getConfig("type") == Item.BLUEPRINT_TYPE then
		local var_51_1 = getProxy(TechnologyProxy)

		if self.keepFateState then
			var_51_0 = self.itemVO.count - var_51_1:getBluePrintById((var_51_1:GetBlueprint4Item(self.itemVO.id))):getFateMaxLeftOver()
			var_51_0 = var_51_0 < 0 and 0 or var_51_0
		end
	end

	self.operateMax = var_51_0

	return
end

function ItemInfoLayer:UpdateSpeedUpResolveNum()
	if self.itemVO:getConfig("type") == Item.TEC_SPEEDUP_TYPE then
		self.operateMax = self.itemVO.count
	end

	return
end

function ItemInfoLayer:UpdateUsePanel()
	setText(self.operateValue, self.operateCount)
	setInputText(self.operateValueInput, self.operateCount)

	local var_53_0 = {}

	table.insert(var_53_0, {
		type = DROP_TYPE_ITEM,
		id = var_0_4,
		count = self.operateCount
	})
	UIItemList.StaticAlign(self.operateBonusList, self.operateBonusTpl, #var_53_0, function(arg_54_0, arg_54_1, arg_54_2)
		arg_54_1 = arg_54_1 + 1

		if arg_54_0 == UIItemList.EventUpdate then
			updateDrop(arg_54_2:Find("IconTpl"), var_53_0[arg_54_1])
		end

		return
	end)

	for iter_53_0, iter_53_1 in pairs(self.operateBtns) do
		setActive(iter_53_1, iter_53_0 == "Confirm" or iter_53_0 == "Cancel")
	end

	setText(self.operateCountdesc, i18n("use_amount_prefix"))
	setActive(self.keepFateTog, false)

	return
end

function ItemInfoLayer:UpdateUseReMapPanel()
	self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
		viewComponent = ReMapTransformationScene,
		mediator = ReMapTransformationMediator,
		data = {
			itemVO = self.itemVO
		}
	}))

	return
end

function ItemInfoLayer:willExit()
	if self.leftEventTrigger then
		ClearEventTrigger(self.leftEventTrigger)
	end

	if self.rightEventTrigger then
		ClearEventTrigger(self.rightEventTrigger)
	end

	self:UnOverlayPanel(self._tf)

	if self.recycleConfirmationPage then
		self.recycleConfirmationPage:Destroy()

		self.recycleConfirmationPage = nil
	end

	return
end

function ItemInfoLayer:PlayOpenBox(arg_57_1, arg_57_2)
	if not arg_57_1 or arg_57_1 == "" then
		arg_57_2()

		return
	end

	local var_57_0 = {}
	local var_57_1 = self._tf:Find(arg_57_1 .. "(Clone)")

	if var_57_1 then
		self[arg_57_1] = go(var_57_1)
	end

	if not self[arg_57_1] then
		table.insert(var_57_0, function(arg_58_0)
			PoolMgr.GetInstance():GetPrefab("ui/" .. string.lower(arg_57_1), "", true, function(arg_59_0)
				arg_59_0:SetActive(true)

				self[arg_57_1] = arg_59_0

				arg_58_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_57_0, function()
		if self.playing or not self[arg_57_1] then
			return
		end

		self.playing = true

		self[arg_57_1]:SetActive(true)
		SetActive(self.window, false)

		local var_60_0 = tf(self[arg_57_1])

		var_60_0:SetParent(self._tf, false)
		var_60_0:SetAsLastSibling()

		local var_60_1 = var_60_0:GetComponent("DftAniEvent")

		var_60_1:SetTriggerEvent(function(arg_61_0)
			arg_57_2()

			return
		end)
		var_60_1:SetEndEvent(function(arg_62_0)
			if self[arg_57_1] then
				SetActive(self[arg_57_1], false)

				self.playing = false
			end

			self:closeView()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_EQUIPMENT_OPEN)

		return
	end)

	return
end

function ItemInfoLayer:inOutAnim(arg_63_1, arg_63_2)
	if arg_63_1 then
		local var_63_0 = self._tf:Find("window/bg_decorations"):GetComponent(typeof(Animation))

		var_63_0:Stop()
		var_63_0:Play("anim_window_bg")

		local var_63_1 = self._tf:Find("window/top"):GetComponent(typeof(Animation))

		var_63_1:Stop()
		var_63_1:Play("anim_top")

		local var_63_2 = self._tf:Find("window"):GetComponent(typeof(Animation))

		var_63_2:Stop()
		var_63_2:Play("anim_content")

		local var_63_3 = self._tf:Find("bg"):GetComponent(typeof(Animation))

		var_63_3:Stop()
		var_63_3:Play("anim_bg_plus")
	end

	arg_63_2()

	return
end

return ItemInfoLayer
