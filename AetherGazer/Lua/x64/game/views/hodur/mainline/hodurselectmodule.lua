local var_0_0 = class("HodurSelectModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.eventController_ = arg_2_0.mainControllerEx_:GetController("Eventcontent")
	arg_2_0.bossController_ = arg_2_0.mainControllerEx_:GetController("BOSS")
	arg_2_0.eventItemList_ = {}

	for iter_2_0 = 1, 2 do
		arg_2_0.eventItemList_[iter_2_0] = HodurSelectEventItem.New(arg_2_0["eventItemGo_" .. iter_2_0])
	end

	arg_2_0.bossItemList_ = {}

	for iter_2_1 = 1, 6 do
		arg_2_0.bossItemList_[iter_2_1] = HodurSelectBossItem.New(arg_2_0["bossItemGo_" .. iter_2_1])
	end

	arg_2_0.selectEventID_ = nil
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.chooseBtn_, nil, function()
		if arg_3_0.type_ == HodurConst.INFO_VIEW_TYPE.STAGE then
			arg_3_0:OnClickStageBtn()
		else
			arg_3_0:OnClickEventBtn()
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.type_ = arg_5_1
	arg_5_0.cfgID_ = arg_5_2
	arg_5_0.chapterID_ = arg_5_3

	if arg_5_0.type_ == HodurConst.INFO_VIEW_TYPE.STAGE then
		arg_5_0.selectEventID_ = nil

		arg_5_0:RefreshStageUI()
	else
		arg_5_0:RefreshEventUI()
	end

	arg_5_0:EndChooseEvent()
end

function var_0_0.RefreshStageUI(arg_6_0)
	arg_6_0.eventController_:SetSelectedState("off")
	arg_6_0.bossController_:SetSelectedState("BOSS")

	local var_6_0 = BattleHodurStageCfg[arg_6_0.cfgID_]

	if var_6_0 then
		arg_6_0.titleText_.text = var_6_0.name
		arg_6_0.descText_.text = var_6_0.tips
	end

	if HodurTools.GetStagePass(arg_6_0.cfgID_, arg_6_0.chapterID_) then
		SetActive(arg_6_0.btnGo_, false)
	else
		SetActive(arg_6_0.btnGo_, true)
	end

	arg_6_0.btnText_.text = GetTips("MATRIX_PREPARE_START_CHALLENGE")

	local var_6_1 = ActivityHodurCfg[arg_6_0.cfgID_]

	arg_6_0.bossImg_.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_6_1.boss_img) or nil

	local var_6_2 = var_6_1.boss_id

	for iter_6_0 = 1, 6 do
		arg_6_0.bossItemList_[iter_6_0]:SetData(var_6_2, iter_6_0)
	end

	arg_6_0.bossScroll_.verticalNormalizedPosition = 1
end

function var_0_0.RefreshEventUI(arg_7_0)
	arg_7_0.eventController_:SetSelectedState("on")
	arg_7_0.bossController_:SetSelectedState("monster")

	local var_7_0 = ActivityHodurEventCfg[arg_7_0.cfgID_]

	if var_7_0 then
		arg_7_0.titleText_.text = var_7_0.event_title
		arg_7_0.descText_.text = var_7_0.event_desc
	end

	local var_7_1 = HodurTools.GetEventComplete(arg_7_0.cfgID_, arg_7_0.chapterID_)

	for iter_7_0 = 1, 2 do
		arg_7_0.eventItemList_[iter_7_0]:SetData(var_7_0.event_option[iter_7_0], arg_7_0.cfgID_, arg_7_0.chapterID_)
		arg_7_0.eventItemList_[iter_7_0]:SetClickHandler(function(arg_8_0)
			if not HodurTools.GetEventComplete(arg_7_0.cfgID_, arg_7_0.chapterID_) then
				arg_7_0:SelectEvent(arg_8_0)
			end
		end)

		if var_7_1 then
			arg_7_0.eventItemList_[iter_7_0]:SetComplete(true)
		else
			arg_7_0.eventItemList_[iter_7_0]:SetComplete(false)
		end
	end

	arg_7_0:SelectEvent(nil)

	arg_7_0.btnText_.text = GetTips("HODUR_SELECT")

	arg_7_0:RefreshEveneBtn()

	local var_7_2

	FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.eventContentTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.eventContentTrs_)
	end, 1, 1):Start()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.eventContentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.eventContentTrs_)
end

function var_0_0.RefreshEveneBtn(arg_10_0)
	if HodurTools.GetEventComplete(arg_10_0.cfgID_, arg_10_0.chapterID_) or arg_10_0.selectEventID_ == nil then
		SetActive(arg_10_0.btnGo_, false)
	else
		SetActive(arg_10_0.btnGo_, true)
	end
end

function var_0_0.SelectEvent(arg_11_0, arg_11_1)
	arg_11_0.selectEventID_ = arg_11_1

	for iter_11_0 = 1, 2 do
		local var_11_0 = arg_11_0.eventItemList_[iter_11_0].optionID_ == arg_11_1

		if iter_11_0 == 1 then
			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.eventItemGo_1.transform)
		end

		arg_11_0.eventItemList_[iter_11_0]:SetSelected(var_11_0)
	end

	arg_11_0:RefreshEveneBtn()
end

function var_0_0.OnClickStageBtn(arg_12_0)
	HodurTools.GoBattle(arg_12_0.cfgID_, ActivityConst.ACTIVITY_HODUR_MAIN, arg_12_0.chapterID_)
end

function var_0_0.OnClickEventBtn(arg_13_0)
	if arg_13_0.selectEventID_ == nil then
		return
	else
		for iter_13_0 = 1, 2 do
			local var_13_0 = arg_13_0.eventItemList_[iter_13_0].optionID_ == arg_13_0.selectEventID_

			if iter_13_0 == 2 and var_13_0 then
				arg_13_0:StartChooseEvent()

				return
			end
		end

		HodurAction.SelectEvent(arg_13_0.chapterID_, arg_13_0.selectEventID_, 1)
	end
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_0.StartChooseEvent(arg_15_0)
	if not arg_15_0.timer_ then
		arg_15_0.blankTrans_.sizeDelta = Vector2(580, 194)

		arg_15_0.eventItemList_[1]:Show(false)

		arg_15_0.showData_ = 194
		arg_15_0.timer_ = Timer.New(function()
			if arg_15_0.showData_ > 0 then
				arg_15_0:UpdateShowData()
			else
				arg_15_0:EndChooseEvent()
				HodurAction.SelectEvent(arg_15_0.chapterID_, arg_15_0.selectEventID_, 2)
			end
		end, 0.033, -1)

		arg_15_0.timer_:Start()
	end
end

function var_0_0.UpdateShowData(arg_17_0)
	local var_17_0 = 38.8

	arg_17_0.showData_ = arg_17_0.showData_ - var_17_0

	if arg_17_0.blankTrans_.sizeDelta.y > 0 then
		arg_17_0.blankTrans_.sizeDelta = Vector2(580, math.max(arg_17_0.blankTrans_.sizeDelta.y - var_17_0, 0))

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.eventContentTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.eventContentTrs_)
	end
end

function var_0_0.EndChooseEvent(arg_18_0)
	arg_18_0.blankTrans_.sizeDelta = Vector2(580, 0)
	arg_18_0.showData_ = 0

	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0 = 1, 2 do
		if arg_19_0.eventItemList_[iter_19_0] then
			arg_19_0.eventItemList_[iter_19_0]:Dispose()

			arg_19_0.eventItemList_[iter_19_0] = nil
		end
	end

	for iter_19_1 = 1, 6 do
		if arg_19_0.bossItemList_[iter_19_1] then
			arg_19_0.bossItemList_[iter_19_1]:Dispose()

			arg_19_0.bossItemList_[iter_19_1] = nil
		end
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
