local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local BattleBossRewardComp = class("BattleBossRewardComp", require("app.fairyGUI.battle.UI_BattleBossRewardComp"))
local var_0_3 = 10

function BattleBossRewardComp:ctor()
	self:setVisible(false)

	self._awardNum = 0
	self._toAwardNum = 0
end

function BattleBossRewardComp:updateView(arg_2_1)
	self:setVisible(true)

	local var_2_0 = g.core.config.activity_theme_boss_award_info.get(arg_2_1.rebornCount).award_size

	self.m_rewardIcon:updateIcon({
		type = arg_2_1.bossBaseInfo.award_type,
		value = arg_2_1.bossBaseInfo.award_value,
		size = var_2_0
	})

	self._toAwardNum = var_2_0

	local var_2_1 = (self._toAwardNum - self._awardNum) / var_0_3

	self:_cancelTimer()

	if self._awardNum == 0 then
		self.m_enterTransition:play()
	end

	if self._toAwardNum ~= 0 then
		self._scheduler = self:newSchedule(function()
			self:_awardIncrease(var_2_1)
		end, 0.05)
	end
end

function BattleBossRewardComp:_awardIncrease(arg_4_1)
	self._awardNum = self._awardNum + arg_4_1

	if self._awardNum < self._toAwardNum then
		self.m_rewardText:setText("*" .. math.floor(self._awardNum))
	else
		self:_cancelTimer()
		self.m_rewardText:setText("*" .. self._toAwardNum)

		self._awardNum = self._toAwardNum
	end

	self.m_upTransition:play()
end

function BattleBossRewardComp:onUnload()
	self:_cancelTimer()
end

function BattleBossRewardComp:_cancelTimer()
	if self._scheduler then
		self:cancelSchedule(self._scheduler)
	end
end

return BattleBossRewardComp
