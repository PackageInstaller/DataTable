local var_0_0 = g.core.lang
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.redCliffData
local var_0_4 = g.core.const.ConstMgr.RedCliffConst
local RedCliffPoolFrontComp = class("RedCliffPoolFrontComp", require("app.fairyGUI.redCliff.UI_RedCliffPoolFrontComp"))

function RedCliffPoolFrontComp:ctor()
	self._poolId = 0
	self._poolInfo = nil
	self._startTime = 0
	self._cdHandler = nil

	self.m_matchUserBtn:addClickListener(handler(self, self._onClickMatchUserBtn))
	self.m_upgradeBtn:addClickListener(handler(self, self._onClickUpgradeBtn))
end

function RedCliffPoolFrontComp:updatePoolComp(arg_2_1)
	self._poolInfo = arg_2_1.poolInfo

	if self._poolInfo then
		self._poolId = self._poolInfo.id

		self.m_poolTypeController:setSelectedIndex(self._poolInfo.type - 1)
		self.m_poolName:setText(self._poolInfo.pool_name)
		self:_updateTimeView()
		self:_updateMyInfo()
		self:_updateLookBtn()
	end
end

function RedCliffPoolFrontComp:_updateMyInfo()
	local var_3_0 = var_0_3:getUpgradeStateByPoolId(self._poolId)

	self.m_upgradeStateController:setSelectedIndex(var_3_0)

	if var_0_3:isApply() then
		self.m_myInfoGroup:setVisible(false)

		if var_3_0 == var_0_4.UPGRADE_STATE.UPGRADE then
			self.m_poolTip:setText(g.core.lang:get(421106, {
				pool = var_0_3:getPoolInfoByPoolId(var_0_3:getMyPoolId()).pool_name
			}))
		elseif var_3_0 == var_0_4.UPGRADE_STATE.CURRENT then
			self.m_myInfoGroup:setVisible(true)
			self:_updateRankAndScore()
		elseif self._poolId == var_0_4.POOL_ID.CROSS then
			self:_updateRankAndScore()
		else
			local var_3_1 = self:_getPrevPoolInfo(self._poolId)

			self.m_poolTip:setText(g.core.lang:get(421016, {
				pool = var_3_1.pool_name,
				num = var_3_1.upgrade_value
			}))
		end
	else
		self.m_myInfoGroup:setVisible(false)

		if self._poolId == var_0_4.POOL_ID.CROSS then
			self.m_tipGroup:setVisible(false)
			self.m_myInfoGroup:setVisible(true)
			self.m_rank:setText(g.core.lang:get(421125))
			self.m_score:setText(g.core.lang:get(421025))
		else
			self.m_tipGroup:setVisible(true)

			local var_3_2 = self:_getPrevPoolInfo(self._poolId)

			self.m_poolTip:setText(g.core.lang:get(421016, {
				pool = var_3_2.pool_name,
				num = var_3_2.upgrade_value
			}))
		end
	end
end

function RedCliffPoolFrontComp:_getPrevPoolInfo(arg_4_1)
	if arg_4_1 == var_0_4.POOL_ID.ALL then
		return var_0_3:getPoolInfoByPoolId(var_0_4.POOL_ID.CROSS)
	elseif arg_4_1 == var_0_4.POOL_ID.SEMI then
		return var_0_3:getPoolInfoByPoolId(var_0_4.POOL_ID.ALL)
	elseif arg_4_1 == var_0_4.POOL_ID.GRAND then
		return var_0_3:getPoolInfoByPoolId(var_0_4.POOL_ID.SEMI)
	end
end

function RedCliffPoolFrontComp:_updateTimeView()
	local var_5_0 = var_0_3:getPoolStateByPoolId(self._poolId)

	self.m_poolStateController:setSelectedIndex(var_5_0)

	if var_0_3:isApply() and var_0_3:getMyPoolId() == self._poolId then
		if var_5_0 == var_0_4.POOL_STATE.ALL_NOT_START then
			local var_5_1, var_5_2 = var_0_3:getDurationByPoolId(self._poolId)

			self.m_startTimeTxt:setText(var_0_0:get(421012, {
				time = var_0_1:getDateMDHMFormat(var_5_1)
			}))
		elseif var_5_0 == var_0_4.POOL_STATE.CUR_NOT_START then
			local var_5_3 = var_0_3:getCurrentPoolFightTime(self._poolId)

			if var_5_3 then
				self._startTime = var_5_3.startTime

				self:_updateCountDown()

				self._cdHandler = self._cdHandler or self:newSchedule(handler(self, self._updateCountDown), 1)
			end
		elseif var_5_0 == var_0_4.POOL_STATE.CUR_START then
			local var_5_4 = var_0_3:getCurrentPoolFightTime(self._poolId)
			local var_5_5 = var_0_1:getDateObject(var_5_4.startTime)
			local var_5_6 = var_0_1:getDateObject(var_5_4.endTime)

			self.m_startTimeTxt:setText(var_0_0:get(421014, {
				startTime = string.format("%02d:%02d", var_5_5.hour, var_5_5.min),
				endTime = string.format("%02d:%02d", var_5_6.hour, var_5_6.min)
			}))
		end
	else
		if self._cdHandler then
			self:cancelSchedule(self._cdHandler)

			self._cdHandler = nil
		end

		if var_5_0 ~= var_0_4.POOL_STATE.ALL_END then
			local var_5_7, var_5_8 = var_0_3:getDurationByPoolId(self._poolId)

			self.m_startTimeTxt:setText(var_0_0:get(421012, {
				time = var_0_1:getDateMDHMFormat(var_5_7)
			}))
		end
	end
end

function RedCliffPoolFrontComp:_updateCountDown()
	local var_6_0 = self._startTime - var_0_1:getTime()

	if var_6_0 > 0 then
		local var_6_1 = math.floor(var_6_0 / 3600)
		local var_6_2 = ""

		var_6_2 = var_6_1 > 0 and string.format("%02d:%02d:%02d", var_6_1, (var_6_0 - var_6_0 % 60) % 3600 / 60, var_6_0 % 60) or string.format("%02d:%02d", (var_6_0 - var_6_0 % 60) % 3600 / 60, var_6_0 % 60)

		self.m_startTimeTxt:setText(var_0_0:get(421015, {
			time = var_6_2
		}))
	elseif self._cdHandler then
		self:cancelSchedule(self._cdHandler)

		self._cdHandler = nil

		self:_updateTimeView()
	end
end

function RedCliffPoolFrontComp:_updateRankAndScore()
	local var_7_0, var_7_1 = var_0_3:getMyRankAndScore()

	if var_7_0 > 0 then
		self.m_rank:setText(var_7_0)
		self.m_score:setText(var_7_1)
	else
		self.m_rank:setText(g.core.lang:get(421125))
		self.m_score:setText(g.core.lang:get(421025))
	end
end

function RedCliffPoolFrontComp:_onClickMatchUserBtn()
	if self._poolId == var_0_4.POOL_ID.GRAND then
		var_0_2:pushPopup(require("app.view.module.redCliff.stage.RedCliffGrandFinalPop").new(), {
			touchDisappear = true,
			ignoreTouch = false
		})
	elseif self._poolId == var_0_4.POOL_ID.SEMI then
		var_0_2:pushPopup(require("app.view.module.redCliff.view.mainView.RedCliffSemiFinalPop").new(), {
			touchDisappear = true,
			ignoreTouch = false
		})
	end
end

function RedCliffPoolFrontComp:_onClickUpgradeBtn()
	if self._poolId == var_0_4.POOL_ID.GRAND then
		var_0_2:pushPopup(require("app.view.module.redCliff.view.mainView.RedCliffGrandUpgradePop").new({}), {
			touchDisappear = true,
			ignoreTouch = false
		})
	else
		var_0_2:pushPopup(require("app.view.module.redCliff.view.mainView.RedCliffPoolUpgradePop").new({
			poolId = self._poolId
		}), {
			touchDisappear = true,
			ignoreTouch = false
		})
	end
end

function RedCliffPoolFrontComp:_updateLookBtn()
	local var_10_0 = var_0_1:getTime()
	local var_10_1, var_10_2 = var_0_3:getDurationByPoolId(self._poolId)

	if self._poolId == var_0_4.POOL_ID.SEMI or self._poolId == var_0_4.POOL_ID.GRAND then
		local var_10_3 = var_0_3:getFirstMatchTimeByPoolId(self._poolId)

		self.m_matchUserBtn:setVisible(var_10_1 <= var_10_0 and var_10_0 < var_10_3.endTime)
		self.m_upgradeBtn:setVisible(var_10_0 >= var_10_3.endTime)
	else
		local var_10_5 = self:_getUpgradeBtnShowTime((self._poolId == var_0_4.POOL_ID.ALL or nil) and var_0_4.POOL_ID.SEMI)

		self.m_matchUserBtn:setVisible(false)
		self.m_upgradeBtn:setVisible(var_10_5 <= var_10_0)
	end
end

function RedCliffPoolFrontComp:_getUpgradeBtnShowTime(arg_11_1)
	local var_11_0, var_11_1 = var_0_3:getDurationByPoolId(arg_11_1)

	return var_0_3:getFirstMatchTimeByPoolId(self._poolId, var_11_0 - 86400).endTime
end

return RedCliffPoolFrontComp
