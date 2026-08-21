local var_0_0 = class("PlayRoomRankItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiRankText, i18n("match_ui_window_out"))

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	local var_3_0 = arg_3_1.rankIndex

	if arg_3_1.rankIndex == 1 then
		setActive(arg_3_0.uiNum1, true)
		setActive(arg_3_0.uiNum2, false)
		setActive(arg_3_0.uiNum3, false)
		setActive(arg_3_0.uiRankNumText, false)
		setActive(arg_3_0.uiRankText, false)
		setImageColor(arg_3_0.uiBgImage, Color.NewHex("FFFCB0"))
		setActive(arg_3_0.uiBgImage, true)
	elseif var_3_0 == 2 then
		setActive(arg_3_0.uiNum1, false)
		setActive(arg_3_0.uiNum2, true)
		setActive(arg_3_0.uiNum3, false)
		setActive(arg_3_0.uiRankNumText, false)
		setActive(arg_3_0.uiRankText, false)
		setImageColor(arg_3_0.uiBgImage, Color.NewHex("B2EAFF"))
		setActive(arg_3_0.uiBgImage, true)
	elseif var_3_0 == 3 then
		setActive(arg_3_0.uiNum1, false)
		setActive(arg_3_0.uiNum2, false)
		setActive(arg_3_0.uiNum3, true)
		setActive(arg_3_0.uiRankNumText, false)
		setActive(arg_3_0.uiRankText, false)
		setImageColor(arg_3_0.uiBgImage, Color.NewHex("FDDFC7"))
		setActive(arg_3_0.uiBgImage, true)
	else
		setActive(arg_3_0.uiNum1, false)
		setActive(arg_3_0.uiNum2, false)
		setActive(arg_3_0.uiNum3, false)
		setActive(arg_3_0.uiRankNumText, var_3_0 ~= 0)
		setActive(arg_3_0.uiRankText, var_3_0 == 0)
		setText(arg_3_0.uiRankNumText, string.format("%02d", var_3_0))
		setActive(arg_3_0.uiBgImage, false)
	end

	local var_3_1 = arg_3_1.playerData

	setText(arg_3_0.uiNameText, arg_3_1.playerData.name)
	setText(arg_3_0.uiLevelText, string.format("Lv.%s", var_3_1.level))
	setText(arg_3_0.uiPtCntText, arg_3_1.score)
	setText(arg_3_0.uiServerText, PlayRoomTools.GetServerName(var_3_1.id))
	setActive(arg_3_0.uiGuildText, var_3_1.guildName ~= "")
	setText(arg_3_0.uiGuildText, var_3_1.guildName)

	local var_3_2 = var_3_0 == 0 and getProxy(PlayerProxy):getData():GetFlagShip() or Ship.New({
		configId = var_3_1.display.icon
	})

	LoadSpriteAsync("qicon/" .. var_3_2:getPrefab(), function(arg_4_0)
		arg_3_0.uiIcon.sprite = arg_4_0

		return
	end)
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(PlayRoomTools.GetGameTypeID()), "", arg_3_0.uiPtIcon)

	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:detach()

	return
end

return var_0_0
