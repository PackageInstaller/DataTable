local TipsLongItemView = import("manager.tips.TipsLongItemView")
local var_0_1 = 3
local TipsLongView = class("TipsLongView")

function TipsLongView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()

	self.itemList_ = {}
	self.queue_ = {}
end

function TipsLongView:InitUI()
	self.tipsTemplate_ = Asset.Load("Widget/System/Com_dynamic/TipsUI")
	self.grid_ = self.transform_:Find("longGrid").gameObject
end

function TipsLongView:ShowTips(arg_3_1)
	if self.itemList_ == nil then
		return
	end

	self:GetFreeItem():RefreshUI(arg_3_1)
end

function TipsLongView:GetFreeItem()
	for iter_4_0, iter_4_1 in ipairs(self.itemList_) do
		if iter_4_1:IsFree() then
			table.insert(self.queue_, iter_4_0)

			return iter_4_1
		end
	end

	if #self.itemList_ < var_0_1 then
		local var_4_0 = TipsLongItemView.New(self, self.tipsTemplate_, self.grid_)

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

function TipsLongView:Finish()
	table.remove(self.queue_, 1)
	self.itemList_[self.queue_[1]]:SetFree(true)
end

function TipsLongView:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.itemList_ = nil
	self.grid_ = nil
	self.tipsTemplate_ = nil
	self.transform_ = nil
	self.gameObject_ = nil
end

return TipsLongView
