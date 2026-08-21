local var_0_0 = class("ActivityAttributeArenaRoundView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return AttributeArenaTools.GetRoundUI(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, ActivityAttributeArenaRoundItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_mask, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activity_id = arg_8_0.params_.activityID
	arg_8_0.listData = ActivityAttributeArenaRoundCfg.get_id_list_by_activity_id[arg_8_0.activity_id] or {}

	local var_8_0 = ActivityAttributeArenaData:GetRound(arg_8_0.activity_id)

	table.sort(arg_8_0.listData, function(arg_9_0, arg_9_1)
		local var_9_0 = ActivityAttributeArenaRoundCfg[arg_9_0].round
		local var_9_1 = ActivityAttributeArenaRoundCfg[arg_9_1].round
		local var_9_2

		var_9_2 = var_9_0 == var_8_0

		local var_9_3

		var_9_3 = var_9_1 == var_8_0

		if var_9_0 == var_8_0 then
			return true
		elseif var_9_1 == var_8_0 then
			return false
		elseif var_9_0 > var_8_0 and var_9_1 > var_8_0 then
			return var_9_0 < var_9_1
		elseif var_9_0 < var_8_0 and var_9_1 < var_8_0 then
			return var_9_0 < var_9_1
		else
			return var_9_0 > var_8_0
		end
	end)
	arg_8_0.list:StartScroll(#arg_8_0.listData)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.listData[arg_11_1]

	arg_11_2:SetData(var_11_0, arg_11_0.activity_id)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.list:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
