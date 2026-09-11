local GameHelpLongView = class("GameHelpLongView", ReduxView)

function GameHelpLongView:UIName()
	return "Widget/Common/Pop/InstructionspopUI01"
end

function GameHelpLongView:UIParent()
	return manager.ui.uiMessage.transform
end

function GameHelpLongView:Dispose()
	GameHelpLongView.super.Dispose(self)
end

function GameHelpLongView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GameHelpLongView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function GameHelpLongView:OnEnter()
	local var_7_0 = self.params_ or {}

	self.contentText_.text = var_7_0.content
	self.titleText_.text = var_7_0.title or GetTips("STAGE_DESCRIPE")
	self.scrollView_.normalizedPosition = Vector2(0, 1)
end

function GameHelpLongView:OnExit()
	self:RecordStay(self.params_.key)
end

function GameHelpLongView:RecordStay(arg_9_1)
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

return GameHelpLongView
