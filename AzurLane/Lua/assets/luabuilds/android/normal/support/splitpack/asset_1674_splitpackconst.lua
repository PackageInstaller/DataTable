local var_0_0 = {}
local var_0_1 = SplitPackConst

function var_0_1.DownloadByLuaArr(arg_1_0, arg_1_1)
	AssetBundleHelper = var_1_10002

	if var_1_10002.GetTotalRefList(arg_1_0) and #var_2 > 0 then
		local var_1_0 = {}

		var_1_0.isShowBox = false
		var_1_0.fileList = var_2
		var_1_0.finishFunc = arg_1_1

		function var_1_0.onNo()
			return
		end

		function var_1_0.onClose()
			return
		end

		DownloadConst = var_4

		var_4.Download(var_1_0)
	elseif arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_1.StartMainDownload()
	local var_4_0 = {}

	GroupMainHelper = var_1_10001
	var_4_0[1] = var_1_10001.DefaultGroupName

	local function var_4_1(arg_5_0, arg_5_1, arg_5_2)
		return
	end

	local function var_4_2(arg_6_0, arg_6_1)
		return
	end

	local function var_4_3(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		string = var_2_10006

		local var_7_0 = var_2_10006.format("成功: %d, 失败: %d, 总文件数: %d, 下载速度: %s", arg_7_0, arg_7_1, arg_7_2, arg_7_5)

		print = var_7

		var_7(var_7_0)

		return
	end

	BundleWizardUpdater = var_1_10004

	local var_4_4 = var_1_10004.Inst
	local var_4_5 = var_4.GetFileList(var_4_4, var_4_0)

	BundleWizardUpdater = var_4_4

	local var_4_6 = var_4_4.Inst
	local var_4_7 = var_5.CreateListInfo

	GroupMainHelper = var_1_10007

	local var_4_8 = var_4_7(var_4_6, var_1_10007.DefaultGroupName, var_4_5, var_4_1, var_4_2, var_4_3)

	BundleWizardUpdater = var_4_6

	local var_4_9 = var_4_6.Inst

	var_6.StartUpdate(var_4_9, var_4_8)

	return
end

return var_0_1
