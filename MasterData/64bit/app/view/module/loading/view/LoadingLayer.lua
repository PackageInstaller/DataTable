local LoadingCommon = require("app.view.module.loading.common.LoadingCommon")
local LoadingLayer = class("LoadingLayer", require("app.fairyGUI.loading.UI_LoadingLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/loading/loading",
		resName = "LoadingLayer",
		pkgName = "loading",
		isFullScreen = true
	}, ...)
end)

function LoadingLayer.show()
	g.core.module.ModuleManager:pushFullComp(LoadingLayer.new())
end

function LoadingLayer:ctor()
	self._needWaitNet = true
	self._curNetPro = 0
	self._netProMax = 10
	self._curPro = 0
	self._maxPro = 100
	self._waitNetCnt = 0
	self._curLoadingInfo = nil
	self._loadingIndex = 0
	self._fileFinish = true
	self._schedule = nil
	self._proWidget = nil

	self:_initLayer()
end

function LoadingLayer:_initLayer()
	self.m_progress:setMax(self._maxPro)
	self.m_progress:setValue(0)
	self.m_blackBg:setPosition(display.width / 2, display.height)
	self:updateLayerInfo()
	self:onLoadingStart()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_LOADING_CHANGE, handler(self, self.onRecvWaitingChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RED_INFO_GET_FLUSH, handler(self, self.onRedPointFlush), self)
end

function LoadingLayer:updateLayerInfo()
	local var_5_0 = LoadingCommon.getLoadingBgList()
	local var_5_1 = math.random(#var_5_0)

	if not var_5_0[var_5_1] then
		return
	end

	self.m_bgTitle:setText(var_5_0[var_5_1].title or "")
	self.m_bgDesc:setText(var_5_0[var_5_1].desc or "")
	self.m_groupIcon:setURL(var_5_0[var_5_1].groupIcon)
	self.m_loaderBg:setURL(var_5_0[var_5_1].bgPic)
end

function LoadingLayer:getParallaxImages(arg_6_1)
	local var_6_0 = json.decodeFileIfExists(arg_6_1)
	local var_6_1 = {}

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs({
			var_6_0.bg,
			var_6_0.fg
		}) do
			for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
				if iter_6_3.img then
					table.insert(var_6_1, {
						file = iter_6_3.img,
						type = g.core.const.ConstMgr.UI_CONST.RES_TYPE.IMAGE
					})
				end
			end
		end
	end

	return var_6_1
end

function LoadingLayer:onLoadingStart()
	local var_7_0 = {}
	local var_7_1 = self:getLoadingRes()

	self._needWaitNet = var_7_1.waitNet or false

	for iter_7_0, iter_7_1 in ipairs(var_7_1.fileList) do
		if iter_7_1.type == g.core.const.ConstMgr.UI_CONST.RES_TYPE.PARALLAX then
			table.insertto(var_7_0, self:getParallaxImages(iter_7_1.file))
		else
			table.insert(var_7_0, iter_7_1)
		end
	end

	self._loadingList = var_7_0

	self:initWaitNet()
	self:scheduleUpdate(0.1)
end

function LoadingLayer:initWaitNet()
	if self._needWaitNet then
		self._waitNetCnt = g.core.module.ModuleManager:getLoadingCount()

		g.core.module.ModuleManager:hideLoadingByOp()
	end
end

function LoadingLayer:onRecvWaitingChange()
	if self._needWaitNet then
		local var_9_0 = g.core.module.ModuleManager:getLoadingCount()

		if var_9_0 > self._waitNetCnt then
			self._waitNetCnt = var_9_0
		end
	end
end

function LoadingLayer:onRedPointFlush()
	self._redPointFlushFinish = true

	self:onLoadingUpdate()
end

function LoadingLayer:onLoadingUpdate()
	local var_11_0 = self._loadingIndex

	if self._fileFinish == true or var_11_0 == 0 then
		var_11_0 = var_11_0 + 1
		self._loadingIndex = var_11_0

		if self._loadingList[var_11_0] then
			self:onLoadingFile(self._loadingList[var_11_0])
		end
	end

	self:updateNetPro()
	self:updateProgressShow()

	local var_11_1, var_11_2 = g.core.service.ServiceManager:getServiceByName("LoopService"):getLoopProgress()

	if self._fileFinish and var_11_0 >= #self._loadingList and (not self._needWaitNet or self._curNetPro >= self._waitNetCnt) and var_11_1 <= var_11_2 then
		self:onLoadingEnd()
	end
end

function LoadingLayer:updateNetPro()
	self._curNetPro = self._needWaitNet and self._waitNetCnt > 0 and self._waitNetCnt - g.core.module.ModuleManager:getLoadingCount() or self._waitNetCnt
end

function LoadingLayer:onLoadingEnd()
	g.core.resource.ResourceManager:initPreloadKnightCache()
	self:unscheduleUpdate()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GAME_LOGIN_LOADING, true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ON_PRE_LOADING_FINISH, true)
	g.core.module.ModuleManager:resetLoadingStatue()
end

function LoadingLayer:onScheduleUpdate()
	self:onLoadingUpdate()
end

function LoadingLayer:updateProgressShow()
	local var_15_0, var_15_1

	if #self._loadingList > 0 then
		var_15_0 = self._loadingIndex / #self._loadingList or 1

		if self._waitNetCnt > 0 then
			var_15_1 = self._curNetPro / self._waitNetCnt or 1
		end
	end

	local var_15_2, var_15_3 = g.core.service.ServiceManager:getServiceByName("LoopService"):getLoopProgress()

	if var_15_2 == 0 then
		var_15_3 = 1
		var_15_2 = 1
	end

	local var_15_4 = var_15_0 * 80 + var_15_1 * 10 + var_15_3 / var_15_2 * 10

	if var_15_0 * 80 + var_15_1 * 10 + var_15_3 / var_15_2 * 10 > self._curPro then
		self._curPro = var_15_4

		self.m_progress:setValue(math.min(math.floor(var_15_4), self._maxPro))
	end
end

function LoadingLayer:onLoadingFile(arg_16_1)
	self._fileFinish = false

	if arg_16_1.type == g.core.const.ConstMgr.UI_CONST.RES_TYPE.UI then
		fgui.UIPackage:addPackage(arg_16_1.file)

		self._fileFinish = true
	elseif arg_16_1.type == g.core.const.ConstMgr.UI_CONST.RES_TYPE.IMAGE then
		cc.Director:getInstance():getTextureCache():addImageAsync(arg_16_1.file, function()
			self._fileFinish = true
		end)
	end
end

function LoadingLayer:getLoadingRes()
	return {
		waitNet = true,
		fileList = {
			{
				file = "ui/home/home",
				type = g.core.const.ConstMgr.UI_CONST.RES_TYPE.UI
			},
			{
				file = g.core.common.Path:getModuleMapFileByTime("home"),
				type = g.core.const.ConstMgr.UI_CONST.RES_TYPE.PARALLAX
			}
		}
	}
end

return LoadingLayer
