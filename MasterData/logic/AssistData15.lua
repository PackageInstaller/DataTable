-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData15.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData15", package.seeall)

local AssistData15 = class("AssistData15", BaseAssistData)

AssistData15.Answer = {
	"A",
	"B",
	"C",
	"D"
}

function AssistData15:init()
	self.keyInputNum1 = "inputNum1"
	self.keyInputNum2 = "inputNum2"
	self.keyInputNum3 = "inputNum3"
	self.keyInputNum4 = "inputNum4"
	self.keyInputNum5 = "inputNum5"
	self.keyInputNum6 = "inputNum6"
	self._assistCellData.raceId1 = self:getCellDataToNumber(self.keyInputNum1)
	self._assistCellData.answer1 = self:getCellDataToNumber(self.keyInputNum2)
	self._assistCellData.raceId2 = self:getCellDataToNumber(self.keyInputNum3)
	self._assistCellData.answer2 = self:getCellDataToNumber(self.keyInputNum4)
	self._assistCellData.raceId3 = self:getCellDataToNumber(self.keyInputNum5)
	self._assistCellData.answer3 = self:getCellDataToNumber(self.keyInputNum6)

	if self._assistCellData.raceId2 > 0 and self._assistCellData.raceId2 == self._assistCellData.raceId1 then
		self:setCellData(self.keyInputNum3, 0)
		self:setCellData(self.keyInputNum4, 0)

		self._assistCellData.raceId2 = 0
		self._assistCellData.answer2 = 0
	end

	if self._assistCellData.raceId3 > 0 and (self._assistCellData.raceId3 == self._assistCellData.raceId1 or self._assistCellData.raceId3 == self._assistCellData.raceId2) then
		self:setCellData(self.keyInputNum5, 0)
		self:setCellData(self.keyInputNum6, 0)

		self._assistCellData.raceId3 = 0
		self._assistCellData.answer3 = 0
	end
end

function AssistData15:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData15:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local leftCount = GoodFeelModel.instance:getTodayInteractLeftCount()

		if leftCount > 0 and self._assistCellData.raceId1 > 0 and self._assistCellData.answer1 > 0 then
			leftCount = leftCount - 1

			local raceId1 = self._assistCellData.raceId1

			local function onSuccessRes(msg, status)
				local eventInfo = msg.eventInfo
				local cfg = GoodFeelConfig.instance:getHudongEvent(eventInfo.eventId)

				if cfg.eventType == 1 then
					local aCfg = GoodFeelConfig.instance:getAnsertEvent(cfg.contentId)
					local win = aCfg and aCfg.rightAnswer == AssistData15.Answer[self._assistCellData.answer]

					GoodFeelController.instance:sendPM_GFHandleEventReq(raceId1, win, true)
				end
			end

			local function callback()
				printInfo("test 请求-好感度答题1", raceId1)
				GoodFeelingAgent.instance:sendPM_GFGetEventInfoReq(raceId1, onSuccessRes)
			end

			table.insert(sendMo.callbackList, callback)
		end

		if leftCount > 0 and self._assistCellData.raceId2 > 0 and self._assistCellData.answer2 > 0 then
			leftCount = leftCount - 1

			local raceId2 = self._assistCellData.raceId2

			local function onSuccessRes(msg, status)
				local eventInfo = msg.eventInfo
				local cfg = GoodFeelConfig.instance:getHudongEvent(eventInfo.eventId)

				if cfg.eventType == 1 then
					local aCfg = GoodFeelConfig.instance:getAnsertEvent(cfg.contentId)
					local win = aCfg and aCfg.rightAnswer == AssistData15.Answer[self._assistCellData.answer]

					GoodFeelController.instance:sendPM_GFHandleEventReq(raceId2, win, true)
				end
			end

			local function callback()
				printInfo("test 请求-好感度答题2", raceId2)
				GoodFeelingAgent.instance:sendPM_GFGetEventInfoReq(raceId2, onSuccessRes)
			end

			table.insert(sendMo.callbackList, callback)
		end

		if leftCount > 0 and self._assistCellData.raceId3 > 0 and self._assistCellData.answer3 > 0 then
			local raceId3 = self._assistCellData.raceId3

			local function onSuccessRes(msg, status)
				local eventInfo = msg.eventInfo
				local cfg = GoodFeelConfig.instance:getHudongEvent(eventInfo.eventId)

				if cfg.eventType == 1 then
					local aCfg = GoodFeelConfig.instance:getAnsertEvent(cfg.contentId)
					local win = aCfg and aCfg.rightAnswer == AssistData15.Answer[self._assistCellData.answer]

					GoodFeelController.instance:sendPM_GFHandleEventReq(raceId3, win, true)
				end
			end

			local function callback()
				printInfo("test 请求-好感度答题3", raceId3)
				GoodFeelingAgent.instance:sendPM_GFGetEventInfoReq(raceId3, onSuccessRes)
			end

			table.insert(sendMo.callbackList, callback)
		end

		return sendMo
	end
end

return AssistData15
