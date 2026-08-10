local var_0_0 = class("NaviBar", ReduxView)
local var_0_1 = import("game.const.TaskConst")
local var_0_2 = import("game.const.ViewConst")
local var_0_3 = import("game.tools.JumpTools")

function var_0_0.OnCtor(arg_1_0)
	return
end

function var_0_0.UIName(arg_2_0)
	return "UI/NaviBarUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.InitUI(arg_4_0)
	return
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener("navibar/topbtn/btn_userinfo", nil, function()
		gameContext:ClearHistroy()
		OpenPageUntilLoaded("/userinfo", nil, var_0_2.SYSTEM_ID.BACK_HOUSE)
	end)
	arg_5_0:AddBtnListener("navibar/topbtn/btn_document", nil, function()
		return
	end)
	arg_5_0:AddBtnListener("navibar/topbtn/btn_close", nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_hero", nil, function()
		gameContext:ClearHistroy()
		var_0_3.GoToSystem("/herolist", nil, var_0_2.SYSTEM_ID.HERO)
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_mission", nil, function()
		gameContext:ClearHistroy()
		var_0_3.GoToSystem("/task", {
			taskIndex = var_0_1.TASK_TYPE.DAILY
		}, var_0_2.SYSTEM_ID.TASK_PLOT)
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_battle", nil, function()
		gameContext:ClearHistroy()
		var_0_3.GoToSystem("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.MAIN
		})
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_shop", nil, function()
		gameContext:ClearHistroy()
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_mail", nil, function()
		return
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_lounge", nil, function()
		return
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_guild", nil, function()
		gameContext:ClearHistroy()
	end)
	arg_5_0:AddBtnListener("navibar/buildingbtn/btn_search", nil, function()
		gameContext:ClearHistroy()
		var_0_3.GoToSystem("/draw", nil, var_0_2.SYSTEM_ID.DRAW)
	end)
	arg_5_0:AddBtnListener("mask", nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListenerScale("btn_return", nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListenerScale("btn_last", nil, function()
		arg_5_0:Go("/home")
	end)
end

function var_0_0.Init(arg_20_0)
	arg_20_0:InitUI()
	arg_20_0:AddUIListener()
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
