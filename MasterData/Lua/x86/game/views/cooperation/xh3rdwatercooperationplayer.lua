local XH3rdWaterCooperationPlayer = class("XH3rdWaterCooperationPlayer", (import("game.views.cooperation.CooperationPlayer")))

function XH3rdWaterCooperationPlayer:Init()
	XH3rdWaterCooperationPlayer.super.Init(self)
	SetActive(self.m_heroInfoBtn.gameObject, false)
end

function XH3rdWaterCooperationPlayer:GotoTeamInfo()
	self:Go("/xH3rdWaterCooperationTeamInfo", {
		mainActivityID = ActivityCfg.get_id_list_by_sub_activity_list[CooperationData:GetRoomData().activity_id][1]
	})
end

return XH3rdWaterCooperationPlayer
