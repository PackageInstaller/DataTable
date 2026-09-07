local PlayRoomRankItem = class("PlayRoomRankItem", import("view.base.BasePanel"))

function PlayRoomRankItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomRankItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomRankItem:Init()
	setText(self.uiRankText, i18n("match_ui_window_out"))

	return
end

function PlayRoomRankItem:didEnter(arg_3_1)
	if arg_3_1 == nil then
		return
	end

	local var_3_0 = arg_3_1.rankIndex

	if arg_3_1.rankIndex == 1 then
		setActive(self.uiNum1, true)
		setActive(self.uiNum2, false)
		setActive(self.uiNum3, false)
		setActive(self.uiRankNumText, false)
		setActive(self.uiRankText, false)
		setImageColor(self.uiBgImage, Color.NewHex("FFFCB0"))
		setActive(self.uiBgImage, true)
	elseif var_3_0 == 2 then
		setActive(self.uiNum1, false)
		setActive(self.uiNum2, true)
		setActive(self.uiNum3, false)
		setActive(self.uiRankNumText, false)
		setActive(self.uiRankText, false)
		setImageColor(self.uiBgImage, Color.NewHex("B2EAFF"))
		setActive(self.uiBgImage, true)
	elseif var_3_0 == 3 then
		setActive(self.uiNum1, false)
		setActive(self.uiNum2, false)
		setActive(self.uiNum3, true)
		setActive(self.uiRankNumText, false)
		setActive(self.uiRankText, false)
		setImageColor(self.uiBgImage, Color.NewHex("FDDFC7"))
		setActive(self.uiBgImage, true)
	else
		setActive(self.uiNum1, false)
		setActive(self.uiNum2, false)
		setActive(self.uiNum3, false)
		setActive(self.uiRankNumText, var_3_0 ~= 0)
		setActive(self.uiRankText, var_3_0 == 0)
		setText(self.uiRankNumText, string.format("%02d", var_3_0))
		setActive(self.uiBgImage, false)
	end

	local var_3_1 = arg_3_1.playerData

	setText(self.uiNameText, arg_3_1.playerData.name)
	setText(self.uiLevelText, string.format("Lv.%s", var_3_1.level))
	setText(self.uiPtCntText, arg_3_1.score)
	setText(self.uiServerText, PlayRoomTools.GetServerName(var_3_1.id))
	setActive(self.uiGuildText, var_3_1.guildName ~= "")
	setText(self.uiGuildText, var_3_1.guildName)
	LoadSpriteAsync("qicon/" .. (var_3_0 == 0 and getProxy(PlayerProxy):getData():GetFlagShip() or Ship.New({
		configId = var_3_1.display.icon
	})):getPrefab(), function(arg_4_0)
		self.uiIcon.sprite = arg_4_0

		return
	end)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(PlayRoomTools.GetGameTypeID()), "", self.uiPtIcon)

	return
end

function PlayRoomRankItem:willExit()
	self:detach()

	return
end

return PlayRoomRankItem
