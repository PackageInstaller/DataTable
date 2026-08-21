local var_0_0 = class("GuildHeadIconSelect", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubSelect"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.controller = ControllerUtil.GetController(arg_3_0.transform_, "club")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.selectID_ = arg_4_0.params_.selectID

	arg_4_0.controller:SetSelectedState(tostring(arg_4_0.selectID_))
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonCancel_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonOk_, nil, function()
		manager.notify:Invoke(GUILD_SWITCH_HEAD_ICON, arg_7_0.selectID_)
		arg_7_0:Back()
	end)

	for iter_7_0 = 1, 5 do
		arg_7_0:AddBtnListener(arg_7_0["icon0" .. iter_7_0 .. "Btn_"], nil, function()
			arg_7_0.controller:SetSelectedState(tostring(iter_7_0))
			arg_7_0:SelectHeadIcon(iter_7_0)
		end)
	end
end

function var_0_0.SelectHeadIcon(arg_12_0, arg_12_1)
	arg_12_0.selectID_ = arg_12_1
end

return var_0_0
