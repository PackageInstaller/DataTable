local var_0_0 = g.core.model.User.achievementData
local var_0_1 = g.core.model.User.resourceData
local var_0_2 = g.core.common.Goods
local AchievementTotalProgPop = class("AchievementTotalProgPop", require("app.fairyGUI.achievement.UI_AchievementTotalProgPop"), function()
	return fgui.GComponent:create({
		resName = "AchievementTotalProgPop",
		pkgName = "achievement",
		isFullScreen = false,
		pkgPath = "ui/achievement/achievement"
	}, ...)
end)

function AchievementTotalProgPop:ctor()
	self._dataList = var_0_0:getAwardDataStructArr()

	if #self._dataList > 1 then
		table.sort(self._dataList, var_0_0:_getSortRuleByStateAndTargetNum())
	end

	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_progressDesText:setText(g.core.lang:get(113005, {
		number = var_0_1:getResourceById(var_0_2.RESOURCE.TYPE_ACHIEVEMENT)
	}))
	self:showAtCenter(true)
end

function AchievementTotalProgPop:onLoad()
	self.m_rewardList:setNumItems(#self._dataList)
end

function AchievementTotalProgPop:_onAwardItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._dataList[arg_4_1 + 1])
end

return AchievementTotalProgPop
