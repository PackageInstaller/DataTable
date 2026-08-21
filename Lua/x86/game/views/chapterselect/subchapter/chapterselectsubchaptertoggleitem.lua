local var_0_0 = class("ChapterSelectSubChapterToggleItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.paintImage_.immediate = true

	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.isCompleteController_ = arg_1_0.controllerEx_:GetController("clear")
	arg_1_0.tagController_ = arg_1_0.controllerEx_:GetController("showTag")

	arg_1_0:OnEnter()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	if arg_2_0.chapterClientID_ then
		manager.redPoint:unbindUIandKey(arg_2_0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_2_0.chapterClientID_))
	end

	arg_2_0.chapterClientID_ = arg_2_1

	local var_2_0 = ChapterClientCfg[arg_2_1]
	local var_2_1 = SpritePathCfg.ChapterPaint.path .. var_2_0.chapter_paint

	arg_2_0.paintImage_.spriteAsync = var_2_1

	arg_2_0.tagController_:SetSelectedState(ChapterTools.GetChapterShowTypeData(arg_2_1))
	manager.redPoint:bindUIandKey(arg_2_0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_2_0.chapterClientID_))
	arg_2_0:Show(true)
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	if arg_4_0.chapterClientID_ then
		manager.redPoint:unbindUIandKey(arg_4_0.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_4_0.chapterClientID_))
	end
end

function var_0_0.SetSelect(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.chapterClientID_

	if var_5_0 == nil then
		return
	end

	local var_5_1 = ChapterTools.GetChapterClientFinishPercentage(var_5_0)

	arg_5_0.isCompleteController_:SetSelectedState(tostring(var_5_1 == 1))
	arg_5_0.selectController_:SetSelectedState(tostring(arg_5_1))
	arg_5_0.transform_:SetAsLastSibling()
end

function var_0_0.RefreshLock(arg_6_0)
	local var_6_0 = arg_6_0.chapterClientID_

	if var_6_0 == nil then
		return
	end

	local var_6_1 = ChapterClientCfg[var_6_0].chapter_list[1]

	arg_6_0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(var_6_1)

	arg_6_0.lockController_:SetSelectedState(tostring(arg_6_0.isLock_))
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.paintImage_ = nil

	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btn_, nil, function()
		local var_9_0 = arg_8_0.chapterClientID_
		local var_9_1 = BattleFieldData:GetCacheChapter(var_9_0)
		local var_9_2 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)

		if ChapterClientCfg[var_9_2].id ~= var_9_0 then
			BattleFieldAction.ChangeSelectChapterID(var_9_1)

			return
		end
	end)
end

function var_0_0.SetLocalPosition(arg_10_0, arg_10_1)
	arg_10_0.transform_.localPosition = arg_10_1
end

function var_0_0.GetLocalPosition(arg_11_0)
	return arg_11_0.transform_.localPosition
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.GetChapterClientID(arg_13_0)
	return arg_13_0.chapterClientID_
end

return var_0_0
