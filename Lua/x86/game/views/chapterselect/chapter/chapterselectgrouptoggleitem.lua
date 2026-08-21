local var_0_0 = class("ChapterSelectGroupToggleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.finishAllController_ = arg_1_0.controllerEx_:GetController("finishAll")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.groupID_ = arg_2_1

	local var_2_0 = ChapterMainPlotToggleCfg[arg_2_1]

	arg_2_0.nameText_.text = var_2_0.name

	arg_2_0.finishAllController_:SetSelectedState(tostring(arg_2_0:IsCollectAllStar()))
	arg_2_0.transform_:SetAsLastSibling()
	arg_2_0:Show(true)
end

function var_0_0.IsCollectAllStar(arg_3_0)
	local var_3_0 = ChapterMainPlotToggleCfg[arg_3_0.groupID_]

	for iter_3_0, iter_3_1 in ipairs(var_3_0.chapter_client_list) do
		if ChapterTools.GetChapterClientFinishPercentage(iter_3_1) ~= 1 then
			return false
		end
	end

	return true
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		local var_6_0 = ChapterMainPlotToggleCfg[arg_5_0.groupID_].chapter_client_list[1]
		local var_6_1 = ChapterClientCfg[var_6_0].chapter_list[1]

		BattleFieldAction.ChangeSelectChapterID(var_6_1)
	end)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
