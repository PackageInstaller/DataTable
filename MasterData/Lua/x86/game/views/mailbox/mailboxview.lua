local MailBoxView = class("MailBoxView", ReduxView)

function MailBoxView:UIName()
	return "Widget/System/Mail/MailUI"
end

function MailBoxView:UIParent()
	return manager.ui.uiMain.transform
end

function MailBoxView:OnCtor()
	self.letterContentItems_ = {}
	self.letterContentClass_ = {
		MailImageItemView,
		MailTextItemView,
		MailRewardItemView,
		MailTitleItemView
	}
end

function MailBoxView:Init()
	self:InitUI()
	self:AddUIListener()

	self.letterTemplate_ = {
		self.imageTemplate_,
		self.textTemplate_,
		self.rewardTemplate_,
		self.titleTemplate_
	}
end

function MailBoxView:InitUI()
	self:BindCfgUI()

	self.letterUiList_ = LuaList.New(handler(self, self.IndexLetterItem), self.mailListGo_, MailBoxListItem)
	self.rewardUiList_ = LuaList.New(handler(self, self.IndexRewardItem), self.rewardListGo_, MailBoxRewardItem)
	self.allReceiveCon_ = self.conExCollection_:GetController("Receive_All")
	self.emptyController_ = self.conExCollection_:GetController("empty")
	self.rewardController_ = self.conExCollection_:GetController("reward")
	self.starController_ = ControllerUtil.GetController(self.starBtn_.transform, "star")
	self.modeController_ = self.conExCollection_:GetController("mode")
	self.mailTypeController_ = self.tabConExCollection:GetController("mailType")
	self.collectStateController_ = self.conExCollection_:GetController("collectState")
	self.showDelStateController_ = self.conExCollection_:GetController("showDelAll")
end

function MailBoxView:AddUIListener()
	self:AddBtnListener(self.delBtn_, nil, function()
		if MailData.GetTotal() <= MailData.GetUnread() then
			ShowTips("NO_MAIL_CAN_BE_DELETED")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MAIL_DELETE_CONFIRM"),
			SecondTip = GetTips("MAIL_DELETE_CONFIRM_NOTICE"),
			OkCallback = function()
				MailAction.TryToDeteleMail(0)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.letterBtn_, nil, function()
		JumpTools.GoToSystem("/letterBox")
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if MailData.GetTotal() == 0 then
			ShowTips("ERROR_NO_MAIL_CAN_RECEIVE")

			return
		end

		MailAction.ReceiveAllMails()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self:GetMail(self.curMailId_).attach_flag == 2 then
			return
		end

		self:OnClickReceiveBtn()
	end)
	self:AddBtnListener(self.removeBtn_, nil, function()
		if self:GetMail(self.curMailId_).attach_flag == 1 then
			return
		end

		self:OnClickDeleteBtn()
	end)
	self:AddBtnListener(self.dlcBtn_, nil, function()
		self:OnClickGotoPurchase()
	end)
	self:AddBtnListener(self.noramlTabBtn_, nil, function()
		self:ChangeMailShowType(MailData.mailType.normal)
	end)
	self:AddBtnListener(self.collectTabBtn_, nil, function()
		self:ChangeMailShowType(MailData.mailType.collect)
	end)
	self:AddBtnListener(self.collectBtn_, nil, function()
		self:OnCollectBtn()
	end)
end

function MailBoxView:ChangeMailShowType(arg_18_1)
	if arg_18_1 == self.useMailType then
		return
	end

	self.curIndex_ = nil
	self.curMailId_ = nil
	self.useMailType = arg_18_1

	self.mailTypeController_:SetSelectedState(self.useMailType == MailData.mailType.normal and "normal" or "collect")
	self:RefreshUI()
end

function MailBoxView:OnCollectBtn()
	if MailData.GetCollectMail(self.curMailId_) then
		if not self.SkipCollectRemoveTips_ and not MailData.GetMail(self.curMailId_) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("REMOVE_COLLECT_MAIL_TIPS"),
				OkCallback = function()
					_G.SkipTip.SkipCollectRemoveTips_ = self.SkipCollectRemoveTips_

					MailAction.SetMailCollect(self.curMailId_, 0)
				end,
				ToggleCallback = function(arg_21_0)
					self.SkipCollectRemoveTips_ = arg_21_0
				end
			})
		else
			MailAction.SetMailCollect(self.curMailId_, 0)
		end
	elseif GameSetting.max_collect_mail_count.value[1] <= MailData.GetCollectTotal() then
		ShowTips("ADD_COLLECT_MAIL_MAX_TIPS")
	else
		MailAction.SetMailCollect(self.curMailId_, 1)
	end
end

function MailBoxView:AddEventListener()
	self:RegistEventListener(MAIL_BRIEF_UPDATE, handler(self, self.OnBriefUpdate))
	self:RegistEventListener(MAIL_LIST_UPDATE, handler(self, self.OnMailListUpdate))
	self:RegistEventListener(MAIL_INFO_UPDATE, handler(self, self.OnMailInfoUpdate))
	self:RegistEventListener(MAIL_STAR_UPDATE, handler(self, self.OnMailStarUpdate))
	self:RegistEventListener(MAIL_COLLECT_UPDATE, handler(self, self.OnMailCollectUpdate))
end

function MailBoxView:IndexRewardItem(arg_23_1, arg_23_2)
	local var_23_0 = self:GetMail(self.curMailId_)

	arg_23_2:SetRewardData(var_23_0.rewardList[arg_23_1], var_23_0.attach_flag == 2)
end

function MailBoxView:IndexLetterItem(arg_24_1, arg_24_2)
	local var_24_0 = self:GetMailSortedList()[arg_24_1]

	arg_24_2:SetMailData(self:GetMail(var_24_0), self.useMailType)
	arg_24_2:SetClickHandler(function()
		self:OnClickLetter(arg_24_1, arg_24_2)
	end)

	if self.curMailId_ then
		if self.curMailId_ == var_24_0 then
			arg_24_2:SetSelected(true)
		else
			arg_24_2:SetSelected(false)
		end
	elseif arg_24_1 == 1 then
		self:SelectItem(1)
	end

	arg_24_2:UpdateView()
end

function MailBoxView:OnEnter()
	MailAction.SortMailManual()
	self:AddEventListener()
	manager.redPoint:bindUIandKey(self.letterTrans_, RedPointConst.LETTER_UNREAD)

	if self.useMailType ~= MailData.mailType.normal then
		self:ChangeMailShowType(MailData.mailType.normal)
	else
		self:RefreshUI()
	end

	self:StartTimer()
end

function MailBoxView:OnTop()
	self:ShowDefaultBar()
end

function MailBoxView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:RemoveTimer()
	manager.redPoint:unbindUIandKey(self.letterTrans_)
	self:SelectItem(nil)
end

function MailBoxView:RefreshUI()
	self:UpdateList(true)
	self:RefreshLeftUI()
end

function MailBoxView:OnMailInfoUpdate(arg_30_1)
	if self.curMailId_ ~= nil and arg_30_1.id == self.curMailId_ then
		self:RefreshLetterUI(arg_30_1.id, true)
	end
end

function MailBoxView:OnMailStarUpdate(arg_31_1)
	if arg_31_1.id == self.curMailId_ then
		self:RefreshStarUI()

		if arg_31_1.star_state == 1 then
			self:UpdateList(false)
		end
	end
end

function MailBoxView:OnMailCollectUpdate(arg_32_1)
	self.collectnumText_.text = string.format("%d/%d", MailData.GetCollectTotal(), GameSetting.max_collect_mail_count.value[1])

	if arg_32_1 == self.curMailId_ then
		self:RefreshCollectUI()
	end

	if self.useMailType == MailData.mailType.collect then
		self:UpdateList()
	end
end

function MailBoxView:OnBriefUpdate()
	self:RefreshLeftUI()
end

function MailBoxView:OnMailListUpdate()
	MailData.GetMailListFromServer(handler(self, function()
		MailAction.SortMailManual()
		self:UpdateList()
		self:RefreshLeftUI()
	end))
end

function MailBoxView:DeleteCurrentMail(arg_36_1)
	local var_36_0 = arg_36_1 or self.curMailId_

	if (arg_36_1 or self.curMailId_) == nil then
		return
	end

	if table.indexof(self:GetMailSortedList(), var_36_0) == false then
		return
	end

	MailAction.DeleteOneMail(var_36_0)
end

function MailBoxView:SelectItem(arg_37_1)
	if arg_37_1 == nil then
		self.curIndex_ = nil
		self.curMailId_ = nil

		if self.curLetterItem_ then
			self.curLetterItem_:SetSelected(false)
			self.curLetterItem_:UpdateView()

			self.curLetterItem_ = nil
		end

		return
	end

	local var_37_0 = self:GetMailSortedList()[arg_37_1]

	if var_37_0 == nil or var_37_0 == 0 then
		return
	end

	if self.curLetterItem_ then
		self.curLetterItem_:SetSelected(false)
		self.curLetterItem_:UpdateView()
	end

	local var_37_1 = self.letterUiList_:GetItemByIndex(arg_37_1)

	self.curIndex_ = arg_37_1
	self.curMailId_ = var_37_0
	self.curLetterItem_ = var_37_1

	var_37_1:SetSelected(true)
	MailAction.ReadMail(var_37_0)
	self:RefreshLetterUI(var_37_0)
end

function MailBoxView:OnClickLetter(arg_38_1, arg_38_2)
	self:SelectItem(arg_38_1)
end

function MailBoxView:OnClickDeleteBtn()
	local var_39_0 = self.curMailId_

	if self.curMailId_ ~= nil and self.curMailId_ ~= 0 then
		if self:GetMail(self.curMailId_).star_state == 1 then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = string.format(GetTips("MAIL_STAR_DELETE_TIP")),
				OkCallback = function()
					self:DeleteCurrentMail(var_39_0)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			self:DeleteCurrentMail()
		end
	end
end

function MailBoxView:OnClickReceiveBtn()
	MailAction.TryToGetMailAttachment(self.curMailId_)
end

function MailBoxView:OnClickGotoPurchase()
	local var_43_0 = self:GetMail(self.curMailId_)

	if var_43_0 and MailTools.CheckIsPurchaseTemplate(var_43_0.mail_template_id) then
		if var_43_0.mail_template_id == MailConst.MAIL_ID_CONST.SKIN_DLC_EXPIRE and var_43_0.link_param[1] and var_43_0.link_param[2] and var_43_0.link_param[3] then
			ShopTools.JumpToSkinShop(var_43_0.link_param[2], true, var_43_0.link_param[1], var_43_0.link_param[3])
		elseif var_43_0.mail_template_id == MailConst.MAIL_ID_CONST.SKIN_EXPIRE and var_43_0.link_param[1] then
			ShopTools.JumpToSkinShop(var_43_0.link_param[1], false)
		end
	end
end

function MailBoxView:RefreshLetterUI(arg_44_1, arg_44_2)
	local var_44_0 = self:GetMail(arg_44_1)

	self.titleText_.text = utf8.sub(MailData.GetMailTitle(arg_44_1, self.useMailType), 1, GameSetting.admin_mail_title_max_len.value[1] + 1)
	self.dateText_.text = manager.time:STimeDescS(var_44_0.date, "!%Y-%m-%d")

	if not arg_44_2 then
		SetActive(self.itemParent_.gameObject, false)
		MailData.TryToGetMailDetail(var_44_0.id, self.useMailType, handler(self, function()
			self:UpdateMailContentView(var_44_0)
			TimeTools.StartAfterSeconds(0.1, function()
				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemParent_.transform)
				SetActive(self.itemParent_.gameObject, true)
			end, {})
		end))
	else
		SetActive(self.itemParent_.gameObject, true)
	end

	if var_44_0.rewardList then
		self.rewardUiList_:StartScroll(#var_44_0.rewardList)
	end

	self:RenderRewardState(var_44_0)
end

function MailBoxView:RenderRewardState(arg_47_1)
	if self.useMailType == MailData.mailType.collect then
		if MailTools.CheckIsPurchaseTemplate(arg_47_1.mail_template_id) then
			self.rewardController_:SetSelectedState("dlc")
		else
			self.rewardController_:SetSelectedState("false")
		end

		return
	end

	if MailTools.CheckIsPurchaseTemplate(arg_47_1.mail_template_id) then
		self.rewardController_:SetSelectedState("dlc")
		self.modeController_:SetSelectedState("delete")

		return
	end

	if arg_47_1.attach_flag == 0 then
		self.rewardController_:SetSelectedState("false")
		self.modeController_:SetSelectedState("delete")
	elseif arg_47_1.attach_flag == 2 then
		self.rewardController_:SetSelectedState("true")
		self.modeController_:SetSelectedState("delete")
	else
		self.rewardController_:SetSelectedState("true")
		self.modeController_:SetSelectedState("reward")
	end
end

function MailBoxView:RefreshCollectUI()
	if MailData.GetCollectMail(self.curMailId_) then
		self.collectStateController_:SetSelectedState("cancelCollect")
	else
		self.collectStateController_:SetSelectedState("canCollect")
	end
end

function MailBoxView:RefreshStarUI()
	if self:GetMail(self.curMailId_).star_state == 1 then
		self.starController_:SetSelectedState("true")
	else
		self.starController_:SetSelectedState("false")
	end
end

function MailBoxView:RefreshLeftUI()
	self.normalnumText_.text = string.format("%d/%d", MailData.GetTotal(), GameSetting.max_mail_count.value[1])
	self.collectnumText_.text = string.format("%d/%d", MailData.GetCollectTotal(), GameSetting.max_collect_mail_count.value[1])

	self:RefreshAllReceiveUI()
end

function MailBoxView:RefreshCountdownUI()
	for iter_51_0, iter_51_1 in pairs(self.letterUiList_:GetItemList()) do
		if iter_51_1 then
			iter_51_1:UpdateCountdown()
		end
	end
end

function MailBoxView:RefreshAllReceiveUI()
	local var_52_0 = false

	for iter_52_0, iter_52_1 in pairs((self:GetMailSortedList())) do
		local var_52_1 = self:GetMail(iter_52_1)

		if var_52_1 and var_52_1.attach_flag == 1 then
			var_52_0 = true

			break
		end
	end

	self.allReceiveCon_:SetSelectedState(var_52_0 and "true" or "false")
end

function MailBoxView:UpdateMailContentView(arg_53_1)
	self.senderText_.text = MailData.GetMailSender(arg_53_1.id, self.useMailType)

	self:RefreshCollectUI()
	self:RefreshStarUI()
	self:ClearLetterContent()

	for iter_53_0, iter_53_1 in ipairs((MailData.GetMailContent(arg_53_1.id, self.useMailType))) do
		self:CreateContent(iter_53_1)
	end
end

function MailBoxView:CreateContent(arg_54_1)
	local var_54_0 = self.letterContentClass_[arg_54_1.content_type].New((Object.Instantiate(self.letterTemplate_[arg_54_1.content_type], self.itemParent_.transform)))

	var_54_0:SetData(arg_54_1)
	table.insert(self.letterContentItems_, var_54_0)
end

function MailBoxView:UpdateList(arg_55_1)
	local var_55_0 = self:GetMailSortedList()
	local var_55_1 = #var_55_0

	self.emptyController_:SetSelectedState(#var_55_0 <= 0 and "true" or "false")

	if var_55_1 > 0 and self.useMailType == MailData.mailType.normal then
		self.showDelStateController_:SetSelectedState("show")
	else
		self.showDelStateController_:SetSelectedState("hide")
	end

	if var_55_1 <= 0 then
		self.letterUiList_:StartScroll(0)
		self:SelectItem(nil)
	elseif self.curMailId_ then
		local var_55_2 = table.indexof(var_55_0, self.curMailId_)

		self.curIndex_ = var_55_2 and var_55_2 or math.min(self.curIndex_, #var_55_0)

		self.letterUiList_:StartScroll(#var_55_0, self.curIndex_, not arg_55_1)
		self:SelectItem(self.curIndex_)
	else
		self.letterUiList_:StartScroll(#var_55_0)
	end
end

function MailBoxView:StartTimer()
	self.timer_ = self.timer_ or Timer.New(function()
		local var_57_0 = MailData.GetTimeoutMailIdList()

		if #var_57_0 > 0 then
			MailData.DeleteMail(var_57_0)
			ShowTips("MAIL_EXPIRED")
		end

		self:RefreshCountdownUI()
	end, 1, -1)

	self.timer_:Start()
end

function MailBoxView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function MailBoxView:Dispose()
	if self.letterUiList_ then
		self.letterUiList_:Dispose()

		self.letterUiList_ = nil
	end

	if self.rewardUiList_ then
		self.rewardUiList_:Dispose()

		self.rewardUiList_ = nil
	end

	self:ClearLetterContent()

	self.letterContentItems_ = nil

	manager.classPool:DisposeOnePool(MailBoxListItem)
	MailBoxView.super.Dispose(self)
end

function MailBoxView:ClearLetterContent()
	for iter_60_0 = #self.letterContentItems_, 1, -1 do
		self.letterContentItems_[iter_60_0]:Dispose()

		self.letterContentItems_[iter_60_0] = nil
	end
end

function MailBoxView:GetMailSortedList()
	if self.useMailType == MailData.mailType.collect then
		return MailData.GetCollectMailSort()
	else
		return MailData.GetMailSort()
	end
end

function MailBoxView:GetMail(arg_62_1)
	if self.useMailType == MailData.mailType.collect then
		return MailData.GetCollectMail(arg_62_1)
	else
		return MailData.GetMail(arg_62_1)
	end
end

return MailBoxView
