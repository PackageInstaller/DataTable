-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell12.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell12", package.seeall)

local AssistCell12 = class("AssistCell12", BaseAssistCell)

function AssistCell12:ctor(luaComponentContainer)
	AssistCell12.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._txt6 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/coin/txt6", self._name))
	self._txt8 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/coin/txt8", self._name))
	self._itemList = {}

	for i = 1, 4 do
		local item = {}

		item._txt4 = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/txt4", self._name, i))
		item._txtChapterName = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/dropdown1/Label", self._name, i))
		item._dropdown2 = DropDownAdapter.GetFrom(self._parentGo, string.format("%s/item%d/dropdown2", self._name, i))
		item._inputField1 = Framework.InputFieldAdapter.GetFrom(self._parentGo, string.format("%s/item%d/inputField1", self._name, i))
		item._Placeholder = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/inputField1/Placeholder", self._name, i))

		table.insert(self._itemList, item)
	end
end

function AssistCell12:reset()
	AssistCell12.super.reset(self)
	self._btn1:RemoveClickListener()

	for i, v in ipairs(self._itemList) do
		v._dropdown2:RemoveOnValueChanged()
		v._inputField1:RemoveOnEndEdit()
	end

	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:unregisterLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)
end

function AssistCell12:init(data)
	AssistCell12.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)

	for i, v in ipairs(self._itemList) do
		v._dropdown2:AddOnValueChanged(self["_onValueChanged" .. i], self)
		v._inputField1:AddOnEndEdit(self["_onEndEdit" .. i], self)
	end

	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:registerLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	self._assistCellData = self._data:getAssistCellData()

	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))

	for i, v in ipairs(self._itemList) do
		v._dropdown2:ClearOptions()
		v._dropdown2:AddOptions("选择关卡")

		local chapterId = i
		local cfgChapter = MaterialChallengeConfig.instance:getChapter(chapterId)

		v._txtChapterName.text = cfgChapter.chapterName
		self._assistCellData.chapterInfo[chapterId].costPower = 0

		local stageCfgs = MaterialChallengeConfig.instance:getStages(chapterId)

		for i, vCfg in ipairs(stageCfgs) do
			local isPass = MaterialChallengeModel.instance:isStagePassed(vCfg.chapterId, vCfg.stageId)
			local str = not isPass and " <color=#FF0000><size=20>X</size></color>" or ""

			v._dropdown2:AddOptions(vCfg.stageName .. str)
		end

		local stageId = self._assistCellData.chapterInfo[chapterId].stageId

		if stageId > 0 then
			v._dropdown2:SetValue(stageId)
		else
			v._dropdown2:SetValue(0)
		end

		local selectNum = self._assistCellData.chapterInfo[chapterId].selectNum

		if stageId > 0 then
			local leftCount, unitPower, powerNum, maxCount, ticketLeftCount, realMaxNum = self:_getLeftCount(chapterId, stageId)
			local ticketPartNum = 0
			local powerPartNum = 0

			if selectNum <= ticketLeftCount then
				ticketPartNum = selectNum
				powerPartNum = 0
			else
				ticketPartNum = ticketLeftCount
				powerPartNum = (selectNum - ticketLeftCount) * unitPower
			end

			self:_updateCostText(selectNum, AssistData12.MaxSweepNum, powerPartNum, ticketPartNum, chapterId, stageId)
		else
			self:_updateCostText(selectNum, AssistData12.MaxSweepNum, 0, 0, chapterId)
		end
	end
end

function AssistCell12:_onClickAll()
	AssistCell12.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell12:_onStageChange(value, chapterId, keyInputNum)
	local chapterInfo = self._assistCellData.chapterInfo[chapterId]
	local oldStageId = chapterInfo.stageId

	if value > 0 then
		local stageCfgs = MaterialChallengeConfig.instance:getStages(chapterId)
		local cfgStage = stageCfgs[value]

		if cfgStage then
			::label_5_0::

			local isPass = MaterialChallengeModel.instance:isStagePassed(chapterId, cfgStage.stageId)

			if isPass then
				local leftCount, unitPower, powerNum, maxCount, ticketLeftCount, realMaxNum = self:_getLeftCount(chapterId, cfgStage.stageId)

				chapterInfo.stageId = cfgStage.stageId

				self._data:setCellData(keyInputNum, cfgStage.stageId)

				local ticketPartNum = 0
				local powerPartNum = 0

				if ticketLeftCount >= chapterInfo.selectNum then
					ticketPartNum = chapterInfo.selectNum
					powerPartNum = 0
				else
					ticketPartNum = ticketLeftCount
					powerPartNum = (chapterInfo.selectNum - ticketLeftCount) * unitPower
				end

				self:_updateCostText(chapterInfo.selectNum, AssistData12.MaxSweepNum, powerPartNum, ticketPartNum, chapterId, cfgStage.stageId)
			else
				chapterInfo.stageId = 0

				self._data:setCellData(keyInputNum, 0)
				self:_updateCostText(chapterInfo.selectNum, AssistData12.MaxSweepNum, 0, 0, chapterId, 0)
				self._itemList[chapterId]._dropdown2:SetValue(0)
				FloatWordMgr.instance:show(((cfgStage or nil) and (cfgStage.stageName or "")) .. " 挑战未通关")
			end
		end
	else
		chapterInfo.stageId = 0

		self._data:setCellData(keyInputNum, 0)
		self:_updateCostText(chapterInfo.selectNum, AssistData12.MaxSweepNum, 0, 0, chapterId, 0)
		self._itemList[chapterId]._dropdown2:SetValue(0)
	end

	if oldStageId ~= chapterInfo.stageId then
		self:_dispatchRefreshCostShow()
	end
end

function AssistCell12:_onValueChanged1(value)
	self:_onStageChange(value, 1, self._data.keyInputNum1_2)
end

function AssistCell12:_onValueChanged2(value)
	self:_onStageChange(value, 2, self._data.keyInputNum2_2)
end

function AssistCell12:_onValueChanged3(value)
	self:_onStageChange(value, 3, self._data.keyInputNum3_2)
end

function AssistCell12:_onValueChanged4(value)
	self:_onStageChange(value, 4, self._data.keyInputNum4_2)
end

function AssistCell12:_onSelectNumChange(inputStr, chapterId, keyInputNum)
	local chapterInfo = self._assistCellData.chapterInfo[chapterId]
	local oldNum = chapterInfo.selectNum
	local num = checknumber(inputStr)

	if string.nilorempty(inputStr) then
		num = oldNum
	end

	num = num >= 0 and num or 0

	if chapterInfo.stageId > 0 then
		local leftCount, unitPower, powerNum, maxCount, ticketLeftCount, realMaxNum = self:_getLeftCount(chapterId, chapterInfo.stageId)
		local curSelectNum = Mathf.Min(AssistData12.MaxSweepNum, num)

		chapterInfo.selectNum = curSelectNum

		self._data:setCellData(keyInputNum, curSelectNum)

		local ticketPartNum = 0
		local powerPartNum = 0

		if curSelectNum <= ticketLeftCount then
			ticketPartNum = curSelectNum
			powerPartNum = 0
		else
			ticketPartNum = ticketLeftCount
			powerPartNum = (curSelectNum - ticketLeftCount) * unitPower
		end

		self:_updateCostText(curSelectNum, AssistData12.MaxSweepNum, powerPartNum, ticketPartNum, chapterId, chapterInfo.stageId)

		if num > AssistData12.MaxSweepNum then
			FloatWordMgr.instance:show(string.format("最多选择%d次", AssistData12.MaxSweepNum))
		end
	else
		chapterInfo.selectNum = num

		self._data:setCellData(keyInputNum, num)
		self:_updateCostText(num, AssistData12.MaxSweepNum, 0, 0, chapterId, 0)
	end

	if oldNum ~= chapterInfo.selectNum then
		self:_dispatchRefreshCostShow()
	end
end

function AssistCell12:_onEndEdit1(inputStr)
	self:_onSelectNumChange(inputStr, 1, self._data.keyInputNum1_1)
end

function AssistCell12:_onEndEdit2(inputStr)
	self:_onSelectNumChange(inputStr, 2, self._data.keyInputNum2_1)
end

function AssistCell12:_onEndEdit3(inputStr)
	self:_onSelectNumChange(inputStr, 3, self._data.keyInputNum3_1)
end

function AssistCell12:_onEndEdit4(inputStr)
	self:_onSelectNumChange(inputStr, 4, self._data.keyInputNum4_1)
end

function AssistCell12:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)

	self._assistCellData.isUseTicket = not isOn

	self:_setBtnIsOn1(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
	self:_onEndEdit1(self._assistCellData.chapterInfo[1].selectNum)
	self:_onEndEdit2(self._assistCellData.chapterInfo[2].selectNum)
	self:_onEndEdit3(self._assistCellData.chapterInfo[3].selectNum)
	self:_onEndEdit4(self._assistCellData.chapterInfo[4].selectNum)
end

function AssistCell12:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

function AssistCell12:_getLeftCount(chapterId, stageId)
	local cfgStage = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)
	local unitPower = cfgStage.power
	local curPowerNum = MaterialMgr.getMatCount(GameEnum.GoldType.Tili)
	local powerNum = Mathf.Floor(curPowerNum / unitPower + 0.001)
	local curCount, maxCount = MaterialChallengeModel.instance:getCostLimitCount(chapterId)

	maxCount = math.min(maxCount, AssistData12.MaxSweepNum)

	local leftCount = maxCount - curCount
	local ticketLeftCount = 0

	if self._assistCellData.isUseTicket then
		local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)
		local totalTicketNum = MaterialMgr.getMatCount(cfgStage.ticket)

		ticketLeftCount = Mathf.Max(0, Mathf.Floor(totalTicketNum / ticketNum))
	end

	local realMaxNum = Mathf.Min(powerNum + ticketLeftCount, leftCount)

	return leftCount, unitPower, powerNum, maxCount, ticketLeftCount, realMaxNum
end

function AssistCell12:_getAllChapterCostPower()
	local costPower = 0

	for i, chapterInfo in ipairs(self._assistCellData.chapterInfo) do
		costPower = costPower + chapterInfo.costPower
	end

	return costPower
end

function AssistCell12:_getAllTicketTxt()
	local str = ""

	for chapterId, chapterInfo in ipairs(self._assistCellData.chapterInfo) do
		local cfgStage = MaterialChallengeConfig.instance:getStageById(chapterId, chapterInfo.stageId)

		if cfgStage and chapterInfo.costTicketNum > 0 then
			local matType, id, ticketNum = MaterialMgr.getMatParams(cfgStage.ticket)

			str = str .. string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x %d", matType .. ":" .. id, chapterInfo.costTicketNum * ticketNum)
			str = str .. " "
		end
	end

	return str
end

function AssistCell12:_updateCostText(curNum, maxNum, costPower, costTicket, chapterId, stageId)
	local chapterInfo = self._assistCellData.chapterInfo[chapterId]

	chapterInfo.costTicketNum = costTicket
	chapterInfo.costPower = costPower

	local item = self._itemList[chapterId]

	item._inputField1.input.text = ""
	item._Placeholder.text = curNum
	item._txt4.text = string.format("/ %d", maxNum)

	local curTotalPower = MaterialMgr.getMatCount(GameEnum.GoldType.Tili)
	local allChapterCostPower = self:_getAllChapterCostPower()

	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), GameEnum.GoldType.Tili, allChapterCostPower)

	local costTotalPower = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), GameEnum.GoldType.Tili)

	if costTotalPower <= curTotalPower then
		if not XiaoNuoAssistantModel.CostColor then
			local coinColorStr = ColorConst.Red

			self._txt6.text = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", GameEnum.GoldType.Tili, coinColorStr, allChapterCostPower)

			self:_fixTxtShow(self._txt6)

			if self._txt8 then
				self._txt8.text = self:_getAllTicketTxt()

				self:_fixTxtShow(self._txt8)
			end
		end
	end
end

function AssistCell12:_refreshCostShow(tabId)
	if self._data:getTabIndex() == tabId then
		for chapterId, chapterInfo in ipairs(self._assistCellData.chapterInfo) do
			local selectNum = chapterInfo.selectNum
			local stageId = chapterInfo.stageId

			if stageId > 0 then
				local leftCount, unitPower, powerNum, maxCount, ticketLeftCount, realMaxNum = self:_getLeftCount(chapterId, stageId)
				local ticketPartNum = 0
				local powerPartNum = 0

				if selectNum <= ticketLeftCount then
					ticketPartNum = selectNum
					powerPartNum = 0
				else
					ticketPartNum = ticketLeftCount
					powerPartNum = (selectNum - ticketLeftCount) * unitPower
				end

				self:_updateCostText(selectNum, AssistData12.MaxSweepNum, powerPartNum, ticketPartNum, chapterId, stageId)
			else
				self:_updateCostText(selectNum, AssistData12.MaxSweepNum, 0, 0, chapterId)
			end
		end
	end
end

function AssistCell12:_onHideDropdown()
	for i, v in ipairs(self._itemList) do
		self:_hideDropdown(v._dropdown2.dropdown)
	end
end

return AssistCell12
