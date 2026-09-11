local WeaponModuleGodItem = class("WeaponModuleGodItem", ReduxView)

function WeaponModuleGodItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponModuleGodItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function WeaponModuleGodItem:InitUI()
	self:BindCfgUI()

	self.statucontroller_ = ControllerUtil.GetController(self.transform_, "type")
	self.selectcontroller_ = ControllerUtil.GetController(self.transform_, "select")
end

function WeaponModuleGodItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.selectCallBack_ then
			self.selectCallBack_(self.index_)
		end
	end)
end

function WeaponModuleGodItem:SetSelectCallBack(arg_6_1)
	self.selectCallBack_ = arg_6_1
end

function WeaponModuleGodItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.index_ = arg_7_1

	if self.index_ == arg_7_2 then
		self.selectcontroller_:SetSelectedState("true")
	else
		self.selectcontroller_:SetSelectedState("false")
	end

	self.nameText_.text = GetI18NText(HeroAstrolabeCfg[arg_7_3].suit_name) .. "·" .. GetI18NText(HeroAstrolabeCfg[arg_7_3].name)
end

function WeaponModuleGodItem:Dispose()
	WeaponModuleGodItem.super.Dispose(self)

	self.selectCallBack_ = nil
end

return WeaponModuleGodItem
