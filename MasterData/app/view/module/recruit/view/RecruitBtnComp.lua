local RecruitBtnComp = class("RecruitBtnComp", require("app.fairyGUI.recruit.UI_RecruitBtnComp"))

function RecruitBtnComp:ctor()
	self.m_costComp:setLackColor(cc.c3b(244, 78, 78))
end

function RecruitBtnComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	if arg_2_1.freeNum and arg_2_1.freeNum > 0 then
		self.m_isFreeController:setSelectedIndex(1)
		self.m_freeTimeText:setText(g.core.lang:get(108435, {
			num = arg_2_1.freeNum
		}))
	else
		self.m_isFreeController:setSelectedIndex(0)
	end

	if arg_2_1.redId then
		self.m_redPointComp:setId(arg_2_1.redId)
	end

	local var_2_0 = clone(arg_2_1.goods)

	var_2_0.showLack = true

	self.m_costComp:updateByTVS(var_2_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = arg_2_1.redParam
	})
end

return RecruitBtnComp
