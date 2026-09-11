local DormLinkGameMaterialItem = class("DormLinkGameMaterialItem", ReduxView)

function DormLinkGameMaterialItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormLinkGameMaterialItem:Init()
	self:InitUI()
end

function DormLinkGameMaterialItem:InitUI()
	self:BindCfgUI()
end

function DormLinkGameMaterialItem:RefreshUI(arg_4_1)
	self.itemID = arg_4_1[1]
	self.iconImg_.sprite = ItemTools.getItemSprite(tonumber(ActivityLinkGameCellCfg[self.itemID].album_id))
	self.numText_.text = string.format("%d/%d", DormLinkGameData:GetDisposeMaterialNum(self.itemID), arg_4_1[2])
end

function DormLinkGameMaterialItem:Dispose()
	DormLinkGameMaterialItem.super.Dispose(self)
end

return DormLinkGameMaterialItem
