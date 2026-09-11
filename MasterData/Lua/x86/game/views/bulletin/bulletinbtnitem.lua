local BulletinBtnItem = class("BulletinBtnItem", ReduxView)

function BulletinBtnItem:OnCtor(arg_1_1, arg_1_2)
	self.clickHandler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function BulletinBtnItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function BulletinBtnItem:InitUI()
	self:BindCfgUI()

	self.selectedController_ = ControllerUtil.GetController(self.gameObject_.transform, "selected")
	self.newController_ = ControllerUtil.GetController(self.gameObject_.transform, "new")
end

function BulletinBtnItem:AddUIListener()
	self:AddBtnListener("", nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.data_)
			self:UpdateView()
		end
	end)
end

function BulletinBtnItem:SetData(arg_6_1)
	self.data_ = arg_6_1

	self:UpdateView()
end

function BulletinBtnItem:UpdateView()
	local var_7_0 = self.data_.i18n_info_name[SettingData:GetCurrentLanguage()] or self.data_.name

	self.content_.text = GetI18NText(var_7_0)
	self.content1_.text = GetI18NText(var_7_0)

	if not getData("bulletin", "bulletin_" .. self.data_.id) and manager.time:GetServerTime() < self.data_.endTime then
		self.newController_:SetSelectedState("true")
	else
		self.newController_:SetSelectedState("false")
	end
end

function BulletinBtnItem:SetSelected(arg_8_1)
	self.selectedController_:SetSelectedState(arg_8_1 and "true" or "false")
	self:UpdateView()
end

function BulletinBtnItem:OnEnter()
	return
end

function BulletinBtnItem:OnExit()
	return
end

function BulletinBtnItem:Dispose()
	self:RemoveAllListeners()
	self.transform_:SetParent(nil)
	Object.Destroy(self.gameObject_)
	BulletinBtnItem.super.Dispose(self)
end

return BulletinBtnItem
