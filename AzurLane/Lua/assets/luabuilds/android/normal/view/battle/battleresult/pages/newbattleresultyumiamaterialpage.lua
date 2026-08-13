class = var_0_10000

local var_0_0 = "NewBattleResultYumiaMaterialPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = {}

DROP_TYPE_RYZA_DROP = var_2
var_0_2[1] = var_2
var_0_1.YUMIA_MATERIAL_DROP_TYPE_LIST = var_0_2

function var_0_1.NeedShowYumiaMaterailDrop(arg_1_0)
	if not arg_1_0 then
		return false
	end

	ipairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001(arg_1_0) do
		table = var_1_10006

		if var_1_10006.contains(var_0_1.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_1_1.type) then
			return true
		end
	end

	return false
end

function var_0_1.getUIName(arg_2_0)
	return "NewBattleResultYumiaRewardPages"
end

function var_0_1.OnLoaded(arg_3_0)
	arg_3_0.parentTr = arg_3_0._tf.parent

	local var_3_0 = arg_3_0._tf

	arg_3_0.itemContainer = var_1.Find(var_3_0, "item/container")

	local var_3_1 = arg_3_0._tf

	arg_3_0.itemTpl = var_1.Find(var_3_1, "item/tpl")

	local var_3_2 = arg_3_0._tf

	arg_3_0.confirmBtn = var_1.Find(var_3_2, "confirm_btn")

	local var_3_3 = arg_3_0._tf

	arg_3_0.lineTxt = var_1.Find(var_3_3, "words/text")
	setText = var_1

	local var_3_4 = arg_3_0.confirmBtn
	local var_3_5 = var_2.Find(var_3_4, "text")

	i18n = var_3_4

	var_1(var_3_5, var_3_4("word_ok"))

	return
end

function var_0_1.SetUp(arg_4_0, arg_4_1)
	arg_4_0:Show()

	seriesAsync = var_2

	var_2({
		function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.playAnima(var_5_0, "Anim_NewBattleResultYumiaRewardPages_In")

			local var_5_1 = arg_4_0

			var_1.UpdateItem(var_5_1)

			local var_5_2 = arg_4_0

			var_1.UpdateLine(var_5_2)

			local var_5_3 = arg_4_0

			var_1.RegisterEvent(var_5_3, arg_5_0)

			return
		end
	}, function()
		local var_6_0 = arg_4_0

		var_0.Clear(var_6_0)

		local var_6_1 = arg_4_0

		var_0.Destroy(var_6_1)
		arg_4_1()

		return
	end)

	return
end

function var_0_1.Show(arg_7_0)
	var_0_1.super.Show(arg_7_0)

	local var_7_0 = arg_7_0.parentTr
	local var_7_1 = var_1.GetComponent

	typeof = var_1_10003
	Image = var_1_10004

	local var_7_2 = var_7_1(var_7_0, var_1_10003(var_1_10004))

	var_7_2.enabled = false
	SetActive = var_7_2

	local var_7_3 = arg_7_0.parentTr

	var_7_2(var_2.Find(var_7_3, "Effect"), false)

	return
end

function var_0_1.dropFilter(arg_8_0)
	local var_8_0 = {}

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0) do
		table = var_1_10007

		if var_1_10007.contains(var_0_1.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_8_1.type) then
			table = var_1_10007

			var_1_10007.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_1.playAnima(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._tf
	local var_9_1 = var_3.GetComponent

	typeof = var_1_10005
	Animation = var_1_10006

	local var_9_2 = var_9_1(var_9_0, var_1_10005(var_1_10006))

	var_3.Play(var_9_2, arg_9_1)

	local var_9_3 = arg_9_0._tf
	local var_9_4 = var_4.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10007

	local var_9_5 = var_9_4(var_9_3, var_6(var_1_10007))

	var_4.SetEndEvent(var_9_5, function()
		arg_9_2()

		return
	end)

	return
end

function var_0_1.UpdateItem(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1.dropFilter
	local var_11_1

	if not arg_11_0.contextData.drops then
		var_11_1 = {}
	end

	local var_11_2 = var_11_0(var_11_1)
	local var_11_3 = {}

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_11_2) do
		for iter_11_2 = 1, iter_11_1.count do
			Drop = var_1_10013
			var_1_10013 = var_1_10013.New({
				count = 1,
				type = iter_11_1.type,
				id = iter_11_1.id
			})
			cloneTplTo = var_14

			local var_11_4 = var_14(arg_11_0.itemTpl, arg_11_0.itemContainer)

			setActive = var_15

			var_15(var_11_4, false)

			table = var_15

			var_15.insert(var_11_3, var_11_4)

			updateDrop = var_15

			var_15(var_11_4:Find("IconTpl"), var_1_10013)
		end
	end

	local var_11_5 = 1

	Timer = var_5
	arg_11_0.timer = var_5.New(function()
		local var_12_0 = var_11_3[var_11_5]

		setActive = var_1

		var_1(var_12_0, true)

		local var_12_1 = var_12_0
		local var_12_2 = var_12_0.GetComponent

		typeof = var_3
		Animation = var_2_10004

		local var_12_3 = var_12_2(var_12_1, var_3(var_2_10004))

		var_1.Play(var_12_3, "Anim_NewBattleResultYumiaRewardPages_Tpl_In")

		var_11_5 = var_11_5 + 1

		return
	end, 0.08, #var_11_3)

	local var_11_6 = arg_11_0.timer

	var_5.Start(var_11_6)

	return
end

function var_0_1.UpdateLine(arg_13_0)
	local var_13_0 = var_0_1.dropFilter
	local var_13_1

	if not arg_13_0.contextData.drops then
		var_13_1 = {}
	end

	local var_13_2 = var_13_0(var_13_1)

	math = var_13_1

	local var_13_3 = var_13_1.random(#var_13_2)

	AtelierMaterial = var_3

	local var_13_4 = var_3.New({
		configId = var_13_2[var_13_3].id
	})

	if var_3.GetVoices(var_13_4) and #var_4 > 0 then
		math = var_5

		local var_13_5 = var_4[var_5.random(#var_4)]

		ShipWordHelper = var_6

		local var_13_6 = var_6.GetWordAndCV
		local var_13_7 = var_13_5[1]
		local var_13_8 = var_13_5[2]
		local var_13_9

		PLATFORM_CODE = var_1_10010
		PLATFORM_US = var_1_10011

		local var_13_10, var_13_11, var_13_12 = var_13_6(var_13_7, var_13_8, var_13_9, var_1_10010 ~= var_1_10011)

		if var_13_11 then
			pg = var_13_9

			local var_13_13 = var_13_9.CriMgr.GetInstance()

			var_13_9.PlaySoundEffect_V3(var_13_13, var_13_11)
		end

		setText = var_13_9

		var_13_9(arg_13_0.lineTxt, var_13_12)
	end

	return
end

function var_0_1.RegisterEvent(arg_14_0, arg_14_1)
	if arg_14_0.exited then
		return
	end

	local function var_14_0()
		local var_15_0 = arg_14_0

		var_0.playAnima(var_15_0, "Anim_NewBattleResultYumiaRewardPages_Out", arg_14_1)

		return
	end

	onButton = var_1_10003

	local var_14_1 = arg_14_0
	local var_14_2 = arg_14_0._tf
	local var_14_3 = var_14_0

	SFX_PANEL = var_1_10007

	var_1_10003(var_14_1, var_14_2, var_14_3, var_1_10007)

	onButton = var_1_10003

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.confirmBtn
	local var_14_6 = var_14_0

	SFX_PANEL = var_1_10007

	var_1_10003(var_14_4, var_14_5, var_14_6, var_1_10007)

	if arg_14_0.contextData.autoSkipFlag then
		triggerButton = var_3

		var_3(arg_14_0._tf)
	end

	return
end

function var_0_1.Clear(arg_16_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_16_0._tf)

	removeOnButton = var_1_10001

	var_1_10001(arg_16_0.confirmBtn)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	arg_17_0.exited = true

	if arg_17_0:isShowing() then
		arg_17_0:Hide()
	end

	if arg_17_0.timer then
		local var_17_0 = arg_17_0.timer

		var_1.Stop(var_17_0)
	end

	local var_17_1 = arg_17_0.parentTr
	local var_17_2 = var_1.GetComponent

	typeof = var_1_10003
	Image = var_1_10004

	local var_17_3 = var_17_2(var_17_1, var_1_10003(var_1_10004))

	var_17_3.enabled = true
	SetActive = var_17_3

	local var_17_4 = arg_17_0.parentTr

	var_17_3(var_2.Find(var_17_4, "Effect"), true)

	return
end

return var_0_1
