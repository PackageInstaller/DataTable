local ActivityReturnSelKnightComp = class("ActivityReturnSelKnightComp", require("app.fairyGUI.activityReturn.UI_ActivityReturnSelKnightComp"))

function ActivityReturnSelKnightComp:ctor()
	self.m_knightItem:addClickListener(handler(self, self._onClick))
end

function ActivityReturnSelKnightComp:updateComp(arg_2_1, arg_2_2)
	self._index = arg_2_2

	self.m_indexTxt:setText(g.core.lang:get(425001, {
		index = arg_2_2
	}))

	local var_2_0 = g.core.common.Goods:convert(arg_2_1)

	self.m_nameTxt:setText(var_2_0.name .. "  x" .. arg_2_1.size)

	if arg_2_1.type == g.core.common.Goods.TYPE_KNIGHT then
		self.m_typeController:setSelectedIndex(0)
		self.m_knightItem:setIcon(g.core.common.Path:getKnightBookPicRes(g.core.config.knight_base_info.get(g.core.config.knight_info.get(arg_2_1.value).res_id).icon_id))
	else
		self.m_typeController:setSelectedIndex(1)
		self.m_item:setIcon(var_2_0.bigIcon)
	end
end

function ActivityReturnSelKnightComp:_onClick()
	self:dispatchCompEvent("selectIndex", {
		index = self._index
	})
end

return ActivityReturnSelKnightComp
