local var_0_0 = class("HeartLinkItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_1.transform.parent.transform)
	arg_1_0.transform_ = arg_1_1.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.canRead_ = false
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_0.RegisterRefresh(arg_4_0, arg_4_1)
	arg_4_0.RefreshParentLayout_ = arg_4_1
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.unlockbtnBtn_, nil, function()
		arg_5_0:SetUnlockState(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.itemTrs_)
		arg_5_0.RefreshParentLayout_(arg_5_0.ID_)
		SDKTools.SendMessageToSDK("record_unlock", {
			record_id = arg_5_0.archiveID_,
			chain_id = arg_5_0.ID_
		})

		if arg_5_0.canRead_ then
			HeroAction.ReadHeartLink(arg_5_0.archiveID_, arg_5_0.ID_)

			arg_5_0.canRead_ = false
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.archiveID_ = arg_7_1
	arg_7_0.ID_ = arg_7_2.id

	local var_7_0
	local var_7_1
	local var_7_2
	local var_7_3 = arg_7_2.isUnlock
	local var_7_4 = arg_7_2.current
	local var_7_5 = arg_7_2.all
	local var_7_6 = GameSetting.heart_chain_unlock_condition.value[arg_7_0.ID_]
	local var_7_7 = ConditionCfg[var_7_6]

	if not var_7_3 then
		arg_7_0.controller_:SetSelectedState("lock")

		arg_7_0.locktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), arg_7_0.ID_)
		arg_7_0.textconditionText_.text = GetI18NText(var_7_7.desc)
	else
		arg_7_0:SetUnlockState()

		local var_7_8 = HeroRecordCfg[arg_7_0.archiveID_]

		arg_7_0.locktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), arg_7_0.ID_)
		arg_7_0.unlocktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), arg_7_0.ID_)
		arg_7_0.textinfoText_.text = var_7_8["heart_chain" .. arg_7_0.ID_]
	end

	arg_7_0.canRead_ = not ArchiveData:IsHeartRead(arg_7_0.archiveID_, arg_7_0.ID_) and var_7_3
end

function var_0_0.SetUnlockState(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or ArchiveData:IsHeartRead(arg_8_0.archiveID_, arg_8_0.ID_)

	if arg_8_1 then
		arg_8_0.controller_:SetSelectedState("unlock_open")
	else
		arg_8_0.controller_:SetSelectedState("unlock_close")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.itemTrs_)
	arg_8_0.RefreshParentLayout_()
end

function var_0_0.Hide(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
