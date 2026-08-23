local var_0_0 = g.core.config.activity_theme_boss_integral_info
local ThemeThirdBossScoreCell = class("ThemeThirdBossScoreCell", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossScoreCell"))

function ThemeThirdBossScoreCell:ctor()
	self._info = nil
	self._infoIndex = 0
	self._bossData = nil
	self._awardList = {}
	self._effect = nil

	self.m_getAwardComp:addClickListener(handler(self, self._onClickGetAward))
	self.m_awardList:setIniter(self)
	self.m_awardList:setItemRenderer(handler(self, self._renderAwardItem))
end

function ThemeThirdBossScoreCell:_renderAwardItem(arg_2_1, arg_2_2)
	arg_2_2:updateIconCell(self._awardList[arg_2_1 + 1], self._bossData:isGetAwardById(self._info.id))
end

function ThemeThirdBossScoreCell:_onClickGetAward()
	if self._info.integral_demand > self._bossData:getTotalScore() then
		return
	end

	g.core.network.GameNetProxy:send_C2S_DemonAutoBoss_GetAward({
		recruit_type = self._bossData:getRecruitType(),
		id = self._bossData:getThemeVal(),
		ids = {
			self:getId()
		}
	})
end

function ThemeThirdBossScoreCell:updateScoreCell(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 then
		self.m_stateController:setSelectedIndex(0)

		return
	end

	self._bossData = arg_4_3
	self._info = arg_4_1
	self._infoIndex = arg_4_2

	if arg_4_3:getTotalScore() < arg_4_1.integral_demand then
		self.m_stateController:setSelectedIndex(3)
	elseif arg_4_3:isGetAwardById(arg_4_1.id) then
		self.m_stateController:setSelectedIndex(1)
	else
		self._effect = self._effect or self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_summerThemeThirdBoss_point",
			isLoop = true
		})

		self.m_stateController:setSelectedIndex(2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_getAwardBtn,
			customData = {
				themeValue = self._bossData:getThemeVal(),
				id = arg_4_1.id
			}
		})
	end

	self.m_scoreText:setText(arg_4_1.integral_demand)

	self._awardList = {}

	while var_0_0.hasKey("reward_type_" .. 1) do
		if arg_4_1["reward_type_" .. 1] > 0 then
			table.insert(self._awardList, {
				type = arg_4_1["reward_type_" .. 1],
				value = arg_4_1["reward_value_" .. 1],
				size = arg_4_1["reward_size_" .. 1]
			})
		end
	end

	local var_4_1 = arg_4_1.reward_token_type

	if arg_4_1.reward_token_type > 0 then
		table.insert(self._awardList, {
			type = var_4_1,
			value = arg_4_1.reward_token_value,
			size = arg_4_1.reward_token_size
		})
	end

	self.m_awardList:setNumItems(#self._awardList)
	self.m_awardList:setScrollEnabled(#self._awardList > 3)
end

function ThemeThirdBossScoreCell:getId()
	return self._info.id
end

function ThemeThirdBossScoreCell:getIndex()
	return self._infoIndex
end

return ThemeThirdBossScoreCell
