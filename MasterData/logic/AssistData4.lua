-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData4.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData4", package.seeall)

local AssistData4 = class("AssistData4", BaseAssistData)

function AssistData4:init()
	self.selectIndex1 = 1
end

function AssistData4:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData4:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local leftFreeTimes = SolicitWealthModel.instance:getDailyFreeTimes()

			if leftFreeTimes > 0 then
				local function callback()
					printInfo("test 请求 招财诺")

					local times = 1

					MoneyCatAgent.instance:sendMakeMoneyReq(times)
				end

				for i = 1, leftFreeTimes do
					table.insert(sendMo.callbackList, callback)
				end
			end
		end

		return sendMo
	end
end

return AssistData4
