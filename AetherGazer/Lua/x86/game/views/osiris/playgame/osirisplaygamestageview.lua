local var_0_0 = class("OsirisPlayGameStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_PlayUI"
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

	arg_4_0.items_ = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = OsirisPlayGameStageItem.New(arg_4_0["stageGo_" .. iter_4_0], iter_4_0)

		arg_4_0.items_[iter_4_0] = var_4_0
	end
end

function var_0_0.OnEnter(arg_5_0)
	if arg_5_0.params_.chapterID then
		arg_5_0.chapterID = arg_5_0.params_.chapterID
	end

	arg_5_0.stage_id = arg_5_0.params_.stage_id

	if arg_5_0.params_.isFailed ~= nil then
		arg_5_0.isFailed = arg_5_0.params_.isFailed
	end

	if not arg_5_0.isShowTips and arg_5_0.params_.isShowTips then
		arg_5_0.isShowTips = arg_5_0.params_.isShowTips
	end

	arg_5_0.stage_id_list = ActivityGeneralityStageCfg.get_id_list_by_chapter_id[arg_5_0.chapterID]

	arg_5_0:RefreshStory()
	arg_5_0:RefreshUI()
	arg_5_0:RefreshItems()
end

function var_0_0.ShowTips(arg_6_0)
	if OsirisPlayGameData:GetPassStagesNumByChapterId(arg_6_0.chapterID) == 3 then
		arg_6_0.tipstimer_ = Timer.New(function()
			arg_6_0:TipsStopTimer()

			arg_6_0.isShowTips = nil

			JumpTools.OpenPageByJump("osirisPlayGameTipsView", {
				chapterID = arg_6_0.chapterID
			})
		end, 1.5, 1)

		arg_6_0.tipstimer_:Start()
	end
end

function var_0_0.RefreshStory(arg_8_0)
	local var_8_0 = GameSetting.activity_generality_end_story.value[1]

	if OsirisPlayGameData:GetPlayStory(var_8_0) ~= 1 and arg_8_0.stage_id == 5260163 then
		manager.story:StartStory(var_8_0)
		OsirisPlayGameData:SetPlayStory(var_8_0)
	end
end

function var_0_0.AddUIListener(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ActivityGeneralityChapterCfg[arg_11_0.chapterID]

	arg_11_0.chapterNameTxt_.text = GetI18NText(var_11_0.chapter_name)

	local var_11_1 = tonumber(var_11_0.icon)

	arg_11_0.descTxt_.text = GetI18NText(ActivityGeneralityTagCfg[var_11_1].desc)

	local var_11_2 = OsirisPlayGameData:GetPassStagesNumByChapterId(arg_11_0.chapterID)

	arg_11_0.slider_.value = var_11_2 - 1 < 0 and 0 or var_11_2 - 1
	arg_11_0.logoImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_11_0.icon)

	local var_11_3 = arg_11_0:GetOpenUnlockPopView()

	if var_11_3 ~= 0 then
		arg_11_0.isShowTips = 2

		local var_11_4 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[var_11_3][1]
		local var_11_5 = ActivityGeneralityStageCfg[var_11_4].unlock_charactor

		if var_11_5 > 0 then
			arg_11_0.timer_ = Timer.New(function()
				arg_11_0:StopTimer()
				JumpTools.OpenPageByJump("/osirisPlayGameUnlockPopView", {
					heroId = var_11_5
				})
			end, 1.5, 1)

			arg_11_0.timer_:Start()
		elseif arg_11_0.isShowTips and arg_11_0.isShowTips == 2 then
			arg_11_0:ShowTips()
		end
	elseif arg_11_0.isShowTips and arg_11_0.isShowTips == 2 then
		arg_11_0:ShowTips()
	end

	local var_11_6 = OsirisPlayGameData:GetPassStagesNumByChapterId(arg_11_0.chapterID)

	arg_11_0.slider_.value = var_11_6 + 1
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.TipsStopTimer(arg_14_0)
	if arg_14_0.tipstimer_ then
		arg_14_0.tipstimer_:Stop()

		arg_14_0.tipstimer_ = nil
	end
end

function var_0_0.GetOpenUnlockPopView(arg_15_0)
	local var_15_0 = OsirisPlayGameData:GetPassStageClearTimes()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if iter_15_1 == 0 then
			OsirisPlayGameData:SetPassStageClearTimes(iter_15_0)

			return iter_15_0
		end
	end

	return 0
end

function var_0_0.RefreshItems(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.items_ do
		if arg_16_0.stage_id_list[iter_16_0] then
			arg_16_0.items_[iter_16_0]:RefreshView(arg_16_0.stage_id_list[iter_16_0], arg_16_0.stage_id, arg_16_0.isFailed)
		end
	end
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
	var_0_0.super.OnExit(arg_17_0)
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0 = 1, #arg_18_0.items_ do
		arg_18_0.items_[iter_18_0]:Dispose()
	end

	arg_18_0:StopTimer()
	arg_18_0:TipsStopTimer()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
