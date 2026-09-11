local GameHelpView = class("GameHelpView", ReduxView)

function GameHelpView:UIName()
	return "Widget/Common/Pop/InstructionspopUI02"
end

function GameHelpView:UIParent()
	return manager.ui.uiMessage.transform
end

function GameHelpView:Dispose()
	GameHelpView.super.Dispose(self)
end

function GameHelpView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GameHelpView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function GameHelpView:OnEnter()
	local var_7_0 = self.params_ or {}

	self.contentText_.text = var_7_0.content
	self.titleText_.text = var_7_0.title or GetTips("STAGE_DESCRIPE")

	if var_7_0.titleStatus ~= nil then
		SetActive(self.titleGo_, var_7_0.titleStatus)
	end

	self.exitFunc_ = var_7_0.exitFunc
	self.scrollView_.normalizedPosition = Vector2(0, 1)
end

function GameHelpView:OnExit()
	self:RecordStay(self.params_.key)

	self.exitFunc_ = nil

	if self.exitFunc_ then
		self.exitFunc_()
	end
end

function GameHelpView:RecordStay(arg_9_1)
	local var_9_0 = 0

	if arg_9_1 == "EQUIP_STAGE_DESCRIPE" then
		var_9_0 = 50101
	elseif arg_9_1 == "ENCHANTMENT_DESCRIPE" then
		var_9_0 = 50102
	elseif arg_9_1 == "MATRIX_DESCRIPE" then
		var_9_0 = 50103
	elseif arg_9_1 == "BOSS_CHALLENGE_DESC" then
		var_9_0 = 50104
	elseif arg_9_1 == "MYTHIC_DESCRIPE" then
		var_9_0 = 50105
	elseif arg_9_1 == "SPAWN_DESCRIPE" then
		var_9_0 = 50106
	elseif arg_9_1 == "TEACH_STAGE_DESC" then
		var_9_0 = 50107
	end

	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", self:GetStayTime(), var_9_0)
end

return GameHelpView
