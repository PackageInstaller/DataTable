local BossRushEscapeManorPassedLayer = class("BossRushEscapeManorPassedLayer", import("view.base.BaseUI"))

function BossRushEscapeManorPassedLayer:getUIName()
	return "BossRushEscapeManorPassedUI"
end

function BossRushEscapeManorPassedLayer:didEnter()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	local var_2_0 = {
		glow = true
	}

	eachChild(self._tf:Find("Main"), function(arg_3_0, arg_3_1)
		setActive(arg_3_0, var_2_0[arg_3_0.name] or arg_3_0.name == tostring(BossRushEscapeManorPassedLayer.seriesId))

		return
	end)

	local function var_2_1(arg_4_0, arg_4_1)
		setActive(arg_4_0:Find("UnFinished"), arg_4_1 > 0)
		setActive(arg_4_0:Find("Challengeing"), arg_4_1 == 0)
		setActive(arg_4_0:Find("Finished"), arg_4_1 < 0)

		return
	end

	local function var_2_2(arg_5_0, arg_5_1)
		setSlider(self.rtSlider, 0, arg_5_1 - 1, arg_5_0 - 1)
		UIItemList.StaticAlign(self.rtContent, self.rtTpl, arg_5_1 - 1, function(arg_6_0, arg_6_1, arg_6_2)
			arg_6_1 = arg_6_1 + 1

			if arg_6_0 == UIItemList.EventUpdate then
				var_2_1(arg_6_2:Find("left"), arg_6_1 - arg_5_0)
				var_2_1(arg_6_2:Find("right"), arg_6_1 + 1 - arg_5_0)
			end

			return
		end)

		return
	end

	seriesAsync({
		function(arg_7_0)
			var_2_2(self.contextData.curIndex, self.contextData.maxIndex)
			onDelayTick(arg_7_0, 0.5)

			return
		end
	}, function()
		var_2_1(self.rtContent:GetChild(self.contextData.curIndex - 1):Find("left"), -1)

		if self.contextData.curIndex > 1 then
			var_2_1(self.rtContent:GetChild(self.contextData.curIndex - 2):Find("right"), -1)
		end

		self:combatPreload(function()
			seriesAsync({
				function(arg_10_0)
					var_2_2(self.contextData.curIndex + 1, self.contextData.maxIndex)
					onDelayTick(arg_10_0, 1.5)

					return
				end
			}, function()
				self:emit(ChallengePassedCombatLoadMediator.FINISH, self._loadObs)

				return
			end)

			return
		end)

		return
	end)

	return
end

function BossRushEscapeManorPassedLayer:combatPreload(arg_12_1)
	PoolMgr.GetInstance():DestroyAllSprite()

	self._loadObs = {}

	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_12_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_12_0:Init()

	local var_12_1, var_12_2 = CombatLoadUI.GetTotalResourceList(self.contextData)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		var_12_0:AddPreloadResource(iter_12_1)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_2) do
		var_12_0:AddPreloadCV(iter_12_3)
	end

	local var_12_3 = 0

	setActive(pg.UIMgr.GetInstance():GetMainCamera(), true)

	var_12_3 = var_12_0:StartPreload(function()
		arg_12_1()

		return
	end, function(arg_14_0)
		setSlider(self.rtSlider, 0, self.contextData.maxIndex - 1, self.contextData.curIndex - 1 + (var_12_3 == 0 and 0 or arg_14_0 / var_12_3))

		return
	end)

	return
end

function BossRushEscapeManorPassedLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BossRushEscapeManorPassedLayer
