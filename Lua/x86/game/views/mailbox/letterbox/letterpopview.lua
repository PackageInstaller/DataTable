local var_0_0 = class("LetterPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Mailbox/LetterPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.letterId_ = arg_8_0.params_.letterId

	arg_8_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	local var_9_0 = MailSpecialLetterCfg[arg_9_0.letterId_]

	arg_9_0.titleText_.text = GetI18NText(var_9_0.letter_title)
	arg_9_0.roleImage_.sprite = ItemTools.getItemSprite(var_9_0.letter_belongs)
	arg_9_0.contentText_.text = GetI18NText(var_9_0.letter_desc)
	arg_9_0.nameText_.text = GetI18NText(var_9_0.letter_sender)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
