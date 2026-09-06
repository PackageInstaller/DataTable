-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData23.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData23", package.seeall)

local AssistData23 = class("AssistData23", BaseAssistData)

function AssistData23:init()
	self.selectIndex1 = 1
end

function AssistData23:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData23:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(1) then
			local isCanGet = false
			local buildingInfo = CutePetModel.instance:getAdvAllBuildingInfo()

			for i, v in ipairs(buildingInfo or {}) do
				if checknumber(v.stashNum) > 0 then
					isCanGet = true

					break
				end
			end

			if isCanGet then
				local function callback()
					CutePetGardenAgent.instance:sendPM_GainAllBuildingOutputResReq()
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		sendMo.emptyShowText = lang("无可领取的奖励")

		return sendMo
	end
end

return AssistData23
