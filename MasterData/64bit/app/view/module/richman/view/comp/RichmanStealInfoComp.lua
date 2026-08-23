local var_0_0 = g.core.model.User.richmanData
local RichmanStealInfoComp = class("RichmanStealInfoComp", require("app.fairyGUI.richman.UI_RichmanStealInfoComp"))

function RichmanStealInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateStealInfo, self)
end

function RichmanStealInfoComp:updateStealInfo()
	local var_2_0 = var_0_0:getCurRobData()

	if var_2_0 then
		self.m_onlineController:setSelectedIndex(var_2_0.online and 0 or 1)

		local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_0.user_id)

		if var_2_1 then
			self.m_nameTxt:setText(var_2_1.name)
			self.m_knightIcon:updateAsUser(var_2_1)
		end
	end
end

return RichmanStealInfoComp
