local var_0_0 = class("NewBackYardShipInfoLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewBackYardShipInfoUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/desc"):GetComponent(typeof(Text))
	arg_2_0.counterTxt = arg_2_0._tf:Find("frame/top/value/Text"):GetComponent(typeof(Text))
	arg_2_0.cardContainer = arg_2_0._tf:Find("frame/panel")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/top/close")
	arg_2_0.mainPanel = arg_2_0._tf:Find("frame")
	arg_2_0.toggles = {
		[DormShip.FLOOR_2] = arg_2_0._tf:Find("frame/top/rest"),
		[DormShip.FLOOR_1] = arg_2_0._tf:Find("frame/top/train")
	}
	;({})[DormShip.FLOOR_2] = arg_2_0._tf:Find("frame/top/rest"):GetComponent(typeof(Animation))
	;({})[DormShip.FLOOR_1] = arg_2_0._tf:Find("frame/top/train"):GetComponent(typeof(Animation))
	arg_2_0.animations = {}
	arg_2_0.animationName = {
		[DormShip.FLOOR_2] = {
			"anim_backyard_shipinfo_rest_Select",
			"anim_backyard_shipinfo_rest_unSelect"
		},
		[DormShip.FLOOR_1] = {
			"anim_backyard_shipinfo_train_Select",
			"anim_backyard_shipinfo_train_unSelect"
		}
	}
	arg_2_0.addShipTpl = arg_2_0.cardContainer:Find("AddShipTpl")
	arg_2_0.extendShipTpl = arg_2_0.cardContainer:Find("ExtendShipTpl")
	arg_2_0.shipCardTpl = arg_2_0.cardContainer:Find("ShipCardTpl")
	arg_2_0.cards = {
		{},
		{},
		{}
	}

	table.insert(arg_2_0.cards[1], BackYardShipCard.New(arg_2_0.shipCardTpl, arg_2_0.event))
	table.insert(arg_2_0.cards[2], BackYardEmptyCard.New(arg_2_0.addShipTpl, arg_2_0.event))
	table.insert(arg_2_0.cards[3], BackYardExtendCard.New(arg_2_0.extendShipTpl, arg_2_0.event))
	setText(arg_2_0._tf:Find("frame/desc1"), i18n("backyard_longpress_ship_tip"))
	setText(arg_2_0._tf:Find("frame/top/rest/Text"), i18n("courtyard_label_rest"))
	setText(arg_2_0._tf:Find("frame/top/train/Text"), i18n("courtyard_label_train"))
	setText(arg_2_0._tf:Find("frame/top/rest/Text_un"), i18n("courtyard_label_rest"))
	setText(arg_2_0._tf:Find("frame/top/train/Text_un"), i18n("courtyard_label_train"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)

	local var_3_0 = Color.New(0.2235294, 0.227451, 0.2352941, 1)
	local var_3_1 = Color.New(0.5137255, 0.5137255, 0.5137255, 1)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.toggles) do
		onToggle(arg_3_0, iter_3_1, function(arg_6_0)
			if arg_6_0 then
				arg_3_0:SwitchToPage(iter_3_0)
			end

			local var_6_0 = iter_3_1:Find("icon"):GetComponent(typeof(Image))

			if arg_6_0 then
				var_6_0.color = var_3_0 or var_3_1

				local var_6_1 = arg_3_0.animationName[iter_3_0]
				local var_6_2 = arg_6_0 and 1 or 2

				arg_3_0.animations[iter_3_0]:Play(arg_3_0.animationName[iter_3_0][arg_6_0 and 1 or 2])
				print(var_6_1[var_6_2])

				return
			end
		end, SFX_PANEL)
	end

	setActive(arg_3_0.toggles[2], getProxy(DormProxy):getRawData():isUnlockFloor(2))
	onNextTick(function()
		if arg_3_0.exited then
			return
		end

		local var_7_0 = arg_3_0.contextData.type or DormShip.FLOOR_1

		for iter_7_0, iter_7_1 in ipairs({
			DormShip.FLOOR_1,
			DormShip.FLOOR_2
		}) do
			triggerToggle(arg_3_0.toggles[iter_7_1], iter_7_1 == var_7_0)
		end

		return
	end)

	return
end

function var_0_0.GetCardTypeCnt(arg_8_0, arg_8_1)
	local var_8_0 = getProxy(DormProxy):getRawData()
	local var_8_1 = 0
	local var_8_2 = 0

	if arg_8_1 == DormShip.FLOOR_1 then
		var_8_1 = var_8_0.exp_pos
		var_8_2 = var_8_0:getConfig("training_ship_number")
	elseif arg_8_1 == DormShip.FLOOR_2 then
		var_8_1 = var_8_0.rest_pos
		var_8_2 = var_8_0:getConfig("fix_ship_number")
	end

	local var_8_4 = var_8_0:GetFloorShipCnt(arg_8_1)

	return {
		var_8_4,
		var_8_1 - var_8_4,
		var_8_2 - var_8_1
	}
end

function var_0_0.SwitchToPage(arg_9_0, arg_9_1)
	if arg_9_0.type == arg_9_1 then
		return
	end

	arg_9_0.type = arg_9_1

	arg_9_0:UpdateSlots()

	if arg_9_1 == DormShip.FLOOR_1 then
		arg_9_0.descTxt.text = i18n("backyard_traning_tip")
	elseif arg_9_1 == DormShip.FLOOR_2 then
		arg_9_0.descTxt.text = i18n("backyard_rest_tip")
	end

	return
end

function var_0_0.UpdateSlots(arg_10_0)
	local var_10_0 = arg_10_0:GetCardTypeCnt(arg_10_0.type)
	local var_10_1 = getProxy(DormProxy):getRawData():GetBayShipOnFloor(arg_10_0.type)
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		for iter_10_2, iter_10_3 in ipairs((arg_10_0:GetTypeCards(iter_10_0, iter_10_1))) do
			var_10_2 = var_10_2 + 1

			iter_10_3:Flush(arg_10_0.type, var_10_1[iter_10_2])
			iter_10_3:SetSiblingIndex(var_10_2)
		end
	end

	arg_10_0.counterTxt.text = var_10_0[1] .. "/" .. var_10_0[2] + var_10_0[1]

	return
end

function var_0_0.GetTypeCards(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = #arg_11_0.cards[arg_11_1], arg_11_2 - 1 do
		table.insert(arg_11_0.cards[arg_11_1], arg_11_0.cards[arg_11_1][1]:Clone())
	end

	for iter_11_1 = #arg_11_0.cards[arg_11_1], arg_11_2 + 1, -1 do
		arg_11_0.cards[arg_11_1][iter_11_1]:Disable()
	end

	for iter_11_2 = 1, arg_11_2 do
		arg_11_0.cards[arg_11_1][iter_11_2]:Enable()

		;({})[iter_11_2] = arg_11_0.cards[arg_11_1][iter_11_2]
	end

	return {}
end

function var_0_0.willExit(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.cards) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			iter_12_3:Dispose()
		end
	end

	return
end

return var_0_0
