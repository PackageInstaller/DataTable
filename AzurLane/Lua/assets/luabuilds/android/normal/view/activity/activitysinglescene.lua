class = var_0_10000

local var_0_0 = "ActivitySingleScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.EXIT = "exit"

function var_0_1.preload(arg_1_0, arg_1_1)
	arg_1_1()

	return
end

function var_0_1.getUIName(arg_2_0)
	return "ActivitySingleUI"
end

function var_0_1.init(arg_3_0)
	ActivityShareData = var_1_10001
	arg_3_0.shareData = var_1_10001.New()
	arg_3_0.pageContainer = arg_3_0._tf
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:bind(var_0_1.EXIT, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.emit(var_5_0, var_0_1.ON_BACK)

		return
	end)

	return
end

function var_0_1.setPlayer(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.shareData

	var_2.SetPlayer(var_6_0, arg_6_1)

	return
end

function var_0_1.setFlagShip(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.shareData

	var_2.SetFlagShip(var_7_0, arg_7_1)

	return
end

function var_0_1.updateTaskLayers(arg_8_0)
	if not arg_8_0.activity then
		return
	end

	arg_8_0:updateActivity(arg_8_0.activity)

	return
end

function var_0_1.selectActivity(arg_9_0, arg_9_1)
	arg_9_0.activity = arg_9_1

	if arg_9_1:getConfig("page_info").class_name and not arg_9_1:isEnd() then
		import = var_3
		arg_9_0.actPage = var_3("view.activity.subPages." .. var_2.class_name).New(arg_9_0.pageContainer, arg_9_0.event, arg_9_0.contextData)

		local var_9_0 = arg_9_0.actPage

		if var_4.UseSecondPage(var_9_0, arg_9_1) then
			local var_9_1 = arg_9_0.actPage

			var_4.SetUIName(var_9_1, var_2.ui_name2)
		else
			local var_9_2 = arg_9_0.actPage

			var_4.SetUIName(var_9_2, var_2.ui_name)
		end

		local var_9_3 = arg_9_0.actPage

		var_4.SetShareData(var_9_3, arg_9_0.shareData)

		local var_9_4 = arg_9_0.actPage

		var_4.Load(var_9_4)

		local var_9_5 = arg_9_0.actPage

		var_4.ActionInvoke(var_9_5, "Flush", arg_9_0.activity)

		local var_9_6 = arg_9_0.actPage

		var_4.ActionInvoke(var_9_6, "ShowOrHide", true)
	end

	return
end

function var_0_1.updateActivity(arg_10_0, arg_10_1)
	ActivityConst = var_1_10002

	if var_1_10002.PageIdLink[arg_10_1.id] then
		getProxy = var_2
		ActivityProxy = var_3

		local var_10_0 = var_2(var_3)
		local var_10_1 = var_2.getActivityById

		ActivityConst = var_1_10004
		arg_10_1 = var_10_1(var_10_0, var_1_10004.PageIdLink[arg_10_1.id])
	end

	if arg_10_1:isShow() then
		local var_10_2 = arg_10_1
		local var_10_3 = arg_10_1.isCorePage
		local var_10_4

		if not arg_10_0.contextData.coreName then
			var_10_4 = ""
		end

		if var_10_3(var_10_2, var_10_4) and not arg_10_1:isEnd() and arg_10_0.activity and arg_10_0.activity.id == arg_10_1.id then
			arg_10_0.activity = arg_10_1

			local var_10_5 = arg_10_0.actPage

			var_2.ActionInvoke(var_10_5, "Flush", arg_10_1)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_11_0)
	local var_11_0 = arg_11_0.actPage

	var_1.ActionInvoke(var_11_0, "onBackPressed")
	arg_11_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.willExit(arg_12_0)
	arg_12_0.shareData = nil

	if arg_12_0.actPage then
		local var_12_0 = arg_12_0.actPage

		var_1.Destroy(var_12_0)
	end

	pg = var_1

	local var_12_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_1, arg_12_0._tf)

	return
end

return var_0_1
