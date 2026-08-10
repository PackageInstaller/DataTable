local var_0_0 = {}
local var_0_1
local var_0_2

function var_0_0.BuildContext(arg_1_0)
	arg_1_0.context = {
		runStrategy = QWStoryConst.StoryType.StoryGraph
	}

	local var_1_0 = "game.qworld.story.strategy."

	arg_1_0.storyStategy = {
		[QWStoryConst.StoryType.StoryGraph] = import(var_1_0 .. "QWGraphStoryStrategy").New()
	}
end

function var_0_0.StartStory(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_2_0 then
		var_2_0.shadowRotationImmediately = true
	end

	if arg_2_4 then
		arg_2_0.context.runStrategy = arg_2_4

		arg_2_0.storyStategy[arg_2_4]:StartStory(arg_2_1, arg_2_2, arg_2_3)
	else
		arg_2_0.context.runStrategy = QWStoryConst.StoryType.StoryGraph

		arg_2_0.storyStategy[QWStoryConst.StoryType.StoryGraph]:StartStory(arg_2_1, arg_2_2, arg_2_3)
	end
end

function var_0_0.GetTarget(arg_3_0)
	return arg_3_0.storyStategy[arg_3_0.context.runStrategy]:GetTarget()
end

function var_0_0.GetStoryHistory(arg_4_0)
	return arg_4_0.storyStategy[arg_4_0.context.runStrategy]:GetStoryHistory()
end

function var_0_0.IsInStory(arg_5_0)
	return arg_5_0.storyStategy[arg_5_0.context.runStrategy]:GetStoryID() ~= 0
end

function var_0_0.StopStory(arg_6_0)
	local var_6_0 = arg_6_0.storyStategy[arg_6_0.context.runStrategy]:GetStoryID()

	arg_6_0.storyStategy[arg_6_0.context.runStrategy]:StopStory()
	arg_6_0:OnStoryEnd(var_6_0)
end

function var_0_0.PreContinueStop(arg_7_0)
	local var_7_0 = arg_7_0.storyStategy[arg_7_0.context.runStrategy]:GetStoryID()

	arg_7_0.storyStategy[arg_7_0.context.runStrategy]:PreContinueStop()
	QWorldMgr:GetQWorldQuestMgr():OnStoryEnd(var_7_0)
end

function var_0_0.Init(arg_8_0)
	manager.notify:RegistListener(QWORLD_OPEN_MAIN_VIEW, function(arg_9_0)
		arg_8_0:OnMainHomeOpenChange(arg_9_0)
	end)

	var_0_1 = QWorldStoryView.New()
	var_0_2 = import("game.qworld.story.view.BlackFadeController").New()

	arg_8_0:BuildContext()
	var_0_1:Hide()
end

function var_0_0.SetContent(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_8)
	var_0_1:RenderContent(arg_10_1, arg_10_3, arg_10_4)
	var_0_1:SetNeedClickCallback(arg_10_5, arg_10_6)
	var_0_1:SetSkipCallback(arg_10_7, arg_10_8)
end

function var_0_0.OpenChoice(arg_11_0, arg_11_1, arg_11_2)
	var_0_1:SetNeedClickCallback(false, nil)
	var_0_1:SetSkipCallback(false, false)
	var_0_1:OpenChoice(arg_11_1, arg_11_2)
end

function var_0_0.CollectFunctionChoice(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:GetCurStrategy():GetTarget()

	if var_12_1 then
		var_12_0 = var_12_1:GetAllTalkTag()
	end

	return var_12_0
end

function var_0_0.GetCurStrategy(arg_13_0)
	return arg_13_0.storyStategy[arg_13_0.context.runStrategy]
end

function var_0_0.CloseChoice(arg_14_0)
	var_0_1:CloseChoice()
end

function var_0_0.OnStoryEnd(arg_15_0, arg_15_1)
	var_0_1:Hide()
	QWorldMgr:GetQWorldQuestMgr():OnStoryEnd(arg_15_1)
end

function var_0_0.ShowTalkView(arg_16_0)
	var_0_1:Show()
end

function var_0_0.HideTalkView(arg_17_0)
	var_0_1:Hide()
end

function var_0_0.GetTalkView(arg_18_0)
	return var_0_1
end

function var_0_0.ChangeAutoPlayState(arg_19_0, arg_19_1)
	arg_19_0.storyStategy[arg_19_0.context.runStrategy]:ChangeAutoPlayState(arg_19_1)
end

function var_0_0.GetAutoPlayState(arg_20_0)
	return arg_20_0.storyStategy[arg_20_0.context.runStrategy]:GetAutoPlayState()
end

function var_0_0.StartTalk(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	if not QWorldMgr:IsInQWorldMain() then
		return
	end

	if not arg_21_0.talkCtx then
		arg_21_0.talkCtx = {}
	end

	if not arg_21_0.talkCtx[arg_21_1] then
		arg_21_0.talkCtx[arg_21_1] = QWStoryConst.TalkViewPage[arg_21_1].New()
	end

	if arg_21_0.talkCtx[arg_21_1] then
		arg_21_0.talkCtx[arg_21_1]:Show()
		arg_21_0.talkCtx[arg_21_1]:RenderContent(arg_21_2, arg_21_3, arg_21_4, arg_21_0:GetSpeed(), arg_21_5)
	end
end

function var_0_0.StartTalkList(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not QWorldMgr:IsInQWorldMain() then
		return
	end

	if not arg_22_0.talkCtx then
		arg_22_0.talkCtx = {}
	end

	if not arg_22_0.talkCtx[arg_22_1] then
		arg_22_0.talkCtx[arg_22_1] = QWStoryConst.TalkViewPage[arg_22_1].New()
	end

	if arg_22_0.talkCtx[arg_22_1] then
		arg_22_0.talkCtx[arg_22_1]:Show()
		arg_22_0.talkCtx[arg_22_1]:RenderContentList(arg_22_2, arg_22_0:GetSpeed(), arg_22_3)
	end
end

function var_0_0.GetSpeed(arg_23_0)
	return 0.2
end

function var_0_0.HideTalk(arg_24_0, arg_24_1)
	if arg_24_0.talkCtx[arg_24_1] then
		arg_24_0.talkCtx[arg_24_1]:Hide()
	end
end

function var_0_0.CloseTalk(arg_25_0, arg_25_1)
	if arg_25_0.talkCtx[arg_25_1] and arg_25_0.talkCtx[arg_25_1]:TryDispose() then
		arg_25_0.talkCtx[arg_25_1] = nil
	end
end

function var_0_0.GetBlackFade(arg_26_0)
	return var_0_2
end

function var_0_0.OnMainHomeOpenChange(arg_27_0, arg_27_1)
	if arg_27_1 == 1 then
		-- block empty
	elseif arg_27_0.talkCtx then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.talkCtx) do
			if iter_27_1 then
				iter_27_1:Hide()
				iter_27_1:TryInterrupt()
			end
		end
	end
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.talkCtx then
		for iter_28_0, iter_28_1 in pairs(arg_28_0.talkCtx) do
			if iter_28_1 then
				iter_28_1:Dispose()
			end
		end
	end

	arg_28_0.talkCtx = nil

	if arg_28_0.storyStategy then
		for iter_28_2, iter_28_3 in pairs(arg_28_0.storyStategy) do
			if iter_28_3 then
				iter_28_3:Dispose()
			end
		end
	end

	arg_28_0.storyStategy = nil

	if var_0_1 then
		var_0_1:Dispose()

		var_0_1 = nil
	end
end

return var_0_0
