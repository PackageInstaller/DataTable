local var_0_0 = class("OathNamePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathCommon/HeroOathNamePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

local var_0_1 = 16

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()
	arg_4_0:GetOrAddComponent(arg_4_0.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(arg_4_0.nameinput_.gameObject)
	arg_4_0.nameinput_.onValueChanged:AddListener(function(arg_5_0)
		arg_4_0:OnValidateInput(arg_5_0)
	end)
	arg_4_0:SetListener(arg_4_0.nameinput_.onValueChanged)
end

function var_0_0.OnValidateInput(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = textLimit(arg_6_1, var_0_1)

	if not var_6_1 then
		arg_6_0.nameinput_.text = var_6_0
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.cancelBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgmaskBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		arg_7_0:OnClickOkBtn()
	end)
	arg_7_0:AddBtnListener(arg_7_0.deleteBtn_, nil, function()
		arg_7_0.nameinput_.text = ""
	end)
end

function var_0_0.OnClickOkBtn(arg_12_0)
	local var_12_0 = arg_12_0.heroID
	local var_12_1, var_12_2 = OathTools.CheckNickNameCanRename(var_12_0)

	if not var_12_1 then
		ShowTipsF("WEDDING_RENAME_TIPS2", manager.time:GetLostTimeStr2(var_12_2, false, true))

		return
	end

	local var_12_3 = HeroTools.GetHeroName(var_12_0)
	local var_12_4 = HeroCfg[var_12_0].suffix
	local var_12_5 = arg_12_0.nameinput_.text

	if var_12_5 == nil or var_12_5 == "" or var_12_5 == var_12_4 then
		arg_12_0:AskResetName(var_12_4)

		return
	end

	if var_12_3 == var_12_5 then
		ShowTips("DEFINED_SUFFIX_NOTSAME_TIP")

		return
	end

	if not nameRule(var_12_5) then
		ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

		return
	end

	WordVerifyBySDK(var_12_5, function(arg_13_0)
		if not arg_13_0 then
			ShowTips("ERROR_USER_NAME_VER_WORD")
		else
			arg_12_0:AskSetName(var_12_5)
		end
	end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
end

function var_0_0.AskSetName(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = OathTools.GetFormatRenameCooldownTips()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTipsF("WEDDING_RENAME_CONFIRM_TIPS", arg_14_1, var_14_0, var_14_1),
		OkCallback = function()
			OathCollectionContentAction.SetHeroNickName(arg_14_0.heroID, arg_14_1)
		end
	})
end

function var_0_0.AskResetName(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = OathTools.GetFormatRenameCooldownTips()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTipsF("WEDDING_RENAME_DEFAULT_TIPS", arg_16_1, var_16_0, var_16_1),
		OkCallback = function()
			OathCollectionContentAction.SetHeroNickName(arg_16_0.heroID, "")
		end
	})
end

function var_0_0.OnChangeOathNickname(arg_18_0, arg_18_1)
	ShowTips("SUCCESS_CHANGE_NAME")
	JumpTools.Back()
end

function var_0_0.OnEnter(arg_19_0)
	local var_19_0 = arg_19_0.params_.heroID

	arg_19_0.heroID = var_19_0

	arg_19_0:RegistEventListener(OATH_CHANGE_NAME, handler(arg_19_0, arg_19_0.OnChangeOathNickname))

	arg_19_0.nameinput_.text = OathCollectionContentData:GetOathCustomNickName(var_19_0) or ""
	arg_19_0.prevName_.text = HeroCfg[var_19_0].suffix

	local var_19_1, var_19_2 = OathTools.CheckNickNameCanRename(var_19_0)

	if var_19_1 then
		local var_19_3, var_19_4 = OathTools.GetFormatRenameCooldownTips()

		arg_19_0.renameTips_.text = GetTipsF("WEDDING_RENAME_TIPS1", var_19_3, var_19_4)
	else
		arg_19_0.renameTips_.text = GetTipsF("WEDDING_RENAME_TIPS2", manager.time:GetLostTimeStr2(var_19_2, false, true))
	end
end

function var_0_0.OnTop(arg_20_0)
	arg_20_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_21_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
	arg_22_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
	arg_23_0.super.Dispose(arg_23_0)
end

return var_0_0
