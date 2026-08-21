local var_0_0 = class("IlluPlotDetailItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "ButItem")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.storyID_ = arg_4_1
	arg_4_0.type_ = arg_4_2
	arg_4_0.unlock_ = arg_4_0:GetIsUnLock(arg_4_1)

	if arg_4_0.unlock_ then
		local var_4_0 = StoryCfg[arg_4_1]
		local var_4_1 = VideoTrackCfg[arg_4_1 .. ".usm"]

		if var_4_0.videoPath ~= nil and var_4_0.videoPath ~= "" or var_4_0.videoType ~= nil and var_4_0.videoType == 1 or var_4_1 ~= nil and arg_4_0.unlock_ ~= nil then
			arg_4_0.controller_:SetSelectedState("video")
		else
			arg_4_0.controller_:SetSelectedState("normal")
		end
	else
		arg_4_0.controller_:SetSelectedState("empty")
	end

	arg_4_0.nameText_.text = GetI18NText(StoryCfg[arg_4_1].name)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		arg_5_0:StoryShowTip()
	end)
end

function var_0_0.GetIsUnLock(arg_7_0, arg_7_1)
	if arg_7_1 == 101110501 then
		arg_7_1 = 101110401
	end

	return IllustratedData:GetPlotInfo()[arg_7_1]
end

function var_0_0.StoryShowTip(arg_8_0)
	if arg_8_0:GetIsUnLock(arg_8_0.storyID_) then
		manager.story:StartStoryById(arg_8_0.storyID_, function(arg_9_0)
			IllustratedAction.ViewIllustration(arg_8_0.storyID_, CollectConst.PLOT)
			gameContext:Go("/blank")
			gameContext:Back()
		end)
	elseif arg_8_0.type_ == 1 then
		local var_8_0 = getStageViaStoryID(arg_8_0.storyID_)
		local var_8_1 = getChapterDifficulty(var_8_0)
		local var_8_2 = getChapterClientCfgByStageID(var_8_0).toggle
		local var_8_3, var_8_4 = BattleStageTools.GetChapterSectionIndex(var_8_2, var_8_0)
		local var_8_5 = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_8_1, GetI18NText(var_8_3), GetI18NText(var_8_4))

		ShowTips(var_8_5)
	elseif arg_8_0.type_ == 2 then
		local var_8_6 = string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(StoryCfg[arg_8_0.storyID_].name))

		if arg_8_0.storyID_ == 101110501 then
			var_8_6 = string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(StoryCfg[101110401].name))
		end

		ShowTips(var_8_6)
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
