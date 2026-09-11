local DormDispatchAwardItem = class("DormDispatchAwardItem", ReduxView)

function DormDispatchAwardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormDispatchAwardItem:Init()
	self:InitUI()

	self.item = CommonItemView.New(self.commonitemGo_1)
end

function DormDispatchAwardItem:InitUI()
	self:BindCfgUI()
end

function DormDispatchAwardItem:RefreshUI(arg_4_1)
	self.extraText_.text = arg_4_1.extraNum and string.format("+%d", arg_4_1.extraNum) or ""

	self.item:SetData({
		id = arg_4_1.id,
		number = arg_4_1.num,
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	})
end

function DormDispatchAwardItem:Dispose()
	if self.item then
		self.item:Dispose()

		self.item = nil
	end

	DormDispatchAwardItem.super.Dispose(self)
end

return DormDispatchAwardItem
