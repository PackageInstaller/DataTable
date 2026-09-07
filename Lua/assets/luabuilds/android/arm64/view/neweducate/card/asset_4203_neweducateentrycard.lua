local NewEducateEntryCard = class("NewEducateEntryCard")

function NewEducateEntryCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.iconTF = self._tf:Find("icon/Image")
	self.levelText = self._tf:Find("level/Text"):GetComponent(typeof(Text))
	self.nameText = self._tf:Find("name"):GetComponent(typeof(Text))
	self.descText = self._tf:Find("desc/content/Text"):GetComponent(typeof(Text))
	self.countText = self._tf:Find("desc/content/effect"):GetComponent(typeof(Text))

	return
end

function NewEducateEntryCard:Update(arg_2_1)
	self.id = arg_2_1
	self.config = pg.child2_benefit_list[arg_2_1]
	self.levelText.text = GetRomanDigitPlus(self.config.rare)
	self.nameText.text = self.config.name
	self.descText.text = self.config.simple_desc
	self.countText.text = ""

	LoadImageSpriteAsync("neweducateicon/" .. self.config.item_icon, self.iconTF, true)
	LoadImageSpriteAtlasAsync("ui/neweducateentrycard_atlas", self.config.benefit_level > 1 and "bg_entry_2" or "bg_entry", self._tf:Find("icon"))

	return
end

function NewEducateEntryCard:UpdateDescMode(arg_3_1)
	if arg_3_1 then
		self.descText.text = self.config.desc or self.config.simple_desc
	end

	return
end

function NewEducateEntryCard:UpdateCountDesc()
	local var_4_0 = getProxy(NewEducateProxy):GetCurChar()
	local var_4_1 = var_4_0:GetBenefitData()
	local var_4_2 = string.gsub(Clone(self.config.count_desc), "{(%d+),%$val}", function(arg_5_0)
		return var_4_1:GetBuff(self.id):GetDisplayNum(arg_5_0)
	end)
	local var_4_3 = var_4_1:GetDisplayCounterData(self.config.debuff_tag)

	if var_4_0 then
		var_4_2 = string.gsub(var_4_2, "{(%d+),(%d+),(%d+)}", function(arg_6_0, arg_6_1, arg_6_2)
			return var_4_3:GetValue(arg_6_0, arg_6_1, arg_6_2)
		end)
	end

	self.countText.text = var_4_2

	return
end

function NewEducateEntryCard:Dispose()
	return
end

function NewEducateEntryCard:StaticShow(arg_8_1)
	local var_8_0 = pg.child2_benefit_list[arg_8_1]

	setText(self:Find("level/Text"), GetRomanDigitPlus(pg.child2_benefit_list[arg_8_1].rare))
	setText(self:Find("name"), var_8_0.name)
	setText(self:Find("desc/content/Text"), var_8_0.desc)
	setText(self:Find("desc/content/effect"), "")
	LoadImageSpriteAsync("neweducateicon/" .. var_8_0.item_icon, self:Find("icon/Image"), true)
	LoadImageSpriteAtlasAsync("ui/neweducateentrycard_atlas", var_8_0.benefit_level > 1 and "bg_entry_2" or "bg_entry", self:Find("icon"))

	return
end

return NewEducateEntryCard
