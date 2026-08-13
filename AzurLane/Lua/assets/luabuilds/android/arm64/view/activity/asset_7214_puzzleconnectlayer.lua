class = var_0_10000

local var_0_0 = "PuzzleConnectLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.OPEN_DETAIL = "open detail panel"
var_0_1.OPEN_MENU = "open menu panel"
var_0_1.OPEN_GAME = "open game panel"

function var_0_1.getUIName(arg_1_0)
	return "PuzzleConnectUI"
end

function var_0_1.didEnter(arg_2_0)
	PuzzleConnectMenu = var_1_10001

	local var_2_0 = var_1_10001.New

	findTF = var_1_10003
	arg_2_0.menuPanel = var_2_0(var_1_10003(arg_2_0._tf, "ad/menu"), arg_2_0)
	PuzzleConnectDetail = var_1

	local var_2_1 = var_1.New

	findTF = var_3
	arg_2_0.detailPanel = var_2_1(var_3(arg_2_0._tf, "ad/detail"), arg_2_0)
	PuzzleConnectGame = var_1

	local var_2_2 = var_1.New

	findTF = var_3
	arg_2_0.gamePanel = var_2_2(var_3(arg_2_0._tf, "ad/game"), arg_2_0)
	arg_2_0.panelDic = {
		arg_2_0.menuPanel,
		arg_2_0.detailPanel,
		arg_2_0.gamePanel
	}

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.bind

	PuzzleConnectLayer = var_4

	var_2_4(var_2_3, var_4.OPEN_DETAIL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.show(var_3_0, arg_2_0.menuPanel)

		local var_3_1 = arg_2_0

		var_2.show(var_3_1, arg_2_0.detailPanel, true)

		if arg_3_1 then
			local var_3_2 = arg_2_0.detailPanel

			var_2.setData(var_3_2, arg_3_1)

			local var_3_3 = arg_2_0

			getProxy = var_2_10003
			ActivityProxy = var_5

			local var_3_4 = var_2_10003(var_5)
			local var_3_5 = var_3.getActivityByType

			ActivityConst = var_6
			var_3_3._activity = var_3_5(var_3_4, var_6.ACTIVITY_TYPE_PUZZLE_CONNECT)

			local var_3_6 = arg_2_0.detailPanel

			var_2.setActivity(var_3_6, arg_2_0._activity)
		end

		return
	end)

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.bind

	PuzzleConnectLayer = var_4

	var_2_6(var_2_5, var_4.OPEN_MENU, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.show(var_4_0, arg_2_0.menuPanel)

		return
	end)

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.bind

	PuzzleConnectLayer = var_4

	var_2_8(var_2_7, var_4.OPEN_GAME, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.show(var_5_0, arg_2_0.gamePanel)

		if arg_5_1 then
			local var_5_1 = arg_2_0.gamePanel

			var_2.setData(var_5_1, arg_5_1)
		end

		return
	end)

	local var_2_9 = arg_2_0

	arg_2_0.show(var_2_9, arg_2_0.menuPanel)

	getProxy = var_1
	ActivityProxy = var_2_9

	local var_2_10 = var_1(var_2_9)
	local var_2_11 = var_1.getActivityByType

	ActivityConst = var_4
	arg_2_0._activity = var_2_11(var_2_10, var_4.ACTIVITY_TYPE_PUZZLE_CONNECT)

	local var_2_13, var_2_14

	if arg_2_0._activity then
		local var_2_12 = arg_2_0._activity

		var_2_13 = var_2_13.getConfig(var_2_12, "config_data")
		var_2_14 = arg_2_0.menuPanel

		var_2.setData(var_2_14, var_2_13)
	else
		local var_2_15 = arg_2_0.menuPanel

		var_2_13.setData(var_2_15, {
			1,
			2,
			3,
			4,
			5,
			6,
			7
		})
	end

	PlayerPrefs = var_2_13

	local var_2_16 = var_2_13.GetInt
	local var_2_17 = "puzzle_connect_first_"

	tostring = var_2_14
	getProxy = var_6
	PlayerProxy = var_1_10008

	local var_2_18 = var_6(var_1_10008)

	if var_2_16(var_2_17 .. var_2_14(var_6.getPlayerId(var_2_18))) ~= 1 then
		pg = var_2

		local var_2_19 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_2_19, "WEIXIANFAMINGPOJINZHONGWEITUO1", function()
			PlayerPrefs = var_2_10000

			local var_6_0 = var_2_10000.SetInt
			local var_6_1 = "puzzle_connect_first_"

			tostring = var_2_10003
			getProxy = var_2_10005
			PlayerProxy = var_2_10007

			local var_6_2 = var_2_10005(var_2_10007)

			var_6_0(var_6_1 .. var_2_10003(var_5.getPlayerId(var_6_2)), 1)

			return
		end)
	end

	arg_2_0:updateActivity()

	return
end

function var_0_1.show(arg_7_0, arg_7_1, arg_7_2)
	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_0.panelDic) do
		if iter_7_1 == arg_7_1 then
			iter_7_1:show()
		elseif not arg_7_2 then
			iter_7_1:hide()
		end
	end

	return
end

function var_0_1.updateActivity(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_8_0._activity = var_8_1(var_8_0, var_1_10004.ACTIVITY_TYPE_PUZZLE_CONNECT)

	if arg_8_0._activity then
		local var_8_2 = arg_8_0._activity
		local var_8_3 = var_1.getConfig(var_8_2, "config_data")
		local var_8_4 = arg_8_0.menuPanel

		var_2.setActivity(var_8_4, arg_8_0._activity)

		local var_8_5 = arg_8_0.detailPanel

		var_2.setActivity(var_8_5, arg_8_0._activity)

		local var_8_6 = arg_8_0.gamePanel

		var_2.setActivity(var_8_6, arg_8_0._activity)

		getProxy = var_2
		PlayerProxy = var_8_6

		local var_8_7 = var_2(var_8_6)
		local var_8_8 = arg_8_0._activity.data1_list
		local var_8_9 = arg_8_0._activity.data2_list
		local var_8_10 = arg_8_0._activity.data3_list
		local var_8_11 = arg_8_0._activity
		local var_8_12 = var_6.getDayIndex(var_8_11)
		local var_8_13 = 0

		for iter_8_0 = 1, #var_8_3 do
			local var_8_14 = var_8_3[iter_8_0]

			if iter_8_0 <= var_8_12 then
				table = var_1_10013

				if not var_1_10013.contains(var_8_10, var_8_14) then
					table = var_1_10013

					if not var_1_10013.contains(var_8_8, var_8_14) and iter_8_0 == var_8_13 + 1 then
						pg = var_1_10013
						var_1_10013 = var_1_10013.activity_tolove_jigsaw[var_8_14].need[3]
						pg = var_1_10014
						var_1_10014 = var_1_10014.activity_tolove_jigsaw[var_8_14].need[2]

						local var_8_15 = var_8_7:getData()

						if var_1_10013 <= var_15.getResource(var_8_15, var_1_10014) then
							local var_8_16 = arg_8_0
							local var_8_17 = arg_8_0.emit

							PuzzleConnectMediator = var_1_10019

							var_8_17(var_8_16, var_1_10019.CMD_ACTIVITY, {
								index = 1,
								config_id = var_8_14
							})
						end
					end
				else
					var_8_13 = var_8_13 < iter_8_0 and iter_8_0 or var_8_13
				end
			end
		end
	end

	return
end

function var_0_1.initEvent(arg_9_0)
	return
end

function var_0_1.willExit(arg_10_0)
	local var_10_0 = arg_10_0.detailPanel

	var_1.dispose(var_10_0)

	local var_10_1 = arg_10_0.menuPanel

	var_1.dispose(var_10_1)

	local var_10_2 = arg_10_0.gamePanel

	var_1.dispose(var_10_2)

	return
end

return var_0_1
