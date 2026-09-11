local QWorldStoryHistoryCell = class("QWorldStoryHistoryCell", import("game.extend.ReduxView"))

function QWorldStoryHistoryCell:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.parent_ = arg_1_2

	self:Init()
end

function QWorldStoryHistoryCell:Init()
	self:InitUI()
end

function QWorldStoryHistoryCell:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.voiceController = self.controller_:GetController("voice")
	self.talkId = 0
end

function QWorldStoryHistoryCell:Show()
	self.gameObject_:SetActive(true)
end

function QWorldStoryHistoryCell:Hide()
	self.gameObject_:SetActive(false)
end

function QWorldStoryHistoryCell:Render(arg_6_1)
	self.talkId = arg_6_1

	local var_6_0 = SandplayStoryTalkCfg[arg_6_1]

	self.titleText_.text = GetI18NText(SandplayStoryTalkCfg[arg_6_1].speaker_name)
	self.contentText_.text = GetI18NText(var_6_0.dialogue_text)

	SetActive(self.voiceObj_, var_6_0.cue_sheet ~= "")
end

function QWorldStoryHistoryCell:AddUIListener()
	self:AddBtnListener(self.voiceBtn_, nil, function()
		self.parent_:PlayTalkVoice(self)
	end)
end

function QWorldStoryHistoryCell:ChangeVoiceState(arg_9_1)
	if arg_9_1 then
		self.voiceController:SetSelectedState("play")
	else
		self.voiceController:SetSelectedState("stop")
	end
end

function QWorldStoryHistoryCell:Dispose()
	GameObject.Destroy(self.gameObject_)
	QWorldStoryHistoryCell.super.Dispose(self)
end

return QWorldStoryHistoryCell
