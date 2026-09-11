local RechargeTitleItem = class("RechargeTitleItem", BaseView)

function RechargeTitleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RechargeTitleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeTitleItem:InitUI()
	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "select")
	self.selectLock = ControllerUtil.GetController(self.gameObject_.transform, "select_lock")
	self.upSelectLock = ControllerUtil.GetController(self.gameObject_.transform, "upselect_lock")
end

function RechargeTitleItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.data = arg_4_1
	self.index = arg_4_2
	self.callback = arg_4_3
	self.shopId = arg_4_4

	self:UpdateView()
end

function RechargeTitleItem:UpdateView()
	return
end

function RechargeTitleItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.callback then
			self.callback(self.index)
		end
	end)
end

function RechargeTitleItem:UpdateView()
	self.nameTxt1_.text = self.data.remark
	self.nameTxt2_.text = self.data.remark

	local var_8_0 = ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[self.shopId] and ShopTools.IsLimitRecharge() or not ShopTools.CheckShopIsUnLock(self.shopId)

	self.selectLock:SetSelectedState(var_8_0 and "on" or "off")
	self.upSelectLock:SetSelectedState(var_8_0 and "on" or "off")
end

return RechargeTitleItem
