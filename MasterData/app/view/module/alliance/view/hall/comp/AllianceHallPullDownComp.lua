local var_0_0 = g.core.const.ConstMgr.AllianceConst
local AllianceHallPullDownComp = class("AllianceHallPullDownComp", require("app.fairyGUI.alliance.UI_AllianceHallPullDownComp"))

function AllianceHallPullDownComp:ctor()
	self._order = var_0_0.GUILD_ORDER.DOWN
	self._isExpand = false
	self._curSelIndex = var_0_0.PULL_DOWN_TYPE.MEMBER_NUM

	self.m_memberBtn:addClickListener(handler(self, self._onClickMemberBtn))
	self.m_powerBtn:addClickListener(handler(self, self._onClickPowerBtn))
	self.m_contribBtn:addClickListener(handler(self, self._onClickContribBtn))
	self.m_totalBtn:addClickListener(handler(self, self._onClickTotalBtn))
	self.m_orderBtn:addClickListener(handler(self, self._onClickOrderBtn))
	self.m_expandBtn:addClickListener(handler(self, self._onClickExpandBtn))
end

function AllianceHallPullDownComp:updateComp(arg_2_1)
	self._order = arg_2_1

	self.m_orderController:setSelectedIndex(arg_2_1)
	self.m_title:setText(self:_getTitle())
end

function AllianceHallPullDownComp:_onClickMemberBtn()
	self.m_title:setText(g.core.lang:get(428562))

	self._curSelIndex = var_0_0.PULL_DOWN_TYPE.MEMBER_NUM

	self:_onClickExpandBtn()
	self:dispatchCompEvent("PULL_DOWN_SELECT", {
		index = var_0_0.PULL_DOWN_TYPE.MEMBER_NUM
	})
end

function AllianceHallPullDownComp:_onClickPowerBtn()
	self.m_title:setText(g.core.lang:get(428563))

	self._curSelIndex = var_0_0.PULL_DOWN_TYPE.POWER

	self:_onClickExpandBtn()
	self:dispatchCompEvent("PULL_DOWN_SELECT", {
		index = var_0_0.PULL_DOWN_TYPE.POWER
	})
end

function AllianceHallPullDownComp:_onClickContribBtn()
	self.m_title:setText(g.core.lang:get(428560))

	self._curSelIndex = var_0_0.PULL_DOWN_TYPE.TODAY

	self:_onClickExpandBtn()
	self:dispatchCompEvent("PULL_DOWN_SELECT", {
		index = var_0_0.PULL_DOWN_TYPE.TODAY
	})
end

function AllianceHallPullDownComp:_onClickTotalBtn()
	self.m_title:setText(g.core.lang:get(428561))

	self._curSelIndex = var_0_0.PULL_DOWN_TYPE.TOTAL

	self:_onClickExpandBtn()
	self:dispatchCompEvent("PULL_DOWN_SELECT", {
		index = var_0_0.PULL_DOWN_TYPE.TOTAL
	})
end

function AllianceHallPullDownComp:_onClickOrderBtn()
	self._order = 1 - self._order

	self.m_orderController:setSelectedIndex(self._order)
	self:dispatchCompEvent("PULL_DOWN_ORDER_CHANGE", {
		order = self._order
	})
end

function AllianceHallPullDownComp:_onClickExpandBtn()
	self._isExpand = not self._isExpand

	self.m_isExpandController:setSelectedIndex(self._isExpand and 1 or 0)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RankingSwitchPage)
end

function AllianceHallPullDownComp:_getTitle()
	if self._curSelIndex == var_0_0.PULL_DOWN_TYPE.MEMBER_NUM then
		return g.core.lang:get(428593)
	elseif self._curSelIndex == var_0_0.PULL_DOWN_TYPE.POWER then
		return g.core.lang:get(428594)
	elseif self._curSelIndex == var_0_0.PULL_DOWN_TYPE.TODAY then
		return g.core.lang:get(428595)
	elseif self._curSelIndex == var_0_0.PULL_DOWN_TYPE.TOTAL then
		return g.core.lang:get(428596)
	end

	return ""
end

return AllianceHallPullDownComp
