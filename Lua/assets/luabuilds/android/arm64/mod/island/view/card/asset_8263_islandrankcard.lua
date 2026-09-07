local IslandRankCard = class("IslandRankCard")

IslandRankCard.TYPE_SELF = 1
IslandRankCard.TYPE_OTHER = 2

function IslandRankCard:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._type = arg_1_2
	self.parent = arg_1_3
	self.bgTF = self._tf:Find("bg")
	self.rankText = self._tf:Find("rank"):GetComponent(typeof(Text))
	self.notOnTF = self._tf:Find("not_on")
	self.iconTF = self._tf:Find("icon_bg/icon")
	self.nameText = self._tf:Find("name"):GetComponent(typeof(Text))
	self.levelText = self._tf:Find("level"):GetComponent(typeof(Text))
	self.ptText = self._tf:Find("pt"):GetComponent(typeof(Text))

	setText(self._tf:Find("island"), i18n("island_season_charts_level"))
	setText(self.notOnTF, i18n("island_season_charts_out"))

	self.awardsTF = self._tf:Find("awards")

	return
end

function IslandRankCard:Update(arg_2_1, arg_2_2)
	self.rankVO = arg_2_1

	if arg_2_1.rank > 9 then
		self.rankText.text = arg_2_1.rank or "0" .. arg_2_1.rank
	end

	self.nameText.text = arg_2_1.name
	self.levelText.text = "Lv." .. arg_2_1.arenaRank
	self.ptText.text = arg_2_1.power

	GetImageSpriteFromAtlasAsync("ui/islandseasonrankui_atlas", "bg" .. ((arg_2_1.rank < 4 or nil) and (arg_2_1.rank or 0)), self.bgTF)

	local var_2_0 = self._type ~= IslandRankCard.TYPE_SELF or arg_2_1.rank > 0

	setActive(self.rankText, (self._type ~= IslandRankCard.TYPE_SELF or arg_2_1.rank > 0) and arg_2_1.rank > 3)
	setActive(self.notOnTF, not var_2_0)
	GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[arg_2_1.skinId].prefab, "", self.iconTF)

	local var_2_1 = IslandSeason.GetAwardsByRank(arg_2_2, arg_2_1.rank)

	UIItemList.StaticAlign(self.awardsTF, self.awardsTF:Find("tpl"), #var_2_1, function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_3_2, var_2_1[arg_3_1 + 1])
			onButton(self.parent, arg_3_2, function()
				self.parent.contextData:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_2_1[arg_3_1 + 1]
				})

				return
			end)
		end

		return
	end)

	return
end

function IslandRankCard:Dispose()
	return
end

return IslandRankCard
