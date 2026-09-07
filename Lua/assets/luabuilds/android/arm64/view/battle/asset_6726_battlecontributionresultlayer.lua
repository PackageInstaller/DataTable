local BattleContributionResultLayer = class("BattleContributionResultLayer", import(".BattleActivityBossResultLayer"))

function BattleContributionResultLayer:setActId(arg_1_1)
	self._actID = arg_1_1
	self._resourceID = pg.activity_event_worldboss[pg.activity_template[arg_1_1].config_id].damage_resource

	return
end

function BattleContributionResultLayer:didEnter()
	BattleContributionResultLayer.super.didEnter(self)
	self:setPoint()

	return
end

function BattleContributionResultLayer:setPoint()
	self._contributionPoint = 0

	for iter_3_0, iter_3_1 in ipairs(self.contextData.drops) do
		if iter_3_1.configId == self._resourceID then
			self._contributionPoint = iter_3_1.count
		end
	end

	return
end

function BattleContributionResultLayer:setGradeLabel()
	setActive(self._tf:Find("grade/Xyz/bg13"), false)
	LoadImageSpriteAsync("battlescore/grade_label_clear", self._tf:Find("grade/Xyz/bg14"), false)

	return
end

function BattleContributionResultLayer:rankAnimaFinish()
	setActive(self._conditionBGNormal, false)
	setActive(self._conditionBGContribute, true)
	self:setCondition(i18n("battle_result_total_damage"), self.contextData.statistics.specificDamage, COLOR_BLUE)
	self:setCondition(i18n("battle_result_contribution"), self._contributionPoint, COLOR_YELLOW)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleContributionResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	self._stateFlag = BattleContributionResultLayer.STATE_REPORT

	return
end

function BattleContributionResultLayer:setCondition(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = cloneTplTo(self._conditionContributeTpl, self._conditionContainer)

	setActive(var_7_0, false)

	var_7_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_7_1, "#FFFFFFFF")
	var_7_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_7_2, arg_7_3)

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleContributionResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_7_0, true)

			return
		end)).id)
	else
		setActive(var_7_0, true)
	end

	return
end

return BattleContributionResultLayer
