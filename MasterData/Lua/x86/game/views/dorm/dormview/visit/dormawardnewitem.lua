local DormAwardNewItem = class("DormAwardNewItem", ReduxView)

function DormAwardNewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormAwardNewItem:Init()
	self:InitUI()

	self.item = CommonItemView.New(self.commonItem_)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self.commonPortrait_:RegisteClickCallback(function()
		local var_3_0 = self:GetUserID()

		if var_3_0 then
			ForeignInfoAction:TryToCheckForeignDetailInfo(var_3_0)
		end
	end)
end

function DormAwardNewItem:InitUI()
	self:BindCfgUI()
end

function DormAwardNewItem:GetUserID()
	if self.data then
		return self.data.user.id
	end

	return nil
end

function DormAwardNewItem:RefreshUI(arg_6_1)
	self.data = arg_6_1
	self.nickName.text = arg_6_1.name and arg_6_1.user.name or ""

	self.commonPortrait_:RenderHead(arg_6_1.user.icon)
	self.commonPortrait_:RenderFrame(arg_6_1.user.icon_frame)
	self.item:SetData({
		id = arg_6_1.id,
		number = arg_6_1.num,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	})
end

function DormAwardNewItem:Dispose()
	if self.item then
		self.item:Dispose()

		self.item = nil
	end

	if self.commonPortrait_ then
		self.commonPortrait_:Dispose()
	end

	DormAwardNewItem.super.Dispose(self)
end

return DormAwardNewItem
