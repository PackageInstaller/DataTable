local var_0_0 = class("ChatFriendsTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectStateController_ = arg_3_0.itemControllerEx_:GetController("selectState")
	arg_3_0.onlineStateController_ = arg_3_0.itemControllerEx_:GetController("onlineState")
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.commonHead_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.itemBtn_, nil, function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end
	end)
	arg_4_0.commonPortrait_:RegisteClickCallback(function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.friendID_ = arg_7_1
	arg_7_0.index_ = arg_7_2
	arg_7_0.click_ = arg_7_4

	arg_7_0:SetSelectState(arg_7_1 == arg_7_3)

	if arg_7_1 == USER_ID then
		local var_7_0 = PlayerData:GetPlayerInfo()

		arg_7_0.nickText_.text = GetI18NText(var_7_0.nick)

		arg_7_0.commonPortrait_:RenderHead(var_7_0.portrait)
		arg_7_0.commonPortrait_:RenderFrame(var_7_0.icon_frame)
	else
		local var_7_1 = FriendsData:GetInfoByID(arg_7_1)

		if var_7_1 == false then
			print("unfind friend data", arg_7_1)
			arg_7_0:Show(false)

			return
		end

		arg_7_0.nickText_.text = GetI18NText(var_7_1.nick)

		arg_7_0.commonPortrait_:RenderHead(var_7_1.icon)
		arg_7_0.commonPortrait_:RenderFrame(var_7_1.icon_frame)
		arg_7_0.onlineStateController_:SetSelectedState(var_7_1.online_state == 0 and "on" or "off")
	end
end

function var_0_0.SetSelectState(arg_8_0, arg_8_1)
	arg_8_0.selectStateController_:SetSelectedState(arg_8_1 and "select" or "cancel")
	arg_8_0:RefreshRedPoint(arg_8_1)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.RefreshRedPoint(arg_10_0, arg_10_1)
	local var_10_0 = ChatFriendData:GetUnreadMsgCnt(arg_10_0.friendID_)

	if var_10_0 <= 0 or arg_10_1 then
		SetActive(arg_10_0.goNotice_, false)
	else
		SetActive(arg_10_0.goNotice_, true)

		arg_10_0.textNoticeCnt_.text = var_10_0
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
