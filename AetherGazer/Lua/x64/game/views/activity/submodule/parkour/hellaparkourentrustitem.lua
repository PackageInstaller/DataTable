local var_0_0 = class("HellaParkourEntrustItem", ReduxView)

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

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.lockController = ControllerUtil.GetController(arg_3_0.transform_, "lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index = arg_6_1
	arg_6_0.entrust_activity_id = arg_6_2

	local var_6_0 = ActivityParkourCfg[arg_6_2]

	arg_6_0.m_name.text = GetI18NText(var_6_0.name)

	arg_6_0:RefreshTime()

	local var_6_1 = ParkourData:GetParkourEntrustData(arg_6_2)

	for iter_6_0 = 1, 4 do
		local var_6_2 = arg_6_0["m_star" .. iter_6_0]

		if var_6_2 then
			if var_6_1 then
				local var_6_3 = not not table.indexof(var_6_1.stars, iter_6_0)

				SetActive(var_6_2, var_6_3)
			else
				SetActive(var_6_2, false)
			end
		end
	end

	manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, arg_6_2))
end

function var_0_0.RefreshTime(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0.entrust_activity_id)

	if var_7_0:IsActivitying() then
		arg_7_0.lockController:SetSelectedIndex(0)
	else
		arg_7_0.lockController:SetSelectedIndex(1)

		if manager.time:GetServerTime() >= var_7_0.stopTime then
			arg_7_0.m_lockLab.text = GetTips("TIME_OVER")
		else
			arg_7_0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_7_0.startTime))
		end
	end
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.SetSelectedIndex(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedIndex(arg_9_1 == arg_9_0.index and 1 or 0)
end

function var_0_0.Dispose(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.transform_)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
