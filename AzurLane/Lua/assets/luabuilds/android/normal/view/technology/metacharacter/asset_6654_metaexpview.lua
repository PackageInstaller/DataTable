class = var_0_10000

local var_0_0 = "MetaExpView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MetaExpUI"
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
	if arg_3_0.closeCB then
		arg_3_0.closeCB()
	end

	return
end

function var_0_1.setData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.expInfoList = arg_4_1
	arg_4_0.closeCB = arg_4_2

	return
end

function var_0_1.initUITip(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1

	var_5_1, setText = var_1.Find(var_5_0, "Panel/Title/Text"), var_5_0
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

	arg_7_0.panelTF = var_1.Find(var_7_2, "Panel")

	local var_7_3 = arg_7_0.panelTF

	arg_7_0.iconContainer = var_1.Find(var_7_3, "ScrollView/Content")
	GetComponent = var_1

	local var_7_4 = arg_7_0.iconContainer

	typeof = var_3
	GridLayoutGroup = var_1_10004
	arg_7_0.gridLayoutGroupSC = var_1(var_7_4, var_3(var_1_10004))
	UIItemList = var_1
	arg_7_0.iconUIItemList = var_1.New(arg_7_0.iconContainer, arg_7_0.iconTpl)

	return
end

function var_0_1.addListener(arg_8_0)
	return
end

function var_0_1.updateIconList(arg_9_0)
	local var_9_1

	if not arg_9_0.expInfoList then
		local var_9_0 = arg_9_0.metaProxy

		var_9_1 = var_1.getMetaTacticsInfoOnEnd(var_9_0)
	end

	local var_9_2 = #arg_9_0:sortDataList(var_9_1)

	arg_9_0.gridLayoutGroupSC.constraintCount = var_9_2 > 4 and 2 or 1

	local var_9_3 = arg_9_0.iconUIItemList

	var_3.make(var_9_3, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 + 1
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_10_2:Find("Icon")
			local var_10_1 = arg_10_2:Find("AddExpText")
			local var_10_2 = arg_10_2:Find("LevelMaxText")
			local var_10_3 = arg_10_2:Find("ExpMaxText")
			local var_10_4 = arg_10_2:Find("Slider")
			local var_10_5 = arg_10_2:Find("Light")
			local var_10_6 = var_0[arg_10_1].shipID
			local var_10_7 = var_9.addDayExp
			local var_10_8 = var_9.isUpLevel
			local var_10_9 = var_9.isMaxLevel
			local var_10_10 = var_9.isExpMax
			local var_10_11 = var_9.progressOld
			local var_10_12 = var_9.progressNew

			getProxy = var_2_10017
			BayProxy = var_2_10018

			local var_10_13 = var_2_10017(var_2_10018)
			local var_10_14 = var_17.getShipById(var_10_13, var_10_6)
			local var_10_15 = var_17.getPainting(var_10_14)
			local var_10_16 = "SquareIcon/" .. var_10_15

			setImageSprite = var_20

			local var_10_17 = var_10_0

			LoadSprite = var_2_10022

			var_20(var_10_17, var_2_10022(var_10_16, var_10_15))

			setText = var_20

			var_20(var_10_1, "EXP + " .. var_10_7)

			setActive = var_20

			var_20(var_10_5, var_10_8 and var_10_9)

			if var_10_8 and var_10_9 then
				setActive = var_20

				var_20(var_10_1, false)

				setActive = var_20

				var_20(var_10_2, true)

				setActive = var_20

				var_20(var_10_3, false)
			elseif var_10_10 then
				setActive = var_20

				var_20(var_10_1, false)

				setActive = var_20

				var_20(var_10_2, false)

				setActive = var_20

				var_20(var_10_3, true)
			else
				setActive = var_20

				var_20(var_10_1, true)

				setActive = var_20

				var_20(var_10_2, false)

				setActive = var_20

				var_20(var_10_3, false)
			end

			setSlider = var_20

			var_20(var_10_4, 0, 1, var_10_12)

			onButton = var_20

			local var_10_18 = arg_9_0
			local var_10_19 = arg_10_2

			local function var_10_20()
				LoadContextCommand = var_3_10000

				local var_11_0 = var_3_10000.LoadLayerOnTopContext

				Context = var_3_10001

				local var_11_1 = var_3_10001.New
				local var_11_2 = {}

				MetaSkillDetailBoxLayer = var_3_10003
				var_11_2.viewComponent = var_3_10003
				MetaSkillDetailBoxMediator = var_3_10003
				var_11_2.mediator = var_3_10003
				var_11_2.data = {
					metaShipID = var_0.id,
					expInfoList = arg_9_0.lastMetaExpInfoList
				}

				function var_11_2.onRemoved()
					local var_12_0 = arg_9_0

					var_0.updateIconList(var_12_0)

					return
				end

				var_11_0(var_11_1(var_11_2))

				return
			end

			SFX_PANEL = var_24

			var_20(var_10_18, var_10_19, var_10_20, var_24)
		end

		return
	end)

	local var_9_4 = arg_9_0.iconUIItemList

	var_3.align(var_9_4, #var_1)

	return
end

function var_0_1.openPanel(arg_13_0)
	if arg_13_0.isAni == true then
		return
	end

	arg_13_0.isAni = true
	Canvas = var_1

	var_1.ForceUpdateCanvases()

	local var_13_0 = arg_13_0.panelTF.sizeDelta.x

	LeanTween = var_1_10002

	local var_13_1 = var_1_10002.value

	go = var_1_10003

	local var_13_2 = var_13_1(var_1_10003(arg_13_0.panelTF), 0, var_13_0, 0.5)
	local var_13_3 = var_2.setOnUpdate

	System = var_4

	local var_13_4 = var_13_3(var_13_2, var_4.Action_float(function(arg_14_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_13_0.panelTF, {
			x = -arg_14_0
		})

		return
	end))
	local var_13_5 = var_2.setOnComplete

	System = var_4

	var_13_5(var_13_4, var_4.Action(function()
		arg_13_0.isAni = false

		return
	end))

	return
end

function var_0_1.closePanel(arg_16_0)
	if arg_16_0.isAni == true then
		return
	end

	arg_16_0.isAni = true

	local var_16_0 = arg_16_0.panelTF.sizeDelta.x

	LeanTween = var_1_10002

	local var_16_1 = var_1_10002.value

	go = var_1_10003

	local var_16_2 = var_16_1(var_1_10003(arg_16_0.panelTF), -var_16_0, 0, 0.5)
	local var_16_3 = var_2.setOnUpdate

	System = var_4

	local var_16_4 = var_16_3(var_16_2, var_4.Action_float(function(arg_17_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_16_0.panelTF, {
			x = arg_17_0
		})

		return
	end))
	local var_16_5 = var_2.setOnComplete

	System = var_4

	var_16_5(var_16_4, var_4.Action(function()
		arg_16_0.isAni = false

		local var_18_0 = arg_16_0

		var_0.Destroy(var_18_0)

		return
	end))

	return
end

function var_0_1.sortDataList(arg_19_0, arg_19_1)
	table = var_1_10002

	var_1_10002.sort(arg_19_1, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0.isUpLevel and arg_20_0.isMaxLevel and 9999 or 0
		local var_20_1 = arg_20_1.isUpLevel and arg_20_1.isMaxLevel and 9999 or 0
		local var_20_2 = arg_20_0.progressNew
		local var_20_3 = arg_20_1.progressNew
		local var_20_4 = var_20_0 + var_20_2

		if var_20_1 + var_20_3 < var_20_4 then
			return true
		elseif var_20_4 == var_7 then
			return arg_20_0.shipID < arg_20_1.shipID
		elseif var_20_4 < var_7 then
			return false
		end

		return
	end)

	return arg_19_1
end

return var_0_1
