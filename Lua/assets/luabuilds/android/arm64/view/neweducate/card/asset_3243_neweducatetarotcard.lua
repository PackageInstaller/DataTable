local NewEducateTarotCard = class("NewEducateTarotCard")

NewEducateTarotCard.TYPE = {
	CURRENT = 1,
	CHOICE = 2,
	REPLACE = 3
}
NewEducateTarotCard.TYPE2TAG = {
	[NewEducateTarotCard.TYPE.CURRENT] = i18n("child2_tarot_tag_current"),
	[NewEducateTarotCard.TYPE.CHOICE] = "",
	[NewEducateTarotCard.TYPE.REPLACE] = i18n("child2_tarot_tag_replace")
}

function NewEducateTarotCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.whiteBgTF = self._tf:Find("bg_white")
	self.blueBgTF = self._tf:Find("bg_blue")
	self.iconTF = self._tf:Find("icon")
	self.simpleTF = self._tf:Find("simple")
	self.tagTF = self.simpleTF:Find("tag")
	self.tagText = self.tagTF:Find("Text"):GetComponent(typeof(Text))
	self.simpleNameText = self.simpleTF:Find("name/Text"):GetComponent(typeof(Text))
	self.simpleDescText = self.simpleTF:Find("desc/Text"):GetComponent(typeof(Text))
	self.detailTF = self._tf:Find("detail")
	self.detailNameText = self.detailTF:Find("name"):GetComponent(typeof(Text))
	self.detailDescText = self.detailTF:Find("desc/Text"):GetComponent(typeof(Text))

	return
end

function NewEducateTarotCard:Update(arg_2_1, arg_2_2)
	self.type = arg_2_2 or NewEducateTarotCard.TYPE.CHOICE
	self.id = arg_2_1
	self.config = pg.child2_benefit_list[arg_2_1]
	self.simpleNameText.text = self.config.name
	self.detailNameText.text = self.config.name
	self.simpleDescText.text = self.config.simple_desc
	self.detailDescText.text = self.config.desc

	LoadImageSpriteAsync("neweducateicon/" .. self.config.item_icon, self.iconTF)
	setActive(self.blueBgTF, self.type == NewEducateTarotCard.TYPE.CURRENT)
	setActive(self.whiteBgTF, self.type == NewEducateTarotCard.TYPE.CHOICE or self.type == NewEducateTarotCard.TYPE.REPLACE)
	setActive(self.tagTF, self.type ~= NewEducateTarotCard.TYPE.CHOICE)

	self.tagText.text = NewEducateTarotCard.TYPE2TAG[self.type]

	return
end

function NewEducateTarotCard:UpdateDescMode(arg_3_1)
	setActive(self.simpleTF, not arg_3_1)
	setActive(self.detailTF, arg_3_1)

	return
end

function NewEducateTarotCard:Dispose()
	return
end

function NewEducateTarotCard:StaticShow(arg_5_1)
	setText(self:Find("simple/name/Text"), pg.child2_benefit_list[arg_5_1].name)
	setText(self:Find("detail/name"), pg.child2_benefit_list[arg_5_1].name)
	setText(self:Find("simple/desc/Text"), pg.child2_benefit_list[arg_5_1].simple_desc)
	setText(self:Find("detail/desc/Text"), pg.child2_benefit_list[arg_5_1].desc)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[arg_5_1].item_icon, self:Find("icon"))

	return
end

return NewEducateTarotCard
