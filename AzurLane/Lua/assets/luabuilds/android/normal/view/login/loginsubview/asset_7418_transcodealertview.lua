class = var_0_10000

local var_0_0 = "TranscodeAlertView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "TranscodeAlertView"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.transcodeAlert = arg_4_0._tf

	local var_4_0 = arg_4_0.transcodeAlert

	arg_4_0.tcSureBtn = var_1.Find(var_4_0, "transcode_sure")

	local var_4_1 = arg_4_0.transcodeAlert
	local var_4_2 = var_1.Find(var_4_1, "uid_input_txt")
	local var_4_3 = var_1.GetComponent

	typeof = var_3
	InputField = var_1_10004
	arg_4_0.uidTxt = var_4_3(var_4_2, var_3(var_1_10004))

	local var_4_4 = arg_4_0.transcodeAlert
	local var_4_5 = var_1.Find(var_4_4, "transcode_input_txt")
	local var_4_6 = var_1.GetComponent

	typeof = var_3
	InputField = var_1_10004
	arg_4_0.transcodeTxt = var_4_6(var_4_5, var_3(var_1_10004))

	local var_4_7 = arg_4_0.transcodeAlert

	arg_4_0.tcDesc = var_1.Find(var_4_7, "desc")
	setText = var_1

	local var_4_8 = arg_4_0.tcDesc

	i18n = var_3

	var_1(var_4_8, var_3("transcode_desc"))
	arg_4_0:InitEvent()

	return
end

function var_0_1.InitEvent(arg_5_0)
	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.tcSureBtn, function()
		local var_6_0 = arg_5_0.uidTxt.text
		local var_6_1 = arg_5_0.transcodeTxt.text

		if var_6_0 == "" or var_6_1 == "" then
			pg = var_2_10002

			local var_6_2 = var_2_10002.MsgboxMgr.GetInstance()

			var_2_10002 = var_2_10002.ShowMsgBox

			local var_6_3 = {
				hideNo = true
			}

			i18n = var_2_10005
			var_6_3.content = var_2_10005("transcode_empty_tip")

			var_2_10002(var_6_2, var_6_3)
		else
			pg = var_2_10002

			local var_6_4 = var_2_10002.SdkMgr.GetInstance()

			var_2.LoginWithTranscode(var_6_4, var_6_0, var_6_1)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.transcodeAlert, function()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
