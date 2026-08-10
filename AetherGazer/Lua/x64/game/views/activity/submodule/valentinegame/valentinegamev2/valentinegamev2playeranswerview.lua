local var_0_0 = class("ValentineGameV2PlayerAnswerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineGame2UI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 2 do
		arg_5_0:AddBtnListener(arg_5_0["chooseBtn" .. iter_5_0 .. "_"], nil, function()
			if ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
				ValentineGameData:CacheRandomQID(arg_5_0.curQID_)
				ValentineGameAction:SetPoint(arg_5_0.activityID_, 0, function()
					SDKTools.SendMessageToSDK("activity_valentine_opt", {
						question_id = arg_5_0.curQID_,
						answer_id = iter_5_0,
						activity_id = arg_5_0.activityID_
					})
					JumpTools.OpenPageByJump("/valentineGameV2ResultView", {
						activityID = arg_5_0.activityID_,
						qID = arg_5_0.curQID_,
						selectIndex = iter_5_0
					})
				end)
			elseif manager.time:GetServerTime() < ActivityData:GetActivityData(arg_5_0.activityID_).startTime then
				local var_6_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_5_0.activityID_).startTime)

				ShowTips(string.format(GetTips("OPEN_TIME"), var_6_0))
			else
				ShowTips(GetTips("TIME_OVER"))
			end
		end)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.cfg_ = ActivityValentineCfg[arg_8_0.activityID_]

	local var_8_0

	if ValentineGameData:GetData(arg_8_0.activityID_) then
		var_8_0 = ValentineGameData:GetData(arg_8_0.activityID_).answerQuestionID
	else
		var_8_0 = {}
	end

	if #arg_8_0.cfg_.qa_id == #var_8_0 then
		var_8_0 = {}

		ValentineGameData:ClearReadedQID(arg_8_0.activityID_)
	end

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.cfg_.qa_id) do
		if table.indexof(var_8_0, iter_8_1) == false then
			table.insert(var_8_1, iter_8_1)
		end
	end

	arg_8_0.curQID_ = var_8_1[math.random(#var_8_1)]

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_9_0.cfg_.hero_id .. "_split_1")

	arg_9_0.heroImage_:SetNativeSize()

	arg_9_0.qustionText_.text = ActivityValentineWordCfg[arg_9_0.curQID_].question_desc

	for iter_9_0 = 1, 2 do
		arg_9_0["chooseText" .. iter_9_0 .. "_"].text = ActivityValentineWordCfg[arg_9_0.curQID_].answer_desc[iter_9_0]
	end
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
			activityID = arg_10_0.activityID_
		})
	end)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
