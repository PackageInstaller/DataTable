local var_0_0 = g.core.const.ConstMgr.BountyConst
local BountyDailyPointCell = class("BountyDailyPointCell", require("app.fairyGUI.bounty.UI_BountyDailyPointCell"))

function BountyDailyPointCell:ctor()
	self._dailyInfo = nil

	self:_initBtn()
end

function BountyDailyPointCell:_initBtn()
	self.m_awardBtn:addClickListener(handler(self, self._onAwardClick))
end

function BountyDailyPointCell:updatePlayerCell(arg_3_1, arg_3_2)
	self._dailyInfo = arg_3_1

	local var_3_0 = g.core.common.Path:getIconByTypeValue(var_0_0.SCORE_ITEM.type, var_0_0.SCORE_ITEM.value, true)

	self.m_itemLoader1:setURL(var_3_0)
	self.m_itemLoader2:setURL(var_3_0)
	self.m_rankComp:updateRankIndex({
		rank = arg_3_2
	})
	self.m_numText1:setText(arg_3_1.score)

	local var_3_1 = math.floor(arg_3_1.cfg.value / 1000 * arg_3_1.score)

	self.m_numText2:setText(var_3_1)
	self:_updateUserGroup((g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.uid)))

	if var_3_1 < 1 then
		self.m_getAwardController:setSelectedIndex(3)
	elseif g.core.model.User.bountyData:isJoinGuildToday() or arg_3_2 > 5 then
		self.m_getAwardController:setSelectedIndex(2)
	elseif g.core.model.User.bountyData:isGetDailyReward(self._dailyInfo.uid) then
		self.m_getAwardController:setSelectedIndex(1)
	else
		self.m_getAwardController:setSelectedIndex(0)
	end
end

function BountyDailyPointCell:_updateUserGroup(arg_4_1)
	if not arg_4_1 then
		self.m_userGroup:setVisible(false)

		return
	end

	self.m_userIconComp:updateAsUser(arg_4_1)
	self.m_userNameText:setText(arg_4_1.name)
	self.m_powerText:setText(arg_4_1.fight_value)
	self.m_userGroup:setVisible(true)
end

function BountyDailyPointCell:_onAwardClick()
	if self._dailyInfo.uid == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(422507))

		return
	end

	self:dispatchCompEvent("clickAward", {
		info = self._dailyInfo
	})
end

return BountyDailyPointCell
