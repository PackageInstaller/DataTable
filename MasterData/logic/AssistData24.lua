-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData24.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData24", package.seeall)

local AssistData24 = class("AssistData24", BaseAssistData)

function AssistData24:init()
	self.selectIndex1 = 1
end

function AssistData24:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData24:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(1) and FamilyController.instance:checkFamilyOpen() == true then
			local list = FamilyHonorModel.instance:getAllFinishTaskId()

			if #list > 0 then
				local function callback()
					FamilyHonorController.instance:csRequestFamilyTaskGainPrizeReq(list)
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		sendMo.emptyShowText = lang("无可领取的奖励")

		return sendMo
	end
end

return AssistData24
