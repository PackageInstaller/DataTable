local var_0_0 = ccui.Button.create
local var_0_1 = ccui.Button.loadTextures
local var_0_2 = ccui.Button.loadTextureNormal
local var_0_3 = ccui.Button.loadTexturePressed
local var_0_4 = ccui.Button.loadTextureDisabled
local download_node_utils = require("controller.filedownloader.download_node_utils")
local file_check_manager = require("controller.filedownloader.file_check_manager")
local var_0_7 = "default/default.png"

local function var_0_8(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	var_0_1(arg_1_0, arg_1_1.normal, arg_1_1.pressed, arg_1_1.disabled)

	if arg_1_0.afterLoadSuccess then
		arg_1_0:afterLoadSuccess(arg_1_1)
	end
end

local function var_0_9(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	var_0_2(arg_2_0, arg_2_1)
end

local function var_0_10(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	var_0_3(arg_3_0, arg_3_1)
end

local function var_0_11(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	var_0_4(arg_4_0, arg_4_1)
end

local function var_0_12(arg_5_0, arg_5_1)
	arg_5_0._downloadnormaltexture = arg_5_1

	if not arg_5_1 then
		arg_5_0:onDownloadNormalComplete(arg_5_1)

		return
	end

	if file_check_manager:checkFileNeedDownload(arg_5_1) then
		arg_5_0:onDownloadNormalComplete(var_0_7)
		arg_5_0:onDownloadProcessing()

		local var_5_0 = {}

		table.insert(var_5_0, file_check_manager:getFileDownloadInfo(arg_5_1))
		arg_5_0:startDownloadSingle(var_5_0)
	else
		arg_5_0:onDownloadNormalComplete(arg_5_1)
	end
end

local function var_0_13(arg_6_0, arg_6_1)
	arg_6_0._downloadpressedtexture = arg_6_1

	if not arg_6_1 then
		arg_6_0:onDownloadPressedComplete(arg_6_1)

		return
	end

	if file_check_manager:checkFileNeedDownload(arg_6_1) then
		arg_6_0:onDownloadPressedComplete(var_0_7)

		local var_6_0 = {}

		table.insert(var_6_0, file_check_manager:getFileDownloadInfo(arg_6_1))
		arg_6_0:startDownloadSingle(var_6_0)
	else
		arg_6_0:onDownloadPressedComplete(arg_6_1)
	end
end

local function var_0_14(arg_7_0, arg_7_1)
	arg_7_0._downloaddisabledtexture = arg_7_1

	if not arg_7_1 then
		arg_7_0:onDownloadDisabledComplete(arg_7_1)

		return
	end

	if file_check_manager:checkFileNeedDownload(arg_7_1) then
		arg_7_0:onDownloadDisabledComplete(var_0_7)

		local var_7_0 = {}

		table.insert(var_7_0, file_check_manager:getFileDownloadInfo(arg_7_1))
		arg_7_0:startDownloadSingle(var_7_0)
	else
		arg_7_0:onDownloadDisabledComplete(arg_7_1)
	end
end

local function var_0_15(arg_8_0, arg_8_1)
	require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_8_1)
end

local function var_0_16(arg_9_0)
	arg_9_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("DOWNLOAD_EVENT_COMPLETE", function(arg_10_0)
		if arg_9_0._downloadnormaltexture == arg_10_0.fileName then
			arg_9_0._downloadnormaltexture = nil

			arg_9_0:onDownloadNormalComplete(arg_10_0.fileName)
		end

		if arg_9_0._downloadpressedtexture == arg_10_0.fileName then
			arg_9_0._downloadpressedtexture = nil

			arg_9_0:onDownloadPressedComplete(arg_10_0.fileName)
		end

		if arg_9_0._downloaddisabledtexture == arg_10_0.fileName then
			arg_9_0._downloaddisabledtexture = nil

			arg_9_0:onDownloadDisabledComplete(arg_10_0.fileName)
		end

		if arg_9_0._downloadinglist[arg_10_0.fileName] then
			arg_9_0._downloadinglist[arg_10_0.fileName] = nil

			if not next(arg_9_0._downloadinglist) then
				arg_9_0:onDownloadComplete(arg_9_0._downloadimg)
			end
		end
	end), arg_9_0)
end

local function var_0_17(arg_11_0)
	download_node_utils:addDownloadInterface(arg_11_0, "Button")

	arg_11_0.onDownloadComplete = var_0_8
	arg_11_0.onDownloadNormalComplete = var_0_9
	arg_11_0.onDownloadPressedComplete = var_0_10
	arg_11_0.onDownloadDisabledComplete = var_0_11
	arg_11_0.checkResourceNormal = var_0_12
	arg_11_0.checkResourcePressed = var_0_13
	arg_11_0.checkResourceDisabled = var_0_14
	arg_11_0.startDownloadSingle = var_0_15
	arg_11_0.registerDownloadEventListener = var_0_16

	arg_11_0:initDownload()
end

function ccui.Button.create(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if arg_12_5 then
		local var_12_0 = var_0_0(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4 or ccui.TextureResType.localType)

		var_12_0:setDownloadEnabled(false)

		return var_12_0
	end

	if arg_12_4 == ccui.TextureResType.plistType then
		return var_0_0(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	else
		local var_12_1 = var_0_0(arg_12_0)

		var_0_17(var_12_1)

		if arg_12_1 or arg_12_2 or arg_12_3 then
			var_12_1:checkResource({
				normal = arg_12_1,
				pressed = arg_12_2,
				disabled = arg_12_3
			})
		end

		return var_12_1
	end
end

function ccui.Button:loadTextures(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if not self:isDownloadEnabled() then
		var_0_1(self, arg_13_1, arg_13_2, arg_13_3, arg_13_4 or ccui.TextureResType.localType)

		return
	end

	if arg_13_4 == ccui.TextureResType.plistType then
		var_0_1(self, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	else
		if not self._havedownloadapi then
			var_0_17(self)
		end

		if arg_13_1 or arg_13_2 or arg_13_3 then
			self:checkResource({
				normal = arg_13_1,
				pressed = arg_13_2,
				disabled = arg_13_3
			})
		end
	end
end

function ccui.Button:loadTextureNormal(arg_14_1, arg_14_2)
	if not self:isDownloadEnabled() then
		var_0_2(self, arg_14_1, arg_14_2 or ccui.TextureResType.localType)

		return
	end

	if arg_14_2 == ccui.TextureResType.plistType then
		var_0_2(self, arg_14_1, arg_14_2)
	else
		self:checkResourceNormal(arg_14_1)
	end
end

function ccui.Button:loadTexturePressed(arg_15_1, arg_15_2)
	if not self:isDownloadEnabled() then
		var_0_3(self, arg_15_1, arg_15_2 or ccui.TextureResType.localType)

		return
	end

	if arg_15_2 == ccui.TextureResType.plistType then
		var_0_3(self, arg_15_1, arg_15_2)
	else
		self:checkResourcePressed(arg_15_1)
	end
end

function ccui.Button:loadTextureDisabled(arg_16_1, arg_16_2)
	if not self:isDownloadEnabled() then
		var_0_4(self, arg_16_1, arg_16_2 or ccui.TextureResType.localType)

		return
	end

	if arg_16_2 == ccui.TextureResType.plistType then
		var_0_4(self, arg_16_1, arg_16_2)
	else
		self:checkResourceDisabled(arg_16_1)
	end
end
