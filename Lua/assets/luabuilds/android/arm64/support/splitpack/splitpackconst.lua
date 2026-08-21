SplitPackConst = {}
;({}).DownloadByLuaArr = function(arg_1_0, arg_1_1)
	local var_1_0 = AssetBundleHelper.GetTotalRefList(arg_1_0)

	if var_1_0 and #var_1_0 > 0 then
		({}).isShowBox = false
		;({}).fileList = var_1_0
		;({}).finishFunc = arg_1_1
		;({}).onNo = function()
			return
		end
		;({}).onClose = function()
			return
		end

		DownloadConst.Download({})
	elseif arg_1_1 then
		arg_1_1()
	end

	return
end
;({}).StartMainDownload = function()
	BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(GroupMainHelper.DefaultGroupName, BundleWizardUpdater.Inst:GetFileList({
		GroupMainHelper.DefaultGroupName
	}), function(arg_5_0, arg_5_1, arg_5_2)
		return
	end, function(arg_6_0, arg_6_1)
		return
	end, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		print((string.format("成功: %d, 失败: %d, 总文件数: %d, 下载速度: %s", arg_7_0, arg_7_1, arg_7_2, arg_7_5)))

		return
	end)))

	return
end

return {}
