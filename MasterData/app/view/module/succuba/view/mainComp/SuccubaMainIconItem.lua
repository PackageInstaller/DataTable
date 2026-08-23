local var_0_0 = g.core.model.User.fragmentsData
local SuccubaMainIconItem = class("SuccubaMainIconItem", require("app.fairyGUI.succuba.UI_SuccubaMainIconItem"))

function SuccubaMainIconItem:ctor()
	self._succuba = nil
end

function SuccubaMainIconItem:updateIconItem(arg_2_1)
	self._succuba = arg_2_1

	self.m_iconComp:setIcon(g.core.common.Path:getSuccubaIconById(self._succuba:getShowCfg().res))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			sid = arg_2_1:getSid()
		}
	})

	if arg_2_1:isOwn() then
		self.m_hasOwnController:setSelectedIndex(1)
	else
		self.m_hasOwnController:setSelectedIndex(0)

		local var_2_0 = self._succuba:getCurStarCfg()
		local var_2_1 = var_2_0.next_star_num
		local var_2_2 = math.min(var_0_0:getFragmentNumById(var_2_0.fragment), var_2_0.next_star_num)

		self.m_curFrag:setText(var_2_2)
		self.m_needFrag:setText("/" .. var_2_1)
		self.m_canComposeController:setSelectedIndex(var_2_1 <= var_2_2 and 1 or 0)
	end
end

return SuccubaMainIconItem
