local DuckItem = class("DuckItem", ReduxView)

function DuckItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DuckItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(nil, nil, "OnClick")
end

function DuckItem:RefreshData(arg_3_1, arg_3_2, arg_3_3)
	self.index_ = arg_3_1
	self.data_ = arg_3_3 and ActivityDuckCfg[arg_3_2]
	self.imgDuck_.sprite = arg_3_3 and getSpriteWithoutAtlas(self.data_.icon)
end

function DuckItem:RegisterClick(arg_4_1)
	self.clickFunc = arg_4_1
end

function DuckItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.index_)
	end
end

function DuckItem:Dispose()
	self.clickFunc = nil

	DuckItem.super.Dispose(self)
end

return DuckItem
