local var_0_0 = class("ActivityAttributeArenaRoundItem", ReduxView)

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

	arg_3_0.list = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, ActivityAttributeArenaTagItem)
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "stateBtn")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ActivityAttributeArenaRoundCfg[arg_5_1]

	arg_5_0.m_lab.text = GetTipsF("ACTIVITY_ATTRIBUTE_ARENE_ROUND", var_5_0.round)

	local var_5_1 = ActivityAttributeArenaData:GetRound(arg_5_2)
	local var_5_2 = ActivityData:GetActivityRefreshTime(arg_5_0.activity_id)

	if var_5_1 == var_5_0.round then
		arg_5_0.stateController:SetSelectedIndex(0)

		arg_5_0.m_timeLab.text = GetTips("ACTIVITY_ATTRIBUTE_ARENE_ROUND_START")
	elseif var_5_1 < var_5_0.round then
		arg_5_0.stateController:SetSelectedIndex(1)

		local var_5_3 = var_5_0.round - var_5_1
		local var_5_4 = ActivityData:GetActivityRefreshTimeList(arg_5_2)

		if var_5_3 <= #var_5_4 then
			local var_5_5 = var_5_4[var_5_3]

			arg_5_0.m_timeLab.text = GetTipsF("ACTIVITY_ATTRIBUTE_ARENE_ROUND_TIME", manager.time:GetLostTimeStr2(var_5_5))
		else
			arg_5_0.m_timeLab.text = ""
		end
	else
		arg_5_0.stateController:SetSelectedIndex(2)

		arg_5_0.m_timeLab.text = GetTips("ACTIVITY_ATTRIBUTE_ARENE_ROUND_OVER")
	end

	arg_5_0.listData = var_5_0.arena_id_list

	arg_5_0.list:StartScroll(#arg_5_0.listData)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.list:Dispose()
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.listData[arg_7_1]

	arg_7_2:SetData(var_7_0)
end

return var_0_0
