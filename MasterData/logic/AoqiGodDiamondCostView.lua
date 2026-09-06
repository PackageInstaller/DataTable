-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodDiamondCostView.lua

module("logic.extensions.aoqigod.view.AoqiGodDiamondCostView", package.seeall)

local AoqiGodDiamondCostView = class("AoqiGodDiamondCostView", ViewComponent)

function AoqiGodDiamondCostView:ctor()
	AoqiGodDiamondCostView.super.ctor(self)
end

function AoqiGodDiamondCostView:unbindEvents()
	AoqiGodDiamondCostView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMinus)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnMax)
end

function AoqiGodDiamondCostView:bindEvents()
	AoqiGodDiamondCostView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAddBtn, self)
	GameUtil.addClickHandler(self._btnMinus, self._onClickSubtractBtn, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickMax, self)
	self._sliderAdapter:AddOnValueChanged(self._setSliderValue, self)
end

function AoqiGodDiamondCostView:buildUI()
	AoqiGodDiamondCostView.super.buildUI(self)

	self._numSlider = self:getGo("numSlider")
	self._sliderAdapter = Framework.SliderAdapter.Get(self._numSlider)
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnMinus = self:getGo("btnMinus")
	self._btnAdd = self:getGo("btnAdd")
	self._diamondCon = self:getGo("diamondCon")
	self._charmCon = self:getGo("charmCon")
	self._txtNum = self:getTxt("txtNum")
	self._btnMax = self:getGo("btnMax")
	self._txtTotal = self:getTxt("txtTotal")
end

function AoqiGodDiamondCostView:onExit()
	AoqiGodDiamondCostView.super.onExit(self)
end

function AoqiGodDiamondCostView:onEnter()
	AoqiGodDiamondCostView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._costDiamond = checknumber(params[2])
	self._additionCharm = checknumber(params[3])
	self._activityCfg = AoqiGodConfig.instance:getActData(self._activityId)

	self:_initSlider()
end

function AoqiGodDiamondCostView:_initSlider()
	self._max = self._activityCfg.diamondBuyCharmLimit

	local charmCanAdd = self._activityCfg.charmLimit - self._additionCharm

	self._max = math.min(self._max, math.floor(charmCanAdd / self._activityCfg.diamondBuyCharm))

	local curDiamondNum = MaterialModel.instance:getMaterialsNumber(MatType.Diamond_Consume, 1)

	self._max = math.min(self._max, curDiamondNum)
	self._max = math.max(self._max, 1)
	self._sliderAdapter.slider.minValue = 1
	self._sliderAdapter.slider.maxValue = self._max

	if self._costDiamond == 0 then
		self._costDiamond = 1
	end

	self._sliderAdapter:SetValue(self._costDiamond)
	self:_refreshView()
end

function AoqiGodDiamondCostView:_refreshView()
	local activityCfg = AoqiGodConfig.instance:getActData(self._activityId)
	local charmCount = activityCfg.diamondBuyCharm * self._costDiamond
	local proxy1 = MaterialMgr.setCellByCfg(activityCfg.charmFakeItem, self._charmCon)

	if proxy1 then
		proxy1.binder:setNum(charmCount)
	end

	local proxy2 = MaterialMgr.setCell(MatType.Diamond_Consume, 1, self._diamondCon)

	if proxy2 then
		proxy2.binder:setNum(self._costDiamond)
	end

	self._txtNum.text = langPara("购买次数：%s/%s", self._costDiamond, self._max)

	local totalCharm = self._additionCharm + charmCount

	self._txtTotal.text = langPara("总魅力值：%s/%s", totalCharm, self._activityCfg.charmLimit)
end

function AoqiGodDiamondCostView:_onClickAddBtn()
	if self._costDiamond + 1 <= self._max then
		self._sliderAdapter:SetValue(self._costDiamond + 1)
	end
end

function AoqiGodDiamondCostView:_onClickSubtractBtn()
	if self._costDiamond - 1 >= 0 then
		self._sliderAdapter:SetValue(self._costDiamond - 1)
	end
end

function AoqiGodDiamondCostView:_onClickSure()
	local charmCanAdd = self._activityCfg.charmLimit - self._additionCharm
	local max = math.floor(charmCanAdd / self._activityCfg.diamondBuyCharm)

	if max < self._costDiamond then
		FloatWordMgr.instance:show(lang("已达附加魅力值上限"))

		return
	end

	if not MaterialModel.instance:IsEnough(MatType.Diamond, 1, self._costDiamond) then
		FloatWordMgr.instance:show(lang("钻石不足"))

		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.AoqiGodBuyCharmChange, self._costDiamond)
	self:close()
end

function AoqiGodDiamondCostView:_onClickMax()
	self._sliderAdapter:SetValue(self._max)
end

function AoqiGodDiamondCostView:_setSliderValue(value)
	self._costDiamond = value

	self:_refreshView()
end

return AoqiGodDiamondCostView
