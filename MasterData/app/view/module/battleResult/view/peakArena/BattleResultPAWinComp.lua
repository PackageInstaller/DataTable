local BattleResultPAWinComp = class("BattleResultPAWinComp", require("app.fairyGUI.battleResult.UI_BattleResultPAWinComp"))

function BattleResultPAWinComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.update), self)
end

function BattleResultPAWinComp:update(arg_2_1)
	local var_2_0 = ""
	local var_2_1 = g.core.model.User.peakArenaData:getMatchedOpponentInfo()

	if var_2_1 then
		if var_2_1.isRobot then
			var_2_0 = g.core.config.peakarena_robot_info.get(var_2_1.targetId).name
		else
			local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_1.targetId)

			if var_2_2 then
				var_2_0 = var_2_2.name
			end
		end
	end

	self.m_userNameTxt:setText(var_2_0)
end

return BattleResultPAWinComp
