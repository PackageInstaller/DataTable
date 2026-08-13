class = var_0_10000

local var_0_0 = "BattleResultMetaExpView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BattleResultMetaExpUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initUITip()
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:updateIconList()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	arg_3_0.closeCB()
	arg_3_0:cleanManagedTween(true)

	return
end

function var_0_1.setData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.lastMetaExpInfoList = arg_4_1
	arg_4_0.closeCB = arg_4_2

	return
end

function var_0_1.initUITip(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1

	var_5_1, setText = var_1.Find(var_5_0, "Notch/Panel/Title/Text"), var_5_0
	i18n = var_1_10004

	var_5_0(var_5_1, var_1_10004("battle_end_subtitle2"))

	return
end

function var_0_1.initData(arg_6_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002
	arg_6_0.metaProxy = var_1_10001(var_1_10002)

	return
end

function var_0_1.initUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf

	arg_7_0.iconTpl = var_1.Find(var_7_1, "IconTpl")

	local var_7_2 = arg_7_0._tf

	arg_7_0.panelTF = var_1.Find(var_7_2, "Notch/Panel")

	local var_7_3 = arg_7_0.panelTF

	arg_7_0.iconContainer = var_1.Find(var_7_3, "ScrollView/Content")
	GetComponent = var_1

	local var_7_4 = arg_7_0.iconContainer

	typeof = var_3
	GridLayoutGroup = var_1_10004
	arg_7_0.gridLayoutGroupSC = var_1(var_7_4, var_3(var_1_10004))

	local var_7_5 = arg_7_0.panelTF

	arg_7_0.closeBtn = var_1.Find(var_7_5, "Button")
	UIItemList = var_1
	arg_7_0.iconUIItemList = var_1.New(arg_7_0.iconContainer, arg_7_0.iconTpl)

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closePanel(var_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.closeBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closePanel(var_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	return
end

function var_0_1.updateIconList(arg_11_0)
	local var_11_1

	if not arg_11_0.lastMetaExpInfoList then
		local var_11_0 = arg_11_0.metaProxy

		var_11_1 = var_1.getLastMetaSkillExpInfoList(var_11_0)
	end

	local var_11_2 = #arg_11_0:sortDataList(var_11_1)

	arg_11_0.gridLayoutGroupSC.constraintCount = var_11_2 > 4 and 2 or 1

	local var_11_3 = arg_11_0.iconUIItemList

	var_3.make(var_11_3, function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_12_2:Find("Light")
			local var_12_1 = arg_12_2:Find("Icon")
			local var_12_2 = arg_12_2:Find("AddExpText")
			local var_12_3 = arg_12_2:Find("LevelMaxText")
			local var_12_4 = arg_12_2:Find("ExpMaxText")
			local var_12_5 = arg_12_2:Find("Slider")
			local var_12_6 = var_0[arg_12_1].shipID
			local var_12_7 = var_9.addDayExp
			local var_12_8 = var_9.isUpLevel
			local var_12_9 = var_9.isMaxLevel
			local var_12_10 = var_9.isExpMax
			local var_12_11 = var_9.progress

			getProxy = var_2_10016
			BayProxy = var_2_10017

			local var_12_12 = var_2_10016(var_2_10017)
			local var_12_13 = var_16.getShipById(var_12_12, var_12_6)
			local var_12_14 = var_16.getPainting(var_12_13)
			local var_12_15 = "SquareIcon/" .. var_12_14

			setImageSprite = var_19

			local var_12_16 = var_12_1

			LoadSprite = var_2_10021

			var_19(var_12_16, var_2_10021(var_12_15, var_12_14))

			setText = var_19

			var_19(var_12_2, "EXP + " .. var_12_7)

			setActive = var_19

			var_19(var_12_0, var_12_8 and var_12_9)

			if var_12_8 and var_12_9 then
				setActive = var_19

				var_19(var_12_2, false)

				setActive = var_19

				var_19(var_12_3, true)

				setActive = var_19

				var_19(var_12_4, false)
			elseif var_12_10 then
				setActive = var_19

				var_19(var_12_2, false)

				setActive = var_19

				var_19(var_12_3, false)

				setActive = var_19

				var_19(var_12_4, true)
			else
				setActive = var_19

				var_19(var_12_2, true)

				setActive = var_19

				var_19(var_12_3, false)

				setActive = var_19

				var_19(var_12_4, false)
			end

			setSlider = var_19

			var_19(var_12_5, 0, 1, var_12_11)

			onButton = var_19

			local var_12_17 = arg_11_0
			local var_12_18 = arg_12_2

			local function var_12_19()
				LoadContextCommand = var_3_10000

				local var_13_0 = var_3_10000.LoadLayerOnTopContext

				Context = var_3_10001

				local var_13_1 = var_3_10001.New
				local var_13_2 = {}

				MetaSkillDetailBoxLayer = var_3_10003
				var_13_2.viewComponent = var_3_10003
				MetaSkillDetailBoxMediator = var_3_10003
				var_13_2.mediator = var_3_10003
				var_13_2.data = {
					metaShipID = var_0.id,
					expInfoList = arg_11_0.lastMetaExpInfoList
				}

				function var_13_2.onRemoved()
					local var_14_0 = arg_11_0

					var_0.updateIconList(var_14_0)

					return
				end

				var_13_0(var_13_1(var_13_2))

				return
			end

			SFX_PANEL = var_23

			var_19(var_12_17, var_12_18, var_12_19, var_23)
		end

		return
	end)

	local var_11_4 = arg_11_0.iconUIItemList

	var_3.align(var_11_4, #var_1)

	return
end

local var_0_2 = 0.3

function var_0_1.openPanel(arg_15_0)
	arg_15_0:cleanManagedTween(true)

	Canvas = var_1

	var_1.ForceUpdateCanvases()

	local var_15_0 = 400
	local var_15_1 = arg_15_0.panelTF.sizeDelta.x

	System = var_3

	local var_15_2 = var_3.Action_float(function(arg_16_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_15_0.panelTF, {
			x = arg_16_0
		})

		return
	end)

	System = var_4

	local var_15_3 = var_4.Action(function()
		setAnchoredPosition = var_2_10000

		var_2_10000(arg_15_0.panelTF, {
			x = 0
		})

		return
	end)
	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.managedTween

	LeanTween = var_1_10007

	local var_15_6 = var_1_10007.value
	local var_15_7

	go = var_1_10009

	local var_15_8 = var_15_5(var_15_4, var_15_6, var_15_7, var_1_10009(arg_15_0.panelTF), var_15_2, 400, 0, var_0_2)

	var_5.setOnComplete(var_15_8, var_15_3)

	return
end

function var_0_1.closePanel(arg_18_0)
	arg_18_0:cleanManagedTween(true)

	local var_18_0 = 400
	local var_18_1 = arg_18_0.panelTF.sizeDelta.x

	System = var_3

	local var_18_2 = var_3.Action_float(function(arg_19_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_18_0.panelTF, {
			x = arg_19_0
		})

		return
	end)

	System = var_4

	local var_18_3 = var_4.Action(function()
		setAnchoredPosition = var_2_10000

		var_2_10000(arg_18_0.panelTF, {
			x = 0
		})

		local var_20_0 = arg_18_0

		var_0.Destroy(var_20_0)

		return
	end)
	local var_18_4 = arg_18_0
	local var_18_5 = arg_18_0.managedTween

	LeanTween = var_1_10007

	local var_18_6 = var_1_10007.value
	local var_18_7

	go = var_1_10009

	local var_18_8 = var_18_5(var_18_4, var_18_6, var_18_7, var_1_10009(arg_18_0.panelTF), var_18_2, 0, 400, var_0_2)

	var_5.setOnComplete(var_18_8, var_18_3)

	return
end

function var_0_1.sortDataList(arg_21_0, arg_21_1)
	table = var_1_10002

	var_1_10002.sort(arg_21_1, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.isUpLevel and arg_22_0.isMaxLevel and 9999 or 0
		local var_22_1 = arg_22_1.isUpLevel and arg_22_1.isMaxLevel and 9999 or 0
		local var_22_2 = arg_22_0.progress
		local var_22_3 = arg_22_1.progress
		local var_22_4 = var_22_0 + var_22_2

		if var_22_1 + var_22_3 < var_22_4 then
			return true
		elseif var_22_4 == var_7 then
			return arg_22_0.shipID < arg_22_1.shipID
		elseif var_22_4 < var_7 then
			return false
		end

		return
	end)

	return arg_21_1
end

return var_0_1
