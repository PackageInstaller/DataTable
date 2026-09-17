local var_0_0 = ccui.Layout.setBackGroundImage
local download_node_utils = require("controller.filedownloader.download_node_utils")

local function var_0_2(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	var_0_0(arg_1_0, arg_1_1)

	if arg_1_0.afterLoadSuccess then
		arg_1_0:afterLoadSuccess(arg_1_1)
	end
end

local function var_0_3(arg_2_0)
	download_node_utils:addDownloadInterface(arg_2_0, "Layout")

	arg_2_0.onDownloadComplete = var_0_2

	arg_2_0:initDownload()
end

function ccui.Layout:setBackGroundImage(arg_3_1, arg_3_2)
	if arg_3_2 == ccui.TextureResType.plistType then
		var_0_0(self, arg_3_1, arg_3_2)
	else
		if not self._havedownloadapi then
			var_0_3(self)
		end

		if arg_3_1 then
			self:checkResource(arg_3_1)
		end
	end
end
