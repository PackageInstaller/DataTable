-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData11.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData11", package.seeall)

local AssistData11 = class("AssistData11", BaseAssistData)

AssistData11.None = 0
AssistData11.RefreshAndDispatch = 1
AssistData11.Dispatch = 2

function AssistData11:init()
	self.keySelect = "keySelect"
	self.keySelectTimes = "keyCount"
	self.keySelectTypeIds = "keySelectTypeIds"

	local selectState = self:getCellDataToNumber(self.keySelect)
	local selectTimes = self:getCellDataToNumber(self.keySelectTimes)

	self._assistCellData.selectState = selectState
	self._assistCellData.txtrefreTimeStr = selectTimes > 0 and selectTimes or 1
	self._assistCellData.cacheTodayTaskRefreshTimes = AssignmentModel.instance:getRefreshTimes(1)

	local selectTypeIds = GameUtil.jsonToTable(self:getCellData(self.keySelectTypeIds)) or {}
	local typeDatas = AssignmentController.instance:getTaskPrizeTypeDatas()
	local newSelectTypeIds = {}
	local count = #selectTypeIds

	if count == 0 then
		for i, v in ipairs(typeDatas) do
			if v.prizeTypeName == "潜能药水" then
				table.insert(newSelectTypeIds, v.prizeType)
			end
		end

		self:setCellData(self.keySelectTypeIds, GameUtil.jsonToString(newSelectTypeIds))

		self._assistCellData.selectTypeIds = newSelectTypeIds
	else
		self._assistCellData.selectTypeIds = selectTypeIds
	end
end

function AssistData11:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData11:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()
		local selectState = self._assistCellData.selectState
		local txtrefreTimeStr = self._assistCellData.txtrefreTimeStr
		local cacheTodayTaskRefreshTimes = self._assistCellData.cacheTodayTaskRefreshTimes
		local selectTypeIds = self._assistCellData.selectTypeIds

		if selectState == 1 then
			local function callback()
				local ids = AssignmentController.instance:getCanGainTaskIds()

				if #ids > 0 then
					AssignmentController.instance:onekeyGainPrize(function()
						local list = AssignmentModel.instance:getAssignment()
						local isRefresh = false

						for _, task in ipairs(list) do
							if task.status == 1 then
								isRefresh = true

								break
							end
						end

						if not isRefresh then
							FloatWordMgr.instance:show("今天没任务可刷新了，请明天再试")
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local times = checknumber(txtrefreTimeStr)
						local useTime = AssignmentModel.instance:getRefreshTimes(1)
						local costCfgs = AssignmentConfig.instance:getPetDispatchRefreshConfig(1)

						if useTime >= #costCfgs then
							FloatWordMgr.instance:show("已达到今天刷新上限，请明天再试")
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local costCfg = costCfgs[useTime + times]

						if not costCfg then
							FloatWordMgr.instance:show("可刷新次数不足")
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, times, cacheTodayTaskRefreshTimes)
						local hasNum = MaterialMgr.getMatCount(costCfg.consume)

						if hasNum < cost then
							FloatWordMgr.instance:show("钻石不足")
							GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

							return
						end

						local typeIds = {}

						for k, v in pairs(selectTypeIds) do
							table.insert(typeIds, v)
						end

						PetDispatchAgent.instance:sendRefreshTaskReq(typeIds, checknumber(txtrefreTimeStr), function()
							self:_onekeyDispatch(sendMo, true)
						end)
					end)
				else
					local list = AssignmentModel.instance:getAssignment()
					local isRefresh = false

					for _, task in ipairs(list) do
						if task.status == 1 then
							isRefresh = true

							break
						end
					end

					if not isRefresh then
						FloatWordMgr.instance:show("今天没任务可刷新了，请明天再试")
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local times = checknumber(txtrefreTimeStr)
					local useTime = AssignmentModel.instance:getRefreshTimes(1)
					local costCfgs = AssignmentConfig.instance:getPetDispatchRefreshConfig(1)

					if useTime >= #costCfgs then
						FloatWordMgr.instance:show("已达到今天刷新上限，请明天再试")
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local costCfg = costCfgs[useTime + times]

					if not costCfg then
						FloatWordMgr.instance:show("可刷新次数不足")
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local cost = AssignmentConfig.instance:getPetDispatchRefreshTotalCost(1, times, cacheTodayTaskRefreshTimes)
					local hasNum = MaterialMgr.getMatCount(costCfg.consume)

					if hasNum < cost then
						FloatWordMgr.instance:show("钻石不足")
						GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)

						return
					end

					local typeIds = {}

					for k, v in pairs(selectTypeIds) do
						table.insert(typeIds, v)
					end

					PetDispatchAgent.instance:sendRefreshTaskReq(typeIds, checknumber(txtrefreTimeStr), function()
						self:_onekeyDispatch(sendMo, true)
					end)
				end
			end

			table.insert(sendMo.callbackList, callback)
		elseif selectState == 2 then
			local function callback()
				local ids = AssignmentController.instance:getCanGainTaskIds()

				if #ids > 0 then
					AssignmentController.instance:onekeyGainPrize(function()
						self:_onekeyDispatch(sendMo)
					end)
				else
					self:_onekeyDispatch(sendMo)
				end
			end

			table.insert(sendMo.callbackList, callback)
		end

		return sendMo
	end
end

function AssistData11:_onekeyDispatch(sendMo, isRefresh)
	local viewDatas = AssignmentController.instance:getOnekeyDispatchInfos()
	local sendNos = {}

	printInfo("test AssistData11:_onekeyDispatch", #viewDatas)

	if #viewDatas > 0 then
		for i, v in ipairs(viewDatas) do
			local sendNo = {
				taskId = v.taskCfg.taskId,
				petIds = v.petIds
			}

			table.insert(sendNos, sendNo)
		end

		sendMo:setEmptyShowText((isRefresh or nil) and (XiaoNuoTextEnum.RefreshAndDispatch or XiaoNuoTextEnum.Dispatch))
		AssignmentController.instance:sendDispatchPetsReq(sendNos)
	else
		sendMo:setEmptyShowText(XiaoNuoTextEnum.Default)
		FloatWordMgr.instance:show("无可派遣精灵")
		GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantSendNextReq)
	end
end

return AssistData11
