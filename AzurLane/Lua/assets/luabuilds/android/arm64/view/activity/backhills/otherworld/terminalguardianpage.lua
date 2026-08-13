class = var_0_10000

local var_0_0 = "TerminalGuardianPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

ActivityConst = var_0_10001
var_0_1.BIND_LOTTERY_ACT_ID = var_0_10001.OTHER_WORLD_TERMINAL_LOTTERY_ID
pg = var_1
var_0_1.config = var_1.guardian_template
var_0_1.GUARDIAN_SELECT_CNT = 4

function var_0_1.getUIName(arg_1_0)
	return "TerminalGuardianPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	tostring = var_1_10002
	OtherworldTerminalLayer = var_1_10004
	var_2_0.name = var_1_10002(var_1_10004.PAGE_GUARDIAN)

	local var_2_1 = arg_2_0._tf

	arg_2_0.mainViewTF = var_1.Find(var_2_1, "frame/view")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0.mainViewTF
	local var_2_4 = var_3.Find(var_2_3, "content")
	local var_2_5 = arg_2_0.mainViewTF

	arg_2_0.mainViewUIList = var_2_2(var_2_4, var_4.Find(var_2_5, "content/tpl"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.selectViewTF = var_1.Find(var_2_6, "frame/select_view")

	local var_2_7 = arg_2_0.selectViewTF

	arg_2_0.selectBackBtn = var_1.Find(var_2_7, "top/back_btn")
	setText = var_1

	local var_2_8 = arg_2_0.selectViewTF
	local var_2_9 = var_3.Find(var_2_8, "top/Text")

	i18n = var_4

	var_1(var_2_9, var_4("guardian_select_title"))

	local var_2_10 = arg_2_0.selectViewTF

	arg_2_0.selectMainTF = var_1.Find(var_2_10, "left")

	local var_2_11 = arg_2_0.selectMainTF

	arg_2_0.selectdIcon = var_1.Find(var_2_11, "icon_bg/Image")

	local var_2_12 = arg_2_0.selectMainTF

	arg_2_0.selectdUnknown = var_1.Find(var_2_12, "icon_bg/unknown")

	local var_2_13 = arg_2_0.selectMainTF

	arg_2_0.selectdName = var_1.Find(var_2_13, "name")

	local var_2_14 = arg_2_0.selectMainTF

	arg_2_0.selectdDesc = var_1.Find(var_2_14, "desc/content/Text")

	local var_2_15 = arg_2_0.selectMainTF

	arg_2_0.selectdSureBtn = var_1.Find(var_2_15, "sure_btn")
	setText = var_1

	local var_2_16 = arg_2_0.selectdSureBtn
	local var_2_17 = var_3.Find(var_2_16, "Text")

	i18n = var_4

	var_1(var_2_17, var_4("guardian_sure_btn"))

	local var_2_18 = arg_2_0.selectMainTF

	arg_2_0.selectdCancelBtn = var_1.Find(var_2_18, "cancel_btn")
	setText = var_1

	local var_2_19 = arg_2_0.selectdCancelBtn
	local var_2_20 = var_3.Find(var_2_19, "Text")

	i18n = var_4

	var_1(var_2_20, var_4("guardian_cancel_btn"))

	local var_2_21 = arg_2_0.selectMainTF

	arg_2_0.selectdCondition = var_1.Find(var_2_21, "condition")
	UIItemList = var_1

	local var_2_22 = var_1.New
	local var_2_23 = arg_2_0.selectViewTF
	local var_2_24 = var_3.Find(var_2_23, "right/content")
	local var_2_25 = arg_2_0.selectViewTF

	arg_2_0.selectViewUIList = var_2_22(var_2_24, var_4.Find(var_2_25, "right/content/tpl"))
	setText = var_1

	local var_2_26 = arg_2_0.selectViewTF
	local var_2_27 = var_3.Find(var_2_26, "right/content/tpl/active/Text")

	i18n = var_4

	var_1(var_2_27, var_4("guardian_active_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.activity = var_1.getActivityById(var_3_0, var_0_1.BIND_LOTTERY_ACT_ID)
	assert = var_1

	var_1(arg_3_0.activity, "not exist bind lottery act, id" .. var_0_1.BIND_LOTTERY_ACT_ID)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.selectBackBtn

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.CloseSelectView(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.selectdSureBtn

	local function var_3_6()
		local var_5_1

		if #arg_3_0.activeIds >= var_0_1.GUARDIAN_SELECT_CNT then
			pg = var_5_1

			local var_5_0 = var_5_1.TipsMgr.GetInstance()

			var_5_1 = var_5_1.ShowTips
			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("guardian_sure_limit_tip"))

			return
		end

		table = var_5_1

		var_5_1.insert(arg_3_0.activeIds, arg_3_0.selectedId)

		local var_5_2 = arg_3_0

		var_0.ChangeActiveIds(var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_4, var_3_5, var_3_6, var_1_10006)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.selectdCancelBtn

	local function var_3_9()
		table = var_2_10000

		var_2_10000.removebyvalue(arg_3_0.activeIds, arg_3_0.selectedId)

		local var_6_0 = arg_3_0

		var_0.ChangeActiveIds(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_7, var_3_8, var_3_9, var_1_10006)
	arg_3_0:InitMainViewUI()
	arg_3_0:InitSelectViewUI()
	arg_3_0:UpdateView()
	arg_3_0:CloseSelectView()

	return
end

function var_0_1.ChangeActiveIds(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.emit

	OtherworldTerminalMediator = var_1_10004

	var_7_1(var_7_0, var_1_10004.ON_BUFF_LIST_CHANGE, {
		actId = var_0_1.BIND_LOTTERY_ACT_ID,
		ids = arg_7_0.activeIds
	})

	return
end

function var_0_1.InitMainViewUI(arg_8_0)
	local var_8_0 = arg_8_0.mainViewUIList

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_0.activeIds[arg_9_1 + 1] ~= nil

			setActive = var_2_10005

			var_2_10005(arg_9_2:Find("content"), var_9_0)

			setActive = var_2_10005

			var_2_10005(arg_9_2:Find("empty"), not var_9_0)

			local var_9_1

			if var_9_0 then
				var_2_10005 = var_0_1.config[var_3]
				setText = var_2_10006
				var_9_1 = arg_9_2

				var_2_10006(arg_9_2.Find(var_9_1, "content/name"), var_2_10005.guardian_name)

				setText = var_2_10006
				var_9_1 = arg_9_2

				var_2_10006(arg_9_2.Find(var_9_1, "content/desc/content/Text"), var_2_10005.guardian_desc)

				local var_9_2 = arg_9_2:Find("content/icon_mask/Image")

				GetImageSpriteFromAtlasAsync = var_7

				var_7("shipyardicon/" .. var_2_10005.guardian_painting, "", var_9_2, false)
			end

			onButton = var_2_10005

			local var_9_3 = arg_8_0
			local var_9_4 = arg_9_2

			local function var_9_5()
				local var_10_0 = arg_8_0
				local var_10_1

				if not var_0 then
					underscore = var_10_1
					var_10_1 = var_10_1.detect(arg_8_0.allIds, function(arg_11_0)
						table = var_4_10001

						return not var_4_10001.contains(arg_8_0.activeIds, arg_11_0)
					end)
				end

				var_10_0.selectedId = var_10_1

				local var_10_2 = arg_8_0

				var_0.OpenSelectView(var_10_2)

				return
			end

			SFX_PANEL = var_9_1

			var_2_10005(var_9_3, var_9_4, var_9_5, var_9_1)
		end

		return
	end)

	return
end

function var_0_1.UpdateMainView(arg_12_0)
	local var_12_0 = arg_12_0.mainViewUIList

	var_1.align(var_12_0, var_0_1.GUARDIAN_SELECT_CNT)

	return
end

function var_0_1.InitSelectViewUI(arg_13_0)
	local var_13_0 = arg_13_0.selectViewUIList

	var_1.make(var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		local var_14_0

		if arg_14_0 == var_2_10003.EventInit then
			var_14_0 = arg_13_0.allIds[arg_14_1 + 1]

			local var_14_1 = var_0_1.config[var_14_0]

			var_2_10005 = arg_14_2:Find("icon_mask/Image")
			GetImageSpriteFromAtlasAsync = var_2_10006

			var_2_10006("shipyardicon/" .. var_14_1.guardian_painting, "", var_2_10005, true)

			onButton = var_2_10006

			local var_14_2 = arg_13_0
			local var_14_3 = arg_14_2

			local function var_14_4()
				arg_13_0.selectedId = var_14_0

				local var_15_0 = arg_13_0

				var_0.UpdateSelectViewUI(var_15_0)

				return
			end

			SFX_PANEL = var_11

			var_2_10006(var_14_2, var_14_3, var_14_4, var_11)
		else
			UIItemList = var_14_0

			if arg_14_0 == var_14_0.EventUpdate then
				local var_14_5 = arg_13_0.allIds[arg_14_1 + 1]
				local var_14_6 = var_0_1.config[var_14_5]

				table = var_2_10005

				local var_14_7 = var_2_10005.contains(arg_13_0.unlcokIds, var_14_5)

				table = var_2_10006

				local var_14_8 = var_2_10006.contains(arg_13_0.activeIds, var_14_5)
				local var_14_9 = var_14_6.type == 2 and not var_14_7

				setActive = var_8

				var_8(arg_14_2:Find("icon_mask/Image"), not var_14_9)

				setActive = var_8

				var_8(arg_14_2:Find("unknown"), var_14_9)

				setActive = var_8

				var_8(arg_14_2:Find("lock"), not var_14_7 and not var_14_9)

				setActive = var_8

				var_8(arg_14_2:Find("active"), var_14_8)

				setActive = var_8

				var_8(arg_14_2:Find("selected"), var_14_5 == arg_13_0.selectedId)
			end
		end

		return
	end)

	return
end

function var_0_1.UpdateSelectViewUI(arg_16_0)
	local var_16_0

	if not arg_16_0.selectedId then
		var_16_0 = arg_16_0.allIds[1]
	end

	local var_16_1 = var_0_1.config[var_16_0]

	table = var_1_10003

	local var_16_2 = var_1_10003.contains(arg_16_0.unlcokIds, var_16_0)

	table = var_1_10004

	local var_16_3 = var_1_10004.contains(arg_16_0.activeIds, var_16_0)
	local var_16_4 = var_16_1.type == 2 and not var_16_2

	GetImageSpriteFromAtlasAsync = var_6

	var_6("shipyardicon/" .. var_16_1.guardian_painting, "", arg_16_0.selectdIcon, true)

	setActive = var_6

	var_6(arg_16_0.selectdIcon, not var_16_4)

	setActive = var_6

	var_6(arg_16_0.selectdUnknown, var_16_4)

	setText = var_6

	var_6(arg_16_0.selectdName, var_16_4 and "???" or var_16_1.guardian_name)

	setText = var_6

	var_6(arg_16_0.selectdDesc, var_16_4 and "???" or var_16_1.guardian_desc)

	local var_16_5 = ""
	local var_16_6

	if var_16_1.type == 1 then
		ActivityItemPool = var_16_6

		local var_16_7

		var_16_6, var_16_7 = var_16_6.GetGuardianLastCount(var_0_1.BIND_LOTTERY_ACT_ID, var_16_0)

		local var_16_8 = var_16_1.guardian_gain[2] - var_16_7

		string = var_10

		local var_16_9 = var_10.gsub
		local var_16_10 = var_16_1.guardian_gain_desc
		local var_16_11 = "$1"

		math = var_1_10014
		var_16_5 = var_16_9(var_16_10, var_16_11, var_1_10014.min(var_16_8, var_16_1.guardian_gain[2]))
	elseif var_16_1.type == 2 then
		var_16_5 = var_16_1.guardian_gain_desc
	end

	setText = var_16_6

	local var_16_12 = arg_16_0.selectdCondition

	var_16_6(var_9.Find(var_16_12, "Text"), var_16_5)

	setActive = var_16_6

	var_16_6(arg_16_0.selectdSureBtn, var_16_2 and not var_16_3)

	setActive = var_16_6

	var_16_6(arg_16_0.selectdCancelBtn, var_16_2 and var_16_3)

	setActive = var_16_6

	var_16_6(arg_16_0.selectdCondition, not var_16_2)

	local var_16_13 = arg_16_0.selectViewUIList

	var_7.align(var_16_13, #arg_16_0.allIds)

	return
end

function var_0_1.UpdateView(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0.activity = arg_17_1
	end

	_ = var_1_10002
	arg_17_0.activeIds = var_1_10002.map(arg_17_0.activity.data2_list, function(arg_18_0)
		return arg_18_0
	end)
	ActivityItemPool = var_2
	arg_17_0.unlcokIds = var_2.GetAllGuardianIdsStatus(var_0_1.BIND_LOTTERY_ACT_ID)
	ActivityItemPool = var_2
	arg_17_0.allIds = var_2.GetAllGuardianIds(var_0_1.BIND_LOTTERY_ACT_ID)

	arg_17_0:UpdateMainView()
	arg_17_0:UpdateSelectViewUI()

	return
end

function var_0_1.OpenSelectView(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.mainViewTF, false)

	setActive = var_1_10001

	var_1_10001(arg_19_0.selectViewTF, true)
	arg_19_0:UpdateSelectViewUI()

	return
end

function var_0_1.CloseSelectView(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.mainViewTF, true)

	setActive = var_1_10001

	var_1_10001(arg_20_0.selectViewTF, false)
	arg_20_0:UpdateMainView()

	return
end

function var_0_1.OnDestroy(arg_21_0)
	return
end

return var_0_1
