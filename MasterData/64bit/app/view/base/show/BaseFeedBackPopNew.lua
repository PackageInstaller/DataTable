local BaseFeedBackPop = class("BaseFeedBackPop", require("app.fairyGUI.base_new.UI_BaseFeedBackPop"), function()
	return fgui.GComponent:create({
		pkgName = "base_new",
		pkgPath = "ui/base_new/base_new",
		resName = "BaseFeedBackPop"
	})
end)

BaseFeedBackPop.GAP = 80

function BaseFeedBackPop:ctor(arg_2_1)
	self._canAuto = false

	self:showAtCenter()
	self.m_clickBg:setSize(display.width, display.height)

	self._popData = arg_2_1
	self._clickClose = false
	self.ignoreCtrlRemove = true

	self:updateBackView(self._popData)
	self.m_tipsBgImg:setSize(display.width, 440)

	self.m_enterTransition = self:getView():getTransition("enter")

	self.m_enterTransition:setHook("panel_Start", handler(self, self._onPanelStart))
	self.m_enterTransition:setHook("title_Start", handler(self, self._onTitleStart))
	self.m_enterTransition:setHook("reward_show", handler(self, self._onPnlPlayEnd))
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))
	self.m_huawenLoader:setURL("pic/base_new/bg_reward_huawen.png")
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
end

function BaseFeedBackPop:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function BaseFeedBackPop:onLoad()
	self.m_enterTransition:play(handler(self, self._onAnimEnterFinish))
end

function BaseFeedBackPop:_onPanelStart()
	self._panelEffect = require("app.view.common.SpineBase").new({
		anim = "play",
		resId = "",
		isLoop = false,
		path = g.core.common.Path:getEffSpine("eff_ui_awardsummary_panel")
	})

	self._panelEffect:setAnchorPoint(0.5, 0.5)
	self.m_eff_ui_awardsummary_panel:addNode(self._panelEffect)
end

function BaseFeedBackPop:_onTitleStart()
	self._titleEffect = require("app.view.common.SpineBase").new({
		anim = "play",
		resId = "",
		isLoop = false,
		path = g.core.common.Path:getEffSpine("eff_ui_awardsummary_title")
	})

	self._titleEffect:setAnchorPoint(0.5, 0.5)
	self.m_eff_ui_awardsummary_title:addNode(self._titleEffect)
end

function BaseFeedBackPop:_onPnlPlayEnd(arg_7_1)
	self.m_posComp:setVisible(true)

	if self._showComp.playAnimate then
		self._showComp:playAnimate()
	end
end

function BaseFeedBackPop:updateBackView(arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = self.m_posComp:getChild("baseShowComp")

	if var_8_0 then
		var_8_0:removeFromParent()
	end

	self:_setTitle(arg_8_1.title)

	if arg_8_1.autoDisappear then
		self:_autoDisappearPop()
	else
		self.m_clickBg:addClickListener(handler(self, self._onCloseClick))
	end

	local var_8_1 = arg_8_1.showComp

	if arg_8_1.showComp then
		release_print("BaseFeedBackPop updateBackView add comp------------------->" .. tostring(arg_8_1.title or ""))
		var_8_1:setName("baseShowComp")
		self.m_posComp:addChild(var_8_1)
		self:addListen(var_8_1)
		self.m_tipsBgImg:setHeight(var_8_1:getHeight() + BaseFeedBackPop.GAP)
		self.m_tipsBgImg:setWidth(display.width)

		self._info = arg_8_1
		self._showComp = var_8_1

		if self._showComp.update then
			self._showComp:update(self._info)
		end

		if var_8_1.setCloseFunc then
			var_8_1:setCloseFunc(handler(self, self._onCloseClick))
		end

		self.m_posComp:setVisible(false)
	end
end

function BaseFeedBackPop:_setTitle(arg_9_1)
	local var_9_0 = arg_9_1 or g.core.lang:get(300001)

	if string.len(var_9_0) > 0 then
		self.m_tips:setText(var_9_0)
	else
		self.m_tips:setVisible(false)
	end
end

function BaseFeedBackPop:_autoDisappearPop()
	self:runFGAction((fgui.FSequence:create(fgui.FDelayTime:create(1.5 + math.min(1, 10) * 0.05), fgui.FSpawn:create({
		fgui.FFadeOut:create(0.3),
		fgui.FMoveBy:create(0.5, cc.p(0, -80))
	}), fgui.FCallFunc:create(function()
		if g.core.model.User.bagData:getFlushFlag() then
			g.core.model.User.bagData:cleanFlushFlag()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ITEM_FLUSH)
		end

		self:_onCloseSelf()
	end))))
end

function BaseFeedBackPop:onCancelCallback()
	self:_onCloseClick()
end

function BaseFeedBackPop:_onCloseClick(arg_13_1)
	if arg_13_1 then
		arg_13_1:stopPropagation()
	end

	if self._clickClose then
		return
	end

	self._clickClose = true

	self:stopAllFGActions()

	local var_13_0 = self:getView():getTransition("close")

	if var_13_0 then
		var_13_0:play(function()
			self:_onCloseSelf()
		end)
	else
		self:_onCloseSelf()
	end
end

function BaseFeedBackPop:onUnload()
	local var_15_0

	if self._popData and self._popData.func then
		var_15_0 = self._popData.func
	end

	if var_15_0 then
		var_15_0()
	end
end

function BaseFeedBackPop:_onCloseSelf()
	local var_16_0

	if self._popData and self._popData.func then
		var_16_0 = self._popData.func
	end

	self._popData.func = nil

	self:removeChildren()
	self:setOpaque(false)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if var_16_0 then
		var_16_0()
	end

	local var_16_1 = g.core.model.User.bagData:getShowBoxId()

	if var_16_1 > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			quickUseBox = var_16_1
		})
	end
end

function BaseFeedBackPop:_onAnimEnterFinish()
	self._canAuto = true
end

function BaseFeedBackPop:doAutoAction()
	if self._canAuto then
		self:_onCloseSelf()
	end
end

return BaseFeedBackPop
