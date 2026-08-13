class = var_0_10000

local var_0_0 = "BossRushEscapeManorPassedLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushEscapeManorPassedUI"
end

function var_0_1.didEnter(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = {
		glow = true
	}

	eachChild = var_1_10002

	local var_2_2 = arg_2_0._tf

	var_1_10002(var_4.Find(var_2_2, "Main"), function(arg_3_0, arg_3_1)
		setActive = var_2_10002

		local var_3_0 = arg_3_0
		local var_3_1

		if not var_2_1[arg_3_0.name] then
			var_3_1 = arg_3_0.name
			tostring = var_6
			BossRushEscapeManorPassedLayer = var_2_10008
			var_3_1 = var_3_1 == var_6(var_2_10008.seriesId)
		end

		var_2_10002(var_3_0, var_3_1)

		return
	end)

	local function var_2_3(arg_4_0, arg_4_1)
		setActive = var_2_10002

		var_2_10002(arg_4_0:Find("UnFinished"), arg_4_1 > 0)

		setActive = var_2_10002

		var_2_10002(arg_4_0:Find("Challengeing"), arg_4_1 == 0)

		setActive = var_2_10002

		var_2_10002(arg_4_0:Find("Finished"), arg_4_1 < 0)

		return
	end

	local function var_2_4(arg_5_0, arg_5_1)
		setSlider = var_2_10002

		var_2_10002(arg_2_0.rtSlider, 0, arg_5_1 - 1, arg_5_0 - 1)

		UIItemList = var_2_10002

		var_2_10002.StaticAlign(arg_2_0.rtContent, arg_2_0.rtTpl, arg_5_1 - 1, function(arg_6_0, arg_6_1, arg_6_2)
			arg_6_1 = arg_6_1 + 1
			UIItemList = var_3_10003

			if arg_6_0 == var_3_10003.EventUpdate then
				var_2_3(arg_6_2:Find("left"), arg_6_1 - arg_5_0)
				var_2_3(arg_6_2:Find("right"), arg_6_1 + 1 - arg_5_0)
			end

			return
		end)

		return
	end

	seriesAsync = var_4

	var_4({
		function(arg_7_0)
			var_2_4(arg_2_0.contextData.curIndex, arg_2_0.contextData.maxIndex)

			onDelayTick = var_1

			var_1(arg_7_0, 0.5)

			return
		end
	}, function()
		local var_8_0 = arg_2_0.contextData.curIndex
		local var_8_1 = arg_2_0.contextData.maxIndex
		local var_8_2 = var_2_3
		local var_8_3 = arg_2_0.rtContent
		local var_8_4 = var_4.GetChild(var_8_3, var_8_0 - 1)

		var_8_2(var_4.Find(var_8_4, "left"), -1)

		if var_8_0 > 1 then
			local var_8_5 = var_2_3
			local var_8_6 = arg_2_0.rtContent
			local var_8_7 = var_4.GetChild(var_8_6, var_8_0 - 2)

			var_8_5(var_4.Find(var_8_7, "right"), -1)
		end

		local function var_8_8()
			seriesAsync = var_3_10000

			var_3_10000({
				function(arg_10_0)
					var_2_4(arg_2_0.contextData.curIndex + 1, arg_2_0.contextData.maxIndex)

					onDelayTick = var_1

					var_1(arg_10_0, 1.5)

					return
				end
			}, function()
				local var_11_0 = arg_2_0
				local var_11_1 = var_0.emit

				ChallengePassedCombatLoadMediator = var_4_10003

				var_11_1(var_11_0, var_4_10003.FINISH, arg_2_0._loadObs)

				return
			end)

			return
		end

		local var_8_9 = arg_2_0

		var_3.combatPreload(var_8_9, var_8_8)

		return
	end)

	return
end

function var_0_1.combatPreload(arg_12_0, arg_12_1)
	PoolMgr = var_1_10002

	local var_12_0 = var_1_10002.GetInstance()

	var_2.DestroyAllSprite(var_12_0)

	arg_12_0._loadObs = {}
	ys = var_2

	local var_12_1 = var_2.Battle.BattleFXPool.GetInstance()

	var_2.Init(var_12_1)

	ys = var_2

	local var_12_2 = var_2.Battle.BattleResourceManager.GetInstance()

	var_2.Init(var_12_2)

	CombatLoadUI = var_3

	local var_12_3, var_12_4 = var_3.GetTotalResourceList(arg_12_0.contextData)

	ipairs = var_5

	for iter_12_0, iter_12_1 in var_5(var_12_3) do
		var_2:AddPreloadResource(iter_12_1)
	end

	ipairs = var_5

	for iter_12_2, iter_12_3 in var_5(var_12_4) do
		var_2:AddPreloadCV(iter_12_3)
	end

	local function var_12_5()
		arg_12_1()

		return
	end

	local var_12_6 = 0

	local function var_12_7(arg_14_0)
		local var_14_0
		local var_14_1 = var_12_6 == 0 and 0 or arg_14_0 / var_12_6

		setSlider = var_2

		var_2(arg_12_0.rtSlider, 0, arg_12_0.contextData.maxIndex - 1, arg_12_0.contextData.curIndex - 1 + var_14_1)

		return
	end

	pg = iter_12_2

	local var_12_8 = iter_12_2.UIMgr.GetInstance()
	local var_12_9 = var_8.GetMainCamera(var_12_8)

	setActive = iter_12_3

	iter_12_3(var_12_9, true)

	var_12_6 = var_2:StartPreload(var_12_5, var_12_7)

	return
end

function var_0_1.willExit(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf)

	return
end

return var_0_1
