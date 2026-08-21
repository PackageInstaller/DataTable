local var_0_0 = class("FireWorkHeadItem", ReduxView)

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
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(arg_4_0.id) then
			return
		end

		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1

	local var_6_0 = ActivityFireWorkCfg[arg_6_1]

	arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/role_small/" .. var_6_0.icon)

	arg_6_0:RefrenTime()

	if FireWorkData:GetInvited(arg_6_0.id) then
		arg_6_0.stateController:SetSelectedIndex(1)
	else
		arg_6_0.stateController:SetSelectedIndex(0)
	end

	manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%s", RedPointConst.FIRE_WORK, arg_6_0.id))
end

function var_0_0.OnExit(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.transform_)
end

function var_0_0.RefrenTime(arg_8_0)
	if ActivityData:GetActivityIsOpen(arg_8_0.id) then
		arg_8_0.lockController:SetSelectedIndex(0)
	else
		arg_8_0.lockController:SetSelectedIndex(1)

		local var_8_0 = manager.time:GetServerTime()
		local var_8_1 = ActivityData:GetActivityData(arg_8_0.id)

		if var_8_1 and var_8_0 < var_8_1.startTime then
			arg_8_0.m_lockLab.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_8_1.startTime))
		else
			arg_8_0.m_lockLab.text = GetTips("TIME_OVER")
		end
	end
end

function var_0_0.UpdateSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedIndex(arg_9_1 == arg_9_0.id and 1 or 0)
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.callback_ = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.transform_)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
