local WorkBenchItem = class("WorkBenchItem", import("model.vo.BaseVO"))

function WorkBenchItem:bindConfigTable()
	return pg.activity_workbench_item
end

function WorkBenchItem:Ctor(...)
	WorkBenchItem.super.Ctor(self, ...)

	self.count = self.count or 0

	return
end

function WorkBenchItem:GetName()
	return self:getConfig("name")
end

function WorkBenchItem:GetRarity()
	return self:getConfig("rarity")
end

function WorkBenchItem:GetIconPath()
	return "props/" .. self:getConfig("icon")
end

function WorkBenchItem:GetDesc()
	return self:getConfig("display")
end

function WorkBenchItem:GetSource()
	return self:getConfig("get_access")
end

function WorkBenchItem:UpdateDrop(arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}

	local var_8_0 = ItemRarity.Rarity2Print(arg_8_1:GetRarity())

	setImageSprite(findTF(self, "icon_bg"), GetSpriteFromAtlas("weaponframes", "bg" .. var_8_0))
	setFrame(findTF(self, "icon_bg/frame"), var_8_0)
	GetImageSpriteFromAtlasAsync(arg_8_1:GetIconPath(), "", (findTF(self, "icon_bg/icon")))
	setIconStars(self, false)
	setIconName(self, arg_8_1:GetName(), arg_8_2)
	setIconColorful(self, arg_8_1:GetRarity(), arg_8_2)

	return
end

return WorkBenchItem
