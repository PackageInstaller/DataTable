class = var_0_10000

local var_0_0 = "MainCameraBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	arg_1_0:OpenCamera()

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._tf, true)

	return
end

function var_0_1.OpenCamera(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.SdkMgr.GetInstance()

	if var_1.IsYunPackage(var_3_0) then
		pg = var_1
		var_3_0 = var_1.TipsMgr.GetInstance()

		var_1.ShowTips(var_3_0, "指挥官，当前平台不支持该功能哦")

		return
	end

	local var_3_1
	local var_3_2

	local function var_3_3()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		NewMainMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_SNAPSHOT)

		return
	end

	local function var_3_4()
		PermissionHelper = var_2_10000

		local var_5_1

		if var_2_10000.IsAndroid() then
			pg = var_5_1

			local var_5_0 = var_5_1.MsgboxMgr.GetInstance()

			var_5_1 = var_5_1.ShowMsgBox

			local var_5_2 = {}

			i18n = var_2_10004
			var_5_2.content = var_2_10004("apply_permission_camera_tip3")

			function var_5_2.onYes()
				PermissionHelper = var_3_10000

				var_3_10000.RequestCamera(var_3_3, var_3_4)

				return
			end

			var_5_1(var_5_0, var_5_2)
		else
			PermissionHelper = var_5_1

			if var_5_1.IsIOS() then
				pg = var_0

				local var_5_3 = var_0.MsgboxMgr.GetInstance()
				local var_5_4 = var_0.ShowMsgBox
				local var_5_5 = {}

				i18n = var_2_10004
				var_5_5.content = var_2_10004("apply_permission_camera_tip2")

				var_5_4(var_5_3, var_5_5)
			end
		end

		return
	end

	pg = var_3_0

	local var_3_5 = var_3_0.MsgboxMgr.GetInstance()
	local var_3_6 = var_3.ShowMsgBox
	local var_3_7 = {}

	i18n = var_1_10007
	var_3_7.content = var_1_10007("apply_permission_camera_tip1")

	function var_3_7.onYes()
		PermissionHelper = var_2_10000

		var_2_10000.RequestCamera(var_3_3, var_3_4)

		return
	end

	var_3_6(var_3_5, var_3_7)

	return
end

return var_0_1
