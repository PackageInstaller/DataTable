local IslandMainTechnologyBtn = class("IslandMainTechnologyBtn", import(".IslandMainBaseBtn"))

IslandMainTechnologyBtn.STATUS = {
	NORMAL = 3,
	STUDYING = 1,
	UNLOCK = 2
}
IslandMainTechnologyBtn.STATUS2ICON = {
	[IslandMainTechnologyBtn.STATUS.STUDYING] = "technology_studying",
	[IslandMainTechnologyBtn.STATUS.UNLOCK] = "technology_unlock",
	[IslandMainTechnologyBtn.STATUS.NORMAL] = "technology"
}

function IslandMainTechnologyBtn:Init()
	self._tf.name = self.config.btn_name

	onButton(self, self._tf, function()
		self:OnClick()

		return
	end, SFX_PANEL)

	return
end

function IslandMainTechnologyBtn:Flush()
	IslandMainTechnologyBtn.super.Flush(self)
	self:StatusCheck()

	return
end

function IslandMainTechnologyBtn:StatusCheck()
	local var_4_0 = self:GetStatus()

	if not self.status or self.status ~= var_4_0 then
		self.status = var_4_0

		LoadImageSpriteAtlasAsync("island/islandbtnicon", IslandMainTechnologyBtn.STATUS2ICON[self.status], self.iconTF, true)
	end

	return
end

function IslandMainTechnologyBtn:GetStatus()
	local var_5_0 = getProxy(IslandProxy):GetIsland()
	local var_5_1 = var_5_0:GetBuildingAgency():GetBuilding(IslandTechnologyAgency.PLACE_ID)

	for iter_5_0, iter_5_1 in ipairs((IslandTechnologyAgency.GetSlotIds())) do
		local var_5_2 = var_5_1:GetDelegationSlotData(iter_5_1)

		if var_5_2 and var_5_2:GetSlotRoleData() then
			return IslandMainTechnologyBtn.STATUS.STUDYING
		end
	end

	for iter_5_2, iter_5_3 in pairs(var_5_0:GetTechnologyAgency():GetTechnologys()) do
		if iter_5_3:IsUnlock() and iter_5_3:GetFinishedCnt() <= 0 then
			return IslandMainTechnologyBtn.STATUS.UNLOCK
		end
	end

	return IslandMainTechnologyBtn.STATUS.NORMAL
end

return IslandMainTechnologyBtn
