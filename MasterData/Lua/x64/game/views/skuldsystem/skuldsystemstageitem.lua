local SkuldSystemStageItem = class("SkuldSystemStageItem", ReduxView)

function SkuldSystemStageItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2
	self.levelID_ = arg_1_3
	self.cfg_ = SkuldStageCfg[self.levelID_]
	self.selectHandler_ = arg_1_4

	self:Init()
	self:RefreshUI()
end

function SkuldSystemStageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SkuldSystemStageItem:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controllerEx_:GetController("lock")
	self.typeController_ = self.controllerEx_:GetController("type")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.completeController_ = self.controllerEx_:GetController("complete")
end

function SkuldSystemStageItem:RefreshUI()
	self.levelNameText_.text = self.cfg_.name

	if SkuldSystemData:GetLevelIDIsOpen(self.levelID_) then
		self.lockController_:SetSelectedState("false")
	else
		self.lockController_:SetSelectedState("true")
	end

	if SkuldSystemData:GetLevelIDIsClear(self.levelID_) then
		self.completeController_:SetSelectedState("true")
	else
		self.completeController_:SetSelectedState("false")
	end

	if self.cfg_.type[1] == 1 then
		self.typeController_:SetSelectedState("plot")
	elseif self.cfg_.type[1] == 2 then
		self.typeController_:SetSelectedState("schedule")
	end
end

function SkuldSystemStageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.selectHandler_ then
			self.selectHandler_(self.index_, self.levelID_)
		end

		JumpTools.OpenPageByJump("skuldSystemStageSectionView", {
			levelID = self.levelID_,
			battleType = BattleConst.STAGE_TYPE_NEW.SKULD
		})
	end)
end

function SkuldSystemStageItem:RefreshSelect(arg_7_1)
	if self.levelID_ == arg_7_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function SkuldSystemStageItem:Dispose()
	SkuldSystemStageItem.super.Dispose(self)
end

return SkuldSystemStageItem
