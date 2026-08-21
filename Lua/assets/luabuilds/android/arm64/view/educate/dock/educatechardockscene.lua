local var_0_0 = class("EducateCharDockScene", import("view.base.BaseUI"))

var_0_0.ON_CLOSE_VIEW = "EducateCharDockScene.ON_CLOSE_VIEW"
var_0_0.ON_SELECT = "EducateCharDockScene.ON_SELECT"
var_0_0.ON_CONFIRM = "EducateCharDockScene.ON_CONFIRM"
var_0_0.ON_SELECTED = "EducateCharDockScene.ON_SELECTED"
var_0_0.MSG_CLEAR_TIP = "EducateCharDockScene.MSG_CLEAR_TIP"

function var_0_0.getUIName(arg_1_0)
	return "EducateCharDockUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("adapt/top/back")
	arg_2_0.homeBtn = arg_2_0._tf:Find("adapt/top/home")
	arg_2_0.selectPage = EducateCharSelectPage.New(arg_2_0._tf:Find("adapt/pages"), arg_2_0.event)
	arg_2_0.groupPage = EducateCharGroupPage.New(arg_2_0._tf:Find("adapt/pages/groupPage"), arg_2_0.event, arg_2_0.contextData)

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		if arg_3_0.contextData.tbSkinId then
			arg_3_0:closeView()

			return
		end

		if arg_3_0.selectPage and arg_3_0.selectPage:GetLoaded() and arg_3_0.selectPage:isShowing() then
			arg_3_0.selectPage:Back(function()
				arg_3_0.groupPage:Show()
				arg_3_0.groupPage:InitList()
				arg_3_0.selectPage:Hide()

				return
			end)

			return
		end

		arg_3_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	arg_3_0:bind(var_0_0.ON_CLOSE_VIEW, function()
		arg_3_0:closeView()

		return
	end)
	arg_3_0:bind(var_0_0.ON_SELECT, function(arg_8_0, arg_8_1, arg_8_2)
		arg_3_0.groupPage:Hide()
		arg_3_0.selectPage:ExecuteAction("Update", arg_8_1, arg_8_2)

		return
	end)
	arg_3_0:bind(var_0_0.ON_SELECTED, function(arg_9_0, arg_9_1)
		arg_3_0:emit(EducateCharDockMediator.ON_SELECTED, arg_9_1)

		return
	end)
	arg_3_0:bind(var_0_0.ON_CONFIRM, function(arg_10_0, arg_10_1)
		if arg_3_0.contextData.tbSkinId then
			arg_3_0:closeView()

			return
		end

		arg_3_0.groupPage:Show()
		arg_3_0.selectPage:Hide()
		arg_3_0.groupPage:FlushList(arg_10_1)

		return
	end)
	arg_3_0.groupPage:Update()

	return
end

function var_0_0.onBackPressed(arg_11_0)
	if arg_11_0.selectPage and arg_11_0.selectPage:GetLoaded() and arg_11_0.selectPage:isShowing() then
		triggerButton(arg_11_0.backBtn)

		return
	end

	var_0_0.super.onBackPressed(arg_11_0)

	return
end

function var_0_0.willExit(arg_12_0)
	if arg_12_0.selectPage then
		arg_12_0.selectPage:Destroy()

		arg_12_0.selectPage = nil
	end

	if arg_12_0.groupPage then
		arg_12_0.groupPage:Destroy()

		arg_12_0.groupPage = nil
	end

	return
end

return var_0_0
