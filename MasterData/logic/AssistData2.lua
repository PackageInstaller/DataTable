-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData2.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData2", package.seeall)

local AssistData2 = class("AssistData2", BaseAssistData)

function AssistData2:init()
	self.selectIndex1 = 1
end

function AssistData2:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData2:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		if self:getCellSelect(self.selectIndex1) then
			local stageId = EndlessBattleConfig.instance:getConstantValue("OPEN_SWEEP_STAGE_ID")
			local realMaxStage = EndlessBattleModel.instance:getMaxStageId()
			local isOpenSweep = realMaxStage >= checknumber(stageId)

			self._dailyState = EndlessBattleModel.instance:getDailyState()

			local isCanSweep = self._dailyState == 0

			if isOpenSweep and isCanSweep then
				local function callback()
					printInfo("test 请求无尽试炼 扫荡")
					EndlessBattleController.instance:sendSweepReq()
				end

				table.insert(sendMo.callbackList, callback)
			end
		end

		return sendMo
	end
end

return AssistData2
