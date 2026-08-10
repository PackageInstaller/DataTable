local var_0_0 = class("MailBoxView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Mail/MailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.letterContentItems_ = {}
	arg_3_0.letterContentClass_ = {
		MailImageItemView,
		MailTextItemView,
		MailRewardItemView,
		MailTitleItemView
	}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.letterTemplate_ = {
		arg_4_0.imageTemplate_,
		arg_4_0.textTemplate_,
		arg_4_0.rewardTemplate_,
		arg_4_0.titleTemplate_
	}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.letterUiList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexLetterItem), arg_5_0.mailListGo_, MailBoxListItem)
	arg_5_0.rewardUiList_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexRewardItem), arg_5_0.rewardListGo_, MailBoxRewardItem)
	arg_5_0.allReceiveCon_ = arg_5_0.conExCollection_:GetController("Receive_All")
	arg_5_0.emptyController_ = arg_5_0.conExCollection_:GetController("empty")
	arg_5_0.rewardController_ = arg_5_0.conExCollection_:GetController("reward")
	arg_5_0.starController_ = ControllerUtil.GetController(arg_5_0.starBtn_.transform, "star")
	arg_5_0.modeController_ = arg_5_0.conExCollection_:GetController("mode")
	arg_5_0.mailTypeController_ = arg_5_0.tabConExCollection:GetController("mailType")
	arg_5_0.collectStateController_ = arg_5_0.conExCollection_:GetController("collectState")
	arg_5_0.showDelStateController_ = arg_5_0.conExCollection_:GetController("showDelAll")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.delBtn_, nil, function()
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
	arg_6_0:AddBtnListener(arg_6_0.letterBtn_, nil, function()
		JumpTools.GoToSystem("/letterBox")
	end)
	arg_6_0:AddBtnListener(arg_6_0.allReceiveBtn_, nil, function()
		if MailData.GetTotal() == 0 then
			ShowTips("ERROR_NO_MAIL_CAN_RECEIVE")

			return
		end

		MailAction.ReceiveAllMails()
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		if arg_6_0:GetMail(arg_6_0.curMailId_).attach_flag == 2 then
			return
		end

		arg_6_0:OnClickReceiveBtn()
	end)
	arg_6_0:AddBtnListener(arg_6_0.removeBtn_, nil, function()
		if arg_6_0:GetMail(arg_6_0.curMailId_).attach_flag == 1 then
			return
		end

		arg_6_0:OnClickDeleteBtn()
	end)
	arg_6_0:AddBtnListener(arg_6_0.dlcBtn_, nil, function()
		arg_6_0:OnClickGotoPurchase()
	end)
	arg_6_0:AddBtnListener(arg_6_0.noramlTabBtn_, nil, function()
		arg_6_0:ChangeMailShowType(MailData.mailType.normal)
	end)
	arg_6_0:AddBtnListener(arg_6_0.collectTabBtn_, nil, function()
		arg_6_0:ChangeMailShowType(MailData.mailType.collect)
	end)
	arg_6_0:AddBtnListener(arg_6_0.collectBtn_, nil, function()
		arg_6_0:OnCollectBtn()
	end)
end

function var_0_0.ChangeMailShowType(arg_18_0, arg_18_1)
	if arg_18_1 == arg_18_0.useMailType then
		return
	end

	arg_18_0.curIndex_ = nil
	arg_18_0.curMailId_ = nil
	arg_18_0.useMailType = arg_18_1

	arg_18_0.mailTypeController_:SetSelectedState(arg_18_0.useMailType == MailData.mailType.normal and "normal" or "collect")
	arg_18_0:RefreshUI()
end

function var_0_0.OnCollectBtn(arg_19_0)
	local var_19_0 = MailData.GetCollectMail(arg_19_0.curMailId_)
	local var_19_1 = MailData.GetMail(arg_19_0.curMailId_)

	if var_19_0 then
		if not arg_19_0.SkipCollectRemoveTips_ and not var_19_1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("REMOVE_COLLECT_MAIL_TIPS"),
				OkCallback = function()
					_G.SkipTip.SkipCollectRemoveTips_ = arg_19_0.SkipCollectRemoveTips_

					MailAction.SetMailCollect(arg_19_0.curMailId_, 0)
				end,
				ToggleCallback = function(arg_21_0)
					arg_19_0.SkipCollectRemoveTips_ = arg_21_0
				end
			})
		else
			MailAction.SetMailCollect(arg_19_0.curMailId_, 0)
		end
	elseif GameSetting.max_collect_mail_count.value[1] <= MailData.GetCollectTotal() then
		ShowTips("ADD_COLLECT_MAIL_MAX_TIPS")
	else
		MailAction.SetMailCollect(arg_19_0.curMailId_, 1)
	end
end

function var_0_0.AddEventListener(arg_22_0)
	arg_22_0:RegistEventListener(MAIL_BRIEF_UPDATE, handler(arg_22_0, arg_22_0.OnBriefUpdate))
	arg_22_0:RegistEventListener(MAIL_LIST_UPDATE, handler(arg_22_0, arg_22_0.OnMailListUpdate))
	arg_22_0:RegistEventListener(MAIL_INFO_UPDATE, handler(arg_22_0, arg_22_0.OnMailInfoUpdate))
	arg_22_0:RegistEventListener(MAIL_STAR_UPDATE, handler(arg_22_0, arg_22_0.OnMailStarUpdate))
	arg_22_0:RegistEventListener(MAIL_COLLECT_UPDATE, handler(arg_22_0, arg_22_0.OnMailCollectUpdate))
end

function var_0_0.IndexRewardItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:GetMail(arg_23_0.curMailId_)

	arg_23_2:SetRewardData(var_23_0.rewardList[arg_23_1], var_23_0.attach_flag == 2)
end

function var_0_0.IndexLetterItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:GetMailSortedList()[arg_24_1]
	local var_24_1 = arg_24_0:GetMail(var_24_0)

	arg_24_2:SetMailData(var_24_1, arg_24_0.useMailType)
	arg_24_2:SetClickHandler(function()
		arg_24_0:OnClickLetter(arg_24_1, arg_24_2)
	end)

	if arg_24_0.curMailId_ then
		if arg_24_0.curMailId_ == var_24_0 then
			arg_24_2:SetSelected(true)
		else
			arg_24_2:SetSelected(false)
		end
	elseif arg_24_1 == 1 then
		arg_24_0:SelectItem(1)
	end

	arg_24_2:UpdateView()
end

function var_0_0.OnEnter(arg_26_0)
	MailAction.SortMailManual()
	arg_26_0:AddEventListener()
	manager.redPoint:bindUIandKey(arg_26_0.letterTrans_, RedPointConst.LETTER_UNREAD)

	if arg_26_0.useMailType ~= MailData.mailType.normal then
		arg_26_0:ChangeMailShowType(MailData.mailType.normal)
	else
		arg_26_0:RefreshUI()
	end

	arg_26_0:StartTimer()
end

function var_0_0.OnTop(arg_27_0)
	arg_27_0:ShowDefaultBar()
end

function var_0_0.OnExit(arg_28_0)
	manager.windowBar:HideBar()
	arg_28_0:RemoveAllEventListener()
	arg_28_0:RemoveTimer()
	manager.redPoint:unbindUIandKey(arg_28_0.letterTrans_)
	arg_28_0:SelectItem(nil)
end

function var_0_0.RefreshUI(arg_29_0)
	arg_29_0:UpdateList(true)
	arg_29_0:RefreshLeftUI()
end

function var_0_0.OnMailInfoUpdate(arg_30_0, arg_30_1)
	if arg_30_0.curMailId_ ~= nil and arg_30_1.id == arg_30_0.curMailId_ then
		arg_30_0:RefreshLetterUI(arg_30_1.id, true)
	end
end

function var_0_0.OnMailStarUpdate(arg_31_0, arg_31_1)
	if arg_31_1.id == arg_31_0.curMailId_ then
		arg_31_0:RefreshStarUI()

		if arg_31_1.star_state == 1 then
			arg_31_0:UpdateList(false)
		end
	end
end

function var_0_0.OnMailCollectUpdate(arg_32_0, arg_32_1)
	local var_32_0 = GameSetting.max_collect_mail_count.value[1]

	arg_32_0.collectnumText_.text = string.format("%d/%d", MailData.GetCollectTotal(), var_32_0)

	if arg_32_1 == arg_32_0.curMailId_ then
		arg_32_0:RefreshCollectUI()
	end

	if arg_32_0.useMailType == MailData.mailType.collect then
		arg_32_0:UpdateList()
	end
end

function var_0_0.OnBriefUpdate(arg_33_0)
	arg_33_0:RefreshLeftUI()
end

function var_0_0.OnMailListUpdate(arg_34_0)
	MailData.GetMailListFromServer(handler(arg_34_0, function()
		MailAction.SortMailManual()
		arg_34_0:UpdateList()
		arg_34_0:RefreshLeftUI()
	end))
end

function var_0_0.DeleteCurrentMail(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1 or arg_36_0.curMailId_

	if var_36_0 == nil then
		return
	end

	if table.indexof(arg_36_0:GetMailSortedList(), var_36_0) == false then
		return
	end

	MailAction.DeleteOneMail(var_36_0)
end

function var_0_0.SelectItem(arg_37_0, arg_37_1)
	if arg_37_1 == nil then
		arg_37_0.curIndex_ = nil
		arg_37_0.curMailId_ = nil

		if arg_37_0.curLetterItem_ then
			arg_37_0.curLetterItem_:SetSelected(false)
			arg_37_0.curLetterItem_:UpdateView()

			arg_37_0.curLetterItem_ = nil
		end

		return
	end

	local var_37_0 = arg_37_0:GetMailSortedList()[arg_37_1]

	if var_37_0 == nil or var_37_0 == 0 then
		return
	end

	if arg_37_0.curLetterItem_ then
		arg_37_0.curLetterItem_:SetSelected(false)
		arg_37_0.curLetterItem_:UpdateView()
	end

	local var_37_1 = arg_37_0.letterUiList_:GetItemByIndex(arg_37_1)

	arg_37_0.curIndex_ = arg_37_1
	arg_37_0.curMailId_ = var_37_0
	arg_37_0.curLetterItem_ = var_37_1

	var_37_1:SetSelected(true)
	MailAction.ReadMail(var_37_0)
	arg_37_0:RefreshLetterUI(var_37_0)
end

function var_0_0.OnClickLetter(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:SelectItem(arg_38_1)
end

function var_0_0.OnClickDeleteBtn(arg_39_0)
	local var_39_0 = arg_39_0.curMailId_

	if var_39_0 ~= nil and var_39_0 ~= 0 then
		if arg_39_0:GetMail(var_39_0).star_state == 1 then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = string.format(GetTips("MAIL_STAR_DELETE_TIP")),
				OkCallback = function()
					arg_39_0:DeleteCurrentMail(var_39_0)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			arg_39_0:DeleteCurrentMail()
		end
	end
end

function var_0_0.OnClickReceiveBtn(arg_42_0)
	MailAction.TryToGetMailAttachment(arg_42_0.curMailId_)
end

function var_0_0.OnClickGotoPurchase(arg_43_0)
	local var_43_0 = arg_43_0:GetMail(arg_43_0.curMailId_)

	if var_43_0 and MailTools.CheckIsPurchaseTemplate(var_43_0.mail_template_id) then
		if var_43_0.mail_template_id == MailConst.MAIL_ID_CONST.SKIN_DLC_EXPIRE and var_43_0.link_param[1] and var_43_0.link_param[2] and var_43_0.link_param[3] then
			ShopTools.JumpToSkinShop(var_43_0.link_param[2], true, var_43_0.link_param[1], var_43_0.link_param[3])
		elseif var_43_0.mail_template_id == MailConst.MAIL_ID_CONST.SKIN_EXPIRE and var_43_0.link_param[1] then
			ShopTools.JumpToSkinShop(var_43_0.link_param[1], false)
		end
	end
end

function var_0_0.RefreshLetterUI(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0:GetMail(arg_44_1)
	local var_44_1 = MailData.GetMailTitle(arg_44_1, arg_44_0.useMailType)
	local var_44_2 = GameSetting.admin_mail_title_max_len.value[1]

	arg_44_0.titleText_.text = utf8.sub(var_44_1, 1, var_44_2 + 1)
	arg_44_0.dateText_.text = manager.time:STimeDescS(var_44_0.date, "!%Y-%m-%d")

	if not arg_44_2 then
		SetActive(arg_44_0.itemParent_.gameObject, false)
		MailData.TryToGetMailDetail(var_44_0.id, arg_44_0.useMailType, handler(arg_44_0, function()
			arg_44_0:UpdateMailContentView(var_44_0)
			TimeTools.StartAfterSeconds(0.1, function()
				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_0.itemParent_.transform)
				SetActive(arg_44_0.itemParent_.gameObject, true)
			end, {})
		end))
	else
		SetActive(arg_44_0.itemParent_.gameObject, true)
	end

	if var_44_0.rewardList then
		arg_44_0.rewardUiList_:StartScroll(#var_44_0.rewardList)
	end

	arg_44_0:RenderRewardState(var_44_0)
end

function var_0_0.RenderRewardState(arg_47_0, arg_47_1)
	if arg_47_0.useMailType == MailData.mailType.collect then
		if MailTools.CheckIsPurchaseTemplate(arg_47_1.mail_template_id) then
			arg_47_0.rewardController_:SetSelectedState("dlc")
		else
			arg_47_0.rewardController_:SetSelectedState("false")
		end

		return
	end

	if MailTools.CheckIsPurchaseTemplate(arg_47_1.mail_template_id) then
		arg_47_0.rewardController_:SetSelectedState("dlc")
		arg_47_0.modeController_:SetSelectedState("delete")

		return
	end

	if arg_47_1.attach_flag == 0 then
		arg_47_0.rewardController_:SetSelectedState("false")
		arg_47_0.modeController_:SetSelectedState("delete")
	elseif arg_47_1.attach_flag == 2 then
		arg_47_0.rewardController_:SetSelectedState("true")
		arg_47_0.modeController_:SetSelectedState("delete")
	else
		arg_47_0.rewardController_:SetSelectedState("true")
		arg_47_0.modeController_:SetSelectedState("reward")
	end
end

function var_0_0.RefreshCollectUI(arg_48_0)
	if MailData.GetCollectMail(arg_48_0.curMailId_) then
		arg_48_0.collectStateController_:SetSelectedState("cancelCollect")
	else
		arg_48_0.collectStateController_:SetSelectedState("canCollect")
	end
end

function var_0_0.RefreshStarUI(arg_49_0)
	if arg_49_0:GetMail(arg_49_0.curMailId_).star_state == 1 then
		arg_49_0.starController_:SetSelectedState("true")
	else
		arg_49_0.starController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshLeftUI(arg_50_0)
	local var_50_0 = GameSetting.max_mail_count.value[1]

	arg_50_0.normalnumText_.text = string.format("%d/%d", MailData.GetTotal(), var_50_0)

	local var_50_1 = GameSetting.max_collect_mail_count.value[1]

	arg_50_0.collectnumText_.text = string.format("%d/%d", MailData.GetCollectTotal(), var_50_1)

	arg_50_0:RefreshAllReceiveUI()
end

function var_0_0.RefreshCountdownUI(arg_51_0)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.letterUiList_:GetItemList()) do
		if iter_51_1 then
			iter_51_1:UpdateCountdown()
		end
	end
end

function var_0_0.RefreshAllReceiveUI(arg_52_0)
	local var_52_0 = arg_52_0:GetMailSortedList()
	local var_52_1 = false

	for iter_52_0, iter_52_1 in pairs(var_52_0) do
		local var_52_2 = arg_52_0:GetMail(iter_52_1)

		if var_52_2 and var_52_2.attach_flag == 1 then
			var_52_1 = true

			break
		end
	end

	arg_52_0.allReceiveCon_:SetSelectedState(var_52_1 and "true" or "false")
end

function var_0_0.UpdateMailContentView(arg_53_0, arg_53_1)
	arg_53_0.senderText_.text = MailData.GetMailSender(arg_53_1.id, arg_53_0.useMailType)

	arg_53_0:RefreshCollectUI()
	arg_53_0:RefreshStarUI()
	arg_53_0:ClearLetterContent()

	local var_53_0 = MailData.GetMailContent(arg_53_1.id, arg_53_0.useMailType)

	for iter_53_0, iter_53_1 in ipairs(var_53_0) do
		arg_53_0:CreateContent(iter_53_1)
	end
end

function var_0_0.CreateContent(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1.content_type
	local var_54_1 = arg_54_0.letterContentClass_[var_54_0]
	local var_54_2 = arg_54_0.letterTemplate_[var_54_0]
	local var_54_3 = Object.Instantiate(var_54_2, arg_54_0.itemParent_.transform)
	local var_54_4 = var_54_1.New(var_54_3)

	var_54_4:SetData(arg_54_1)
	table.insert(arg_54_0.letterContentItems_, var_54_4)
end

function var_0_0.UpdateList(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:GetMailSortedList()
	local var_55_1 = #var_55_0

	arg_55_0.emptyController_:SetSelectedState(var_55_1 <= 0 and "true" or "false")

	if var_55_1 > 0 and arg_55_0.useMailType == MailData.mailType.normal then
		arg_55_0.showDelStateController_:SetSelectedState("show")
	else
		arg_55_0.showDelStateController_:SetSelectedState("hide")
	end

	if var_55_1 <= 0 then
		arg_55_0.letterUiList_:StartScroll(0)
		arg_55_0:SelectItem(nil)
	elseif arg_55_0.curMailId_ then
		local var_55_2 = table.indexof(var_55_0, arg_55_0.curMailId_)

		if var_55_2 then
			arg_55_0.curIndex_ = var_55_2
		else
			arg_55_0.curIndex_ = math.min(arg_55_0.curIndex_, #var_55_0)
		end

		arg_55_0.letterUiList_:StartScroll(#var_55_0, arg_55_0.curIndex_, not arg_55_1)
		arg_55_0:SelectItem(arg_55_0.curIndex_)
	else
		arg_55_0.letterUiList_:StartScroll(#var_55_0)
	end
end

function var_0_0.StartTimer(arg_56_0)
	if not arg_56_0.timer_ then
		arg_56_0.timer_ = Timer.New(function()
			local var_57_0 = MailData.GetTimeoutMailIdList()

			if #var_57_0 > 0 then
				MailData.DeleteMail(var_57_0)
				ShowTips("MAIL_EXPIRED")
			end

			arg_56_0:RefreshCountdownUI()
		end, 1, -1)
	end

	arg_56_0.timer_:Start()
end

function var_0_0.RemoveTimer(arg_58_0)
	if arg_58_0.timer_ then
		arg_58_0.timer_:Stop()

		arg_58_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_59_0)
	if arg_59_0.letterUiList_ then
		arg_59_0.letterUiList_:Dispose()

		arg_59_0.letterUiList_ = nil
	end

	if arg_59_0.rewardUiList_ then
		arg_59_0.rewardUiList_:Dispose()

		arg_59_0.rewardUiList_ = nil
	end

	arg_59_0:ClearLetterContent()

	arg_59_0.letterContentItems_ = nil

	manager.classPool:DisposeOnePool(MailBoxListItem)
	var_0_0.super.Dispose(arg_59_0)
end

function var_0_0.ClearLetterContent(arg_60_0)
	for iter_60_0 = #arg_60_0.letterContentItems_, 1, -1 do
		arg_60_0.letterContentItems_[iter_60_0]:Dispose()

		arg_60_0.letterContentItems_[iter_60_0] = nil
	end
end

function var_0_0.GetMailSortedList(arg_61_0)
	if arg_61_0.useMailType == MailData.mailType.collect then
		return MailData.GetCollectMailSort()
	else
		return MailData.GetMailSort()
	end
end

function var_0_0.GetMail(arg_62_0, arg_62_1)
	if arg_62_0.useMailType == MailData.mailType.collect then
		return MailData.GetCollectMail(arg_62_1)
	else
		return MailData.GetMail(arg_62_1)
	end
end

return var_0_0
