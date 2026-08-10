local var_0_0 = class("ChapterPlotDayView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parentView_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.dayItemList_ = {}
	arg_1_0.dayController_ = arg_1_0.controllerEx_:GetController("dayList")
	arg_1_0.guildController_ = arg_1_0.controllerEx_:GetController("guildState")
	arg_1_0.dayImageController_ = arg_1_0.dayControllerEx_:GetController("default0")
	arg_1_0.isExpandDay_ = false
end

function var_0_0.OnEnter(arg_2_0)
	if ChapterTools.IsNeedExpandDay(arg_2_0.chapterID_) then
		arg_2_0.isExpandDay_ = true

		arg_2_0:SwitchUI()
	end
end

function var_0_0.OnUpdate(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0.isExpandDay_ = false
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.dayItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.dayItemList_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.dayBtn_, nil, function()
		if not arg_6_0.parentView_:IsTop() then
			JumpTools:Back()

			return
		end

		arg_6_0.isExpandDay_ = true

		arg_6_0:SwitchUI()
	end)
	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		arg_6_0.isExpandDay_ = false

		arg_6_0:SwitchUI()
		manager.notify:Invoke(CHAPTER_CLOSE_DAY_LIST)
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.selectDay_ = arg_9_1
	arg_9_0.chapterID_ = arg_9_2

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_10_0.chapterID_][arg_10_0.selectDay_][1]
	local var_10_1 = ChapterMapCfg[var_10_0]

	if var_10_1.icon_id ~= "" then
		arg_10_0.dayImage_.sprite = getSprite("Atlas/OperationAtlas", var_10_1.icon_id)

		arg_10_0.dayImageController_:SetSelectedState("image")
	else
		arg_10_0.selectDayText_.text = arg_10_0.selectDay_

		arg_10_0.dayImageController_:SetSelectedState("num")
	end

	if var_10_1.name ~= "" then
		arg_10_0.dayBottomText_.text = var_10_1.name
	else
		arg_10_0.dayBottomText_.text = GetTips("DATE")
	end

	arg_10_0:SwitchUI()
	arg_10_0:RefreshDayItemList()
end

function var_0_0.SwitchUI(arg_11_0)
	arg_11_0.dayController_:SetSelectedState(tostring(arg_11_0.isExpandDay_))

	if arg_11_0.isExpandDay_ then
		arg_11_0.animator_:Play("dayList1")
	else
		arg_11_0.animator_:Play("dayList2")
	end

	if ChapterTools.IsNeedExpandDay(arg_11_0.chapterID_) then
		arg_11_0.guildController_:SetSelectedState(tostring(true))
	else
		arg_11_0.guildController_:SetSelectedState(tostring(false))
	end
end

function var_0_0.RefreshDayItemList(arg_12_0)
	local var_12_0 = ChapterTools.GetChapterDayList(arg_12_0.chapterID_)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if arg_12_0.dayItemList_[iter_12_1] == nil then
			arg_12_0.dayItemList_[iter_12_1] = ChapterPlotDayItem.New(arg_12_0.dayItem_, arg_12_0.dayParent_, arg_12_0.chapterID_, iter_12_1)
		end

		arg_12_0.dayItemList_[iter_12_1]:SetData(iter_12_1, arg_12_0.selectDay_)
	end
end

return var_0_0
