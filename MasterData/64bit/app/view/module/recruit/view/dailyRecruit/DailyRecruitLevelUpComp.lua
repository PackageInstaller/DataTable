local DailyRecruitLevelUpComp = class("DailyRecruitLevelUpComp", require("app.fairyGUI.recruitDaily.UI_DailyRecruitLevelUpComp"))

function DailyRecruitLevelUpComp:update(arg_1_1)
	self._lastInfo = arg_1_1.compData.lastInfo
	self._curInfo = arg_1_1.compData.curInfo
	self._unlockInfoList = {}
	self._awardInfoList = {}

	self.m_lastLevelText:setText(self._lastInfo.level)
	self.m_curLevelText:setText(self._curInfo.level)
	self.m_unlockList:setIniter()
	self.m_unlockList:setItemRenderer(handler(self, self._onUnlockRender))
	self.m_awardList:setIniter()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRender))
end

function DailyRecruitLevelUpComp:_onAwardRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awardInfoList[arg_2_1 + 1])
end

function DailyRecruitLevelUpComp:_onUnlockRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		type = self._unlockInfoList[arg_3_1 + 1].reward_type,
		value = self._unlockInfoList[arg_3_1 + 1].reward_value,
		size = self._unlockInfoList[arg_3_1 + 1].reward_size
	})
end

function DailyRecruitLevelUpComp:playAnimate()
	self._awardInfoList = {}

	table.insert(self._awardInfoList, {
		type = self._lastInfo.reward_type,
		value = self._lastInfo.reward_value,
		size = self._lastInfo.reward_size
	})
	self.m_awardList:setNumItems(#self._awardInfoList)

	self._unlockInfoList = {}

	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in g.core.config.daily_recruit_pool_info.ipairs() do
		if iter_4_1.pool_id == self._lastInfo.pool_show then
			if iter_4_1.if_locked == 0 or self._lastInfo.level >= iter_4_1.unlock_level then
				var_4_0[iter_4_1.reward_type .. "_" .. iter_4_1.reward_value] = iter_4_1
			end
		elseif iter_4_1.pool_id == self._curInfo.pool_show and (iter_4_1.if_locked == 0 or self._curInfo.level >= iter_4_1.unlock_level) then
			var_4_1[iter_4_1.reward_type .. "_" .. iter_4_1.reward_value] = iter_4_1
		end
	end

	for iter_4_2, iter_4_3 in pairs(var_4_1) do
		if not var_4_0[iter_4_2] then
			table.insert(self._unlockInfoList, iter_4_3)
		end
	end

	if #self._unlockInfoList > 0 then
		self.m_hasUnlockListController:setSelectedIndex(1)
		self.m_unlockList:setNumItems(#self._unlockInfoList)
	else
		self.m_hasUnlockListController:setSelectedIndex(0)
	end
end

return DailyRecruitLevelUpComp
