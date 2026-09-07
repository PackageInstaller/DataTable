local GuildTaskCard = class("GuildTaskCard")

function GuildTaskCard:Ctor(arg_1_1)
	self._tf = arg_1_1
	self._go = go(arg_1_1)
	self.acceptBtn = self._tf:Find("accept")
	self.icon = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.descTxt = self._tf:Find("desc/Text"):GetComponent(typeof(Text))
	self.publicResTxt = self._tf:Find("res_1/Text"):GetComponent(typeof(Text))
	self.privateResTxt = self._tf:Find("res_2/Text"):GetComponent(typeof(Text))
	self._tf:Find("res_1/label"):GetComponent(typeof(Text)).text = i18n("guild_public_awards")
	self._tf:Find("res_2/label"):GetComponent(typeof(Text)).text = i18n("guild_private_awards")

	return
end

function GuildTaskCard:Update(arg_2_1)
	self.task = arg_2_1
	self.icon.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "frame_" .. arg_2_1:GetScale())
	self.descTxt.text = arg_2_1:GetDesc()
	self.publicResTxt.text = arg_2_1:GetCaptailAward()
	self.privateResTxt.text = arg_2_1:GetPrivateAward()

	return
end

function GuildTaskCard:Destroy()
	return
end

return GuildTaskCard
