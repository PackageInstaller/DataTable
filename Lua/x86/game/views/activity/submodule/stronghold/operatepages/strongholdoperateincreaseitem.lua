local var_0_0 = class("StrongholdOperateIncreaseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.node_id = arg_1_2

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
	arg_3_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. arg_3_0.node_id)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.node_id, true, arg_4_0)
		end
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[arg_6_0.node_id][arg_6_1 + 1]
	local var_6_1 = ActivityStrongholdIncreaseCfg[var_6_0]

	if arg_6_1 == 0 then
		arg_6_0.lockController:SetSelectedIndex(1)
	elseif not var_6_1 then
		arg_6_0.lockController:SetSelectedIndex(2)

		arg_6_0.m_lvLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
	else
		arg_6_0.lockController:SetSelectedIndex(0)

		arg_6_0.m_lvLab.text = "Lv" .. arg_6_1
	end

	if var_6_1 and arg_6_2 >= var_6_1.cost then
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, false)
	end
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedIndex(arg_7_1 == arg_7_0.node_id and 1 or 0)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

return var_0_0
