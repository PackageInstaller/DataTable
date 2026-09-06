-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell13.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell13", package.seeall)

local AssistCell13 = class("AssistCell13", BaseAssistCell)

function AssistCell13:ctor(luaComponentContainer)
	AssistCell13.super.ctor(self, luaComponentContainer)

	self._txt3 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt3", self._name))
	self._txt5 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt5", self._name))
	self._dropdown1 = DropDownAdapter.GetFrom(self._parentGo, string.format("%s/dropdown1", self._name))
	self._inputField1 = Framework.InputFieldAdapter.GetFrom(self._parentGo, string.format("%s/inputField1", self._name))
	self._Placeholder = goutil.findChildTextComponent(self._parentGo, string.format("%s/inputField1/Placeholder", self._name))
end

function AssistCell13:reset()
	AssistCell13.super.reset(self)
	self._dropdown1:RemoveOnValueChanged()
	self._inputField1:RemoveOnEndEdit()
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:unregisterLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)
end

function AssistCell13:init(data)
	AssistCell13.super.init(self, data)
	self._dropdown1:AddOnValueChanged(self._onValueChanged1, self)
	self._inputField1:AddOnEndEdit(self._onEndEdit1, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:registerLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	self._assistCellData = self._data:getAssistCellData()

	self._dropdown1:ClearOptions()
	self._dropdown1:AddOptions("选择挑战")

	self._cfgPets = LegendConfig.instance:getLegendChallengeCfgs()

	for i, v in ipairs(self._cfgPets) do
		self._dropdown1:AddOptions(v.challengeName)
	end

	local maxCount = VipModel.instance:getFreeChallengeTimesOfPet()

	if self._assistCellData.challengeId > 0 and self._cfgPets[self._assistCellData.challengeId] then
		local cfg = self._cfgPets[self._assistCellData.challengeId]
		local isUnlock = LegendController.instance:isChallengeUnlock(cfg.unlockId)
		local isPass = LegendModel.instance:isChallengePass(cfg.challengeId)

		if isUnlock and isPass then
			local leftCount = LegendModel.instance:getLeftCountByChallengeId(cfg.challengeId)
			local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(cfg.challengeId)
			local stageId = cfgList[#cfgList].stageId
			local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(cfg.challengeId, stageId)
			local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
			local unitPower = cfgTeam.strengthConsumption
			local costPower = Mathf.Min(leftCount, self._assistCellData.selectNum) * unitPower

			self._dropdown1:SetValue(self._assistCellData.challengeId)
			self:_updateTxt(self._assistCellData.selectNum, leftCount, costPower)
		else
			self._dropdown1:SetValue(0)
			self:_updateTxt(self._assistCellData.selectNum, 0, 0)
		end
	else
		self._dropdown1:SetValue(0)
		self:_updateTxt(self._assistCellData.selectNum, 0, 0)
	end
end

function AssistCell13:_selectAll()
	return
end

function AssistCell13:_cancelAll()
	return
end

function AssistCell13:_onClickAll()
	AssistCell13.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell13:_onValueChanged1(value)
	printInfo("test AssistCell13:_onValueChanged1", value, type(value))

	if value > 0 and self._cfgPets[value] then
		local cfg = self._cfgPets[value]
		local isUnlock = LegendController.instance:isChallengeUnlock(cfg.unlockId)
		local isPass = LegendModel.instance:isChallengePass(cfg.challengeId)

		if isUnlock and isPass then
			local leftCount = LegendModel.instance:getLeftCountByChallengeId(cfg.challengeId)
			local maxCount = VipModel.instance:getFreeChallengeTimesOfPet()
			local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(cfg.challengeId)
			local stageId = cfgList[#cfgList].stageId
			local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(cfg.challengeId, stageId)
			local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
			local unitPower = cfgTeam.strengthConsumption
			local costPower = Mathf.Min(leftCount, self._assistCellData.selectNum) * unitPower

			self:_updateTxt(self._assistCellData.selectNum, leftCount, costPower)
		else
			self._dropdown1:SetValue(0)
			self:_updateTxt(self._assistCellData.selectNum, 0, 0)
			FloatWordMgr.instance:show(cfg.challengeName .. " 挑战未通关")
		end

		self._assistCellData.challengeId = cfg.challengeId

		self._data:setCellData(self._data.keyInputNum2, cfg.challengeId)
	else
		self._data:setCellData(self._data.keyInputNum2, 0)
		self._dropdown1:SetValue(0)
		self:_updateTxt(self._assistCellData.selectNum, 0, 0)
	end
end

function AssistCell13:_onEndEdit1(inputStr)
	local num = checknumber(inputStr)

	if string.nilorempty(inputStr) then
		num = self._assistCellData.selectNum
	end

	num = num >= 0 and num or 0

	local maxCount = VipModel.instance:getFreeChallengeTimesOfPet()
	local selectNum = Mathf.Min(num, maxCount)

	if self._assistCellData.challengeId > 0 then
		local cfg = self._cfgPets[self._assistCellData.challengeId]
		local leftCount = LegendModel.instance:getLeftCountByChallengeId(cfg.challengeId)
		local unitPower = self:_getUnitPower(cfg.challengeId)
		local costPower = Mathf.Min(leftCount, selectNum) * unitPower

		self:_updateTxt(selectNum, leftCount, costPower)

		self._assistCellData.selectNum = selectNum

		self._data:setCellData(self._data.keyInputNum1, selectNum)

		if maxCount < num then
			FloatWordMgr.instance:show(string.format("关卡最多选择%d次", maxCount))
		end
	else
		self:_updateTxt(self._assistCellData.selectNum, 0, 0)

		self._assistCellData.selectNum = 0

		self._data:setCellData(self._data.keyInputNum1, 0)
	end
end

function AssistCell13:_getUnitPower(challengeId)
	return self._data:getUnitPower(challengeId)
end

function AssistCell13:_updateTxt(curNum, maxNum, costPower)
	self._inputField1.input.text = ""
	self._Placeholder.text = curNum
	self._txt3.text = string.format("/ %d", maxNum)

	local curTotalPower = MaterialMgr.getMatCount(GameEnum.GoldType.Tili)

	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), GameEnum.GoldType.Tili, costPower)

	local costTotalPower = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), GameEnum.GoldType.Tili)

	if costTotalPower <= curTotalPower then
		if not XiaoNuoAssistantModel.CostColor then
			local coinColorStr = ColorConst.Red

			self._txt5.text = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", GameEnum.GoldType.Tili, coinColorStr, costPower)

			self:_fixTxtShow(self._txt5)
		end
	end
end

function AssistCell13:_refreshCostShow(tabId)
	if self._data:getTabIndex() == tabId then
		if self._assistCellData.challengeId > 0 and self._cfgPets[self._assistCellData.challengeId] then
			local cfg = self._cfgPets[self._assistCellData.challengeId]
			local isUnlock = LegendController.instance:isChallengeUnlock(cfg.unlockId)
			local isPass = LegendModel.instance:isChallengePass(cfg.challengeId)

			if isUnlock and isPass then
				local leftCount = LegendModel.instance:getLeftCountByChallengeId(cfg.challengeId)
				local cfgList = LegendConfig.instance:getLegendChallengeStageCfgList(cfg.challengeId)
				local stageId = cfgList[#cfgList].stageId
				local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(cfg.challengeId, stageId)
				local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
				local unitPower = cfgTeam.strengthConsumption
				local costPower = Mathf.Min(leftCount, self._assistCellData.selectNum) * unitPower

				self:_updateTxt(self._assistCellData.selectNum, leftCount, costPower)
			else
				self:_updateTxt(self._assistCellData.selectNum, 0, 0)
			end
		else
			self:_updateTxt(self._assistCellData.selectNum, 0, 0)
		end
	end
end

function AssistCell13:_onHideDropdown()
	self:_hideDropdown(self._dropdown1.dropdown)
end

return AssistCell13
