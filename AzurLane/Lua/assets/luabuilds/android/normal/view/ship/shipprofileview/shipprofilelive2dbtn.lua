class = var_0_10000

local var_0_0 = var_0_10000("ShipProfileLive2dBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0.live2dBtn = arg_1_1

	local var_1_0 = arg_1_0.live2dBtn

	arg_1_0.live2dToggle = var_2.Find(var_1_0, "toggle")

	local var_1_1 = arg_1_0.live2dBtn

	arg_1_0.live2dState = var_2.Find(var_1_1, "state")

	local var_1_2 = arg_1_0.live2dToggle

	arg_1_0.live2dOn = var_2.Find(var_1_2, "on")

	local var_1_3 = arg_1_0.live2dToggle

	arg_1_0.live2dOff = var_2.Find(var_1_3, "off")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	Live2dConst = var_1_10003

	if var_1_10003.GetLive2DArm32MatchAble() then
		arg_2_2 = false
	end

	arg_2_0.paintingName = arg_2_1
	arg_2_0.isOn = arg_2_2
	BundleWizard = var_3

	local var_2_0 = var_3.Inst
	local var_2_1 = var_3.GetGroupMgr(var_2_0, "L2D")
	local var_2_2 = "live2d/"

	string = var_5

	local var_2_3 = var_2_2 .. var_5.lower(arg_2_1)

	HXSet = var_5

	local var_2_4 = var_5.autoHxShiftPath(var_2_3, nil, true)
	local var_2_5 = var_2_1
	local var_2_6 = var_2_1.CheckF(var_2_5, var_2_4)

	warning = var_2_5

	local var_2_7 = "OnCheckToUpdate state = "

	tostring = var_8

	var_2_5(var_2_7 .. var_8(var_2_6))

	DownloadState = var_2_5

	if var_2_6 ~= var_2_5.CheckToUpdate then
		DownloadState = var_6

		if var_2_6 == var_6.UpdateFailure then
			arg_2_0:OnCheckToUpdate(var_2_4)
		else
			arg_2_0:OnUpdated(var_2_4, arg_2_2)
		end

		return
	end
end

function var_0_0.OnCheckToUpdate(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.live2dBtn, true)

	setActive = var_1_10002

	var_1_10002(arg_3_0.live2dState, false)

	setActive = var_1_10002

	var_1_10002(arg_3_0.live2dToggle, true)

	setActive = var_1_10002

	var_1_10002(arg_3_0.live2dOn, false)

	setActive = var_1_10002

	var_1_10002(arg_3_0.live2dOff, true)

	onButton = var_1_10002

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.live2dBtn

	local function var_3_2()
		local var_4_0 = "L2D"
		local var_4_1 = {
			arg_3_1
		}
		local var_4_2 = var_4_0 .. arg_3_1

		GroupHelper = var_3

		local var_4_3 = var_3.CalcSizeWithFileArr(var_4_0, var_4_1)

		HashUtil = var_4

		local var_4_4 = var_4.BytesToString(var_4_3)

		pg = var_5

		local var_4_5 = var_5.MsgboxMgr.GetInstance()
		local var_4_6 = var_5.ShowMsgBox
		local var_4_7 = {}

		MSGBOX_TYPE_NORMAL = var_2_10008
		var_4_7.type = var_2_10008
		string = var_2_10008

		local var_4_8 = var_2_10008.format

		i18n = var_2_10009
		var_4_7.content = var_4_8(var_2_10009("group_download_tip", var_4_4))

		function var_4_7.onYes()
			local function var_5_0(arg_6_0, arg_6_1)
				if not arg_3_0.isDisposed then
					arg_3_0.isOn = arg_6_0

					local var_6_0 = arg_3_0

					var_2.OnUpdated(var_6_0, arg_3_1, arg_3_0.isOn)
				end

				return
			end

			BundleWizardUpdater = var_3_10001

			local var_5_1 = var_3_10001.Inst
			local var_5_2 = var_1.GetFileList(var_5_1, var_4_0, var_4_1)

			BundleWizardUpdater = var_5_1

			local var_5_3 = var_5_1.Inst
			local var_5_4 = var_2.CreateListInfo(var_5_3, var_4_2, var_5_2, nil, var_5_0, nil)

			BundleWizardUpdater = var_5_3

			local var_5_5 = var_5_3.Inst

			var_3.StartUpdate(var_5_5, var_5_4)

			return
		end

		var_4_6(var_4_5, var_4_7)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_0.OnUpdated(arg_7_0, arg_7_1, arg_7_2)
	checkABExist = var_1_10003

	local var_7_0 = var_1_10003(arg_7_1)

	warning = var_4

	local var_7_1 = "fileExist = "

	tostring = var_1_10006

	var_4(var_7_1 .. var_1_10006(var_7_0))

	setActive = var_4

	var_4(arg_7_0.live2dBtn, var_7_0)

	setActive = var_4

	var_4(arg_7_0.live2dState, false)

	setActive = var_4

	var_4(arg_7_0.live2dToggle, true)

	setActive = var_4

	var_4(arg_7_0.live2dOn, arg_7_2)

	setActive = var_4

	var_4(arg_7_0.live2dOff, not arg_7_2)

	onButton = var_4

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.live2dBtn

	local function var_7_4()
		Live2dConst = var_2_10000

		if var_2_10000.GetLive2DArm32MatchAble() then
			Live2dConst = var_0

			var_0.ShowLive2DArm32Tips()
		end

		local var_8_0 = arg_7_0

		var_0.Update(var_8_0, arg_7_0.paintingName, not arg_7_0.isOn)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_7_2, var_7_3, var_7_4, var_1_10008)

	if arg_7_0.callback then
		arg_7_0.callback(arg_7_0.isOn)
	end

	return
end

function var_0_0.Disable(arg_9_0)
	if arg_9_0.isOn then
		triggerButton = var_1

		var_1(arg_9_0.live2dBtn)
	end

	return
end

function var_0_0.SetEnable(arg_10_0, arg_10_1)
	setButtonEnabled = var_1_10002

	var_1_10002(arg_10_0.live2dBtn, arg_10_1)

	return
end

function var_0_0.AddListener(arg_11_0, arg_11_1)
	arg_11_0.callback = arg_11_1

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.callback = nil
	arg_12_0.isDisposed = true
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_12_0)

	return
end

return var_0_0
