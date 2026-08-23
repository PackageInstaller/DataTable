local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local var_0_2 = g.core.common.Color
local RecruitWishArtifactComp = class("RecruitWishArtifactComp", require("app.fairyGUI.recruitArtifact.UI_RecruitWishArtifactComp"))

function RecruitWishArtifactComp:ctor()
	self._struct = nil
	self._pos = nil

	PressComp.bindComp(self)
	self:setClickListener(handler(self, self._onCellItemClicked))
end

function RecruitWishArtifactComp:updateComp(arg_2_1, arg_2_2)
	self._pos = arg_2_2

	if not arg_2_1 then
		self.m_wishStateController:setSelectedIndex(0)

		return
	end

	self._struct = arg_2_1

	if arg_2_1:isCompleted() then
		self.m_wishStateController:setSelectedIndex(2)
	else
		self.m_wishStateController:setSelectedIndex(1)
	end

	self.m_memberPic:setIcon(g.core.common.Path:getArtifactPic(g.core.config.artifact_info.get((arg_2_1:getId())).res_id))

	local var_2_0 = arg_2_1:getQuality()

	self.m_nameBgLoader:setURL((g.core.common.Path:getUserIconQualityStarBg(var_2_0)))
	self.m_nameText:setText(arg_2_1:getName())
	self.m_tipText:setColor(var_0_2.Recruit_Wish[var_2_0 + 1])
	self.m_colorController:setSelectedIndex(var_2_0 >= 4 and 1 or 0)
	self.m_knightComp:updateComp(self._struct:getStruct():getBelongToKnightAvdIdIncludingMainRole(), var_2_0)
end

function RecruitWishArtifactComp:_onCellItemClicked()
	if not self._struct then
		-- block empty
	else
		self:dispatchCompEvent("updateWishInfo", {
			needUpdateItem = true,
			pos = self._pos
		})
	end
end

function RecruitWishArtifactComp:getStruct()
	return self._struct
end

function RecruitWishArtifactComp:getWishStateIndex()
	return self.m_wishStateController:getSelectedIndex()
end

return RecruitWishArtifactComp
