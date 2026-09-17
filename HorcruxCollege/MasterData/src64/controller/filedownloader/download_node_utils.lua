local var_0_0 = {}
local file_check_manager = require("controller.filedownloader.file_check_manager")
local var_0_2 = "default/default.png"
local var_0_3 = "default/default.json"
local var_0_4 = "default/default.atlas"
local var_0_5 = {
	Live2d = "Live2d",
	Layout = "Layout",
	Button = "Button",
	Spine = "Spine",
	ImageView = "ImageView",
	Sprite = "Sprite"
}

local function var_0_6(arg_1_0)
	arg_1_0._havedownloadapi = true
	arg_1_0._downloadimg = nil
	arg_1_0._loadingani = nil
	arg_1_0._downloadinglist = {}

	arg_1_0:registerDownloadEventListener()
end

local function var_0_7(arg_2_0, arg_2_1)
	arg_2_0._downloadinglist = {}
	arg_2_0._downloadimg = arg_2_1

	if not arg_2_1 then
		arg_2_0:onDownloadComplete(arg_2_1)

		return
	end

	if file_check_manager:checkFileNeedDownload(arg_2_1) then
		arg_2_0:onDownloadComplete(var_0_2)
		arg_2_0:onDownloadProcessing()

		local var_2_0 = {}

		table.insert(var_2_0, file_check_manager:getFileDownloadInfo(arg_2_1))
		arg_2_0:startDownload(var_2_0)
	else
		arg_2_0:onDownloadComplete(arg_2_1)
	end
end

local var_0_8 = {
	[var_0_5.ImageView] = var_0_7,
	[var_0_5.Button] = function(arg_3_0, arg_3_1)
		arg_3_0._downloadinglist = {}
		arg_3_0._downloadimg = arg_3_1

		if not arg_3_1 then
			arg_3_0:onDownloadComplete(arg_3_1)

			return
		end

		local var_3_0 = {}

		var_3_0[#var_3_0 + 1] = arg_3_1.normal
		var_3_0[#var_3_0 + 1] = arg_3_1.pressed
		var_3_0[#var_3_0 + 1] = arg_3_1.disabled

		local var_3_1, var_3_2 = file_check_manager:checkFileNeedDownloadByList(var_3_0)

		if var_3_1 then
			arg_3_0:onDownloadComplete({
				normal = var_0_2,
				pressed = var_0_2,
				disabled = var_0_2
			})
			arg_3_0:onDownloadProcessing()
			arg_3_0:startDownload(var_3_2)
		else
			arg_3_0:onDownloadComplete(arg_3_1)
		end
	end,
	[var_0_5.Sprite] = var_0_7,
	[var_0_5.Spine] = function(arg_4_0, arg_4_1)
		arg_4_0._downloadinglist = {}
		arg_4_0._downloadimg = arg_4_1

		if not arg_4_1 then
			arg_4_0:onDownloadComplete(arg_4_1)

			return
		end

		local var_4_0, var_4_1 = file_check_manager:checkSpineFile(arg_4_1.json)

		if var_4_0 then
			arg_4_0:onDownloadComplete({
				json = var_0_3,
				atlas = var_0_4
			})
			arg_4_0:onDownloadProcessing()
			arg_4_0:startDownload(var_4_1)
		else
			arg_4_0:onDownloadComplete(arg_4_1)
		end
	end,
	[var_0_5.Live2d] = function(arg_5_0, arg_5_1)
		arg_5_0._downloadinglist = {}
		arg_5_0._downloadimg = arg_5_1

		if not arg_5_1 then
			arg_5_0:onDownloadComplete(arg_5_1)

			return
		end

		local var_5_0, var_5_1 = file_check_manager:checkL2DFile(arg_5_1)

		if var_5_0 then
			arg_5_0:onDownloadProcessing()
			arg_5_0:startDownload(var_5_1)
		else
			arg_5_0:onDownloadComplete(arg_5_1)
		end
	end,
	[var_0_5.Layout] = var_0_7
}

local function var_0_9(arg_6_0, arg_6_1)
	arg_6_0._downloadinglist = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0._downloadinglist[iter_6_1.filename] = true
	end

	require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_6_1)
end

local function var_0_10(arg_7_0)
	arg_7_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("DOWNLOAD_EVENT_COMPLETE", function(arg_8_0)
		if arg_7_0._downloadinglist[arg_8_0.fileName] then
			arg_7_0._downloadinglist[arg_8_0.fileName] = nil

			if not next(arg_7_0._downloadinglist) then
				arg_7_0:onDownloadComplete(arg_7_0._downloadimg)
			end
		end
	end), arg_7_0)
end

local function var_0_11(arg_9_0)
	arg_9_0._downloadinglist = {}
	arg_9_0._downloadimg = nil
end

local function var_0_12(...)
	return
end

local function var_0_13(...)
	return
end

function var_0_0.addDownloadInterface(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or var_0_5.ImageView
	arg_12_1.initDownload = arg_12_1.initDownload or var_0_6
	arg_12_1.checkResource = arg_12_1.checkResource or var_0_8[arg_12_2]
	arg_12_1.startDownload = arg_12_1.startDownload or var_0_9
	arg_12_1.registerDownloadEventListener = arg_12_1.registerDownloadEventListener or var_0_10
	arg_12_1.stopDownload = arg_12_1.stopDownload or var_0_11
	arg_12_1.onDownloadProcessing = arg_12_1.onDownloadProcessing or var_0_12
	arg_12_1.onDownloadComplete = arg_12_1.onDownloadComplete or var_0_13
end

return var_0_0
