local ActivityReturnWishBtn = class("ActivityReturnWishBtn", require("app.fairyGUI.activityReturn.UI_ActivityReturnWishBtn"))

function ActivityReturnWishBtn:ctor()
	self.m_eff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_activityReturn_plus",
		remove = false
	})
end

function ActivityReturnWishBtn:updateComp(arg_2_1)
	if not arg_2_1.curAward then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	if arg_2_1.curAward.type == g.core.common.Goods.TYPE_KNIGHT then
		self.m_knightIcon:setIcon((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(g.core.config.knight_info.get(arg_2_1.curAward.value).res_id).icon_id)))
	else
		self.m_knightIcon:setIcon(g.core.common.Goods:convert(arg_2_1.curAward).icon)
	end

	self.m_isEmptyController:setSelectedIndex(0)
end

return ActivityReturnWishBtn
