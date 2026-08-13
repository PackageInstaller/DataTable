class = var_0_10000

local var_0_0 = "MonopolyCar2026SetNamePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MonopolyCar2026SetNameUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.input = var_1.Find(var_2_1, "main/input")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bgTr = var_1.Find(var_2_2, "bg")
	setText = var_1

	local var_2_3 = arg_2_0.confirmBtn
	local var_2_4 = var_2.Find(var_2_3, "Text")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("word_ok"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001)
		local var_4_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		if not var_4_1(var_4_0, var_2_10003.ACTIVITY_TYPE_MONOPOLY) or var_1:isEnd() then
			if arg_3_0.callback then
				arg_3_0.callback()
			end

			return
		end

		local var_4_2 = var_1
		local var_4_3 = var_1.getConfig(var_4_2, "config_client").link_act

		getInputText = var_4_2

		if var_4_2(arg_3_0.input) == "" then
			return
		end

		nameValidityCheck = var_4

		if not var_4(var_3, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"playerinfo_mask_word"
		}) then
			return
		end

		pg = var_4

		local var_4_4 = var_4.m02
		local var_4_5 = var_4.sendNotification

		GAME = var_6

		var_4_5(var_4_4, var_6.ACTIVITY_STORE_DATE, {
			intValue = 0,
			activity_id = var_4_3,
			strValue = var_3 or "",
			callback = function()
				if arg_3_0.callback then
					arg_3_0.callback()
				end

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	arg_6_0.callback = arg_6_1

	var_0_1.super.Show(arg_6_0)
	arg_6_0:BlurPanel()

	return
end

function var_0_1.BlurPanel(arg_7_0)
	setParent = var_1_10001

	local var_7_0 = arg_7_0.bgTr

	pg = var_1_10003

	var_1_10001(var_7_0, var_1_10003.NewStoryMgr.GetInstance()._go)

	setParent = var_1_10001
	pg = var_7_0

	local var_7_1 = var_7_0.NewStoryMgr.GetInstance()._go

	pg = var_3

	var_1_10001(var_7_1, var_3.UIMgr.GetInstance().UIMain)

	pg = var_1_10001

	local var_7_2 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_2, arg_7_0._tf)

	return
end

function var_0_1.UnBlurPanel(arg_8_0)
	setParent = var_1_10001

	var_1_10001(arg_8_0.bgTr, arg_8_0._tf)

	local var_8_0 = arg_8_0.bgTr

	var_1.SetAsFirstSibling(var_8_0)

	setParent = var_1
	pg = var_8_0

	local var_8_1 = var_8_0.NewStoryMgr.GetInstance()._go

	pg = var_3

	var_1(var_8_1, var_3.UIMgr.GetInstance().OverlayToast)

	pg = var_1

	local var_8_2 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_2, arg_8_0._tf, arg_8_0._parentTf)

	return
end

function var_0_1.Hide(arg_9_0)
	arg_9_0:UnBlurPanel()
	var_0_1.super.Hide(arg_9_0)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0.callback = nil

	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_1
