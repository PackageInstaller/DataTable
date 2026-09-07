local BattleRewardRerformResultLayer = class("BattleRewardRerformResultLayer", import(".BattleResultLayer"))

function BattleRewardRerformResultLayer:didEnter()
	setText(self._levelText, pg.expedition_data_template[self.contextData.stageId].name)

	local var_1_0 = rtf(self._grade)

	self._gradeUpperLeftPos = var_1_0.localPosition
	var_1_0.localPosition = Vector3(0, 25, 0)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(self._grade, Vector3(0.88, 0.88, 1), BattleRewardRerformResultLayer.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
		SetActive(self._levelText, true)
		self:rankAnimaFinish()

		return
	end))

	self._tf:GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0.5)
	self._stateFlag = BattleResultLayer.STATE_RANK_ANIMA

	onButton(self, self._skipBtn, function()
		self:skip()

		return
	end, SFX_CONFIRM)

	return
end

function BattleRewardRerformResultLayer:skip()
	if self._stateFlag == BattleResultLayer.STATE_REPORTED then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function BattleRewardRerformResultLayer:onBackPressed()
	triggerButton(self._skipBtn)

	return
end

function BattleRewardRerformResultLayer:willExit()
	LeanTween.cancel(go(self._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BattleRewardRerformResultLayer
