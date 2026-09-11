local TipsShortItemView = import("manager.tips.TipsShortItemView")
local var_0_1 = 1
local TipsShortView = class("TipsShortView")

function TipsShortView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()

	self.itemList_ = {}
	self.queue_ = {}
end

function TipsShortView:InitUI()
	self.tips_ = self.transform_:Find("shortTip").gameObject
	self.grid_ = self.transform_:Find("shortGrid").gameObject
end

function TipsShortView:ShowTips(arg_3_1, arg_3_2, arg_3_3)
	if self.itemList_ == nil then
		return
	end

	self:GetFreeItem():RefreshUI(arg_3_1, arg_3_2, arg_3_3)
end

function TipsShortView:GetFreeItem()
	for iter_4_0, iter_4_1 in ipairs(self.itemList_) do
		if iter_4_1:IsFree() then
			table.insert(self.queue_, iter_4_0)

			return iter_4_1
		end
	end

	if #self.itemList_ < var_0_1 then
		local var_4_0 = TipsShortItemView.New(self, self.tips_, self.grid_)

		table.insert(self.itemList_, var_4_0)
		table.insert(self.queue_, #self.itemList_)

		return var_4_0
	end

	local var_4_1 = self.queue_[1]

	table.remove(self.queue_, 1)
	table.insert(self.queue_, var_4_1)
	self.itemList_[var_4_1]:FastFinish()

	return self.itemList_[var_4_1]
end

function TipsShortView:Finish()
	table.remove(self.queue_, 1)
	self.itemList_[self.queue_[1]]:SetFree(true)
end

function TipsShortView:Dispose()
	if self.itemList_ then
		for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
			iter_6_1:Dispose()
		end

		self.itemList_ = nil
	end

	self.tips_ = nil
	self.transform_ = nil
	self.gameObject_ = nil
	self.grid_ = nil
end

return TipsShortView
