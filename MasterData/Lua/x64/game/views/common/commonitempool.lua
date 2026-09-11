local CommonItemPool = class("CommonItemPool", ReduxView)

function CommonItemPool:GetItemPath()
	if self.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function CommonItemPool:OnCtor(arg_2_1, arg_2_2, arg_2_3)
	self.isSmall_ = arg_2_3
	self.gameObject_ = manager.objectPool:Get(self:GetItemPath())
	self.transform_ = self.gameObject_.transform

	self.gameObject_.transform:SetParent(arg_2_1.transform)

	self.commonItem_ = CommonItemView.New(self.gameObject_)
	self.commonItem_.itemCanvasGroup_.alpha = 1

	self:SetData(arg_2_2)
end

function CommonItemPool:SetData(arg_3_1)
	self.commonItem_:SetData(arg_3_1)
end

function CommonItemPool:Dispose()
	CommonItemPool.super.Dispose(self)
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	manager.objectPool:Return(self:GetItemPath(), self.gameObject_)
end

function CommonItemPool:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return CommonItemPool
