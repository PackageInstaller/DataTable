-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell22.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell22", package.seeall)

local AssistCell22 = class("AssistCell22", BaseAssistCell)

AssistCell22.Diamond = "105:2"
AssistCell22.Tick = "4:9001"

function AssistCell22:ctor(luaComponentContainer)
	AssistCell22.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._txtLabel1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
	self._txt4 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt4", self._name))
	self._dropdown1 = DropDownAdapter.GetFrom(self._parentGo, string.format("%s/dropdown1", self._name))
end

function AssistCell22:reset()
	AssistCell22.super.reset(self)
	self._btn1:RemoveClickListener()
	self._dropdown1:RemoveOnValueChanged()
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:unregisterLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)
end

function AssistCell22:init(data)
	AssistCell22.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._dropdown1:AddOnValueChanged(self._onValueChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:registerLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	self._assistCellData = self._data:getAssistCellData()

	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))

	local usedTotalTimes = BreakFormationModel.instance:getHasFirstPassTimes()
	local hasBuyTimes = BreakFormationModel.instance:getHasBuyFirstPassTimes()
	local freeTimes = VipModel.instance:getFreeGetTimesOfBreakFormation()
	local buyTimesLimit = BreakFormationConfig.instance:getBuyCfgLength()

	self._totalTimes = freeTimes + buyTimesLimit
	self._leftTotalTimes = self._totalTimes - usedTotalTimes

	self._dropdown1:ClearOptions()
	self._dropdown1:AddOptions(tostring(0))

	for i = 1, self._totalTimes do
		self._dropdown1:AddOptions(tostring(i))
	end

	self._dropdown1:SetValue(self._assistCellData.realRemainingTimes)

	local realSelectNum = Mathf.Min(self._assistCellData.realRemainingTimes, self._leftTotalTimes)
	local needDiamondNum = self:_getCoinInfo(realSelectNum)

	self:_updateCoins(needDiamondNum)
	self:_updateTicks(realSelectNum)
end

function AssistCell22:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self:_setBtnIsOn1(true)
end

function AssistCell22:_onClickAll()
	AssistCell22.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell22:_onValueChanged(value)
	local towerId = WTowerModel.instance:getTowerId()

	if value ~= 0 and not self._data:isCanQuickPass() then
		self._assistCellData.realRemainingTimes = 0

		self._dropdown1:SetValue(0)
		self:_updateCoins(0)
		self:_updateTicks(0)
		FloatWordMgr.instance:show("破阵天下已全通")
		self:_dispatchRefreshCostShow()

		return
	end

	self._assistCellData.realRemainingTimes = value

	self._data:setCellData(self._data.keyInputNum1, value)

	local realSelectNum = Mathf.Min(value, self._leftTotalTimes, self._data:getUnPassCount())
	local needDiamondNum = self:_getCoinInfo(realSelectNum)

	self:_updateCoins(needDiamondNum)
	self:_updateTicks(realSelectNum)
	self:_dispatchRefreshCostShow()
end

function AssistCell22:_updateCoins(costDiamondNum)
	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), AssistCell22.Diamond, costDiamondNum)

	local costTotalDimond = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), AssistCell22.Diamond)
	local curTotalDiamond = MaterialMgr.getMatCount(AssistCell22.Diamond)

	if costTotalDimond <= curTotalDiamond then
		if not XiaoNuoAssistantModel.CostColor then
			local coinColorStr = ColorConst.Red

			self._txt4.text = string.format("消耗：<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", AssistCell22.Diamond, coinColorStr, costDiamondNum)

			self:_fixTxtShow(self._txt4)
		end
	end
end

function AssistCell22:_updateTicks(realSelectNum)
	local costTotalTick = realSelectNum
	local curTotalTick = MaterialMgr.getMatCount(AssistCell22.Tick)

	if costTotalTick <= curTotalTick then
		if not XiaoNuoAssistantModel.CostColor then
			local tickColorStr = ColorConst.Red
			local tipsStr = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", AssistCell22.Tick, tickColorStr, costTotalTick)

			self._txt4.text = self._txt4.text .. tipsStr

			self:_fixTxtShow(self._txt4)
		end
	end
end

function AssistCell22:_getCoinInfo(selectTimes)
	return (self._data:_getCoinInfo(selectTimes))
end

function AssistCell22:_refreshCostShow(tabId)
	if self._data:getTabIndex() == tabId then
		local realSelectNum = Mathf.Min(self._assistCellData.realRemainingTimes, self._leftTotalTimes)
		local needDiamondNum = self:_getCoinInfo(realSelectNum)

		self:_updateCoins(needDiamondNum)
		self:_updateTicks(realSelectNum)
	end
end

function AssistCell22:_onHideDropdown()
	self:_hideDropdown(self._dropdown1.dropdown)
end

function AssistCell22:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
end

function AssistCell22:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

return AssistCell22
