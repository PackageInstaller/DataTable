require("controller.filedownloader.download_node_utils"):addDownloadInterface(SwitchManageLayer)

local file_check_manager = require("controller.filedownloader.file_check_manager")
local download_manager = require("controller.filedownloader.download_manager")

function SwitchManageLayer:checkResource(arg_1_1, arg_1_2, arg_1_3, ...)
	if config._DEBUG then
		if arg_1_3 == "UILAYER" then
			self:doSwitchLayer(arg_1_1, ...)
		elseif arg_1_3 == "POPLAYER" then
			self:doPushInLayer(arg_1_1, ...)
		end

		return
	end

	if arg_1_3 == "UILAYER" and self._initialcomplete then
		download_manager:onSceneTransaction()
	end

	if type(arg_1_2) == "function" then
		arg_1_2 = arg_1_2(...)
	end

	local var_1_0 = {
		...
	}

	self._switchinglayerinfo = {
		layerName = arg_1_1,
		layertype = arg_1_3,
		params = var_1_0
	}

	local var_1_1, var_1_2 = file_check_manager:checkFileNeedDownloadByList(self:generateLayerTextureList(arg_1_2))

	if var_1_1 then
		self:onDownloadProcessing()
		self:startDownload(var_1_2)
	elseif arg_1_3 == "UILAYER" then
		self:doSwitchLayer(arg_1_1, unpack(var_1_0))
	elseif arg_1_3 == "POPLAYER" then
		self:doPushInLayer(arg_1_1, unpack(var_1_0))
	end
end

function SwitchManageLayer.generateLayerTextureList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if not arg_2_1 then
		return var_2_0
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1:find(".png") then
			table.insert(var_2_0, iter_2_1)
		else
			table.insert(var_2_0, "ui/" .. iter_2_1 .. ".plist")
			table.insert(var_2_0, "ui/" .. iter_2_1 .. ".png")
		end
	end

	return var_2_0
end

function SwitchManageLayer:onDownloadComplete()
	self:hideDownloadAni()

	if self._switchinglayerinfo.layertype == "UILAYER" then
		self:doSwitchLayer(self._switchinglayerinfo.layerName, unpack(self._switchinglayerinfo.params))
	elseif self._switchinglayerinfo.layertype == "POPLAYER" then
		self:doPushInLayer(self._switchinglayerinfo.layerName, unpack(self._switchinglayerinfo.params))
	end
end

function SwitchManageLayer:onDownloadProcessing()
	self:showDownloadAni()
end

function SwitchManageLayer:showDownloadAni()
	if not self._loadingani then
		self:createDownloadAni()
	end

	self._loadingani:setVisible(true)
end

function SwitchManageLayer:hideDownloadAni()
	if self._loadingani then
		self._loadingani:setVisible(false)
	end
end

function SwitchManageLayer:createDownloadAni()
	self._loadingani = ccui.Layout:create()

	self._loadingani:setTouchEnabled(true)
	self._loadingani:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self._loadingani:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self._loadingani:setBackGroundColor(cc.c3b(0, 0, 0))
	self._loadingani:setBackGroundColorOpacity(110)
	self._loadingani:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self._loadingani, 6)

	local var_7_0 = require("controller.spinecache_manager"):addSpineData("spine/ui/zhandouloading.json", "spine/ui/zhandouloading.atlas")

	var_7_0:retain()

	local var_7_1 = sp.SkeletonAnimation:create(var_7_0:getData())

	var_7_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	var_7_1:setName("ani")
	var_7_1:setAnimation(0, "loading", true)
	self._loadingani:addChild(var_7_1)
end
