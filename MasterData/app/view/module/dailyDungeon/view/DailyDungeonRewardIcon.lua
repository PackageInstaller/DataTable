local DailyDungeonRewardIcon = class("DailyDungeonRewardIcon", require("app.fairyGUI.dailyDungeon.UI_DailyDungeonRewardIcon"))

function DailyDungeonRewardIcon:ctor()
	return
end

function DailyDungeonRewardIcon:updateIcon(arg_2_1)
	self.m_rewardIcon:updateIcon(arg_2_1.award)
	self.m_numTxt:setText(self:getRewardNumText(arg_2_1.min) .. "~" .. self:getRewardNumText(arg_2_1.max))
end

function DailyDungeonRewardIcon:getRewardNumText(arg_3_1)
	return tostring(arg_3_1)
end

return DailyDungeonRewardIcon
