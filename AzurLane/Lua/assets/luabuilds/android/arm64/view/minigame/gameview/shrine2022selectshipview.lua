local var_0_0 = class("Shrine2022SelectShipView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "Shrine2022SelectShipUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateCardList()
	arg_2_0:Show()
	arg_2_0:playEnterAni(true)

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0:cleanManagedTween()

	return
end

function var_0_0.setUIData(arg_4_0)
	arg_4_0.shipCardSpriteList = {}

	for iter_4_0 = 1, 7 do
		table.insert(arg_4_0.shipCardSpriteList, (LoadSprite("Shrine2022/" .. "cardselect_" .. iter_4_0, "cardselect_" .. iter_4_0)))
	end

	arg_4_0.shipNameSpriteList = {}

	for iter_4_1 = 1, 7 do
		table.insert(arg_4_0.shipNameSpriteList, (LoadSprite("Shrine2022/" .. "cardselectname_" .. iter_4_1, "cardselectname_" .. iter_4_1)))
	end

	return
end

function var_0_0.updateShipCardUI(arg_5_0, arg_5_1, arg_5_2)
	setImageSprite(arg_5_1, arg_5_0.shipCardSpriteList[arg_5_2], true)

	local var_5_0 = arg_5_1:Find("Name")

	setImageSprite(var_5_0, arg_5_0.shipNameSpriteList[arg_5_2], true)
	setLocalPosition(arg_5_1, arg_5_0.cardPosList[arg_5_2])

	local var_5_1 = arg_5_0:isSelected(arg_5_2)

	setActive(arg_5_1:Find("Selected"), var_5_1)
	setActive(var_5_0, not var_5_1)

	GetComponent(arg_5_1, "Toggle").enabled = not var_5_1

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.cardPosList = {
		{
			x = -80,
			y = 240
		},
		{
			x = -80,
			y = 40
		},
		{
			x = -80,
			y = -162
		},
		{
			x = -80,
			y = -363
		},
		{
			x = 94,
			y = 195
		},
		{
			x = 94,
			y = -7
		},
		{
			x = 94,
			y = -210
		}
	}
	arg_6_0.confirmPosList = {
		{
			x = -452,
			y = -34
		},
		{
			x = -160,
			y = -34
		},
		{
			x = 140,
			y = -34
		},
		{
			x = 440,
			y = -34
		},
		{
			x = -304,
			y = -400
		},
		{
			x = -6,
			y = -400
		},
		{
			x = 297,
			y = -400
		}
	}
	arg_6_0.onCloseFunc = arg_6_0.contextData.onClose
	arg_6_0.onSelectFunc = arg_6_0.contextData.onSelect
	arg_6_0.onConfirmFunc = arg_6_0.contextData.onConfirm
	arg_6_0.shipGameID = arg_6_0.contextData.shipGameID
	arg_6_0.shipGameData = getProxy(MiniGameProxy):GetMiniGameData(arg_6_0.shipGameID)
	arg_6_0.selectingCardIndex = arg_6_0.contextData.selectingCardIndex
	arg_6_0.curSelectIndex = nil

	return
end

function var_0_0.initUI(arg_7_0)
	arg_7_0:setUIData()

	arg_7_0.bg = arg_7_0._tf:Find("BG")
	arg_7_0.cardTpl = arg_7_0._tf:Find("CardTpl")
	arg_7_0.backBtn = arg_7_0._tf:Find("Adapt/BackBtn")
	arg_7_0.helpBtn = arg_7_0._tf:Find("Adapt/HelpBtn")
	arg_7_0.panelTF = arg_7_0._tf:Find("Adapt/Panel")
	arg_7_0.tipTF = arg_7_0._tf:Find("Adapt/Tip")
	arg_7_0.cardContainer = arg_7_0.panelTF:Find("CardContainer")
	arg_7_0.cardUIItemList = UIItemList.New(arg_7_0.cardContainer, arg_7_0.cardTpl)
	arg_7_0.confirmBtn = arg_7_0._tf:Find("ConfirmBtn")

	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:closeSelf()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:closeSelf()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.Pray_activity_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.confirmBtn, function()
		setActive(arg_7_0.confirmBtn, false)
		arg_7_0:confirmSelf()

		return
	end, SFX_PANEL)
	arg_7_0.cardUIItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_7_0:updateShipCardUI(arg_12_2, arg_12_1 + 1)

			if not isSelected then
				onToggle(arg_7_0, arg_12_2, function(arg_13_0)
					if arg_13_0 then
						arg_7_0.curSelectIndex = var_0

						if arg_7_0.onSelectFunc then
							arg_7_0.onSelectFunc(var_0)
						end
					end

					arg_7_0:updateConfirmBtn(arg_13_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	return
end

function var_0_0.closeSelf(arg_14_0)
	if arg_14_0.isPlaying then
		return
	end

	arg_14_0:playEnterAni(false, function()
		if arg_14_0.onCloseFunc then
			arg_14_0.onCloseFunc()
		end

		arg_14_0:Destroy()

		return
	end)

	return
end

function var_0_0.confirmSelf(arg_16_0)
	if arg_16_0.isPlaying then
		return
	end

	if arg_16_0.onCloseFunc then
		arg_16_0.onCloseFunc()
	end

	arg_16_0:playEnterAni(false, function()
		if arg_16_0.onConfirmFunc then
			arg_16_0.onConfirmFunc(arg_16_0.curSelectIndex)
		end

		arg_16_0:Destroy()

		return
	end)

	return
end

function var_0_0.updateConfirmBtn(arg_18_0, arg_18_1)
	setLocalPosition(arg_18_0.confirmBtn, arg_18_0.confirmPosList[arg_18_0.selectingCardIndex])
	setActive(arg_18_0.confirmBtn, arg_18_1)

	return
end

function var_0_0.updateCardList(arg_19_0)
	arg_19_0.cardUIItemList:align(7)

	return
end

function var_0_0.playEnterAni(arg_20_0, arg_20_1, arg_20_2)
	local var_20_3 = {
		x = arg_20_1 and -1000 or 0,
		y = rtf(arg_20_0.panelTF).anchoredPosition.y
	}

	arg_20_0.isPlaying = true

	arg_20_0:managedTween(LeanTween.value, nil, go(arg_20_0.panelTF), var_20_0, var_20_1, var_20_2):setOnUpdate(System.Action_float(function(arg_21_0)
		var_20_3.x = arg_21_0

		setAnchoredPosition(arg_20_0.panelTF, var_20_3)

		return
	end)):setOnComplete(System.Action(function()
		arg_20_0.isPlaying = false

		if arg_20_2 then
			arg_20_2()
		end

		return
	end))

	local var_20_4 = {
		x = rtf(arg_20_0.tipTF).anchoredPosition.x,
		y = arg_20_1 and -100 or 38
	}

	arg_20_0:managedTween(LeanTween.value, nil, go(arg_20_0.tipTF), arg_20_1 and -100 or 38, arg_20_1 and 38 or -100, var_20_2):setOnUpdate(System.Action_float(function(arg_23_0)
		var_20_4.y = arg_23_0

		setAnchoredPosition(arg_20_0.tipTF, var_20_4)

		return
	end))

	return
end

function var_0_0.isSelected(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.shipGameData:GetRuntimeData("kvpElements")[1]) do
		if iter_24_1.value == arg_24_1 then
			return true
		end
	end

	return false
end

return var_0_0
