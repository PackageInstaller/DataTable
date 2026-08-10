local var_0_0 = class("ValentineGameV2HeroAnswerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineGame1UI"
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

	for iter_4_0 = 1, 3 do
		arg_4_0["controller" .. iter_4_0 .. "_"] = ControllerUtil.GetController(arg_4_0["chooseBtn" .. iter_4_0 .. "_"].transform, "get")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 3 do
		arg_5_0:AddBtnListener(arg_5_0["chooseBtn" .. iter_5_0 .. "_"], nil, function()
			if ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
				local var_6_0 = arg_5_0.cfg_.hero_qa_id[iter_5_0]

				SDKTools.SendMessageToSDK("activity_valentine_opt", {
					answer_id = 0,
					question_id = var_6_0,
					activity_id = arg_5_0.activityID_
				})
				ValentineGameData:CacheChooseQID(var_6_0)
				manager.story:StartStoryById(ActivityValentineWordCfg[var_6_0].stroy_id_list[1], function(arg_7_0)
					JumpTools.OpenPageByJump("/valentineGameV2PlayerAnswerView", {
						activityID = arg_5_0.activityID_
					})
				end, true)
			elseif manager.time:GetServerTime() < ActivityData:GetActivityData(arg_5_0.activityID_).startTime then
				local var_6_1 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_5_0.activityID_).startTime)

				ShowTips(string.format(GetTips("OPEN_TIME"), var_6_1))
			else
				ShowTips(GetTips("TIME_OVER"))
			end
		end)
	end
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.cfg_ = ActivityValentineCfg[arg_8_0.activityID_]

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. arg_9_0.cfg_.hero_id .. "_split_1")

	arg_9_0.heroImage_:SetNativeSize()

	for iter_9_0 = 1, 3 do
		local var_9_0 = arg_9_0.cfg_.hero_qa_id[iter_9_0]

		arg_9_0["chooseText" .. iter_9_0 .. "_"].text = ActivityValentineWordCfg[var_9_0].question_desc

		local var_9_1 = ValentineGameData:GetData(arg_9_0.activityID_)

		if table.indexof(var_9_1.selectQuestionID, var_9_0) then
			arg_9_0["controller" .. iter_9_0 .. "_"]:SetSelectedState("true")
		else
			arg_9_0["controller" .. iter_9_0 .. "_"]:SetSelectedState("false")
		end
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
