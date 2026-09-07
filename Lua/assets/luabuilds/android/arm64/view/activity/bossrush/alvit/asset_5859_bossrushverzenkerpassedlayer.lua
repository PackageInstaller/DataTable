local BossRushVerZenkerPassedLayer = class("BossRushVerZenkerPassedLayer", import("view.base.BaseUI"))

function BossRushVerZenkerPassedLayer:getUIName()
	return "BossRushVerZenkerPassedUI"
end

function BossRushVerZenkerPassedLayer:didEnter()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	local var_2_0 = {
		word = true,
		glow = true
	}

	eachChild(self._tf:Find("main"), function(arg_3_0, arg_3_1)
		setActive(arg_3_0, var_2_0[arg_3_0.name] or arg_3_0.name == tostring(BossRushVerZenkerPassedLayer.seriesId))

		return
	end)
	eachChild(self._tf:Find("Image/content"), function(arg_4_0, arg_4_1)
		setActive(arg_4_0, arg_4_1 < self.contextData.maxIndex)

		return
	end)
	self:combatPreload(function()
		seriesAsync({
			function(arg_6_0)
				triggerToggle(self._tf:Find("Image/content"):GetChild(self.contextData.curIndex - 1), true)
				onDelayTick(arg_6_0, 1.5)

				return
			end,
			function(arg_7_0)
				triggerToggle(self._tf:Find("Image/content"):GetChild(self.contextData.curIndex), true)
				onDelayTick(arg_7_0, 1.5)

				return
			end
		}, function()
			self:emit(ChallengePassedCombatLoadMediator.FINISH, self._loadObs)

			return
		end)

		return
	end)

	return
end

function BossRushVerZenkerPassedLayer:combatPreload(arg_9_1)
	PoolMgr.GetInstance():DestroyAllSprite()

	self._loadObs = {}

	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_9_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_9_0:Init()

	local var_9_1, var_9_2 = CombatLoadUI.GetTotalResourceList(self.contextData)

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

function BossRushVerZenkerPassedLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BossRushVerZenkerPassedLayer
