local var_0_0 = class("ShareLogoView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.gameObject_)

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
	arg_1_0.logoController = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "logo")
end

function var_0_0.ShowLogo(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if not arg_2_1 then
		var_2_0 = {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 0,
			cardPos = 1,
			cardShow = true
		}
	else
		var_2_0 = arg_2_1
	end

	SetActive(arg_2_0.goCardPanel_, var_2_0.cardShow)
	arg_2_0.transformLogo_:SetParent(arg_2_0.logoParent_[var_2_0.logoPos], false)
	arg_2_0.logoController:SetSelectedIndex(GameToSDK.CURRENT_SERVER == "kr" and 1 or 0)

	if var_2_0.cardShow then
		arg_2_0.transformCard_:SetParent(arg_2_0.cardParent_[var_2_0.cardPos], false)

		local var_2_1 = PlayerData:GetPlayerInfo()

		arg_2_0.textNick_.text = var_2_1.nick

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

	SetActive(arg_2_0.gameObject_, true)
end

function var_0_0.HideLogo(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
