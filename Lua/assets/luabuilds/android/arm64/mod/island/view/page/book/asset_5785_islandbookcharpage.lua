local IslandBookCharPage = class("IslandBookCharPage", import(".IslandBookItemPage"))

function IslandBookCharPage:getUIName()
	return "IslandBookCharUI"
end

function IslandBookCharPage:GetIllustrationType()
	return IslandIllustration.TYPES.CHAR
end

function IslandBookCharPage:GetHelpTip()
	return i18n("island_guide_help")
end

function IslandBookCharPage:OnLoaded()
	IslandBookCharPage.super.OnLoaded(self)

	self.starList = UIItemList.New(self.rightTF:Find("stars"), self.rightTF:Find("stars/tpl"))

	return
end

function IslandBookCharPage:FlushRightPanel()
	IslandBookCharPage.super.FlushRightPanel(self)

	local var_5_1
	local var_5_0
	local var_5_3
	local var_5_2

	if not self.showIllustration then
		do return end

		var_5_0 = self.showIllustration:GetLinkConfigID()
		var_5_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(var_5_0)
		var_5_2 = setText
		var_5_3 = self.rightTF:Find("level")
	end

	var_5_2(var_5_3, self.showIllustration:GetStatus() == IslandIllustration.STATUS.UNLOCK and "Lv." .. var_5_1:GetLevel() or "")
	setScrollTextWithSize(self.rightNameTF, self.rightTF:Find("scroll_name/Text"), self.showIllustration:GetName(), 11)

	local var_5_4 = var_5_1 and var_5_1:GetBreakLevel() or 0

	self.starList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			setActive(arg_6_2:Find("Image"), arg_6_1 + 1 <= var_5_4)
		end

		return
	end)
	self.starList:align(self:GetShipBreakMaxLevel(var_5_0))

	return
end

function IslandBookCharPage:GetShipBreakMaxLevel(arg_7_1)
	return pg.island_chara_template[arg_7_1].upgrade_level[2] + 1
end

return IslandBookCharPage
