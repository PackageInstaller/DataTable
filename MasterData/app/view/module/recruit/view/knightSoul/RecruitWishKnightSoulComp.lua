local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local var_0_2 = g.core.common.Color
local RecruitWishKnightSoulComp = class("RecruitWishKnightSoulComp", require("app.fairyGUI.recruitKnightSoul.UI_RecruitWishKnightSoulComp"))

function RecruitWishKnightSoulComp:ctor()
	self._struct = nil
	self._pos = nil

	PressComp.bindComp(self)
	self:setClickListener(handler(self, self._onCellItemClicked))
end

function RecruitWishKnightSoulComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._pos = arg_2_2

	if not arg_2_1 then
		self.m_wishStateController:setSelectedIndex(0)

		return
	end

	self._struct = arg_2_1

	if arg_2_3 == 1 then
		self.m_wishStateController:setSelectedIndex(2)
	else
		self.m_wishStateController:setSelectedIndex(1)
	end

	self.m_memberPic:getChild("icon"):updateCard({
		num = 1,
		kSoulId = arg_2_1:getId()
	})

	local var_2_0 = arg_2_1:getQuality()

	self.m_nameBgLoader:setURL((g.core.common.Path:getUserIconQualityStarBg(var_2_0)))
	self.m_nameText:setText(arg_2_1:getName())
	self.m_colorController:setSelectedIndex(var_2_0 >= 4 and 1 or 0)
	self.m_tipText:setColor(var_0_2.Recruit_Wish[var_2_0 + 1])
end

function RecruitWishKnightSoulComp:_onCellItemClicked()
	if not self._struct then
		-- block empty
	else
		self:dispatchCompEvent("updateWishInfo", {
			needUpdateItem = true,
			pos = self._pos
		})
	end
end

function RecruitWishKnightSoulComp:getStruct()
	return self._struct
end

function RecruitWishKnightSoulComp:getWishStateIndex()
	return self.m_wishStateController:getSelectedIndex()
end

return RecruitWishKnightSoulComp
