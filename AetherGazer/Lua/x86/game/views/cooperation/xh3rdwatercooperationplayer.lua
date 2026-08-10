local var_0_0 = import("game.views.cooperation.CooperationPlayer")
local var_0_1 = class("XH3rdWaterCooperationPlayer", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)
	SetActive(arg_1_0.m_heroInfoBtn.gameObject, false)
end

function var_0_1.GotoTeamInfo(arg_2_0)
	local var_2_0 = CooperationData:GetRoomData()
	local var_2_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_2_0.activity_id][1]

	arg_2_0:Go("/xH3rdWaterCooperationTeamInfo", {
		mainActivityID = var_2_1
	})
end

return var_0_1
