local IslandBookNpcPage = class("IslandBookNpcPage", import(".IslandBookItemPage"))

function IslandBookNpcPage:getUIName()
	return "IslandBookNpcUI"
end

function IslandBookNpcPage:GetIllustrationType()
	return IslandIllustration.TYPES.NPC
end

function IslandBookNpcPage:GetHelpTip()
	return i18n("island_guide_help_npc")
end

function IslandBookNpcPage:OnLoaded()
	IslandBookNpcPage.super.OnLoaded(self)

	self.postNameTF = self.rightTF:Find("post/Text")

	return
end

function IslandBookNpcPage:FlushRightPanel()
	IslandBookNpcPage.super.FlushRightPanel(self)

	if not self.showIllustration then
		return
	end

	setText(self.postNameTF, pg.island_npc_hud[self.showIllustration:getLinkConfig("group")].title)

	return
end

return IslandBookNpcPage
