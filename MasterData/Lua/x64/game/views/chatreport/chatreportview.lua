local ChatReportView = class("ChatReportView", ReduxView)

function ChatReportView:UIName()
	return "Widget/System/Friends/LineReportUI"
end

function ChatReportView:UIParent()
	return manager.ui.uiPop.transform
end

function ChatReportView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.optionDataList_ = {}

	for iter_3_0, iter_3_1 in ipairs(ChatConst.CHAT_REPORT_REASON) do
		self.optionDataList_[iter_3_0] = OptionDataList.New()

		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			if iter_3_3 == 0 then
				self.optionDataList_[iter_3_0].options:Add(OptionData.New((GetTips("REPORT_SELECT"))))
			else
				self.optionDataList_[iter_3_0].options:Add(OptionData.New((GetTips(ChatConst.CHAT_REASON_INDEX[iter_3_3]))))
			end
		end
	end
end

function ChatReportView:OnEnter()
	self.inputFieldNote_.text = ""
	self.textNick_.text = GetI18NText(self.params_.reportData.nick)
	self.dropDownReason_.options = self.optionDataList_[self.params_.reportType].options
	self.dropDownReason_.value = 0
end

function ChatReportView:OnExit()
	return
end

function ChatReportView:Dispose()
	ChatReportView.super.Dispose(self)

	for iter_6_0, iter_6_1 in ipairs(self.optionDataList_) do
		iter_6_1.options:Clear()
	end

	self.optionDataList_ = nil
end

function ChatReportView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonSure_, nil, function()
		if self.dropDownReason_.value == 0 then
			ShowTips("NEED_REPORT_REASON")

			return
		end

		if self.params_.reportType == ChatConst.CHAT_REPORT_TYPE.CONTENT then
			ChatAction.ChatReportMsg(self.params_.reportData.msgID, ChatConst.CHAT_REPORT_REASON[self.params_.reportType][self.dropDownReason_.value + 1], self.inputFieldNote_.text, function(arg_11_0)
				if isSuccess(arg_11_0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function()
							self:Back()
						end
					})
				else
					ShowTips(arg_11_0.result)
				end
			end)
		elseif self.params_.reportType == ChatConst.CHAT_REPORT_TYPE.USER then
			ChatAction.ChatReportUser(self.params_.reportData.userID, ChatConst.CHAT_REPORT_REASON[self.params_.reportType][self.dropDownReason_.value + 1], self.inputFieldNote_.text, function(arg_13_0)
				if isSuccess(arg_13_0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function()
							self:Back()
						end
					})
				else
					ShowTips(arg_13_0.result)
				end
			end)
		elseif self.params_.reportType == ChatConst.CHAT_REPORT_TYPE.DORM then
			local function var_10_0()
				SetActive(manager.ui.uiPop.transform, false)
				WaitRenderFrameUtil.inst.StartScreenShot(function()
					local var_16_0, var_16_1 = SettingTools.GetSettingScreenSize((tonumber(SettingData:GetSettingData().pic.resolution)))

					if not SDKTools.IsSDK() then
						var_16_1 = Screen.height
						var_16_0 = Screen.width
					end

					self.screenSnap_ = ScreenSnap.New(var_16_0, var_16_1)

					self.screenSnap_:Take()
					SetActive(manager.ui.uiPop.transform, true)

					if self.params_.reportData then
						local var_16_2 = OperationAction.GetOperationUrl("REST_URL")

						print("获取图片服务器路径", var_16_2)

						if not var_16_2 then
							print("获取图片服务器路径失败")
						else
							DormLuaBridge.SavePhotoToWebServer(self.screenSnap_:GetSprite(), var_16_2 .. "/common/uploadResource", PlayerData:GetPlayerInfo().userID .. "_" .. PlayerData:GetPlayerInfo().signUserId, function(arg_17_0)
								if arg_17_0 == "ServerError" then
									print("图片服务器上传失败")

									return
								end

								ChatAction.DormReportUser({
									reported_user_id = self.params_.reportData.userID,
									layout_uid = self.params_.reportData.layout_uid,
									architecture_id = self.params_.reportData.architecture_id,
									report_type = ChatConst.CHAT_REPORT_REASON[self.params_.reportType][self.dropDownReason_.value + 1],
									report_note = self.inputFieldNote_.text,
									picture_link = arg_17_0
								}, function(arg_18_0)
									if isSuccess(arg_18_0.result) then
										-- block empty
									else
										ShowTips(arg_18_0.result)
									end
								end)
							end)
						end

						self:Back()
						ShowTips("REPORT_SUCCESS")
					end
				end)
			end

			WordVerifyBySDK(self.inputFieldNote_.text, function(arg_19_0)
				if not arg_19_0 then
					ShowTips("ERROR_USER_NAME_VER_WORD")
				elseif var_10_0 then
					var_10_0()
				end
			end, JUDGE_MESSAGE_TYPE.OTHER)
		end
	end)
end

return ChatReportView
