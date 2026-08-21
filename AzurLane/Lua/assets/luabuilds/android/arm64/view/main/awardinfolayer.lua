local var_0_0 = class("AwardInfoLayer", import("..base.BaseUI"))

var_0_0.TITLE = {
	COMMANDER = "commander",
	RYZA = "ryza",
	ITEM = "item",
	SHIP = "ship",
	REVERT = "revert",
	ESCORT = "escort"
}

local var_0_1 = 0.15
local var_0_2 = 340
local var_0_3 = 564

function var_0_0.getUIName(arg_1_0)
	return "AwardInfoUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	local var_2_0 = arg_2_0.contextData.items or {}

	arg_2_0.awards = _.select(var_2_0, function(arg_3_0)
		return arg_3_0.type ~= DROP_TYPE_ICON_FRAME and arg_3_0.type ~= DROP_TYPE_CHAT_FRAME and arg_3_0.type ~= DROP_TYPE_LIVINGAREA_COVER
	end)
	arg_2_0._itemsWindow = arg_2_0._tf:Find("items")
	arg_2_0.spriteMask = arg_2_0._itemsWindow:Find("SpriteMask")
	arg_2_0.title = arg_2_0.contextData.title or var_0_0.TITLE.ITEM

	for iter_2_0, iter_2_1 in pairs(var_0_0.TITLE) do
		setActive(arg_2_0._itemsWindow:Find("titles/title_" .. iter_2_1), arg_2_0.title == iter_2_1)
	end

	if arg_2_0.title == var_0_0.TITLE.COMMANDER then
		eachChild(arg_2_0._itemsWindow:Find("titles/title_commander"), function(arg_4_0)
			setActive(arg_4_0, arg_4_0.name == arg_2_0.contextData.titleExtra)

			return
		end)
	end

	local var_2_1 = {
		items_scroll = arg_2_0._itemsWindow:Find("items_scroll/content"),
		ships = arg_2_0._itemsWindow:Find("ships")
	}

	if arg_2_0.title == var_0_0.TITLE.SHIP then
		arg_2_0.container = var_2_1.ships
	else
		arg_2_0.container = var_2_1.items_scroll

		scrollTo(arg_2_0.container, nil, 1)

		arg_2_0.windowLayout = arg_2_0._itemsWindow:Find("items_scroll"):GetComponent(typeof(LayoutElement))
	end

	GetOrAddComponent(arg_2_0.container, "CanvasGroup").alpha = 1

	for iter_2_2, iter_2_3 in pairs(var_2_1) do
		setActive(arg_2_0._itemsWindow:Find(iter_2_2), arg_2_0.container == iter_2_3)
	end

	setLocalScale(arg_2_0._itemsWindow, Vector3(0.5, 0.5, 0.5))

	arg_2_0.itemTpl = arg_2_0._itemsWindow:Find("item_tpl")
	arg_2_0.shipTpl = arg_2_0._itemsWindow:Find("ship_tpl")
	arg_2_0.extraBouns = arg_2_0._itemsWindow:Find("titles/extra_bouns")

	setActive(arg_2_0.extraBouns, arg_2_0.contextData.extraBonus)

	arg_2_0.continueBtn = arg_2_0._tf:Find("items/close")

	local var_2_2 = arg_2_0._tf:Find("decorations")

	if arg_2_0.title == var_0_0.TITLE.SHIP then
		setLocalScale(var_2_2, Vector3.New(1.25, 1.25, 1))
	else
		setLocalScale(var_2_2, Vector3.one)
	end

	arg_2_0.blinks = {}
	arg_2_0.tweenItems = {}
	arg_2_0.shipCardTpl = arg_2_0._tf:Find("ShipCardTpl")

	arg_2_0._tf:SetAsLastSibling()

	arg_2_0.metaRepeatAwardTF = arg_2_0._tf:Find("MetaShipRepeatAward")

	return
end

function var_0_0.doAnim(arg_5_0, arg_5_1)
	LeanTween.scale(rtf(arg_5_0._itemsWindow), Vector3(1, 1, 1), 0.15):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
		if arg_5_0.exited then
			return
		end

		arg_5_1()

		return
	end))

	return
end

function var_0_0.playAnim(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.awards do
		table.insert({}, function(arg_8_0)
			setActive(arg_7_0.container:GetChild(iter_7_0 - 1), true)

			if arg_7_0.windowLayout then
				if iter_7_0 > 5 and arg_7_0.windowLayout.preferredHeight ~= var_0_3 then
					arg_7_0.windowLayout.preferredHeight = var_0_3

					arg_7_0:updateSpriteMaskScale()
				end

				if iter_7_0 % 5 == 1 then
					scrollTo(arg_7_0.container, nil, 0)
				end
			end

			arg_7_0.tweeningId = LeanTween.delayedCall(var_0_1, System.Action(arg_8_0)).uniqueId

			return
		end)
	end

	seriesAsync({}, function()
		arg_7_0.tweeningId = nil

		if arg_7_1 then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_10_0)
	setActive(arg_10_0.spriteMask, true)
	onButton(arg_10_0, arg_10_0._tf, function()
		arg_10_0:checkPaintingRes(function()
			if arg_10_0.tweeningId then
				LeanTween.cancel(arg_10_0.tweeningId)

				arg_10_0.tweeningId = nil
			end

			arg_10_0:emit(var_0_0.ON_CLOSE)

			return
		end)

		return
	end, SFX_CANCEL, {
		noShip = not arg_10_0.hasShip
	})
	onButton(arg_10_0, arg_10_0.continueBtn, function()
		triggerButton(arg_10_0._tf)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_GETITEM)
	table.insert({}, function(arg_14_0)
		arg_10_0:doAnim(arg_14_0)

		return
	end)
	arg_10_0:displayAwards()

	if arg_10_0.contextData.animation then
		eachChild(arg_10_0.container, function(arg_15_0)
			setActive(arg_15_0, false)

			return
		end)

		GetOrAddComponent(arg_10_0.container, "CanvasGroup").alpha = 0

		table.insert({}, function(arg_16_0)
			GetOrAddComponent(arg_10_0.container, "CanvasGroup").alpha = 1

			arg_10_0:playAnim(arg_16_0)

			return
		end)
	end

	if arg_10_0.windowLayout then
		local var_10_0 = arg_10_0.windowLayout

		if not arg_10_0.contextData.animation and #arg_10_0.awards > 5 then
			var_10_0.preferredHeight = var_0_3 or var_0_2

			arg_10_0:updateSpriteMaskScale()
			seriesAsync({}, function()
				if arg_10_0.exited then
					return
				end

				if arg_10_0.contextData.closeOnCompleted then
					triggerButton(arg_10_0._tf)
				end

				if arg_10_0.enterCallback then
					arg_10_0.enterCallback()

					arg_10_0.enterCallback = nil
				end

				return
			end)

			if arg_10_0.contextData.auto then
				arg_10_0:AddCloseTimer()
			end

			return
		end
	end
end

function var_0_0.RemoveCloseTimer(arg_18_0)
	if arg_18_0.closeTimer then
		arg_18_0.closeTimer:Stop()

		arg_18_0.closeTimer = nil
	end

	return
end

function var_0_0.AddCloseTimer(arg_19_0)
	arg_19_0:RemoveCloseTimer()

	local var_19_0 = arg_19_0.contextData.auto or 2

	arg_19_0.closeTimer = Timer.New(function()
		arg_19_0:RemoveCloseTimer()
		triggerButton(arg_19_0._tf)

		return
	end, var_19_0, 1)

	arg_19_0.closeTimer:Start()

	return
end

function var_0_0.onUIAnimEnd(arg_21_0, arg_21_1)
	arg_21_0.enterCallback = arg_21_1

	return
end

function var_0_0.onBackPressed(arg_22_0)
	if LeanTween.isTweening(go(arg_22_0._itemsWindow)) then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_22_0._tf)

	return
end

local function var_0_4(arg_23_0, arg_23_1)
	local var_23_1 = Ship.New({
		configId = arg_23_1.id
	})

	var_23_1.virgin = arg_23_1.virgin

	setScrollText(findTF(arg_23_0, "content/info/name_mask/name"), var_23_1:GetColorName())
	flushShipCard(arg_23_0, var_23_1)
	setActive(findTF(arg_23_0, "content/front/new"), arg_23_1.virgin)

	return
end

function var_0_0.displayAwards(arg_24_0)
	assert(#arg_24_0.awards ~= 0, "items数量不能为0")
	removeAllChildren(arg_24_0.container)

	for iter_24_0 = 1, #arg_24_0.awards do
		if arg_24_0.title ~= var_0_0.TITLE.SHIP then
			cloneTplTo(arg_24_0.itemTpl, arg_24_0.container)
		else
			setActive(cloneTplTo(arg_24_0.shipCardTpl, cloneTplTo(arg_24_0.shipTpl, arg_24_0.container), "ship_tpl"), true)
		end
	end

	if arg_24_0.title ~= var_0_0.TITLE.SHIP then
		for iter_24_1 = 1, #arg_24_0.awards do
			local var_24_0 = arg_24_0.container:GetChild(iter_24_1 - 1):Find("bg")
			local var_24_1 = arg_24_0.awards[iter_24_1]

			if arg_24_0.awards[iter_24_1].type == DROP_TYPE_SHIP then
				arg_24_0.hasShip = true
			end

			updateDrop(var_24_0, arg_24_0.awards[iter_24_1], {
				fromAwardLayer = true
			})
			setActive(findTF(var_24_0, "icon_bg/bonus"), arg_24_0.awards[iter_24_1].riraty)
			setActive(findTF(var_24_0, "icon_bg/bonus_catchup"), arg_24_0.awards[iter_24_1].catchupTag)
			setActive(findTF(var_24_0, "icon_bg/bonus_event"), arg_24_0.awards[iter_24_1].catchupActTag)

			local var_24_2 = findTF(var_24_0, "name")
			local var_24_3 = findTF(var_24_0, "name_mask")

			setActive(var_24_2, false)
			setActive(var_24_3, true)

			local var_24_4 = findTF(var_24_0, "name_mask/name")
			local var_24_5 = arg_24_0.awards[iter_24_1].name or getText(var_24_2)

			setScrollText(var_24_4, var_24_5)
			onButton(arg_24_0, var_24_0, function()
				if arg_24_0.tweeningId then
					return
				end

				arg_24_0:emit(AwardInfoMediator.ON_DROP, var_24_1)

				return
			end, SFX_PANEL)
		end
	else
		for iter_24_2 = 1, #arg_24_0.awards do
			local var_24_6 = arg_24_0.container:GetChild(iter_24_2 - 1):Find("ship_tpl")

			var_0_4(var_24_6, arg_24_0.awards[iter_24_2])

			if arg_24_0.awards[iter_24_2].reMetaSpecialItemVO then
				local var_24_7 = cloneTplTo(arg_24_0.metaRepeatAwardTF, var_24_6)

				setLocalPosition(var_24_7, Vector3.zero)
				setLocalScale(var_24_7, Vector3.zero)

				local var_24_8 = var_24_7:Find("item_tpl/bg")

				updateDrop(var_24_8, arg_24_0.awards[iter_24_2].reMetaSpecialItemVO)
				setActive(var_24_8:Find("name"), false)
				setActive(var_24_8:Find("name_mask"), true)
				var_24_8:Find("name_mask/name"):GetComponent("ScrollText"):SetText(arg_24_0.awards[iter_24_2].reMetaSpecialItemVO.cfg.name)
				arg_24_0:managedTween(LeanTween.delayedCall, function()
					arg_24_0:managedTween(LeanTween.value, nil, go(var_24_7), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_27_0)
						setLocalScale(var_24_7, {
							x = arg_27_0,
							y = arg_27_0
						})

						return
					end)):setOnComplete(System.Action(function()
						setLocalScale(var_24_7, Vector3.one)

						return
					end))

					return
				end, 0.3, nil)
			end

			if #arg_24_0.awards > 5 then
				var_24_6.anchoredPosition = iter_24_2 <= 5 and Vector2.New(-50, 0) or Vector2.New(50, 0)
			end
		end
	end

	return
end

function var_0_0.ShowOrHideSpriteMask(arg_29_0, arg_29_1)
	if isActive(arg_29_0.spriteMask) == arg_29_1 then
		return
	end

	setActive(arg_29_0.spriteMask, arg_29_1)

	return
end

function var_0_0.willExit(arg_30_0)
	arg_30_0:RemoveCloseTimer()
	setActive(arg_30_0.spriteMask, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0._tf)

	if arg_30_0.title ~= var_0_0.TITLE.SHIP then
		for iter_30_0 = 0, arg_30_0.container.childCount - 1 do
			local var_30_0 = arg_30_0.container:GetChild(iter_30_0)

			clearDrop(var_30_0:Find("bg"))
		end
	end

	if arg_30_0.blinks and #arg_30_0.blinks > 0 then
		for iter_30_1, iter_30_2 in pairs(arg_30_0.blinks) do
			if not IsNil(iter_30_2) then
				Destroy(iter_30_2)
			end
		end
	end

	if arg_30_0.contextData.removeFunc then
		arg_30_0.contextData.removeFunc()

		arg_30_0.contextData.removeFunc = nil
	end

	return
end

function var_0_0.updateSpriteMaskScale(arg_31_0)
	onNextTick(function()
		if arg_31_0.exited then
			return
		end

		setLocalScale(arg_31_0.spriteMask, Vector3(arg_31_0.spriteMask.rect.width / WHITE_DOT_SIZE * PIXEL_PER_UNIT, arg_31_0.spriteMask.rect.height / WHITE_DOT_SIZE * PIXEL_PER_UNIT, 1))

		return
	end)

	return
end

function var_0_0.checkPaintingRes(arg_33_0, arg_33_1)
	PaintingGroupConst.PaintingDownload({
		isShowBox = false,
		paintingNameList = PaintingGroupConst.GetPaintingNameListForAwardList(arg_33_0.awards),
		finishFunc = arg_33_1
	})

	return
end

return var_0_0
