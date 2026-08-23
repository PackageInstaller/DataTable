local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionRewardPop = class("WeeklyCompetitionRewardPop", require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionRewardPop"), function()
	return fgui.GComponent:create({
		resName = "WeeklyCompetitionRewardPop",
		pkgPath = "ui/weeklyCompetition/weeklyCompetition",
		pkgName = "weeklyCompetition"
	})
end)

function WeeklyCompetitionRewardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._weeklyData = arg_2_1.weeklyData
	self._rewardInfoList = arg_2_1.awardList

	self:_initView()
end

function WeeklyCompetitionRewardPop:_initView()
	self.m_previewList:setVirtual()
	self.m_previewList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_previewList:doFairyBatching(false)
end

function WeeklyCompetitionRewardPop:onLoad()
	self:_updatePop()
end

function WeeklyCompetitionRewardPop:_updatePop()
	self.m_previewList:setNumItems(#self._rewardInfoList)
end

function WeeklyCompetitionRewardPop:_onAwardItemRender(arg_6_1, arg_6_2)
	local var_6_0 = self._rewardInfoList[arg_6_1 + 1]
	local var_6_1 = WeeklyCompetitionConst.REWARD_STATE.NONE
	local var_6_2 = self._weeklyData:getCurSection()

	if arg_6_1 + 1 < var_6_2 then
		var_6_1 = WeeklyCompetitionConst.REWARD_STATE.REWARDED
	elseif var_6_2 == arg_6_1 + 1 and var_6_0.state == WeeklyCompetitionConst.REWARD_STATE.REWARDED then
		var_6_1 = WeeklyCompetitionConst.REWARD_STATE.REWARDED
	end

	arg_6_2:updateItem(var_6_0, var_6_1)
end

return WeeklyCompetitionRewardPop
