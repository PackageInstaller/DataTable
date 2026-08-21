local var_0_0 = class("VoteAwardPtWindow", import("view.activity.Panels.PtAwardWindow"))

var_0_0.TYPE_CURR = 1
var_0_0.TYPE_ACC = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.binder = arg_1_2
	arg_1_0.scrollPanel = arg_1_0._tf:Find("frame/panel")
	arg_1_0.UIlist = UIItemList.New(arg_1_0._tf:Find("frame/panel/list"), arg_1_0._tf:Find("frame/panel/list/tpl"))
	arg_1_0.ptTF = arg_1_0._tf:Find("frame/pt")
	arg_1_0.totalTxt = arg_1_0._tf:Find("frame/pt/Text"):GetComponent(typeof(Text))
	arg_1_0.totalTitleTxt = arg_1_0._tf:Find("frame/pt/title"):GetComponent(typeof(Text))

	return
end

function var_0_0.UpdateTitle(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_0.TYPE_CURR then
		arg_2_0.resTitle, arg_2_0.cntTitle = i18n("vote_lable_curr_title_1"), i18n("vote_lable_curr_title_2")
	elseif arg_2_1 == var_0_0.TYPE_ACC then
		arg_2_0.resTitle, arg_2_0.cntTitle = i18n("vote_lable_acc_title_1"), i18n("vote_lable_acc_title_2")
	end

	return
end

function var_0_0.updateResIcon(arg_3_0)
	return
end

return var_0_0
