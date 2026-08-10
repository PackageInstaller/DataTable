local var_0_0 = class("ChapterMapToggleView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnExit(arg_2_0)
	return
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		local var_5_0 = ChapterMainPlotToggleCfg[arg_4_0.id_]

		if table.keyof(var_5_0.chapter_client_list, arg_4_0.selectChapterClientID_) then
			return
		end

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_5_0.chapter_client_list[1])
		manager.notify:Invoke(CHANGE_PLOT_SELECT_CHAPTER)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id_ = arg_6_1

	arg_6_0:RefreshUI()
	arg_6_0:Show(true)
end

function var_0_0.SetSelectID(arg_7_0, arg_7_1)
	arg_7_0.selectChapterClientID_ = arg_7_1

	local var_7_0 = ChapterMainPlotToggleCfg[arg_7_0.id_]

	if table.keyof(var_7_0.chapter_client_list, arg_7_1) then
		arg_7_0.controller_:SetSelectedState("yes")
	else
		arg_7_0.controller_:SetSelectedState("no")
	end
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = ChapterMainPlotToggleCfg[arg_8_0.id_]

	arg_8_0.text_.text = var_8_0.name
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.GetTransform(arg_10_0)
	return arg_10_0.transform_
end

return var_0_0
