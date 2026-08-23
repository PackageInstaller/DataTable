local var_0_0 = g.core.const.ConstMgr.SuperSdkConst
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.const.ConstMgr.AnnoConst.TipCtrlIdxConst
local var_0_3 = g.core.model.User.annoData
local var_0_4 = g.core.network.GameHttpProxy
local AnnoWebViewLayer = require("app.view.module.announcement.view.AnnoWebViewLayer")
local AnnoMainPop = class("AnnoMainPop", require("app.fairyGUI.announcement.UI_AnnoMainPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/announcement/announcement",
		resName = "AnnoMainPop",
		pkgName = "announcement",
		isFullScreen = true
	})
end)

function AnnoMainPop:ctor()
	local var_2_0 = AnnoWebViewLayer.new()

	self.m_comp:addChild(var_2_0)
	var_2_0:setPosition(cc.p(0, self.m_comp:getHeight()))

	self._annoWebViewLayer = var_2_0

	self:showAtCenter()
	self.m_todayNotShowCheckBtn:addClickListener(handler(self, self._onClickTodayNotShowCheckBtn))
	self.m_bgLoader:addClickListener(handler(self, self._onReturnClick))
	self.m_returnBtn:addClickListener(handler(self, self._onReturnClick))
	self.m_annoList:setVirtual(self)
	self.m_annoList:setItemRenderer(handler(self, self._onTabRenderer))
	self.m_annoList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClicked))
end

function AnnoMainPop:onLoad()
	g.core.event.EventManager:addEventListener(var_0_1.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	g.core.event.EventManager:dispatchEvent(var_0_1.EVENT_SUPERSDK_STATS, false, {
		event_id = var_0_0.SHOW_NOTICE_LAYER_COMP
	})
	self.m_todayNotShowCheckBtn:setSelected((var_0_3:isSelectedTodayNotShow()))

	local var_3_0 = #var_0_3:getWebInfoArr()

	if var_3_0 == 0 then
		self.m_tipController:setSelectedIndex(var_0_2.NO_ANNO)
	else
		self:_setSelected(1)
		self.m_annoList:setNumItems(var_3_0)
		self.m_annoList:transitionShowCells("enter_left", 0.03)
		self.m_annoList:setSelectedIndex(0)
		g.core.event.EventManager:dispatchEvent(var_0_1.EVENT_SUPERSDK_STATS, false, {
			event_id = var_0_0.SHOW_NOTICE_LAYER
		})
	end

	self.m_enterTransition:play()
	self._annoWebViewLayer:setWebViewVisible(true)

	if device.isWindows() then
		self:getChild("n20"):setVisible(false)
	end
end

function AnnoMainPop:onUnload()
	var_0_3:setShowedAnnoToday()
	var_0_3:saveJsonFile()
	var_0_4:removeHttpResponse(self)
end

function AnnoMainPop:_onModuleEnter()
	if g.core.module.ModuleManager:getCurPopModuleCnt() > 1 then
		g.core.module.ModuleManager:popByDisplay(self)
	end
end

function AnnoMainPop:_onTabRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(arg_6_1 + 1)
end

function AnnoMainPop:_onTabClicked(arg_7_1)
	self:_setSelected(arg_7_1:getDataValue() + 1)
	self.m_annoList:setNumItems(#var_0_3:getWebInfoArr())
end

function AnnoMainPop:_onClickTodayNotShowCheckBtn()
	var_0_3:setSelectedTodayNotShow((self.m_todayNotShowCheckBtn:isSelected()))
end

function AnnoMainPop:_onReturnClick()
	if device.isWindows() then
		self:_close()
	else
		self.m_backTransition:play(handler(self, function()
			self:_close()
		end))
	end
end

function AnnoMainPop:_close()
	self._annoWebViewLayer:setWebViewVisible(false)
	g.core.module.ModuleManager:popComponent()
end

function AnnoMainPop:_setSelected(arg_12_1)
	local var_12_0 = var_0_3:getWebInfo(arg_12_1)

	var_0_3:setRead(var_12_0.id)

	if not self._annoWebViewLayer:getContent(arg_12_1) then
		self._annoWebViewLayer:setContent(arg_12_1, (self:_createWebView(arg_12_1, var_12_0.id, var_12_0.url)))
	end

	self._annoWebViewLayer:switchTo(arg_12_1)
	self.m_tipController:setSelectedIndex((var_0_3:getWebState(arg_12_1)))
end

function AnnoMainPop:_doRefreshTip(arg_13_1)
	if self._annoWebViewLayer:getCurViewIndex() == arg_13_1 then
		self.m_tipController:setSelectedIndex((var_0_3:getWebState(arg_13_1)))
	end
end

function AnnoMainPop:_createWebView(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self.m_comp:getSize()
	local var_14_1 = ccexp.WebView:create()

	var_14_1:setContentSize(var_14_0)
	var_14_1:setPosition(var_14_0.width / 2, var_14_0.height / 2)

	if not device.isWindows() then
		var_14_1:draw()
	end

	local var_14_2 = var_0_3:getWebHtmlFileFullPath(arg_14_2, arg_14_3)

	if cc.FileUtils:getInstance():isFileExist(var_14_2) then
		var_14_1:loadHTMLString(io.readfile(var_14_2), "")
	else
		var_14_1:loadURL(arg_14_3, true)
		self:_saveAnnoHtmlFile(var_14_2, arg_14_3)
	end

	var_14_1:setBounces(false)
	var_14_1:setOpacityWebView(1)
	var_14_1:setBackgroundTransparent()
	var_14_1:setOnShouldStartLoading(function(arg_15_0, arg_15_1)
		return true
	end)
	var_14_1:setOnDidFinishLoading(function(arg_16_0, arg_16_1)
		var_0_3:setWebState(arg_14_1, var_0_2.BLANK)
		self:_doRefreshTip(arg_14_1)
	end)
	var_14_1:setOnDidFailLoading(function(arg_17_0, arg_17_1)
		var_0_3:setWebState(arg_14_1, var_0_2.FAILED)
		self:_doRefreshTip(arg_14_1)
	end)

	return var_14_1
end

function AnnoMainPop:_saveAnnoHtmlFile(arg_18_1, arg_18_2)
	var_0_4:sendHttpRequest(arg_18_2, "GET", {
		success = function(arg_19_0)
			io.writefile(arg_18_1, arg_19_0, "w+b")
		end,
		fail = function()
			return
		end,
		cancel = function()
			return
		end
	}, self)
end

return AnnoMainPop
