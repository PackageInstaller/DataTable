-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData12.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData12", package.seeall)

local AssistData12 = class("AssistData12", BaseAssistData)

AssistData12.MinPowerNum = 6
AssistData12.MaxSweepNum = 99

function AssistData12:init()
	self.selectIndex1 = 1
	self.keyInputNum1_1 = "inputNum1_1"
	self.keyInputNum1_2 = "inputNum1_2"
	self.keyInputNum2_1 = "inputNum2_1"
	self.keyInputNum2_2 = "inputNum2_2"
	self.keyInputNum3_1 = "inputNum3_1"
	self.keyInputNum3_2 = "inputNum3_2"
	self.keyInputNum4_1 = "inputNum4_1"
	self.keyInputNum4_2 = "inputNum4_2"

	local isUseTicket = self:getCellSelect(self.selectIndex1)
	local inputNum1_1 = self:getCellDataToNumber(self.keyInputNum1_1)
	local inputNum1_2 = self:getCellDataToNumber(self.keyInputNum1_2)
	local inputNum2_1 = self:getCellDataToNumber(self.keyInputNum2_1)
	local inputNum2_2 = self:getCellDataToNumber(self.keyInputNum2_2)
	local inputNum3_1 = self:getCellDataToNumber(self.keyInputNum3_1)
	local inputNum3_2 = self:getCellDataToNumber(self.keyInputNum3_2)
	local inputNum4_1 = self:getCellDataToNumber(self.keyInputNum4_1)
	local inputNum4_2 = self:getCellDataToNumber(self.keyInputNum4_2)

	self._assistCellData.isUseTicket = isUseTicket
	self._assistCellData.chapterInfo = {}
	self._assistCellData.chapterInfo[1] = {}
	self._assistCellData.chapterInfo[1].selectNum = inputNum1_1
	self._assistCellData.chapterInfo[1].stageId = inputNum1_2
	self._assistCellData.chapterInfo[1].costTicketNum = self:_getCostTicketNum(1, inputNum1_2)
	self._assistCellData.chapterInfo[2] = {}
	self._assistCellData.chapterInfo[2].selectNum = inputNum2_1
	self._assistCellData.chapterInfo[2].stageId = inputNum2_2
	self._assistCellData.chapterInfo[2].costTicketNum = self:_getCostTicketNum(2, inputNum2_2)
	self._assistCellData.chapterInfo[3] = {}
	self._assistCellData.chapterInfo[3].selectNum = inputNum3_1
	self._assistCellData.chapterInfo[3].stageId = inputNum3_2
	self._assistCellData.chapterInfo[3].costTicketNum = self:_getCostTicketNum(3, inputNum3_2)
	self._assistCellData.chapterInfo[4] = {}
	self._assistCellData.chapterInfo[4].selectNum = inputNum4_1
	self._assistCellData.chapterInfo[4].stageId = inputNum4_2
	self._assistCellData.chapterInfo[4].costTicketNum = self:_getCostTicketNum(4, inputNum4_2)

	for i = 1, 4 do
		local chapterInfo = self._assistCellData.chapterInfo[i]

		chapterInfo.costPower = 0
	end
end

function AssistData12:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData12:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local isUseTicket = self._assistCellData.isUseTicket

		XiaoNuoAssistCostModel.instance:setCoin(self:getFuncIndex(), GameEnum.GoldType.Tili, 0)

		local chapterId = 1

		self:_addCallback(sendMo, chapterId, isUseTicket)

		chapterId = 2

		self:_addCallback(sendMo, 2, isUseTicket)

		chapterId = 3

		self:_addCallback(sendMo, 3, isUseTicket)

		chapterId = 4

		self:_addCallback(sendMo, 4, isUseTicket)

		return sendMo
	end
end

function AssistData12:_addCallback(sendMo, chapterId, isUseTicket)
	local stageId = self._assistCellData.chapterInfo[chapterId].stageId
	local times = self._assistCellData.chapterInfo[chapterId].selectNum
	local costTicketNum = self._assistCellData.chapterInfo[chapterId].costTicketNum
	local curCount, maxCount = MaterialChallengeModel.instance:getCostLimitCount(chapterId)
	local leftCount = maxCount - curCount

	if times <= leftCount and chapterId > 0 and stageId > 0 and times > 0 then
		local cfgStage = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)
		local unitPower = cfgStage.power
		local curTotalPower = MaterialMgr.getMatCount(GameEnum.GoldType.Tili)
		local leftTimes = times - costTicketNum

		XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), GameEnum.GoldType.Tili, leftTimes * unitPower)

		local costTotalPower = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), GameEnum.GoldType.Tili)

		if costTotalPower <= curTotalPower then
			local isDoubleTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material, chapterId)

			local function resFunc(msg)
				MaterialChallengeModel.instance:addChallengeCount(chapterId, #msg.prizes)

				if isDoubleTime then
					MaterialChallengeModel.instance:addChallengeDoubleRewardCount(chapterId, msg.multiplyTimes)
				end
			end

			if isUseTicket and costTicketNum > 0 then
				local function callback()
					MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(chapterId, stageId, costTicketNum, true, resFunc)
				end

				table.insert(sendMo.callbackList, callback)
			end

			if leftTimes > 0 then
				local function callback1()
					MaterialChallengeController.instance:sendMCLG_SweepsByTimesReq(chapterId, stageId, leftTimes, false, resFunc)
				end

				table.insert(sendMo.callbackList, callback1)
			end
		end
	end
end

function AssistData12:_getCostTicketNum(chapterId, stageId)
	local cfgStage = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)

	if not cfgStage then
		return 0
	end

	local ticketLeftCount = 0

	if self._assistCellData.isUseTicket then
		local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)
		local totalTicketNum = MaterialMgr.getMatCount(cfgStage.ticket)

		ticketLeftCount = Mathf.Max(0, Mathf.Floor(totalTicketNum / ticketNum))
	end

	return ticketLeftCount >= self._assistCellData.chapterInfo[chapterId].selectNum and self._assistCellData.chapterInfo[chapterId].selectNum or ticketLeftCount
end

return AssistData12
