require("view.Layer.Pops.PopBaseLayer")

PopAutoDownloadLayer = class("PopAutoDownloadLayer", function()
	return PopBaseLayer:create()
end)

local download_manager = require("controller.filedownloader.download_manager")

function PopAutoDownloadLayer.create(arg_2_0)
	local var_2_0 = PopAutoDownloadLayer.new()

	var_2_0:init()

	return var_2_0
end

function PopAutoDownloadLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AutoDownloadLayer.json" or "AutoDownloadLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 50))
	self.rootpanel:setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.rootpanel:getChildByName("btn_sure"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self:initUI()
	self:initScheduler()
end

function PopAutoDownloadLayer:initUI()
	local var_8_0 = self.rootpanel:getChildByName("barbg")

	self.bar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("AutoDownloadLayer/bar.png") or cc.Sprite:createWithSpriteFrameName("AutoDownloadLayer/bar.png")))

	self.bar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar:setBarChangeRate(cc.p(1, 0))
	self.bar:setMidpoint(cc.p(0, 0))
	self.bar:setAnchorPoint(cc.p(0.5, 0.5))
	self.bar:setPosition(cc.p(var_8_0:getContentSize().width / 2, var_8_0:getContentSize().height / 2))
	var_8_0:addChild(self.bar, 2)
	self.bar:setPercentage(0)

	self.downloadInfo = self.rootpanel:getChildByName("label_info")
	self.downloadPercent = self.rootpanel:getChildByName("label_percent")
end

function PopAutoDownloadLayer:initScheduler()
	self:scheduleUpdateWithPriorityLua(function(arg_10_0)
		self:updateDownload()
	end, 0)
end

local function var_0_2(arg_11_0)
	if arg_11_0 > 1073741824 then
		return string.format("%.1fG", arg_11_0 / 1073741824)
	elseif arg_11_0 > 1048576 then
		return string.format("%.1fM", arg_11_0 / 1048576)
	elseif arg_11_0 > 1024 then
		return string.format("%.1fK", arg_11_0 / 1024)
	else
		return tostring(arg_11_0)
	end
end

function PopAutoDownloadLayer:updateDownload()
	local var_12_0 = download_manager:getAutoDownloadTotalSize()
	local var_12_1 = download_manager:getAutoDownloadDownloadedSize()

	if var_12_0 <= var_12_1 then
		self.downloadInfo:setString(string.format("%s/%s", var_0_2(var_12_0), var_0_2(var_12_0)))
		self.downloadPercent:setString("100%")

		return
	end

	self.downloadInfo:setString(string.format("%s/%s", var_0_2(var_12_1), var_0_2(var_12_0)))

	local var_12_2 = math.floor(var_12_1 / var_12_0 * 100)

	self.downloadPercent:setString(string.format("%.1f%%", var_12_2))
	self.bar:setPercentage(var_12_2)
end
