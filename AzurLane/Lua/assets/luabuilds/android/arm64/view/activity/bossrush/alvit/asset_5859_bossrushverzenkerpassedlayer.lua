class = var_0_10000

local var_0_0 = "BossRushVerZenkerPassedLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushVerZenkerPassedUI"
end

function var_0_1.didEnter(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)

	local var_2_1 = {
		word = true,
		glow = true
	}

	eachChild = var_1_10002

	local var_2_2 = arg_2_0._tf

	var_1_10002(var_4.Find(var_2_2, "main"), function(arg_3_0, arg_3_1)
		setActive = var_2_10002

		local var_3_0 = arg_3_0
		local var_3_1

		if not var_2_1[arg_3_0.name] then
			var_3_1 = arg_3_0.name
			tostring = var_6
			BossRushVerZenkerPassedLayer = var_2_10008
			var_3_1 = var_3_1 == var_6(var_2_10008.seriesId)
		end

		var_2_10002(var_3_0, var_3_1)

		return
	end)

	eachChild = var_1_10002

	local var_2_3 = arg_2_0._tf

	var_1_10002(var_4.Find(var_2_3, "Image/content"), function(arg_4_0, arg_4_1)
		setActive = var_2_10002

		var_2_10002(arg_4_0, arg_4_1 < arg_2_0.contextData.maxIndex)

		return
	end)

	local function var_2_4()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_6_0)
				triggerToggle = var_3_10001

				local var_6_0 = arg_2_0._tf
				local var_6_1 = var_3.Find(var_6_0, "Image/content")

				var_3_10001(var_3.GetChild(var_6_1, arg_2_0.contextData.curIndex - 1), true)

				onDelayTick = var_3_10001

				var_3_10001(arg_6_0, 1.5)

				return
			end,
			function(arg_7_0)
				triggerToggle = var_3_10001

				local var_7_0 = arg_2_0._tf
				local var_7_1 = var_3.Find(var_7_0, "Image/content")

				var_3_10001(var_3.GetChild(var_7_1, arg_2_0.contextData.curIndex), true)

				onDelayTick = var_3_10001

				var_3_10001(arg_7_0, 1.5)

				return
			end
		}, function()
			local var_8_0 = arg_2_0
			local var_8_1 = var_0.emit

			ChallengePassedCombatLoadMediator = var_3_10003

			var_8_1(var_8_0, var_3_10003.FINISH, arg_2_0._loadObs)

			return
		end)

		return
	end

	arg_2_0:combatPreload(var_2_4)

	return
end

function var_0_1.combatPreload(arg_9_0, arg_9_1)
	PoolMgr = var_1_10002

	local var_9_0 = var_1_10002.GetInstance()

	var_2.DestroyAllSprite(var_9_0)

	arg_9_0._loadObs = {}
	ys = var_2

	local var_9_1 = var_2.Battle.BattleFXPool.GetInstance()

	var_2.Init(var_9_1)

	ys = var_2

	local var_9_2 = var_2.Battle.BattleResourceManager.GetInstance()

	var_2.Init(var_9_2)

	CombatLoadUI = var_3

	local var_9_3, var_9_4 = var_3.GetTotalResourceList(arg_9_0.contextData)

	ipairs = var_5

	for iter_9_0, iter_9_1 in var_5(var_9_3) do
		var_2:AddPreloadResource(iter_9_1)
	end

	ipairs = var_5

	for iter_9_2, iter_9_3 in var_5(var_9_4) do
		var_2:AddPreloadCV(iter_9_3)
	end

	local function var_9_5()
		arg_9_1()

		return
	end

	local var_9_6 = 0

	local function var_9_7(arg_11_0)
		return
	end

	pg = iter_9_2

	local var_9_8 = iter_9_2.UIMgr.GetInstance()
	local var_9_9 = var_8.GetMainCamera(var_9_8)

	setActive = iter_9_3

	iter_9_3(var_9_9, true)

	local var_9_10 = var_2:StartPreload(var_9_5, var_9_7)

	return
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf)

	return
end

return var_0_1
