class = var_0_10000

local var_0_0 = "PlayRoomRankItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiRankText

	i18n = var_1_10003

	var_1_10001(var_2_0, var_1_10003("match_ui_window_out"))

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	if arg_3_1.rankIndex == 1 then
		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum1, true)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum2, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum3, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankNumText, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankText, false)

		setImageColor = var_1_10003
		var_1_10004 = arg_3_0.uiBgImage
		Color = var_5

		var_1_10003(var_1_10004, var_5.NewHex("FFFCB0"))

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiBgImage, true)
	elseif var_2 == 2 then
		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum1, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum2, true)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum3, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankNumText, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankText, false)

		setImageColor = var_1_10003
		var_1_10004 = arg_3_0.uiBgImage
		Color = var_5

		var_1_10003(var_1_10004, var_5.NewHex("B2EAFF"))

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiBgImage, true)
	elseif var_2 == 3 then
		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum1, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum2, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum3, true)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankNumText, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankText, false)

		setImageColor = var_1_10003
		var_1_10004 = arg_3_0.uiBgImage
		Color = var_5

		var_1_10003(var_1_10004, var_5.NewHex("FDDFC7"))

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiBgImage, true)
	else
		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum1, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum2, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiNum3, false)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankNumText, var_2 ~= 0)

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiRankText, var_2 == 0)

		setText = var_1_10003
		var_1_10004 = arg_3_0.uiRankNumText
		string = var_5

		var_1_10003(var_1_10004, var_5.format("%02d", var_2))

		setActive = var_1_10003

		var_1_10003(arg_3_0.uiBgImage, false)
	end

	local var_3_0 = arg_3_1.playerData

	setText = var_1_10004

	var_1_10004(arg_3_0.uiNameText, var_3_0.name)

	setText = var_1_10004

	local var_3_1 = arg_3_0.uiLevelText

	string = var_6

	var_1_10004(var_3_1, var_6.format("Lv.%s", var_3_0.level))

	setText = var_1_10004

	var_1_10004(arg_3_0.uiPtCntText, arg_3_1.score)

	setText = var_1_10004

	local var_3_2 = arg_3_0.uiServerText

	PlayRoomTools = var_6

	var_1_10004(var_3_2, var_6.GetServerName(var_3_0.id))

	setActive = var_1_10004

	var_1_10004(arg_3_0.uiGuildText, var_3_0.guildName ~= "")

	setText = var_1_10004

	var_1_10004(arg_3_0.uiGuildText, var_3_0.guildName)

	local var_3_3

	if var_2 == 0 then
		getProxy = var_5
		PlayerProxy = var_6

		local var_3_4 = var_5(var_6)
		local var_3_5 = var_5.getData(var_3_4)

		var_3_3 = var_5.GetFlagShip(var_3_5)
	else
		Ship = var_5
		var_3_3 = var_5.New({
			configId = var_3_0.display.icon
		})
	end

	LoadSpriteAsync = var_5

	var_5("qicon/" .. var_3_3:getPrefab(), function(arg_4_0)
		arg_3_0.uiIcon.sprite = arg_4_0

		return
	end)

	PlayRoomTools = var_5

	local var_3_6 = var_5.GetPtScoreIcon

	PlayRoomTools = var_6

	local var_3_7 = var_3_6(var_6.GetGameTypeID())

	GetImageSpriteFromAtlasAsync = var_6

	var_6("Island/IslandCheaterTavernIcon/" .. var_3_7, "", arg_3_0.uiPtIcon)

	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:detach()

	return
end

return var_0_1
