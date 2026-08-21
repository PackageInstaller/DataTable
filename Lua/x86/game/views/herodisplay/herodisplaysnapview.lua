local var_0_0 = class("HeroDisplaySnapView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.logoParent_ = {
		[0] = arg_1_0.ltLogo_,
		arg_1_0.lbLogo_,
		arg_1_0.rtLogo_,
		arg_1_0.rbLogo_
	}
	arg_1_0.cardParent_ = {
		[0] = arg_1_0.ltCard_,
		arg_1_0.lbCard_,
		arg_1_0.rtCard_,
		arg_1_0.rbCard_
	}
end

function var_0_0.Snap(arg_2_0, arg_2_1, arg_2_2)
	SetActive(arg_2_0.gameObject_, true)

	local var_2_0 = arg_2_2 or HeroDisplayData:GetSetting()

	SetActive(arg_2_0.goCardPanel_, var_2_0.cardShow)
	arg_2_0.transformLogo_:SetParent(arg_2_0.logoParent_[var_2_0.logoPos], false)

	if var_2_0.cardShow then
		arg_2_0.transformCard_:SetParent(arg_2_0.cardParent_[var_2_0.cardPos], false)

		local var_2_1 = PlayerData:GetPlayerInfo()

		arg_2_0.textNick_.text = GetI18NText(var_2_1.nick)

		if var_2_0.cardShowLv then
			arg_2_0.textLv_.text = GetTips("LEVEL") .. var_2_1.userLevel
		else
			arg_2_0.textLv_.text = GetTips("LEVEL") .. "**"
		end

		if var_2_0.cardShowUID then
			arg_2_0.textUID_.text = "UID：" .. USER_ID
		else
			arg_2_0.textUID_.text = "UID：************"
		end
	end

	manager.ui:ShowScreenTap(false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		manager.ui:ShowScreenTap(true)
		SetActive(arg_2_0.gameObject_, false)
		arg_2_1()
	end)
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
