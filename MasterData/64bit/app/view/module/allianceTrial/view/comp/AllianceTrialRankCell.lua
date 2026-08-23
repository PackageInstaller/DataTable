local var_0_0 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_1 = g.core.model.User.snapShotCacheData
local AllianceTrialRankCell = class("AllianceTrialRankCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialRankCell"))

function AllianceTrialRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function AllianceTrialRankCell:updateUserCell(arg_2_1, arg_2_2)
	if not arg_2_2 then
		return
	end

	local var_2_0 = var_0_1:getSnapShot(var_0_0.SNAP_SHOT_KEY.USER, arg_2_2.uid)

	if var_2_0 then
		self.m_userHeadComp:updateAsUser(var_2_0)
		self.m_nameText:setText((g.core.utils.String.transRobotName(var_2_0)))
		self.m_powerText:setText(var_2_0.fight_value)

		local var_2_1 = var_2_0.server_name or g.core.lang:get(411015)

		self.m_lvText:setText(g.core.lang:get(302516, {
			level = var_2_0.level
		}))
		self.m_serverNameTxt:initRaceTextParams({
			playMode = 1,
			pauseTime = 0.5,
			direction = "right",
			moveType = "MOVE_BY",
			title = var_2_1
		})
		self.m_serverNameTxt:play()
	end

	self.m_isShowBgController:setSelectedIndex(arg_2_1 % 2 == 0 and 1 or 0)

	local var_2_2 = arg_2_2.rank
	local var_2_3 = arg_2_2.rank <= 3

	if arg_2_2.rank <= 3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_2_2
		})
	else
		self.m_rankText:setText(var_2_2)
	end

	self.m_isTopThreeController:setSelectedIndex(var_2_3 and 1 or 0)
	self.m_scoreTxt:setText(arg_2_2.damage)
end

return AllianceTrialRankCell
