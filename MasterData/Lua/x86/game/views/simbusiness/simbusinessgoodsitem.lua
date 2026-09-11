local SimBusinessGoodsItem = class("SimBusinessGoodsItem", BaseView)

function SimBusinessGoodsItem:Ctor(arg_1_1)
	SimBusinessGoodsItem.super.Ctor(self)

	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessGoodsItem:Init()
	self:BindCfgUI()

	self.emptyController = self.controllerExCollection_:GetController("empty")
	self.typeController = self.controllerExCollection_:GetController("category")
	self.selectController = self.controllerExCollection_:GetController("select")
	self.lockController = self.controllerExCollection_:GetController("UnlockCondition")

	self:AddUIListener()
end

function SimBusinessGoodsItem:Dispose()
	SimBusinessGoodsItem.super.Dispose(self)
end

function SimBusinessGoodsItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		end
	end)
end

function SimBusinessGoodsItem:RefreshData(arg_6_1)
	self.id = arg_6_1

	local var_6_0 = nullable(SimBusinessGoodsCfg, arg_6_1)

	if var_6_0 then
		self.emptyController:SetSelectedState("off")

		self.iconImage_.sprite = SimBusinessTools.GetGoodsIcon(arg_6_1)

		local var_6_1, var_6_2 = SimBusinessTools.GetGoodLockState(arg_6_1)

		if var_6_1 and var_6_2 ~= SimBusinessTools.State.LOCK_BY_LEVEL then
			self.lockController:SetSelectedState("canUnlock")
		else
			self.lockController:SetSelectedState("normal")
		end

		self.typeController:SetSelectedState(tostring(var_6_0.type))
	else
		self.emptyController:SetSelectedState("on")
		self.typeController:SetSelectedState("0")
	end
end

function SimBusinessGoodsItem:RefreshSelect(arg_7_1)
	self.selectController:SetSelectedState(arg_7_1 and "true" or "false")
end

function SimBusinessGoodsItem:RegisterClick(arg_8_1)
	self.clickFunc = arg_8_1
end

function SimBusinessGoodsItem:DefaultClickFunc()
	manager.notify:CallFirstUpdateFunc("OnGoodsItemClick", self.id)
end

function SimBusinessGoodsItem:UseDefaultClick()
	if self.clickFunc == nil then
		self:RegisterClick(handler(self, self.DefaultClickFunc))
	end
end

return SimBusinessGoodsItem
