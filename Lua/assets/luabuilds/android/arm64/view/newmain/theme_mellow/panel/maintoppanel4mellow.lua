local var_0_0 = class("MainTopPanel4Mellow", import("...base.MainBasePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainPlayerInfoBtn4Mellow.New(arg_1_0._tf, arg_1_0.event),
		MainMailBtn.New(findTF(arg_1_0._tf, "btns/mail"), arg_1_0.event),
		MainNoticeBtn.New(findTF(arg_1_0._tf, "btns/noti"), arg_1_0.event),
		MainSettingsBtn.New(findTF(arg_1_0._tf, "btns/settings"), arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(0, 1)
end

return var_0_0
