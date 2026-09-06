-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData6.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData6", package.seeall)

local AssistData6 = class("AssistData6", BaseAssistData)

function AssistData6:init()
	self.selectIndex1 = 1
end

function AssistData6:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData6:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local tiliInfo = SupplyModel.instance:getTiliCommonInfo()

			if tiliInfo ~= nil then
				local usedFreeTimes = checknumber(tiliInfo.useFreeCount)
				local maxFreeTimes = checknumber(VipModel.instance:getFreeGetTimesOfEnergy())
				local leftFreeTimes = Mathf.Max(0, maxFreeTimes - usedFreeTimes)

				if leftFreeTimes > 0 then
					local function callback()
						printInfo("test 请求 每日免费体力购买")
						SupplyController.instance:CSRequestBuyTili(1)
					end

					for i = 1, leftFreeTimes do
						table.insert(sendMo.callbackList, callback)
					end
				end
			end
		end

		return sendMo
	end
end

return AssistData6
