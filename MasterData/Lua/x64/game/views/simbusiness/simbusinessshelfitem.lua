local SimBusinessShelfItem = class("SimBusinessShelfItem", BaseView)

function SimBusinessShelfItem:Ctor(arg_1_1)
	SimBusinessShelfItem.super.Ctor(self)

	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SimBusinessShelfItem:Init()
	self:BindCfgUI()

	self.levelController = self.controllerExCollection_:GetController("quality")
	self.selectController = self.controllerExCollection_:GetController("select")

	self:AddUIListener()
end

function SimBusinessShelfItem:Dispose()
	SimBusinessShelfItem.super.Dispose(self)
end

function SimBusinessShelfItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		else
			manager.notify:CallFirstUpdateFunc("OnShelfItemClick", self.id)
		end
	end)
end

local var_0_1 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}

function SimBusinessShelfItem:RefreshData(arg_6_1)
	self.iconImage_.sprite = SimBusinessTools.GetShelfIcon(arg_6_1)

	local var_6_1 = SimBusinessData:GetShelfLevel(arg_6_1)

	if var_6_1 == 0 then
		self.levelController:SetSelectedState("off")
	else
		self.levelController:SetSelectedState(var_0_1[var_6_1] or var_0_1[#var_0_1])
	end
end

function SimBusinessShelfItem:RefreshSelect(arg_7_1)
	self.selectController:SetSelectedState(arg_7_1 and "true" or "false")
end

function SimBusinessShelfItem:RegisterClick(arg_8_1)
	self.clickFunc = arg_8_1
end

return SimBusinessShelfItem
