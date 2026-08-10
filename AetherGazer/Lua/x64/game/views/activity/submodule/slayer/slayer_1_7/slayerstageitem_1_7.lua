local var_0_0 = import("game.views.activity.Submodule.slayer.volume.VolumeSlayerItem")
local var_0_1 = class("SlayerStageItem_1_7", var_0_0)

function var_0_1.SetData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:BindRedPoint(arg_1_3)

	arg_1_0.slayer_activity_id = arg_1_2
	arg_1_0.region_activity_id = arg_1_3
	arg_1_0.index = arg_1_1

	local var_1_0 = ActivitySlayerCfg[arg_1_3]

	arg_1_0.m_name.text = GetI18NText(var_1_0.name)

	local var_1_1 = SlayerData:GetPoint(arg_1_0.slayer_activity_id, arg_1_0.region_activity_id)

	if var_1_1 == 0 then
		arg_1_0.scoreController:SetSelectedIndex(0)
	else
		arg_1_0.scoreController:SetSelectedIndex(1)

		arg_1_0.m_maxPointLab.text = var_1_1
	end

	arg_1_0:RefreshTime()

	local var_1_2 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[arg_1_0.region_activity_id]
	local var_1_3 = ActivitySlayerPointRewardCfg[var_1_2[#var_1_2]].need

	SetActive(arg_1_0.m_completeGo, var_1_3 <= var_1_1)
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:UnbindRedPoint()
	var_0_1.super.Dispose(arg_2_0)
end

function var_0_1.BindRedPoint(arg_3_0, arg_3_1)
	if arg_3_0.region_activity_id == nil then
		local var_3_0 = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_3_1)

		manager.redPoint:bindUIandKey(arg_3_0.transform_, var_3_0)
	elseif arg_3_0.region_activity_id ~= arg_3_1 then
		local var_3_1 = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_3_0.region_activity_id)

		manager.redPoint:unbindUIandKey(arg_3_0.transform_, var_3_1)

		local var_3_2 = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_3_1)

		manager.redPoint:bindUIandKey(arg_3_0.transform_, var_3_2)
	end
end

function var_0_1.UnbindRedPoint(arg_4_0)
	local var_4_0 = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_4_0.region_activity_id)

	manager.redPoint:unbindUIandKey(arg_4_0.transform_, var_4_0)
end

return var_0_1
