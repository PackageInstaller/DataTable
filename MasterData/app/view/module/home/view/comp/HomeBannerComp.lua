local HomeConst = require("app.view.module.home.const.HomeConst")
local HomeBannerComp = class("HomeBannerComp", require("app.fairyGUI.home.UI_HomeBannerComp"))

function HomeBannerComp:ctor()
	self._bannerNum = 0
	self._bannerList = {}
	self._schedulerHandler = nil
	self._startPosX = nil

	self:_initListView()
end

function HomeBannerComp:onLoad()
	self:updateData()
end

function HomeBannerComp:onUnload()
	self:removeSchedule()
end

function HomeBannerComp:addSchedule()
	if self._bannerNum > 1 then
		self._schedulerHandler = self._schedulerHandler or g.core.common.Scheduler:newSchedule(handler(self, self._onSchedule), 5)
	else
		self:removeSchedule()
	end
end

function HomeBannerComp:removeSchedule()
	if self._schedulerHandler then
		g.core.common.Scheduler:cancelSchedule(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function HomeBannerComp:_onSchedule()
	self.m_bannerBtnList:scrollToView((self.m_selectIndexController:getSelectedIndex() + 1) % self._bannerNum, true)
end

function HomeBannerComp:updateData()
	self._bannerList = g.core.model.User.homeData:getBannerList()
	self._bannerNum = #self._bannerList

	for iter_7_0 = self.m_selectIndexController:getPageCount() + 1, self._bannerNum do
		self.m_selectIndexController:addPage(iter_7_0, "tab_" .. iter_7_0)
	end

	self.m_bannerBtnList:setNumItems(self._bannerNum)
	self.m_bannerDotList:setNumItems(self._bannerNum)
	self.m_showDotController:setSelectedIndex((self._bannerNum > 1 or nil) and (HomeConst.CTRL_BANNER_DOT_SHOW or HomeConst.CTRL_BANNER_DOT_HIDE))
	self:addSchedule()
end

function HomeBannerComp:_initListView()
	self.m_bannerBtnList:setIniter()
	self.m_bannerBtnList:setItemRenderer(handler(self, self._onRenderBannerList))
	self.m_bannerBtnList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickBanner))
	self.m_bannerBtnList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_bannerBtnList:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
end

function HomeBannerComp:_onRenderBannerList(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._bannerList[arg_9_1 + 1])
end

function HomeBannerComp:_onClickBanner(arg_10_1)
	local var_10_0 = g.core.config.banner_info.get(self._bannerList[arg_10_1:getDataValue() + 1].id)

	if not (var_10_0.activity_type == 0 or var_10_0.activity_value == 0) and not g.core.model.User.homeData:isBannerActivityOpen(var_10_0, var_10_0.func_id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(100530))
		self:dispatchCompEvent("EVENT_HOME_BANNER_UPDATE")

		return
	end

	if g.core.const.ConstMgr.FUNCTION_TYPE.SDK_H5_BANNER == var_10_0.func_id then
		g.core.platform.PlatformProxy:jumpToH5Banner()

		return
	end

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.config.source_route_info.get(var_10_0.route_id).function_id) then
		return
	end

	local var_10_1 = g.view.entrance.ModuleGotoProxy
	local var_10_2, var_10_3 = g.view.entrance.ModuleGotoProxy:getModule(var_10_0.route_id)

	if not g.core.module.ModuleManager:isCurModule(var_10_2) then
		var_10_1:gotoModule(var_10_0.route_id)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1143))
	end
end

function HomeBannerComp:_onTouchBegin(arg_11_1)
	if self._bannerNum <= 0 then
		return
	end

	arg_11_1:captureTouch()

	self._startPosX = arg_11_1:getInput():getTouch():getLocationInView().x
end

function HomeBannerComp:_onTouchMove(arg_12_1)
	if self._startPosX and self._bannerNum > 0 then
		local var_12_0 = arg_12_1:getInput()

		if math.abs(var_12_0 - self._startPosX) > 20 then
			local var_12_1 = self.m_selectIndexController:getSelectedIndex() + (var_12_0:getTouch():getLocationInView().x > self._startPosX and -1 or 1)

			if var_12_1 < 0 then
				var_12_1 = self._bannerNum - 1
			end

			self.m_bannerBtnList:scrollToView(var_12_1 % self._bannerNum, true)

			self._startPosX = nil
		end
	end
end

return HomeBannerComp
