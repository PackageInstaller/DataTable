local BattleSubmarineRunResultLayer = class("BattleSubmarineRunResultLayer", import("..base.BaseUI"))

BattleSubmarineRunResultLayer.DURATION_WIN_FADE_IN = 0.5
BattleSubmarineRunResultLayer.DURATION_LOSE_FADE_IN = 1.5
BattleSubmarineRunResultLayer.DURATION_GRADE_LAST = 1.5
BattleSubmarineRunResultLayer.DURATION_MOVE = 0.7
BattleSubmarineRunResultLayer.DURATION_WIN_SCALE = 0.7

function BattleSubmarineRunResultLayer:getUIName()
	return "BattleResultUI"
end

function BattleSubmarineRunResultLayer:setPlayer()
	return
end

function BattleSubmarineRunResultLayer:setShips()
	return
end

function BattleSubmarineRunResultLayer:init()
	self._grade = self._tf:Find("grade")
	self._levelText = self._grade:Find("chapterName/Text22")
	self.clearFX = self._tf:Find("clear")
	self._main = self._tf:Find("main")
	self._blurConatiner = self._tf:Find("blur_container")
	self._bg = self._tf:Find("main/jiesuanbeijing")
	self._painting = self._blurConatiner:Find("painting")
	self._failPainting = self._painting:Find("fail")
	self._chat = self._painting:Find("chat")
	self._rightBottomPanel = self._main:Find("dodgem_confirm")
	self._exitBtn = self._rightBottomPanel:Find("confirm_btn")
	self._skipBtn = self._tf:Find("skipLayer")
	self.UIMain = pg.UIMgr.GetInstance().UIMain
	self.overlay = pg.UIMgr.GetInstance().OverlayMain

	local var_4_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_4_1 = self._tf:Find("grade/Xyz/bg13")
	local var_4_2 = self._tf:Find("grade/Xyz/bg14")
	local var_4_3
	local var_4_4
	local var_4_6 = self.contextData.score
	local var_4_7 = self.contextData.score > 0

	setActive(self._bg:Find("jieuan01/BG/bg_victory"), self.contextData.score > 0)
	setActive(self._bg:Find("jieuan01/BG/bg_fail"), not var_4_7)

	if var_4_7 then
		var_4_3 = "battlescore/battle_score_" .. var_4_0[var_4_6 + 1] .. "/letter_" .. var_4_0[var_4_6 + 1]
		var_4_4 = "battlescore/battle_score_" .. var_4_0[var_4_6 + 1] .. "/label_" .. var_4_0[var_4_6 + 1]
	else
		var_4_3 = "battlescore/battle_score_" .. var_4_0[1] .. "/letter_" .. var_4_0[1]
		var_4_4 = "battlescore/battle_score_" .. var_4_0[1] .. "/label_" .. var_4_0[1]
	end

	LoadImageSpriteAsync(var_4_3, var_4_1, false)
	LoadImageSpriteAsync(var_4_4, var_4_2, false)
	SetActive(self._levelText, false)
	SetActive(self._tf:Find("main/conditions"), false)

	self._ratioFitter = GetComponent(self._tf, typeof(AspectRatioFitter))
	self._ratioFitter.enabled = true
	self._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance().targetRatio
	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_5_0, arg_5_1)
		self._ratioFitter.aspectRatio = arg_5_1

		return
	end)

	return
end

function BattleSubmarineRunResultLayer:didEnter()
	setText(self._levelText, pg.expedition_data_template[self.contextData.stageId].name)

	local var_6_0 = rtf(self._grade)

	self._gradeUpperLeftPos = var_6_0.localPosition
	var_6_0.localPosition = Vector3(0, 25, 0)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._grade.transform.localScale = Vector3(1.5, 1.5, 0)

	LeanTween.scale(self._grade, Vector3(0.88, 0.88, 1), BattleSubmarineRunResultLayer.DURATION_WIN_SCALE):setOnComplete(System.Action(function()
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
	self:showPainting()

	return
end

function BattleSubmarineRunResultLayer:rankAnimaFinish()
	self._stateFlag = BattleResultLayer.STATE_REPORTED

	return
end

function BattleSubmarineRunResultLayer:showPainting()
	local var_10_1

	SetActive(self._painting, true)

	self.paintingName = "u556"

	setPaintingPrefabAsync(self._painting, self.paintingName, "jiesuan", function()
		if findTF(self._painting, "fitter").childCount > 0 then
			ShipExpressionHelper.SetExpression(findTF(self._painting, "fitter"):GetChild(0), self.paintingName, "win_mvp")
		end

		return
	end)
	SetActive(self._failPainting, false)

	if self.contextData.score > 1 then
		local var_10_3, var_10_4

		var_10_3, var_10_4, var_10_1 = ShipWordHelper.GetWordAndCV(900180, ShipWordHelper.WORD_TYPE_MVP)
	else
		local var_10_5, var_10_6

		var_10_5, var_10_6, var_10_1 = ShipWordHelper.GetWordAndCV(900180, ShipWordHelper.WORD_TYPE_LOSE)
	end

	setText(self._chat:Find("Text"), var_10_1)

	local var_10_7 = self._chat:Find("Text"):GetComponent(typeof(Text))

	var_10_7.alignment = #var_10_7.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	SetActive(self._chat, true)

	self._chat.transform.localScale = Vector3.New(0, 0, 0)

	LeanTween.moveX(rtf(self._painting), 50, 0.1):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self._chat.gameObject), Vector3.New(1, 1, 1), 0.1):setEase(LeanTweenType.easeOutBack)

		return
	end))

	return
end

function BattleSubmarineRunResultLayer:skip()
	if self._stateFlag == BattleResultLayer.STATE_RANK_ANIMA then
		-- block empty
	elseif self._stateFlag == BattleResultLayer.STATE_REPORTED then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE)
	end

	return
end

function BattleSubmarineRunResultLayer:onBackPressed()
	triggerButton(self._skipBtn)

	return
end

function BattleSubmarineRunResultLayer:willExit()
	LeanTween.cancel(go(self._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

	return
end

return BattleSubmarineRunResultLayer
