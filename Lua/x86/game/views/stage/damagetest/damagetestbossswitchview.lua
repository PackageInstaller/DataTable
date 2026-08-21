local var_0_0 = class("BossSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/DamageTest/BossSwitchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, BossSwitchItem)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshData({
		id = arg_5_0.bossList_[arg_5_1],
		index = arg_5_1
	})
	arg_5_2:RegistCallBack(function(arg_6_0)
		JumpTools.GoToSystem("/damageTestBossInfo", {
			damageTestId = arg_6_0.id
		})
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	if arg_7_0.battleType_ == 0 then
		arg_7_0.nameText_.text = "DEAD MAN"
	elseif arg_7_0.battleType_ == 1 then
		arg_7_0.nameText_.text = "COMBAT"
	elseif arg_7_0.battleType_ == 3 then
		arg_7_0.nameText_.text = "MOVE MAN"
	end

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.bossList_)
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_8_0.battleType_ = arg_8_0.params_.battleType
	arg_8_0.bossList_ = DamageTestCfg.get_id_list_by_battle_type[arg_8_0.battleType_]

	arg_8_0:RefreshUI()
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
