-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData14.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData14", package.seeall)

local AssistData14 = class("AssistData14", BaseAssistData)

function AssistData14:init()
	printInfo("test AssistData14:init")

	self.selectIndex1 = 1
	self.keyInputNum1 = "inputNum1"
	self._assistCellData.realRemainingTimes = self:getCellDataToNumber(self.keyInputNum1)

	printInfo("test AssistData14:init 初始化选择次数", self._assistCellData.realRemainingTimes)
end

function AssistData14:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData14:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local towerId = WTowerModel.instance:getTowerId()

		printInfo("test AssistData14 进行勇者之塔产出购买", WTowerModel.instance:getCurLevel(towerId) > 1 or towerId > 1)

		local isCanExcute = WTowerModel.instance:getCurLevel(towerId) > 1 or towerId > 1

		if isCanExcute then
			if self:getCellSelect(self.selectIndex1) then
				local isCanGet = WTowerModel.instance:getBoxGainTime() < ServerTime.now()

				if isCanGet then
					local function callback()
						WTowerController.instance:sendGainWarriorTowerProfitPrizeReq()
					end

					table.insert(sendMo.callbackList, callback)
				end
			end

			local selectNum = self._assistCellData.realRemainingTimes
			local usedTotalTimes, leftFreeTimes = WTowerModel.instance:getTimeBoxTimes()
			local leftTotalTimes = VipModel.instance:getFreeSweepTimesOfWarriorTower() + VipModel.instance:getBuyChallengeTimesOfWarriorTower() - usedTotalTimes
			local realSelectNum = Mathf.Min(selectNum, leftTotalTimes)
			local costDiamondNum = self:_getCoinInfo(realSelectNum)

			XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), AssistCell14.Diamond, costDiamondNum)

			local costTotalDimond = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), AssistCell14.Diamond)
			local curTotalDiamond = MaterialMgr.getMatCount(AssistCell14.Diamond)

			if costTotalDimond <= curTotalDiamond then
				for i = 1, realSelectNum do
					if i <= leftFreeTimes then
						local function callback()
							WarriorTowerAgent.instance:sendTurnTimeWarriorTowerReq(true)

							local usedTotalTimes, leftFreeTimes = WTowerModel.instance:getTimeBoxTimes()

							WTowerModel.instance:setTimeBoxFreeTimes(math.max(leftFreeTimes - 1, 0))
							WTowerModel.instance:setTimeBoxTotalTimes(usedTotalTimes + 1)
						end

						table.insert(sendMo.callbackList, callback)
					else
						local function callback()
							WarriorTowerAgent.instance:sendTurnTimeWarriorTowerReq(false)

							local usedTotalTimes, leftFreeTimes = WTowerModel.instance:getTimeBoxTimes()

							WTowerModel.instance:setTimeBoxTotalTimes(usedTotalTimes + 1)
						end

						table.insert(sendMo.callbackList, callback)
					end
				end
			end
		end

		return sendMo
	end
end

function AssistData14:_getCoinInfo(selectTimes)
	local totalUseTimes, freeTimes = WTowerModel.instance:getTimeBoxTimes()
	local totalFreeTimes = VipModel.instance:getFreeSweepTimesOfWarriorTower()
	local shoufei = selectTimes - freeTimes
	local cfgList = WTowerConfig.instance:getProfitCfg().dataList
	local totalCount = #cfgList
	local cost = 0
	local countFree = 0
	local count = 0

	for i = totalUseTimes + 1, totalCount do
		countFree = countFree + 1

		if freeTimes < countFree then
			if count < shoufei then
				local t, id, num = MaterialMgr.getMatParams(cfgList[i].cost)

				if t == MatType.Diamond or t == MatType.Diamond_Consume then
					cost = cost + num
					count = count + 1
				end
			else
				break
			end
		end
	end

	return cost
end

return AssistData14
