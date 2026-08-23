local var_0_0 = g.core.model.User.outpostData
local var_0_1 = g.core.config.outpost_tips_info
local OutpostTipsBtn = class("OutpostTipsBtn", require("app.fairyGUI.outpost.UI_OutpostTipsBtn"))

function OutpostTipsBtn:ctor()
	self._tipsInfo = nil

	self:addClickListener(handler(self, self.onClick))
end

function OutpostTipsBtn:updateTip(arg_2_1, arg_2_2)
	self:cancelAllSchedule()
	self.m_showTimeController:setSelectedIndex(0)
	self.m_typeController:setSelectedIndex(arg_2_1 - 1)

	self._tipsInfo = arg_2_2

	local var_2_0 = ""

	if arg_2_2.knightId then
		var_2_0 = var_0_0:getKnightsData():getKnightBySid(arg_2_2.knightId):getCfg().name
	end

	if arg_2_2.box then
		self.m_showTimeController:setSelectedIndex(1)

		var_2_0 = g.core.config.outpost_monster_info.get(arg_2_2.box.boss_id).level

		self:newSchedule(handler(self, self._onBoxUpdateCheck), 1)
	end

	self.m_tipsTxt:setText((g.core.lang:getByString(var_0_1.get(arg_2_2.id).text, {
		name = var_2_0
	})))
	self.m_effHolder:removeAllEffect()
	self.m_effHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_outpost_tipsicon",
		y = 0,
		x = 0,
		anim = "play_" .. arg_2_1
	})
end

function OutpostTipsBtn:_onBoxUpdateCheck()
	self.m_showTimeController:setSelectedIndex(1)

	if self._tipsInfo.box.expire_time < g.core.common.ServerTime:getTime() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_BOSS_BOX_EXPIRE)
	else
		self.m_timeStr:setText((g.core.common.ServerTime:getLeftSecondsString(self._tipsInfo.box.expire_time)))
	end
end

function OutpostTipsBtn:onClick()
	if self._tipsInfo then
		if self._tipsInfo.buildType then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD, false, 0, {
				buildType = self._tipsInfo.buildType
			})
			self:newScheduleOnce(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD_2, false, 0, {
					buildType = self._tipsInfo.buildType
				})
			end, 0.2)

			return
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_POS, false, 0, {
			knightId = self._tipsInfo.knightId,
			pos = self._tipsInfo.pos,
			box = self._tipsInfo.box
		})
	end
end

return OutpostTipsBtn
