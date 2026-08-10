local var_0_0 = class("ChatReportView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Friends/LineReportUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.optionDataList_ = {}

	for iter_3_0, iter_3_1 in ipairs(ChatConst.CHAT_REPORT_REASON) do
		arg_3_0.optionDataList_[iter_3_0] = OptionDataList.New()

		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			if iter_3_3 == 0 then
				local var_3_0 = GetTips("REPORT_SELECT")

				arg_3_0.optionDataList_[iter_3_0].options:Add(OptionData.New(var_3_0))
			else
				local var_3_1 = GetTips(ChatConst.CHAT_REASON_INDEX[iter_3_3])

				arg_3_0.optionDataList_[iter_3_0].options:Add(OptionData.New(var_3_1))
			end
		end
	end
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.inputFieldNote_.text = ""
	arg_4_0.textNick_.text = GetI18NText(arg_4_0.params_.reportData.nick)
	arg_4_0.dropDownReason_.options = arg_4_0.optionDataList_[arg_4_0.params_.reportType].options
	arg_4_0.dropDownReason_.value = 0
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.optionDataList_) do
		iter_6_1.options:Clear()
	end

	arg_6_0.optionDataList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonCancel_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonSure_, nil, function()
		if arg_7_0.dropDownReason_.value == 0 then
			ShowTips("NEED_REPORT_REASON")

			return
		end

		if arg_7_0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.CONTENT then
			ChatAction.ChatReportMsg(arg_7_0.params_.reportData.msgID, ChatConst.CHAT_REPORT_REASON[arg_7_0.params_.reportType][arg_7_0.dropDownReason_.value + 1], arg_7_0.inputFieldNote_.text, function(arg_11_0)
				if isSuccess(arg_11_0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function()
							arg_7_0:Back()
						end
					})
				else
					ShowTips(arg_11_0.result)
				end
			end)
		elseif arg_7_0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.USER then
			ChatAction.ChatReportUser(arg_7_0.params_.reportData.userID, ChatConst.CHAT_REPORT_REASON[arg_7_0.params_.reportType][arg_7_0.dropDownReason_.value + 1], arg_7_0.inputFieldNote_.text, function(arg_13_0)
				if isSuccess(arg_13_0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function()
							arg_7_0:Back()
						end
					})
				else
					ShowTips(arg_13_0.result)
				end
			end)
		elseif arg_7_0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.DORM then
			local function var_10_0()
				SetActive(manager.ui.uiPop.transform, false)
				WaitRenderFrameUtil.inst.StartScreenShot(function()
					local var_16_0 = tonumber(SettingData:GetSettingData().pic.resolution)
					local var_16_1, var_16_2 = SettingTools.GetSettingScreenSize(var_16_0)

					if not SDKTools.IsSDK() then
						var_16_1, var_16_2 = Screen.width, Screen.height
					end

					arg_7_0.screenSnap_ = ScreenSnap.New(var_16_1, var_16_2)

					arg_7_0.screenSnap_:Take()

					local var_16_3 = arg_7_0.screenSnap_:GetSprite()

					SetActive(manager.ui.uiPop.transform, true)

					if arg_7_0.params_.reportData then
						local var_16_4 = PlayerData:GetPlayerInfo().signUserId
						local var_16_5 = PlayerData:GetPlayerInfo().userID .. "_" .. var_16_4

						local function var_16_6(arg_17_0)
							if arg_17_0 == "ServerError" then
								print("图片服务器上传失败")

								return
							end

							local var_17_0 = {
								reported_user_id = arg_7_0.params_.reportData.userID,
								layout_uid = arg_7_0.params_.reportData.layout_uid,
								architecture_id = arg_7_0.params_.reportData.architecture_id,
								report_type = ChatConst.CHAT_REPORT_REASON[arg_7_0.params_.reportType][arg_7_0.dropDownReason_.value + 1],
								report_note = arg_7_0.inputFieldNote_.text,
								picture_link = arg_17_0
							}

							ChatAction.DormReportUser(var_17_0, function(arg_18_0)
								if isSuccess(arg_18_0.result) then
									-- block empty
								else
									ShowTips(arg_18_0.result)
								end
							end)
						end

						local var_16_7 = OperationAction.GetOperationUrl("REST_URL")

						print("获取图片服务器路径", var_16_7)

						if not var_16_7 then
							print("获取图片服务器路径失败")
						else
							local var_16_8 = var_16_7 .. "/common/uploadResource"

							DormLuaBridge.SavePhotoToWebServer(var_16_3, var_16_8, var_16_5, var_16_6)
						end

						arg_7_0:Back()
						ShowTips("REPORT_SUCCESS")
					end
				end)
			end

			WordVerifyBySDK(arg_7_0.inputFieldNote_.text, function(arg_19_0)
				if not arg_19_0 then
					ShowTips("ERROR_USER_NAME_VER_WORD")
				elseif var_10_0 then
					var_10_0()
				end
			end, JUDGE_MESSAGE_TYPE.OTHER)
		end
	end)
end

return var_0_0
