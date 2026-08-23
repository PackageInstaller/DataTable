local var_0_0 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_1 = g.core.model.User.crossServerArenaData
local CrossServerArenaSeasonPop = class("CrossServerArenaSeasonPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaSeasonPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaSeasonPop",
		pkgPath = "ui/crossServerArena/crossServerArena",
		isFullScreen = true,
		pkgName = "crossServerArena"
	}, ...)
end)

function CrossServerArenaSeasonPop:ctor(arg_2_1)
	self.m_blankSpace:addClickListener(handler(self, self._onClickBlank))
	self:showAtCenter()

	self._seasonInfo = arg_2_1.seasonInfo or {}
	self._seasonStatus = arg_2_1.seasonStatus or var_0_0.SEASON_START

	if arg_2_1.rank and arg_2_1.rank > 0 then
		self._myRank = arg_2_1.rank

		self.m_hasRankController:setSelectedIndex(1)
	else
		self._myRank = ""

		self.m_hasRankController:setSelectedIndex(0)
	end

	self:_updateView()
end

function CrossServerArenaSeasonPop:_updateView()
	self.m_seasonStatusController:setSelectedIndex(self._seasonStatus)
	self.m_seasonNumTxt:setText("S" .. self._seasonInfo.term or 1)
	self.m_seasonTimeTxt:setText((var_0_1:getDurationString()))
	self.m_seasonRankTxt:setText(self._myRank)
end

function CrossServerArenaSeasonPop:onLoad()
	local var_4_0 = ""

	if self._seasonStatus == var_0_0.CTRL_ON_SEASON then
		var_0_1:saveSeasonPopStatus(self._seasonInfo.term, var_0_0.JSON_SEASON_STATUS_START)

		var_4_0 = "startEnter"
	elseif self._seasonStatus == var_0_0.CTRL_OFF_SEASON then
		var_0_1:saveSeasonPopStatus(self._seasonInfo.term, var_0_0.JSON_SEASON_STATUS_END)

		var_4_0 = "endEnter"
	end

	if self.m_effect then
		self.m_effect:removeAllEffect()
		self.m_effect:addEffectSpine({
			name = "eff_ui_chiefArena_startOver",
			isLoop = false,
			anim = var_4_0
		})
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_PVP_START)

	if var_0_1:isNeedGuide() then
		self:setTouchable(false)
		self:newScheduleOnce(handler(self, self._onClickBlank), 2)
	end
end

function CrossServerArenaSeasonPop:_onClickBlank()
	local var_5_0 = ""

	if self._seasonStatus == var_0_0.CTRL_ON_SEASON then
		var_5_0 = "startClose"
	elseif self._seasonStatus == var_0_0.CTRL_OFF_SEASON then
		var_5_0 = "endClose"
	end

	if self.m_effect then
		self.m_effect:removeAllEffect()
		self.m_effect:addEffectSpine({
			name = "eff_ui_chiefArena_startOver",
			isLoop = false,
			anim = var_5_0,
			eventHandler = function(self)
				if self.type == "complete" then
					g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
				end
			end
		})
	end
end

function CrossServerArenaSeasonPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	local var_7_0 = self._seasonStatus

	g.core.common.Scheduler:newScheduleOnce(function()
		local var_8_0 = var_0_1:getLastSeasonRank()

		if var_7_0 == var_0_0.CTRL_ON_SEASON and var_8_0 > 0 then
			local var_8_1 = 0

			for iter_8_0, iter_8_1 in g.core.config.chief_arena_reset_info.ipairs() do
				if var_8_0 >= iter_8_1.previous_min and var_8_0 <= iter_8_1.previous_max then
					var_8_1 = var_8_0 + (iter_8_1.rank_min - iter_8_1.previous_min)

					break
				end
			end

			if var_8_1 == 0 then
				var_8_1 = var_0_0.DEFAULT_RANK
			end

			g.core.module.ModuleManager:pushPopup((require("app.view.module.crossServerArena.pop.CrossServerArenaRankResetPop").new({
				oldRank = var_8_0,
				newRank = var_8_1
			})))
		end
	end, 0)
end

return CrossServerArenaSeasonPop
