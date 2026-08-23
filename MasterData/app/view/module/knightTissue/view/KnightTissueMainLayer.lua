local KnightTissueMainLayer = class("KnightTissueMainLayer", require("app.fairyGUI.knightTissue.UI_KnightTissueMainLayer"), function()
	return fgui.GComponent:create({
		resName = "KnightTissueMainLayer",
		pkgPath = "ui/knightTissue/knightTissue",
		isFullScreen = true,
		pkgName = "knightTissue"
	}, ...)
end)
local KsMath = require("app.core.utils.KsMath")
local var_0_2 = g.core.model.User.knightTissueData

function KnightTissueMainLayer:ctor()
	self._totalCollectNum = 0
	self._ownCollectNum = 0

	self:_initRegisterUI()
end

function KnightTissueMainLayer:_initRegisterUI()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_relationSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRelationSliderChanged))
	self.m_worldViewArea:addClickListener(handler(self, self._onClickKnightTissueWorldViewBtn))
end

function KnightTissueMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_UPLV, self._onRecTissueActive, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_ACTIVE, self._onRecTissueActive, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_TISSUE_INFO, self._updateMainView, self)
	var_0_2:invalidateCollectCache()
	g.core.network.GameNetProxy:send_C2S_KnightTissue_Info({})
end

function KnightTissueMainLayer:_updateMainView()
	self.m_topBarComp:setResInfoById(72)

	self._totalCollectNum = var_0_2:getKnightCollectionAllCount()
	self._ownCollectNum = var_0_2:getOwnCollectCount()

	self.m_curNumTxt:setText(self._ownCollectNum)
	self.m_allCountTxt:setText(g.core.lang:get(111903, {
		num = self._totalCollectNum
	}))
	self.m_relationNetComp:updateSubComp()
	self.m_enterTransition:play(handler(self, self._onEnterTransitionEnd))
end

function KnightTissueMainLayer:_onEnterTransitionEnd()
	self:_onRelationSliderChanged()
	self.m_relationNetComp:startDeferredCreate()
end

function KnightTissueMainLayer:_onTouchBegin(arg_7_1)
	arg_7_1:captureTouch()
end

function KnightTissueMainLayer:_onTouchMove(arg_8_1)
	local var_8_0 = arg_8_1:getInput():getTouch():getDelta()
	local var_8_1 = self.m_relationNetComp:getPosition()

	if self._offYRange and self._offXRange then
		self.m_relationNetComp:setPosition(KsMath.rangeIn(var_8_1.x + var_8_0.x, display.width - self._offXRange, self._offXRange), (KsMath.rangeIn(var_8_1.y - var_8_0.y, display.height - self._offYRange, self._offYRange)))
	end
end

function KnightTissueMainLayer:_onRelationSliderChanged()
	local var_9_0 = 0.5 + math.floor(self.m_relationSlider:getValue()) / 100

	self.m_relationNetComp:setScale(var_9_0)

	self._offXRange = display.width * var_9_0
	self._offYRange = display.height * var_9_0

	local var_9_1 = self.m_relationNetComp:getPosition()

	self.m_relationNetComp:setPosition(KsMath.rangeIn(var_9_1.x, display.width - self._offXRange, self._offXRange), (KsMath.rangeIn(var_9_1.y, display.height - self._offYRange, self._offYRange)))
end

function KnightTissueMainLayer:_onClickKnightTissueWorldViewBtn()
	self:addPopup(require("app.view.module.knightTissue.view.tissuePop.KnightTissueWorldViewPop").new())
end

function KnightTissueMainLayer:_onRecTissueActive(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 and arg_11_3.id then
		self.m_relationNetComp:updateOneById(arg_11_3 and arg_11_3.id)
	else
		self.m_relationNetComp:updateSubComp()
	end
end

return KnightTissueMainLayer
