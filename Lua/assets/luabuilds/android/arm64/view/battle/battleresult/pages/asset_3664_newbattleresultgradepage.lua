local NewBattleResultGradePage = class("NewBattleResultGradePage", import("view.base.BaseSubView"))

function NewBattleResultGradePage:getUIName()
	return "NewBattleResultGradePage"
end

function NewBattleResultGradePage:OnLoaded()
	self.parentTr = self._tf.parent
	self.bgTr = self._tf:Find("bg")
	self.gradePanel = self.bgTr:Find("grade")
	self.gradeIcon = self.bgTr:Find("grade/icon")
	self.gradeTxt = self.bgTr:Find("grade/Text")
	self.gradeLabel = self.bgTr:Find("grade/label")
	self.gradeChapterName = self.bgTr:Find("grade/chapterName")
	self.gradeTxtCG = self.gradeTxt:GetComponent(typeof(CanvasGroup))
	self.gradeChapterNameCG = self.gradeChapterName:GetComponent(typeof(CanvasGroup))
	self.objectiveContainer = self.bgTr:Find("conditions/list")
	self.objectiveTpl = self.bgTr:Find("conditions/list/tpl")
	self.objectiveContainer.localPosition = Vector3(2000, self.objectiveContainer.localPosition.y, 0)

	setText(self.bgTr:Find("conditions/Text"), i18n("battle_result_targets"))

	return
end

function NewBattleResultGradePage:SetUp(arg_3_1)
	self:Show()
	seriesAsync({
		function(arg_4_0)
			self:LoadBGAndGrade(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:PlayEnterAnimation(arg_5_0)
			self:UpdateChapterName()

			return
		end,
		function(arg_6_0)
			self:LoadEffects(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:UpdateObjectives(arg_7_0)

			return
		end,
		function(arg_8_0)
			self:RegisterEvent(arg_8_0)

			return
		end
	}, function()
		self:Clear()
		self:Destroy()
		arg_3_1()

		return
	end)

	return
end

function NewBattleResultGradePage:RegisterEvent(arg_10_1)
	if self.exited then
		return
	end

	onButton(self, self._tf, arg_10_1, SFX_PANEL)

	if self.contextData.autoSkipFlag then
		triggerButton(self._tf)
	end

	return
end

function NewBattleResultGradePage:Clear()
	removeOnButton(self._tf)

	return
end

local function var_0_1(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.text or ""
	local var_12_1 = arg_12_1.icon
	local var_12_2 = arg_12_1.value or ""
	local var_12_3 = arg_12_0.transform:Find("checkBox"):GetComponent(typeof(Image))

	setActive(var_12_3.gameObject, var_12_1)

	if var_12_1 then
		var_12_3.sprite = GetSpriteFromAtlas("ui/battleresult_atlas", var_12_1)

		var_12_3:SetNativeSize()
	end

	setText(arg_12_0.transform:Find("text"), var_12_0)
	setText(arg_12_0.transform:Find("value"), var_12_2)
	setActive(arg_12_0:Find("fx"), true)

	return
end

function NewBattleResultGradePage:GetGetObjectives()
	return NewBattleResultUtil.GetObjectives(self.contextData)
end

function NewBattleResultGradePage:UpdateObjectives(arg_14_1)
	local var_14_0 = self:GetGetObjectives()

	if #var_14_0 <= 0 then
		setActive(self.objectiveTpl, false)
		arg_14_1()

		return
	end

	local var_14_1 = {
		self.objectiveTpl
	}

	for iter_14_0 = 2, #var_14_0 do
		table.insert(var_14_1, (Object.Instantiate(self.objectiveTpl, self.objectiveContainer)))
	end

	local var_14_2 = {}

	for iter_14_1 = 1, #var_14_0 do
		table.insert(var_14_2, function(arg_15_0)
			if self.exited then
				return
			end

			var_0_1(var_14_1[iter_14_1], var_14_0[iter_14_1])
			onDelayTick(arg_15_0, 0.3)

			return
		end)
	end

	seriesAsync(var_14_2, arg_14_1)
	LeanTween.value(self.objectiveContainer.gameObject, 2000, 237, 0.3):setOnUpdate(System.Action_float(function(arg_16_0)
		self.objectiveContainer.localPosition = Vector3(arg_16_0, self.objectiveContainer.localPosition.y, 0)

		return
	end))

	return
end

function NewBattleResultGradePage:UpdateChapterName()
	setText(self.gradeChapterName, (NewBattleResultUtil.GetChapterName(self.contextData)))

	return
end

function NewBattleResultGradePage:LoadEffects(arg_18_1)
	LoadAnyAsync("BattleResultItems/ResultEffect", "", nil, function(arg_19_0)
		if self.exited or IsNil(arg_19_0) then
			if arg_18_1 then
				arg_18_1()
			end

			return
		end

		local var_19_0 = Object.Instantiate(arg_19_0, self.bgTr)

		setText(var_19_0.transform:Find("Tips/dianjijixu/bg20"), i18n("battle_result_continue"))

		var_19_0.name = "ResultEffect"

		var_19_0.transform:SetSiblingIndex(1)

		if arg_18_1 then
			arg_18_1()
		end

		return
	end)

	return
end

function NewBattleResultGradePage:PlayEnterAnimation(arg_20_1)
	self.gradeTxtCG.alpha = 0

	LeanTween.value(self.gradeTxt.gameObject, 0.2, 1, 0.3):setOnUpdate(System.Action_float(function(arg_21_0)
		self.gradeTxtCG.alpha = arg_21_0

		return
	end)):setDelay(0.2)
	LeanTween.value(self.gradeTxt.gameObject, 1.3, 1, 0.15):setOnUpdate(System.Action_float(function(arg_22_0)
		self.gradeTxt.localScale = Vector3(arg_22_0, arg_22_0, 1)

		return
	end)):setDelay(0.15)

	self.gradeLabel.localPosition = self.gradeLabel.localPosition + Vector3(20, 20)

	LeanTween.moveLocal(self.gradeLabel.gameObject, self.gradeLabel.localPosition, 0.15):setDelay(0.15)

	self.gradeChapterNameCG.alpha = 0

	LeanTween.value(self.gradeChapterName.gameObject, 0.1, 0.7, 0.3):setOnUpdate(System.Action_float(function(arg_23_0)
		self.gradeChapterNameCG.alpha = arg_23_0

		return
	end)):setOnComplete(System.Action(function()
		self.gradeChapterNameCG.alpha = 1

		return
	end)):setLoopPingPong(2):setDelay(0.15)
	LeanTween.value(self.gradeIcon.gameObject, 15, 1, 0.3):setOnUpdate(System.Action_float(function(arg_25_0)
		self.gradeIcon.localScale = Vector3(arg_25_0, arg_25_0, 1)

		return
	end)):setOnComplete(System.Action(arg_20_1))

	return
end

function NewBattleResultGradePage:LoadBGAndGrade(arg_26_1)
	parallelAsync({
		function(arg_27_0)
			self:LoadBG(arg_27_0)

			return
		end,
		function(arg_28_0)
			self:LoadGrade(arg_28_0)

			return
		end
	}, arg_26_1)

	return
end

function NewBattleResultGradePage:LoadBG(arg_29_1)
	LoadAnyAsync("BattleResultItems/" .. NewBattleResultUtil.Score2Bg(self.contextData.score), "", nil, function(arg_30_0)
		if self.exited or IsNil(arg_30_0) then
			if arg_29_1 then
				arg_29_1()
			end

			return
		end

		local var_30_0 = Object.Instantiate(arg_30_0, self._parentTf)

		var_30_0.transform:SetAsFirstSibling()

		var_30_0.name = "Effect"

		if arg_29_1 then
			arg_29_1()
		end

		return
	end)

	return
end

function NewBattleResultGradePage:LoadGrade(arg_31_1)
	local var_31_0, var_31_1 = NewBattleResultUtil.Score2Grade(self.contextData.score, self.contextData._scoreMark)

	LoadImageSpriteAsync(var_31_0, self.gradeIcon, true)
	LoadImageSpriteAsync(var_31_1, self.gradeTxt, true)

	if arg_31_1 then
		arg_31_1()
	end

	return
end

function NewBattleResultGradePage:OnDestroy()
	self.exited = true

	if self:isShowing() then
		self:Hide()
	end

	if LeanTween.isTweening(self.objectiveContainer.gameObject) then
		LeanTween.cancel(self.objectiveContainer.gameObject)
	end

	if LeanTween.isTweening(self.gradeTxt.gameObject) then
		LeanTween.cancel(self.gradeTxt.gameObject)
	end

	if LeanTween.isTweening(self.gradeIcon.gameObject) then
		LeanTween.cancel(self.gradeIcon.gameObject)
	end

	if LeanTween.isTweening(self.gradeLabel.gameObject) then
		LeanTween.cancel(self.gradeLabel.gameObject)
	end

	if LeanTween.isTweening(self.gradeChapterNameCG.gameObject) then
		LeanTween.cancel(self.gradeChapterNameCG.gameObject)
	end

	return
end

return NewBattleResultGradePage
