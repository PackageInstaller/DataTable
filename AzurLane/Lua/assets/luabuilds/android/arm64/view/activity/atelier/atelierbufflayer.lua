class = var_0_10000

local var_0_0 = "AtelierBuffLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierBuffUI"
end

function var_0_1.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.GetItems(var_2_0)

	AtelierMaterial = var_1_10003

	local var_2_2 = var_1_10003.bindConfigTable()

	_ = var_2_0

	local var_2_3 = var_2_0.map

	_ = var_1_10006
	arg_2_0.buffItems = var_2_3(var_1_10006.filter(var_2_2.all, function(arg_3_0)
		local var_3_0 = var_2_2[arg_3_0].type

		AtelierMaterial = var_2_10002

		return var_3_0 == var_2_10002.TYPE.STRENGTHEN
	end), function(arg_4_0)
		local var_4_0

		if not var_2_1[arg_4_0] then
			AtelierMaterial = var_4_0
			var_4_0 = var_4_0.New({
				configId = arg_4_0
			})
		end

		return var_4_0
	end)

	return
end

function var_0_1.init(arg_5_0)
	_ = var_1_10001
	arg_5_0.slotTfs = var_1_10001.map({
		1,
		2,
		3,
		4,
		5
	}, function(arg_6_0)
		local var_6_0 = arg_5_0._tf
		local var_6_1 = var_1.Find(var_6_0, "Panel")

		return var_1.GetChild(var_6_1, arg_6_0)
	end)

	local var_5_0 = arg_5_0._tf

	arg_5_0.effectList = var_1.Find(var_5_0, "Effects/ScrollView/Viewport/Content")
	setText = var_1

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "Items/List")
	local var_5_3 = var_3.GetChild(var_5_2, 0)
	local var_5_4 = var_3.Find(var_5_3, "Max/Text")

	i18n = var_4

	var_1(var_5_4, var_4("ryza_tip_control_buff_limit"))

	setText = var_1

	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_3.Find(var_5_5, "Items/List")
	local var_5_7 = var_3.GetChild(var_5_6, 0)
	local var_5_8 = var_3.Find(var_5_7, "Min/Text")

	i18n = var_4

	var_1(var_5_8, var_4("ryza_tip_control_buff_not_obtain"))

	setText = var_1

	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_3.Find(var_5_9, "Top/Tips")

	i18n = var_4

	var_1(var_5_10, var_4("ryza_tip_control"))

	setText = var_1

	local var_5_11 = arg_5_0._tf
	local var_5_12 = var_3.Find(var_5_11, "Effects/Total")

	i18n = var_4

	var_1(var_5_12, var_4("ryza_tip_control_buff"))

	AutoLoader = var_1
	arg_5_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_7_0)
	CustomIndexLayer = var_1_10001

	local var_7_0 = var_1_10001.Clone2Full
	local var_7_1 = arg_7_0._tf

	arg_7_0.buffItemTFs = var_7_0(var_3.Find(var_7_1, "Items/List"), #arg_7_0.buffItems)
	onButton = var_1

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0._tf
	local var_7_4 = var_4.Find(var_7_3, "Top/Back")

	local function var_7_5()
		local var_8_0 = arg_7_0

		var_0.onBackPressed(var_8_0)

		return
	end

	SFX_CANCEL = var_7_3

	var_1(var_7_2, var_7_4, var_7_5, var_7_3)

	onButton = var_1

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0._tf
	local var_7_8 = var_4.Find(var_7_7, "Top/Home")

	local function var_7_9()
		local var_9_0 = arg_7_0

		var_0.quickExitFunc(var_9_0)

		return
	end

	SFX_CANCEL = var_7_7

	var_1(var_7_6, var_7_8, var_7_9, var_7_7)

	onButton = var_1

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0._tf
	local var_7_12 = var_4.Find(var_7_11, "Top/Help")

	local function var_7_13()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.ryza_control_help_tip.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_7_11

	var_1(var_7_10, var_7_12, var_7_13, var_7_11)

	table = var_1

	var_1.Foreach(arg_7_0.slotTfs, function(arg_11_0, arg_11_1)
		onButton = var_2_10002

		local var_11_0 = arg_7_0
		local var_11_1 = arg_11_1

		local function var_11_2()
			arg_7_0.contextData.selectIndex = arg_11_0

			local var_12_0 = arg_7_0

			var_0.UpdateView(var_12_0)

			return
		end

		SFX_PANEL = var_2_10007

		var_2_10002(var_11_0, var_11_1, var_11_2, var_2_10007)

		return
	end)

	table = var_1

	var_1.Foreach(arg_7_0.buffItemTFs, function(arg_13_0, arg_13_1)
		onButton = var_2_10002

		local var_13_0 = arg_7_0
		local var_13_1 = arg_13_1

		local function var_13_2()
			local var_14_0 = arg_7_0.buffItems[arg_13_0]

			if not arg_7_0.contextData.selectIndex then
				local var_14_1 = arg_7_0
				local var_14_2 = var_1.emit

				AtelierMaterialDetailMediator = var_3_10004

				var_14_2(var_14_1, var_3_10004.SHOW_DETAIL, var_14_0)

				return
			end

			local var_14_3 = arg_7_0.activity
			local var_14_4 = var_1.GetSlots(var_14_3)[arg_7_0.contextData.selectIndex]

			local function var_14_5(arg_15_0, arg_15_1)
				local var_15_1

				if var_14_0.count < arg_15_1 then
					pg = var_15_1

					local var_15_0 = var_15_1.TipsMgr.GetInstance()

					var_15_1 = var_15_1.ShowTips
					i18n = var_4_10005

					var_15_1(var_15_0, var_4_10005("ryza_tip_control_buff_not_obtain_tip"))

					return
				end

				Clone = var_15_1

				local var_15_2 = var_15_1(var_0)[arg_7_0.contextData.selectIndex]

				var_15_2[1] = arg_15_0
				var_15_2[2] = arg_15_1

				local var_15_3 = arg_7_0
				local var_15_4 = var_4.emit

				GAME = var_4_10007

				var_15_4(var_15_3, var_4_10007.UPDATE_ATELIER_BUFF, var_2)

				return
			end

			if var_14_4[1] == var_14_0:GetConfigID() then
				if var_14_4[2] < #var_14_0:GetBuffs() then
					var_14_5(var_14_4[1], var_14_4[2] + 1)
				end

				return
			end

			_ = var_4

			if var_4.detect(var_1, function(arg_16_0)
				local var_16_0 = arg_16_0[1]
				local var_16_1 = var_14_0

				return var_16_0 == var_2.GetConfigID(var_16_1)
			end) then
				return
			end

			var_14_5(var_14_0:GetConfigID(), 1)

			return
		end

		SFX_PANEL = var_2_10007

		var_2_10002(var_13_0, var_13_1, var_13_2, var_2_10007)

		return
	end)
	arg_7_0:UpdateView()

	pg = var_1

	local var_7_14 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_7_14, arg_7_0._tf)

	PlayerPrefs = var_1

	local var_7_15 = var_1.GetInt
	local var_7_16 = "first_enter_ryza_buff_"

	getProxy = var_4
	PlayerProxy = var_7_11

	local var_7_17 = var_4(var_7_11)

	if var_7_15(var_7_16 .. var_4.getRawData(var_7_17).id, 0) == 0 then
		triggerButton = var_1

		local var_7_18 = arg_7_0._tf

		var_1(var_3.Find(var_7_18, "Top/Help"))

		PlayerPrefs = var_1

		local var_7_19 = var_1.SetInt
		local var_7_20 = "first_enter_ryza_buff_"

		getProxy = var_4
		PlayerProxy = var_6

		local var_7_21 = var_4(var_6)

		var_7_19(var_7_20 .. var_4.getRawData(var_7_21).id, 1)
	end

	return
end

function var_0_1.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.activity
	local var_17_1 = var_1.GetSlots(var_17_0)

	_ = var_1_10002

	local var_17_2 = var_1_10002.all(var_17_1, function(arg_18_0)
		return arg_18_0[1] > 0
	end)

	setActive = var_17_0

	local var_17_3 = arg_17_0._tf

	var_17_0(var_5.Find(var_17_3, "Panel/Full"), var_17_2)

	arg_17_0.slotFull = var_17_2
	table = var_17_0

	var_17_0.Foreach(arg_17_0.slotTfs, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_17_0

		var_2.UpdateSlot(var_19_0, arg_19_1, arg_19_0)

		return
	end)

	local var_17_4

	if arg_17_0.contextData.selectIndex then
		var_17_4 = var_17_1[arg_17_0.contextData.selectIndex]
	end

	table = var_4

	var_4.Foreach(arg_17_0.buffItems, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_17_0.buffItemTFs[arg_20_0]
		local var_20_1 = arg_20_1:GetBuffs()

		_ = var_2_10004

		local var_20_2 = var_2_10004.detect(var_17_1, function(arg_21_0)
			local var_21_0 = arg_21_0[1]
			local var_21_1 = arg_20_1

			return var_21_0 == var_2.GetConfigID(var_21_1)
		end)
		local var_20_3 = #var_20_1
		local var_20_4 = var_20_2 and var_20_3 <= var_20_2[2]
		local var_20_5 = arg_20_1.count == 0 or var_20_2 and var_20_3 > var_20_2[2] and var_20_2[2] == arg_20_1.count

		if var_20_2 then
			::label_20_0::

			table = var_2_10008
			var_2_10008 = var_2_10008.indexof(var_17_1, var_20_2) == arg_17_0.contextData.selectIndex
		end

		local var_20_6

		if var_17_4 then
			var_20_6 = not var_20_4 and var_20_2 and not var_2_10008
		end

		local var_20_7

		if var_17_4 then
			var_20_7 = not var_20_2 and not var_20_5
		end

		if not var_20_5 then
			if var_17_4 then
				if not var_20_7 or var_17_4[1] ~= 0 then
					local var_20_8

					if var_2_10008 then
						::label_20_1::

						if not (var_20_3 > var_20_2[2]) then
							var_20_8 = false

							goto label_20_2
						end

						var_20_8 = true
					end

					::label_20_2::

					local var_20_9 = var_20_7 or var_20_8

					setActive = var_2_10013

					var_2_10013(var_20_0:Find("Min"), false)

					if var_20_5 then
						setActive = var_2_10013

						var_2_10013(var_20_0:Find("Min"), true)

						setText = var_2_10013

						local var_20_10 = var_20_0:Find("Min/Text")

						i18n = var_16

						var_2_10013(var_20_10, var_16("ryza_tip_control_buff_not_obtain"))
					elseif var_20_6 then
						setActive = var_2_10013

						var_2_10013(var_20_0:Find("Min"), true)

						setText = var_2_10013

						local var_20_11 = var_20_0:Find("Min/Text")

						i18n = var_16

						var_2_10013(var_20_11, var_16("ryza_tip_control_buff_already_active_tip"))
					end

					setActive = var_2_10013

					var_2_10013(var_20_0:Find("Avaliable"), var_20_9)

					if var_20_8 then
						setText = var_2_10013

						local var_20_12 = var_20_0:Find("Avaliable/Text")

						i18n = var_16

						var_2_10013(var_20_12, var_16("ryza_tip_control_buff_upgrade"))
					elseif var_20_7 then
						setText = var_2_10013

						local var_20_13 = var_20_0:Find("Avaliable/Text")

						i18n = var_16

						var_2_10013(var_20_13, var_16("ryza_tip_control_buff_replace"))
					end

					setActive = var_2_10013

					var_2_10013(var_20_0:Find("Max"), var_20_4)

					setScrollText = var_2_10013

					var_2_10013(var_20_0:Find("Name/Text"), arg_20_1:GetName())

					local var_20_14 = arg_20_1.count

					if var_20_2 then
						var_20_14 = var_20_14 - var_20_2[2]
					end

					updateDrop = var_2_10014

					local var_20_15 = var_20_0
					local var_20_16 = var_20_0.Find(var_20_15, "Icon")
					local var_20_17 = {}

					DROP_TYPE_RYZA_DROP = var_20_15
					var_20_17.type = var_20_15
					var_20_17.id = arg_20_1:GetConfigID()
					var_20_17.count = var_20_14

					var_2_10014(var_20_16, var_20_17)

					return
				end
			end
		end
	end)

	_ = var_4

	local var_17_5 = var_4.map(var_17_1, function(arg_22_0)
		if arg_22_0[1] == 0 or arg_22_0[2] == 0 then
			return
		end

		local var_22_0 = arg_17_0.activity
		local var_22_1 = var_1.GetItems(var_22_0)[arg_22_0[1]]

		assert = var_2

		var_2(var_22_1)

		if not var_22_1 then
			AtelierMaterial = var_2
			var_22_1 = var_2.New({
				configId = arg_22_0[1]
			})
		end

		local var_22_2 = var_22_1

		if not var_22_1.GetBuffs(var_22_2) then
			return
		end

		math = var_22_0

		local var_22_3 = var_2[var_22_0.min(#var_2, arg_22_0[2])]

		CommonBuff = var_22_2

		local var_22_4 = var_22_2.New({
			id = var_22_3
		})

		return "【" .. var_22_4:getConfig("name") .. "】:" .. var_22_4:getConfig("desc")
	end)

	CustomIndexLayer = var_5

	local var_17_6 = var_5.Clone2Full(arg_17_0.effectList, #var_17_5)

	ipairs = var_6

	for iter_17_0, iter_17_1 in var_6(var_17_6) do
		setText = var_1_10011

		var_1_10011(iter_17_1, var_17_5[iter_17_0])
	end

	return
end

function var_0_1.PlayFullEffect(arg_23_0)
	arg_23_0:LoadingOn()

	return
end

function var_0_1.UpdateSlot(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.activity
	local var_24_1 = var_3.GetSlots(var_24_0)[arg_24_2][1]
	local var_24_2 = var_3[2]
	local var_24_3 = arg_24_0.contextData.selectIndex == arg_24_2
	local var_24_4 = var_24_1 > 0 or var_24_3

	setActive = var_1_10009

	var_1_10009(arg_24_1:Find("Avaliable"), var_24_4)

	setActive = var_1_10009

	var_1_10009(arg_24_1:Find("Link"), var_24_4)

	setActive = var_1_10009

	var_1_10009(arg_24_1:Find("LinkActive"), var_24_3)

	setActive = var_1_10009

	var_1_10009(arg_24_1:Find("Diamond"), var_24_1 > 0)

	local var_24_5 = false

	if var_24_4 then
		setActive = var_1_10010

		var_1_10010(arg_24_1:Find("Avaliable/Selecting"), var_24_3)

		setActive = var_1_10010

		var_1_10010(arg_24_1:Find("Avaliable/Item"), var_24_1 > 0)

		setActive = var_1_10010

		var_1_10010(arg_24_1:Find("Avaliable/Image"), var_24_1 == 0)

		if 0 < var_24_1 then
			AtelierMaterial = var_1_10010

			local var_24_6 = var_1_10010.New({
				configId = var_24_1
			})

			var_24_5 = #var_1_10010.GetBuffs(var_24_6) == var_24_2

			local var_24_7 = var_1_10010:GetBuffs()

			math = var_12

			local var_24_8 = var_24_7[var_12.min(#var_1_10010:GetBuffs(), var_24_2)]

			CommonBuff = var_12

			local var_24_9 = var_12.New({
				id = var_24_8
			})
			local var_24_10 = arg_24_0.loader

			var_13.GetSpriteQuiet(var_24_10, var_24_9:getConfig("icon"), "", arg_24_1:Find("Avaliable/Item/Image"))

			setText = var_13

			var_13(arg_24_1:Find("Avaliable/Item/Name/Text"), var_24_9:getConfig("name"))
		end
	end

	setActive = var_1_10010

	var_1_10010(arg_24_1:Find("Link/3"), var_24_5)

	setActive = var_1_10010

	var_1_10010(arg_24_1:Find("Link/1"), not var_24_5 and var_24_2 > 0)

	return
end

function var_0_1.OnUpdateAtelierBuff(arg_25_0)
	arg_25_0:UpdateView()
	arg_25_0:PlayLevelUpAnim()

	return
end

function var_0_1.PlayLevelUpAnim(arg_26_0)
	local var_26_0 = arg_26_0

	arg_26_0.CleanTween(var_26_0)

	local var_26_1 = arg_26_0.slotTfs[arg_26_0.contextData.selectIndex]
	local var_26_2 = var_1.Find(var_26_1, "Avaliable/LevelUp/Image")

	setActive = var_26_0

	var_26_0(var_26_2.parent, true)

	local var_26_3 = var_26_2.anchoredPosition.y

	setImageAlpha = var_26_1

	var_26_1(var_26_2, 0)

	LeanTween = var_26_1

	local var_26_4 = var_26_1.value

	go = var_6

	local var_26_5 = var_26_4(var_6(var_1), 0, 2, 2)
	local var_26_6 = var_4.setOnUpdate

	System = var_7

	local var_26_7 = var_26_6(var_26_5, var_7.Action_float(function(arg_27_0)
		math = var_2_10001
		arg_27_0 = var_2_10001.clamp(arg_27_0, 0, 1)
		setImageAlpha = var_1

		var_1(var_26_2, arg_27_0)

		setAnchoredPosition = var_1

		var_1(var_26_2, {
			y = var_26_3 + 20 * (arg_27_0 - 1)
		})

		return
	end))
	local var_26_8 = var_4.setOnComplete

	System = var_7
	arg_26_0.tweenId = var_26_8(var_26_7, var_7.Action(function()
		setAnchoredPosition = var_2_10000

		var_2_10000(var_26_2, {
			y = var_26_3
		})

		setActive = var_2_10000

		var_2_10000(var_26_2.parent, false)

		return
	end)).id

	return
end

function var_0_1.CleanTween(arg_29_0)
	if not arg_29_0.tweenId then
		return
	end

	LeanTween = var_1

	var_1.cancel(arg_29_0.tweenId, true)

	return
end

function var_0_1.LoadingOn(arg_30_0)
	if arg_30_0.animating then
		return
	end

	arg_30_0.animating = true
	pg = var_1

	local var_30_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_30_0, false)

	return
end

function var_0_1.LoadingOff(arg_31_0)
	if not arg_31_0.animating then
		return
	end

	pg = var_1

	local var_31_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOff(var_31_0)

	arg_31_0.animating = false

	return
end

function var_0_1.willExit(arg_32_0)
	local var_32_0 = arg_32_0.loader

	var_1.Clear(var_32_0)
	arg_32_0:CleanTween()
	arg_32_0:LoadingOff()

	pg = var_1

	local var_32_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_32_1, arg_32_0._tf)

	return
end

return var_0_1
