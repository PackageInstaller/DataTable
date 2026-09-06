-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData17.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData17", package.seeall)

local AssistData17 = class("AssistData17", BaseAssistData)

function AssistData17:init()
	self.selectIndex1 = 1
end

function AssistData17:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData17:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local curLv = VipModel.instance:getCurVipLv()
			local isGeted = VipModel.instance:getGainDailyBonusStateByLv(curLv)

			if not isGeted then
				local function callback()
					printInfo("test 请求VIP每日奖励")
					VipController.instance:sendGainVipDailyBonusReq(curLv)
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		return sendMo
	end
end

return AssistData17
