local QWorldTalkView = class("QWorldTalkView", import("game.extend.ReduxView"))

function QWorldTalkView:GetUIName()
	return "Widget/System/QWorld/QWorldTalkUI"
end

function QWorldTalkView:Ctor()
	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName()), manager.ui.uiStory.transform)
	self.transform_ = self.gameObject_.transform

	self:AdaptScreen()

	self.isInHide = false
	self.ExcuteContext = {
		isPlayingVoice = false,
		isInExcuting = false
	}

	self:Hide()
	self:Init()
end

function QWorldTalkView:Init()
	self:InitUI()
end

function QWorldTalkView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
	self:AddListener()
end

function QWorldTalkView:AddListener()
	return
end

function QWorldTalkView:Show()
	if self.isInHide then
		self.isInHide = false

		self.gameObject_:SetActive(true)
	end
end

function QWorldTalkView:TryShow()
	if self.isInTalk then
		self:Show()
	end
end

function QWorldTalkView:Hide(arg_8_1)
	if not self.isInHide then
		if arg_8_1 then
			self:StopTimer()
		else
			self:StopVoice()
		end

		self.gameObject_:SetActive(false)

		self.isInHide = true
	end
end

function QWorldTalkView:RenderContent(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	self.contentId = arg_9_1

	self:StopTimer()

	self.callback = arg_9_5
	self.speed = arg_9_4

	local var_9_0 = SandplayStoryTalkCfg[tonumber(arg_9_1)]
	local var_9_1 = "***"

	if arg_9_2 then
		var_9_1 = GetI18NText(arg_9_2)
	end

	local var_9_2 = -1

	if var_9_0.cue_sheet and var_9_0.cue_sheet ~= "" then
		manager.audio:PlayVoice(var_9_0.cue_sheet, var_9_0.cue_name, true)

		var_9_2 = manager.audio:GetVoiceLength(var_9_0.cue_sheet, var_9_0.cue_name, true) / 1000
	end

	self.contentTxt_.text = GetI18NText(var_9_0.dialogue_text)
	self.nameTxt_.text = var_9_1

	self:StartTimer(var_9_0.dialogue_text, var_9_2)
end

function QWorldTalkView:StartTimer(arg_10_1, arg_10_2)
	local var_10_1 = utf8len(arg_10_1) * (self.speed or 1)

	self.timer = Timer.New(function()
		self.callback = nil

		self:StopTimer()

		if self.callback then
			self.callback(self.contentId)
		end
	end, (arg_10_2 and arg_10_2 ~= -1 or nil) and arg_10_2, 1)
	self.isInTalk = true

	self.timer:Start()
end

function QWorldTalkView:StopTimer()
	if self.timer then
		self.isInTalk = false
		self.callback = nil

		self.timer:Stop()

		self.timer = nil
	end

	self:StopVoice()
end

function QWorldTalkView:StopVoice()
	if self.ExcuteContext.isInExcuting then
		manager.audio:StopVoiceImmediate()
	end
end

function QWorldTalkView:PauseVoice()
	if self.ExcuteContext.isInExcuting then
		manager.audio:PauseVoice()
	end
end

function QWorldTalkView:RenderContentList(arg_15_1, arg_15_2, arg_15_3)
	self:StopTimer()

	if self.ExcuteContext.isInExcuting then
		self:StopVoice()

		if self.ExcuteContext.callback then
			self.ExcuteContext.callback()

			self.ExcuteContext.callback = nil
		end

		self.ExcuteContext.isInExcuting = false
	end

	self.ExcuteContext.isInExcuting = true
	self.ExcuteContext.callback = arg_15_3

	self:ShowContentList(arg_15_1, 1, arg_15_2, arg_15_3)
end

function QWorldTalkView:ShowContentList(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if arg_16_1[arg_16_2] then
		local var_16_0 = tonumber(arg_16_1[arg_16_2])

		self:RenderContent(var_16_0, SandplayStoryTalkCfg[var_16_0].speaker_name, nil, arg_16_3, function()
			self:ShowContentList(arg_16_1, arg_16_2 + 1, arg_16_3, arg_16_4)
		end)
	else
		self.ExcuteContext.isInExcuting = false

		if arg_16_4 then
			arg_16_4()
		end
	end
end

function QWorldTalkView:TryDispose()
	if self.ExcuteContext.isInExcuting then
		return false
	end

	self.ExcuteContext.isInExcuting = false

	self:Dispose()

	return true
end

function QWorldTalkView:TryInterrupt()
	self:StopTimer()

	if self.ExcuteContext.isInExcuting then
		self:StopVoice()

		self.ExcuteContext.isInExcuting = false

		if self.ExcuteContext.callback then
			self.ExcuteContext.callback()

			self.ExcuteContext.callback = nil
		end
	end
end

function QWorldTalkView:Dispose()
	GameObject.Destroy(self.gameObject_)
	Asset.Unload(self:GetUIName())
	QWorldTalkView.super.Dispose(self)
end

return QWorldTalkView
