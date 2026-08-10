local var_0_0 = class("MomoTalkCharactorListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectController_ = arg_2_0.controllerEx_:GetController("select")

	arg_2_0:InitNoticeColor()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.itemBtn_, nil, function()
		if arg_3_0.isSelected_ then
			arg_3_0:SetSelected(false)
			manager.notify:Invoke(MOMOTALK_BACK_TO_LIST)

			return
		end

		arg_3_0:SetSelected(true)
		manager.notify:Invoke(MOMOTALK_OPEN_CHAT, arg_3_0.senderID_, arg_3_0.sessionID_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.senderID_ = arg_5_1.sender_id

	local var_5_0 = MomoTalkTools.GetDisplaySession(arg_5_1.chat_Data, arg_5_0.senderID_)

	arg_5_0.sessionID_ = var_5_0 and var_5_0.id or 0
	arg_5_0.isSelected_ = arg_5_0.senderID_ == arg_5_2

	arg_5_0:RefreshUI(arg_5_1, var_5_0)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.sender_id
	local var_6_1 = ChatHeroCfg[var_6_0]

	if arg_6_0.headIcon_ and var_6_1 then
		arg_6_0.headIcon_.sprite = MomoTalkTools.GetHeroIcon(var_6_1.icon)
	end

	if arg_6_0.nameText_ and var_6_1 then
		arg_6_0.nameText_.text = GetI18NText(var_6_1.name)
	end

	if arg_6_0.descText_ then
		arg_6_0.descText_.text = arg_6_0:GetSessionLastPreview(arg_6_2)
	end

	arg_6_0:SetSelected(arg_6_0.isSelected_)

	local var_6_2, var_6_3 = arg_6_0:GetUnreadCounts(arg_6_1.chat_Data)

	if arg_6_0.redDotGo_ then
		local var_6_4 = var_6_2 > 0 or var_6_3 > 0

		SetActive(arg_6_0.redDotGo_, var_6_4)
		arg_6_0:RefreshUnreadCount(var_6_2 > 0 and var_6_2 or var_6_3, var_6_2 == 0 and var_6_3 > 0)
	end
end

function var_0_0.GetUnreadCounts(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_1 or {}) do
		if MomoTalkData:IsActiveUnreadSession(iter_7_1, iter_7_0) then
			var_7_0 = var_7_0 + 1
		elseif MomoTalkData:IsNoRemindSession(iter_7_1, iter_7_0) then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_0, var_7_1
end

function var_0_0.GetSessionLastPreview(arg_8_0, arg_8_1)
	local var_8_0 = MomoTalkTools.GetSessionPreviewContent(arg_8_1)

	if var_8_0 and var_8_0 ~= "" then
		return var_8_0
	end

	return ""
end

function var_0_0.GetSessionDisplayList(arg_9_0, arg_9_1)
	if not arg_9_1.save_list then
		arg_9_1 = clone(arg_9_1)
		arg_9_1.save_list = {}
	end

	return MomoTalkTools.GetListDataByMessAge(arg_9_1) or {}
end

function var_0_0.GetLastShownItem(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_1[MomoTalkTools.GetShownCountBySessionProgress(arg_10_1, arg_10_2)]
end

function var_0_0.InitNoticeColor(arg_11_0)
	if arg_11_0.redDotGo_ then
		arg_11_0.redDotImg_ = arg_11_0.redDotGo_:GetComponent(typeof(Image))

		if arg_11_0.redDotImg_ then
			arg_11_0.redDotDefaultColor_ = arg_11_0.redDotImg_.color
		end
	end

	if arg_11_0.unReadNumText_ then
		arg_11_0.unReadNumDefaultColor_ = arg_11_0.unReadNumText_.color
	end

	arg_11_0.noRemindColor_ = Color.New(0.55, 0.55, 0.55, 1)
end

function var_0_0.RefreshUnreadCount(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2 and arg_12_0.noRemindColor_ or nil

	if arg_12_0.redDotImg_ then
		arg_12_0.redDotImg_.color = var_12_0 or arg_12_0.redDotDefaultColor_
	end

	if arg_12_0.unReadNumText_ then
		arg_12_0.unReadNumText_.color = var_12_0 or arg_12_0.unReadNumDefaultColor_
		arg_12_0.unReadNumText_.text = arg_12_1 > 0 and tostring(arg_12_1) or ""
	end
end

function var_0_0.SetSelected(arg_13_0, arg_13_1)
	arg_13_0.isSelected_ = arg_13_1

	if arg_13_0.selectController_ then
		arg_13_0.selectController_:SetSelectedState(arg_13_1 and "state1" or "state0")
	end
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
