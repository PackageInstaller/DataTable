local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local var_0_1 = g.core.model.User.peakArenaData
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.common.ServerTime
local PAPeakStageLayerComp = class("PAPeakStageLayerComp", require("app.fairyGUI.peakArena.UI_PAPeakStageLayerComp"))

function PAPeakStageLayerComp:ctor()
	self._canLineUp = true
	self._playedEffect = false
	self._groupId = 0

	self.m_guessBtn:addClickListener(handler(self, self._onClickGuessBtn))
end

function PAPeakStageLayerComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)
end

function PAPeakStageLayerComp:_onS2CUserSnapshot()
	self:updateComp(self._groupId)
end

function PAPeakStageLayerComp:onCD()
	local var_4_0 = var_0_3:getTime()
	local var_4_1 = var_0_1:getFinalStageEndTime()
	local var_4_2 = var_4_1 - var_4_0 < 60 and g.core.lang:get(307029) or var_0_3:getLeftDHMFormat(var_4_1)

	self.m_endCDTxt:setText(g.core.lang:get(307001, {
		time = var_4_2
	}))

	local var_4_3 = var_0_1:getGroupStageEndTime()

	if var_4_3 <= var_4_0 then
		self.m_finalStartCDTxt:setVisible(false)
	else
		local var_4_4 = {}

		var_4_4.time = var_0_3:getLeftSecondsString(var_4_3)

		self.m_finalStartCDTxt:setText(g.core.lang:get(307007, var_4_4))
		self.m_finalStartCDTxt:setVisible(true)
	end

	local var_4_5 = var_0_1:getFormationCD()

	if var_4_5 > 0 then
		self._canLineUp = true

		self.m_timeText:setText(var_0_3:secondToHMSString(var_4_5))
		self.m_timeText:setVisible(true)
		self.m_timeBg:setVisible(true)
		self.m_lineUpTimeBtn:getChild("icon"):setColor(g.core.common.Color.A6)

		if not self._playedEffect then
			self.m_effTimeNode:addEffectSpine({
				anim = "play",
				name = "eff_ui_peakArena_countdown",
				remove = true,
				isLoop = false
			})

			self._playedEffect = true
		end
	else
		self.m_timeText:setVisible(false)
		self.m_timeBg:setVisible(false)
		self.m_lineUpTimeBtn:getChild("icon"):setColor(g.core.common.Color.A3)

		if self._canLineUp then
			self._canLineUp = false

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_lineUpTimeBtn
			})
		end
	end

	self.m_groupMemberComp:updateRoundStartCD()
end

function PAPeakStageLayerComp:getCanLineUpStatus()
	return self._canLineUp
end

function PAPeakStageLayerComp:updateComp(arg_6_1)
	self._groupId = arg_6_1

	if not var_0_1:getGroupStruct(arg_6_1):isEmpty() or var_0_1:getPeakStageGroupType() == var_0_0.GroupType.FINAL then
		-- block empty
	elseif arg_6_1 ~= var_0_0.FINAL_GROUP_ID then
		-- block empty
	end

	self.m_groupMemberComp:changeGroup(arg_6_1)
	self.m_groupMemberComp:updateRoundStartCD()

	if var_0_1:isCheerActive() then
		self.m_cheerGroup:setVisible(true)
		self.m_cheerTip:setVisible(true)
		self.m_cheerNum:setText(g.core.lang:get(307065, {
			num = var_0_1:getOwnCheerCount()
		}))
	else
		self.m_cheerGroup:setVisible(false)
		self.m_cheerTip:setVisible(false)
	end
end

function PAPeakStageLayerComp:onReturnFormPop()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_lineUpTimeBtn
	})
end

function PAPeakStageLayerComp:_onClickGuessBtn()
	if var_0_1:gotoBetListPopEnable() then
		var_0_2:pushPopup(require("app.view.module.peakArena.view.PeakArenaBettingListPop").new(), {
			touchDisappear = false,
			ignoreTouch = false
		})
	else
		var_0_2:tip(g.core.lang:get(307026))
	end
end

function PAPeakStageLayerComp:playEnterAni()
	self.m_enterTransition:play()
end

function PAPeakStageLayerComp:updateHeadAfterCheer(arg_10_1)
	self.m_groupMemberComp:changeGroup(self._groupId)
	self.m_cheerNum:setText(g.core.lang:get(307065, {
		num = var_0_1:getOwnCheerCount()
	}))
end

return PAPeakStageLayerComp
