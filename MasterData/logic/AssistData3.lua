-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData3.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData3", package.seeall)

local AssistData3 = class("AssistData3", BaseAssistData)

function AssistData3:init()
	self.selectIndex1 = 1
end

function AssistData3:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData3:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local hasGain = ThroneModel.instance:hasGainDailyPrize()

			if not hasGain then
				local function callback()
					printInfo("test 请求每日原液")
					ThroneAgent.instance:sendPM_GainThroneDailyPrizeReq()
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		return sendMo
	end
end

return AssistData3
