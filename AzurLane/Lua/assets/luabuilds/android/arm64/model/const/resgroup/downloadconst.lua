local var_0_0 = {}

DownloadConst = {}
;({}).NotifyDownloadFinish = "DownloadConst.NotifyDownloadFinish"
;({}).GetAllGroup = function()
	return BundleWizard.Inst:GetAllGroups()
end
;({}).VerifyFile = function(arg_2_0)
	return GroupHelper.VerifyFile(GroupHelper.GetGroupNameByFilePath(arg_2_0), arg_2_0)
end
;({}).IsNeedCheck = function()
	local var_3_0 = SplitPackHelper.Inst:IsSplitPackMode()

	if Application.isEditor and not var_3_0 then
		return false
	end

	local var_3_1 = GroupHelper.IsAllGroupVerLastest()
	local var_3_2 = GroupHelper.IsAnyGroupWaitToUpdate()

	if not var_3_0 then
		if Application.isEditor or var_3_1 or not var_3_2 then
			return false
		else
			return true
		end
	elseif var_3_2 then
		return true
	else
		return false
	end

	return
end
;({}).CalcListSize = function(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		var_4_0 = var_4_0 + GroupHelper.CalcSizeWithFileArr(iter_4_0, iter_4_1)
	end

	return var_4_0, (HashUtil.BytesToString(var_4_0))
end
;({}).IndexFileListByGroup = function(arg_5_0)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		iter_5_1 = string.lower(iter_5_1)

		local var_5_1 = GroupHelper.GetGroupNameByFilePath(iter_5_1)

		if ({})[var_5_1] == nil then
			({})[var_5_1] = {}
		end

		if var_0_0.VerifyFile(iter_5_1) and not table.contains(({})[var_5_1], iter_5_1) then
			table.insert(({})[var_5_1], iter_5_1)

			var_5_0 = var_5_0 + 1
		end
	end

	return {}, var_5_0
end
;({}).Download = function(arg_6_0)
	if var_0_0.IsNeedCheck() then
		local var_6_0 = IsUsingWifi()
		local var_6_1 = arg_6_0.isShowBox and pg.FileDownloadMgr.GetInstance():IsNeedRemind()
		local var_6_2, var_6_3 = var_0_0.IndexFileListByGroup(arg_6_0.fileList)

		if var_6_3 > 0 then
			if var_6_1 then
				local var_6_4, var_6_5 = var_0_0.CalcListSize(var_6_2)

				table.insert({}, function(arg_7_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						modal = true,
						locked = true,
						hideToggle = true,
						type = MSGBOX_TYPE_FILE_DOWNLOAD,
						content = string.format(i18n("file_down_msgbox", var_6_5)),
						onYes = arg_7_0,
						onNo = arg_6_0.onNo,
						onClose = arg_6_0.onClose
					})

					return
				end)
			end

			table.insert({}, function(arg_8_0)
				for iter_8_0, iter_8_1 in pairs(var_6_2) do
					table.insert(({
						dataList = {},
						onFinish = arg_8_0
					}).dataList, {
						groupName = iter_8_0,
						fileNameList = iter_8_1
					})
				end

				pg.FileDownloadMgr.GetInstance():Main({
					dataList = {},
					onFinish = arg_8_0
				})

				return
			end)
			table.insert({}, function(arg_9_0)
				pg.m02:sendNotification(var_0_0.NotifyDownloadFinish)
				arg_9_0()

				return
			end)
		end
	end

	seriesAsync({}, arg_6_0.finishFunc)

	return
end

return {}
