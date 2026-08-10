local var_0_0 = class("IdolTraineeChapterListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if not arg_3_0.closeClick then
			JumpTools.OpenPageByJump("/idolTraineeLevelMainView", {
				chapterID = arg_3_0.chapterID_
			})
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.chapterID_ = arg_5_1
	arg_5_0.closeClick = arg_5_2

	local var_5_0 = IdolTraineeChapterCfg[arg_5_1]
	local var_5_1, var_5_2 = IdolTraineeTools:GetChapterProgress(arg_5_1)

	arg_5_0.progress_.text = string.format("%s/%s", var_5_1, var_5_2)
	arg_5_0.name_.text = var_5_0.title
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
