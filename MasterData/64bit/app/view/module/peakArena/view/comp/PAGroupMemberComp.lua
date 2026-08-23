local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst.UserMatchState
local var_0_2 = {
	GROUP = 0,
	FINAL = 1
}
local var_0_3 = g.core.model.User.peakArenaData
local var_0_4 = g.core.common.ServerTime
local PAGroupMemberComp = class("PAGroupMemberComp", require("app.fairyGUI.peakArena.UI_PAGroupMemberComp"))

function PAGroupMemberComp:ctor()
	self._headComp2DArr = {}

	self:_initView()
end

function PAGroupMemberComp:_initView()
	for iter_2_0 = 1, var_0_0.PEAK_STAGE_ROUND do
		local var_2_0 = {}

		for iter_2_1 = 1, var_0_3:getPeakStageUserNumWithRound(iter_2_0) do
			table.insert(var_2_0, (self:_getHeadComp(iter_2_0, iter_2_1)))

			if iter_2_1 % 2 == 0 then
				local var_2_1 = self:_getConnLineComp(iter_2_0, iter_2_1)

				if var_2_1 then
					var_2_1:setConnectLine(true)
				end

				local var_2_2 = self:_getPlaybackBtn(iter_2_0, iter_2_1)

				if var_2_2 then
					var_2_2:setVisible(false)
					var_2_2:addClickListener(handler(self, self._onClickPlaybackBtn))
				end
			end
		end

		self._headComp2DArr[iter_2_0] = var_2_0
	end

	self.m_groupTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupTypeChanged))
end

function PAGroupMemberComp:_onGroupTypeChanged()
	self:dispatchCompEvent("ClickGroupNameItem", (self.m_groupTypeController:getSelectedIndex() == var_0_2.GROUP or nil) and self.m_groupNamesComp:getSelectedGroupId())
end

function PAGroupMemberComp:_onClickPlaybackBtn(arg_4_1)
	local var_4_0, var_4_1 = string.match(arg_4_1:getSender():getName(), ".+(%d)_(%d)")
	local var_4_2 = tonumber(var_4_0)
	local var_4_3 = self:_getCurGroupId()
	local var_4_4 = var_0_3:getGroupStruct(var_4_3):getWinnerUserId(var_4_2, tonumber(var_4_1) * 2)

	if var_4_4 > 0 then
		g.core.network.GameNetProxy:send_C2S_GetBattleVideo({
			battle_id = var_0_3:getPlaybackId(var_4_3, var_4_2, var_4_4),
			tp = g.core.network.proto.PEAK_ARENA_FINAL
		})
	end
end

function PAGroupMemberComp:setGroupType(arg_5_1)
	if arg_5_1 == var_0_0.GroupType.FINAL then
		self:_onClickFinalBtn()
	else
		self:_onClickGroupBtn()
	end
end

function PAGroupMemberComp:changeGroup(arg_6_1)
	self.m_groupNamesComp:updateComp(arg_6_1)

	local var_6_0 = self:_getGroupTypeCtrlIdxWithGroupId(arg_6_1)

	if var_6_0 ~= self.m_groupTypeController:getSelectedIndex() then
		self.m_groupTypeController:setSelectedIndex(var_6_0, false)
	end

	local var_6_1 = var_0_3:getPeakStageGroupType() == var_0_0.GroupType.GROUP and var_6_0 == var_0_2.FINAL
	local var_6_2 = var_0_3:getGroupStruct(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(self._headComp2DArr) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_3 = var_0_1.EMPTY
			local var_6_4

			if not var_6_1 then
				var_6_3 = var_6_2:getUserMatchState(iter_6_0, iter_6_2)
				var_6_4 = var_0_3:getUserSnapshotWithId((var_6_2:getUserIdWithRoundUserIdx(iter_6_0, iter_6_2)))
			end

			iter_6_3:updateComp(var_6_3, var_6_4)
			self:_updateLineComp(iter_6_0, iter_6_2, var_6_3)

			if iter_6_2 % 2 == 0 then
				self:_updateConnLineComp(iter_6_0, iter_6_2, var_6_3)
				self:_updatePlayBackBtn(arg_6_1, iter_6_0, iter_6_2)
			end
		end
	end
end

function PAGroupMemberComp:updateHeadAfterCheer(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._headComp2DArr) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			iter_7_3:updateCheer()
		end
	end
end

function PAGroupMemberComp:_getCurGroupId()
	if self.m_groupTypeController:getSelectedIndex() == var_0_2.FINAL then
		return var_0_0.FINAL_GROUP_ID
	else
		return self.m_groupNamesComp:getSelectedGroupId()
	end
end

function PAGroupMemberComp:_getHeadComp(arg_9_1, arg_9_2)
	return self[string.format("m_headComp_%d_%d", arg_9_1, arg_9_2)]
end

function PAGroupMemberComp:_getLineComp(arg_10_1, arg_10_2)
	return self[string.format("m_lineComp_%d_%d", arg_10_1, arg_10_2)]
end

function PAGroupMemberComp:_getConnLineComp(arg_11_1, arg_11_2)
	return self[string.format("m_connLineComp_%d_%d", arg_11_1, (math.ceil(arg_11_2 / 2)))]
end

function PAGroupMemberComp:_getPlaybackBtn(arg_12_1, arg_12_2)
	return self[string.format("m_playbackBtn_%d_%d", arg_12_1, (math.ceil(arg_12_2 / 2)))]
end

function PAGroupMemberComp:_getGroupTypeCtrlIdxWithGroupId(arg_13_1)
	if arg_13_1 == var_0_0.FINAL_GROUP_ID then
		return var_0_2.FINAL
	else
		return var_0_2.GROUP
	end
end

function PAGroupMemberComp:updateRoundStartCD()
	local var_14_0 = self:_getCurGroupId()

	if var_14_0 == var_0_0.FINAL_GROUP_ID and var_0_3:getPeakStageGroupType() == var_0_0.GroupType.GROUP then
		for iter_14_0, iter_14_1 in ipairs(self._headComp2DArr) do
			for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
				iter_14_3:updateCD(false)
			end
		end

		return
	end

	local var_14_1 = var_0_3:getNextRoundWithTime(var_14_0, (var_0_4:getTime()))
	local var_14_2 = var_0_3:getGroupStruct(var_14_0)

	for iter_14_4 = 2, var_0_0.PEAK_STAGE_ROUND do
		if var_14_1 == 0 or iter_14_4 - 1 < var_14_1 then
			local var_14_3 = g.core.lang:get(307028)

			for iter_14_5, iter_14_6 in ipairs(self._headComp2DArr[iter_14_4]) do
				if var_14_2:getUserMatchState(iter_14_4, iter_14_5) == var_0_1.EMPTY then
					if var_14_2:getUserMatchState(iter_14_4 - 1, iter_14_5 * 2) == var_0_1.EMPTY and var_14_2:getUserMatchState(iter_14_4 - 1, iter_14_5 * 2 - 1) == var_0_1.EMPTY then
						iter_14_6:updateCD(false)
					else
						iter_14_6:updateCD(true, var_14_3)
					end
				else
					iter_14_6:updateCD(false)
				end
			end
		elseif iter_14_4 - 1 == var_14_1 then
			local var_14_4 = var_0_4:getLeftSecondsString((var_0_3:getRoundStartTime(var_14_0, iter_14_4 - 1)))

			for iter_14_7, iter_14_8 in ipairs(self._headComp2DArr[iter_14_4]) do
				if var_14_2:getUserMatchState(iter_14_4, iter_14_7) == var_0_1.EMPTY then
					iter_14_8:updateCD(true, var_14_4)
				else
					iter_14_8:updateCD(false)
				end
			end
		else
			for iter_14_9, iter_14_10 in ipairs(self._headComp2DArr[iter_14_4]) do
				iter_14_10:updateCD(false)
			end
		end
	end
end

function PAGroupMemberComp:_updateLineComp(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = self:_getLineComp(arg_15_1, arg_15_2)

	if var_15_0 then
		var_15_0:updateComp(arg_15_3)
	end
end

function PAGroupMemberComp:_updateConnLineComp(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self:_getConnLineComp(arg_16_1, arg_16_2)

	if var_16_0 then
		var_16_0:updateComp(arg_16_3)
	end
end

function PAGroupMemberComp:_updatePlayBackBtn(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = self:_getPlaybackBtn(arg_17_2, arg_17_3)

	if var_17_0 then
		var_17_0:setVisible(checkbool((var_0_3:getPlaybackIdWithUserIdx(arg_17_1, arg_17_2, arg_17_3))))
	end
end

return PAGroupMemberComp
