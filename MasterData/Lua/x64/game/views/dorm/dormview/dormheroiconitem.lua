local DormHeroIconItem = class("DormHeroIconItem", ReduxView)

function DormHeroIconItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormHeroIconItem:InitUI()
	self:BindCfgUI()
end

function DormHeroIconItem:RefreshUI(arg_3_1)
	self.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_3_1)
end

function DormHeroIconItem:Dispose()
	DormHeroIconItem.super.Dispose(self)
end

return DormHeroIconItem
