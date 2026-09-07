local BeachGuardMenuUI = class("BeachGuardMenuUI")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {
	img = "char_1",
	img_desc = "char_1_desc",
	id = 900913,
	icon = "char_1_icon"
}

var_0_3.desc = "beach_guard_chaijun"
var_0_2[1] = var_0_3
var_0_2[2] = {
	img = "char_2",
	img_desc = "char_2_desc",
	id = 319011,
	icon = "char_2_icon",
	desc = "beach_guard_jianye"
}
var_0_2[3] = {
	img = "char_3",
	img_desc = "char_3_desc",
	id = 605021,
	icon = "char_3_icon",
	desc = "beach_guard_lituoliao"
}
var_0_2[4] = {
	img = "char_4",
	img_desc = "char_4_desc",
	id = 102231,
	icon = "char_4_icon",
	desc = "beach_guard_bominghan"
}
var_0_2[5] = {
	img = "char_5",
	img_desc = "char_5_desc",
	id = 302211,
	icon = "char_5_icon",
	desc = "beach_guard_nengdai"
}
var_0_2[6] = {
	icon = "m_craft_icon",
	img = "m_craft",
	name = "beach_guard_m_craft_name",
	desc = "beach_guard_m_craft"
}
var_0_2[7] = {
	icon = "m_atk_icon",
	img = "m_atk",
	name = "beach_guard_m_atk_name",
	desc = "beach_guard_m_atk"
}
var_0_2[8] = {
	icon = "m_guard_icon",
	img = "m_guard",
	name = "beach_guard_m_guard_name",
	desc = "beach_guard_m_guard"
}
var_0_1[1] = var_0_2
var_0_1[2] = {
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
var_0_1[3] = {}

function BeachGuardMenuUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_3
	self._gameData = arg_1_2
	self.menuUI = findTF(self._tf, "ui/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "ad/battList"), typeof(ScrollRect))
	self.totalTimes = self._gameData.total_times
	self.battleItems = {}
	self.dropItems = {}

	GetComponent(findTF(self.menuUI, "desc"), typeof(Image)):SetNativeSize()
	onButton(self._event, findTF(self.menuUI, "ad/rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "ad/rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "ad/btnBack"), function()
		self._event:emit(BeachGuardGameView.CLOSE_GAME)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnRule"), function()
		self._event:emit(BeachGuardGameView.SHOW_RULE)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "btnStart"), function()
		self._event:emit(BeachGuardGameView.READY_START)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.menuUI, "ad/btnGameBook"), function()
		if isActive(self.bookUI) then
			setActive(self.bookUI, false)
			self._event:emit(BeachGuardGameView.OPEN_BOOK, false)
		else
			self._event:emit(BeachGuardGameView.OPEN_BOOK, true)
			setActive(self.bookUI, true)
		end

		return
	end, SFX_CANCEL)

	local var_1_0 = findTF(self.menuUI, "tplBattleItem")

	for iter_1_0 = 1, 7 do
		local var_1_1 = tf(instantiate(var_1_0))

		var_1_1.name = "battleItem_" .. iter_1_0

		setParent(var_1_1, findTF(self.menuUI, "ad/battList/Viewport/Content"))
		GetSpriteFromAtlasAsync(self._gameData.path, "battleDesc" .. iter_1_0, function(arg_8_0)
			if arg_8_0 then
				setImageSprite(findTF(var_1_1, "state_open/desc"), arg_8_0, true)
				setImageSprite(findTF(var_1_1, "state_clear/desc"), arg_8_0, true)
				setImageSprite(findTF(var_1_1, "state_current/desc"), arg_8_0, true)
				setImageSprite(findTF(var_1_1, "state_closed/desc"), arg_8_0, true)
			end

			return
		end)

		local var_1_2 = findTF(var_1_1, "icon")
		local var_1_3 = {
			type = self._gameData.drop[iter_1_0][1],
			id = self._gameData.drop[iter_1_0][2],
			amount = self._gameData.drop[iter_1_0][3]
		}

		updateDrop(var_1_2, var_1_3)
		onButton(self._event, var_1_2, function()
			self._event:emit(BaseUI.ON_DROP, var_1_3)

			return
		end, SFX_PANEL)
		table.insert(self.dropItems, var_1_2)
		setActive(var_1_1, true)
		table.insert(self.battleItems, var_1_1)
	end

	self.bookUI = findTF(self.menuUI, "bookUI")

	setActive(self.bookUI, false)
	onButton(self._event, findTF(self.bookUI, "bottom"), function()
		if isActive(self.bookUI) then
			setActive(self.bookUI, false)
		end

		return
	end, SFX_PANEL)

	self.selectTagIndex = nil
	self.selectGridIndex = nil
	self.bookUITags = {}
	self.grids = {}
	self.iconImage = findTF(self.bookUI, "bg/icon/img")
	self.iconDesc = findTF(self.bookUI, "bg/icon/img_desc")
	self.descBoundTxt = findTF(self.bookUI, "bg/descBound/desc")
	self.descBoundTitle = findTF(self.bookUI, "bg/descBound/title")

	for iter_1_1 = 1, 3 do
		local var_1_4 = iter_1_1
		local var_1_5 = findTF(self.bookUI, "bg/tag" .. iter_1_1)

		if iter_1_1 == 3 then
			setActive(var_1_5, false)
		end

		onButton(self._event, var_1_5, function()
			self:selectBookTag(var_1_4)

			return
		end, SFX_PANEL)
		table.insert(self.bookUITags, var_1_5)
	end

	local var_1_6 = findTF(self.bookUI, "bg/gridTpl")

	for iter_1_2 = 1, 8 do
		local var_1_7 = iter_1_2
		local var_1_8 = tf(instantiate(var_1_6))

		setActive(var_1_8, true)
		setParent(var_1_8, findTF(self.bookUI, "container/Viewport/Content"))
		onButton(self._event, var_1_8, function()
			self:selectGrid(var_1_7)

			return
		end, SFX_PANEL)
		table.insert(self.grids, var_1_8)
	end

	self:selectBookTag(1)

	return
end

function BeachGuardMenuUI:selectBookTag(arg_13_1)
	if self.selectTagIndex ~= arg_13_1 then
		self.selectTagIndex = arg_13_1
		self.bookDatas = var_0_1[arg_13_1]

		for iter_13_0 = 1, #self.bookUITags do
			if arg_13_1 == iter_13_0 then
				setActive(findTF(self.bookUITags[iter_13_0], "select"), true)
			else
				setActive(findTF(self.bookUITags[iter_13_0], "select"), false)
			end
		end

		for iter_13_1 = 1, #self.grids do
			local var_13_0 = self.grids[iter_13_1]

			if iter_13_1 <= #self.bookDatas then
				local var_13_1 = GetSpriteFromAtlas(self._gameData.path, self.bookDatas[iter_13_1].icon)

				setText(findTF(var_13_0, "name"), self.bookDatas[iter_13_1].id and pg.ship_data_statistics[self.bookDatas[iter_13_1].id].name or i18n(self.bookDatas[iter_13_1].name))
				setImageSprite(findTF(var_13_0, "icon"), var_13_1, true)
				setActive(var_13_0, true)
			else
				setActive(var_13_0, false)
			end
		end

		self.selectGridIndex = nil

		self:selectGrid(1)
	end

	return
end

function BeachGuardMenuUI:selectGrid(arg_14_1)
	if self.selectGridIndex ~= arg_14_1 then
		self.selectGridIndex = arg_14_1

		local var_14_0 = self.bookDatas[arg_14_1]

		for iter_14_0 = 1, #self.grids do
			if iter_14_0 == arg_14_1 then
				setActive(findTF(self.grids[iter_14_0], "select"), true)
			else
				setActive(findTF(self.grids[iter_14_0], "select"), false)
			end
		end

		if var_14_0.img then
			setImageSprite(self.iconImage, GetSpriteFromAtlas(self._gameData.path, var_14_0.img), true)
			setActive(self.iconImage, true)
		else
			setActive(self.iconImage, false)
		end

		if var_14_0.img_desc then
			setImageSprite(self.iconDesc, GetSpriteFromAtlas(self._gameData.path, var_14_0.img_desc), true)
			setActive(self.iconDesc, true)
		else
			setActive(self.iconDesc, false)
		end

		setText(self.descBoundTxt, (i18n(var_14_0.desc)))
	end

	return
end

function BeachGuardMenuUI:updateBookUI()
	return
end

function BeachGuardMenuUI:show(arg_16_1)
	setActive(self.menuUI, arg_16_1)

	return
end

function BeachGuardMenuUI:update(arg_17_1)
	local var_17_0 = self:getGameUsedTimes(arg_17_1)
	local var_17_1 = self:getGameTimes(arg_17_1)

	for iter_17_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_17_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_17_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_17_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_17_0], "state_current"), false)

		if iter_17_0 <= var_17_0 then
			SetParent(self.dropItems[iter_17_0], findTF(self.battleItems[iter_17_0], "state_clear/icon"))
			setActive(self.dropItems[iter_17_0], true)
			setActive(findTF(self.battleItems[iter_17_0], "state_clear"), true)
		elseif iter_17_0 == var_17_0 + 1 and var_17_1 >= 1 then
			setActive(findTF(self.battleItems[iter_17_0], "state_current"), true)
			SetParent(self.dropItems[iter_17_0], findTF(self.battleItems[iter_17_0], "state_current/icon"))
			setActive(self.dropItems[iter_17_0], true)
		elseif var_17_0 < iter_17_0 and iter_17_0 <= var_17_0 + var_17_1 then
			setActive(findTF(self.battleItems[iter_17_0], "state_open"), true)
			SetParent(self.dropItems[iter_17_0], findTF(self.battleItems[iter_17_0], "state_open/icon"))
			setActive(self.dropItems[iter_17_0], true)
		else
			setActive(findTF(self.battleItems[iter_17_0], "state_closed"), true)
			SetParent(self.dropItems[iter_17_0], findTF(self.battleItems[iter_17_0], "state_closed/icon"))
			setActive(self.dropItems[iter_17_0], true)
		end
	end

	scrollTo(self.battleScrollRect, 0, (1 - (var_17_0 - 3 < 0 and 0 or var_17_0 - 3) / (self.totalTimes - 4) > 1 or nil) and 1)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_17_1 > 0)
	self:CheckGet(arg_17_1)

	return
end

function BeachGuardMenuUI:CheckGet(arg_18_1)
	setActive(findTF(self.menuUI, "got"), false)

	local var_18_0 = self:getUltimate(arg_18_1)

	if var_18_0 and var_18_0 ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if var_18_0 == 0 then
		if self._gameData.total_times > self:getGameUsedTimes(arg_18_1) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_18_1.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function BeachGuardMenuUI:getGameTimes(arg_19_1)
	return arg_19_1.count
end

function BeachGuardMenuUI:getGameUsedTimes(arg_20_1)
	return arg_20_1.usedtime
end

function BeachGuardMenuUI:getUltimate(arg_21_1)
	return arg_21_1.ultimate
end

return BeachGuardMenuUI
