local StageArchiveView = class("StageArchiveView", ReduxView)

function StageArchiveView:UIName()
	return "Widget/System/Operation/OperationDiaryUI"
end

function StageArchiveView:UIParent()
	return manager.ui.uiPop.transform
end

function StageArchiveView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.clueController_ = self.controllerEx_:GetController("verClue")
end

function StageArchiveView:OnEnter()
	local var_4_0 = self.params_.archiveID

	if self.params_.isClue then
		self.clueController_:SetSelectedState("state1")
	else
		self.clueController_:SetSelectedState("state0")
	end

	local var_4_1 = StageArchiveCfg[var_4_0]

	self.nameText_.text = formatText(StageArchiveCfg[var_4_0].name)
	self.archiveText_.text = formatText(var_4_1.desc)

	if self.iconImage_ then
		self.iconImage_.sprite = pureGetSpriteWithoutAtlas(var_4_1.iconPath)
	end

	self.scrollView_.verticalNormalizedPosition = 1
end

function StageArchiveView:OnExit()
	if self.iconImage_ then
		self.iconImage_.sprite = nil
	end
end

function StageArchiveView:Dispose()
	StageArchiveView.super.Dispose(self)
end

function StageArchiveView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

return StageArchiveView
