local var_0_0 = class("QWorldMaxMapInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
	arg_1_0:AddListeners()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.trackController = arg_2_0.m_controller:GetController("tracking")
	arg_2_0.BgController = arg_2_0.m_controller:GetController("bgstate")
	arg_2_0.IconTypeController = arg_2_0.m_iconController:GetController("type")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.callback_ then
			arg_3_0.callback_(arg_3_0.board)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.board = arg_5_2

	local var_5_0 = arg_5_2.inst.entityId
	local var_5_1 = false

	arg_5_0.trackController:SetSelectedIndex(var_5_1 and 0 or 1)

	if var_5_1 then
		arg_5_0.BgController:SetSelectedIndex(0)
	elseif arg_5_1 % 2 == 1 then
		arg_5_0.BgController:SetSelectedIndex(2)
	else
		arg_5_0.BgController:SetSelectedIndex(1)
	end

	arg_5_0.m_title.text = arg_5_0.board:GetName()

	local var_5_2, var_5_3 = arg_5_2:GetIcon()

	arg_5_0.IconTypeController:SetSelectedIndex(var_5_3)

	arg_5_0.m_icon.sprite = pureGetSpriteWithoutAtlas(var_5_2)

	arg_5_0:UpdateRedPoint()
end

function var_0_0.UpdateRedPoint(arg_6_0)
	local var_6_0 = arg_6_0.board
	local var_6_1 = false

	if var_6_0.tag == QWorldEntityMiniMapTag.Hud then
		local var_6_2 = nullable(SandplayTagCfg, var_6_0.param, "activityId")

		if var_6_2 then
			var_6_1 = manager.redPoint:getTipBoolean(ActivityTools.GetRedPointKey(var_6_2) .. var_6_2)
		end
	end

	manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, var_6_1)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

return var_0_0
