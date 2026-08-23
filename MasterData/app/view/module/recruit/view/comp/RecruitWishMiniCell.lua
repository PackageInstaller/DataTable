local RecruitWishMiniCell = class("RecruitWishMiniCell", require("app.fairyGUI.recruit.UI_RecruitWishMiniCell"))
local PressComp = require("app.view.module.recruit.view.comp.PressComp")

function RecruitWishMiniCell:ctor()
	self._idx = -1
	self._info = nil

	PressComp.bindComp(self)
	self:setClickListener(handler(self, self._onCellItemClicked))
	self:addPressListener((handler(self, self._showDetailInfo)))
	self:setPressContinueTypeEnable(false)
end

function RecruitWishMiniCell:_onCellItemClicked()
	self:dispatchCompEvent("clickWish", self._idx)
end

function RecruitWishMiniCell:_showDetailInfo()
	if self._info then
		g.core.common.GlobalFunc.pushInfoPop({
			type = self._info.r_type,
			value = self._info.r_value
		})
	end
end

function RecruitWishMiniCell:updateItem(arg_4_1, arg_4_2, arg_4_3)
	self._info = arg_4_1
	self._idx = arg_4_2

	if not self._info then
		self.m_isWishController:setSelectedIndex(0)

		return
	end

	self.m_isWishController:setSelectedIndex(1)

	local var_4_0 = {
		size = -1,
		type = self._info.r_type,
		value = self._info.r_value
	}

	if self._info.r_type == g.core.common.Goods.TYPE_KNIGHT then
		var_4_0.changeControllers = true
		var_4_0.hideSkin = true
	end

	self.m_itemIcon:updateIcon(var_4_0)
	self.m_itemIcon:setTouchable(false)

	if self._info.status >= self._info.statusMax then
		self.m_isCompletedController:setSelectedIndex(1)
	else
		self.m_isCompletedController:setSelectedIndex(0)
	end
end

return RecruitWishMiniCell
