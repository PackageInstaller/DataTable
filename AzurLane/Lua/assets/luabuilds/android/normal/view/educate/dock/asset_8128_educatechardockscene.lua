class = var_0_10000

local var_0_0 = "EducateCharDockScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.ON_CLOSE_VIEW = "EducateCharDockScene.ON_CLOSE_VIEW"
var_0_1.ON_SELECT = "EducateCharDockScene.ON_SELECT"
var_0_1.ON_CONFIRM = "EducateCharDockScene.ON_CONFIRM"
var_0_1.ON_SELECTED = "EducateCharDockScene.ON_SELECTED"
var_0_1.MSG_CLEAR_TIP = "EducateCharDockScene.MSG_CLEAR_TIP"

function var_0_1.getUIName(arg_1_0)
	return "EducateCharDockUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "adapt/top/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "adapt/top/home")
	EducateCharSelectPage = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf

	arg_2_0.selectPage = var_2_2(var_2.Find(var_2_3, "adapt/pages"), arg_2_0.event)
	EducateCharGroupPage = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf

	arg_2_0.groupPage = var_2_4(var_2.Find(var_2_5, "adapt/pages/groupPage"), arg_2_0.event, arg_2_0.contextData)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		if arg_3_0.contextData.tbSkinId then
			local var_4_0 = arg_3_0

			var_0.closeView(var_4_0)

			return
		end

		if arg_3_0.selectPage then
			local var_4_1 = arg_3_0.selectPage

			if var_0.GetLoaded(var_4_1) then
				local var_4_2 = arg_3_0.selectPage

				if var_0.isShowing(var_4_2) then
					local var_4_3 = arg_3_0.selectPage

					var_0.Back(var_4_3, function()
						local var_5_0 = arg_3_0.groupPage

						var_0.Show(var_5_0)

						local var_5_1 = arg_3_0.groupPage

						var_0.InitList(var_5_1)

						local var_5_2 = arg_3_0.selectPage

						var_0.Hide(var_5_2)

						return
					end)

					return
				end
			end
		end

		local var_4_4 = arg_3_0

		var_0.closeView(var_4_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_6_0 = arg_3_0

		var_0.emit(var_6_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)
	arg_3_0:bind(var_0_1.ON_CLOSE_VIEW, function()
		local var_7_0 = arg_3_0

		var_0.closeView(var_7_0)

		return
	end)
	arg_3_0:bind(var_0_1.ON_SELECT, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_3_0.groupPage

		var_3.Hide(var_8_0)

		local var_8_1 = arg_3_0.selectPage

		var_3.ExecuteAction(var_8_1, "Update", arg_8_1, arg_8_2)

		return
	end)
	arg_3_0:bind(var_0_1.ON_SELECTED, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_3_0
		local var_9_1 = var_2.emit

		EducateCharDockMediator = var_2_10004

		var_9_1(var_9_0, var_2_10004.ON_SELECTED, arg_9_1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_CONFIRM, function(arg_10_0, arg_10_1)
		if arg_3_0.contextData.tbSkinId then
			local var_10_0 = arg_3_0

			var_2.closeView(var_10_0)

			return
		end

		local var_10_1 = arg_3_0.groupPage

		var_2.Show(var_10_1)

		local var_10_2 = arg_3_0.selectPage

		var_2.Hide(var_10_2)

		local var_10_3 = arg_3_0.groupPage

		var_2.FlushList(var_10_3, arg_10_1)

		return
	end)

	local var_3_6 = arg_3_0.groupPage

	var_1.Update(var_3_6)

	return
end

function var_0_1.onBackPressed(arg_11_0)
	if arg_11_0.selectPage then
		local var_11_0 = arg_11_0.selectPage

		if var_1.GetLoaded(var_11_0) then
			local var_11_1 = arg_11_0.selectPage

			if var_1.isShowing(var_11_1) then
				triggerButton = var_1

				var_1(arg_11_0.backBtn)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_11_0)

	return
end

function var_0_1.willExit(arg_12_0)
	if arg_12_0.selectPage then
		local var_12_0 = arg_12_0.selectPage

		var_1.Destroy(var_12_0)

		arg_12_0.selectPage = nil
	end

	if arg_12_0.groupPage then
		local var_12_1 = arg_12_0.groupPage

		var_1.Destroy(var_12_1)

		arg_12_0.groupPage = nil
	end

	return
end

return var_0_1
