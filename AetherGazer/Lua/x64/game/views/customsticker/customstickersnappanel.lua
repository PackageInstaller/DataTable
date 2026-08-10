local var_0_0 = class("CustomStickerSnapPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.Snap(arg_2_0, arg_2_1, arg_2_2)
	SetActive(arg_2_0.gameObject_, true)

	local var_2_0 = PlayerData:GetPlayerInfo()

	arg_2_0.textNick_.text = GetI18NText(var_2_0.nick)
	arg_2_0.textLv_.text = GetTips("LEVEL") .. var_2_0.userLevel
	arg_2_0.textUID_.text = "UID：" .. USER_ID

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
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
