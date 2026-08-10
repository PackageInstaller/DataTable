local var_0_0 = class("PolyhedronBeaconOperateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_unlockBtn, nil, function()
		PolyhedronAction.QueryUnlockBeacon(arg_3_0.id)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id = arg_5_1
	arg_5_0.transform_.name = arg_5_1

	arg_5_0:Refresh()
end

function var_0_0.Refresh(arg_6_0)
	local var_6_0 = PolyhedronBeaconCfg[arg_6_0.id]

	arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. var_6_0.icon)
	arg_6_0.m_name.text = GetI18NText(var_6_0.name)
	arg_6_0.m_des.text = GetI18NText(var_6_0.desc)

	if PolyhedronData:GetBeaconIsLock(arg_6_0.id) then
		local var_6_1, var_6_2, var_6_3 = PolyhedronTools.GetBeaconIsUnlockCondition(arg_6_0.id)

		if not var_6_1 then
			arg_6_0.stateController_:SetSelectedIndex(1)

			local var_6_4 = var_6_0.condition

			var_6_2 = var_6_2 or 0
			var_6_3 = var_6_3 or 0
			arg_6_0.m_processText.text = var_6_2 .. "/" .. var_6_3
			arg_6_0.m_processImg.fillAmount = var_6_3 == 0 and 0 or var_6_2 / var_6_3
			arg_6_0.m_lockTip.text = GetI18NText(ConditionCfg[var_6_4].desc)
		else
			arg_6_0.stateController_:SetSelectedIndex(2)
		end
	else
		arg_6_0.stateController_:SetSelectedIndex(0)
	end
end

return var_0_0
