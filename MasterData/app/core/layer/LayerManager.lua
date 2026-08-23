local LayerManager = class("LayerManager")
local var_0_1 = cc.Director:getInstance()
local LayerType = import(".LayerType")

function LayerManager:ctor()
	self._scene = display.newScene("scene", {
		physics = true
	})

	var_0_1:replaceScene(self._scene)
	self._scene:getPhysicsWorld():setGravity(cc.vertex2F(0, -600))
	self:setPhysicsWorldAutoStep(false)

	self._keypadLayer = display.newLayer()

	self._keypadLayer:onKeypad(handler(self, self._onKeypadClicked))
	self._scene:addChild(self._keypadLayer)

	self._cocosNode = display.newNode()

	self._scene:addChild(self._cocosNode, 500)

	self._groot = fgui.GRoot:create(self._scene)

	self._groot:retain()
	self._groot:addEventListener(fgui.UIEventType.ClickPreview, handler(self, self._onClickPreview))
	self:_initLayer()

	if not device.isWindows() and config.SHOW_DEBUG_BTN then
		self:addDebugBtn()
	end
end

function LayerManager:addDebugBtn()
	local var_2_0 = cc.Director:getInstance()
	local var_2_1 = fgui.UIPackage:createObject("base_new", "BaseDebugBtn")

	var_2_1.setPosition(var_2_0, var_2_0:getSafeAreaRect().x, 0)
	var_2_1:setSortingOrder(100)
	var_2_1:addClickListener(function()
		local var_3_0 = g.core.module.ModuleManager:getCurModule()

		if var_3_0 and var_3_0.module ~= g.view.entrance.DEBUG and not g.core.battle.BattleProxy:isInBattle() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.DEBUG)
		end

		var_2_1:setOpacity(0)
	end)
	self._groot:addChild(var_2_1)
end

function LayerManager:_initLayer()
	self._moduleLayer = fgui.GComponent:create()

	self._moduleLayer:setName("module")
	self._groot:addChild(self._moduleLayer)

	self._fightUILayer = fgui.GComponent:create()

	self._fightUILayer:setName("fightui")
	self._groot:addChild(self._fightUILayer)

	self._pauseLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._pauseLayer:setSize(display.width * 2, display.height * 2)
	self._pauseLayer:setPosition(-display.width / 2, -display.height / 2)
	self._groot:addChild(self._pauseLayer)

	self._popupLayer = fgui.GComponent:create()

	self._popupLayer:setName("popup")
	self._groot:addChild(self._popupLayer)

	self._topLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._topLayer:setOpaque(true)
	self._topLayer:setTouchable(false)
	self._topLayer:setName("top")
	self._groot:addChild(self._topLayer)

	self._transitionLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._transitionLayer:setName("transition")

	self._exitTransitionComp = fgui.UIPackage:createObject("base_new", "BaseCommonBackComp")

	self._exitTransitionComp:setPosition(display.cx, display.cy)
	self._exitTransitionComp:setTouchable(false)
	self._transitionLayer:addChild(self._exitTransitionComp)

	self._enterTransitionComp = fgui.UIPackage:createObject("base_new", "BaseEnterTransComp")

	self._enterTransitionComp:setPosition(display.cx, display.cy)
	self._enterTransitionComp:setSize(display.width, display.height)
	self._transitionLayer:addChild(self._enterTransitionComp)
	self._groot:addChild(self._transitionLayer)

	self._battleChatLayer = fgui.GComponent:create()

	self._battleChatLayer:setName("battleChatLayer")
	self._groot:addChild(self._battleChatLayer)

	self._floatLayer = require("app.view.module.float.view.FloatLayerComponent").new()

	self._battleChatLayer:addChild(self._floatLayer)

	self._guideLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._guideLayer:setSize(display.width * 2, display.height * 2)
	self._guideLayer:setPosition(-display.width / 2, -display.height / 2)
	self._groot:addChild(self._guideLayer)

	self._guideTopLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._guideTopLayer:setSize(display.width * 2, display.height * 2)
	self._guideTopLayer:setPosition(-display.width / 2, -display.height / 2)
	self._groot:addChild(self._guideTopLayer)

	self._packageDownLoadLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._packageDownLoadLayer:setSize(display.width * 2, display.height * 2)
	self._packageDownLoadLayer:setPosition(-display.width / 2, -display.height / 2)
	self._groot:addChild(self._packageDownLoadLayer)

	self._sysTipLayer = fgui.GComponent:create()

	self._groot:addChild(self._sysTipLayer)

	self._moduleLoadingLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._groot:addChild(self._moduleLoadingLayer)

	self._loadingLayer = fgui.GComponent:create({
		isFullScreen = true
	})

	self._loadingLayer:setOpaque(true)
	self._loadingLayer:setVisible(false)
	self._groot:addChild(self._loadingLayer)

	self._tipLayer = fgui.GComponent:create()

	self._groot:addChild(self._tipLayer)

	local var_4_0 = fgui.GComponent:create()

	self._groot:addChild(var_4_0)

	self._markLayer = var_4_0

	self:_initBlackLayer()
end

function LayerManager:_initBlackLayer()
	self._blackLayer = fgui.UIPackage:createObject("base", "BaseBlurContainer")

	self._blackLayer:setSize(display.width, display.height)
	self._blackLayer:setPivot(0.5, 0.5, true)
	self._blackLayer:setTouchable(true)
	self._blackLayer:setVisible(false)
	self._blackLayer:setPosition(display.width / 2, display.height / 2)
	self._popupLayer:addChild(self._blackLayer)
end

function LayerManager:_onKeypadClicked(arg_6_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_KEY_PAD, false, nil, arg_6_1)
end

function LayerManager:_onClickPreview()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_DISPLAY_CLICK_PREVIEW, false, ...)
end

function LayerManager:addChildToLayer(arg_8_1, arg_8_2)
	if arg_8_2 == LayerType.MODULE_LAYER then
		self._moduleLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.POPUP_LAYER then
		self._popupLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.TOP_LAYER then
		self._topLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.GUIDE_LAYER then
		self._guideLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.SYSTEM_TIP_LAYER then
		self._sysTipLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.MODULE_LOADING_LAYER then
		self._moduleLoadingLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.LOADING_LAYER then
		self._loadingLayer:addChild(arg_8_1)
	elseif arg_8_2 == LayerType.TIP_LAYER then
		self._tipLayer:addChild(arg_8_1)
	else
		self._moduleLayer:addChild(arg_8_1)
	end
end

function LayerManager:getRunningScene()
	return self._scene
end

function LayerManager:getKeypadLayer()
	return self._keypadLayer
end

function LayerManager:getCocosNode()
	return self._cocosNode
end

function LayerManager:getRoot()
	return self._groot
end

function LayerManager:getModuleLayer()
	return self._moduleLayer
end

function LayerManager:getFightUILayer()
	return self._fightUILayer
end

function LayerManager:getBattleChatLayer()
	return self._battleChatLayer
end

function LayerManager:getFloatLayer()
	return self._floatLayer
end

function LayerManager:getPopupLayer()
	return self._popupLayer
end

function LayerManager:getTopLayer()
	return self._topLayer
end

function LayerManager:getGuideLayer()
	return self._guideLayer
end

function LayerManager:getPauseLayer()
	return self._pauseLayer
end

function LayerManager:getGuideTopLayer()
	return self._guideTopLayer
end

function LayerManager:getSysTipLayer()
	return self._sysTipLayer
end

function LayerManager:getModuleLoadingLayer()
	return self._moduleLoadingLayer
end

function LayerManager:getLoadingLayer()
	return self._loadingLayer
end

function LayerManager:getTipLayer()
	return self._tipLayer
end

function LayerManager:setIosDownObj(arg_26_1)
	self:clearIosDownObj()
	self._tipLayer:addChild(arg_26_1)
	arg_26_1:setPosition(display.width - cc.Director:getInstance():getSafeAreaRect().x * 2, display.height)

	self._iosSilentProgObj = arg_26_1
end

function LayerManager:getIosDownObj()
	return self._iosSilentProgObj
end

function LayerManager:clearIosDownObj()
	if self._iosSilentProgObj and not tolua.isnull(self._iosSilentProgObj) then
		self._iosSilentProgObj:removeSelf()

		self._iosSilentProgObj = nil
	end
end

function LayerManager:getBlackLayer()
	return self._blackLayer
end

function LayerManager:getTranslationLayer()
	return self._transitionLayer
end

function LayerManager:getLayerByType(arg_31_1)
	if arg_31_1 == LayerType.MODULE_LAYER then
		return self._moduleLayer
	elseif arg_31_1 == LayerType.POPUP_LAYER then
		return self._popupLayer
	elseif arg_31_1 == LayerType.TOP_LAYER then
		return self._topLayer
	elseif arg_31_1 == LayerType.GUIDE_LAYER then
		return self._guideLayer
	elseif arg_31_1 == LayerType.SYSTEM_TIP_LAYER then
		return self._sysTipLayer
	elseif arg_31_1 == LayerType.MODULE_LOADING_LAYER then
		return self._moduleLoadingLayer
	elseif arg_31_1 == LayerType.LOADING_LAYER then
		return self._loadingLayer
	elseif arg_31_1 == LayerType.TIP_LAYER then
		return self._tipLayer
	end
end

function LayerManager:setPhysicsWorldAutoStep(arg_32_1)
	arg_32_1 = arg_32_1 or false

	self._scene:getPhysicsWorld():setAutoStep(arg_32_1)
end

function LayerManager:addPackageDownloadPop(arg_33_1)
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_33_0 = fgui.UIPackage:createObject("infoPop", "DownloadingPop")

	var_33_0:setPosition(display.width, display.height)
	var_33_0:setName("DownloadingPop")
	self._packageDownLoadLayer:addChild(var_33_0)

	return var_33_0
end

function LayerManager:setDownloadingPopVisible(arg_34_1)
	local var_34_0 = self._packageDownLoadLayer:getChild("DownloadingPop")
	local var_34_1

	if var_34_0 == nil then
		var_34_0 = self:addPackageDownloadPop()
	else
		var_34_1 = var_34_0:isVisible()
	end

	if arg_34_1 == var_34_1 then
		return
	end

	var_34_0:setVisible(arg_34_1)

	if arg_34_1 then
		var_34_0:playShow()
	else
		var_34_0:playHide()
	end
end

function LayerManager:addMark()
	if self._mark then
		return
	end

	fgui.UIPackage:addPackage("ui/mask/mask")

	local var_35_0 = fgui.UIPackage:createObject("mask", "MaskComp")

	var_35_0:setSize(display.width * 2, display.height * 2)
	var_35_0:setPivot(0.5, 0.5, true)
	var_35_0:setPosition(display.width, display.height)
	var_35_0:setTouchable(false)

	self._mark = var_35_0

	self._markLayer:addChild(var_35_0)
end

return LayerManager
