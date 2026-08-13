class = var_0_10000

local var_0_0 = "VoteAwardPtWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Panels.PtAwardWindow"))

var_0_1.TYPE_CURR = 1
var_0_1.TYPE_ACC = 2

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.binder = arg_1_2

	local var_1_0 = arg_1_0._tf

	arg_1_0.scrollPanel = var_3.Find(var_1_0, "frame/panel")
	UIItemList = var_3

	local var_1_1 = var_3.New
	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_4.Find(var_1_2, "frame/panel/list")
	local var_1_4 = arg_1_0._tf

	arg_1_0.UIlist = var_1_1(var_1_3, var_5.Find(var_1_4, "frame/panel/list/tpl"))

	local var_1_5 = arg_1_0._tf

	arg_1_0.ptTF = var_3.Find(var_1_5, "frame/pt")

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "frame/pt/Text")
	local var_1_8 = var_3.GetComponent

	typeof = var_5
	Text = var_1_4
	arg_1_0.totalTxt = var_1_8(var_1_7, var_5(var_1_4))

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_3.Find(var_1_9, "frame/pt/title")
	local var_1_11 = var_3.GetComponent

	typeof = var_5
	Text = var_1_4
	arg_1_0.totalTitleTxt = var_1_11(var_1_10, var_5(var_1_4))

	return
end

function var_0_1.UpdateTitle(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1.TYPE_CURR then
		i18n = var_2

		local var_2_0 = var_2("vote_lable_curr_title_1")

		i18n = var_3
		arg_2_0.cntTitle = var_3("vote_lable_curr_title_2")
		arg_2_0.resTitle = var_2_0
	elseif arg_2_1 == var_0_1.TYPE_ACC then
		i18n = var_2

		local var_2_1 = var_2("vote_lable_acc_title_1")

		i18n = var_3
		arg_2_0.cntTitle = var_3("vote_lable_acc_title_2")
		arg_2_0.resTitle = var_2_1
	end

	return
end

function var_0_1.updateResIcon(arg_3_0)
	return
end

return var_0_1
