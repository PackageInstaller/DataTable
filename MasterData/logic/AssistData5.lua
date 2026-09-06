-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData5.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData5", package.seeall)

local AssistData5 = class("AssistData5", BaseAssistData)

function AssistData5:init()
	self.selectIndex1 = 1
	self.selectIndex2 = 2
	self.selectIndex3 = 3
	self.selectIndex4 = 4
end

function AssistData5:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData5:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local isDone = SupplymergeController.instance:isStrengthPrize()
			local isCanGet = SupplymergeController.instance:getTimeState(0) == 1 or SupplymergeController.instance:getTimeState(1) == 1 or SupplymergeController.instance:getTimeState(2) == 1

			if not isDone or isCanGet then
				local function callback()
					SupplymergeController.instance:sendBasicBenefitsGainPrizeReq()
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		return sendMo
	end
end

return AssistData5
