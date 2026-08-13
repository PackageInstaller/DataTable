class = var_0_10000

local var_0_0 = var_0_10000("PuzzleConnectMenu")
local var_0_1 = 3
local var_0_2 = 3

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0._index = arg_1_2
			findTF = var_1
			arg_2_0._shipDescTf = var_1(arg_2_0._tf, "desc/text")
			findTF = var_1
			arg_2_0._titleTf = var_1(arg_2_0._tf, "title_text")
			findTF = var_1
			arg_2_0._iconTf = var_1(arg_2_0._tf, "icon")
			findTF = var_1
			arg_2_0._awardTfs = var_1(arg_2_0._tf, "iconBg")
			findTF = var_1
			arg_2_0._newTf = var_1(arg_2_0._tf, "new")
			findTF = var_1
			arg_2_0._progressTf = var_1(arg_2_0._tf, "progress")
			findTF = var_1
			arg_2_0._btnDetail = var_1(arg_2_0._tf, "btnDetail")
			findTF = var_1
			arg_2_0._btnDetailText = var_1(arg_2_0._btnDetail, "text")
			findTF = var_1
			arg_2_0._lockMask = var_1(arg_2_0._tf, "lockMask")
			onButton = var_1

			local var_2_0 = arg_2_0._event
			local var_2_1 = arg_2_0._btnDetail

			local function var_2_2()
				if arg_2_0._progressCount and arg_2_0._progressCount == 3 then
					return
				end

				PlayerPrefs = var_0

				local var_3_0 = var_0.SetInt
				local var_3_1 = "puzzle_connect_new_"

				tostring = var_3_10002
				getProxy = var_3_10003
				PlayerProxy = var_3_10004

				local var_3_2 = var_3_10003(var_3_10004)

				var_3_0(var_3_1 .. var_3_10002(var_3.getPlayerId(var_3_2)) .. "_" .. arg_2_0._configId, 1)

				local var_3_3 = arg_2_0

				var_0.setItemNew(var_3_3, false)

				local var_3_4 = arg_2_0._event
				local var_3_5 = var_0.emit

				PuzzleConnectLayer = var_2

				var_3_5(var_3_4, var_2.OPEN_DETAIL, {
					index = arg_2_0._index,
					data = arg_2_0._data
				})

				return
			end

			SFX_CONFIRM = var_2_10005

			var_1(var_2_0, var_2_1, var_2_2, var_2_10005)

			return
		end,
		setActive = function(arg_4_0, arg_4_1)
			setActive = var_2_10002

			var_2_10002(arg_4_0._tf, arg_4_1)

			return
		end,
		setContent = function(arg_5_0, arg_5_1)
			setParent = var_2_10002

			var_2_10002(arg_5_0._tf, arg_5_1)

			return
		end,
		setData = function(arg_6_0, arg_6_1)
			arg_6_0._configId = arg_6_1
			pg = var_2_10002
			arg_6_0._data = var_2_10002.activity_tolove_jigsaw[arg_6_0._configId]
			arg_6_0._progressCount = 0

			arg_6_0:updateUI()

			return
		end,
		updateUI = function(arg_7_0)
			setActive = var_2_10001

			var_2_10001(arg_7_0._iconTf, false)

			GetSpriteFromAtlasAsync = var_2_10001

			var_2_10001("ui/puzzleconnecticon_atlas", arg_7_0._data.item_icon, function(arg_8_0)
				setImageSprite = var_3_10001

				var_3_10001(arg_7_0._iconTf, arg_8_0, true)

				setActive = var_3_10001

				var_3_10001(arg_7_0._iconTf, true)

				return
			end)

			local var_7_0 = arg_7_0._data.show_award

			for iter_7_0 = 1, var_0_1 do
				findTF = var_2_10006
				var_2_10006 = var_2_10006(arg_7_0._tf, "awards/icon" .. iter_7_0)
				findTF = var_7

				local var_7_1 = var_7(arg_7_0._tf, "iconBg/" .. iter_7_0)
				local var_7_2

				if iter_7_0 <= #var_7_0 then
					var_7_2 = {
						type = var_7_0[iter_7_0][1],
						id = var_7_0[iter_7_0][2],
						amount = var_7_0[iter_7_0][3]
					}
					updateDrop = var_9

					var_9(var_2_10006, var_7_2)

					onButton = var_9

					local var_7_3 = arg_7_0._event
					local var_7_4 = var_2_10006

					local function var_7_5()
						local var_9_0 = arg_7_0._event
						local var_9_1 = var_0.emit

						BaseUI = var_3_10002

						var_9_1(var_9_0, var_3_10002.ON_DROP, var_7_2)

						return
					end

					SFX_PANEL = var_2_10013

					var_9(var_7_3, var_7_4, var_7_5, var_2_10013)

					setActive = var_9

					var_9(var_2_10006, true)

					setActive = var_9

					var_9(var_7_1, true)
				else
					setActive = var_7_2

					var_7_2(var_2_10006, false)

					setActive = var_7_2

					var_7_2(var_7_1, false)
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
				i18n = var_2_10008

				local var_11_3 = "tolovegame_puzzle_lock_by_time"

				math = var_2_10010
				var_11_2 = var_2_10008(var_11_3, var_2_10010.floor(arg_11_3 / 24), arg_11_3 % 24)
			elseif arg_11_2 then
				if arg_11_4 ~= 3 then
					var_11_1 = false
					var_11_0 = false
					i18n = var_2_10008
					var_11_2 = var_2_10008("tolovegame_puzzle_open_detail")
				else
					var_11_1 = false
					var_11_0 = false
					i18n = var_2_10008
					var_11_2 = var_2_10008("tolovegame_puzzle_finished")
				end
			else
				var_11_1 = true
				var_11_0 = true
				i18n = var_2_10008
				var_11_2 = var_2_10008("tolovegame_puzzle_lock_by_front")
			end

			arg_11_0._maskAble = var_11_0

			if var_11_0 then
				setText = var_2_10008

				local var_11_4 = arg_11_0._shipDescTf

				i18n = var_2_10010

				var_2_10008(var_11_4, var_2_10010("tolovegame_puzzle_ship_unknown"))

				setText = var_2_10008

				local var_11_5 = arg_11_0._titleTf

				i18n = var_2_10010

				var_2_10008(var_11_5, var_2_10010("tolovegame_puzzle_lock"))
			else
				setText = var_2_10008

				local var_11_6 = arg_11_0._shipDescTf

				pg = var_2_10010

				var_2_10008(var_11_6, var_2_10010.ship_data_statistics[arg_11_0._data.ship_id].name)

				setText = var_2_10008

				local var_11_7 = arg_11_0._titleTf

				i18n = var_2_10010

				var_2_10008(var_11_7, var_2_10010("tolovegame_puzzle_unlock"))
			end

			if var_11_1 then
				GetComponent = var_2_10008

				local var_11_8 = arg_11_0._iconTf

				typeof = var_2_10010
				Image = var_2_10011
				var_2_10008 = var_2_10008(var_11_8, var_2_10010(var_2_10011))
				Color = var_11_8
				var_2_10008.color = var_11_8.New(1, 1, 1, 0.5)
			else
				GetComponent = var_2_10008

				local var_11_9 = arg_11_0._iconTf

				typeof = var_2_10010
				Image = var_2_10011
				var_2_10008 = var_2_10008(var_11_9, var_2_10010(var_2_10011))
				Color = var_11_9
				var_2_10008.color = var_11_9.New(1, 1, 1, 1)
			end

			setActive = var_2_10008

			var_2_10008(arg_11_0._lockMask, var_11_0)
			arg_11_0:updateDetailBtn(var_11_2)
			arg_11_0:updateProgress()

			return
		end,
		updateDetailBtn = function(arg_12_0, arg_12_1)
			local var_12_0
			local var_12_2

			if arg_12_0._maskAble then
				var_12_0 = false
			elseif arg_12_0._progressCount == 3 then
				GetComponent = var_12_2

				local var_12_1 = arg_12_0._btnDetail

				typeof = var_2_10005
				CanvasGroup = var_2_10006
				var_12_2 = var_12_2(var_12_1, var_2_10005(var_2_10006))
				var_12_2.interactable = false
				var_12_0 = false
			else
				var_12_0 = true
			end

			setText = var_12_2

			var_12_2(arg_12_0._btnDetailText, arg_12_1)

			setActive = var_12_2
			findTF = var_4

			var_12_2(var_4(arg_12_0._btnDetail, "on"), var_12_0)

			setActive = var_12_2
			findTF = var_4

			var_12_2(var_4(arg_12_0._btnDetail, "off"), not var_12_0)

			return
		end,
		setItemNew = function(arg_13_0, arg_13_1)
			setActive = var_2_10002

			var_2_10002(arg_13_0._newTf, arg_13_1)

			return
		end,
		updateProgress = function(arg_14_0)
			local var_14_0 = arg_14_0._progressCount

			for iter_14_0 = 1, var_0_2 do
				local var_14_1

				findTF = var_2_10007

				local var_14_2 = arg_14_0._progressTf

				tostring = var_2_10009
				var_2_10007 = var_2_10007(var_14_2, var_2_10009(iter_14_0))

				if iter_14_0 ~= 1 then
					findTF = var_14_2
					var_14_1 = var_14_2(arg_14_0._progressTf, "line" .. iter_14_0)
				end

				if var_14_1 then
					setActive = var_14_2
					findTF = var_2_10009

					var_14_2(var_2_10009(var_14_1, "on"), iter_14_0 <= var_14_0)

					setActive = var_14_2
					findTF = var_2_10009

					var_14_2(var_2_10009(var_14_1, "off"), var_14_0 < iter_14_0)
				end

				if var_2_10007 then
					setActive = var_14_2
					findTF = var_2_10009

					var_14_2(var_2_10009(var_2_10007, "on"), iter_14_0 <= var_14_0)

					setActive = var_14_2
					findTF = var_2_10009

					var_14_2(var_2_10009(var_2_10007, "off"), var_14_0 < iter_14_0)
				end
			end

			return
		end,
		setBtnGray = function(arg_15_0, arg_15_1)
			setGray = var_2_10002

			var_2_10002(arg_15_0._btnDetail, arg_15_1, true)

			return
		end,
		setActiveData = function(arg_16_0)
			return
		end,
		getChapterIndex = function(arg_17_0)
			return arg_17_0._configId
		end
	}

	var_3.Ctor(var_1_0)

	return var_3
end

function var_0_0.Ctor(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._tf = arg_18_1
	arg_18_0._event = arg_18_2
	findTF = var_1_10003
	arg_18_0.itemContent = var_1_10003(arg_18_0._tf, "list/content")
	findTF = var_3
	arg_18_0.itemTpl = var_3(arg_18_0._tf, "itemTpl")
	setActive = var_3

	var_3(arg_18_0.itemTpl, false)

	arg_18_0.items = {}
	onButton = var_3

	local var_18_0 = arg_18_0._event

	findTF = var_5

	local var_18_1 = var_5(arg_18_0._tf, "back")

	local function var_18_2()
		local var_19_0 = arg_18_0._event
		local var_19_1 = var_0.emit

		BaseUI = var_2_10002

		var_19_1(var_19_0, var_2_10002.ON_BACK)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_18_0, var_18_1, var_18_2, var_7)

	onButton = var_3

	local var_18_3 = arg_18_0._event

	findTF = var_18_1

	local var_18_4 = var_18_1(arg_18_0._tf, "home")

	local function var_18_5()
		local var_20_0 = arg_18_0._event
		local var_20_1 = var_0.emit

		BaseUI = var_2_10002

		var_20_1(var_20_0, var_2_10002.ON_HOME)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_18_3, var_18_4, var_18_5, var_7)

	return
end

function var_0_0.setData(arg_21_0, arg_21_1)
	local var_21_0

	if not (#arg_21_1 > #arg_21_0.items) or not #arg_21_1 then
		var_21_0 = #arg_21_0.items
	end

	for iter_21_0 = 1, var_21_0 do
		if #arg_21_0.items < var_21_0 then
			table = var_7

			var_7.insert(arg_21_0.items, arg_21_0:createItem(arg_21_1[iter_21_0], iter_21_0))
		elseif var_21_0 > #arg_21_1 then
			local var_21_1 = arg_21_0.items[iter_21_0]

			var_7.setActive(var_21_1, false)
		else
			local var_21_2 = arg_21_0.items[iter_21_0]

			var_7.setData(var_21_2, arg_21_1[iter_21_0])
		end
	end

	return
end

function var_0_0.setActivity(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.data1_list
	local var_22_1 = arg_22_1.data2_list
	local var_22_2 = arg_22_1.data3_list
	local var_22_3 = arg_22_1
	local var_22_4 = arg_22_1.getDayIndex(var_22_3)

	parseTimeConfig = var_22_3

	local var_22_5 = arg_22_1
	local var_22_6, var_22_7 = var_22_3(arg_22_1.getConfig(var_22_5, "time"))

	pg = var_22_5

	local var_22_8 = var_22_5.TimeMgr.GetInstance()
	local var_22_9 = var_8.parseTimeFromConfig(var_22_8, var_22_6[2])

	pg = var_22_8

	local var_22_10 = var_22_8.TimeMgr.GetInstance()
	local var_22_11 = var_9.GetServerTime(var_22_10)

	for iter_22_0 = 1, #arg_22_0.items do
		local var_22_12 = var_22_4 < iter_22_0 and true or false
		local var_22_13 = var_22_9 + 0 * (iter_22_0 - 1)

		math = var_1_10016
		var_1_10016 = var_1_10016.floor((var_22_13 - var_22_11) / 16)

		local var_22_14 = true
		local var_22_15 = arg_22_0.items[iter_22_0]
		local var_22_16 = var_18.getConfigId(var_22_15)
		local var_22_18

		if 1 < iter_22_0 then
			local var_22_17 = arg_22_0.items[iter_22_0 - 1]

			var_22_18 = var_22_18.getConfigId(var_22_17)
			table = var_22_17

			if not var_22_17.contains(var_22_2, var_22_18) then
				var_22_14 = false
			end
		end

		PuzzleConnectMediator = var_22_18

		local var_22_19 = var_22_18.GetPuzzleActivityState(var_22_16, arg_22_1)
		local var_22_20 = false

		PuzzleConnectMediator = var_21

		if var_22_19 ~= var_21.state_complete and not var_22_12 and var_22_14 then
			PlayerPrefs = var_21

			local var_22_21 = var_21.GetInt

			var_1_10022 = "puzzle_connect_new_"
			tostring = var_1_10023
			getProxy = var_1_10024
			PlayerProxy = var_1_10025
			var_1_10025 = var_1_10024(var_1_10025)

			if var_22_21(var_1_10022 .. var_1_10023(var_1_10024.getPlayerId(var_1_10025)) .. "_" .. var_22_16) ~= 1 then
				var_22_20 = true
			end
		end

		local var_22_22

		PuzzleConnectMediator = var_1_10022

		if var_22_19 == var_1_10022.state_collection then
			var_22_22 = 0
		else
			PuzzleConnectMediator = var_1_10022

			if var_22_19 == var_1_10022.state_puzzle then
				var_22_22 = 1
			else
				PuzzleConnectMediator = var_1_10022

				if var_22_19 == var_1_10022.state_connection then
					var_22_22 = 2
				else
					PuzzleConnectMediator = var_1_10022

					if var_22_19 == var_1_10022.state_complete then
						var_22_22 = 3
					end
				end
			end
		end

		var_1_10023 = arg_22_0.items[iter_22_0]

		var_1_10022.setItemNew(var_1_10023, var_22_20)

		var_1_10023 = arg_22_0.items[iter_22_0]

		var_1_10022.setItemMask(var_1_10023, var_22_12, var_22_14, var_1_10016, var_22_22)
	end

	return
end

function var_0_0.createItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = var_0_3

	tf = var_1_10004
	instantiate = var_1_10005

	local var_23_1 = var_23_0(var_1_10004(var_1_10005(arg_23_0.itemTpl)), arg_23_0._event, arg_23_2)

	var_3.setContent(var_23_1, arg_23_0.itemContent)
	var_3:setData(arg_23_1)
	var_3:setActive(true)

	return var_3
end

function var_0_0.show(arg_24_0)
	setActive = var_1_10001

	var_1_10001(arg_24_0._tf, true)

	return
end

function var_0_0.hide(arg_25_0)
	setActive = var_1_10001

	var_1_10001(arg_25_0._tf, false)

	return
end

function var_0_0.dispose(arg_26_0)
	return
end

return var_0_0
