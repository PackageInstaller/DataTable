local var_0_0 = class("MonopolyCar2024Scene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MonopolyCar2024UI"
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:UpdateGame((getProxy(ActivityProxy):getActivityById(arg_3_0.contextData.actId)))

	return
end

function var_0_0.UpdateGame(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	if arg_4_0.gameUI then
		arg_4_0.gameUI:UpdateActivity(arg_4_0.activity)
	else
		arg_4_0.gameUI = arg_4_0:NewGame()

		arg_4_0.gameUI:Setup()
	end

	return
end

function var_0_0.UpdateStory(arg_5_0)
	if not arg_5_0.gameUI then
		return
	end

	arg_5_0.gameUI:UpdateStory()

	return
end

function var_0_0.NewGame(arg_6_0)
	return MonopolyCar2024Game.New(arg_6_0.activity, arg_6_0._tf:Find("adapt"), arg_6_0.event)
end

function var_0_0.onBackPressed(arg_7_0)
	if arg_7_0.gameUI and arg_7_0.gameUI.isBlocksRaycasts then
		return
	end

	var_0_0.super.onBackPressed(arg_7_0)

	return
end

function var_0_0.willExit(arg_8_0)
	if arg_8_0.gameUI then
		arg_8_0.gameUI:Dispose()

		arg_8_0.gameUI = nil
	end

	return
end

return var_0_0
