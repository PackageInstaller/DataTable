class = var_0_10000

local var_0_0 = "EducateTopPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateTopPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_0, "content/btns/help")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "content/btns/home")

	local var_2_2

	if arg_2_0.contextData then
		var_2_2 = arg_2_0.contextData.hideBack
	end

	setActive = var_1_10002

	var_1_10002(arg_2_0.homeBtn, not var_2_2)

	local var_2_3 = arg_2_0._tf

	arg_2_0.refresh = var_2.Find(var_2_3, "content/btns/refresh")

	arg_2_0:addListener()

	return
end

function var_0_1.addListener(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.refresh

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		EducateBaseUI = var_2_10003

		local var_4_2 = var_2_10003.EDUCATE_ON_MSG_TIP
		local var_4_3 = {}

		i18n = var_2_10005
		var_4_3.content = var_2_10005("child_refresh_sure_tip")

		function var_4_3.onYes()
			pg = var_3_10000

			local var_5_0 = var_3_10000.m02
			local var_5_1 = var_0.sendNotification

			GAME = var_3_10003

			var_5_1(var_5_0, var_3_10003.EDUCATE_REFRESH)

			return
		end

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.child_main_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.homeBtn

	local function var_3_8()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		EducateBaseUI = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
