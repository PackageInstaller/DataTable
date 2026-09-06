-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell21.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell21", package.seeall)

local AssistCell21 = class("AssistCell21", BaseAssistCell)

function AssistCell21:ctor(luaComponentContainer)
	AssistCell21.super.ctor(self, luaComponentContainer)

	self._txt6 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/coin/txt6", self._name))
	self._itemList = {}

	for i = 1, 4 do
		local item = {}

		item._go = goutil.findChild(self._parentGo, string.format("%s/item%d", self._name, i))
		item._lock = goutil.findChild(self._parentGo, string.format("%s/item%d/lock", self._name, i))
		item._lockTxt = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/lock/txt", self._name, i))
		item._txt4 = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/txt4", self._name, i))
		item._txtChapterName = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/dropdown1/Label", self._name, i))
		item._dropdown2 = DropDownAdapter.GetFrom(self._parentGo, string.format("%s/item%d/dropdown2", self._name, i))
		item._inputField1 = Framework.InputFieldAdapter.GetFrom(self._parentGo, string.format("%s/item%d/inputField1", self._name, i))
		item._Placeholder = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/inputField1/Placeholder", self._name, i))

		table.insert(self._itemList, item)
	end

	self._MaxSweepNum = checknumber(HolyStripeCopyConfig.instance:getCommonValue("GAME_TIME_STORAGE"))
end

function AssistCell21:reset()
	AssistCell21.super.reset(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:unregisterLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	for i, v in ipairs(self._itemList) do
		v._dropdown2:RemoveOnValueChanged()
		v._inputField1:RemoveOnEndEdit()
	end
end

function AssistCell21:init(data)
	AssistCell21.super.init(self, data)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:registerLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	for i, v in ipairs(self._itemList) do
		v._dropdown2:AddOnValueChanged(self["_onValueChanged" .. i], self)
		v._inputField1:AddOnEndEdit(self["_onEndEdit" .. i], self)
	end

	self._assistCellData = self._data:getAssistCellData()

	for i, v in ipairs(self._itemList) do
		v._dropdown2:ClearOptions()
		v._dropdown2:AddOptions("选择关卡")

		local chapterId = i
		local cfgChapter = HolyStripeCopyConfig.instance:getTabCfgByTabId(chapterId)
		local isOpen = GameUtil.checkTimeStr(cfgChapter.openTime)

		GameUtil.SetActive(v._lock, not isOpen)

		v._lockTxt.text = cfgChapter.openDesc
		v._txtChapterName.text = cfgChapter.name
		self._assistCellData.chapterInfo[chapterId].costPower = 0

		local stageCfgs = HolyStripeCopyConfig.instance:getStageCfgsByTabId(chapterId)

		for i, vCfg in ipairs(stageCfgs) do
			local isPass = HolyStripeCopyModel.instance:isLevelPassed(vCfg.tabId, vCfg.stageId)
			local str = not isPass and " <color=#FF0000><size=20>X</size></color>" or ""

			v._dropdown2:AddOptions(vCfg.name .. str)
		end

		local stageId = self._assistCellData.chapterInfo[chapterId].stageId

		if stageId > 0 then
			v._dropdown2:SetValue(stageId)
		else
			v._dropdown2:SetValue(0)
		end

		local selectNum = self._assistCellData.chapterInfo[chapterId].selectNum

		if stageId > 0 then
			local costPoswer = selectNum * self:_getUnitPower(chapterId, stageId)

			self:_updateCostText(selectNum, self._MaxSweepNum, costPoswer, chapterId)
		else
			self:_updateCostText(selectNum, self._MaxSweepNum, 0, chapterId)
		end
	end
end

function AssistCell21:_onClickAll()
	AssistCell21.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell21:_onStageChange(value, chapterId, keyInputNum)
	local chapterInfo = self._assistCellData.chapterInfo[chapterId]
	local oldStageId = chapterInfo.stageId

	if value > 0 then
		local stageCfgs = HolyStripeCopyConfig.instance:getStageCfgsByTabId(chapterId)
		local cfgStage = stageCfgs[value]

		if cfgStage then
			::label_5_0::

			local isPass = HolyStripeCopyModel.instance:isLevelPassed(chapterId, cfgStage.stageId)

			if isPass then
				chapterInfo.stageId = cfgStage.stageId

				self._data:setCellData(keyInputNum, cfgStage.stageId)

				local costPoswer = chapterInfo.selectNum * self:_getUnitPower(chapterId, cfgStage.stageId)

				self:_updateCostText(chapterInfo.selectNum, self._MaxSweepNum, costPoswer, chapterId)
			else
				chapterInfo.stageId = 0

				self._data:setCellData(keyInputNum, 0)
				self:_updateCostText(chapterInfo.selectNum, self._MaxSweepNum, 0, chapterId)
				self._itemList[chapterId]._dropdown2:SetValue(0)
				FloatWordMgr.instance:show(((cfgStage or nil) and (cfgStage.name or "")) .. " 挑战未通关")
			end
		end
	else
		chapterInfo.stageId = 0

		self._data:setCellData(keyInputNum, 0)
		self:_updateCostText(chapterInfo.selectNum, self._MaxSweepNum, 0, chapterId)
		self._itemList[chapterId]._dropdown2:SetValue(0)
	end

	if oldStageId ~= chapterInfo.stageId then
		self:_dispatchRefreshCostShow()
	end
end

function AssistCell21:_onValueChanged1(value)
	self:_onStageChange(value, 1, self._data.keyInputNum1_2)
end

function AssistCell21:_onValueChanged2(value)
	self:_onStageChange(value, 2, self._data.keyInputNum2_2)
end

function AssistCell21:_onValueChanged3(value)
	self:_onStageChange(value, 3, self._data.keyInputNum3_2)
end

function AssistCell21:_onValueChanged4(value)
	self:_onStageChange(value, 4, self._data.keyInputNum4_2)
end

function AssistCell21:_onSelectNumChange(inputStr, chapterId, keyInputNum)
	local num = checknumber(inputStr)
	local chapterInfo = self._assistCellData.chapterInfo[chapterId]
	local oldNum = chapterInfo.selectNum

	if string.nilorempty(inputStr) then
		num = oldNum
	end

	num = num >= 0 and num or 0

	if chapterInfo.stageId > 0 then
		local curSelectNum = Mathf.Min(self._MaxSweepNum, num)

		chapterInfo.selectNum = curSelectNum

		self._data:setCellData(keyInputNum, curSelectNum)

		local costPoswer = curSelectNum * self:_getUnitPower(chapterId, chapterInfo.stageId)

		self:_updateCostText(curSelectNum, self._MaxSweepNum, costPoswer, chapterId)

		if num > self._MaxSweepNum then
			FloatWordMgr.instance:show(string.format("最多选择%d次", self._MaxSweepNum))
		end
	else
		chapterInfo.selectNum = num

		self._data:setCellData(keyInputNum, num)
		self:_updateCostText(num, self._MaxSweepNum, 0, chapterId)
	end

	if oldNum ~= chapterInfo.selectNum then
		self:_dispatchRefreshCostShow()
	end
end

function AssistCell21:_onEndEdit1(inputStr)
	self:_onSelectNumChange(inputStr, 1, self._data.keyInputNum1_1)
end

function AssistCell21:_onEndEdit2(inputStr)
	self:_onSelectNumChange(inputStr, 2, self._data.keyInputNum2_1)
end

function AssistCell21:_onEndEdit3(inputStr)
	self:_onSelectNumChange(inputStr, 3, self._data.keyInputNum3_1)
end

function AssistCell21:_onEndEdit4(inputStr)
	self:_onSelectNumChange(inputStr, 4, self._data.keyInputNum4_1)
end

function AssistCell21:_getUnitPower(chapterId, stageId)
	local cfgStage = HolyStripeCopyConfig.instance:getStageCfg(chapterId, stageId)

	return cfgStage.strengthCost
end

function AssistCell21:_getAllChapterCostPower()
	local costPower = 0

	for i, chapterInfo in ipairs(self._assistCellData.chapterInfo) do
		costPower = costPower + chapterInfo.costPower
	end

	return costPower
end

function AssistCell21:_updateCostText(curNum, maxNum, costPower, chapterId)
	local chapterInfo = self._assistCellData.chapterInfo[chapterId]

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
		end
	end
end

function AssistCell21:_refreshCostShow(tabId)
	if self._data:getTabIndex() == tabId then
		for chapterId, chapterInfo in ipairs(self._assistCellData.chapterInfo) do
			local selectNum = chapterInfo.selectNum
			local stageId = chapterInfo.stageId

			if stageId > 0 then
				local costPoswer = selectNum * self:_getUnitPower(chapterId, stageId)

				self:_updateCostText(selectNum, self._MaxSweepNum, costPoswer, chapterId)
			else
				self:_updateCostText(selectNum, self._MaxSweepNum, 0, chapterId)
			end
		end
	end
end

function AssistCell21:_onHideDropdown()
	for i, v in ipairs(self._itemList) do
		self:_hideDropdown(v._dropdown2.dropdown)
	end
end

return AssistCell21
