local var_0_0 = class("DamageTestModeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/DamageTest/DamageTestModeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.btnTransform_, "conName")
	arg_3_0.deadManItem_ = DamageTestModeItem.New(arg_3_0.deadManGo_, 1)
	arg_3_0.combatItem_ = DamageTestModeItem.New(arg_3_0.combatGo_, 2)
	arg_3_0.moveManItem_ = DamageTestModeItem.New(arg_3_0.moveManGo_, 3)
	arg_3_0.chooseHandler_ = handler(arg_3_0, arg_3_0.ChooseItemMode)

	arg_3_0.deadManItem_:RegistClickFunc(arg_3_0.chooseHandler_)
	arg_3_0.combatItem_:RegistClickFunc(arg_3_0.chooseHandler_)
	arg_3_0.moveManItem_:RegistClickFunc(arg_3_0.chooseHandler_)
end

function var_0_0.ChooseItemMode(arg_4_0, arg_4_1)
	arg_4_0.chooseIndex_ = arg_4_1

	arg_4_0.deadManItem_:RefreshUI(arg_4_1)
	arg_4_0.combatItem_:RefreshUI(arg_4_1)
	arg_4_0.moveManItem_:RefreshUI(arg_4_1)
	arg_4_0:RefreshUI()
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_5_0:RefreshUI()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.chooseIndex_ = nil

	arg_6_0.deadManItem_:RefreshUI(arg_6_0.chooseIndex_)
	arg_6_0.combatItem_:RefreshUI(arg_6_0.chooseIndex_)
	arg_6_0.moveManItem_:RefreshUI(arg_6_0.chooseIndex_)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.chooseHandler_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.chooseBtn_, nil, function()
		if arg_8_0.chooseIndex_ == nil then
			return
		end

		arg_8_0:ClickBtn()
	end)
end

function var_0_0.ClickBtn(arg_10_0)
	if arg_10_0.chooseIndex_ == 1 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 0
		})
	elseif arg_10_0.chooseIndex_ == 2 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 1
		})
	elseif arg_10_0.chooseIndex_ == 3 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 2
		})
	end
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshMode(arg_11_0.chooseIndex_)
end

function var_0_0.RefreshMode(arg_12_0, arg_12_1)
	arg_12_0.chooseIndex_ = arg_12_1

	if arg_12_1 then
		arg_12_0.selectController_:SetSelectedState("yellow")
	else
		arg_12_0.selectController_:SetSelectedState("black")
	end
end

return var_0_0
