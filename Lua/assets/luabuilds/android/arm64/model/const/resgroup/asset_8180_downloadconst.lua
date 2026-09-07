local var_0_0 = {}

DownloadConst = var_0_0
var_0_0.NotifyDownloadFinish = "DownloadConst.NotifyDownloadFinish"

function var_0_0.GetAllGroup()
	return BundleWizard.Inst:GetAllGroups()
end

function var_0_0.VerifyFile(arg_2_0)
	return GroupHelper.VerifyFile(GroupHelper.GetGroupNameByFilePath(arg_2_0), arg_2_0)
end

function var_0_0.IsNeedCheck()
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

function var_0_0.CalcListSize(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		var_4_0 = var_4_0 + GroupHelper.CalcSizeWithFileArr(iter_4_0, iter_4_1)
	end

	return var_4_0, (HashUtil.BytesToString(var_4_0))
end

function var_0_0.IndexFileListByGroup(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		iter_5_1 = string.lower(iter_5_1)

		local var_5_2 = GroupHelper.GetGroupNameByFilePath(iter_5_1)

		if var_5_1[var_5_2] == nil then
			var_5_1[var_5_2] = {}
		end

		if var_0_0.VerifyFile(iter_5_1) and not table.contains(var_5_1[var_5_2], iter_5_1) then
			table.insert(var_5_1[var_5_2], iter_5_1)

			var_5_0 = var_5_0 + 1
		end
	end

	return var_5_1, var_5_0
end

function var_0_0:Download()
	local var_6_0 = {}

	if var_0_0.IsNeedCheck() then
		local var_6_1 = IsUsingWifi()
		local var_6_2 = self.isShowBox and pg.FileDownloadMgr.GetInstance():IsNeedRemind()
		local var_6_3, var_6_4 = var_0_0.IndexFileListByGroup(self.fileList)

		if var_6_4 > 0 then
			if var_6_2 then
				local var_6_5, var_6_6 = var_0_0.CalcListSize(var_6_3)

				table.insert(var_6_0, function(arg_7_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						modal = true,
						locked = true,
						hideToggle = true,
						type = MSGBOX_TYPE_FILE_DOWNLOAD,
						content = string.format(i18n("file_down_msgbox", var_6_6)),
						onYes = arg_7_0,
						onNo = self.onNo,
						onClose = self.onClose
					})

					return
				end)
			end

			table.insert(var_6_0, function(arg_8_0)
				local var_8_0 = {
					dataList = {},
					onFinish = arg_8_0
				}

				for iter_8_0, iter_8_1 in pairs(var_6_3) do
					table.insert(var_8_0.dataList, {
						groupName = iter_8_0,
						fileNameList = iter_8_1
					})
				end

				pg.FileDownloadMgr.GetInstance():Main(var_8_0)

				return
			end)
			table.insert(var_6_0, function(arg_9_0)
				pg.m02:sendNotification(var_0_0.NotifyDownloadFinish)
				arg_9_0()

				return
			end)
		end
	end

	seriesAsync(var_6_0, self.finishFunc)

	return
end

return var_0_0
