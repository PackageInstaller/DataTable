local DormAwardItem = class("DormAwardItem", ReduxView)

function DormAwardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormAwardItem:Init()
	self:InitUI()

	self.item = CommonItemView.New(self.commonitemGo_1)
end

function DormAwardItem:InitUI()
	self:BindCfgUI()
end

function DormAwardItem:RefreshUI(arg_4_1)
	self.extraText_.text = arg_4_1.name and arg_4_1.name or ""

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

function DormAwardItem:Dispose()
	if self.item then
		self.item:Dispose()

		self.item = nil
	end

	DormAwardItem.super.Dispose(self)
end

return DormAwardItem
