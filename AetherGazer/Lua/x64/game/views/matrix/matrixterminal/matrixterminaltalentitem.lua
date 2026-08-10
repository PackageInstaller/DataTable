local var_0_0 = class("MatrixTerminalTalentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.id, arg_3_0)
		end
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.id = arg_5_1

	arg_5_0.selectController_:SetSelectedIndex(arg_5_1 == arg_5_3 and 1 or 0)
	arg_5_0:RefreshData(arg_5_2, arg_5_4)
end

function var_0_0.RefreshData(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.id then
		return
	end

	local var_6_0 = arg_6_0.id
	local var_6_1 = arg_6_1[var_6_0] or 0
	local var_6_2 = MatrixTerminalGiftCfg[var_6_0]
	local var_6_3 = getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixTerminal/" .. var_6_2.icon)

	arg_6_0.m_grayIcon.sprite = var_6_3
	arg_6_0.m_icon.sprite = var_6_3

	local var_6_4 = var_6_2.pre_id
	local var_6_5 = arg_6_1[var_6_4] or 0
	local var_6_6 = var_6_4 ~= 0 and var_6_5 == 0

	if var_6_2.limit_level > MatrixData:GetTerminalLevel() or var_6_6 then
		arg_6_0.stateController_:SetSelectedIndex(0)

		return
	end

	local var_6_7 = #var_6_2.effect_id_list

	if var_6_7 <= var_6_1 then
		arg_6_0.stateController_:SetSelectedIndex(2)

		arg_6_0.m_levelLab.text = "MAX"
	else
		arg_6_0.m_levelLab.text = var_6_1 .. "/" .. var_6_7

		local var_6_8 = var_6_1 + 1
		local var_6_9 = var_6_2.cost[var_6_8] or 0

		arg_6_0.stateController_:SetSelectedIndex(arg_6_2 < var_6_9 and 2 or 1)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.SetChoice(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedIndex(arg_8_0.id == arg_8_1 and 1 or 0)
end

function var_0_0.SetScrollEnable(arg_9_0, arg_9_1)
	arg_9_0.m_scroll.enabled = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
