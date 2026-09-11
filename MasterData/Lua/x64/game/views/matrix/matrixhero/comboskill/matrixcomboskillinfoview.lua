local MatrixComboSkillInfoView = class("MatrixComboSkillInfoView", ReduxView)

function MatrixComboSkillInfoView:UIBackCount()
	return 3
end

function MatrixComboSkillInfoView:UIName()
	return "UI/MatrixHero/MatrixComboSkillInfoUI"
end

function MatrixComboSkillInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixComboSkillInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.comboSkillUIList_ = LuaList.New(handler(self, self.RefreshComboSkillItem), self.uiList_, MatrixComboSkillItem)
end

function MatrixComboSkillInfoView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixMiniHero")
	end)
end

function MatrixComboSkillInfoView:OnEnter()
	self.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(self.params_.heroId)

	self.comboSkillUIList_:StartScroll(#self.comboSkillList_, 1)
end

function MatrixComboSkillInfoView:Dispose()
	MatrixComboSkillInfoView.super.Dispose(self)

	if self.comboSkillUIList_ then
		self.comboSkillUIList_:Dispose()

		self.comboSkillUIList_ = nil
	end
end

function MatrixComboSkillInfoView:RefreshComboSkillItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshUI(self.comboSkillList_[arg_9_1])
end

return MatrixComboSkillInfoView
