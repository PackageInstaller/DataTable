local HardLevelBaseItem = class("HardLevelBaseItem", ReduxView)

function HardLevelBaseItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.hardLevel_ = arg_1_2

	self:Init()
end

function HardLevelBaseItem:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.lockController_ = self.controllerEx_:GetController("lock")
end

function HardLevelBaseItem:OnEnter()
	self:IsLock()
	self:RefreshItem()
end

function HardLevelBaseItem:OnExit()
	return
end

function HardLevelBaseItem:Dispose()
	HardLevelBaseItem.super.Dispose(self)
end

function HardLevelBaseItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			self:LockTips()

			return
		end

		self:ClickBtn()
	end)
end

function HardLevelBaseItem:LockTips()
	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function HardLevelBaseItem:ClickBtn()
	return
end

function HardLevelBaseItem:RefreshItem()
	self.lockController_:SetSelectedState(tostring(self.isLock_))

	self.hardText_.text = GetTips(BattleConst.HARD_LANGUAGE[self.hardLevel_])
end

function HardLevelBaseItem:SetSiblingIndex(arg_11_1)
	self.transform_:SetSiblingIndex(arg_11_1)
end

function HardLevelBaseItem:IsLock()
	self.isLock_ = false
end

return HardLevelBaseItem
