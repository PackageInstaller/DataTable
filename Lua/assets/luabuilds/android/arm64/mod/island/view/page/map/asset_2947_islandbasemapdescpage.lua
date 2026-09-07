local IslandBaseMapDescPage = class("IslandBaseMapDescPage", import("...base.IslandBasePage"))

function IslandBaseMapDescPage:getUIName()
	return "IslandMapDescUI"
end

function IslandBaseMapDescPage:OnLoaded()
	self.nameTxt = self._tf:Find("frame/title/name/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("frame/Text"):GetComponent(typeof(Text))
	self.goBtn = self._tf:Find("frame/go")
	self.uiProductionList = UIItemList.New(self._tf:Find("frame/scrollrect/list"), self._tf:Find("frame/scrollrect/list/tpl"))
	self.iconTr = self._tf:Find("frame/icon")
	self.fullMark = self._tf:Find("frame/icon/tag")

	setText(self._tf:Find("frame/go/Text"), i18n("island_word_go"))

	return
end

function IslandBaseMapDescPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()
		self:emit(IslandBaseMapPage.HIDE_DESC)

		return
	end, SFX_PANEL)

	return
end

function IslandBaseMapDescPage:OnShow(arg_5_1)
	self.nameTxt.text = pg.island_map[arg_5_1].name
	self.descTxt.text = pg.island_map[arg_5_1].desc

	LoadImageSpriteAtlasAsync("island/IslandMapIcon/" .. arg_5_1, "", self.iconTr)
	onButton(self, self.goBtn, function()
		self:GoMap(arg_5_1)

		return
	end, SFX_PANEL)
	setActive(self.fullMark, false)

	return
end

function IslandBaseMapDescPage:GoMap(arg_7_1)
	self:emitCoreController(ISLAND_EVT.SWITCH_MAP)
	self:emit(IslandBaseMediator.SWITCH_MAP, arg_7_1, pg.island_map[arg_7_1].born_object)
	self:emit(IslandBaseMapPage.CLOSE)

	return
end

return IslandBaseMapDescPage
