local var_0_0 = class("BossRushVerZenkerPassedLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BossRushVerZenkerPassedUI"
end

function var_0_0.didEnter(arg_2_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_2_0._tf)

	local var_2_0 = {
		word = true,
		glow = true
	}

	eachChild(arg_2_0._tf:Find("main"), function(arg_3_0, arg_3_1)
		local var_3_0 = var_2_0[arg_3_0.name] or arg_3_0.name == tostring(BossRushVerZenkerPassedLayer.seriesId)

		setActive(arg_3_0, var_3_0)

		return
	end)
	eachChild(arg_2_0._tf:Find("Image/content"), function(arg_4_0, arg_4_1)
		setActive(arg_4_0, arg_4_1 < arg_2_0.contextData.maxIndex)

		return
	end)
	arg_2_0:combatPreload(function()
		seriesAsync({
			function(arg_6_0)
				triggerToggle(arg_2_0._tf:Find("Image/content"):GetChild(arg_2_0.contextData.curIndex - 1), true)
				onDelayTick(arg_6_0, 1.5)

				return
			end,
			function(arg_7_0)
				triggerToggle(arg_2_0._tf:Find("Image/content"):GetChild(arg_2_0.contextData.curIndex), true)
				onDelayTick(arg_7_0, 1.5)

				return
			end
		}, function()
			arg_2_0:emit(ChallengePassedCombatLoadMediator.FINISH, arg_2_0._loadObs)

			return
		end)

		return
	end)

	return
end

function var_0_0.combatPreload(arg_9_0, arg_9_1)
	PoolMgr.GetInstance():DestroyAllSprite()

	arg_9_0._loadObs = {}

	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_9_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_9_0:Init()

	local var_9_1, var_9_2 = CombatLoadUI.GetTotalResourceList(arg_9_0.contextData)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		var_9_0:AddPreloadResource(iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_2) do
		var_9_0:AddPreloadCV(iter_9_3)
	end

	setActive(pg.UIMgr.GetInstance():GetMainCamera(), true)

	local var_9_4 = var_9_0:StartPreload(function()
		arg_9_1()

		return
	end, function(arg_11_0)
		return
	end)

	return
end

function var_0_0.willExit(arg_12_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
