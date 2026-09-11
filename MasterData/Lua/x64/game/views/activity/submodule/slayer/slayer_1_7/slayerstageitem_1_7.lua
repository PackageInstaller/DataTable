local SlayerStageItem_1_7 = class("SlayerStageItem_1_7", (import("game.views.activity.Submodule.slayer.volume.VolumeSlayerItem")))

function SlayerStageItem_1_7:SetData(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self:BindRedPoint(arg_1_3)

	self.slayer_activity_id = arg_1_2
	self.region_activity_id = arg_1_3
	self.index = arg_1_1
	self.m_name.text = GetI18NText(ActivitySlayerCfg[arg_1_3].name)

	local var_1_0 = SlayerData:GetPoint(self.slayer_activity_id, self.region_activity_id)

	if var_1_0 == 0 then
		self.scoreController:SetSelectedIndex(0)
	else
		self.scoreController:SetSelectedIndex(1)

		self.m_maxPointLab.text = var_1_0
	end

	self:RefreshTime()
	SetActive(self.m_completeGo, ActivitySlayerPointRewardCfg[ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[self.region_activity_id][#ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[self.region_activity_id]]].need <= var_1_0)
end

function SlayerStageItem_1_7:Dispose()
	self:UnbindRedPoint()
	SlayerStageItem_1_7.super.Dispose(self)
end

function SlayerStageItem_1_7:BindRedPoint(arg_3_1)
	if self.region_activity_id == nil then
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_3_1)))
	elseif self.region_activity_id ~= arg_3_1 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.region_activity_id)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_3_1)))
	end
end

function SlayerStageItem_1_7:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.region_activity_id)))
end

return SlayerStageItem_1_7
