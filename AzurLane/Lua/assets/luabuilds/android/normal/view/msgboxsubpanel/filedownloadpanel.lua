class = var_0_10000

local var_0_0 = "FileDownloadPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "FileDownloadBox"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.UpdateView(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.onYes

	function arg_3_1.onYes()
		pg = var_2_10000

		local var_4_0 = var_2_10000.FileDownloadMgr.GetInstance()

		var_0.SetRemind(var_4_0, arg_3_0.curStopValue)
		var_3_0()

		return
	end

	arg_3_0:PreRefresh(arg_3_1)

	setText = var_3

	var_3(arg_3_0.contextText, arg_3_1.content)

	rtf = var_3

	local var_3_1 = var_3(arg_3_0.viewParent._window)

	Vector2 = var_4
	var_3_1.sizeDelta = var_4.New(1000, 638)
	setActive = var_3_1

	var_3_1(arg_3_0.toggleTF, not arg_3_1.hideToggle)
	arg_3_0:PostRefresh(arg_3_1)

	return
end

function var_0_1.findUI(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.contextText = var_1.Find(var_5_0, "Context")

	local var_5_1 = arg_5_0._tf

	arg_5_0.toggleTF = var_1.Find(var_5_1, "Toggle")

	local var_5_2 = arg_5_0.toggleTF

	arg_5_0.tickTF = var_1.Find(var_5_2, "Tip/TickBG/Tick")

	return
end

function var_0_1.addListener(arg_6_0)
	arg_6_0.curStopValue = false
	onToggle = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.toggleTF

	local function var_6_2(arg_7_0)
		arg_6_0.curStopValue = arg_7_0

		return
	end

	SFX_CONFIRM = var_1_10005
	SFX_CANCEL = var_1_10006

	var_1(var_6_0, var_6_1, var_6_2, var_1_10005, var_1_10006)

	return
end

return var_0_1
