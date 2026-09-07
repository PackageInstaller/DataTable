local PuzzleConnectMenu = class("PuzzleConnectMenu")
local var_0_1 = 3
local var_0_2 = 3

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		Ctor = function(self)
			self._tf = arg_1_0
			self._event = arg_1_1
			self._index = arg_1_2
			self._shipDescTf = findTF(self._tf, "desc/text")
			self._titleTf = findTF(self._tf, "title_text")
			self._iconTf = findTF(self._tf, "icon")
			self._awardTfs = findTF(self._tf, "iconBg")
			self._newTf = findTF(self._tf, "new")
			self._progressTf = findTF(self._tf, "progress")
			self._btnDetail = findTF(self._tf, "btnDetail")
			self._btnDetailText = findTF(self._btnDetail, "text")
			self._lockMask = findTF(self._tf, "lockMask")

			onButton(self._event, self._btnDetail, function()
				if self._progressCount and self._progressCount == 3 then
					return
				end

				PlayerPrefs.SetInt("puzzle_connect_new_" .. tostring(getProxy(PlayerProxy):getPlayerId()) .. "_" .. self._configId, 1)
				self:setItemNew(false)
				self._event:emit(PuzzleConnectLayer.OPEN_DETAIL, {
					index = self._index,
					data = self._data
				})

				return
			end, SFX_CONFIRM)

			return
		end,
		setActive = function(self, arg_4_1)
			setActive(self._tf, arg_4_1)

			return
		end,
		setContent = function(self, arg_5_1)
			setParent(self._tf, arg_5_1)

			return
		end,
		setData = function(self, arg_6_1)
			self._configId = arg_6_1
			self._data = pg.activity_tolove_jigsaw[self._configId]
			self._progressCount = 0

			self:updateUI()

			return
		end,
		updateUI = function(self)
			setActive(self._iconTf, false)
			GetSpriteFromAtlasAsync("ui/puzzleconnecticon_atlas", self._data.item_icon, function(arg_8_0)
				setImageSprite(self._iconTf, arg_8_0, true)
				setActive(self._iconTf, true)

				return
			end)

			for iter_7_0 = 1, var_0_1 do
				local var_7_0 = findTF(self._tf, "awards/icon" .. iter_7_0)
				local var_7_1 = findTF(self._tf, "iconBg/" .. iter_7_0)

				if iter_7_0 <= #self._data.show_award then
					local var_7_2 = {
						type = self._data.show_award[iter_7_0][1],
						id = self._data.show_award[iter_7_0][2],
						amount = self._data.show_award[iter_7_0][3]
					}

					updateDrop(var_7_0, var_7_2)
					onButton(self._event, var_7_0, function()
						self._event:emit(BaseUI.ON_DROP, var_7_2)

						return
					end, SFX_PANEL)
					setActive(var_7_0, true)
					setActive(var_7_1, true)
				else
					setActive(var_7_0, false)
					setActive(var_7_1, false)
				end
			end

			self:setItemNew(false)
			self:updateProgress()
			self:setItemMask(false, true, 0, 0)

			return
		end,
		getConfigId = function(self)
			return self._configId
		end,
		setItemMask = function(self, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
			self._progressCount = arg_11_4

			local var_11_0 = false
			local var_11_1 = false
			local var_11_2

			if arg_11_1 then
				var_11_1 = true
				var_11_0 = true
				var_11_2 = i18n("tolovegame_puzzle_lock_by_time", math.floor(arg_11_3 / 24), arg_11_3 % 24)
			elseif arg_11_2 then
				if arg_11_4 ~= 3 then
					var_11_1 = false
					var_11_0 = false
					var_11_2 = i18n("tolovegame_puzzle_open_detail")
				else
					var_11_1 = false
					var_11_0 = false
					var_11_2 = i18n("tolovegame_puzzle_finished")
				end
			else
				var_11_1 = true
				var_11_0 = true
				var_11_2 = i18n("tolovegame_puzzle_lock_by_front")
			end

			self._maskAble = var_11_0

			if var_11_0 then
				setText(self._shipDescTf, i18n("tolovegame_puzzle_ship_unknown"))
				setText(self._titleTf, i18n("tolovegame_puzzle_lock"))
			else
				setText(self._shipDescTf, pg.ship_data_statistics[self._data.ship_id].name)
				setText(self._titleTf, i18n("tolovegame_puzzle_unlock"))
			end

			GetComponent(self._iconTf, typeof(Image)).color = var_11_1 and Color.New(1, 1, 1, 0.5) or Color.New(1, 1, 1, 1)

			setActive(self._lockMask, var_11_0)
			self:updateDetailBtn(var_11_2)
			self:updateProgress()

			return
		end,
		updateDetailBtn = function(self, arg_12_1)
			local var_12_1

			if self._maskAble then
				var_12_1 = false
			elseif self._progressCount == 3 then
				GetComponent(self._btnDetail, typeof(CanvasGroup)).interactable = false
				var_12_1 = false
			else
				var_12_1 = true
			end

			setText(self._btnDetailText, arg_12_1)
			setActive(findTF(self._btnDetail, "on"), var_12_1)
			setActive(findTF(self._btnDetail, "off"), not var_12_1)

			return
		end,
		setItemNew = function(self, arg_13_1)
			setActive(self._newTf, arg_13_1)

			return
		end,
		updateProgress = function(self)
			for iter_14_0 = 1, var_0_2 do
				local var_14_0
				local var_14_1 = findTF(self._progressTf, tostring(iter_14_0))

				if iter_14_0 ~= 1 then
					var_14_0 = findTF(self._progressTf, "line" .. iter_14_0)
				end

				if var_14_0 then
					setActive(findTF(var_14_0, "on"), iter_14_0 <= self._progressCount)
					setActive(findTF(var_14_0, "off"), self._progressCount < iter_14_0)
				end

				if var_14_1 then
					setActive(findTF(var_14_1, "on"), iter_14_0 <= self._progressCount)
					setActive(findTF(var_14_1, "off"), self._progressCount < iter_14_0)
				end
			end

			return
		end,
		setBtnGray = function(self, arg_15_1)
			setGray(self._btnDetail, arg_15_1, true)

			return
		end,
		setActiveData = function(arg_16_0)
			return
		end,
		getChapterIndex = function(self)
			return self._configId
		end
	}

	var_1_0:Ctor()

	return var_1_0
end

function PuzzleConnectMenu:Ctor(arg_18_1, arg_18_2)
	self._tf = arg_18_1
	self._event = arg_18_2
	self.itemContent = findTF(self._tf, "list/content")
	self.itemTpl = findTF(self._tf, "itemTpl")

	setActive(self.itemTpl, false)

	self.items = {}

	onButton(self._event, findTF(self._tf, "back"), function()
		self._event:emit(BaseUI.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._tf, "home"), function()
		self._event:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)

	return
end

function PuzzleConnectMenu:setData(arg_21_1)
	local var_21_0

	if #arg_21_1 > #self.items then
		var_21_0 = #arg_21_1 or #self.items
	end

	for iter_21_0 = 1, var_21_0 do
		if var_21_0 > #self.items then
			table.insert(self.items, self:createItem(arg_21_1[iter_21_0], iter_21_0))
		elseif var_21_0 > #arg_21_1 then
			self.items[iter_21_0]:setActive(false)
		else
			self.items[iter_21_0]:setData(arg_21_1[iter_21_0])
		end
	end

	return
end

function PuzzleConnectMenu:setActivity(arg_22_1)
	local var_22_2 = arg_22_1.data3_list
	local var_22_3 = arg_22_1:getDayIndex()
	local var_22_4, var_22_5 = parseTimeConfig(arg_22_1:getConfig("time"))
	local var_22_6 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_22_4[2])
	local var_22_7 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_22_0 = 1, #self.items do
		local var_22_8 = var_22_3 < iter_22_0
		local var_22_9 = math.floor((var_22_6 + 0 * (iter_22_0 - 1) - var_22_7) / 16)
		local var_22_10 = true
		local var_22_11 = self.items[iter_22_0]:getConfigId()

		if iter_22_0 > 1 and not table.contains(var_22_2, (self.items[iter_22_0 - 1]:getConfigId())) then
			var_22_10 = false
		end

		local var_22_12 = PuzzleConnectMediator.GetPuzzleActivityState(var_22_11, arg_22_1)
		local var_22_13 = false

		if var_22_12 ~= PuzzleConnectMediator.state_complete and not var_22_8 and var_22_10 then
			if PlayerPrefs.GetInt("puzzle_connect_new_" .. tostring(getProxy(PlayerProxy):getPlayerId()) .. "_" .. var_22_11) ~= 1 then
				var_22_13 = true
			end
		end

		local var_22_15

		if var_22_12 == PuzzleConnectMediator.state_collection then
			var_22_15 = 0
		elseif var_22_12 == PuzzleConnectMediator.state_puzzle then
			var_22_15 = 1
		elseif var_22_12 == PuzzleConnectMediator.state_connection then
			var_22_15 = 2
		elseif var_22_12 == PuzzleConnectMediator.state_complete then
			var_22_15 = 3
		end

		self.items[iter_22_0]:setItemNew(var_22_13)
		self.items[iter_22_0]:setItemMask(var_22_8, var_22_10, var_22_9, var_22_15)
	end

	return
end

function PuzzleConnectMenu:createItem(arg_23_1, arg_23_2)
	local var_23_0 = var_0_3(tf(instantiate(self.itemTpl)), self._event, arg_23_2)

	var_23_0:setContent(self.itemContent)
	var_23_0:setData(arg_23_1)
	var_23_0:setActive(true)

	return var_23_0
end

function PuzzleConnectMenu:show()
	setActive(self._tf, true)

	return
end

function PuzzleConnectMenu:hide()
	setActive(self._tf, false)

	return
end

function PuzzleConnectMenu:dispose()
	return
end

return PuzzleConnectMenu
