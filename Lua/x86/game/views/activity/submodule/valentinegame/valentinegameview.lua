local var_0_0 = class("ValentineGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ValentineGameTools.GetGameUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	local var_4_0 = 0
	local var_4_1 = ActivityCfg[arg_4_0.params_.mainActivityID].sub_activity_list

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = ActivityValentineCfg[iter_4_1]

		for iter_4_2, iter_4_3 in ipairs(var_4_2.qa_id) do
			var_4_0 = var_4_0 < #ActivityValentineWordCfg[iter_4_3].answer_desc and #ActivityValentineWordCfg[iter_4_3].answer_desc or var_4_0
		end
	end

	arg_4_0.choose_ = {}
	arg_4_0.chooseText_ = {}
	arg_4_0.chooseName_ = {}
	arg_4_0.chooseCanvasGroup_ = {}
	arg_4_0.selfCon_ = {}
	arg_4_0.otherCon_ = {}
	arg_4_0.chooseCon_ = {}

	for iter_4_4 = 1, var_4_0 do
		arg_4_0.choose_[iter_4_4] = arg_4_0["choose_" .. iter_4_4]
		arg_4_0.chooseText_[iter_4_4] = arg_4_0["chooseText_" .. iter_4_4]
		arg_4_0.chooseName_[iter_4_4] = arg_4_0["chooseName_" .. iter_4_4]
		arg_4_0.chooseCanvasGroup_[iter_4_4] = arg_4_0["chooseCanvasGroup_" .. iter_4_4]
		arg_4_0.selfCon_[iter_4_4] = ControllerUtil.GetController(arg_4_0.choose_[iter_4_4].transform, "self")
		arg_4_0.otherCon_[iter_4_4] = ControllerUtil.GetController(arg_4_0.choose_[iter_4_4].transform, "other")
		arg_4_0.chooseCon_[iter_4_4] = ControllerUtil.GetController(arg_4_0.choose_[iter_4_4].transform, "choosing")
	end

	arg_4_0.indexCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "index")
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.btnstateCon_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "btn")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.choose_) do
		arg_5_0:AddBtnListener(arg_5_0.choose_[iter_5_0], nil, function()
			if arg_5_0.curChoose_ ~= 0 then
				return
			end

			local var_6_0 = ActivityValentineCfg[arg_5_0.activityID_].qa_id[arg_5_0.curIndex_]

			SDKTools.SendMessageToSDK("activity_valentine_opt", {
				question_id = var_6_0,
				answer_id = iter_5_0,
				activity_id = arg_5_0.activityID_
			})

			if ActivityValentineWordCfg[var_6_0].correct_answer == iter_5_0 then
				arg_5_0.correctCount_ = arg_5_0.correctCount_ + 1
			end

			if arg_5_0.curIndex_ >= #arg_5_0.list_ then
				SDKTools.SendMessageToSDK("activity_valentine_over", {
					activity_id = arg_5_0.correctCount_
				})
			end

			arg_5_0.curChoose_ = iter_5_0

			arg_5_0.selfCon_[iter_5_0]:SetSelectedState("true")
			arg_5_0:StopTimer()
			arg_5_0:Update()
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.nextBtn_, nil, function()
		arg_5_0.curIndex_ = arg_5_0.curIndex_ + 1

		arg_5_0:Refresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.resultBtn_, nil, function()
		local var_8_0 = manager.time:GetServerTime()
		local var_8_1 = ActivityData:GetActivityData(arg_5_0.mainActivityID_)

		if not (var_8_0 >= var_8_1.startTime) or not (var_8_0 < var_8_1.stopTime) then
			ShowTips("TIME_OVER")
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityID = arg_5_0.mainActivityID_
			})

			return
		end

		ValentineGameAction:SetPoint(arg_5_0.activityID_, arg_5_0.count_)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.count_ = 0
	arg_9_0.curIndex_ = 1
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.mainActivityID_ = arg_9_0.params_.mainActivityID
	arg_9_0.correctCount_ = 0

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.cfg_ = ActivityValentineCfg[arg_10_0.activityID_]

	arg_10_0.indexCon_:SetSelectedState(table.indexof(ActivityCfg[arg_10_0.params_.mainActivityID].sub_activity_list, arg_10_0.activityID_))

	arg_10_0.name_.text = GetI18NText(arg_10_0.cfg_.name)
	arg_10_0.list_ = arg_10_0.cfg_.qa_id

	for iter_10_0 = 1, #arg_10_0.chooseName_ do
		arg_10_0.chooseName_[iter_10_0].text = GetI18NText(arg_10_0.cfg_.name)
	end

	arg_10_0:Refresh()
end

function var_0_0.Refresh(arg_11_0)
	arg_11_0:Reset()
	arg_11_0:RefreshTimer()
end

function var_0_0.Reset(arg_12_0)
	arg_12_0.curChoose_ = 0

	local var_12_0 = arg_12_0.list_[arg_12_0.curIndex_]

	arg_12_0.curAnsCfg_ = ActivityValentineWordCfg[var_12_0]

	for iter_12_0 = 1, #arg_12_0.curAnsCfg_.answer_desc do
		arg_12_0.selfCon_[iter_12_0]:SetSelectedState("false")
		arg_12_0.otherCon_[iter_12_0]:SetSelectedState("false")
		arg_12_0.chooseCon_[iter_12_0]:SetSelectedState("false")

		arg_12_0.chooseCanvasGroup_[iter_12_0].alpha = 1

		if arg_12_0.curAnsCfg_.answer_desc[iter_12_0] == "<nickname>" then
			local var_12_1 = PlayerData:GetPlayerInfo()

			arg_12_0.chooseText_[iter_12_0].text = GetI18NText(var_12_1.nick)
		else
			arg_12_0.chooseText_[iter_12_0].text = GetI18NText(arg_12_0.curAnsCfg_.answer_desc[iter_12_0])
		end

		SetActive(arg_12_0.choose_[iter_12_0].gameObject, true)
	end

	for iter_12_1 = #arg_12_0.curAnsCfg_.answer_desc + 1, #arg_12_0.choose_ do
		SetActive(arg_12_0.choose_[iter_12_1].gameObject, false)
	end

	arg_12_0.title_.text = GetTips("TIP_QUESTION") .. GetTips("NUM_" .. arg_12_0.curIndex_)
	arg_12_0.desc_.text = GetI18NText(arg_12_0.curAnsCfg_.question_desc)

	arg_12_0.btnstateCon_:SetSelectedState("wait")
end

function var_0_0.RefreshTimer(arg_13_0)
	arg_13_0.think_.text = GetTips("TIP_SELECTING") .. "..."

	arg_13_0.stateCon_:SetSelectedState("choosing")

	local var_13_0 = math.random(3, 6)
	local var_13_1 = 0

	arg_13_0.timer_ = Timer.New(function()
		if var_13_1 < var_13_0 then
			var_13_1 = var_13_1 + 1

			local var_14_0 = var_13_1 % 3

			if var_14_0 == 1 then
				arg_13_0.think_.text = GetTips("TIP_SELECTING") .. "."
			elseif var_14_0 == 2 then
				arg_13_0.think_.text = GetTips("TIP_SELECTING") .. ".."
			else
				arg_13_0.think_.text = GetTips("TIP_SELECTING") .. "..."
			end
		else
			arg_13_0.think_.text = GetTips("TIP_SELECT_OVER")

			arg_13_0:StopTimer()
		end
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.Update(arg_15_0)
	local var_15_0 = arg_15_0.curAnsCfg_.correct_answer

	arg_15_0.otherCon_[var_15_0]:SetSelectedState("true")

	arg_15_0.ans_.text = GetI18NText(arg_15_0.curAnsCfg_.hero_comment[arg_15_0.curChoose_])

	arg_15_0.stateCon_:SetSelectedState("result")

	for iter_15_0 = 1, #arg_15_0.curAnsCfg_.answer_desc do
		if iter_15_0 ~= var_15_0 and iter_15_0 ~= arg_15_0.curChoose_ then
			arg_15_0.chooseCanvasGroup_[iter_15_0].alpha = 0.4
		end
	end

	if arg_15_0.curChoose_ == var_15_0 then
		arg_15_0.count_ = arg_15_0.count_ + 1
	end

	if arg_15_0.curIndex_ < #arg_15_0.list_ then
		arg_15_0.btnstateCon_:SetSelectedState("next")
	else
		arg_15_0.btnstateCon_:SetSelectedState("result")
	end
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.OnValentineResult(arg_17_0)
	JumpTools.OpenPageByJump("/valentineResult", {
		mainActivityID = arg_17_0.params_.mainActivityID,
		activityID = arg_17_0.params_.activityID,
		point = arg_17_0.count_
	})
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:StopTimer()
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveAllListeners()
	arg_20_0.super.Dispose(arg_20_0)
end

return var_0_0
