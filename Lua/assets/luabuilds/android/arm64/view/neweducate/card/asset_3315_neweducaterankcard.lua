local NewEducateRankCard = class("NewEducateRankCard")

NewEducateRankCard.TYPE_SELF = 1
NewEducateRankCard.TYPE_OTHER = 2

function NewEducateRankCard:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._type = arg_1_2
	self.parent = arg_1_3
	self.bg1TF = self._tf:Find("1")
	self.bg2TF = self._tf:Find("2")
	self.bg3TF = self._tf:Find("3")
	self.rankText = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.notOnTF = self._tf:Find("not_on")

	setText(self.notOnTF, i18n("child2_rank_not_on"))

	self.iconTF = self._tf:Find("icon_bg/icon")
	self.callNameText = self._tf:Find("call_name"):GetComponent(typeof(Text))
	self.playerNameText = self._tf:Find("player_name/Text"):GetComponent(typeof(Text))
	self.valueText = self._tf:Find("value"):GetComponent(typeof(Text))

	return
end

function NewEducateRankCard:Update(arg_2_1, arg_2_2)
	self.rankVO = arg_2_1

	local var_2_0 = arg_2_1.rank

	self.rankText.text = arg_2_1.rank > 9 and var_2_0 or "0" .. var_2_0

	local var_2_1 = arg_2_1.power

	if arg_2_2 == PowerRank.TYPE_TB_ENDLESS_WAVE then
		var_2_1 = math.max(0, var_2_1 - getProxy(NewEducateProxy):GetCurChar():GetRoundData():GetGameRoundCnt())
	end

	self.valueText.text = var_2_1

	local var_2_2 = string.split(arg_2_1.name, "|")

	self.callNameText.text = var_2_2[2]
	self.playerNameText.text = var_2_2[1]

	setActive(self.bg1TF, var_2_0 == 1)
	setActive(self.bg2TF, var_2_0 == 2)
	setActive(self.bg3TF, var_2_0 == 3)

	local var_2_3 = self._type ~= NewEducateRankCard.TYPE_SELF or var_2_0 > 0

	setActive(self.rankText, (self._type ~= NewEducateRankCard.TYPE_SELF or var_2_0 > 0) and var_2_0 > 3)
	setActive(self.notOnTF, not var_2_3)
	GetImageSpriteFromAtlasAsync("qicon/" .. pg.ship_skin_template[arg_2_1.skinId].prefab, "", self.iconTF)

	return
end

function NewEducateRankCard:Dispose()
	return
end

return NewEducateRankCard
