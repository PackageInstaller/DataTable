class = var_0_10000

local var_0_0 = "MetaPTGetPreviewLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaPTGetPreviewUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initUITextTips(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1

	var_5_1, setText = var_1.Find(var_5_0, "Panel/BG/TitleText"), var_1_10002
	i18n = var_1_10005

	var_1_10002(var_5_1, var_1_10005("meta_pt_get_way"))

	return
end

function var_0_1.initData(arg_6_0)
	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "BG")

	local var_7_1 = arg_7_0._tf

	arg_7_0.panelTF = var_1.Find(var_7_1, "Panel")

	local var_7_2 = arg_7_0.panelTF

	arg_7_0.bossBtn = var_1.Find(var_7_2, "BossTip")

	local var_7_3 = arg_7_0.panelTF

	arg_7_0.taskBtn = var_1.Find(var_7_3, "TaskTip")

	local var_7_4 = arg_7_0.panelTF

	arg_7_0.resetBtn = var_1.Find(var_7_4, "ResetTip")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.panelTF

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	local function var_8_6()
		getProxy = var_2_10000
		ContextProxy = var_2_10002

		local var_11_0 = var_2_10000(var_2_10002)
		local var_11_1 = var_0.getContextByMediator

		MetaCharacterMediator = var_2_10003

		local var_11_2 = var_11_1(var_11_0, var_2_10003)

		pg = var_2_10001

		local var_11_3 = var_2_10001.m02
		local var_11_4 = var_1.retrieveMediator(var_11_3, "MetaCharacterMediator")

		var_11_2.data.lastPageIndex = var_11_4.viewComponent.curPageIndex

		local var_11_5 = arg_8_0

		var_2.closeView(var_11_5)

		local var_11_6 = arg_8_0
		local var_11_7 = var_2.sendNotification

		GAME = var_2_10005

		local var_11_8 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_11_7(var_11_6, var_11_8, var_2_10006.WORLDBOSS)

		getProxy = var_11_7
		ContextProxy = var_11_6

		local var_11_9 = var_11_7(var_11_6)
		local var_11_10 = var_2.getContextByMediator

		MetaCharacterSynMediator = var_11_8

		if var_11_10(var_11_9, var_11_8) then
			var_11_2:removeChild(var_2)
		end

		return
	end

	onButton = var_1_10002

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0.bossBtn
	local var_8_9 = var_8_6

	SFX_PANEL = var_1_10007

	var_1_10002(var_8_7, var_8_8, var_8_9, var_1_10007)

	onButton = var_1_10002

	local var_8_10 = arg_8_0
	local var_8_11 = arg_8_0.taskBtn
	local var_8_12 = var_8_6

	SFX_PANEL = var_1_10007

	var_1_10002(var_8_10, var_8_11, var_8_12, var_1_10007)

	onButton = var_1_10002

	local var_8_13 = arg_8_0
	local var_8_14 = arg_8_0.resetBtn
	local var_8_15 = var_8_6

	SFX_PANEL = var_1_10007

	var_1_10002(var_8_13, var_8_14, var_8_15, var_1_10007)

	return
end

return var_0_1
