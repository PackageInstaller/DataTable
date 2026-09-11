local StoreItemSource = class("StoreItemSource", ReduxView)

function StoreItemSource:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.accessbtnControllerexcollection_:GetController("btnState")
end

function StoreItemSource:Dispose()
	StoreItemSource.super.Dispose(self)
end

function StoreItemSource:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		JumpTools.JumpToPage2(self.sourceData_)
	end)
end

function StoreItemSource:SetData(arg_5_1)
	self.sourceData_ = arg_5_1

	if JumpTools.GetLinkIsLocked(arg_5_1) then
		self.stateController_:SetSelectedState("locked")
	else
		self.stateController_:SetSelectedState("unlocked")
	end

	self.nameText_.text, self.frontText_.text = JumpTools.GetName(arg_5_1)
end

return StoreItemSource
