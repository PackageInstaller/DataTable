local DamageTestModeView = class("DamageTestModeView", ReduxView)

function DamageTestModeView:UIName()
	return "UI/DamageTest/DamageTestModeUI"
end

function DamageTestModeView:UIParent()
	return manager.ui.uiMain.transform
end

function DamageTestModeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.btnTransform_, "conName")
	self.deadManItem_ = DamageTestModeItem.New(self.deadManGo_, 1)
	self.combatItem_ = DamageTestModeItem.New(self.combatGo_, 2)
	self.moveManItem_ = DamageTestModeItem.New(self.moveManGo_, 3)
	self.chooseHandler_ = handler(self, self.ChooseItemMode)

	self.deadManItem_:RegistClickFunc(self.chooseHandler_)
	self.combatItem_:RegistClickFunc(self.chooseHandler_)
	self.moveManItem_:RegistClickFunc(self.chooseHandler_)
end

function DamageTestModeView:ChooseItemMode(arg_4_1)
	self.chooseIndex_ = arg_4_1

	self.deadManItem_:RefreshUI(arg_4_1)
	self.combatItem_:RefreshUI(arg_4_1)
	self.moveManItem_:RefreshUI(arg_4_1)
	self:RefreshUI()
end

function DamageTestModeView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

function DamageTestModeView:OnExit()
	self.chooseIndex_ = nil

	self.deadManItem_:RefreshUI(self.chooseIndex_)
	self.combatItem_:RefreshUI(self.chooseIndex_)
	self.moveManItem_:RefreshUI(self.chooseIndex_)
	manager.windowBar:HideBar()
end

function DamageTestModeView:Dispose()
	DamageTestModeView.super.Dispose(self)

	self.chooseHandler_ = nil
end

function DamageTestModeView:AddListeners()
	self:AddBtnListener(self.chooseBtn_, nil, function()
		if self.chooseIndex_ == nil then
			return
		end

		self:ClickBtn()
	end)
end

function DamageTestModeView:ClickBtn()
	if self.chooseIndex_ == 1 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 0
		})
	elseif self.chooseIndex_ == 2 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 1
		})
	elseif self.chooseIndex_ == 3 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 2
		})
	end
end

function DamageTestModeView:RefreshUI()
	self:RefreshMode(self.chooseIndex_)
end

function DamageTestModeView:RefreshMode(arg_12_1)
	self.chooseIndex_ = arg_12_1

	if arg_12_1 then
		self.selectController_:SetSelectedState("yellow")
	else
		self.selectController_:SetSelectedState("black")
	end
end

return DamageTestModeView
