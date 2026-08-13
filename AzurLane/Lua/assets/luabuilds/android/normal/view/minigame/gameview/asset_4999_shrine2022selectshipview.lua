class = var_0_10000

local var_0_0 = "Shrine2022SelectShipView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "Shrine2022SelectShipUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateCardList()
	arg_2_0:Show()
	arg_2_0:playEnterAni(true)

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0:cleanManagedTween()

	return
end

function var_0_1.setUIData(arg_4_0)
	arg_4_0.shipCardSpriteList = {}

	for iter_4_0 = 1, 7 do
		local var_4_0 = "cardselect_" .. iter_4_0
		local var_4_1 = "Shrine2022/" .. var_4_0

		LoadSprite = var_7

		local var_4_2 = var_7(var_4_1, var_4_0)

		table = var_8

		var_8.insert(arg_4_0.shipCardSpriteList, var_4_2)
	end

	arg_4_0.shipNameSpriteList = {}

	for iter_4_1 = 1, 7 do
		local var_4_3 = "cardselectname_" .. iter_4_1
		local var_4_4 = "Shrine2022/" .. var_4_3

		LoadSprite = var_7

		local var_4_5 = var_7(var_4_4, var_4_3)

		table = var_8

		var_8.insert(arg_4_0.shipNameSpriteList, var_4_5)
	end

	return
end

function var_0_1.updateShipCardUI(arg_5_0, arg_5_1, arg_5_2)
	setImageSprite = var_1_10003

	var_1_10003(arg_5_1, arg_5_0.shipCardSpriteList[arg_5_2], true)

	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.Find(var_5_0, "Name")

	setImageSprite = var_5_0

	var_5_0(var_5_1, arg_5_0.shipNameSpriteList[arg_5_2], true)

	setLocalPosition = var_5_0

	var_5_0(arg_5_1, arg_5_0.cardPosList[arg_5_2])

	local var_5_2 = arg_5_1:Find("Selected")
	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.isSelected(var_5_3, arg_5_2)

	setActive = var_5_3

	var_5_3(var_5_2, var_5_4)

	setActive = var_5_3

	var_5_3(var_5_1, not var_5_4)

	GetComponent = var_5_3
	var_5_3(arg_5_1, "Toggle").enabled = not var_5_4

	return
end

function var_0_1.initData(arg_6_0)
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
	getProxy = var_1
	MiniGameProxy = var_2

	local var_6_0 = var_1(var_2)

	arg_6_0.shipGameData = var_1.GetMiniGameData(var_6_0, arg_6_0.shipGameID)
	arg_6_0.selectingCardIndex = arg_6_0.contextData.selectingCardIndex
	arg_6_0.curSelectIndex = nil

	return
end

function var_0_1.initUI(arg_7_0)
	arg_7_0:setUIData()

	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf

	arg_7_0.cardTpl = var_1.Find(var_7_1, "CardTpl")

	local var_7_2 = arg_7_0._tf

	arg_7_0.backBtn = var_1.Find(var_7_2, "Adapt/BackBtn")

	local var_7_3 = arg_7_0._tf

	arg_7_0.helpBtn = var_1.Find(var_7_3, "Adapt/HelpBtn")

	local var_7_4 = arg_7_0._tf

	arg_7_0.panelTF = var_1.Find(var_7_4, "Adapt/Panel")

	local var_7_5 = arg_7_0._tf

	arg_7_0.tipTF = var_1.Find(var_7_5, "Adapt/Tip")

	local var_7_6 = arg_7_0.panelTF

	arg_7_0.cardContainer = var_1.Find(var_7_6, "CardContainer")
	UIItemList = var_1
	arg_7_0.cardUIItemList = var_1.New(arg_7_0.cardContainer, arg_7_0.cardTpl)

	local var_7_7 = arg_7_0._tf

	arg_7_0.confirmBtn = var_1.Find(var_7_7, "ConfirmBtn")
	onButton = var_1

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.bg

	local function var_7_10()
		local var_8_0 = arg_7_0

		var_0.closeSelf(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_8, var_7_9, var_7_10, var_1_10005)

	onButton = var_1

	local var_7_11 = arg_7_0
	local var_7_12 = arg_7_0.backBtn

	local function var_7_13()
		local var_9_0 = arg_7_0

		var_0.closeSelf(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_11, var_7_12, var_7_13, var_1_10005)

	onButton = var_1

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.helpBtn

	local function var_7_16()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.Pray_activity_tips1.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_14, var_7_15, var_7_16, var_1_10005)

	onButton = var_1

	local var_7_17 = arg_7_0
	local var_7_18 = arg_7_0.confirmBtn

	local function var_7_19()
		setActive = var_2_10000

		var_2_10000(arg_7_0.confirmBtn, false)

		local var_11_0 = arg_7_0

		var_0.confirmSelf(var_11_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_17, var_7_18, var_7_19, var_1_10005)

	local var_7_20 = arg_7_0.cardUIItemList

	var_1.make(var_7_20, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_12_1 + 1
			local var_12_1 = arg_7_0

			var_4.updateShipCardUI(var_12_1, arg_12_2, var_12_0)

			isSelected = var_4

			if not var_4 then
				onToggle = var_4

				local var_12_2 = arg_7_0
				local var_12_3 = arg_12_2

				local function var_12_4(arg_13_0)
					if arg_13_0 then
						arg_7_0.curSelectIndex = var_12_0

						if arg_7_0.onSelectFunc then
							arg_7_0.onSelectFunc(var_12_0)
						end
					end

					local var_13_0 = arg_7_0

					var_1.updateConfirmBtn(var_13_0, arg_13_0)

					return
				end

				SFX_PANEL = var_2_10008

				var_4(var_12_2, var_12_3, var_12_4, var_2_10008)
			end
		end

		return
	end)

	return
end

function var_0_1.closeSelf(arg_14_0)
	if arg_14_0.isPlaying then
		return
	end

	arg_14_0:playEnterAni(false, function()
		if arg_14_0.onCloseFunc then
			arg_14_0.onCloseFunc()
		end

		local var_15_0 = arg_14_0

		var_0.Destroy(var_15_0)

		return
	end)

	return
end

function var_0_1.confirmSelf(arg_16_0)
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

		local var_17_0 = arg_16_0

		var_0.Destroy(var_17_0)

		return
	end)

	return
end

function var_0_1.updateConfirmBtn(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.confirmPosList[arg_18_0.selectingCardIndex]

	setLocalPosition = var_3

	var_3(arg_18_0.confirmBtn, var_18_0)

	setActive = var_3

	var_3(arg_18_0.confirmBtn, arg_18_1)

	return
end

function var_0_1.updateCardList(arg_19_0)
	local var_19_0 = 7
	local var_19_1 = arg_19_0.cardUIItemList

	var_2.align(var_19_1, var_19_0)

	return
end

function var_0_1.playEnterAni(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1 and -1000 or 0
	local var_20_1 = arg_20_1 and 0 or -1000
	local var_20_2 = 0.3
	local var_20_3 = {
		x = var_20_0
	}

	rtf = var_1_10007
	var_20_3.y = var_1_10007(arg_20_0.panelTF).anchoredPosition.y
	arg_20_0.isPlaying = true

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_0.managedTween

	LeanTween = var_1_10009

	local var_20_6 = var_1_10009.value
	local var_20_7

	go = var_1_10011

	local var_20_8 = var_20_5(var_20_4, var_20_6, var_20_7, var_1_10011(arg_20_0.panelTF), var_20_0, var_20_1, var_20_2)
	local var_20_9 = var_7.setOnUpdate

	System = var_20_6

	local var_20_10 = var_20_9(var_20_8, var_20_6.Action_float(function(arg_21_0)
		local var_21_0 = var_20_3

		var_21_0.x = arg_21_0
		setAnchoredPosition = var_21_0

		var_21_0(arg_20_0.panelTF, var_20_3)

		return
	end))
	local var_20_11 = var_7.setOnComplete

	System = var_9

	var_20_11(var_20_10, var_9.Action(function()
		arg_20_0.isPlaying = false

		if arg_20_2 then
			arg_20_2()
		end

		return
	end))

	local var_20_12 = arg_20_1 and -100 or 38
	local var_20_13 = arg_20_1 and 38 or -100
	local var_20_14 = {}

	rtf = var_10
	var_20_14.x = var_10(arg_20_0.tipTF).anchoredPosition.x
	var_20_14.y = var_20_12

	local var_20_15 = arg_20_0
	local var_20_16 = arg_20_0.managedTween

	LeanTween = var_12

	local var_20_17 = var_12.value
	local var_20_18

	go = var_14

	local var_20_19 = var_20_16(var_20_15, var_20_17, var_20_18, var_14(arg_20_0.tipTF), var_20_12, var_20_13, var_20_2)
	local var_20_20 = var_10.setOnUpdate

	System = var_20_17

	var_20_20(var_20_19, var_20_17.Action_float(function(arg_23_0)
		local var_23_0 = var_20_14

		var_23_0.y = arg_23_0
		setAnchoredPosition = var_23_0

		var_23_0(arg_20_0.tipTF, var_20_14)

		return
	end))

	return
end

function var_0_1.isSelected(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.shipGameData
	local var_24_1 = var_2.GetRuntimeData(var_24_0, "kvpElements")[1]

	ipairs = var_24_0

	for iter_24_0, iter_24_1 in var_24_0(var_24_1) do
		if iter_24_1.value == arg_24_1 then
			return true
		end
	end

	return false
end

return var_0_1
