-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData7.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData7", package.seeall)

local AssistData7 = class("AssistData7", BaseAssistData)

function AssistData7:init()
	self.selectIndex1 = 1
	self.selectIndex2 = 2
	self.selectIndex3 = 3
	self.selectIndex4 = 4
end

function AssistData7:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData7:getSendCallbackList()
	if self:getOpenData() then
		local id = PigraiseModel.instance:getPigId()
		local isExistPig = id ~= nil
		local sendMo = self:getSendMo()

		if isExistPig and self:getCellSelect(self.selectIndex1) then
			local dataList = PigraiseModel.instance:getAdventurePrizeList()

			if dataList ~= nil and #dataList ~= 0 then
				local function callback()
					printInfo("test 请求 溜溜宠 一键收取")
					PigraiseController.instance:getAdventurePrizeReq()
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		if isExistPig and self:getCellSelect(self.selectIndex2) then
			local touchtime = PigraiseModel.instance:getDailyTouchTimes()

			if touchtime <= 0 then
				-- block empty
			elseif PigraiseModel.instance:isupdatePigCDTime() then
				-- block empty
			elseif VipModel.instance:getIsAbleToOneKeyToTouchPig() then
				local function callback()
					printInfo("test 请求 溜溜宠 一键抚摸 vip")

					local id = PigraiseModel.instance:getPigId()

					AnimalsAgent.instance:sendPM_AnimalsOneKeyTouchReq(checknumber(id))
				end

				table.insert(sendMo.callbackList, callback)
			else
				local function callback()
					printInfo("test 请求 溜溜宠 一键抚摸 普通")

					local id = PigraiseModel.instance:getPigId()

					AnimalsAgent.instance:sendPM_AnimalsTouchReq(checknumber(id))
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		if isExistPig and self:getCellSelect(self.selectIndex3) then
			self._feedItemInfo = PigraiseConfig.instance:getFeedCostItem()
			self._useItem = string.split(self._feedItemInfo, ":")

			local curCount = checkint(MaterialMgr.getMatCount(self._feedItemInfo))
			local maxCount = 10

			if curCount < checkint(self._useItem[3]) and checkint(self._useItem[3]) > 0 then
				-- block empty
			elseif PigraiseModel.instance:getPigCurEnergy() >= PigraiseConfig.instance:getMaxEnergyVal() then
				-- block empty
			else
				local function callback()
					printInfo("test 请求 溜溜宠 一键喂养")

					local id = PigraiseModel.instance:getPigId()

					AnimalsAgent.instance:sendPM_AnimalsFeedReq(checknumber(id))
				end

				local realCount = Mathf.Clamp(curCount, 1, maxCount)

				for i = 1, realCount do
					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		if isExistPig and self:getCellSelect(self.selectIndex4) and PigraiseModel.instance:isExistFeedbackEventId() then
			local function callback()
				printInfo("test 请求 溜溜宠 宠物奇事")
				PigraiseController.instance:processFeedBackReq()
			end

			table.insert(sendMo.callbackList, callback)
		end

		return sendMo
	end
end

return AssistData7
