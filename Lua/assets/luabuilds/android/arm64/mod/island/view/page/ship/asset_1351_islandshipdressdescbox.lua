local IslandShipDressDescBox = class("IslandShipDressDescBox", import("view.base.BaseSubView"))

IslandShipDressDescBox.TYPE = {
	SKIN = 2,
	DRESS = 1
}
IslandShipDressDescBox.DRESS_TGA_TWINS = 1
IslandShipDressDescBox.DRESS_TAG_SP_ANIMATOR = 2
IslandShipDressDescBox.TAG2NAME = {
	[IslandShipDressDescBox.DRESS_TGA_TWINS] = i18n("island_dress_tag_twins"),
	[IslandShipDressDescBox.DRESS_TAG_SP_ANIMATOR] = i18n("island_dress_tag_sp_animator")
}

function IslandShipDressDescBox:getUIName()
	return "IslandShipDressDescUI"
end

function IslandShipDressDescBox:OnLoaded()
	self.tagUIList = UIItemList.New(self.uiTagsTF, self.uiTagsTF:Find("tpl"))

	return
end

function IslandShipDressDescBox:OnInit()
	self.tagUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setScrollText(arg_4_2:Find("mask/Text"), IslandShipDressDescBox.TAG2NAME[self.tagList[arg_4_1 + 1]])
		end

		return
	end)

	return
end

function IslandShipDressDescBox:Show(arg_5_1, arg_5_2, arg_5_3)
	setAnchoredPosition(self.uiPanelTF, arg_5_3)

	self.type = arg_5_1
	self.id = arg_5_2

	if self.type == IslandShipDressDescBox.TYPE.DRESS then
		self.cfg = pg.island_dress_template[arg_5_2] or pg.island_skin_template[arg_5_2]
	end

	setText(self.uiNameText, self.cfg.name)
	setText(self.uiDescText, self.cfg.desc)

	self.tagList = {}

	if self.cfg.tag and type(self.cfg.tag) == "table" then
		for iter_5_0, iter_5_1 in ipairs(self.cfg.tag) do
			table.insert(self.tagList, iter_5_1)
		end
	end

	setActive(self.uiTagsTF, #self.tagList > 0)
	self.tagUIList:align(#self.tagList)
	self.super.Show(self)

	return
end

return IslandShipDressDescBox
