local var_0_0 = class("HellaSlayerItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lineController = ControllerUtil.GetController(arg_3_0.transform_, "line")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.m_regionTrans, "state")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.m_regionTrans, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_regionBtn, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.slayer_activity_id = arg_6_2
	arg_6_0.region_activity_id = arg_6_3
	arg_6_0.index = arg_6_1

	if arg_6_1 == 1 then
		arg_6_0.lineController:SetSelectedIndex(1)

		arg_6_0.m_region.anchoredPosition = Vector3.New(0, -80, 0)
	elseif arg_6_1 % 2 == 0 then
		arg_6_0.lineController:SetSelectedIndex(2)

		arg_6_0.m_region.anchoredPosition = Vector3.New(0, 140, 0)
	elseif arg_6_1 % 2 == 1 then
		arg_6_0.lineController:SetSelectedIndex(3)

		arg_6_0.m_region.anchoredPosition = Vector3.New(0, -240, 0)
	else
		arg_6_0.lineController:SetSelectedIndex(0)
	end

	if arg_6_4 then
		arg_6_0.lineController:SetSelectedIndex(0)
	end

	local var_6_0 = ActivitySlayerCfg[arg_6_3]

	arg_6_0.m_name.text = GetI18NText(var_6_0.name)

	local var_6_1 = SlayerData:GetPoint(arg_6_0.slayer_activity_id, arg_6_0.region_activity_id)

	arg_6_0.m_maxPointLab.text = var_6_1

	arg_6_0:RefreshTime()
end

function var_0_0.RefreshTime(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0.region_activity_id)

	if var_7_0 and var_7_0:IsActivitying() then
		arg_7_0.stateController:SetSelectedIndex(1)
	else
		arg_7_0.stateController:SetSelectedIndex(0)

		if manager.time:GetServerTime() >= var_7_0.stopTime then
			arg_7_0.m_countDownLab.text = GetTips("TIME_OVER")
		else
			arg_7_0.m_countDownLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_7_0.startTime))
		end
	end
end

function var_0_0.SetSelectedIndex(arg_8_0, arg_8_1)
	arg_8_0.selectController:SetSelectedIndex(arg_8_1 == arg_8_0.index and 1 or 0)
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
