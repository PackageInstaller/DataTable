local PublicGuildTechnologyPage = class("PublicGuildTechnologyPage", import("...base.BaseSubView"))

function PublicGuildTechnologyPage:getUIName()
	return "PublicGuildTechnologyPage"
end

function PublicGuildTechnologyPage:OnTechGroupUpdate(arg_2_1)
	self:UpdateUpgradeList()

	return
end

function PublicGuildTechnologyPage:OnLoaded()
	self.upgradeList = UIItemList.New(self._tf:Find("frame/upgrade/content"), self._tf:Find("frame/upgrade/content/tpl"))

	return
end

function PublicGuildTechnologyPage:OnInit()
	self.upgradeList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			PublicGuildTechnologyCard.New(arg_5_2:Find("content"), self):Update(self.technologyVOs[arg_5_1 + 1])
			setActive(arg_5_2:Find("back"), false)
		end

		return
	end)

	return
end

function PublicGuildTechnologyPage:Show(arg_6_1)
	self.guildVO = arg_6_1

	self:UpdateUpgradeList()
	PublicGuildTechnologyPage.super.Show(self)

	return
end

function PublicGuildTechnologyPage:UpdateUpgradeList()
	self.technologyVOs = {}

	for iter_7_0, iter_7_1 in pairs((self.guildVO:GetTechnologys())) do
		if not iter_7_1:IsGuildMember() then
			table.insert(self.technologyVOs, iter_7_1)
		end
	end

	table.sort(self.technologyVOs, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)
	self.upgradeList:align(#self.technologyVOs)

	return
end

function PublicGuildTechnologyPage:OnDestroy()
	return
end

return PublicGuildTechnologyPage
