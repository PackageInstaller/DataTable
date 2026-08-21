local var_0_0 = class("PuzzleConnectMenu")
local var_0_1 = 3
local var_0_2 = 3

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	({
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._index = arg_1_2
			arg_2_0._shipDescTf = findTF(arg_2_0._tf, "desc/text")
			arg_2_0._titleTf = findTF(arg_2_0._tf, "title_text")
			arg_2_0._iconTf = findTF(arg_2_0._tf, "icon")
			arg_2_0._awardTfs = findTF(arg_2_0._tf, "iconBg")
			arg_2_0._newTf = findTF(arg_2_0._tf, "new")
			arg_2_0._progressTf = findTF(arg_2_0._tf, "progress")
			arg_2_0._btnDetail = findTF(arg_2_0._tf, "btnDetail")
			arg_2_0._btnDetailText = findTF(arg_2_0._btnDetail, "text")
			arg_2_0._lockMask = findTF(arg_2_0._tf, "lockMask")

			onButton(arg_2_0._event, arg_2_0._btnDetail, function()
				if arg_2_0._progressCount and arg_2_0._progressCount == 3 then
					return
				end

				PlayerPrefs.SetInt("puzzle_connect_new_" .. tostring(getProxy(PlayerProxy):getPlayerId()) .. "_" .. arg_2_0._configId, 1)
				arg_2_0:setItemNew(false)
				arg_2_0._event:emit(PuzzleConnectLayer.OPEN_DETAIL, {
					index = arg_2_0._index,
					data = arg_2_0._data
				})

				return
			end, SFX_CONFIRM)

			return
		end,
		setActive = function(arg_4_0, arg_4_1)
			setActive(arg_4_0._tf, arg_4_1)

			return
		end,
		setContent = function(arg_5_0, arg_5_1)
			setParent(arg_5_0._tf, arg_5_1)

			return
		end,
		setData = function(arg_6_0, arg_6_1)
			arg_6_0._configId = arg_6_1
			arg_6_0._data = pg.activity_tolove_jigsaw[arg_6_0._configId]
			arg_6_0._progressCount = 0

			arg_6_0:updateUI()

			return
		end,
		updateUI = function(arg_7_0)
			setActive(arg_7_0._iconTf, false)
			GetSpriteFromAtlasAsync("ui/puzzleconnecticon_atlas", arg_7_0._data.item_icon, function(arg_8_0)
				setImageSprite(arg_7_0._iconTf, arg_8_0, true)
				setActive(arg_7_0._iconTf, true)

				return
			end)

			for iter_7_0 = 1, var_0_1 do
				local var_7_0 = findTF(arg_7_0._tf, "awards/icon" .. iter_7_0)
				local var_7_1 = findTF(arg_7_0._tf, "iconBg/" .. iter_7_0)

				if iter_7_0 <= #arg_7_0._data.show_award then
					updateDrop(var_7_0, {
						type = arg_7_0._data.show_award[iter_7_0][1],
						id = arg_7_0._data.show_award[iter_7_0][2],
						amount = arg_7_0._data.show_award[iter_7_0][3]
					})
					onButton(arg_7_0._event, var_7_0, function()
						arg_7_0._event:emit(BaseUI.ON_DROP, var_0)

						return
					end, SFX_PANEL)
					setActive(var_7_0, true)
					setActive(var_7_1, true)
				else
					setActive(var_7_0, false)
					setActive(var_7_1, false)
				end
			end

			arg_7_0:setItemNew(false)
			arg_7_0:updateProgress()
			arg_7_0:setItemMask(false, true, 0, 0)

			return
		end,
		getConfigId = function(arg_10_0)
			return arg_10_0._configId
		end,
		setItemMask = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
			arg_11_0._progressCount = arg_11_4

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

			arg_11_0._maskAble = var_11_0

			if var_11_0 then
				setText(arg_11_0._shipDescTf, i18n("tolovegame_puzzle_ship_unknown"))
				setText(arg_11_0._titleTf, i18n("tolovegame_puzzle_lock"))
			else
				setText(arg_11_0._shipDescTf, pg.ship_data_statistics[arg_11_0._data.ship_id].name)
				setText(arg_11_0._titleTf, i18n("tolovegame_puzzle_unlock"))
			end

			GetComponent(arg_11_0._iconTf, typeof(Image)).color = var_11_1 and Color.New(1, 1, 1, 0.5) or Color.New(1, 1, 1, 1)

			setActive(arg_11_0._lockMask, var_11_0)
			arg_11_0:updateDetailBtn(var_11_2)
			arg_11_0:updateProgress()

			return
		end,
		updateDetailBtn = function(arg_12_0, arg_12_1)
			local var_12_1

			if arg_12_0._maskAble then
				var_12_1 = false
			elseif arg_12_0._progressCount == 3 then
				GetComponent(arg_12_0._btnDetail, typeof(CanvasGroup)).interactable = false
				var_12_1 = false
			else
				var_12_1 = true
			end

			setText(arg_12_0._btnDetailText, arg_12_1)
			setActive(findTF(arg_12_0._btnDetail, "on"), var_12_1)
			setActive(findTF(arg_12_0._btnDetail, "off"), not var_12_1)

			return
		end,
		setItemNew = function(arg_13_0, arg_13_1)
			setActive(arg_13_0._newTf, arg_13_1)

			return
		end,
		updateProgress = function(arg_14_0)
			for iter_14_0 = 1, var_0_2 do
				local var_14_0
				local var_14_1 = findTF(arg_14_0._progressTf, tostring(iter_14_0))

				if iter_14_0 ~= 1 then
					var_14_0 = findTF(arg_14_0._progressTf, "line" .. iter_14_0)
				end

				if var_14_0 then
					setActive(findTF(var_14_0, "on"), iter_14_0 <= arg_14_0._progressCount)
					setActive(findTF(var_14_0, "off"), arg_14_0._progressCount < iter_14_0)
				end

				if var_14_1 then
					setActive(findTF(var_14_1, "on"), iter_14_0 <= arg_14_0._progressCount)
					setActive(findTF(var_14_1, "off"), arg_14_0._progressCount < iter_14_0)
				end
			end

			return
		end,
		setBtnGray = function(arg_15_0, arg_15_1)
			setGray(arg_15_0._btnDetail, arg_15_1, true)

			return
		end,
		setActiveData = function(arg_16_0)
			return
		end,
		getChapterIndex = function(arg_17_0)
			return arg_17_0._configId
		end
	}).Ctor({
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._index = arg_1_2
			arg_2_0._shipDescTf = findTF(arg_2_0._tf, "desc/text")
			arg_2_0._titleTf = findTF(arg_2_0._tf, "title_text")
			arg_2_0._iconTf = findTF(arg_2_0._tf, "icon")
			arg_2_0._awardTfs = findTF(arg_2_0._tf, "iconBg")
			arg_2_0._newTf = findTF(arg_2_0._tf, "new")
			arg_2_0._progressTf = findTF(arg_2_0._tf, "progress")
			arg_2_0._btnDetail = findTF(arg_2_0._tf, "btnDetail")
			arg_2_0._btnDetailText = findTF(arg_2_0._btnDetail, "text")
			arg_2_0._lockMask = findTF(arg_2_0._tf, "lockMask")

			onButton(arg_2_0._event, arg_2_0._btnDetail, function()
				if arg_2_0._progressCount and arg_2_0._progressCount == 3 then
					return
				end

				PlayerPrefs.SetInt("puzzle_connect_new_" .. tostring(getProxy(PlayerProxy):getPlayerId()) .. "_" .. arg_2_0._configId, 1)
				arg_2_0:setItemNew(false)
				arg_2_0._event:emit(PuzzleConnectLayer.OPEN_DETAIL, {
					index = arg_2_0._index,
					data = arg_2_0._data
				})

				return
			end, SFX_CONFIRM)

			return
		end,
		setActive = function(arg_4_0, arg_4_1)
			setActive(arg_4_0._tf, arg_4_1)

			return
		end,
		setContent = function(arg_5_0, arg_5_1)
			setParent(arg_5_0._tf, arg_5_1)

			return
		end,
		setData = function(arg_6_0, arg_6_1)
			arg_6_0._configId = arg_6_1
			arg_6_0._data = pg.activity_tolove_jigsaw[arg_6_0._configId]
			arg_6_0._progressCount = 0

			arg_6_0:updateUI()

			return
		end,
		updateUI = function(arg_7_0)
			setActive(arg_7_0._iconTf, false)
			GetSpriteFromAtlasAsync("ui/puzzleconnecticon_atlas", arg_7_0._data.item_icon, function(arg_8_0)
				setImageSprite(arg_7_0._iconTf, arg_8_0, true)
				setActive(arg_7_0._iconTf, true)

				return
			end)

			for iter_7_0 = 1, var_0_1 do
				local var_7_0 = findTF(arg_7_0._tf, "awards/icon" .. iter_7_0)
				local var_7_1 = findTF(arg_7_0._tf, "iconBg/" .. iter_7_0)

				if iter_7_0 <= #arg_7_0._data.show_award then
					updateDrop(var_7_0, {
						type = arg_7_0._data.show_award[iter_7_0][1],
						id = arg_7_0._data.show_award[iter_7_0][2],
						amount = arg_7_0._data.show_award[iter_7_0][3]
					})
					onButton(arg_7_0._event, var_7_0, function()
						arg_7_0._event:emit(BaseUI.ON_DROP, var_0)

						return
					end, SFX_PANEL)
					setActive(var_7_0, true)
					setActive(var_7_1, true)
				else
					setActive(var_7_0, false)
					setActive(var_7_1, false)
				end
			end

			arg_7_0:setItemNew(false)
			arg_7_0:updateProgress()
			arg_7_0:setItemMask(false, true, 0, 0)

			return
		end,
		getConfigId = function(arg_10_0)
			return arg_10_0._configId
		end,
		setItemMask = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
			arg_11_0._progressCount = arg_11_4

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

			arg_11_0._maskAble = var_11_0

			if var_11_0 then
				setText(arg_11_0._shipDescTf, i18n("tolovegame_puzzle_ship_unknown"))
				setText(arg_11_0._titleTf, i18n("tolovegame_puzzle_lock"))
			else
				setText(arg_11_0._shipDescTf, pg.ship_data_statistics[arg_11_0._data.ship_id].name)
				setText(arg_11_0._titleTf, i18n("tolovegame_puzzle_unlock"))
			end

			GetComponent(arg_11_0._iconTf, typeof(Image)).color = var_11_1 and Color.New(1, 1, 1, 0.5) or Color.New(1, 1, 1, 1)

			setActive(arg_11_0._lockMask, var_11_0)
			arg_11_0:updateDetailBtn(var_11_2)
			arg_11_0:updateProgress()

			return
		end,
		updateDetailBtn = function(arg_12_0, arg_12_1)
			local var_12_1

			if arg_12_0._maskAble then
				var_12_1 = false
			elseif arg_12_0._progressCount == 3 then
				GetComponent(arg_12_0._btnDetail, typeof(CanvasGroup)).interactable = false
				var_12_1 = false
			else
				var_12_1 = true
			end

			setText(arg_12_0._btnDetailText, arg_12_1)
			setActive(findTF(arg_12_0._btnDetail, "on"), var_12_1)
			setActive(findTF(arg_12_0._btnDetail, "off"), not var_12_1)

			return
		end,
		setItemNew = function(arg_13_0, arg_13_1)
			setActive(arg_13_0._newTf, arg_13_1)

			return
		end,
		updateProgress = function(arg_14_0)
			for iter_14_0 = 1, var_0_2 do
				local var_14_0
				local var_14_1 = findTF(arg_14_0._progressTf, tostring(iter_14_0))

				if iter_14_0 ~= 1 then
					var_14_0 = findTF(arg_14_0._progressTf, "line" .. iter_14_0)
				end

				if var_14_0 then
					setActive(findTF(var_14_0, "on"), iter_14_0 <= arg_14_0._progressCount)
					setActive(findTF(var_14_0, "off"), arg_14_0._progressCount < iter_14_0)
				end

				if var_14_1 then
					setActive(findTF(var_14_1, "on"), iter_14_0 <= arg_14_0._progressCount)
					setActive(findTF(var_14_1, "off"), arg_14_0._progressCount < iter_14_0)
				end
			end

			return
		end,
		setBtnGray = function(arg_15_0, arg_15_1)
			setGray(arg_15_0._btnDetail, arg_15_1, true)

			return
		end,
		setActiveData = function(arg_16_0)
			return
		end,
		getChapterIndex = function(arg_17_0)
			return arg_17_0._configId
		end
	})

	return {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._index = arg_1_2
			arg_2_0._shipDescTf = findTF(arg_2_0._tf, "desc/text")
			arg_2_0._titleTf = findTF(arg_2_0._tf, "title_text")
			arg_2_0._iconTf = findTF(arg_2_0._tf, "icon")
			arg_2_0._awardTfs = findTF(arg_2_0._tf, "iconBg")
			arg_2_0._newTf = findTF(arg_2_0._tf, "new")
			arg_2_0._progressTf = findTF(arg_2_0._tf, "progress")
			arg_2_0._btnDetail = findTF(arg_2_0._tf, "btnDetail")
			arg_2_0._btnDetailText = findTF(arg_2_0._btnDetail, "text")
			arg_2_0._lockMask = findTF(arg_2_0._tf, "lockMask")

			onButton(arg_2_0._event, arg_2_0._btnDetail, function()
				if arg_2_0._progressCount and arg_2_0._progressCount == 3 then
					return
				end

				PlayerPrefs.SetInt("puzzle_connect_new_" .. tostring(getProxy(PlayerProxy):getPlayerId()) .. "_" .. arg_2_0._configId, 1)
				arg_2_0:setItemNew(false)
				arg_2_0._event:emit(PuzzleConnectLayer.OPEN_DETAIL, {
					index = arg_2_0._index,
					data = arg_2_0._data
				})

				return
			end, SFX_CONFIRM)

			return
		end,
		setActive = function(arg_4_0, arg_4_1)
			setActive(arg_4_0._tf, arg_4_1)

			return
		end,
		setContent = function(arg_5_0, arg_5_1)
			setParent(arg_5_0._tf, arg_5_1)

			return
		end,
		setData = function(arg_6_0, arg_6_1)
			arg_6_0._configId = arg_6_1
			arg_6_0._data = pg.activity_tolove_jigsaw[arg_6_0._configId]
			arg_6_0._progressCount = 0

			arg_6_0:updateUI()

			return
		end,
		updateUI = function(arg_7_0)
			setActive(arg_7_0._iconTf, false)
			GetSpriteFromAtlasAsync("ui/puzzleconnecticon_atlas", arg_7_0._data.item_icon, function(arg_8_0)
				setImageSprite(arg_7_0._iconTf, arg_8_0, true)
				setActive(arg_7_0._iconTf, true)

				return
			end)

			for iter_7_0 = 1, var_0_1 do
				local var_7_0 = findTF(arg_7_0._tf, "awards/icon" .. iter_7_0)
				local var_7_1 = findTF(arg_7_0._tf, "iconBg/" .. iter_7_0)

				if iter_7_0 <= #arg_7_0._data.show_award then
					updateDrop(var_7_0, {
						type = arg_7_0._data.show_award[iter_7_0][1],
						id = arg_7_0._data.show_award[iter_7_0][2],
						amount = arg_7_0._data.show_award[iter_7_0][3]
					})
					onButton(arg_7_0._event, var_7_0, function()
						arg_7_0._event:emit(BaseUI.ON_DROP, var_0)

						return
					end, SFX_PANEL)
					setActive(var_7_0, true)
					setActive(var_7_1, true)
				else
					setActive(var_7_0, false)
					setActive(var_7_1, false)
				end
			end

			arg_7_0:setItemNew(false)
			arg_7_0:updateProgress()
			arg_7_0:setItemMask(false, true, 0, 0)

			return
		end,
		getConfigId = function(arg_10_0)
			return arg_10_0._configId
		end,
		setItemMask = function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
			arg_11_0._progressCount = arg_11_4

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

			arg_11_0._maskAble = var_11_0

			if var_11_0 then
				setText(arg_11_0._shipDescTf, i18n("tolovegame_puzzle_ship_unknown"))
				setText(arg_11_0._titleTf, i18n("tolovegame_puzzle_lock"))
			else
				setText(arg_11_0._shipDescTf, pg.ship_data_statistics[arg_11_0._data.ship_id].name)
				setText(arg_11_0._titleTf, i18n("tolovegame_puzzle_unlock"))
			end

			GetComponent(arg_11_0._iconTf, typeof(Image)).color = var_11_1 and Color.New(1, 1, 1, 0.5) or Color.New(1, 1, 1, 1)

			setActive(arg_11_0._lockMask, var_11_0)
			arg_11_0:updateDetailBtn(var_11_2)
			arg_11_0:updateProgress()

			return
		end,
		updateDetailBtn = function(arg_12_0, arg_12_1)
			local var_12_1

			if arg_12_0._maskAble then
				var_12_1 = false
			elseif arg_12_0._progressCount == 3 then
				GetComponent(arg_12_0._btnDetail, typeof(CanvasGroup)).interactable = false
				var_12_1 = false
			else
				var_12_1 = true
			end

			setText(arg_12_0._btnDetailText, arg_12_1)
			setActive(findTF(arg_12_0._btnDetail, "on"), var_12_1)
			setActive(findTF(arg_12_0._btnDetail, "off"), not var_12_1)

			return
		end,
		setItemNew = function(arg_13_0, arg_13_1)
			setActive(arg_13_0._newTf, arg_13_1)

			return
		end,
		updateProgress = function(arg_14_0)
			for iter_14_0 = 1, var_0_2 do
				local var_14_0
				local var_14_1 = findTF(arg_14_0._progressTf, tostring(iter_14_0))

				if iter_14_0 ~= 1 then
					var_14_0 = findTF(arg_14_0._progressTf, "line" .. iter_14_0)
				end

				if var_14_0 then
					setActive(findTF(var_14_0, "on"), iter_14_0 <= arg_14_0._progressCount)
					setActive(findTF(var_14_0, "off"), arg_14_0._progressCount < iter_14_0)
				end

				if var_14_1 then
					setActive(findTF(var_14_1, "on"), iter_14_0 <= arg_14_0._progressCount)
					setActive(findTF(var_14_1, "off"), arg_14_0._progressCount < iter_14_0)
				end
			end

			return
		end,
		setBtnGray = function(arg_15_0, arg_15_1)
			setGray(arg_15_0._btnDetail, arg_15_1, true)

			return
		end,
		setActiveData = function(arg_16_0)
			return
		end,
		getChapterIndex = function(arg_17_0)
			return arg_17_0._configId
		end
	}
end

function var_0_0.Ctor(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._tf = arg_18_1
	arg_18_0._event = arg_18_2
	arg_18_0.itemContent = findTF(arg_18_0._tf, "list/content")
	arg_18_0.itemTpl = findTF(arg_18_0._tf, "itemTpl")

	setActive(arg_18_0.itemTpl, false)

	arg_18_0.items = {}

	onButton(arg_18_0._event, findTF(arg_18_0._tf, "back"), function()
		arg_18_0._event:emit(BaseUI.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_18_0._event, findTF(arg_18_0._tf, "home"), function()
		arg_18_0._event:emit(BaseUI.ON_HOME)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.setData(arg_21_0, arg_21_1)
	if #arg_21_1 > #arg_21_0.items then
		local var_21_0 = #arg_21_1 or #arg_21_0.items

		for iter_21_0 = 1, var_21_0 do
			if var_21_0 > #arg_21_0.items then
				table.insert(arg_21_0.items, arg_21_0:createItem(arg_21_1[iter_21_0], iter_21_0))
			elseif var_21_0 > #arg_21_1 then
				arg_21_0.items[iter_21_0]:setActive(false)
			else
				arg_21_0.items[iter_21_0]:setData(arg_21_1[iter_21_0])
			end
		end

		return
	end
end

function var_0_0.setActivity(arg_22_0, arg_22_1)
	local var_22_2 = arg_22_1.data3_list
	local var_22_3 = arg_22_1:getDayIndex()
	local var_22_4, var_22_5 = parseTimeConfig(arg_22_1:getConfig("time"))
	local var_22_6 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_22_4[2])
	local var_22_7 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_22_0 = 1, #arg_22_0.items do
		local var_22_8 = var_22_3 < iter_22_0
		local var_22_9 = math.floor((var_22_6 + 0 * (iter_22_0 - 1) - var_22_7) / 16)
		local var_22_10 = true
		local var_22_11 = arg_22_0.items[iter_22_0]:getConfigId()

		if iter_22_0 > 1 and not table.contains(var_22_2, (arg_22_0.items[iter_22_0 - 1]:getConfigId())) then
			var_22_10 = false
		end

		local var_22_12 = PuzzleConnectMediator.GetPuzzleActivityState(var_22_11, arg_22_1)
		local var_22_13 = false

		if var_22_12 ~= PuzzleConnectMediator.state_complete and not var_22_8 and var_22_10 then
			local var_22_14 = getProxy(PlayerProxy)
			local var_22_15 = tostring(var_22_14:getPlayerId())

			if PlayerPrefs.GetInt("puzzle_connect_new_" .. var_22_15 .. "_" .. var_22_11) ~= 1 then
				var_22_13 = true
			end
		end

		local var_22_16

		if var_22_12 == PuzzleConnectMediator.state_collection then
			var_22_16 = 0
		elseif var_22_12 == PuzzleConnectMediator.state_puzzle then
			var_22_16 = 1
		elseif var_22_12 == PuzzleConnectMediator.state_connection then
			var_22_16 = 2
		elseif var_22_12 == PuzzleConnectMediator.state_complete then
			var_22_16 = 3
		end

		arg_22_0.items[iter_22_0]:setItemNew(var_22_13)
		arg_22_0.items[iter_22_0]:setItemMask(var_22_8, var_22_10, var_22_9, var_22_16)
	end

	return
end

function var_0_0.createItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = var_0_3(tf(instantiate(arg_23_0.itemTpl)), arg_23_0._event, arg_23_2)

	var_23_0:setContent(arg_23_0.itemContent)
	var_23_0:setData(arg_23_1)
	var_23_0:setActive(true)

	return var_23_0
end

function var_0_0.show(arg_24_0)
	setActive(arg_24_0._tf, true)

	return
end

function var_0_0.hide(arg_25_0)
	setActive(arg_25_0._tf, false)

	return
end

function var_0_0.dispose(arg_26_0)
	return
end

return var_0_0
