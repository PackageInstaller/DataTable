-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData18.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData18", package.seeall)

local AssistData18 = class("AssistData18", BaseAssistData)

function AssistData18:init()
	self.selectIndex1 = 1
	self.selectIndex2 = 2
end

function AssistData18:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData18:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local cfgActivity = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FirstCharge)
		local curActId = cfgActivity and cfgActivity.activityId
		local lastYearId = YearCardConfig.instance:getCurrActId()

		if self:getCellSelect(self.selectIndex1) then
			local actInfo = YearCardModel.instance:getAnnuityInfo(curActId)

			if actInfo and actInfo.active then
				local hasGain = YearCardModel.instance:getHasGainWeeklyPrize(curActId)

				if not hasGain then
					local function callback()
						printInfo("test 请求年费奖励-每周奖励")
						YearCardController.instance:onClickWeekReward(curActId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end

			if YearCardModel.instance:isActiveAnnuity(lastYearId) and YearCardModel.instance:getEndTime(lastYearId) > ServerTime.now() then
				local hasGain = YearCardModel.instance:getHasGainWeeklyPrize(lastYearId)

				if not hasGain then
					local function callback()
						printInfo("test2 请求年费奖励-每周奖励")
						YearCardController.instance:onClickWeekReward(lastYearId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if self:getCellSelect(self.selectIndex2) then
			local actInfo = YearCardModel.instance:getAnnuityInfo(curActId)

			if actInfo and actInfo.active then
				local monthRewardCfg = YearCardConfig.instance:getMonthRewardCfgs(curActId)

				for i, v in ipairs(monthRewardCfg) do
					local isMatchTime = YearCardController.instance:isCanGet(curActId, v)

					if isMatchTime then
						local isGain = YearCardModel.instance:getIsGainMonthPrize(curActId, v.prizeId)

						if not isGain then
							local prizeId = v.prizeId

							local function callback()
								printInfo("test 请求年费奖励-每月奖励", curActId, prizeId)
								AnnuityAgent.instance:sendPM_AnnuityGainMonthPrizeReq(curActId, prizeId)
							end

							table.insert(sendMo.callbackList, callback)
						end
					end
				end
			end

			if YearCardModel.instance:isActiveAnnuity(lastYearId) and YearCardModel.instance:getEndTime(lastYearId) > ServerTime.now() then
				local monthRewardCfg = YearCardConfig.instance:getMonthRewardCfgs(lastYearId)

				for i, v in ipairs(monthRewardCfg) do
					local isMatchTime = YearCardController.instance:isCanGet(lastYearId, v)

					if isMatchTime then
						local isGain = YearCardModel.instance:getIsGainMonthPrize(lastYearId, v.prizeId)

						if not isGain then
							local prizeId = v.prizeId

							local function callback()
								printInfo("test2 请求年费奖励-每月奖励", lastYearId, prizeId)
								AnnuityAgent.instance:sendPM_AnnuityGainMonthPrizeReq(lastYearId, prizeId)
							end

							table.insert(sendMo.callbackList, callback)
						end
					end
				end
			end
		end

		return sendMo
	end
end

return AssistData18
