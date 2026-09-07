local GuildResPage = class("GuildResPage", import("....base.BaseSubView"))

function GuildResPage:getUIName()
	return "GuildResPanel"
end

function GuildResPage:Load()
	if self._state ~= GuildResPage.STATES.NONE then
		return
	end

	self._state = GuildResPage.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()
	self:Loaded((LoadAndInstantiateSync("UI", self:getUIName(), true, false)))
	self:Init()

	return
end

function GuildResPage:OnLoaded()
	self.captailBg = self._tf:Find("captail"):GetComponent(typeof(Image))
	self.contributionBg = self._tf:Find("contribution"):GetComponent(typeof(Image))
	self.resCaptailTxt = self._tf:Find("captail/Text"):GetComponent(typeof(Text))
	self.resContributionTxt = self._tf:Find("contribution/Text"):GetComponent(typeof(Text))
	self.resourceLogBtn = self._tf:Find("captail/log")

	setActive(self._tf, true)

	return
end

function GuildResPage:OnInit()
	onButton(self, self.resourceLogBtn, function()
		self:emit(GuildMainMediator.ON_FETCH_CAPITAL_LOG)

		return
	end, SFX_PANEL)

	return
end

function GuildResPage:Update(arg_6_1, arg_6_2)
	self.resCaptailTxt.text = arg_6_2:getCapital()
	self.resContributionTxt.text = arg_6_1:getResource(8)

	local var_6_0 = arg_6_2:getFaction()

	if self.faction ~= var_6_0 then
		local var_6_1 = var_6_0 == GuildConst.FACTION_TYPE_BLHX and "blue" or "red"

		self.contributionBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. (var_6_0 == GuildConst.FACTION_TYPE_BLHX and "blue" or "red"))
		self.captailBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. var_6_1)
		self.faction = var_6_0
	end

	return
end

function GuildResPage:OnDestroy()
	return
end

return GuildResPage
