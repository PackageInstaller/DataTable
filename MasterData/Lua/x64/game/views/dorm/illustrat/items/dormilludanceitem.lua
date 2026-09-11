local DormIlluDanceItem = class("DormIlluDanceItem", ReduxView)

function DormIlluDanceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormIlluDanceItem:InitUI()
	self:BindCfgUI()

	self.unLockController_ = self.mainControllerEx_:GetController("have")

	self:AddUIListener()
end

function DormIlluDanceItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		self.clickFunc_(self.danceID_, self.index_)
	end)
end

function DormIlluDanceItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.danceID_ = arg_5_2
	self.isUnlock_ = IdolTraineeData:DanceDIYActionAvailable(self.danceID_)

	self:RefreshUI()
end

function DormIlluDanceItem:RefreshUI()
	self.unLockController_:SetSelectedIndex(self.isUnlock_ and 1 or 0)

	self.bgImg_.sprite = getSpriteViaConfig("IdolDanceRoleIcon", self.danceID_)
	self.nameText_.text = IdolDanceDIYActionCfg[self.danceID_].name
end

function DormIlluDanceItem:SetUnlock(arg_7_1)
	self.unLockController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function DormIlluDanceItem:RegistCallBack(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function DormIlluDanceItem:Dispose()
	DormIlluDanceItem.super.Dispose(self)
end

return DormIlluDanceItem
