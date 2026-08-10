local var_0_0 = class("MailBoxListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.starController_ = arg_3_0.conExCollection_:GetController("star")
	arg_3_0.readController_ = arg_3_0.conExCollection_:GetController("read")
	arg_3_0.rewardController_ = arg_3_0.conExCollection_:GetController("reward")
	arg_3_0.selectController_ = arg_3_0.conExCollection_:GetController("select")
	arg_3_0.typeController_ = arg_3_0.conExCollection_:GetController("type")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.onClickHandler_ ~= nil then
			arg_4_0.onClickHandler_(arg_4_0)
		end
	end)
end

function var_0_0.AddEventListener(arg_6_0)
	arg_6_0:RegistEventListener(MAIL_INFO_UPDATE, handler(arg_6_0, arg_6_0.OnMailInfoUpdate))
	arg_6_0:RegistEventListener(MAIL_STAR_UPDATE, handler(arg_6_0, arg_6_0.OnMailStarUpdate))
end

function var_0_0.OnMailInfoUpdate(arg_7_0, arg_7_1)
	if arg_7_1.id == arg_7_0.data_.id then
		arg_7_0:UpdateView()
	end
end

function var_0_0.OnMailStarUpdate(arg_8_0, arg_8_1)
	if arg_8_1.id == arg_8_0.data_.id then
		arg_8_0:UpdateStar()
	end
end

function var_0_0.UpdateBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.SetMailData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.data_ = arg_10_1
	arg_10_0.mailType = arg_10_2
end

function var_0_0.SetClickHandler(arg_11_0, arg_11_1)
	arg_11_0.onClickHandler_ = arg_11_1
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0

	if arg_12_0.mailType == MailData.mailType.normal then
		var_12_0 = MailData.GetMail(arg_12_0.data_.id)
	else
		var_12_0 = MailData.GetCollectMail(arg_12_0.data_.id)
	end

	if var_12_0 == nil then
		return
	end

	local var_12_1 = MailData.GetMailTitle(arg_12_0.data_.id, arg_12_0.mailType)
	local var_12_2 = GameSetting.admin_mail_title_max_len.value[1]

	arg_12_0.nameText_.text = utf8.sub(var_12_1, 1, var_12_2 + 1)

	local var_12_3 = arg_12_0.data_.attach_flag and arg_12_0.data_.attach_flag > 0

	arg_12_0.rewardController_:SetSelectedState(var_12_3 and "true" or "false")

	if arg_12_0.data_.attach_flag == 2 then
		arg_12_0.rewardController_:SetSelectedState("false")
	else
		arg_12_0.rewardController_:SetSelectedState(var_12_3 and "true" or "false")
	end

	arg_12_0:UpdateRead()
	arg_12_0:UpdateStar()
	arg_12_0:UpdateCountdown()
	arg_12_0.selectController_:SetSelectedState(arg_12_0.selected_ and "true" or "false")
	arg_12_0.typeController_:SetSelectedState(arg_12_0.mailType == MailData.mailType.normal and "normal" or "collect")
end

function var_0_0.UpdateStar(arg_13_0)
	if arg_13_0.data_.star_state == 1 then
		arg_13_0.starController_:SetSelectedState("true")
	else
		arg_13_0.starController_:SetSelectedState("false")
	end
end

function var_0_0.UpdateRead(arg_14_0)
	if arg_14_0.mailType == MailData.mailType.collect then
		arg_14_0.readController_:SetSelectedState("false")
	elseif arg_14_0.selected_ then
		arg_14_0.readController_:SetSelectedState("false")
	elseif MailData.HaveMailRead(arg_14_0.data_.id) then
		arg_14_0.readController_:SetSelectedState("true")
	else
		arg_14_0.readController_:SetSelectedState("false")
	end
end

function var_0_0.SetSelected(arg_15_0, arg_15_1)
	arg_15_0.selected_ = arg_15_1
end

function var_0_0.UpdateCountdown(arg_16_0)
	if not arg_16_0.data_.timeout_timestamp then
		return
	end

	local var_16_0 = MailTools.GetLostTimeStr(arg_16_0.data_.timeout_timestamp)

	arg_16_0.tipsText_.text = string.format(GetTips("TIME_DISPLAY_5"), var_16_0)
end

function var_0_0.GetData(arg_17_0)
	return arg_17_0.data_
end

function var_0_0.OnEnter(arg_18_0)
	return
end

function var_0_0.OnExit(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveAllListeners()
	arg_20_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
