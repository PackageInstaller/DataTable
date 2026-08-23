local AncientsSelectKnightCell = class("AncientsSelectKnightCell", require("app.fairyGUI.ancients.UI_AncientsSelectKnightCell"))

function var_0_0:ctor()
	self:addClickListener(handler(self, self._onClickBtnLineUp))
end

function var_0_0:updateCell(arg_2_1, arg_2_2)
	self._sendUserId = 0

	self.m_Comp_icon:updateIcon({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = arg_2_1.base_id
	})
	self.m_starComp:initStar({
		gap = -7,
		style = 2,
		index = 3,
		num = g.core.config.knight_info.get(arg_2_1.base_id).star
	})

	self._sendUserId = arg_2_2 == 0 and arg_2_1.id or g.core.model.User.ancientsData:getAdvIdByUnit(arg_2_1) == arg_2_2 and 0 or arg_2_1.id
end

function var_0_0:_onClickBtnLineUp()
	self:dispatchCompEvent("AncientsSelectKnightCell_onClickBtnLineUp", {
		knightPos = self._sendUserId
	})
end

return var_0_0
