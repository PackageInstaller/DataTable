local RecruitWishArtifactGroupCell = class("RecruitWishArtifactGroupCell", require("app.fairyGUI.recruitArtifact.UI_RecruitWishArtifactGroupCell"))

function RecruitWishArtifactGroupCell:ctor()
	self._wishMemberStruct = nil
end

function RecruitWishArtifactGroupCell:updateCell(arg_2_1)
	self._wishMemberStruct = arg_2_1

	self.m_itemIcon:updateIcon({
		type = self._wishMemberStruct:getType(),
		value = self._wishMemberStruct:getId(),
		struct = self._wishMemberStruct:getStruct()
	})

	local var_2_0, var_2_1, var_2_2, var_2_3 = g.core.common.ServerTime:getLeftTimeParts((g.core.model.User.recruitData:getArtifactActivityData(self._wishMemberStruct):getFinishTime()))

	self.m_timeText:setText(var_2_0 >= 1 and g.core.lang:get(108416, {
		num = var_2_0
	}) or g.core.lang:get(108417))
end

return RecruitWishArtifactGroupCell
