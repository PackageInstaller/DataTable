local var_0_0 = {}
local var_0_1
local var_0_2

function var_0_0.BuildContext(arg_1_0)
	arg_1_0.context = {
		runStrategy = QWStoryConst.StoryType.StoryGraph
	}
	arg_1_0.storyStategy = {
		[QWStoryConst.StoryType.StoryGraph] = import("game.qworld.story.strategy." .. "QWGraphStoryStrategy").New()
	}
end

function var_0_0:StartStory(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if var_2_0 then
		var_2_0.shadowRotationImmediately = true
	end

	if arg_2_4 then
		self.context.runStrategy = arg_2_4

		self.storyStategy[arg_2_4]:StartStory(arg_2_1, arg_2_2, arg_2_3)
	else
		self.context.runStrategy = QWStoryConst.StoryType.StoryGraph

		self.storyStategy[QWStoryConst.StoryType.StoryGraph]:StartStory(arg_2_1, arg_2_2, arg_2_3)
	end
end

function var_0_0:GetTarget()
	return self.storyStategy[self.context.runStrategy]:GetTarget()
end

function var_0_0:GetStoryHistory()
	return self.storyStategy[self.context.runStrategy]:GetStoryHistory()
end

function var_0_0:IsInStory()
	return self.storyStategy[self.context.runStrategy]:GetStoryID() ~= 0
end

function var_0_0:StopStory()
	self.storyStategy[self.context.runStrategy]:StopStory()
	self:OnStoryEnd((self.storyStategy[self.context.runStrategy]:GetStoryID()))
end

function var_0_0:PreContinueStop()
	self.storyStategy[self.context.runStrategy]:PreContinueStop()
	QWorldMgr:GetQWorldQuestMgr():OnStoryEnd((self.storyStategy[self.context.runStrategy]:GetStoryID()))
end

function var_0_0:Init()
	manager.notify:RegistListener(QWORLD_OPEN_MAIN_VIEW, function(arg_9_0)
		self:OnMainHomeOpenChange(arg_9_0)
	end)

	var_0_1 = QWorldStoryView.New()
	var_0_2 = import("game.qworld.story.view.BlackFadeController").New()

	self:BuildContext()
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

function var_0_0:CollectFunctionChoice()
	local var_12_1 = self:GetCurStrategy():GetTarget()

	return (var_12_1 or nil) and var_12_1:GetAllTalkTag()
end

function var_0_0:GetCurStrategy()
	return self.storyStategy[self.context.runStrategy]
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

function var_0_0:ChangeAutoPlayState(arg_19_1)
	self.storyStategy[self.context.runStrategy]:ChangeAutoPlayState(arg_19_1)
end

function var_0_0:GetAutoPlayState()
	return self.storyStategy[self.context.runStrategy]:GetAutoPlayState()
end

function var_0_0:StartTalk(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	if not QWorldMgr:IsInQWorldMain() then
		return
	end

	self.talkCtx = self.talkCtx or {}
	self.talkCtx[arg_21_1] = self.talkCtx[arg_21_1] or QWStoryConst.TalkViewPage[arg_21_1].New()

	if self.talkCtx[arg_21_1] then
		self.talkCtx[arg_21_1]:Show()
		self.talkCtx[arg_21_1]:RenderContent(arg_21_2, arg_21_3, arg_21_4, self:GetSpeed(), arg_21_5)
	end
end

function var_0_0:StartTalkList(arg_22_1, arg_22_2, arg_22_3)
	if not QWorldMgr:IsInQWorldMain() then
		return
	end

	self.talkCtx = self.talkCtx or {}
	self.talkCtx[arg_22_1] = self.talkCtx[arg_22_1] or QWStoryConst.TalkViewPage[arg_22_1].New()

	if self.talkCtx[arg_22_1] then
		self.talkCtx[arg_22_1]:Show()
		self.talkCtx[arg_22_1]:RenderContentList(arg_22_2, self:GetSpeed(), arg_22_3)
	end
end

function var_0_0.GetSpeed(arg_23_0)
	return 0.2
end

function var_0_0:HideTalk(arg_24_1)
	if self.talkCtx[arg_24_1] then
		self.talkCtx[arg_24_1]:Hide()
	end
end

function var_0_0:CloseTalk(arg_25_1)
	if self.talkCtx[arg_25_1] and self.talkCtx[arg_25_1]:TryDispose() then
		self.talkCtx[arg_25_1] = nil
	end
end

function var_0_0.GetBlackFade(arg_26_0)
	return var_0_2
end

function var_0_0:OnMainHomeOpenChange(arg_27_1)
	if arg_27_1 == 1 then
		-- block empty
	elseif self.talkCtx then
		for iter_27_0, iter_27_1 in pairs(self.talkCtx) do
			if iter_27_1 then
				iter_27_1:Hide()
				iter_27_1:TryInterrupt()
			end
		end
	end
end

function var_0_0:Dispose()
	if self.talkCtx then
		for iter_28_0, iter_28_1 in pairs(self.talkCtx) do
			if iter_28_1 then
				iter_28_1:Dispose()
			end
		end
	end

	self.talkCtx = nil

	if self.storyStategy then
		for iter_28_2, iter_28_3 in pairs(self.storyStategy) do
			if iter_28_3 then
				iter_28_3:Dispose()
			end
		end
	end

	self.storyStategy = nil

	if var_0_1 then
		var_0_1:Dispose()

		var_0_1 = nil
	end
end

return var_0_0
