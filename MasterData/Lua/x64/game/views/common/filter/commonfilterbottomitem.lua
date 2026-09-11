local CommonFilterBottomItem = class("CommonFilterBottomItem", ReduxView)

function CommonFilterBottomItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonFilterBottomItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CommonFilterBottomItem:InitUI()
	self:BindCfgUI()
end

function CommonFilterBottomItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.info_)
		end
	end)
end

function CommonFilterBottomItem:Refresh(arg_6_1)
	self.info_ = arg_6_1
	self.nameText_.text = self.info_.name

	SetActive(self.gameObject_, true)
end

function CommonFilterBottomItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function CommonFilterBottomItem:Dispose()
	CommonFilterBottomItem.super.Dispose(self)
end

return CommonFilterBottomItem
