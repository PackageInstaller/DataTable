local IslandTradeRankCard = class("IslandTradeRankCard")

function IslandTradeRankCard:Ctor(arg_1_1)
	self._tf = arg_1_1.transform
	self.mainTr = self._tf:Find("main")
	self.iconTF = self.mainTr:Find("icon_bg/icon")
	self.nameTxt = self.mainTr:Find("name"):GetComponent(typeof(Text))
	self.lvTxt = self.mainTr:Find("level"):GetComponent(typeof(Text))
	self.numImg = self.mainTr:Find("num")
	self.numTxt = self.mainTr:Find("num_text"):GetComponent(typeof(Text))
	self.valueTxt = self.mainTr:Find("price/Text"):GetComponent(typeof(Text))
	self.visitBtn = self.mainTr:Find("visit")
	self.inviteBtn = self.mainTr:Find("invite")

	setText(self.mainTr:Find("island"), i18n("island_trade_rank_level_label"))

	self.cg = GetOrAddComponent(self.mainTr, typeof(CanvasGroup))

	return
end

function IslandTradeRankCard:Update(arg_2_1, arg_2_2, arg_2_3)
	self.id = arg_2_2.id

	if arg_2_1 <= 3 then
		GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "rank-0" .. arg_2_1, self.numImg)
		GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "rank-0" .. arg_2_1 .. "bg", self.mainTr)
	else
		GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "rank04bg", self.mainTr)
	end

	if arg_2_2.value > 0 then
		self.valueTxt.text = arg_2_2.value or "-"
	end

	if arg_2_1 < 10 then
		self.numTxt.text = "0" .. arg_2_1 or arg_2_1
	end

	self.nameTxt.text = arg_2_2.name
	self.lvTxt.text = "lv." .. arg_2_2.islandLevel

	GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[arg_2_2.skinId].prefab, "", self.iconTF)

	local var_2_0 = arg_2_2:IsSelf()

	setActive(self.visitBtn, not var_2_0)
	setActive(self.inviteBtn, var_2_0)
	setActive(self.numTxt.gameObject, arg_2_1 > 3)
	setActive(self.numImg, arg_2_1 <= 3)

	return
end

function IslandTradeRankCard:CancelAnimation()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandTradeRankCard:PlayAnimation()
	return
end

function IslandTradeRankCard:Dispose()
	self:CancelAnimation()

	return
end

return IslandTradeRankCard
