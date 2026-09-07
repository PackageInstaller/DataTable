local PublicGuildResPage = class("PublicGuildResPage", import("..subPages.main.GuildResPage"))

function PublicGuildResPage:OnInit()
	self.contributionBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. "blue")
	self.captailBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. "blue")

	setActive(self.captailBg.gameObject, false)

	return
end

function PublicGuildResPage:Update(arg_2_1)
	self.resContributionTxt.text = arg_2_1:getResource(8)

	return
end

return PublicGuildResPage
