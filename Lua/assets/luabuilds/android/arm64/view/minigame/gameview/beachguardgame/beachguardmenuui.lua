local var_0_0 = class("BeachGuardMenuUI")
local var_0_1 = {}

;({
	img = "char_1",
	img_desc = "char_1_desc",
	id = 900913,
	icon = "char_1_icon"
}).desc = "beach_guard_chaijun"
;({})[1] = {
	img = "char_1",
	img_desc = "char_1_desc",
	id = 900913,
	icon = "char_1_icon"
}
;({})[2] = {
	img = "char_2",
	img_desc = "char_2_desc",
	id = 319011,
	icon = "char_2_icon",
	desc = "beach_guard_jianye"
}
;({})[3] = {
	img = "char_3",
	img_desc = "char_3_desc",
	id = 605021,
	icon = "char_3_icon",
	desc = "beach_guard_lituoliao"
}
;({})[4] = {
	img = "char_4",
	img_desc = "char_4_desc",
	id = 102231,
	icon = "char_4_icon",
	desc = "beach_guard_bominghan"
}
;({})[5] = {
	img = "char_5",
	img_desc = "char_5_desc",
	id = 302211,
	icon = "char_5_icon",
	desc = "beach_guard_nengdai"
}
;({})[6] = {
	icon = "m_craft_icon",
	img = "m_craft",
	name = "beach_guard_m_craft_name",
	desc = "beach_guard_m_craft"
}
;({})[7] = {
	icon = "m_atk_icon",
	img = "m_atk",
	name = "beach_guard_m_atk_name",
	desc = "beach_guard_m_atk"
}
;({})[8] = {
	icon = "m_guard_icon",
	img = "m_guard",
	name = "beach_guard_m_guard_name",
	desc = "beach_guard_m_guard"
}
;({})[1] = {}
;({})[2] = {
	{
		icon = "e1_icon",
		img = "e1",
		name = "beach_guard_e1",
		desc = "beach_guard_e1_desc"
	},
	{
		icon = "e2_icon",
		img = "e2",
		name = "beach_guard_e2",
		desc = "beach_guard_e2_desc"
	},
	{
		icon = "e3_icon",
		img = "e3",
		name = "beach_guard_e3",
		desc = "beach_guard_e3_desc"
	},
	{
		icon = "e4_icon",
		img = "e4",
		name = "beach_guard_e4",
		desc = "beach_guard_e4_desc"
	},
	{
		icon = "e5_icon",
		img = "e5",
		name = "beach_guard_e5",
		desc = "beach_guard_e5_desc"
	},
	{
		icon = "e6_icon",
		img = "e6",
		name = "beach_guard_e6",
		desc = "beach_guard_e6_desc"
	},
	{
		icon = "e7_icon",
		img = "e7",
		name = "beach_guard_e7",
		desc = "beach_guard_e7_desc"
	}
}
;({})[3] = {}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_3
	arg_1_0._gameData = arg_1_2
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "ad/battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = arg_1_0._gameData.total_times
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}

	GetComponent(findTF(arg_1_0.menuUI, "desc"), typeof(Image)):SetNativeSize()
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "ad/rightPanelBg/arrowUp"), function()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4) > 1 then
			var_2_0 = 1
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_2_0)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "ad/rightPanelBg/arrowDown"), function()
		local var_3_0 = arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4)

		if arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4) < 0 then
			var_3_0 = 0
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_3_0)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "ad/btnBack"), function()
		arg_1_0._event:emit(BeachGuardGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(BeachGuardGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnStart"), function()
		arg_1_0._event:emit(BeachGuardGameView.READY_START)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "ad/btnGameBook"), function()
		if isActive(arg_1_0.bookUI) then
			setActive(arg_1_0.bookUI, false)
			arg_1_0._event:emit(BeachGuardGameView.OPEN_BOOK, false)
		else
			arg_1_0._event:emit(BeachGuardGameView.OPEN_BOOK, true)
			setActive(arg_1_0.bookUI, true)
		end

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_1 = tf(instantiate(var_1_0))

		var_1_1.name = "battleItem_" .. iter_1_0

		setParent(var_1_1, findTF(arg_1_0.menuUI, "ad/battList/Viewport/Content"))
		GetSpriteFromAtlasAsync(arg_1_0._gameData.path, "battleDesc" .. iter_1_0, function(arg_8_0)
			if arg_8_0 then
				setImageSprite(findTF(var_1_1, "state_open/desc"), arg_8_0, true)
				setImageSprite(findTF(var_1_1, "state_clear/desc"), arg_8_0, true)
				setImageSprite(findTF(var_1_1, "state_current/desc"), arg_8_0, true)
				setImageSprite(findTF(var_1_1, "state_closed/desc"), arg_8_0, true)
			end

			return
		end)

		local var_1_2 = findTF(var_1_1, "icon")

		updateDrop(var_1_2, {
			type = arg_1_0._gameData.drop[iter_1_0][1],
			id = arg_1_0._gameData.drop[iter_1_0][2],
			amount = arg_1_0._gameData.drop[iter_1_0][3]
		})
		onButton(arg_1_0._event, var_1_2, function()
			arg_1_0._event:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		table.insert(arg_1_0.dropItems, var_1_2)
		setActive(var_1_1, true)
		table.insert(arg_1_0.battleItems, var_1_1)
	end

	arg_1_0.bookUI = findTF(arg_1_0.menuUI, "bookUI")

	setActive(arg_1_0.bookUI, false)
	onButton(arg_1_0._event, findTF(arg_1_0.bookUI, "bottom"), function()
		if isActive(arg_1_0.bookUI) then
			setActive(arg_1_0.bookUI, false)
		end

		return
	end, SFX_PANEL)

	arg_1_0.selectTagIndex = nil
	arg_1_0.selectGridIndex = nil
	arg_1_0.bookUITags = {}
	arg_1_0.grids = {}
	arg_1_0.iconImage = findTF(arg_1_0.bookUI, "bg/icon/img")
	arg_1_0.iconDesc = findTF(arg_1_0.bookUI, "bg/icon/img_desc")
	arg_1_0.descBoundTxt = findTF(arg_1_0.bookUI, "bg/descBound/desc")
	arg_1_0.descBoundTitle = findTF(arg_1_0.bookUI, "bg/descBound/title")

	for iter_1_1 = 1, 3 do
		local var_1_3 = iter_1_1
		local var_1_4 = findTF(arg_1_0.bookUI, "bg/tag" .. iter_1_1)

		if iter_1_1 == 3 then
			setActive(var_1_4, false)
		end

		onButton(arg_1_0._event, var_1_4, function()
			arg_1_0:selectBookTag(var_1_3)

			return
		end, SFX_PANEL)
		table.insert(arg_1_0.bookUITags, var_1_4)
	end

	local var_1_5 = findTF(arg_1_0.bookUI, "bg/gridTpl")

	for iter_1_2 = 1, 8 do
		local var_1_6 = iter_1_2
		local var_1_7 = tf(instantiate(var_1_5))

		setActive(var_1_7, true)
		setParent(var_1_7, findTF(arg_1_0.bookUI, "container/Viewport/Content"))
		onButton(arg_1_0._event, var_1_7, function()
			arg_1_0:selectGrid(var_1_6)

			return
		end, SFX_PANEL)
		table.insert(arg_1_0.grids, var_1_7)
	end

	arg_1_0:selectBookTag(1)

	return
end

function var_0_0.selectBookTag(arg_13_0, arg_13_1)
	if arg_13_0.selectTagIndex ~= arg_13_1 then
		arg_13_0.selectTagIndex = arg_13_1
		arg_13_0.bookDatas = var_0_1[arg_13_1]

		for iter_13_0 = 1, #arg_13_0.bookUITags do
			if arg_13_1 == iter_13_0 then
				setActive(findTF(arg_13_0.bookUITags[iter_13_0], "select"), true)
			else
				setActive(findTF(arg_13_0.bookUITags[iter_13_0], "select"), false)
			end
		end

		for iter_13_1 = 1, #arg_13_0.grids do
			local var_13_0 = arg_13_0.grids[iter_13_1]

			if iter_13_1 <= #arg_13_0.bookDatas then
				local var_13_1 = GetSpriteFromAtlas(arg_13_0._gameData.path, arg_13_0.bookDatas[iter_13_1].icon)
				local var_13_2 = arg_13_0.bookDatas[iter_13_1].id and pg.ship_data_statistics[arg_13_0.bookDatas[iter_13_1].id].name or i18n(arg_13_0.bookDatas[iter_13_1].name)

				setText(findTF(var_13_0, "name"), var_13_2)
				setImageSprite(findTF(var_13_0, "icon"), var_13_1, true)
				setActive(var_13_0, true)
			else
				setActive(var_13_0, false)
			end
		end

		arg_13_0.selectGridIndex = nil

		arg_13_0:selectGrid(1)
	end

	return
end

function var_0_0.selectGrid(arg_14_0, arg_14_1)
	if arg_14_0.selectGridIndex ~= arg_14_1 then
		arg_14_0.selectGridIndex = arg_14_1

		local var_14_0 = arg_14_0.bookDatas[arg_14_1]

		for iter_14_0 = 1, #arg_14_0.grids do
			if iter_14_0 == arg_14_1 then
				setActive(findTF(arg_14_0.grids[iter_14_0], "select"), true)
			else
				setActive(findTF(arg_14_0.grids[iter_14_0], "select"), false)
			end
		end

		if var_14_0.img then
			setImageSprite(arg_14_0.iconImage, GetSpriteFromAtlas(arg_14_0._gameData.path, var_14_0.img), true)
			setActive(arg_14_0.iconImage, true)
		else
			setActive(arg_14_0.iconImage, false)
		end

		if var_14_0.img_desc then
			setImageSprite(arg_14_0.iconDesc, GetSpriteFromAtlas(arg_14_0._gameData.path, var_14_0.img_desc), true)
			setActive(arg_14_0.iconDesc, true)
		else
			setActive(arg_14_0.iconDesc, false)
		end

		setText(arg_14_0.descBoundTxt, (i18n(var_14_0.desc)))
	end

	return
end

function var_0_0.updateBookUI(arg_15_0)
	return
end

function var_0_0.show(arg_16_0, arg_16_1)
	setActive(arg_16_0.menuUI, arg_16_1)

	return
end

function var_0_0.update(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getGameUsedTimes(arg_17_1)
	local var_17_1 = arg_17_0:getGameTimes(arg_17_1)

	for iter_17_0 = 1, #arg_17_0.battleItems do
		setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_open"), false)
		setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_closed"), false)
		setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_clear"), false)
		setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_current"), false)

		if iter_17_0 <= var_17_0 then
			SetParent(arg_17_0.dropItems[iter_17_0], findTF(arg_17_0.battleItems[iter_17_0], "state_clear/icon"))
			setActive(arg_17_0.dropItems[iter_17_0], true)
			setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_clear"), true)
		elseif iter_17_0 == var_17_0 + 1 and var_17_1 >= 1 then
			setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_current"), true)
			SetParent(arg_17_0.dropItems[iter_17_0], findTF(arg_17_0.battleItems[iter_17_0], "state_current/icon"))
			setActive(arg_17_0.dropItems[iter_17_0], true)
		elseif var_17_0 < iter_17_0 and iter_17_0 <= var_17_0 + var_17_1 then
			setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_open"), true)
			SetParent(arg_17_0.dropItems[iter_17_0], findTF(arg_17_0.battleItems[iter_17_0], "state_open/icon"))
			setActive(arg_17_0.dropItems[iter_17_0], true)
		else
			setActive(findTF(arg_17_0.battleItems[iter_17_0], "state_closed"), true)
			SetParent(arg_17_0.dropItems[iter_17_0], findTF(arg_17_0.battleItems[iter_17_0], "state_closed/icon"))
			setActive(arg_17_0.dropItems[iter_17_0], true)
		end
	end

	local var_17_2 = 1 - (var_17_0 - 3 < 0 and 0 or var_17_0 - 3) / (arg_17_0.totalTimes - 4)

	if 1 - (var_17_0 - 3 < 0 and 0 or var_17_0 - 3) / (arg_17_0.totalTimes - 4) > 1 then
		var_17_2 = 1
	end

	scrollTo(arg_17_0.battleScrollRect, 0, var_17_2)
	setActive(findTF(arg_17_0.menuUI, "btnStart/tip"), var_17_1 > 0)
	arg_17_0:CheckGet(arg_17_1)

	return
end

function var_0_0.CheckGet(arg_18_0, arg_18_1)
	setActive(findTF(arg_18_0.menuUI, "got"), false)

	local var_18_0 = arg_18_0:getUltimate(arg_18_1)

	if var_18_0 and var_18_0 ~= 0 then
		setActive(findTF(arg_18_0.menuUI, "got"), true)
	end

	if var_18_0 == 0 then
		if arg_18_0._gameData.total_times > arg_18_0:getGameUsedTimes(arg_18_1) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_18_1.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_18_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.getGameTimes(arg_19_0, arg_19_1)
	return arg_19_1.count
end

function var_0_0.getGameUsedTimes(arg_20_0, arg_20_1)
	return arg_20_1.usedtime
end

function var_0_0.getUltimate(arg_21_0, arg_21_1)
	return arg_21_1.ultimate
end

return var_0_0
