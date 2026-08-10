local var_0_0 = class("ChapterSelectChapterToggleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.isCompleteController_ = arg_1_0.controllerEx_:GetController("isComplete")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.chapterClientID_ = arg_2_1

	local var_2_0 = ChapterClientCfg[arg_2_1]

	if var_2_0.toggle == BattleConst.TOGGLE.PLOT then
		arg_2_0.nameText_.text = var_2_0.desc
	else
		arg_2_0.nameText_.text = var_2_0.name
	end

	local var_2_1 = ChapterTools.GetChapterClientFinishPercentage(arg_2_1)

	arg_2_0.percentageText_.text = string.format("%s%%", math.floor(var_2_1 * 100))

	arg_2_0.isCompleteController_:SetSelectedState(tostring(var_2_1 == 1))

	local var_2_2 = var_2_0.chapter_list[1]

	arg_2_0.isLock_ = not ChapterTools.IsFinishPreChapter(var_2_2)

	arg_2_0.lockController_:SetSelectedState(tostring(arg_2_0.isLock_))
	arg_2_0.selectController_:SetSelectedState(tostring(arg_2_2))
	arg_2_0.transform_:SetAsLastSibling()
	arg_2_0:Show(true)
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = arg_4_0.chapterClientID_
		local var_5_1 = BattleFieldData:GetCacheChapter(var_5_0)
		local var_5_2 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)

		if ChapterClientCfg[var_5_2].id ~= var_5_0 then
			BattleFieldAction.ChangeSelectChapterID(var_5_1)

			return
		end
	end)
end

function var_0_0.GetLocalPosition(arg_6_0)
	return arg_6_0.transform_.localPosition
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
