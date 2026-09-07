local EducateItem = class("EducateItem", import("model.vo.BaseVO"))

EducateItem.TYPE_BOOK = 1
EducateItem.TYPE_MUSICAL = 2
EducateItem.TYPE_TOOL = 3
EducateItem.TYPE_SUDRIES = 4
EducateItem.RARITY2FRAME = {
	"rarity_grey",
	"rarity_green",
	"rarity_blue",
	"rarity_purple",
	"rarity_orange"
}
EducateItem.USE_TYPE_UNDEFINED = "usage_undefined"
EducateItem.USE_TYPE_DROP = "usage_drop"

function EducateItem:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.count = arg_1_1.num or 0

	return
end

function EducateItem:bindConfigTable()
	return pg.child_item
end

function EducateItem:CanUse()
	return self:getConfig("usage") ~= EducateItem.USE_TYPE_UNDEFINED
end

function EducateItem:IsEnough(arg_4_1)
	return arg_4_1 <= self.count
end

function EducateItem:Consume(arg_5_1)
	self.count = self.count - arg_5_1

	return
end

function EducateItem:AddCount(arg_6_1)
	self.count = self.count + arg_6_1

	return
end

function EducateItem:GetType()
	return self:getConfig("type")
end

function EducateItem:GetIcon()
	return self:getConfig("icon")
end

function EducateItem:GetName()
	return self:getConfig("name")
end

function EducateItem:GetRarity()
	return self:getConfig("rarity")
end

function EducateItem:GetFrameName()
	return EducateItem.RARITY2FRAME[self:GetRarity()]
end

function EducateItem:IsShow()
	return self:getConfig("is_show") == 1
end

function EducateItem:GetShowInfo()
	return {
		type = EducateConst.DROP_TYPE_ITEM,
		id = self.id,
		number = self.count
	}
end

return EducateItem
