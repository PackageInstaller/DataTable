local GameHelpMultiView = class("GameHelpMultiView", ReduxView)

function GameHelpMultiView:UIName()
	return "Widget/Common/Pop/InstructionspopUI03"
end

function GameHelpMultiView:UIParent()
	return manager.ui.uiPop.transform
end

function GameHelpMultiView:Dispose()
	for iter_3_0, iter_3_1 in ipairs(self.infoItems_) do
		iter_3_1:Dispose()
	end

	self.infoItems_ = nil

	GameHelpMultiView.super.Dispose(self)
end

function GameHelpMultiView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.infoItems_ = {}
end

function GameHelpMultiView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function GameHelpMultiView:OnEnter()
	local var_7_0 = self.params_.titleList or {}
	local var_7_1 = self.params_.contentList or {}

	for iter_7_0 = 1, #var_7_0 do
		self.infoItems_[iter_7_0] = self.infoItems_[iter_7_0] or GameHelpMultiItem.New((Object.Instantiate(self.infoItemGo_, self.infoItemRootTrs_)))

		self.infoItems_[iter_7_0]:SetData(var_7_0[iter_7_0], var_7_1[iter_7_0])
		self.infoItems_[iter_7_0]:Show(true)
	end

	for iter_7_1 = #var_7_0 + 1, #self.infoItems_ do
		self.infoItems_[iter_7_1]:Show(false)
	end

	self.scrollView_.normalizedPosition = Vector2(0, 1)
end

function GameHelpMultiView:OnExit()
	self:RecordStay(self.params_.key)
end

function GameHelpMultiView:RecordStay(arg_9_1)
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

return GameHelpMultiView
