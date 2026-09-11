local QWorldStoryHistoryView = class("QWorldStoryHistoryView", import("game.extend.ReduxView"))

function QWorldStoryHistoryView:UIName()
	return "Widget/System/SandPlay/SandPlay_Story/SandPlay_ChatHistoryUI"
end

function QWorldStoryHistoryView:UIParent()
	return manager.ui.uiPop.transform
end

function QWorldStoryHistoryView:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldStoryHistoryView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		if self.canExit then
			self:Back()
		end
	end)
end

function QWorldStoryHistoryView:SetGaussion(arg_6_1)
	self:SetGaussionBg(arg_6_1)
	manager.ui:SetUISeparateRender(arg_6_1)

	return arg_6_1
end

function QWorldStoryHistoryView:InitUI()
	self:BindCfgUI()

	self.itemPool = {}
	self.canExit = true
	self.loadFrameCounter = 10
	self.frameTimer = nil
	self.histroyCount = 0
	self.curFrameTimer = 0
	self.curLoadCounter = 0
	self.curFrameLoadCount = 0
	self.storyHistory = {}
	self.curVoicePlayCell = nil
end

function QWorldStoryHistoryView:OnEnter()
	self.canExit = false
	self.storyHistory = QWorldMgr:GetQWorldStoryMgr():GetStoryHistory()
	self.histroyCount = #self.storyHistory
	self.curFrameLoadCount = math.ceil(self.histroyCount / self.loadFrameCounter)

	self:StartLoadHistory()
	manager.notify:Invoke(QWORLD_STORY_HISTORY_OPEN, true)
end

function QWorldStoryHistoryView:StartLoadHistory()
	self:StopLoad()

	self.curFrameTimer = 0
	self.frameTimer = FrameTimer.New(function()
		if self.curFrameTimer < self.loadFrameCounter then
			for iter_10_0 = self.curLoadCounter + 1, self.curLoadCounter + 1 + self.curFrameLoadCount do
				if self.storyHistory[iter_10_0] then
					self:InstNewCell(iter_10_0)
					self:ScrollToEnd()
				else
					self:StopLoad()

					self.canExit = true

					return
				end
			end

			if self.curLoadCounter + 1 + self.curFrameLoadCount > self.histroyCount then
				self:StopLoad()

				self.canExit = true

				return
			end

			self.curLoadCounter = self.curLoadCounter + self.curFrameLoadCount
		end

		self.curFrameTimer = self.curFrameTimer + 1

		if self.curFrameTimer == self.loadFrameCounter then
			self:StopLoad()

			self.canExit = true

			return
		end
	end, 1, -1)

	self.frameTimer:Start()
end

function QWorldStoryHistoryView:ScrollToEnd()
	self.scrollView_.verticalNormalizedPosition = 0
end

function QWorldStoryHistoryView:StopLoad()
	if self.frameTimer then
		self.frameTimer:Stop()

		self.frameTimer = nil
	end
end

function QWorldStoryHistoryView:OnExit()
	self:StopLoad()

	for iter_13_0, iter_13_1 in pairs(self.itemPool) do
		iter_13_1:Dispose()
	end

	self.itemPool = {}
	self.curLoadCounter = 0

	self:StopVoiceTimer()
	manager.audio:StopVoiceImmediate()
	manager.notify:Invoke(QWORLD_STORY_HISTORY_OPEN, false)
end

function QWorldStoryHistoryView:InstNewCell(arg_14_1)
	if self.itemPool[arg_14_1] then
		self.itemPool[arg_14_1]:Show()
		self.itemPool[arg_14_1]:Render(self.storyHistory[arg_14_1])
	else
		local var_14_0 = QWorldStoryHistoryCell.New(GameObject.Instantiate(self.oneRow_, self.content_.transform), self)

		table.insert(self.itemPool, var_14_0)
		var_14_0:Show()
		var_14_0:Render(self.storyHistory[arg_14_1])
	end
end

function QWorldStoryHistoryView:PlayTalkVoice(arg_15_1)
	if self.curVoicePlayCell then
		if self.curVoicePlayCell == arg_15_1 then
			return
		end

		self.curVoicePlayCell:ChangeVoiceState(false)
	end

	arg_15_1:ChangeVoiceState(true)
	manager.audio:StopVoiceImmediate()
	manager.audio:PlayVoice(SandplayStoryTalkCfg[arg_15_1.talkId].cue_sheet, SandplayStoryTalkCfg[arg_15_1.talkId].cue_name, true)
	self:StartVoiceTimer(manager.audio:GetVoiceLength(SandplayStoryTalkCfg[arg_15_1.talkId].cue_sheet, SandplayStoryTalkCfg[arg_15_1.talkId].cue_name, true) / 1000)

	self.curVoicePlayCell = arg_15_1
end

function QWorldStoryHistoryView:StartVoiceTimer(arg_16_1)
	self:StopVoiceTimer()

	self.voiceTimer = Timer.New(function()
		if self.curVoicePlayCell then
			self.curVoicePlayCell:ChangeVoiceState(false)

			self.curVoicePlayCell = nil
		end

		self:StopVoiceTimer()
	end, arg_16_1, 1)

	self.voiceTimer:Start()
end

function QWorldStoryHistoryView:StopVoiceTimer()
	if self.voiceTimer then
		self.voiceTimer:Stop()

		self.voiceTimer = nil
	end
end

function QWorldStoryHistoryView:Dispose()
	self:StopLoad()

	for iter_19_0, iter_19_1 in ipairs(self.itemPool) do
		iter_19_1:Dispose()
	end

	self.itemPool = nil

	QWorldStoryHistoryView.super.Dispose(self)
end

return QWorldStoryHistoryView
