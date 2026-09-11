local AutoChessTalkItem = class("AutoChessTalkItem", (import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")))

function AutoChessTalkItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessTalkItem:Init()
	self:InitUI()
	self:AddListeners()

	self.isPlayedAnim_ = false
end

function AutoChessTalkItem:InitUI()
	self:BindCfgUI()
end

function AutoChessTalkItem:AddListeners()
	return
end

function AutoChessTalkItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.talkID_ = arg_5_1
	self.index_ = arg_5_2

	self:Refresh()
end

function AutoChessTalkItem:Refresh()
	self.nameText_.text = AutoChessTalkCfg[self.talkID_].speaker_name
	self.dialogText_.text = AutoChessTalkCfg[self.talkID_].speaker_desc
end

function AutoChessTalkItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function AutoChessTalkItem:PlayAnim(arg_8_1)
	if not self.isPlayedAnim_ then
		self.anim_:Play(arg_8_1 and "UI_Dialogueleft_cx" or "UI_Dialogueright_cx", -1, 0)
		self.anim_:Update(0)

		self.isPlayedAnim_ = true
	end
end

function AutoChessTalkItem:ResetAnimState()
	self.isPlayedAnim_ = false

	self.anim_:Play("New State", 0, 0)
end

return AutoChessTalkItem
