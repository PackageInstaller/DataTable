local var_0_0 = class("ItemInfoLayer", import("..base.BaseUI"))
local var_0_3 = 100
local var_0_4 = 53996
local var_0_5 = {
	USE = 3,
	RESOLVE = 2,
	COMPOSE = 1
}

function var_0_0.getUIName(arg_1_0)
	return "ItemInfoUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:BlurPanel(arg_2_0._tf)

	arg_2_0.window = arg_2_0._tf:Find("window")

	setText(arg_2_0.window:Find("top/bg/infomation/title"), i18n("words_information"))

	arg_2_0.btnContent = arg_2_0.window:Find("actions")

	eachChild(arg_2_0.btnContent, function(arg_3_0)
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

		arg_2_0[iter_2_0] = arg_2_0.btnContent:Find(var_2_0)

		if var_2_1 then
			setText(arg_2_0[iter_2_0]:Find("pic"), var_2_1)
		end
	end

	arg_2_0.itemTF = arg_2_0.window:Find("item")
	arg_2_0.operatePanel = arg_2_0._tf:Find("operate")
	arg_2_0.countTF = arg_2_0.operatePanel:Find("item/left/own/Text"):GetComponent(typeof(Text))
	arg_2_0.keepFateTog = arg_2_0.operatePanel:Find("got/keep_tog")

	setText(arg_2_0.keepFateTog:Find("label"), i18n("keep_fate_tip"))

	arg_2_0.operateBtns = {}
	arg_2_0.operateBtns.Confirm = arg_2_0.operatePanel:Find("actions/confirm_button")
	arg_2_0.operateBtns.Cancel = arg_2_0.operatePanel:Find("actions/cancel_button")
	arg_2_0.operateBtns.Resolve = arg_2_0.operatePanel:Find("actions/resolve_button")

	setText(arg_2_0.operateBtns.Confirm:Find("label"), i18n("msgbox_text_confirm"))
	setText(arg_2_0.operateBtns.Cancel:Find("label"), i18n("msgbox_text_cancel"))
	setText(arg_2_0.operateBtns.Resolve:Find("label"), i18n("msgbox_text_analyse"))
	SetActive(arg_2_0.operatePanel, false)
	SetActive(arg_2_0.window, true)

	arg_2_0.operateMode = nil
	arg_2_0.operateBonusList = arg_2_0.operatePanel:Find("got/panel_bg/list")
	arg_2_0.operateBonusTpl = arg_2_0.operatePanel:Find("got/panel_bg/list/item")
	arg_2_0.operateCountdesc = arg_2_0.operatePanel:Find("count/image_text")
	arg_2_0.operateValue = arg_2_0.operatePanel:Find("count/number_panel/value")
	arg_2_0.operateValueInput = arg_2_0.operatePanel:Find("count/number_panel/InputField")
	arg_2_0.operateLeftButton = arg_2_0.operatePanel:Find("count/number_panel/left")
	arg_2_0.operateRightButton = arg_2_0.operatePanel:Find("count/number_panel/right")
	arg_2_0.operateMaxButton = arg_2_0.operatePanel:Find("count/max")
	arg_2_0.recycleConfirmationPage = ItemRecycleConfirmationPage.New(pg.UIMgr.GetInstance().OverlayMain)

	arg_2_0.recycleConfirmationPage:SetCallback(function()
		setActive(arg_2_0._tf, false)

		return
	end, function()
		setActive(arg_2_0._tf, true)

		return
	end)

	return
end

function var_0_0.getButton(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0[arg_6_1] = arg_6_0[arg_6_1] or cloneTplTo(arg_6_2, arg_6_0.btnContent)

	setActive(arg_6_0[arg_6_1], true)

	return arg_6_0[arg_6_1]
end

function var_0_0.setDrop(arg_7_0, arg_7_1)
	if arg_7_1.type == DROP_TYPE_SHIP then
		arg_7_0:setItemInfo(arg_7_1, arg_7_0.itemTF)
	elseif arg_7_1.type == DROP_TYPE_ITEM then
		arg_7_1.count = getProxy(BagProxy):getItemCountById(arg_7_1.id)

		arg_7_0:setItem(arg_7_1)
	else
		assert(false, "do not support current kind of type: " .. arg_7_1.type)
	end

	return
end

function var_0_0.setItemInfo(arg_8_0, arg_8_1, arg_8_2)
	updateDrop(arg_8_2:Find("left/IconTpl"), setmetatable({
		count = 0
	}, {
		__index = arg_8_1
	}))
	UpdateOwnDisplay(arg_8_2:Find("left/own"), arg_8_1)
	RegisterDetailButton(arg_8_0, arg_8_2:Find("left/detail"), arg_8_1)
	setText(arg_8_2:Find("display_panel/name_container/name/Text"), arg_8_1:getConfig("name"))
	setText(arg_8_2:Find("display_panel/desc/Text"), arg_8_1.desc)

	local var_8_0 = arg_8_2:Find("display_panel/name_container/shiptype")

	setActive(var_8_0, arg_8_1.type == DROP_TYPE_SHIP)

	if arg_8_1.type == DROP_TYPE_SHIP then
		GetImageSpriteFromAtlasAsync("shiptype", shipType2print(arg_8_1:getConfig("type")), var_8_0, false)
	end

	return
end

function var_0_0.updateItemCount(arg_9_0, arg_9_1)
	arg_9_0.countTF.text = arg_9_1

	return
end

function var_0_0.setItem(arg_10_0, arg_10_1)
	arg_10_0:setItemInfo(arg_10_1, arg_10_0.itemTF)

	arg_10_0.itemVO = arg_10_1:getSubClass()

	if not Item.CanInBag(arg_10_0.itemVO.id) then
		return
	end

	local var_10_0 = arg_10_0.itemVO:getConfig("compose_number")

	if var_10_0 > 0 and var_10_0 <= arg_10_0.itemVO.count then
		arg_10_0:setItemInfo(arg_10_1, arg_10_0.operatePanel:Find("item"))

		arg_10_0.operateMax = arg_10_0.itemVO.count / var_10_0

		setActive(arg_10_0.composeBtn, true)
	end

	if arg_10_0.itemVO:getConfig("usage") == ItemUsage.SOS then
		setText(arg_10_0.useBtn:Find("text"), 1)
		setActive(arg_10_0.useBtn, true)
	end

	local var_10_1 = arg_10_0.itemVO:getConfig("type")

	if arg_10_0.itemVO:IsRepairLoveLetterItem() then
		onButton(arg_10_0, arg_10_0.loveRepairBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("loveletter2018_ui_1"),
				onYes = function()
					arg_10_0:emit(ItemInfoMediator.REPAIR_LOVE_LETTER_ITEM, arg_10_0.itemVO)

					return
				end
			})

			return
		end, SFX_PANEL)
		setActive(arg_10_0.loveRepairBtn, true)
		setActive(arg_10_0.okBtn, false)
	elseif Item.IsLoveLetterCheckItem(arg_10_0.itemVO.id) then
		local var_10_2 = arg_10_0.itemVO.extra or pg.loveletter_2018_2021[arg_10_0.itemVO.id].ship_group_id
		local var_10_3 = arg_10_0:getButton("checkMail", arg_10_0.blueBtn)

		setText(var_10_3:Find("pic"), i18n("loveletter_recover_bottom1"))
		onButton(arg_10_0, var_10_3, function()
			arg_10_0:emit(ItemInfoMediator.CHECK_LOVE_LETTER_MAIL, arg_10_0.itemVO.id, var_10_2)

			return
		end, SFX_CONFIRM)

		local var_10_4 = arg_10_0:getButton("repairMail", arg_10_0.yellowBtn)

		setText(var_10_4:Find("pic"), i18n("loveletter_recover_bottom2"))

		local var_10_5 = getProxy(BagProxy):GetLoveLetterRepairInfo(arg_10_0.itemVO.id .. "_" .. var_10_2)

		onButton(arg_10_0, var_10_4, function()
			if not var_10_5 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip1"))
			elseif #var_10_5 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip3"))
			elseif #var_10_5 == 1 then
				({
					delayConfirm = 3
				}).content = i18n("loveletter_recover_text1", var_10_5[1], ShipGroup.New({
					id = var_10_2
				}):getName())
				;({
					delayConfirm = 3
				}).onYes = function()
					arg_10_0:emit(ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL, arg_10_0.itemVO.id, var_0, var_10_2)

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					delayConfirm = 3
				})
			else
				table.sort(var_10_5)

				;({
					hideYes = true
				}).content = i18n("loveletter_recover_text2", ShipGroup.New({
					id = var_10_2
				}):getName())
				;({
					hideYes = true
				}).custom = underscore.map(var_10_5, function(arg_16_0)
					return {
						delayButton = 3,
						text = i18n("loveletter_recover_bottom3", arg_16_0),
						sound = SFX_CONFIRM,
						onCallback = function()
							arg_10_0:emit(ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL, arg_10_0.itemVO.id, arg_16_0, var_10_2)

							return
						end,
						btnType = pg.MsgboxMgr.BUTTON_YELLOW
					}
				end)

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideYes = true
				})
			end

			return
		end, SFX_PANEL)
		setGray(var_10_4, not var_10_5 or #var_10_5 == 0)
	elseif arg_10_0.itemVO:getConfig("type") == Item.EQUIPMENT_BOX_TYPE_5 then
		arg_10_0:setItemInfo(arg_10_1, arg_10_0.operatePanel:Find("item"))
		setActive(arg_10_0.useOneBtn, true)
		onButton(arg_10_0, arg_10_0.useOneBtn, function()
			SetActive(arg_10_0.operatePanel, true)
			SetActive(arg_10_0.window, false)

			arg_10_0.operateMode = var_0_5.USE

			arg_10_0:SetOperateCount(1)

			return
		end, SFX_PANEL)
	elseif arg_10_0.itemVO:CanOpen() then
		setText(arg_10_0.useBtn:Find("text"), 1)
		setActive(arg_10_0.useBtn, true)

		if arg_10_0.itemVO.count > 1 then
			setText(arg_10_0.batchUseBtn:Find("text"), math.min(arg_10_0.itemVO.count, 10))
			setActive(arg_10_0.batchUseBtn, true)
		end
	elseif var_10_1 == Item.BLUEPRINT_TYPE then
		local var_10_6 = getProxy(TechnologyProxy)
		local var_10_7 = var_10_6:GetBlueprint4Item(arg_10_0.itemVO.id)

		if not LOCK_FRAGMENT_SHOP and var_10_7 then
			if var_10_6:getBluePrintById(var_10_7):isMaxLevel() then
				setActive(arg_10_0.resolveBtn, true)
				arg_10_0:UpdateBlueprintResolveNum()
			end
		end

		arg_10_0:setItemInfo(arg_10_1, arg_10_0.operatePanel:Find("item"))
		setActive(arg_10_0.okBtn, true)
	elseif var_10_1 == Item.TEC_SPEEDUP_TYPE then
		setActive(arg_10_0.resolveBtn, true)
		arg_10_0:UpdateSpeedUpResolveNum()
		arg_10_0:setItemInfo(arg_10_1, arg_10_0.operatePanel:Find("item"))
		setActive(arg_10_0.okBtn, true)
	elseif var_10_1 == Item.LOVE_LETTER_TYPE then
		setActive(arg_10_0.loveRepairBtn, false)
		setActive(arg_10_0.okBtn, true)
	elseif var_10_1 == Item.METALESSON_TYPE then
		setActive(arg_10_0.metaskillBtn, true)
		onButton(arg_10_0, arg_10_0.metaskillBtn, function()
			arg_10_0:closeView()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER)

			return
		end, SFX_PANEL)
		setActive(arg_10_0.okBtn, true)
	elseif var_10_1 == Item.SKIN_ASSIGNED_TYPE then
		setActive(arg_10_0.useOneBtn, arg_10_0.contextData.confirmCall)
		onButton(arg_10_0, arg_10_0.useOneBtn, function()
			arg_10_0.contextData.confirmCall()
			arg_10_0:closeView()

			return
		end, SFX_PANEL)
		setActive(arg_10_0.okBtn, true)
	elseif arg_10_0.itemVO:IsExclusiveDiscountType() then
		setActive(arg_10_0.recycleBtn, true)
		setActive(arg_10_0.skinShopBtn, true)
	elseif arg_10_0.itemVO:IsSkinExperienceType() then
		setActive(arg_10_0.skinExperienceShopBtn, true)
	else
		setActive(arg_10_0.okBtn, true)
	end

	return
end

function var_0_0.closeView(arg_21_0)
	if arg_21_0.playing then
		return
	end

	var_0_0.super.closeView(arg_21_0)

	return
end

function var_0_0.didEnter(arg_22_0)
	local var_22_0 = arg_22_0._tf:Find("OpenBox(Clone)")

	if var_22_0 then
		SetActive(var_22_0, false)
	end

	onButton(arg_22_0, arg_22_0._tf:Find("bg"), function()
		arg_22_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_22_0, arg_22_0._tf:Find("window/top/btnBack"), function()
		arg_22_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_22_0, arg_22_0.okBtn, function()
		arg_22_0:closeView()

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.useBtn, function()
		arg_22_0:emit(ItemInfoMediator.USE_ITEM, arg_22_0.itemVO.id, 1)

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.batchUseBtn, function()
		arg_22_0:emit(ItemInfoMediator.USE_ITEM, arg_22_0.itemVO.id, math.min(arg_22_0.itemVO.count, 10))

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.composeBtn, function()
		SetActive(arg_22_0.operatePanel, true)
		SetActive(arg_22_0.window, false)

		arg_22_0.operateMode = var_0_5.COMPOSE

		arg_22_0:SetOperateCount(1)

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.resolveBtn, function()
		SetActive(arg_22_0.operatePanel, true)
		SetActive(arg_22_0.window, false)

		arg_22_0.operateMode = var_0_5.RESOLVE

		arg_22_0:SetOperateCount(1)

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_22_0.operateLeftButton, 0.5, function(arg_30_0)
		if not arg_22_0:UpdateCount(arg_22_0.operateCount - 1) then
			arg_30_0()

			return
		end

		arg_22_0:SetOperateCount(arg_22_0.operateCount - 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_22_0.operateRightButton, 0.5, function(arg_31_0)
		if not arg_22_0:UpdateCount(arg_22_0.operateCount + 1) then
			arg_31_0()

			return
		end

		arg_22_0:SetOperateCount(arg_22_0.operateCount + 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_22_0, arg_22_0.operateMaxButton, function()
		arg_22_0:SetOperateCount(arg_22_0.operateMax)

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_22_0, arg_22_0.operateValueInput, function(arg_33_0)
		local var_33_0 = tonumber(arg_33_0) or 1
		local var_33_1 = math.max(1, (math.min(var_0_3, math.min(var_33_0, arg_22_0.operateMax))))

		arg_22_0:SetOperateCount(var_33_1)

		if arg_33_0 ~= tostring(var_33_1) then
			setInputText(arg_22_0.operateValueInput, var_33_1)
		end

		return
	end)

	local var_22_1 = arg_22_0.itemVO:getConfig("type") == Item.EQUIPMENT_BOX_TYPE_5

	setActive(arg_22_0.operateValueInput, var_22_1)
	setActive(arg_22_0.operateValue, not var_22_1)
	onButton(arg_22_0, arg_22_0.operateBtns.Cancel, function()
		SetActive(arg_22_0.operatePanel, false)
		SetActive(arg_22_0.window, true)

		arg_22_0.operateCount = 0
		arg_22_0.operateMode = nil

		return
	end, SFX_CANCEL)
	onButton(arg_22_0, arg_22_0.operateBtns.Confirm, function()
		if arg_22_0.operateMode == var_0_5.COMPOSE then
			arg_22_0:emit(ItemInfoMediator.COMPOSE_ITEM, arg_22_0.itemVO.id, arg_22_0.operateCount)

			local var_35_0 = arg_22_0.itemVO:getConfig("compose_number")

			if var_35_0 > arg_22_0.itemVO.count - arg_22_0.operateCount * var_35_0 then
				triggerButton(arg_22_0.operateBtns.Cancel)
			else
				arg_22_0:SetOperateCount(1)
			end
		elseif arg_22_0.operateMode == var_0_5.USE then
			arg_22_0:emit(ItemInfoMediator.USE_ITEM, arg_22_0.itemVO.id, arg_22_0.operateCount)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.recycleBtn, function()
		local var_36_0 = arg_22_0.itemVO:GetPrice() or {
			0,
			0
		}

		arg_22_0.recycleConfirmationPage:ExecuteAction("Show", {
			content = i18n("skin_discount_item_recycle_tip", arg_22_0.itemVO:getName(), var_36_0[2]),
			itemId = arg_22_0.itemVO.id
		})

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.skinShopBtn, function()
		arg_22_0:closeView()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.skinExperienceShopBtn, function()
		arg_22_0:closeView()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP, {
			mode = NewSkinShopScene.MODE_EXPERIENCE_FOR_ITEM
		})

		return
	end, SFX_CONFIRM)
	onButton(arg_22_0, arg_22_0.operateBtns.Resolve, function()
		arg_22_0:emit(ItemInfoMediator.SELL_BLUEPRINT, Drop.New({
			type = DROP_TYPE_ITEM,
			id = arg_22_0.itemVO.id,
			count = arg_22_0.operateCount
		}))

		return
	end, SFX_CONFIRM)

	arg_22_0.keepFateState = not getProxy(PlayerProxy):getData():GetCommonFlag(SHOW_DONT_KEEP_FATE_ITEM)
	GetComponent(arg_22_0.keepFateTog, typeof(Toggle)).isOn = arg_22_0.keepFateState

	local function var_22_2()
		arg_22_0:UpdateBlueprintResolveNum()
		arg_22_0:SetOperateCount(1)

		return
	end

	onToggle(arg_22_0, arg_22_0.keepFateTog, function(arg_41_0)
		arg_22_0.keepFateState = arg_41_0

		if arg_41_0 then
			pg.m02:sendNotification(GAME.CANCEL_COMMON_FLAG, {
				flagID = SHOW_DONT_KEEP_FATE_ITEM
			})
		else
			pg.m02:sendNotification(GAME.COMMON_FLAG, {
				flagID = SHOW_DONT_KEEP_FATE_ITEM
			})
		end

		var_22_2()

		return
	end)
	;(function()
		arg_22_0:UpdateBlueprintResolveNum()
		arg_22_0:SetOperateCount(1)

		return
	end)()

	return
end

function var_0_0.UpdateCount(arg_42_0, arg_42_1)
	if arg_42_0.operateMode == var_0_5.COMPOSE then
		local var_42_0 = arg_42_0.itemVO:getConfig("target_id")

		if not var_42_0 or var_42_0 <= 0 then
			return false
		end

		arg_42_1 = math.clamp(arg_42_1, 1, math.floor(arg_42_0.itemVO.count / arg_42_0.itemVO:getConfig("compose_number")))

		return arg_42_0.operateCount ~= arg_42_1
	elseif arg_42_0.operateMode == var_0_5.RESOLVE then
		arg_42_1 = math.clamp(arg_42_1, 1, arg_42_0.itemVO.count)

		return arg_42_0.operateCount ~= arg_42_1
	elseif arg_42_0.operateMode == var_0_5.USE then
		arg_42_1 = math.clamp(arg_42_1, 1, arg_42_0.itemVO.count)

		return arg_42_0.operateCount ~= arg_42_1
	end

	return
end

function var_0_0.SetOperateCount(arg_43_0, arg_43_1)
	if arg_43_0.operateMode == var_0_5.COMPOSE then
		local var_43_0 = arg_43_0.itemVO:getConfig("target_id")

		if not var_43_0 or var_43_0 <= 0 then
			return
		end

		local var_43_1 = arg_43_0.itemVO:getConfig("compose_number")

		arg_43_1 = math.clamp(arg_43_1, 1, math.floor(arg_43_0.itemVO.count / var_43_1))

		if arg_43_0.operateCount ~= arg_43_1 then
			arg_43_0.operateCount = arg_43_1

			arg_43_0:UpdateComposeCount()
		end

		arg_43_0:updateItemCount(arg_43_0.itemVO.count - arg_43_0.operateCount * var_43_1)
	elseif arg_43_0.operateMode == var_0_5.RESOLVE then
		arg_43_1 = math.clamp(arg_43_1, 0, arg_43_0.operateMax)

		if arg_43_0.operateCount ~= arg_43_1 then
			arg_43_0.operateCount = arg_43_1

			arg_43_0:UpdateResolvePanel()
			arg_43_0:updateItemCount(arg_43_0.itemVO.count - arg_43_0.operateCount)
		end
	elseif arg_43_0.operateMode == var_0_5.USE then
		arg_43_1 = math.clamp(arg_43_1, 0, math.min(arg_43_0.operateMax, var_0_3))

		if arg_43_0.operateCount ~= arg_43_1 then
			arg_43_0.operateCount = arg_43_1

			arg_43_0:UpdateUsePanel()
			arg_43_0:updateItemCount(arg_43_0.itemVO.count - arg_43_0.operateCount)
		end
	end

	return
end

function var_0_0.UpdateComposeCount(arg_44_0)
	setText(arg_44_0.operateValue, arg_44_0.operateCount)
	setInputText(arg_44_0.operateValueInput, arg_44_0.operateCount)

	local var_44_0 = {}

	table.insert({}, {
		type = DROP_TYPE_ITEM,
		id = arg_44_0.itemVO:getConfig("target_id"),
		count = arg_44_0.operateCount
	})
	UIItemList.StaticAlign(arg_44_0.operateBonusList, arg_44_0.operateBonusTpl, #{}, function(arg_45_0, arg_45_1, arg_45_2)
		arg_45_1 = arg_45_1 + 1

		if arg_45_0 == UIItemList.EventUpdate then
			updateDrop(arg_45_2:Find("IconTpl"), var_44_0[arg_45_1])
			onButton(arg_44_0, arg_45_2:Find("IconTpl"), function()
				arg_44_0:emit(var_0_0.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	for iter_44_0, iter_44_1 in pairs(arg_44_0.operateBtns) do
		setActive(iter_44_1, iter_44_0 == "Confirm" or iter_44_0 == "Cancel")
	end

	setText(arg_44_0.operateCountdesc, i18n("compose_amount_prefix"))
	setActive(arg_44_0.keepFateTog, false)

	return
end

function var_0_0.UpdateResolvePanel(arg_47_0)
	setText(arg_47_0.operateValue, arg_47_0.operateCount)
	setInputText(arg_47_0.operateValueInput, arg_47_0.operateCount)

	local var_47_0 = arg_47_0.itemVO:getConfig("price")
	local var_47_1 = {}

	table.insert({}, {
		type = DROP_TYPE_RESOURCE,
		id = var_47_0[1],
		count = var_47_0[2] * arg_47_0.operateCount
	})
	UIItemList.StaticAlign(arg_47_0.operateBonusList, arg_47_0.operateBonusTpl, #{}, function(arg_48_0, arg_48_1, arg_48_2)
		arg_48_1 = arg_48_1 + 1

		if arg_48_0 == UIItemList.EventUpdate then
			updateDrop(arg_48_2:Find("IconTpl"), var_47_1[arg_48_1])
			onButton(arg_47_0, arg_48_2:Find("IconTpl"), function()
				arg_47_0:emit(var_0_0.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	for iter_47_0, iter_47_1 in pairs(arg_47_0.operateBtns) do
		setActive(iter_47_1, iter_47_0 == "Resolve" or iter_47_0 == "Cancel")
	end

	setText(arg_47_0.operateCountdesc, i18n("resolve_amount_prefix"))

	if arg_47_0.itemVO:getConfig("type") == Item.TEC_SPEEDUP_TYPE then
		setActive(arg_47_0.keepFateTog, false)
	else
		setActive(arg_47_0.keepFateTog, true)
	end

	setButtonEnabled(arg_47_0.operateBtns.Resolve, arg_47_0.operateCount > 0)

	return
end

function var_0_0.UpdateBlueprintResolveNum(arg_50_0)
	local var_50_0 = arg_50_0.itemVO.count

	if arg_50_0.itemVO:getConfig("type") == Item.BLUEPRINT_TYPE then
		local var_50_1 = getProxy(TechnologyProxy)

		if arg_50_0.keepFateState then
			var_50_0 = arg_50_0.itemVO.count - var_50_1:getBluePrintById((var_50_1:GetBlueprint4Item(arg_50_0.itemVO.id))):getFateMaxLeftOver()
			var_50_0 = var_50_0 < 0 and 0 or var_50_0
		end
	end

	arg_50_0.operateMax = var_50_0

	return
end

function var_0_0.UpdateSpeedUpResolveNum(arg_51_0)
	if arg_51_0.itemVO:getConfig("type") == Item.TEC_SPEEDUP_TYPE then
		arg_51_0.operateMax = arg_51_0.itemVO.count
	end

	return
end

function var_0_0.UpdateUsePanel(arg_52_0)
	setText(arg_52_0.operateValue, arg_52_0.operateCount)
	setInputText(arg_52_0.operateValueInput, arg_52_0.operateCount)

	local var_52_0 = {}

	table.insert({}, {
		type = DROP_TYPE_ITEM,
		id = var_0_4,
		count = arg_52_0.operateCount
	})
	UIItemList.StaticAlign(arg_52_0.operateBonusList, arg_52_0.operateBonusTpl, #{}, function(arg_53_0, arg_53_1, arg_53_2)
		arg_53_1 = arg_53_1 + 1

		if arg_53_0 == UIItemList.EventUpdate then
			updateDrop(arg_53_2:Find("IconTpl"), var_52_0[arg_53_1])
		end

		return
	end)

	for iter_52_0, iter_52_1 in pairs(arg_52_0.operateBtns) do
		setActive(iter_52_1, iter_52_0 == "Confirm" or iter_52_0 == "Cancel")
	end

	setText(arg_52_0.operateCountdesc, i18n("use_amount_prefix"))
	setActive(arg_52_0.keepFateTog, false)

	return
end

function var_0_0.willExit(arg_54_0)
	if arg_54_0.leftEventTrigger then
		ClearEventTrigger(arg_54_0.leftEventTrigger)
	end

	if arg_54_0.rightEventTrigger then
		ClearEventTrigger(arg_54_0.rightEventTrigger)
	end

	arg_54_0:UnOverlayPanel(arg_54_0._tf)

	if arg_54_0.recycleConfirmationPage then
		arg_54_0.recycleConfirmationPage:Destroy()

		arg_54_0.recycleConfirmationPage = nil
	end

	return
end

function var_0_0.PlayOpenBox(arg_55_0, arg_55_1, arg_55_2)
	if not arg_55_1 or arg_55_1 == "" then
		arg_55_2()

		return
	end

	local var_55_0 = {}
	local var_55_1 = arg_55_0._tf:Find(arg_55_1 .. "(Clone)")

	if var_55_1 then
		arg_55_0[arg_55_1] = go(var_55_1)
	end

	if not arg_55_0[arg_55_1] then
		table.insert(var_55_0, function(arg_56_0)
			PoolMgr.GetInstance():GetPrefab("ui/" .. string.lower(arg_55_1), "", true, function(arg_57_0)
				arg_57_0:SetActive(true)

				arg_55_0[arg_55_1] = arg_57_0

				arg_56_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_55_0, function()
		if arg_55_0.playing or not arg_55_0[arg_55_1] then
			return
		end

		arg_55_0.playing = true

		arg_55_0[arg_55_1]:SetActive(true)
		SetActive(arg_55_0.window, false)

		local var_58_0 = tf(arg_55_0[arg_55_1])

		var_58_0:SetParent(arg_55_0._tf, false)
		var_58_0:SetAsLastSibling()

		local var_58_1 = var_58_0:GetComponent("DftAniEvent")

		var_58_1:SetTriggerEvent(function(arg_59_0)
			arg_55_2()

			return
		end)
		var_58_1:SetEndEvent(function(arg_60_0)
			if arg_55_0[arg_55_1] then
				SetActive(arg_55_0[arg_55_1], false)

				arg_55_0.playing = false
			end

			arg_55_0:closeView()

			return
		end)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_EQUIPMENT_OPEN)

		return
	end)

	return
end

function var_0_0.inOutAnim(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 then
		local var_61_0 = arg_61_0._tf:Find("window/bg_decorations"):GetComponent(typeof(Animation))

		var_61_0:Stop()
		var_61_0:Play("anim_window_bg")

		local var_61_1 = arg_61_0._tf:Find("window/top"):GetComponent(typeof(Animation))

		var_61_1:Stop()
		var_61_1:Play("anim_top")

		local var_61_2 = arg_61_0._tf:Find("window"):GetComponent(typeof(Animation))

		var_61_2:Stop()
		var_61_2:Play("anim_content")

		local var_61_3 = arg_61_0._tf:Find("bg"):GetComponent(typeof(Animation))

		var_61_3:Stop()
		var_61_3:Play("anim_bg_plus")
	end

	arg_61_2()

	return
end

return var_0_0
