-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData22.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData22", package.seeall)

local AssistData22 = class("AssistData22", BaseAssistData)

function AssistData22:init()
	printInfo("test AssistData22:init")

	self.selectIndex1 = 1
	self.keyInputNum1 = "inputNum1"
	self._assistCellData.realRemainingTimes = self:getCellDataToNumber(self.keyInputNum1)

	printInfo("test AssistData22:init 初始化选择次数", self._assistCellData.realRemainingTimes)
end

function AssistData22:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData22:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local isCanExcute = self:isCanQuickPass()

		if isCanExcute then
			local selectNum = self._assistCellData.realRemainingTimes
			local usedTotalTimes = BreakFormationModel.instance:getHasFirstPassTimes()
			local buyTimesLimit = BreakFormationConfig.instance:getBuyCfgLength()
			local freeTimes = VipModel.instance:getFreeGetTimesOfBreakFormation()
			local hasBuyFirstCount = BreakFormationModel.instance:getHasBuyFirstPassTimes()
			local totalTimesLimit = freeTimes + buyTimesLimit
			local leftFreeTimes = Mathf.Max(freeTimes - usedTotalTimes, 0)
			local leftTotalTimes = totalTimesLimit - usedTotalTimes
			local realSelectNum = Mathf.Min(selectNum, leftTotalTimes, self:getUnPassCount())
			local leftNoUseTimes = (freeTimes <= usedTotalTimes and Mathf.Max(hasBuyFirstCount + freeTimes - usedTotalTimes, 0) or 0) + leftFreeTimes
			local costDiamondNum = self:_getCoinInfo(realSelectNum)

			XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), AssistCell22.Diamond, costDiamondNum)

			local costTotalDimond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell22.Diamond)
			local curTotalTick = MaterialMgr.getMatCount(AssistCell22.Tick)
			local curTotalDiamond = MaterialMgr.getMatCount(AssistCell22.Diamond)

			if costTotalDimond <= curTotalDiamond and realSelectNum <= curTotalTick then
				local periodId = BreakFormationModel.instance.periodId
				local curdatalist, minUnPassId = self:getCurFormationCardListAndMinUnPassId()

				if curdatalist ~= nil and #curdatalist > 0 and minUnPassId then
					for i = 1, realSelectNum do
						local data = curdatalist[minUnPassId + i - 1]

						if data then
							local monsterId = data.monsterId

							if i <= leftNoUseTimes then
								local function callback()
									BreachFormationAgent.instance:sendPM_BreachFormationQuickPassReq(periodId, monsterId)
								end

								table.insert(sendMo.callbackList, callback)
							else
								local function callback()
									local buyTime = BreakFormationModel.instance:getHasBuyFirstPassTimes()

									BreachFormationAgent.instance:sendPM_BreachFormationBuyFirstPassTimesReq(buyTime, function(msg)
										BreakFormationModel.instance:addHasBuyFirstPassTimes()
										BreakFormationController.instance:localNotify("onDataLoaded")
									end)
								end

								table.insert(sendMo.callbackList, callback)

								local function sweepCallback()
									BreachFormationAgent.instance:sendPM_BreachFormationQuickPassReq(periodId, monsterId)
								end

								table.insert(sendMo.callbackList, sweepCallback)
							end
						end
					end
				end
			end

			if self:getCellSelect(self.selectIndex1) then
				local isCanGet = self:isCanGetProgressPrize()

				if isCanGet then
					local function callback()
						local periodId = BreakFormationModel.instance.periodId

						BreachFormationAgent.instance:sendPM_BreachFormationOneKeyGainProgressPrizeReq(periodId)
					end

					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		return sendMo
	end
end

function AssistData22:_getCoinInfo(selectTimes)
	local totalUseTimes = BreakFormationModel.instance:getHasFirstPassTimes()
	local totalFreeTimes = VipModel.instance:getFreeGetTimesOfBreakFormation()
	local leftFreeTimes = Mathf.Max(totalFreeTimes - totalUseTimes, 0)
	local hasUseBuyTimes = Mathf.Min(totalFreeTimes - totalFreeTimes, 0)
	local shoufei = selectTimes - leftFreeTimes
	local cost = 0

	for i = hasUseBuyTimes + 1, shoufei + hasUseBuyTimes do
		local costCfg = BreakFormationConfig.instance:getBuyCfgByTimes(i)

		if costCfg and not string.nilorempty(costCfg.consume) then
			local t, id, num = MaterialMgr.getMatParams(costCfg.consume)

			if t == MatType.Diamond or t == MatType.Diamond_Consume then
				cost = cost + num
			end
		end
	end

	return cost
end

function AssistData22:isCanQuickPass()
	local curdataList, minUnPassId = self:getCurFormationCardListAndMinUnPassId()

	if curdataList == nil or #curdataList == 0 then
		return false
	end

	if minUnPassId == nil then
		return false
	end

	return true
end

function AssistData22:getMaxUnPassData()
	local lastData
	local curDataList = BreakFormationModel.instance:getFormationCards()

	for i = 1, #curDataList do
		local data = curDataList[i]
		local score = BreakFormationModel.instance:GetPozhanScorelistByType(true, data.index)

		lastData = data

		if not score or score < 0 then
			break
		end
	end

	return lastData
end

function AssistData22:getCurFormationCardListAndMinUnPassId()
	local curDataList = BreakFormationModel.instance:getFormationCards()
	local minUnPassId

	for i = 1, #curDataList do
		local data = curDataList[i]
		local score = BreakFormationModel.instance:GetPozhanScorelistByType(true, data.index)

		minUnPassId = i

		if not score or score < 0 then
			break
		end
	end

	return curDataList, minUnPassId
end

function AssistData22:isCanGetProgressPrize()
	local ownHurtCount, progInfoList = BreakFormationModel.instance:GetPozhenProgReceiveList()

	for k, v in pairs(progInfoList) do
		local state = BreakFormationModel.instance:getBtnState(BreakFormationModel.instance:getFightId(), v.__index)

		if state == BreakFormationModel.CAN_GET then
			return true
		end
	end

	return false
end

function AssistData22:getUnPassCount()
	local count = 0
	local curDataList = BreakFormationModel.instance:getFormationCards()

	for i = 1, #curDataList do
		local data = curDataList[i]
		local score = BreakFormationModel.instance:GetPozhanScorelistByType(true, data.index)

		if not score or score < 0 then
			count = count + 1
		end
	end

	return count
end

return AssistData22
