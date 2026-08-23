local StormAllOverlordLayer = class("StormAllOverlordLayer", require("app.fairyGUI.storm.UI_StormAllOverlordLayer"), function()
	return fgui.GComponent:create({
		resName = "StormAllOverlordLayer",
		pkgPath = "ui/storm/storm",
		isFullScreen = true,
		pkgName = "storm"
	}, ...)
end)

function StormAllOverlordLayer:ctor()
	self._historys = nil
	self._curPage = 1
	self._maxPage = 0
	self._newPage = 0

	self.m_leftBtn:addClickListener(handler(self, self._onLeftClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightClick))
	self.m_leftOutTransition:setHook("switch", handler(self, self._onSwitchPage))
	self.m_rightOutTransition:setHook("switch", handler(self, self._onSwitchPage))
	self.m_rightBtn:setAlpha(0.4)
	self.m_leftBtn:setAlpha(0.4)
end

function StormAllOverlordLayer:onLoad()
	self.m_enterTransition:play(handler(self, function()
		self:checkBtnShowState()
	end))

	self._historys = g.core.model.User.stormCityData:getLordHistorys()
	self._curPage = #self._historys
	self._maxPage = #self._historys

	table.sort(self._historys, function(arg_5_0, arg_5_1)
		return arg_5_0.time < arg_5_1.time
	end)
	self:updatePage()
	self:checkBtnShowState()
end

function StormAllOverlordLayer:_onLeftClick()
	if self._newPage > 0 then
		return
	end

	local var_6_0 = self._curPage - 1

	if self._curPage - 1 < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(304621))

		return
	else
		self._newPage = var_6_0

		self.m_rightOutTransition:play(handler(self, self._onPlayFinish))
	end
end

function StormAllOverlordLayer:_onRightClick()
	if self._newPage > 0 then
		return
	end

	local var_7_0 = self._curPage + 1

	if self._curPage + 1 > self._maxPage then
		g.core.module.ModuleManager:tip(g.core.lang:get(304622))

		return
	else
		self._newPage = var_7_0

		self.m_leftOutTransition:play(handler(self, self._onPlayFinish))
	end
end

function StormAllOverlordLayer:checkBtnShowState()
	self.m_rightBtn:setAlpha(1)
	self.m_leftBtn:setAlpha(1)
	self.m_rightBtn:setTouchable(true)
	self.m_leftBtn:setTouchable(true)

	if self._curPage == self._maxPage then
		self.m_rightBtn:setTouchable(false)
		self.m_rightBtn:setAlpha(0.4)
	end

	if self._curPage == 1 then
		self.m_leftBtn:setTouchable(false)
		self.m_leftBtn:setAlpha(0.4)
	end
end

function StormAllOverlordLayer:_onSwitchPage()
	if self._newPage > 0 then
		self:updatePage(self._newPage)
	end
end

function StormAllOverlordLayer:_onPlayFinish()
	self._newPage = 0

	self:checkBtnShowState()
end

function StormAllOverlordLayer:updatePage(arg_11_1)
	self._curPage = arg_11_1 or self._curPage

	if not self._historys[self._curPage] then
		return
	end

	self.m_timeTxt:setText(g.core.common.ServerTime:getDateYMDFormat(self._historys[self._curPage].time))
	self.m_roundTxt:setText(g.core.lang:get(304620, {
		num = self._historys[self._curPage].period
	}))

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._historys[self._curPage].users or {}) do
		if (iter_11_1.city or 0) > 0 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return g.core.config.storm_info.get(arg_12_0.city).order > g.core.config.storm_info.get(arg_12_1.city).order
	end)
	self.m_playerNumController:setSelectedIndex(#var_11_0)
	self.m_allUserComp:updateLord(var_11_0, #var_11_0)
end

return StormAllOverlordLayer
