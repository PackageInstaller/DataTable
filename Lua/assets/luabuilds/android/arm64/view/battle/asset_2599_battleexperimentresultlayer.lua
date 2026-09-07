local BattleExperimentResultLayer = class("BattleExperimentResultLayer", import(".BattleContributionResultLayer"))

function BattleExperimentResultLayer:setPoint()
	self._contributionPoint = 0

	return
end

function BattleExperimentResultLayer:skip()
	for iter_2_0, iter_2_1 in ipairs(self._delayLeanList) do
		LeanTween.cancel(iter_2_1)
	end

	if self._stateFlag == BattleExperimentResultLayer.STATE_RANK_ANIMA then
		-- block empty
	elseif self._stateFlag == BattleExperimentResultLayer.STATE_REPORT then
		while self._conditionContainer.childCount > 0 do
			SetActive(self._conditionContainer:GetChild(self._conditionContainer.childCount - 1), true)
		end

		SetActive(self._bg:Find("jieuan01/tips"), true)

		self._stateFlag = BattleExperimentResultLayer.STATE_REPORTED
	elseif self._stateFlag == BattleExperimentResultLayer.STATE_REPORTED then
		self:displayBG()
		SetActive(self._bg:Find("jieuan01/tips"), false)
	end

	return
end

function BattleExperimentResultLayer:displayBG()
	LeanTween.moveX(rtf(self._conditions), 1300, BattleExperimentResultLayer.DURATION_MOVE)
	LeanTween.scale(self._grade, Vector3(0.6, 0.6, 0), BattleExperimentResultLayer.DURATION_MOVE)
	LeanTween.moveLocal(go((rtf(self._grade))), self._gradeUpperLeftPos, BattleExperimentResultLayer.DURATION_MOVE):setOnComplete(System.Action(function()
		self:displayShips()
		self:showRightBottomPanel()
		triggerButton(self._statisticsBtn)
		self:skipAtkAnima(self._atkContainerNext)
		self:skipAtkAnima(self._atkContainer)
		setActive(self._statisticsBtn, false)

		self._stateFlag = BattleExperimentResultLayer.STATE_DISPLAY

		return
	end))
	setActive(self._bg:Find("jieuan01/Bomb"), false)

	return
end

function BattleExperimentResultLayer:closeStatistics()
	return
end

function BattleExperimentResultLayer:displayShips()
	self._expTFs = {}
	self._nameTxts = {}
	self._initExp = {}
	self._skipExp = {}
	self._subSkipExp = {}
	self._subCardAnimaFuncList = {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self.shipVOs) do
		var_6_0[iter_6_1.id] = iter_6_1
	end

	local var_6_1 = self.contextData.statistics

	for iter_6_2, iter_6_3 in ipairs(self.shipVOs) do
		if var_6_1[iter_6_3.id] then
			var_6_1[iter_6_3.id].vo = iter_6_3
		end
	end

	local var_6_2 = self.contextData.oldMainShips
	local var_6_3 = 0

	for iter_6_4, iter_6_5 in ipairs(self.contextData.oldMainShips) do
		if var_6_1[iter_6_5.id] and var_6_3 < var_6_1[iter_6_5.id].output then
			self.mvpShipVO = iter_6_5
			var_6_3 = var_6_1[iter_6_5.id].output
		end
	end

	self._atkFuncs = {}
	self._commonAtkTplList = {}
	self._subAtkTplList = {}

	SetActive(self._atkToggle, #var_6_2 > 6)

	if #var_6_2 > 6 then
		onToggle(self, self._atkToggle, function(arg_7_0)
			SetActive(self._atkContainer, arg_7_0)
			SetActive(self._atkContainerNext, not arg_7_0)

			if arg_7_0 then
				self:skipAtkAnima(self._atkContainerNext)
			else
				self:skipAtkAnima(self._atkContainer)
			end

			return
		end, SFX_PANEL)
	end

	for iter_6_6, iter_6_7 in ipairs(var_6_2) do
		if var_6_1[iter_6_7.id] then
			local var_6_9 = table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_6_7.configId).type)
			local var_6_11
			local var_6_13

			if iter_6_6 > 6 then
				var_6_11 = self._atkContainerNext
				var_6_13 = 7
			else
				var_6_11 = self._atkContainer
				var_6_13 = 1
			end

			local var_6_14 = cloneTplTo(self._atkTpl, var_6_11)

			var_6_14.localPosition.x = var_6_14.localPosition.x + (iter_6_6 - var_6_13) * 74
			var_6_14.localPosition.y = var_6_14.localPosition.y + (iter_6_6 - var_6_13) * 4
			var_6_14.localPosition = var_6_14.localPosition

			local var_6_15 = var_6_14:Find("result/mask/icon")
			local var_6_16 = var_6_14:Find("result/type")

			var_6_15:GetComponent(typeof(Image)).sprite = LoadSprite("herohrzicon/" .. iter_6_7:getPainting())

			local var_6_17 = var_6_1[iter_6_7.id].output / var_6_3

			setImageSprite(var_6_16, GetSpriteFromAtlas("shiptype", shipType2print(iter_6_7:getShipType())), true)
			self:setAtkAnima(var_6_14, var_6_11, var_6_17, var_6_3, self.mvpShipVO == iter_6_7, var_6_1[iter_6_7.id].output, var_6_1[iter_6_7.id].kill_count)

			if iter_6_7.id == var_6_1._flagShipID then
				self.flagShipVO = iter_6_7
			end
		end
	end

	return
end

return BattleExperimentResultLayer
