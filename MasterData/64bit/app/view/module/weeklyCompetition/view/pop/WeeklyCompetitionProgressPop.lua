local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionProgressPop = class("WeeklyCompetitionProgressPop", require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionProgressPop"), function()
	return fgui.GComponent:create({
		resName = "WeeklyCompetitionProgressPop",
		pkgPath = "ui/weeklyCompetition/weeklyCompetition",
		pkgName = "weeklyCompetition"
	})
end)

function WeeklyCompetitionProgressPop:ctor(arg_2_1)
	self:showAtCenter()

	self._rewardInfo = arg_2_1.rewardInfo
	self._weeklyData = arg_2_1.weeklyData

	self:_initView()
	self:_updatePop()
end

function WeeklyCompetitionProgressPop:_initView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_awardList:doFairyBatching(false)
end

function WeeklyCompetitionProgressPop:_updatePop()
	local var_4_0 = 1

	if WeeklyCompetitionConst.REWARD_STATE.REWARDED ~= self._rewardInfo.state then
		self.m_tipText:setText(g.core.lang:get(420104, {
			name = self._weeklyData:getScoreIconName(),
			score = self._rewardInfo.cfg.score
		}))

		var_4_0 = 0
	end

	self.m_isGetController:setSelectedIndex(var_4_0)
	self.m_awardList:setNumItems(#self._rewardInfo.awards)
end

function WeeklyCompetitionProgressPop:_onAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._rewardInfo.awards[arg_5_1 + 1])
end

return WeeklyCompetitionProgressPop
